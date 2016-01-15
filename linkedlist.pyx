from libc.stdlib cimport malloc

ctypedef struct _LinkedListStruct:
    int data
    _LinkedListStruct *next


cdef class LinkedList:

    cdef _LinkedListStruct *_head

    def __cinit__(self):
        self._head = NULL

    cpdef add(self, int data):
        cdef _LinkedListStruct *obj = <_LinkedListStruct*> malloc(sizeof(_LinkedListStruct))
        if not obj:
            raise MemoryError()

        obj.data = data
        obj.next = NULL

        cdef _LinkedListStruct *ptr = self._head
        if self._head is NULL:
            self._head = obj
            return
        else:
            while ptr.next is not NULL:
                ptr = ptr.next
            ptr.next = obj

    cpdef count(self, int data):
        cdef _LinkedListStruct *ptr = self._head
        cdef int c = 0
        while ptr is not NULL:
            if ptr.data == data:
                c += 1
            ptr = ptr.next
        return c

    def __iter__(self):
        cdef _LinkedListStruct *ptr = self._head
        while ptr is not NULL:
            yield ptr.data
            ptr = ptr.next
