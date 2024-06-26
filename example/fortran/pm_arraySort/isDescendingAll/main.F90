program example

    use pm_kind, only: SK, IK, LK ! all intrinsic types and kinds are supported.
    use pm_arraySort, only: isDescendingAll
    use pm_io, only: display_type

    implicit none

    type(display_type) :: disp

    disp = display_type(file = "main.out.F90")

    call disp%skip()
    call disp%show("isDescendingAll('')")
    call disp%show( isDescendingAll('') )
    call disp%skip()
    call disp%show("isDescendingAll('?Aa')")
    call disp%show( isDescendingAll('?Aa') )
    call disp%skip()
    call disp%show("isDescendingAll('A!b')")
    call disp%show( isDescendingAll('A!b') )
    call disp%skip()
    call disp%show("isDescendingAll('zxw')")
    call disp%show( isDescendingAll('zxw') )
    call disp%skip()
    call disp%show("isDescendingAll('AAA')")
    call disp%show( isDescendingAll('AAA') )
    call disp%skip()

    call disp%skip()
    call disp%show("isDescendingAll([character(0) ::])")
    call disp%show( isDescendingAll([character(0) ::]) )
    call disp%skip()
    call disp%show("isDescendingAll(['?', 'A', 'a'])")
    call disp%show( isDescendingAll(['?', 'A', 'a']) )
    call disp%skip()
    call disp%show("isDescendingAll(['A', '!', 'b'])")
    call disp%show( isDescendingAll(['A', '!', 'b']) )
    call disp%skip()
    call disp%show("isDescendingAll(['z', 'x', 'w'])")
    call disp%show( isDescendingAll(['z', 'x', 'w']) )
    call disp%skip()
    call disp%show("isDescendingAll(['A', 'A', 'A'])")
    call disp%show( isDescendingAll(['A', 'A', 'A']) )
    call disp%skip()

    call disp%skip()
    call disp%show("isDescendingAll([integer ::])")
    call disp%show( isDescendingAll([integer ::]) )
    call disp%skip()
    call disp%show("isDescendingAll([+1, +2, +3])")
    call disp%show( isDescendingAll([+1, +2, +3]) )
    call disp%skip()
    call disp%show("isDescendingAll([-1, -2, -3])")
    call disp%show( isDescendingAll([-1, -2, -3]) )
    call disp%skip()
    call disp%show("isDescendingAll([-1, +2, -3])")
    call disp%show( isDescendingAll([-1, +2, -3]) )
    call disp%skip()
    call disp%show("isDescendingAll([-1, -1, -1])")
    call disp%show( isDescendingAll([-1, -1, -1]) )
    call disp%skip()

    call disp%skip()
    call disp%show("isDescendingAll([logical ::])")
    call disp%show( isDescendingAll([logical ::]) )
    call disp%skip()
    call disp%show("isDescendingAll([.false., .false., .true.])")
    call disp%show( isDescendingAll([.false., .false., .true.]) )
    call disp%skip()
    call disp%show("isDescendingAll([.true., .false., .false.])")
    call disp%show( isDescendingAll([.true., .false., .false.]) )
    call disp%skip()
    call disp%show("isDescendingAll([.false., .true., .false.])")
    call disp%show( isDescendingAll([.false., .true., .false.]) )
    call disp%skip()
    call disp%show("isDescendingAll([.true., .true., .true.])")
    call disp%show( isDescendingAll([.true., .true., .true.]) )
    call disp%skip()

    call disp%skip()
    call disp%show("isDescendingAll([complex ::])")
    call disp%show( isDescendingAll([complex ::]) )
    call disp%skip()
    call disp%show("isDescendingAll([(+1., -1.), (+2., -2.), (+3., -3.)])")
    call disp%show( isDescendingAll([(+1., -1.), (+2., -2.), (+3., -3.)]) )
    call disp%skip()
    call disp%show("isDescendingAll([(-1., +1.), (-2., +2.), (-3., +3.)])")
    call disp%show( isDescendingAll([(-1., +1.), (-2., +2.), (-3., +3.)]) )
    call disp%skip()
    call disp%show("isDescendingAll([(-1., +1.), (+2., -2.), (-3., +3.)])")
    call disp%show( isDescendingAll([(-1., +1.), (+2., -2.), (-3., +3.)]) )
    call disp%skip()
    call disp%show("isDescendingAll([(-1., +1.), (-1., +1.), (-1., +1.)])")
    call disp%show( isDescendingAll([(-1., +1.), (-1., +1.), (-1., +1.)]) )
    call disp%skip()
    call disp%show("isDescendingAll([(-1., +1.), (-1., -2.), (-1., +3.)])")
    call disp%show( isDescendingAll([(-1., +1.), (-1., -2.), (-1., +3.)]) )
    call disp%skip()

    call disp%skip()
    call disp%show("isDescendingAll([real ::])")
    call disp%show( isDescendingAll([real ::]) )
    call disp%skip()
    call disp%show("isDescendingAll([+1., +2., +3.])")
    call disp%show( isDescendingAll([+1., +2., +3.]) )
    call disp%skip()
    call disp%show("isDescendingAll([-1., -2., -3.])")
    call disp%show( isDescendingAll([-1., -2., -3.]) )
    call disp%skip()
    call disp%show("isDescendingAll([-1., +2., -3.])")
    call disp%show( isDescendingAll([-1., +2., -3.]) )
    call disp%skip()
    call disp%show("isDescendingAll([-1., -1., -1.])")
    call disp%show( isDescendingAll([-1., -1., -1.]) )
    call disp%skip()

#if PDT_ENABLED
    !   \bug
    !   Intel ifort 2022.3 cannot handle aliases for pdt names (e.g., strc => css_pdt).
    block
        use pm_container, only: css_pdt
        call disp%skip()
        call disp%show("isDescendingAll([css_pdt('is'), css_pdt(  'sorted'), css_pdt('string')])")
        call disp%show( isDescendingAll([css_pdt('is'), css_pdt(  'sorted'), css_pdt('string')]) )
        call disp%skip()
        call disp%show("isDescendingAll([css_pdt('string'), css_pdt('is'), css_pdt('sorted')])")
        call disp%show( isDescendingAll([css_pdt('string'), css_pdt('is'), css_pdt('sorted')]) )
        call disp%skip()
        call disp%show("isDescendingAll([css_pdt('same string'), css_pdt('same '), css_pdt('same')])")
        call disp%show( isDescendingAll([css_pdt('same string'), css_pdt('same '), css_pdt('same')]) )
        call disp%skip()
    end block
#endif

end program example