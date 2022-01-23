symbol hungry = w0
symbol light = w1
symbol mood = w2
symbol sad = w3
symbol sleepy = w4
symbol timer = w5
symbol song = w6
symbol age = w7
symbol velo = w8

main:
        mood = time
	do
  	 let hungry = 0
  	 let sleepy = 0
  	 let timer = 100
	 let age = 0
	 let velo = 1
	 random mood
  	 do while timer > 0
    	  random mood
    	  if mood < 2000 then
	   if hungry = 0 then
            let hungry = 1
      	    high C.0
      	    sound C.2, ( 64, 20)
	   endif
    	  elseif mood >= 2000 AND mood < 4000 then
	   if sleepy = 0 then
      	    let sleepy = 1
      	    high C.4
      	    sound C.2, ( 60, 20)
	   endif
    	  endif
    	  let sad = hungry or sleepy
    	  if sad <> 0 then
      	   let timer = timer - velo
    	  endif
    	  if pinC.3 = 1 then
      	   if hungry = 1 then
            low C.0
            let hungry = 0
            let timer = 100
	   else
            let timer = timer - velo
      	   endif
    	  endif
    	  readadc C.1, light
    	  if light < 8 then
      	   if sleepy = 1 then
            low C.4
            let sleepy = 0
            let timer = 100
	   else
	    let timer = timer - velo
      	   endif
    	  endif
	  if timer < 10 then
	   sound C.2, (42, 20)
	  endif
          let age = age + 1
	  if age > 30 then
	   let velo = 4
	  elseif age > 20 then
	   let velo = 2
	  else
	   let velo = 1
	  endif
          rem debug
	  pause 50
         loop
  	 sound C.2, ( 48, 20, 42, 50, 36, 50, 30, 100)
  	 do
    	  high C.0
	  high C.4
    	  pause 200
    	  low C.0
    	  low C.4
    	  pause 200
  	 loop until pinC.3 = 1
    	 readadc C.1, light
    	 if light < 8 then
	  random mood
	  let song = mood & %11
	  if song = 0 then
	   play 0, 3
	  elseif song = 1 then
	   play 1, 3
	  elseif song = 2 then
	   play 2, 3
	  else
	   play 3, 3
	  endif
	 endif
	loop
	stop
