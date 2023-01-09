from filtc.filtc import FilterP 
from dataclasses import dataclass
from typing import Protocol, runtime_checkable, Optional, Callable

@runtime_checkable
class MFilter(FilterP, Protocol):
    ...

@dataclass
class F:
    
    val: float

    def __call__(self, measurements: Optional[float]) -> "F":
        if measurements is not None:
            return F(self.val + measurements)
        else: 
            return self


_F = Callable[[Optional[float]], "_F"]
def f(measurements: float | None) -> Callable[[Optional[float]], _F]:
    ...


def test_isinstance():

    assert isinstance(F(4.9), MFilter)
    assert isinstance(F(5.5)(4.2), MFilter)
    assert isinstance(F(5.5)(4.2)(None), MFilter)
    assert isinstance(f, MFilter)
