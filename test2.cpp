#include <chrono>
#include <cstdlib>
#include <filesystem>
#include <fstream>
#include <functional>
#include <iostream>
#include <sstream>
#include <string>
#include <sys/types.h>
#include <unistd.h>
#include <vector>
#define N 10000
enum Tag { DUMMY, ISLAND, STRATEGIC_HUB, AVAIL, M_POOL };

std::ifstream infile("testcase3.txt");

typedef struct Node {
    int data;
    Tag tag;
    int visited;
    struct Node *queueNext;

    struct Node *next, *prev;
} Node;

typedef struct Queue {
    Node *front;
    Node *rear;
} Queue;
struct Info {
    Node *ptr;
    int occur;
};

class Timer {
  public:
    Timer(const std::string &name = "Execution") : name_(name) {
        start_time_ = std::chrono::high_resolution_clock::now();
        std::cout << "[" << name_ << "] Timer started..." << std::endl;
    }

    ~Timer() { stop(); }
    // so this is the
  private:
    void stop() {

        auto end_time = std::chrono::high_resolution_clock::now();

        auto duration = std::chrono::duration_cast<std::chrono::milliseconds>(
            end_time - start_time_);

        std::cout << "[" << name_ << "] Finished in: " << duration.count()
                  << " ms" << std::endl;
    }

  private:
    std::chrono::time_point<std::chrono::high_resolution_clock> start_time_;
    std::string name_;
};

struct ReturnPack {
    Node *head;
    int hubsCount;
};

// innerCount : number of nodes added in current step
// count: number of steps taken so far
// totalsteps: total steps to reach all strategic hubs from the starting hub
// meetCount: number of strategic hubs met so far
// visitedCount: to mark nodes visited in current BFS traversal
// stepCount: number of nodes to be processed in the current step
// minimumSteps: to keep track of the minimum total steps found so far

int judge(struct ReturnPack &pack) {
    Queue queue = {nullptr, nullptr};
    Node *now_node = pack.head;
    int hubsCount = pack.hubsCount;
    int minimumSteps = 99999999;
    Node *winner = now_node;

    Node *tempNode = pack.head;
    int temp = 0;
    //	std::cout << "start judging" << std::endl;
    /*for (; tempNode != pack.head || temp == 0; tempNode = tempNode->next) {
                    Node* temptempNode = tempNode->prev;
                    for (; temptempNode != tempNode; temptempNode =
       temptempNode->next) { std::cout << temptempNode->data << " ";

                    }
                    std::cout << std::endl;
                    temp++;
            }
            std::cout << "strategic hub count: " << pack.hubsCount << std::endl;
     */
    int visitedCount = 1;
    while (hubsCount) {
        int count = 0;
        int totalsteps = 0;
        int meetCount = 0;
        if (now_node->tag == STRATEGIC_HUB) {
            //	std::cout << "starting from node: " << now_node->data <<
            // std::endl;
            int stepCount = 1;
            int innerCount = 0;
            queue.rear = now_node;
            queue.rear->visited = visitedCount;
            int k = 0;
            while (1) {
                if (now_node != queue.rear) {
                    Node *tempNode = queue.front;
                    queue.front = queue.front->queueNext;
                    tempNode->queueNext = nullptr;
                    if (queue.front == nullptr)
                        break;
                } else {
                    if (queue.front == nullptr)
                        queue.front = queue.rear;
                }
                //		std::cout << "current front node: " << " " <<
                // queue.front->data << std::endl; 		std::cout << "current
                // final node: " << " " << queue.rear->data << std::endl;
                Node *tempNode = queue.front->prev;
                while (queue.front != tempNode) {
                    //	std::cout << "visiting node: " << tempNode->data <<
                    //std::endl;
                    if (tempNode->prev->visited < visitedCount) {
                        if (tempNode->prev->tag == STRATEGIC_HUB) {
                            totalsteps += (count + 1);
                            //			std::cout << "@@ " << "totalsteps" << "
                            //" << totalsteps << std::endl;
                            meetCount++;
                            if (meetCount == pack.hubsCount - 1) {
                                hubsCount--;
                                k = 1;
                                break;
                            }
                        }
                        queue.rear->queueNext = tempNode->prev;
                        queue.rear = tempNode->prev;
                        tempNode->prev->visited = visitedCount;
                        tempNode = tempNode->next;
                        innerCount++;
                    } else {
                        tempNode = tempNode->next;
                    }
                }

                if (k == 1)
                    break;
                stepCount--;
                if (stepCount == 0) {
                    stepCount = innerCount;
                    count++;
                    innerCount = 0;
                }
            }
            Node *tempPtr = queue.front, *prev = nullptr;
            for (; tempPtr != nullptr;) {
                prev = tempPtr;
                tempPtr = tempPtr->queueNext;
                prev->queueNext = nullptr;
            }

            queue.front = nullptr;
            queue.rear = nullptr;
            //		std::cout << "--------------------------------------" <<
            // std::endl;
            visitedCount++;
            if (totalsteps <= minimumSteps) {
                if (now_node->data < winner->data ||
                    totalsteps < minimumSteps) {
                    minimumSteps = totalsteps;
                    winner = now_node;
                    //  			std::cout << "new winner found: " <<
                    //  winner->data << " with steps: " << minimumSteps <<
                    //  std::endl;
                }
            }
            now_node = now_node->next;
        } else {
            now_node = now_node->next;
        }
    }

    return winner->data;
}

