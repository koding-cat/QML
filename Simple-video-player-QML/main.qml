import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.15
import QtMultimedia 5.15
import QtQuick.Dialogs 1.2


Window {
    id: window
    width: 640
    height: 480
    visible: true
    title: qsTr("My Video Player")

    property string videoPath: ""

    FileDialog {
        id: openDialog
        title: "Please choose a file"
        folder: shortcuts.home //set initial directory when file open
        selectMultiple: false
        selectExisting: true

        onAccepted: {
            videoPath = openDialog.fileUrl
            playButtonIcon()
        }
    }

    function playButtonIcon(){
        if(video.playbackState == MediaPlayer.PlayingState){
            video.pause()
            imPlaypause.source = "qrc:/images/images/playButton.png"
        } else {
            video.play()
            imPlaypause.source = "qrc:/images/images/pauseButton.png"
        }
    }


    Column {
        id: column
        width: parent.width
        height: parent.height
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 20



        Video {
            id: video
            height : parent.height - 100
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.top: parent.top
            anchors.topMargin: 5
            source: videoPath
            anchors.rightMargin: 5
            anchors.leftMargin: 5

            MouseArea {
                width: parent.width
                anchors.fill: parent
                onClicked: {
                    if(videoPath == ""){
                        openDialog.open()
                    } else {
                       playButtonIcon()
                    }
                }
            }

            focus: true
            Keys.onSpacePressed: playButtonIcon()
            Keys.onLeftPressed: video.seek(video.position - 5000) //seek backward the video 5 seconds
            Keys.onRightPressed: video.seek(video.position + 5000) //seek forward the video 5 seconds

        }

        Row {
            id: row
            width: parent.width
            height: 75
            anchors.bottom: parent.bottom
            anchors.bottomMargin: 5
            spacing: 10


            Image {
                id: imPlaypause
                width: 50
                height: 50
                anchors.horizontalCenter: parent.horizontalCenter
                source: "qrc:/images/images/playButton.png"
                fillMode: Image.PreserveAspectFit

                MouseArea {
                    id: mouseAreaPlay
                    anchors.fill: parent

                    onClicked: {
                        playButtonIcon()
                    }
                }
            }

            Image {
                id: imFoward
                width: 50
                height: 50
                anchors.left: imPlaypause.right
                anchors.leftMargin: 40
                source: "qrc:/images/images/fowardButton.png"
                fillMode: Image.PreserveAspectFit

                MouseArea {
                    id: mouseAreaFoward
                    anchors.fill: parent

                    onClicked: {
                        video.seek(video.position + 5000)
                    }
                }
            }

            Image {
                id: imBackward
                width: 50
                height: 50
                anchors.right: imPlaypause.left
                anchors.rightMargin: 40
                source: "qrc:/images/images/backwardButton.png"
                fillMode: Image.PreserveAspectFit

                MouseArea {
                    id: mouseAreaBackward
                    anchors.fill: parent

                    onClicked: {
                        video.seek(video.position - 5000)
                    }
                }
            }

            Image {
                id: imOpen
                width: 50
                height: 50
                anchors.verticalCenter: parent.verticalCenter
                anchors.left: parent.left
                source: "qrc:/images/images/openButton.png"
                anchors.leftMargin: 25
                fillMode: Image.PreserveAspectFit

                MouseArea {
                    id: mouseAreaOpen
                    anchors.fill: parent

                    onClicked: {
                        openDialog.open()
                    }
                }
            }
        }


    }
}

/*##^##
Designer {
    D{i:0;formeditorZoom:0.5}D{i:2}
}
##^##*/
