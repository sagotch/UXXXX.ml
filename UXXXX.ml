(* More informations about conversion method used at
   http://www.ietf.org/rfc/rfc3629.txt
   (Page3, section "3. UTF-8 definition") *)

(** Convert Unicode escaped XXXX to utf-8 encoded string *)
let to_utf8 u =
  let dec = int_of_string ("0x" ^ u) in
  let update_byte s i mask shift =
    s.[i] <- Char.chr (Char.code s.[i]
		       + dec lsr shift land int_of_string mask) in
  if dec > 0xFFFF then
    failwith ("Invalid escaped unicode \\u" ^ u)
  else if dec > 0x7FF then
    let s = String.copy "\224\128\128" in
    update_byte s 2 "0b00111111" 0 ;
    update_byte s 1 "0b00111111" 6 ;
    update_byte s 0 "0b00001111" 12 ;
    s
  else if dec > 0x7F then
    let s = String.copy "\192\128" in
    update_byte s 1 "0b00111111" 0 ;
    update_byte s 0 "0b00011111" 6 ;
    s
  else
    let s = String.copy "\000" in
    update_byte s 0 "0b01111111" 0 ;
    s
