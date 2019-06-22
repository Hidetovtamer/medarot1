SECTION "Setup Initial Name Screen", ROMX[$4a9f], BANK[$1]
SetupInitialNameScreen: ;4a9f
  xor a
  ld hl, $c5c9
  ld [hli], a
  ld [hli], a
  ld [hli], a
  ld [hli], a
  ld [hli], a
  ld [hli], a
  ld hl, cNAME
  ld [hli], a
  ld [hli], a
  ld [hli], a
  ld [hli], a
  ld [hli], a
  ld [hli], a
  ld [hli], a
  ld [hli], a
  ld [hli], a
  ld [$c6c6], a
  ld hl, cBUF01
  ld a, $9a ; ひ  
  ld [hli], a
  ld a, $85 ; か
  ld [hli], a
  ld a, $a8 ; る
  ld [hli], a
  ld a, $50 ; EOL
  ld [hli], a
  xor a
  ld [hli], a
  ld [hli], a
  ld [hli], a
  ld [hli], a
  ld [hli], a
  ld a, $3 ; Name length
  ld [$c5ce], a
  ld a, $2
  call $015f
  ld a, $3
  call $015f
  ld b, $0
  ld c, $0
  ld e, $2
  call $015c
  ld b, $2
  ld c, $6
  ld e, $2b
  call $015c
  ld b, $1
  ld c, $1
  ld e, $29
  call $015c
  ld hl, cBUF01
  ld bc, $984a
  call $0264
  call $5213
  ld a, $1
  ld [$ffa0], a
  ld a, $4
  call $017d
  ld b, $5
  ld c, $5
  ld d, $5
  ld e, $5
  ld a, $2
  call $0309
  jp $0168

;TODO: Properly disassemble this routine which draws the OAM for the setup screen
SECTION "Setup Initial Name Screen OAM", ROMX[$4b2e], BANK[$1]
  ld a, $70 ; Initial tilemap position for spinning coin marker

SECTION "Copy from buffer to &NAME", ROMX[$4f1d], BANK[$1]
  ld hl, cBUF01
  ld de, cNAME
  ld b, $9
.asm_4f25
  ld a, [hli]
  ld [de], a
  inc de
  dec b
  jr nz, .asm_4f25 ; 0x4f29 $fa
  ret
; 0x4f2c