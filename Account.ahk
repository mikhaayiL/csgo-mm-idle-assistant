class Account {
	__New(login, pass, code, secret) {
		this.login := login
		this.password := pass
		this.friendCode := code
		this.secret := secret
	}

	OpenPanel() {
		MouseClick(this.uid,  20,  20, , 50)
		MouseClick(this.uid, 630, 470, , 50)
	}

	OpenFindGame() {
		this.OpenPanel()
		MouseClick(this.uid, 22, 65, 300, 500) ; play button
		MouseClick(this.uid, 80, 80, , 50)  ; competitive button
	}

	ClickFindGame(state := true) {
		SoundBeep, 500, 100
		findGameButtonColor := GetPixelColor(this.uid, 455, 458)
		SplitRGBColor(findGameButtonColor, red, green, blue)

		if (state && red < 40 || !state && red > 40)
		{
			MouseClick(this.uid, 455, 458, , 50) ; start play button
			return true
		}

		return false
	}

	SendInvite(code) {
		this.OpenPanel()

		MouseClick(this.uid, 620, 121, 300, 150) ; mail button
		MouseClick(this.uid, 493, 150, , 150) ; add button

		MouseClick(this.uid, 250, 230, , 50)  ; click to input
		SendText(this.uid, code, , 100)
		MouseClick(this.uid, 355, 231, , 300) ; submit

		inviteTitleColor := GetPixelColor(this.uid, 210, 176)
		SplitRGBColor(inviteTitleColor, red, green, blue)

		if (red > 50) {
			MouseClick(this.uid, 233, 250, , 300) ; open profile
			MouseClick(this.uid, 445, 250, , 300) ; invite
		}

		MouseClick(this.uid, 400, 295, , 100) ; close popup

		if (red < 50)
			this.SendInvite(code)
	}

	LobbyIsFull() {
		if (!this.uid)
			return false

		lobbyColor := GetPixelColor(this.uid, 638, 180)
		SplitRGBColor(lobbyColor, red, green, blue)

		if (blue < 50)
			return false

		Sleep, 100
		lobbyColor := GetPixelColor(this.uid, 638, 180)
		SplitRGBColor(lobbyColor, red, green, blue)

		return blue > 50
	}

	ToLobby() {
		this.OpenPanel()
		MouseClick(this.uid, 615, 135, 300)
	}

	LeaveFromLobby() {
		this.OpenPanel()
		MouseClick(this.uid, 620, 13, 300, 50)
		MouseClick(this.uid, 620, 43, , 50)
	}

	HasAccept() {
		if (!this.uid)
			return false

		acceptColor := GetPixelColor(this.uid, 278, 263)
		SplitRGBColor(acceptColor, red, green, blue)

		return red < 100 && blue < 100 && green > 150
	}

	ClickAccept() {
		MouseClick(this.uid, 278, 263)
	}

	InsertSetup(setups) {
		Loop, % setups.Length()
		{
			row := setups[A_Index]
			SendText(this.uid, row)
			SendKey(this.uid, "{Enter}", , 50)
		}

		SendText(this.uid, "bind ""F4"" ""disconnect""")
		SendKey(this.uid, "{Enter}", , 50)

		SendText(this.uid, "bind ""F8"" ""quit""")
		SendKey(this.uid, "{Enter}", , 50)

		SendKey(this.uid, "{Esc}")
		SendKey(this.uid, "{Esc}", 100, 50)
	}

	Reconnect() {
		MouseClick(this.uid, 435, 270)
		MouseClick(this.uid, 450, 37)
	}

	Disconnect() {
		SendKey(this.uid, "{F4}")
	}

	CloseGame() {
		SendKey(this.uid, "{F8}")

		SendKey(this.uid, "{``}", , 50)
		SendKey(this.uid, "{F8}")

		SendKey(this.uid, "{ё}", , 50)
		SendKey(this.uid, "{F8}")
	}

	Activate(beep := true) {
		if (!this.uid) {
			if (beep)
				FailureBeep()

			return false
		}

		uid := this.uid
		WinActivate, ahk_id %uid%

		return true
	}
}