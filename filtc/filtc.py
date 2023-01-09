
from typing import TypeVar, Callable, Iterator, Optional, Protocol, Iterable
from typing_extensions import Self

M               = TypeVar("M", contravariant=True) 
Measurements    = Optional[M]
S               = TypeVar("S") 

class FilterP(Protocol[M]):

    def __call__(self, measurements: Optional[M]) -> Self:
        ...


FilterT = TypeVar("FilterT", bound = FilterP)
FilterModifier  = Callable[[FilterT, S], FilterT]

def filtc(f           : FilterT, 
          datasource  : Iterator[Measurements]) -> Iterable[FilterT]:

    p = f
    for a in datasource:
        p2 = p(a)
        yield p2
        p = p2


def filtc_conditional(f             : FilterT, 
                      f_modifier    : Callable[[FilterT, S], FilterT], 
                      datasource    : Iterator[tuple[S, Measurements]]
                      ) -> Iterator[FilterT]:

    """ Filter function that allows modification of the filter before it is
    used, created to be able to insert known data, from the ground truth, into
    the filter """

    for s, data in datasource:

        f = f_modifier(f, s)
        ff = f(data)
        yield ff