Node *getNewNode() {
    Node *now_node = nullptr;
    Node *nodePool = nullptr;
    nodePool = (Node *)::operator new(N * sizeof(Node));
    now_node = nodePool;
    int counter = 0;
    while (counter < N - 1) {
        now_node->tag = M_POOL;
        now_node->data = -1;
        now_node->next = now_node + 1;
        now_node->prev = now_node;
        now_node = now_node->next;
        counter++;
    }
    now_node->tag = M_POOL;
    now_node->data = -1;
    now_node->next = nullptr;
    now_node->prev = now_node;

    return nodePool;
}

// template<size_t K>
ReturnPack setRoute(struct Info *info, Node *dummyHead) {
    int counter = 0;
    Node *head = nullptr;
    int islandNum;
    int routeNum;
    infile >> islandNum >> routeNum;

    Node *getNode = dummyHead;

    head = getNode->next;
    int i;
    for (i = 0; i < islandNum; i++) {
        getNode = getNode->next;
        info[i].ptr = getNode;
        info[i].occur = 0;
        getNode->tag = ISLAND;
        getNode->visited = 0;
        getNode->queueNext = nullptr;
        getNode->data = i + 1;
        getNode->prev = getNode;
    }
    info[i].ptr = nullptr;
    info[i].occur = -1;
    dummyHead->next = getNode->next;
    getNode->next = head;

    std::function<void(Node *, int)> insertNode = [&](Node *ptr,
                                                      int to) mutable {
        if (dummyHead->next->next == nullptr) {
            dummyHead->next->next = getNewNode();
        }

        Node *temp = dummyHead->next;
        temp->tag = AVAIL;
        temp->data = to;
        dummyHead->next = temp->next;
        temp->next = ptr->prev;
        ptr->prev = temp;
        temp->prev = info[to - 1].ptr;
    };
    // malloc();
    int strategicHubCount = 0;
    for (int j = 0; j < routeNum; j++) {
        int from;
        int to;
        //	int counter = 0;
        infile >> from;
        while (1) {
            infile >> to;
            if (to != 0) {
                insertNode(info[from - 1].ptr, to);
                info[from - 1].occur++;

                insertNode(info[to - 1].ptr, from);
                if (info[from - 1].occur == 2) {
                    info[from - 1].ptr->tag = STRATEGIC_HUB;
                    //			std::cout <<" new strategichub" << from <<
                    // std::endl;
                    strategicHubCount++;
                }
                from = to;
            } else {
                info[from - 1].occur++;
                if (info[from - 1].occur == 2) {
                    info[from - 1].ptr->tag = STRATEGIC_HUB;
                    //			std::cout << "new strategichub" << from <<
                    // std::endl;
                    strategicHubCount++;
                }
                break;
            }
        }
    }
    counter++;
    //	std::cout << "case " << counter << " prepared" << std::endl;
    Node *tempNode = head;
    int temp = 0;
    /*	for (; tempNode != head || temp == 0; tempNode = tempNode->next) {
                    Node* temptempNode = tempNode->prev;
                    for (; temptempNode != tempNode; temptempNode =
       temptempNode->next) { std::cout << temptempNode->data << " ";

                    }
                    std::cout << std::endl;
                    temp++;
            }*/
    //	std::cout << "strategic hub count: " << strategicHubCount << std::endl;
    return {head, strategicHubCount};
}

void print(int result) {
    static int counter = 0;

    static std::ofstream outputFile;
    if (counter == 0) {
        outputFile.open("output3.txt");
        counter++;
    }
    outputFile << result << std::endl;
}

int main() {

    int it = 0;
    Timer timer;
    Node *nodePool = nullptr;

    nodePool = getNewNode();

    Node *dummyHead = (Node *)::operator new(sizeof(Node));
    dummyHead->tag = DUMMY;
    dummyHead->data = -1;
    dummyHead->next = nodePool;
    //	dummyHead->prev = dummyHead;
    dummyHead->queueNext = nullptr;
    dummyHead->visited = 0;

    struct Info *info = new struct Info[N + 1]{};
    infile >> it;
    int result;
    int counter = 0;
    while (it--) {
        //	std::cout << "=======================================" << std::endl;
        //	std::cout << "processing case " << counter + 1 << std::endl;
        //	std::cout << "=======================================" << std::endl;
        ReturnPack pack = setRoute(info, dummyHead);
        //	std::cout << pack.head->data << std::endl;
        result = judge(pack);
        print(result);
        Node *tempNode = pack.head;
        Node *ptr = tempNode;
        for (; tempNode->next != pack.head; tempNode = ptr) {
            ptr = tempNode->next;
            tempNode->next = ptr->prev;
        }
        tempNode->next = dummyHead->next;
        dummyHead->next = pack.head->prev;
        counter++;
        tempNode = dummyHead->next;
        //	std::cout << temp << " ";
    }
}
