open Github_hooks

module Time : TIME

module Make : functor (Conf : CONFIGURATION) -> HOOKS
