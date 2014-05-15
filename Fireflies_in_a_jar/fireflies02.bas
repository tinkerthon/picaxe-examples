'Sechs LEDs im Charlieplex an drei Anschluessen
'Anschluesse: 1, 2, 4
'Die LEDs blinken nacheinander
'Olav Schettler, 2014-05-15

#PICAXE 08M

symbol led = b1
symbol wire1 = 1
symbol wire2 = 2
symbol wire3 = 4

start1:
	for led = 0 to 5
		on led gosub led1, led2, led3, led4, led5, led6
		pause 100
	next led

	goto start1

dark:
	input wire1
	input wire2
	input wire3
	pause 200
	return	

led1:
	gosub dark
	low wire1
	high wire2
	input wire3
	return

led2:
	gosub dark
	input wire1
	low wire2
	high wire3
	return

led3:
	gosub dark
	high wire1
	low wire2
	input wire3
	return

led4:
	gosub dark
	input wire1
	high wire2
	low wire3
	return

led5:
	gosub dark
	low wire1
	input wire2
	high wire3
	return

led6:
	gosub dark
	high wire1
	input wire2
	low wire3
	return
