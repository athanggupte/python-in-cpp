#include <python3.9/Python.h>
#include "DecisionTree.h"

void printHelloPython()
{
    Py_Initialize();
    PyRun_SimpleString("print('Hello World from python!')");
    Py_Finalize();
}
