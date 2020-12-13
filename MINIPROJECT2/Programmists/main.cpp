#include <iostream>
#include <pthread.h>
#include <semaphore.h>
#include <queue>
#include <vector>
#include <string>
#include <unistd.h>

// Структура описывающая задание.
struct TaskStructure {
    int task;
    int requester;
    int executer;
};

// Структура с данными для потока.
struct Info {
    int taskAmt;
    int myNumber;
    pthread_mutex_t* wrMutex;
    pthread_mutex_t* workMutex;
};

int progersAmt = 3; // Количество программистов.
int readyProgers = 0; // Количество программистов, которые закончили работу.

std::vector<std::queue<TaskStructure>> tasks(progersAmt, std::queue<TaskStructure>()); // Очередь с заданиями для каждого программиста.
std::vector<sem_t> sems(progersAmt, sem_t()); // Семафор для каждого программиста.
std::vector<int> tasksAmt(3); //Количество задач для каждого программиста
//Метод для вывода типа задания
std::string printType(int task){
    if(task == 0){
        return "review accept";
    }
    if(task == 1){
        return "fix task";
    }
    if(task == 2){
        return "review task";
    }
}

// Метод, описывающий программиста.
void* programmer(void* param){
    // Извлечение данных.
    Info* info = (Info*)param;
    int taskAmt = info->taskAmt;
    int myNum = info->myNumber;
    pthread_mutex_t* wrMut = info->wrMutex;
    pthread_mutex_t* workMut = info->workMutex;

    // Переменные, описывающие состояние.
    int val = 0;
    int curState = 0;
    int completedTask;
    int myRequester;
    TaskStructure newTask;
    TaskStructure myTask;
    bool almostWork = true;


    while(almostWork){

        pthread_mutex_lock(wrMut);
        switch (curState){
            case 0:
                std::cout << "Programmer #"
                          << myNum + 1 << ": start working" <<  std::endl;

                break;

            case 1:
                std::cout << "Programmer #" << myNum + 1
                          << ": writing task #" << completedTask + 1 <<  std::endl;
                break;

            case 3:
                std::cout << "Programmer #" << myNum + 1
                          << ": reviewing task from programmer #" << myRequester + 1
                          <<  std::endl;
                break;

            case 2:
                std::cout << "Programmer #" << myNum + 1
                          << ": fixing task #" << completedTask+1 <<  std::endl;
                break;

            case 4:
                std::cout << "Programmer #" << myNum + 1
                          << ": send " << printType(newTask.task) << " to "
                          << "programmer #" << newTask.executer + 1 <<   std::endl;
                break;

            case 5:
                sem_getvalue(&sems[myNum],&val);
                if(val <= 0){
                    std::cout << "Programmer #" << myNum + 1
                              << ": wait new task" << std::endl;
                }
                break;

            case 6:

                if(tasks[myNum].empty()){
                    std::cout << "Programmer #" << myNum + 1
                              << ": ends his work" << std::endl;
                    break;
                }
                std::cout << "Programmer #" << myNum + 1
                          << ": get "<< printType(tasks[myNum].front().task) << std::endl;
                break;

            case 7:
                std::cout << "Programmer #" << myNum + 1
                          << ": dont have any tasks but wait code for checking"
                          << std::endl;
                break;
            default : break;
        }
        pthread_mutex_unlock(wrMut);

        switch (curState) {
            case 0:

                completedTask = 0;
                curState = 1;
                break;

            case 1:

                usleep(1000);
                newTask = TaskStructure{2, myNum,
                                (myNum + rand() % (progersAmt-1) + 1) % progersAmt };
                curState = 4;
                break;

            case 2:

                usleep(1500);
                newTask = TaskStructure{2, myNum, myRequester};
                curState = 4;
                break;

            case 3:

                usleep(500);
                newTask = TaskStructure{
                        (rand() % 10 < 8) ? 0 : 1,
                        myNum,
                        myRequester};
                curState = 4;
                break;

            case 4:

                tasks[newTask.executer].push(newTask);
                sem_post(&sems[newTask.executer]);
                curState = 5;
                break;

            case 5:

                sem_wait(&sems[myNum]);
                curState = 6;
                break;

            case 6:

                if(tasks[myNum].empty()){
                    curState = 8;
                    break;
                }
                myTask = tasks[myNum].front();
                tasks[myNum].pop();

                myRequester = myTask.requester;
                if (myTask.task == 0) completedTask++;

                if (completedTask == taskAmt && myTask.task == 0) {
                    pthread_mutex_lock(workMut);
                    curState = 7;
                    readyProgers++;

                    if (readyProgers == progersAmt) {
                        for (int i = 0; i < progersAmt; i++){
                            sem_post(&sems[i]);
                        }
                    }
                    pthread_mutex_unlock(workMut);
                    break;
                }
                if(myTask.task == 1){
                    curState = 2;
                }
                else if(myTask.task == 2){
                    curState = 3;
                }
                else if(myTask.task == 0){
                    curState = 1;
                }else{
                    curState = 9;
                }
                break;
            case 7:

                curState = 5;
                break;
            case 8:

                almostWork = false;
                curState = 9;
                break;
            default: break;
        }
    }

    return nullptr;
}

void takeTask(){
    // Считаем количество задач каждому программисту.
    for (int i = 0; i < 3; i++){
        std::cout << "Enter the quantity of task for "<< i + 1 << " programmers (from 1 to 10): " << std::endl;
        std::cin >> tasksAmt[i];
    }
    if ((tasksAmt[0] < 1 || tasksAmt[0] > 10) || (tasksAmt[1] < 1 || tasksAmt[1] > 10) || (tasksAmt[2] < 1 || tasksAmt[2] > 10)){
        std::cout << std::endl << "Wrong quantity of tasks" << std::endl;
        exit(1);
    }

    std::cout << std::endl;
}
int main() {
    takeTask();

    for(int i = 0; i < progersAmt; i++){
        sem_init(&sems[i], 0, 0);
    }
    pthread_mutex_t mutex, workMutex;
    pthread_mutex_init(&mutex, NULL);
    pthread_mutex_init(&workMutex, NULL);

    // Запускаем потоки.
    std::vector<pthread_t> threads =
            std::vector<pthread_t>(progersAmt, pthread_t());
    Info* info = new Info[progersAmt];
    for(int i = 0; i < progersAmt; i++){
        info[i] = Info{ tasksAmt[i], i, &mutex, &workMutex };
        pthread_create(&threads[i], NULL, programmer, &info[i]);
    }

    // Освобождаем ресурсы.
    for(int i = 0; i < progersAmt; i++){
        pthread_join(threads[i], NULL);
    }
    pthread_mutex_destroy(&mutex);
    pthread_mutex_destroy(&workMutex);
    delete[] info;
    return 0;
}