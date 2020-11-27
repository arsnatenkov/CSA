#include <iostream>
#include <vector>
#include <random>
#include <ctime>
#include <chrono>
#include <omp.h>

#define N a
std::vector<std::vector<int>> forest; //Лес в котором летают неправильные пчелы
volatile bool found = false; //Флаг для проверки нашелся ли Пух
int ansM, ansN; //Переменные для хранения ответа

/// Метод для осуществления поиска Пуха пчелами в лесу (задачи в портфеле)
/// \param count Номер строки модели леса(двумерного массива)
/// \return Ничего не возвращает
void searching(int count) {

    bool complete = false; //Проверка готовности
    if (!found) { //Если Пух не наден, то давайте искать его на этой линии в лесу
        for (size_t i = 0; i < forest[0].size(); ++i) {
            if (forest[count][i] == 1) {

                found = true;
                complete = true;
                std::cout << count + 1 << " detachment of wrong bees found Pooh\n";
                ansN = count;
                ansM = i;
                std::cout << "Pooh located:" << ansN + 1 << " " << ansM + 1 << '\n';
                exit(0);
            }
        }
    }
    if (!complete) { //Если не готовы значит этот отряд пчел не нашел
        std::cout << count + 1 << " detachment of wrong bees doesn't found Pooh\n";
    }


}

/// Вход в программу, определение положения Пух в лесу
int main() {
    int a;
    int b;
    std::cout << "Enter x: ";
    std::cin >> a;
    std::cout << "Enter y: ";
    std::cin >> b;


    for (int i = 0; i < a; ++i) {
        forest.push_back(std::vector<int>());
        for (int j = 0; j < b; ++j) {
            forest[i].push_back(0);
        }
    }

    srand(time(nullptr));
    int x = rand() % a; //Координата Пуха в лесу
    int y = rand() % b; //Координата Пуха в лесу
    forest[x][y] = 1;
    auto start = std::chrono::high_resolution_clock::now();

        #pragma omp parallel for
        for (int i = 0; i < N; i++) {
            //std::cout << omp_get_thread_num() << "potok" << std::endl;
            #pragma omp critical
            searching(i);
        }



    auto end = std::chrono::high_resolution_clock::now();
    std::chrono::duration<float> duration = end - start;
    std::cout << duration.count() << std::endl;

    //Вывод местоположения Пуха в лесу
    if (x < 0 || y < 0 || x > a || y > b) {
        std::cout << "Pooh wasn't in the forest";
    }

    return 0;
}

