//
//  Hooks.swift
//  Feathers
//
//  Created by Brendan Conron on 5/14/17.
//  Copyright © 2017 Swoopy Studios. All rights reserved.
//

import Feathers
import Foundation
import PromiseKit
import enum Result.Result

/// Hook that always errors
struct ErrorHook: Hook {

    let error: FeathersError

    init(error: FeathersError) {
        self.error = error
    }

    func run(with hookObject: HookObject) -> Promise<HookObject> {
        return Promise(error: error)
    }

}

// Hook that doesn't reject, just modifies the error
struct ModifyErrorHook: Hook {
    let error: FeathersError

    init(error: FeathersError) {
        self.error = error
    }

    func run(with hookObject: HookObject) -> Promise<HookObject> {
        var object = hookObject
        object.error = error
        return Promise(value: object)
    }

}

struct StubHook: Hook {

    let data: ResponseData

    init(data: ResponseData) {
        self.data = data
    }

    func run(with hookObject: HookObject) -> Promise<HookObject> {
        var object = hookObject
        object.result = Response(pagination: nil, data: data)
        return Promise(value: object)
    }

}


struct PopuplateDataAfterHook: Hook {

    let data: [String: Any]

    init(data: [String: Any]) {
        self.data = data
    }

    func run(with hookObject: HookObject) -> Promise<HookObject> {
        var object = hookObject
        object.result = Response(pagination: nil, data: .jsonObject(data))
        return Promise(value: object)
    }

}
