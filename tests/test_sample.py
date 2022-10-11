from berpfpy.module import add


def inc(x):
    return x + 1


def test_answer():
    assert inc(3) == 4

def test_add():
    assert add(4) == 5
