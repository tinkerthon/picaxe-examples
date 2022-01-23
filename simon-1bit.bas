symbol counter = w0
symbol player = w1
symbol success = w2
symbol top = w3
symbol value = w4

main:
 do
  rem sertxd("Waiting\n")
  value = time
  do
   high C.0
   low C.4
   pause 400
   high C.4
   low C.0
   pause 400
   random value
  loop until pinC.3 = 1
  low C.4

  for counter = 0 to 10 step 1
   random value
   rem sertxd("Val: ", #counter)
   if value > $7FFF then
    write counter, 1
    rem sertxd("=1\n")
   else
    write counter, 0
    rem sertxd("=0\n")
   endif
  next counter

  let top = 0
  do while top < 10
   pause 1000
   sound C.2, ( 40, 50)
   rem sertxd("Round ", #top, "\n")
   for counter = 0 to top step 1
    read counter, value
    rem sertxd("Val[", #counter, "]: ", #value)
    let value = value * 900 + 300
    rem sertxd(", delay: ", #value, "\n"); 
    high C.4
    pause value
    low C.4
    pause 300
   next counter

   do
    pause 10
   loop until pinC.3 = 0
   
   let success = 1
   let player = 0
   do while player <= top
    read player, value
    rem sertxd("Check[", #player, "]: ", #value, "\n")

    let counter = 0
    rem sertxd("Waiting\n")
    do
     pause 10
    loop until pinC.3 = 1
    high C.4
    do
     let counter = counter + 1
     pause 20
    loop until pinC.3 = 0
    low C.4
    rem sertxd("Count: ", #counter, "\n")

    let player = player + 1
    if value = 0 then
     if counter > 20 then
      let success = 0
      let player = top + 1
     endif
    else
     if counter <= 20 then
      let success = 0
      let player = top + 1
     endif
    endif
   loop
   if success = 0 then
    rem sertxd("Fail\n")
    sound C.2, ( 64, 50)
    sound C.2, ( 40, 50)
    let top = 10
   else
    let top = top + 1
   endif
  loop
  if success = 1 then
   rem sertxd("Success\n")
   sound C.2, ( 40, 50)
   sound C.2, ( 64, 50)
  endif
 loop
stop

