# Шаблон проекта QT5/QML интегрированного с Unit тестами

Структура проекта содержит следующие каталоги:

- app
- tests
- shared
# Каталог ``app``
Pong’s interface consists of two paddles and a ball. 
The ball deflects off the paddle upon impact. 
You need to obtain 11 points when your opponent misses the ball to win. 
Additionally, the game can either be played by two people or one against a computer-controlled paddle.

Для создания игры Pong на QML необходимо выполнить следующие шаги:

1. Создать новый проект QML в Qt Creator.
2. Создать файлы для игры: main.qml, Ball.qml, Paddle.qml.
3. В файле main.qml создать элементы интерфейса: поле для игры, две ракетки и мяч.
4. Определить свойства и методы для элементов Ball и Paddle.
5. Реализовать алгоритм движения мяча и ракеток.
6. Обработать столкновения мяча с ракетками и границами поля.
7. Добавить возможность подсчета очков.
8. Реализовать возможность начать новую игру.
