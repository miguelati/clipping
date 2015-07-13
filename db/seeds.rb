# encoding: UTF-8

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

def set_title(title)
	puts " #{title} ".center(70, "=")
end

def set_item(item)
	puts " ------> #{item}"
end

set_title("Entidades")
set_item("Entidad 'Pepsico'")
ent = Entity.create(name: "Pepsico")
set_item("Entidad 'Arcor'")
ent2 = Entity.create(name: "Arcor")

set_title("Usuarios")
set_item("Creando 'Miguel Godoy'")
user = User.create(:email => 'miguelgodoyg@gmail.com', :password => 'abc12345@', :name => 'Miguel Godoy', :is_admin => true)
user.entities << ent
user.entities << ent2
user.save

set_title("Fuentes")
set_item("Creando el diario 'ABC Color'")
Source.create(name: "ABC Color", url: "abc.com.py", title_reg: "div#article h1", short_content_reg: "p.summary")
set_item("Creando el diario 'Ultima Hora'")
Source.create(name: "Ultima Hora", url: "ultimahora.com", title_reg: "h1#nota_titulo", short_content_reg: "h2#nota_copete")
set_item("Creando el diario 'Ultima Hora'")
Source.create(name: "La Nación", url: "lanacion.com.py", title_reg: "div#imprimir h1.title_article", short_content_reg: "div#imprimir div.copete_article")
set_item("Creando el diario 'Hoy'")
Source.create(name: "Hoy", url: "hoy.com.py", title_reg: "div.main_content h1")
set_item("Creando el diario '5 días'")
Source.create(name: "5 Días", url: "5dias.com.py", title_reg: "div.noticia h3")
set_item("Creando el diario 'Crónica'")
Source.create(name: "Crónica", url: "cronica.com.py", title_reg: "div#impresion div#titulo-nota", short_content_reg: "div#impresion div.copeteART strong")

set_title("Categorias")
set_item("Creando 'COMPETENCIA'")
Category.create(name: "COMPETENCIA", is_important: true, entity_id: ent.id)
set_item("Creando 'Política'")
Category.create(name: "Política", is_important: false, entity_id: ent.id)
set_item("Creando 'Economía y Negocios'")
Category.create(name: "Economía y Negocios", is_important: false, entity_id: ent.id)
set_item("Creando 'Editoriales'")
Category.create(name: "Editoriales", is_important: false, entity_id: ent.id)
set_item("Creando 'Salud y Bienestar'")
Category.create(name: "Salud y Bienestar", is_important: false, entity_id: ent.id)
set_item("Creando 'Columnistas'")
Category.create(name: "Columnistas", is_important: false, entity_id: ent.id)
