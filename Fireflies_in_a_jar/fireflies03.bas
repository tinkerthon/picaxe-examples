'Sechs LEDs im Charlieplex an drei Anschluessen
'Anschluesse: 1, 2, 4
'Die LEDs werden nacheinander sanft ein- und ausgeblendet
'Olav Schettler, 2014-05-15

#PICAXE 08M

symbol led = b0
symbol wire1 = 1
symbol wire2 = 2
symbol wire3 = 4

'Derjenige Anschluss, der fuer langsames Ein-/Ausblenden benutzt wird
symbol pwd = b1

'Aktueller Helligkeitswert
symbol duty = b2
symbol period = 10
symbol high_time = b3

start1:
	for led = 0 to 5
		on led gosub led1, led2, led3, led4, led5, led6
		
		for duty = period to 1 step -1
			gosub cycle
		next duty
	
		for duty = 1 to period
			gosub cycle
		next duty
	
	next led

	goto start1

cycle:
	low pwd
	pause duty
	high pwd
	high_time = period - duty
	pause high_time
	return

dark:
	input wire1
	input wire2
	input wire3
	return	

led1:
	gosub dark
	low wire1
	pwd = wire2
	input wire3
	return

led2:
	gosub dark
	input wire1
	low wire2
	pwd = wire3
	return

led3:
	gosub dark
	pwd = wire1
	low wire2
	input wire3
	return

led4:
	gosub dark
	input wire1
	pwd = wire2
	low wire3
	return

led5:
	gosub dark
	low wire1
	input wire2
	pwd = wire3
	return

led6:
	gosub dark
	pwd = wire1
	input wire2
	low wire3
	return
