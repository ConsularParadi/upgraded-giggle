
from . import dp_geeksTraining as func


def test_function():
    solve = func.Solution() 
    arr = [[1,2,5],[3,1,1],[3,3,3]]
    n = 3
    result = solve.maximumPoints(arr, n)
    assert result == 11
