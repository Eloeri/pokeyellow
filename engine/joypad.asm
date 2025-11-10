_Joypad::
; hJoyReleased: (hJoyLast ^ hJoyInput) & hJoyLast
; hJoyPressed:  (hJoyLast ^ hJoyInput) & hJoyInput

	ldh a, [hJoyInput]
	cp PAD_BUTTONS ; soft reset
	jp z, TrySoftReset

	; --- Turbo A/B ---
	ld b, a
	ld a, [wFontLoaded]
	bit 1, a
	jr z, .noTurbo

	ld a, [rDIV]
	bit 4, a
	jr z, .noTurbo

	ld a, b
	bit B_PAD_A, a
	jr z, .checkBTurbo
	xor PAD_A
.checkBTurbo:
	bit B_PAD_B, a
	jr z, .doneTurbo
	xor PAD_B
	jr .doneTurbo
.noTurbo:
	ld a, b
.doneTurbo:

	ld b, a
	ldh a, [hJoyLast]
	ld e, a
	xor b
	ld d, a
	and e
	ldh [hJoyReleased], a
	ld a, d
	and b
	ldh [hJoyPressed], a
	ld a, b
	ldh [hJoyLast], a

	ld a, [wStatusFlags5]
	bit BIT_DISABLE_JOYPAD, a
	jr nz, DiscardButtonPresses

	ldh a, [hJoyLast]
	ldh [hJoyHeld], a

	ld a, [wJoyIgnore]
	and a
	ret z

	cpl
	ld b, a
	ldh a, [hJoyHeld]
	and b
	ldh [hJoyHeld], a
	ldh a, [hJoyPressed]
	and b
	ldh [hJoyPressed], a
	ret

DiscardButtonPresses:
	xor a
	ldh [hJoyHeld], a
	ldh [hJoyPressed], a
	ldh [hJoyReleased], a
	ret

TrySoftReset:
	call DelayFrame

	; deselect (redundant)
	ld a, $30
	ldh [rJOYP], a

	ld hl, hSoftReset
	dec [hl]
	jp z, SoftReset

	jp Joypad
