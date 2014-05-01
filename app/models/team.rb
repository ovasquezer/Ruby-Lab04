class Team < ActiveRecord::Base
	has_one :participations
	has_one :groups, :through => :participations
	has_many :matches

	validates :name, presence: true, uniqueness: true, uniqueness: {case_sensitive: false}, format: {with: /\A[A-Za-z ]+\z/, message: "ERROR: Only letters and spaces allowed in Team Name"}
	validates :coach, presence: true, uniqueness: true, uniqueness: {case_sensitive: false}
	validates :flag, presence: true, format: {with: /http(s)?:\/\/[A-Za-z0-9+&@#%?=~_|\.|\-|\/]+/i, message: "ERROR: Invalid Flag URL"}
	validates :uniform, presence: true, format: {with: /http(s)?:\/\/[A-Za-z0-9+&@#%?=~_|\.|\-|\/]+/i, message: "ERROR: Invalid Uniform URL"}
	validates_length_of :info, minimum: 15, maximum: 200

end

=begin
Asociaciones:
YA--->Un equipo pertenece a un grupo.
YA--->Un equipo tiene varios partidos por jugar.

Validaciones:
YA--->Todo equipo debe tener un nombre, el cual sólo puede estar formado por letras (mayúsculas o minúsculas).
YA--->Todo equipo debe tener un nombre de entrenador.
YA--->Todo equipo debe tener un url a una foto de su bandera, el cual debe ser un url con formato válido.
YA--->Todo equipo debe tener un url a una foto de su uniforme, el cual debe ser un url con formato válido.
YA--->Todo equipo debe tener un texto que lo describa, un mínimo de 15 caracteres, y un máximo de 200.
YA--->No deben haber equipos con el mismo nombre.
YA--->Un entrenador no puede entrenar a más de un equipo.
=end