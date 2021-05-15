const mapEle = document.getElementById('map');

        function initialize() {
            var location = { lat: 35.658746, lng: 139.745465 }//東京タワー
            // 地図初期化
            var map = new google.maps.Map(mapEle, {
                zoom: 15,
                center: location
            });
        };