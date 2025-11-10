ReadJoypad::
; Poll joypad input.
; Unlike the hardware register, button
; presses are indicated by a set bit.
	ldh a, [hDisableJoypadPolling]
	and a
	ret nz

	ld a, 1 << 5 ; select direction keys

	ldh [rJOYP], a
	ldh a, [rJOYP]
	ldh a, [rJOYP]
	cpl
	and %1111
	swap a
	ld b, a

	ld a, 1 << 4 ; select button keys
	ldh [rJOYP], a
REPT 6
	ldh a, [rJOYP]
ENDR
	cpl
	and %1111
	or b

	ldh [hJoyInput], a

	ld a, 1 << 4 + 1 << 5 ; deselect keys
	ldh [rJOYP], a
	ret

Joypad::
	homecall _Joypad
	ld a, [hSelectHoldTimer]
	cp 15  ; Used by the hSelectHoldTimer for bike shortcut
	ret nc
	ld a, [hJoyReleased]
	bit B_PAD_SELECT, a
	ret z
	ld hl, wFontLoaded
	bit 1, [hl]
	jr z, .setTurbo
	res 1, [hl]
	ret
.setTurbo
	set 1, [hl]
	ret