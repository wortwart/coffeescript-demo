Bildergalerie
=============

Demo-Projekt für CoffeeScript
-----------------------------

*siehe [c't](http://ct.de/) 7/2014*

Erst mal ein paar Variablen zu Pfaden und Dateinamen:

	bilderDir = 'pixel/'
	bilderEndung = '.jpg'
	urlPrefix = 'http://www.heise.de/artikel-archiv/ct/'

### Bilddatenbank

Die Bilddatenbank in einer Art JSON-Format:

	bilder = [
			id: 201319172
			name: 'Telefonbau'
		,
			id: 201320132
			name: 'Browser-Feuerwerk'
		,
			id: 201321108
			name: 'Soziales privatisieren'
		,
			id: 201326182
			name: 'HTML maßgeschneidert'
		,
			id: 201326186
			name: 'Rock\'n\'Scroll'
	]

### Klasse "Bild"

Die Klasse `Bild` bereitet die Informationen aus der Datenbank für die Ausgabe auf und gibt ein Objekt zurück, das nur noch in die HTML-Ausgabe eingesetzt werden muss:

	class Bild

Ein mehrzeiliger regulärer Ausdruck, der Jahr, Ausgabe und Seite aus der ID extrahiert:

		regex: ///
			(^\d{4})	# Jahr
			(\d{2})		# Ausgabe
			0*		# eventuell führende Null der Seitenzahl
			(\d{1,3}$)	# Seite
		///

Erhöht die laufende Nummer des aktuellen Bildes:

		counterAdd: ->
			Bild.counter++

Die automatisch aufgerufene `constructor`-Funktion nimmt ein Objekt mit Name und ID des Bildes entgegen und ermittelt die laufende Nummer, die Bild-URL, die Quellenangabe und die URL der Quelle.

		constructor: (params) ->
			{@name, @id} = params
			@nummer = @counterAdd
			@bild = "#{bilderDir}#{@id}#{bilderEndung}"
			treffer = "#{@id}".match @regex
			treffer = ('unbekannt' for [0..3]) unless treffer?
			@ausgabe = "c't #{treffer[2]}/#{treffer[1]}, Seite #{treffer[3]}"
			@url = urlPrefix + treffer[1..3].join '/'

### Ausgabefunktion und Bildobjekte

Das Array mit den erzeugten Bildobjekten und die `galerie`-Funktion stecken im `window`-Objekt, damit sie auch außerhalb des kompilierten Codeblocks zugänglich sind.

	window.cs =

Das noch leere Bilder-Array:

		bilder: []

Die `galerie`-Funktion löst nach dem Laden und nach dem Klick auf die Vor- und Zurück-Pfeile aus. Per Default lädt sie das erste Bild des Arrays `window.cs.bilder`.

		galerie: (bildnr = 0) ->
			container = document.getElementById 'galerie'

Ermittelt die Nummern der Bilder, die nach Klick auf die Pfeile zu laden sind:

			prev = if bildnr < 1 then @bilder.length - 1 else bildnr - 1
			next = if bildnr + 1 >= @bilder.length then 0 else bildnr + 1

Der HTML-Block für die Ausgabe:

			container.innerHTML = """
			<figcaption>
				<h3>Bild #{bildnr + 1} von #{@bilder.length}:</h3>
				<h2>#{@bilder[bildnr].name}</h2>
				<small>erschienen in: <a href='#{@bilder[bildnr].url}'>#{@bilder[bildnr].ausgabe}</a></small>
			</figcaption>
			<div>
				<span onclick='window.cs.galerie(#{prev})' title='Bild #{prev + 1}'>Zurück</span>
				<img src='#{@bilder[bildnr].bild}' alt=\"#{@bilder[bildnr].name}\"/>
				<span onclick='window.cs.galerie(#{next})' title='Bild #{next + 1}'>Weiter</span>
			</div>
			"""

### Start der Galerie

Wandelt die einzelnen Datenbankeinträge aus `bilder` mit Hilfe der Klasse `Bild` in Bildobjekte um:

	for bild in bilder
		window.cs.bilder.push(new Bild name: bild.name, id: bild.id)

Startet die Ausgabe:

	window.cs?.galerie 0