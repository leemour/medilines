function initYMap() {
  contactMap = new ymaps.Map("ya-map", {
    center:    [59.922266, 30.484438],
    zoom:      14,
    behaviors: ["default", "scrollZoom"]
  });

  var trafficControl = new ymaps.control.TrafficControl();
  contactMap.controls
    .add('zoomControl', { left: 5, top: 5 })
    .add('typeSelector')                    // Список типов карты
    .add('mapTools', { left: 35, top: 5 })  // Стандартный набор кнопок
    .add(trafficControl);                   // Пробки

  var ballonContent = "<span style='font-size:150%'>МедиЛайн Сервис</span>";
  contactMap.balloon.open([59.92442, 30.495253], ballonContent, {
    closeButton: false // Не показываем кнопку закрытия
  });
}