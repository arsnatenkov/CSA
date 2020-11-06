#include <iostream>
#include <pthread.h>
#include <vector>
#include <random>

int forest[10][10]; //Лес в котором летают неправильные пчелы
volatile bool found = false; //Флаг для проверки нашелся ли Пух
int str; //Переменная для хранения номера задачи
int ansM, ansN; //Переменные для хранения ответа

/// Метод для осуществления поиска Пуха пчелами в лесу (задачи в портфеле)
/// \param count Номер строки модели леса(двумерного массива)
/// \return Ничего не возвращает
void* searching(void *count) {

    bool complete = false; //Проверка готовности
    if(!found){ //Если Пух не наден, то давайте искать его на этой линии в лесу
        for (int i = 0; i < 10; ++i) {
            if (forest[(int64_t)count][i] == 1) {

                found = true;
                complete = true;
                std::cout << str + 1 << " detachment of wrong bees found Pooh\n";
                ansN = str;
                ansM = i;
            }
        }
    }
    if (!complete){ //Если не готовы значит этот отряд пчел не нашел
        std::cout << str + 1 << " detachment of wrong bees doesn't found Pooh\n";
    }


}
/// Вход в программу, определение положения Пух в лесу
int main()
{
    int n = 10;
    for (int i = 0; i < 10; ++i){
        for (int j = 0; j < 10; ++j) {
            forest[i][j] = 0;
        }
    }
    int x = rand() % 11; //Координата Пуха в лесу
    int y = rand() % 11; //Координата Пуха в лесу
    forest[x][y] = 1;

    std::vector<pthread_t> threads(n); //Создание портфеля задач

    for (std::vector<pthread_t>::iterator it = threads.begin(); it != threads.end(); ++it){ //Выполнение задач в портфеле

        pthread_create(&*it, NULL, searching, (void *)str);
        pthread_join((pthread_t)*it, NULL);
        ++str;
    }
    //Вывод местоположения Пуха в лесу
    if(x < 0 || y < 0 || x > 10 || y > 10){
        std::cout << "Pooh wasn't in the forest";
    }
    else{
        std::cout << "Pooh located:" << ansN + 1 << " " << ansM + 1 << '\n';
    }

    return 0;
}


