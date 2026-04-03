import QtQuick 2.15
import QtQuick.Controls 2.15
import Sddm 1.0

Item {
	id: root
	width: 1920
	height: 1080

	property var userModel: sddm.userModel
	property var sessionModel: sddm.sessionModel

	Rectangle {
		anchors.fill: parent
		color: "#091833"
	}
	
	// Background Image
	Image {
		anchors.fill: parent
		source: "/home/cleaver/wallhaven-w87zrq_1366x768.png"
		fillMode: Image.PreserveAspectCrop
	}

	// Subtle Zoom Animation
	scale: 1.0
	SequentialAnimation on scale {
		loops: Animation.Infinite
		NumberAnimation { from: 1.0; to: 1.05; duration: 10000 }
		NumberAnimation { from: 1.05; to: 1.0; duration: 10000 }
	}

	// Gradient Overlay
	Rectangle {
		anchors.fill: parent
		gradient: Gradient {
			GradientStop { position: 0.0; color: "#091833DD" }
			GradientStop { position: 1.0; color: "#000000AA" }
		}
	}

	// Cyberpunk Scanlines
	Canvas {
		id: scanlines
		anchors.fill: parent

		property int offset: 0

		Timer {
			interval: 50
			running: true
			repeat: true
			onTriggered: {
				scanlines.offset += 1
				scanlines.requestPaint()
			}
		}

		onPaint: {
			var ctx = getContext("2d")
			ctx.clearRect(0, 0, width, height)

			ctx.strokeStyle = "rgba(0,255,255,0.04)"

			for (var y = 0; y < height; y += 4) {
				ctx.beginPath()
				ctx.moveTo(0, y)
				ctx.lineTo(width, y)
				ctx.stroke()
			}
		}
	}

	Rectangle {
		anchors.fill: parent
		color: "#000000"
		opacity: 0.25
	}

	// Login Panel
	Rectangle {
		id: panel
		width: 420
		height: 360
		anchors.centerIn: parent
		
		// Base Panel
		color: "#0a1020CC"
		radius: 14

		// Frosted Light Diffusion
		Rectangle {
			anchors.fill: parent
			radius: 14
			color: "#ffffff06"  // very subtle light diffusion
		}

		// Inner Shadow For Contrast
		Rectangle {
			anchors.fill: parent
			radius: 14
			color: "#00000040"
		}

		border.width: 2
		border.color: "#ea00d9"

		property bool capsOn: false

		Keys.onPressed: {
			capsOn = (event.modifiers & Qt.CapsLockModifier)
			capsWarning.visible = capsOn
		}

		function glitch() {
			panel.rotation = 2
			panel.x += 10

			panel.rotation = -2
			panel.x -= 20

			panel.rotation = 1
			panel.x += 10

			panel.rotation = 0
		}

		Connections {
			target: sddm

			function onLoginFailed() {
				statusText.text = "WELCOME"
			}
		}

		Text {
			id: statusText
			anchors.horizontalCenter: parent.horizontalCenter
			y: panel.height - 40

			text: ""
			color: "#00ff9c"
			font.pixelSize: 14
		}

		// Neon Glow Layer (Qt6 Safe)
		Rectangle {
			id: glow
			anchors.fill: parent
			radius: 14
			color: "transparent"
			border.color: "#ea00d9"
			border.width: 3
			
			opacity: 0.2

			SequentialAnimation on opacity {
				loops: Animation.Infinite

				NumberAnimation { from: 0.2; to: 0.6; duration: 1500 }
				NumberAnimation { from: 0.6; to: 0.2; duration: 1500 }
			}
		}

		// Entry Animation
		opacity: 0
		scale: 0.9
			
		Behavior on opacity {
			NumberAnimation { duration: 500 }
		}

		Behavior on scale {
			NumberAnimation { duration: 400; easing.type: Easing.OutBack }
		}

		Component.onCompleted: {
			panel.opacity = 1
			panel.scale = 1
		}

		// Breathing Effect
		SequentialAnimation on scale {
			loops: Animation.Infinite

			NumberAnimation {
				from: 0.97
				to: 1.03
				duration: 2500
				easing.type: Easing.InOutSine
			}
			
			NumberAnimation {
				from: 1.03
				to: 0.97
				duration: 2500
				easing.type: Easing.InOutSine
			}
		}

		Column {
			anchors.centerIn: parent
			spacing: 16

			// Hostname
			Text {
				text: "cleaver@nixos"
				color: "#00ff9c"
				font.pixelSize: 12
				opacity: 0.7
				horizontalAlignment: Text.AlignHCenter
			}
			
			// Clock
			Text {
				id: clock
				color: "#ea00d9"
				font.pixelSize: 18

				text: Qt.formatTime(new Date(), "hh:mm AP")

				Timer {
					interval: 1000
					running: true
					repeat: true
					onTriggered: clock.text = Qt.formatTime(new Date(), "hh:mm AP")
				}
			}

			// Title
			Text {
				text: "WELCOME"
				color: "#00fff7"
				font.pixelSize: 26
				font.bold: true
				horizontalAlignment: Text.AlignHCenter
			}

			// Username
			TextField {
				id: user
				text: userModel.lastUser || ""
				width: 260

				color: "#00fff7"  // Cyan Text
				selectionColor: "#ea00d9"
				
				background: Rectangle {
					color: "#091833"
					border.color: "#00fff7"
					border.width: 1
					radius: 6
				}
			}

			// Password
			TextField {
				id: password
				placeholderText: "Password"
				placeholderTextColor: "#ea00d9"
				echoMode: TextInput.Password
				width: 260

				color: "#00ff9c"  // Neon Green (Contrast)
				selectionColor: "#ea00d9"

				font.family: "monospace"
				
				background: Rectangle {
					color: "#091833"
					border.color: "#ea00d9"
					border.width: 1
					radius: 6
				}

				onTextChanged: {
					//Subtle Flicker Effect
					opacity = 0.8
					opacity = 1.0
				}
			}

			// Session Selector
			ComboBox {
				id: sessionBox
				width: 260
				model: sessionModel
				textRole: "name"

				background: Rectangle {
					color: "#091833"
					border.color: "#ea00d9"
					border.width: 1
					radius: 6
				}

				contentItem: Text {
					text: sessionBox.displayText
					color: "#00fff7"
					verticalAlignment: Text.AlignVCenter
					leftPadding: 10
				}
			}

			// Caps Lock
			Text {
				id: capsWarning
				text: "CAPS LOCK IS ON"
				color: "#ff0055"
				font.pixelSize: 12
				visible: false

				opacity: 0

				SequentialAnimation on opacity {
					running: capsWarning.visible
					loops: Animation.Infinite

					NumberAnimation { from: 0.3; to: 1.0; duration: 600 }
					NumberAnimation { from: 1.0; to: 0.3; duration: 600 }
				}
			}

			//Login Button
			Rectangle {
				width: 150
				height: 40
				radius: 6

				property color btnColor: "#ea00d9"
				color: btnColor

				scale: 1.0

				Behavior on scale {
					NumberAnimation { duration: 100 }
				}

				Behavior on btnColor {
					ColorAnimation { duration: 200 }
				}

				Text {
					anchors.centerIn: parent
					text: "LOGIN"
					color: "#091833"
					font.bold: true
				}
				
				MouseArea {
					anchors.fill: parent
					hoverEnabled: true

					onEntered: parent.btnColor = "#ff2bd6"
					onExited: parent.btnColor = "#ea00d9"
					
					onPressed: parent.scale = 0.95
					onReleased: parent.scale = 1.0



					onClicked: {
						statusText.text = "ACCESSING..."
						sddm.login(user.text, password.text, sessionBox.currentIndex)
					}					
				}
			}
		}
	}
}
