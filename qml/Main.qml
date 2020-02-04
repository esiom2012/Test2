import Felgo 3.0
import QtQuick 2.0

App {
    // This signal handler is called when the app is created, like a constructor
    Component.onCompleted: {
        // show network activity indicator for ongoing HttpRequest without activation delay
        HttpNetworkActivityIndicator.activationDelay = 0

        // get IP via http request
        getIp()
    }

    NavigationStack {
        Page {
            title: "IP HttpRequest"
            rightBarItem: ActivityIndicatorBarItem {
                enabled: HttpNetworkActivityIndicator.enabled
                visible: enabled
            }

            AppText {
                id: ipText
                anchors.centerIn: parent
                text: "OK"
            }
        }
    }

    function getIp() {
        // create request
        HttpRequest.get("http://ip.jsontest.com/")
        .then(function(res) {
            // The responseText looks like this {"ip":"xxx.xxx.xxx.xxx"}
            // it automatically gets parsed into a JSON object
            var responseJSON = res.body
            // Read the ip property of the response
            var ip = responseJSON.ip
            // Display the ip in the AppText item
            ipText.text = "IP: " + ip
        })
        .catch(function(err) {
            console.log("Error: "+err.message);
            ipText.text = "Error: "+err.message;
        });
    }
}
