; Includes logic for dealing with "list" text (Medals, Items, Medarots)
; Data is fixed size, so no need for a pointer table

SECTION "List Data", ROMX[$5af0], BANK[$17]
ItemList:
  INCBIN "build/lists/Items.bin"
MedalList:
  INCBIN "build/lists/Medals.bin"

SECTION "Medarot List Data", ROMX[$6c36], BANK[$17]
MedarotList:
  INCBIN "build/lists/Medarots.bin"

SECTION "Part List Data", ROMX[$65cc], BANK[$1c]
PartList:
HeadPartList:
  INCBIN "build/lists/HeadParts.bin"
RightPartList:
  INCBIN "build/lists/RightParts.bin"
LeftPartList:
  INCBIN "build/lists/LeftParts.bin"
LegPartList:
  INCBIN "build/lists/LegParts.bin"

SECTION "Load from Item List", ROM0[$328f]
LoadItemList:
  push af
  ld a, BANK(ItemList)
  ld [$2000], a
  pop af
  ld hl, ItemList - $10
  ld b, $0
  ld c, a
  sla c
  rl b
  sla c
  rl b
  sla c
  rl b
  sla c
  rl b
  add hl, bc
  ld de, cBUF01
  ld b, $9 ; Despite having 16 bytes per item, it only looks at 10
.asm_32b2
  ld a, [hli]
  ld [de], a
  inc de
  dec b
  jr nz, .asm_32b2 ; 0x32b6 $fa
  ret
; 0x32b9

SECTION "Load from Medal List", ROM0[$32b9]
LoadMedalList:
  push af
  ld a, BANK(MedalList)
  ld [$2000], a
  pop af
  ld hl, MedalList
  ld b, $0
  ld c, a
  sla c
  rl b
  sla c
  rl b
  sla c
  rl b
  add hl, bc
  ld de, cBUF01
  ld b, $7
.asm_32d8
  ld a, [hli]
  ld [de], a
  inc de
  dec b
  jr nz, .asm_32d8 ; 0x32dc $fa
  ret
; 0x32df

SECTION "Load from Medarot List", ROM0[$35dc]
LoadMedarotList:
  push hl
  push de
  ld a, BANK(MedarotList)
  ld [$2000], a
  ld hl, MedarotList
  ld b, $0
  ld a, $4
  call $3981
  ld de, cBUF01
  ld a, [hli]
  cp $50
  jr z, .asm_35fa ; 0x35f3 $5
  ld [de], a
  inc de
  jp $35f0
.asm_35fa
  ld a, $50
  ld [de], a
  pop de
  pop hl
  ret
; 0x3600


; Pointer to the start of each part list (Head, Right, Left, Leg)
SECTION "Part List Pointers", ROM0[$3562] ; Actually quite surprising it's in ROM0, since there's no need for flexibility with banks (all part lists are in 1c)
PartListPointers:
  dw HeadPartList
  dw RightPartList
  dw LeftPartList
  dw LegPartList

SECTION "Load from Part List", ROM0[$34f0]
LoadPartList:
  ld [$c64e], a
  ld a, BANK(PartList)
  ld [$2000], a
  ld a, b
  or a
  jp nz, .load_model_no
  ld hl, PartListPointers
  ld b, $0
  sla c
  rl b
  add hl, bc
  ld a, [hli]
  ld h, [hl]
  ld l, a
  ld a, [$c64e]
  ld b, $0
  ld c, a
  sla c
  rl b
  sla c
  rl b
  sla c
  rl b
  sla c
  rl b
  add hl, bc
  ld de, cBUF01
  ld b, $9
.asm_3526
  ld a, [hli]
  ld [de], a
  inc de
  dec b
  jr nz, .asm_3526 ; 0x352a $fa
  ret
.load_model_no
  ld hl, PartListPointers
  ld b, $0
  sla c
  rl b
  add hl, bc
  ld a, [hli]
  ld h, [hl]
  ld l, a
  ld a, [$c64e]
  ld b, $0
  ld c, a
  sla c
  rl b
  sla c
  rl b
  sla c
  rl b
  sla c
  rl b
  add hl, bc
  ld b, $0
  ld c, $9
  add hl, bc
  ld de, cBUF01
  ld b, $7
.asm_355b
  ld a, [hli]
  ld [de], a
  inc de
  dec b
  jr nz, .asm_355b ; 0x355f $fa
  ret
; 0x3562