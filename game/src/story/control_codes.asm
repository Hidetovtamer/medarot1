SECTION "Old Dialog Control Codes", ROM0[$1e5e]
Free:
.marker
REPT $1f4f - .marker
  nop
ENDR

; Current control codes are in game/src/patch/vwf.asm