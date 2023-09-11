Done is better than perfect
# План похудения для приложения

  * Вынести тяжелые ресурсы в отдельный блок ext_resources.qrc
  * настроить запуск в epong.pro для режима релиз выполнение команды: 
    `rcc -binary resources_expansion.qrc -o main.<version-code>.<bundle-id>.obb`
  * Проверка загрузки и инициализации ресурса для режима Десктоп и Мобильный
