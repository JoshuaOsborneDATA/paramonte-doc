!**********************************************************************************************************************************
!**********************************************************************************************************************************
!
!  ParaMonte: plain powerful parallel Monte Carlo library.
!
!  Copyright (C) 2012-present, The Computational Data Science Lab
!
!  This file is part of ParaMonte library. 
!
!  ParaMonte is free software: you can redistribute it and/or modify
!  it under the terms of the GNU Lesser General Public License as published by
!  the Free Software Foundation, version 3 of the License.
!
!  ParaMonte is distributed in the hope that it will be useful,
!  but WITHOUT ANY WARRANTY; without even the implied warranty of
!  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
!  GNU Lesser General Public License for more details.
!
!  You should have received a copy of the GNU Lesser General Public License
!  along with ParaMonte.  If not, see <https://www.gnu.org/licenses/>.
!
!**********************************************************************************************************************************
!**********************************************************************************************************************************

module SpecBase_InterfaceType_mod
!#if defined CFI_ENABLED

    use Constants_mod, only: IK
    implicit none

    character(*), parameter         :: MODULE_NAME = "@SpecBase_InterfaceType_mod"
    integer(IK), parameter          :: MAX_INTERFACETYPE_LEN = 511_IK

    character(:)    , allocatable   :: interfaceType ! namelist input

    type                            :: InterfaceType_type
        logical                     :: isPython = .false.
        logical                     :: isClang = .false.
        character(:), allocatable   :: val
        character(:), allocatable   :: def
        character(:), allocatable   :: null
        character(:), allocatable   :: desc
    contains
        procedure, pass             :: set => setInterfaceType, nullifyNameListVar
    end type InterfaceType_type

    interface InterfaceType_type
        module procedure            :: constructInterfaceType
    end interface InterfaceType_type

    private :: constructInterfaceType, setInterfaceType, nullifyNameListVar

!***********************************************************************************************************************************
!***********************************************************************************************************************************

contains

!***********************************************************************************************************************************
!***********************************************************************************************************************************

    function constructInterfaceType() result(InterfaceTypeObj)
#if defined DLL_ENABLED && !defined CFI_ENABLED
        !DEC$ ATTRIBUTES DLLEXPORT :: constructInterfaceType
#endif
        use Constants_mod, only: NULL_SK
        use Decoration_mod, only: TAB
        use String_mod, only: num2str
        implicit none
        type(InterfaceType_type) :: InterfaceTypeObj
#if defined CFI_ENABLED
        InterfaceTypeObj%def = "The C Programming Language."
#else
        InterfaceTypeObj%def = "The Fortran Programming Language."
#endif
        if ( allocated(InterfaceTypeObj%null) ) deallocate(InterfaceTypeObj%null)
        allocate( character(len=MAX_INTERFACETYPE_LEN) :: InterfaceTypeObj%null )
        InterfaceTypeObj%null = repeat(NULL_SK, MAX_INTERFACETYPE_LEN)
        InterfaceTypeObj%desc = &
        "This is a ParaMonte internal variable used for providing information about other languages' interface with ParaMonte."
    end function constructInterfaceType

!***********************************************************************************************************************************
!***********************************************************************************************************************************

    subroutine nullifyNameListVar(InterfaceTypeObj)
#if defined DLL_ENABLED && !defined CFI_ENABLED
        !DEC$ ATTRIBUTES DLLEXPORT :: nullifyNameListVar
#endif
        implicit none
        class(InterfaceType_type), intent(in) :: InterfaceTypeObj
        interfaceType = InterfaceTypeObj%null
    end subroutine nullifyNameListVar

!***********************************************************************************************************************************
!***********************************************************************************************************************************

    subroutine setInterfaceType(InterfaceTypeObj,interfaceType)
#if defined DLL_ENABLED && !defined CFI_ENABLED
        !DEC$ ATTRIBUTES DLLEXPORT :: setInterfaceType
#endif
        implicit none
        class(InterfaceType_type), intent(inout)    :: InterfaceTypeObj
        character(*), intent(in)                    :: interfaceType
        if (allocated(InterfaceTypeObj%val)) deallocate(InterfaceTypeObj%val)
        InterfaceTypeObj%val = trim(adjustl(interfaceType))
        if (InterfaceTypeObj%val==trim(adjustl(InterfaceTypeObj%null))) then
            InterfaceTypeObj%val=InterfaceTypeObj%def
            InterfaceTypeObj%isClang = .true.
        elseif (InterfaceTypeObj%val(1:6) == "Python") then
            InterfaceTypeObj%isPython = .true.
        end if
    end subroutine setInterfaceType

!***********************************************************************************************************************************
!***********************************************************************************************************************************

!#endif
end module SpecBase_InterfaceType_mod