'Sechs LEDs im Charlieplex an drei Anschluessen
'Anschluesse: 1, 2, 4
'Hardware: http://tinkerthon.de/2011/03/gluhwurmchen-im-marmeladenglas/
'Die LEDs werden nacheinander sanft ein- und ausgeblendet
'Das Ausblenden erfolgt verzoegert
'Olav Schettler <olav@tinkerthon,de>, 2014-05-15

#PICAXE 08M
sertxd ("fireflies03:ce37b8e")

symbol led = b0
symbol wire1 = 1
symbol wire2 = 2
symbol wire3 = 4

'Derjenige Anschluss, der fuer langsames Ein-/Ausblenden benutzt wird
symbol pwd = b1

'Aktueller Helligkeitswert
symbol duty = b2

'Anzahl Stufen
symbol duty_period = 10

'Zwischenspeicher fuer Anzahl Stufen "an"
symbol high_time = b3

'Aktuelle Wiederholung fuer das verzoegerte Ausblenden 
symbol duration = b4

'Anzahl Wiederholungen
symbol duration_period = 5


start1:
	'Nacheinander alle sechs LEDs
	for led = 0 to 5
		on led gosub led1, led2, led3, led4, led5, led6
		
		'zunaechst dunkel nach hell
		for duty = duty_period to 1 step -1
			gosub cycle
		next duty
	
		'anschliessend hell nach dunkel
		for duty = 1 to duty_period
			'Zur Verzoegerung "duration_period" mal wiederholen
			for duration = 1 to duration_period
				gosub cycle
			next duration
		next duty
	
	next led

	'Das ganze von vorn
	goto start1

cycle:
	'Unterprogramm: Pin mit Nummer "pwd" 
	'fuer "duty" Millisekunden aus
	'und fuer "duty_period - duty" Millisekunden an  
	low pwd
	pause duty
	high pwd
	high_time = duty_period - duty
	pause high_time
	return

dark:
	'Unterprogramm: Alle LEDs aus
	input wire1
	input wire2
	input wire3
	pause 500
	return	

led1:
	'Unterprogramm: LED 1 an
	gosub dark
	low wire1
	pwd = wire2
	input wire3
	return

led2:
	'Unterprogramm: LED 2 an
	gosub dark
	input wire1
	low wire2
	pwd = wire3
	return

led3:
	'Unterprogramm: LED 3 an
	gosub dark
	pwd = wire1
	low wire2
	input wire3
	return

led4:
	'Unterprogramm: LED 4 an
	gosub dark
	input wire1
	pwd = wire2
	low wire3
	return

led5:
	'Unterprogramm: LED 5 an
	gosub dark
	low wire1
	input wire2
	pwd = wire3
	return

led6:
	'Unterprogramm: LED 6 an
	gosub dark
	pwd = wire1
	input wire2
	low wire3
	return
