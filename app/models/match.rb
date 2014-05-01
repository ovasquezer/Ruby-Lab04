class Match < ActiveRecord::Base
  belongs_to :local_team, :class_name => Team
  belongs_to :visit_team, :class_name => Team
  belongs_to :winner_team, :class_name => Team
  belongs_to :looser_team, :class_name => Team
  belongs_to :group, :class_name => Group
  belongs_to :stadium, :class_name => Stadium


  validates :date, presence: true #Atributo tipo Date revisa que sea una fecha valida
  validates :phase, presence: true, format: {with: /\A(Grupos|Octavos de final|Cuartos de final|Semifinales|Final)\z/i, message: "ERROR: Match Phase must be: Grupos, Octavos de Final, Cuartos de final, Semifinales, Final"}
  validates :state, presence: true, format: {with: /\A(Por jugar|En juego|Finalizado)\z/i, message: "ERROR: Match State must be: Por jugar, En juego, Finalizado"}
  validates :local_team, presence: true
  validates :visit_team, presence: true
  validates :local_goals, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :visit_goals, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0}
  validates :stadium, presence: true

  validate :local_and_visit_team_are_different
  validate :winner_looser_draw
  validate :match_in_the_same_date_at_the_same_stadium
  validate :team_play_two_or_more_games_in_the_same_date
  
  def local_and_visit_team_are_different
    if local_team == visit_team
      errors.add(:visit_team, "ERROR: Local and visit team must be different")
    end
  end

  def winner_looser_draw
  	if local_goals == visit_goals && (!draw? || winner_team != nil || looser_team != nil)
  		errors.add(:winner_team, "ERROR: Local team and visit team scored the same quantity of goals, they must draw, winner and looser team must be nil")
  	elsif local_goals > visit_goals && (draw? || winner_team != local_team || looser_team != visit_team)
  		errors.add(:winner_team, "ERROR: Local team scored more goals than visit team, local team must win and visit team must loose, no draw allowed")
  	elsif local_goals < visit_goals && (draw? || winner_team != visit_team || looser_team != local_team)
      errors.add(:winner_team, "ERROR: Visit team scored more goals than local team, visit team must win and local team must loose, no draw allowed")
  	end
  end

  def match_in_the_same_date_at_the_same_stadium
    matches_array_temp = []
    matches_array_temp = Match.where('id != ? AND date BETWEEN ? AND ? AND stadium_id = ?', id, date.beginning_of_day, date.end_of_day, stadium)
    if matches_array_temp.size > 0
      errors.add(:stadium, "ERROR: Choosen Stadium will have an other match in the selected date")
    end
  end

  def team_play_two_or_more_games_in_the_same_date
    matches_array_temp = []
    matches_array_temp = Match.where('local_team_id = ? AND date BETWEEN ? AND ?', local_team, date.beginning_of_day, date.end_of_day)
    #if matches_array_temp.size > 0
      errors.add(:local_team, "ERROR: Local team will play another match in the choose date")
    #end

    matches_array_temp = []
    matches_array_temp = Match.where('visit_team_id = ? AND date BETWEEN ? AND ?', visit_team, date.beginning_of_day, date.end_of_day)
    #if matches_array_temp.size > 0
      errors.add(:visit_team, "ERROR: Visit team will play another match in the choosen date")
    #end
  end

end

=begin
Asociaciones:
YA--->Un partido pertenece a un equipo local.
YA--->Un partido pertenece a un equipo visitante.
YA--->Un partido pertenece a un estadio.
YA--->Un partido pertenece a un ganador.
YA--->Un partido pertenece a un perdedor.
YA--->Un partido pertenece a un grupo.

Validaciones:
YA--->Todo partido debe tener una fecha de juego, la cual debe ser válida.
YA--->Todo partido debe ser jugado en alguna fase.
	Grupos
	Octavos de final
	Cuartos de final
	Semifinales
	Final
YA--->Todo partido debe encontrarse en un estado.
	Por jugar
	En juego
	Finalizado
YA--->Todo partido debe tener un equipo local.
YA--->Todo partido debe tener un equipo visitante.
YA--->Todo partido debe tener un marcador, el cual incluye una cantidad entera no negativa de goles locales, y una cantidad entera no negativa de goles visitantes.
YA--->Todo partido terminado debe tener un ganador (a menos que haya sido empate).
YA--->Todo partido terminado debe tener un perdedor (a menos que haya sido empate).
YA--->Todo partido que tenga la misma cantidad de goles locales y visitantes debe ser un empate.
YA--->Todo partido debe tener un estadio.
YA--->No se debe permitir más de un partido en la misma fecha en el mismo estadio.
YA--->El equipo local debe ser distinto al equipo visitante.
YA--->Un mismo equipo no puede jugar dos partidos en la misma fecha.
=end
