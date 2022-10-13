
from typing import TypeVar, Callable, Generic, Iterator, Optional, Protocol, Iterable
import numpy as np

M               = TypeVar("M", contravariant=True) 
Measurements    = Optional[M]
S               = TypeVar("S") 

class Filter(Protocol[M]):

    def __call__(self, measurements: Optional[M]) -> "Filter":
        ...

FilterModifier  = Callable[[Filter, S], Filter]


def filtc(f           : Filter, 
          datasource  : Iterator[Measurements]) -> Iterable[Filter]:

    p = f
    for a in datasource:
        p2 = p(a)
        yield p2
        p = p2


def filtc_conditional(f             : Filter, 
                      f_modifier    : FilterModifier[S], 
                      datasource    : Iterator[tuple[S, Measurements]]
                      ) -> Iterator[Filter]:

    """ Filter function that allows modification of the filter before it is
    used, created to be able to insert known data, from the ground truth, into
    the filter """

    for s, data in datasource:

        f = f_modifier(f, s)
        ff = f(data)
        yield ff

