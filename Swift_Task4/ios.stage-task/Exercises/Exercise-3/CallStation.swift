import Foundation

final class CallStation {
    var usersSet = Set<User>()
    var callsArray = Array<Call>()
}

extension CallStation: Station {
    
    func users() -> [User] {
        return Array(usersSet)
    }
    
    func add(user: User) {
        usersSet.insert(user)
    }
    
    func remove(user: User) {
        usersSet.remove(user)
    }
    
    func execute(action: CallAction) -> CallID? {
        switch action {
        case .start(from: let from, to: let to):
            let call = Call(id: UUID(), incomingUser: from, outgoingUser: to, status: .calling)
            callsArray.append(call)
            return call.id
        case .answer(from: let user):
            for i in 0..<callsArray.count {
                if callsArray[i].outgoingUser == user {
                    let call = Call(id: callsArray[i].id, incomingUser: callsArray[i].incomingUser, outgoingUser: user, status: .talk)
                    callsArray.remove(at: i)
                    callsArray.append(call)
                    return call.id
                }
            }
        case .end(from: let from):
            for i in 0..<callsArray.count {
                if callsArray[i].incomingUser == from && callsArray[i].status == .calling {
                    let call = Call(id: callsArray[i].id, incomingUser: callsArray[i].incomingUser, outgoingUser: callsArray[i].outgoingUser, status: .ended(reason: .userBusy))
                    callsArray.remove(at: i)
                    callsArray.append(call)
                    return call.id
                } else if callsArray[i].outgoingUser == from && callsArray[i].status == .calling {
                    let call = Call(id: callsArray[i].id, incomingUser: callsArray[i].incomingUser, outgoingUser: callsArray[i].outgoingUser, status: .ended(reason: .cancel))
                    callsArray.remove(at: i)
                    callsArray.append(call)
                    return call.id
                } else if callsArray[i].incomingUser == from || callsArray[i].outgoingUser.id == from.id {
                    let call = Call(id: callsArray[i].id, incomingUser: callsArray[i].incomingUser, outgoingUser: callsArray[i].outgoingUser, status: .ended(reason: .end))
                    callsArray.remove(at: i)
                    callsArray.append(call)
                    return call.id
                }
            }
        }
        return nil
    }
    
    func calls() -> [Call] {
        return callsArray
    }
    
    func calls(user: User) -> [Call] {
        return callsArray.filter{$0.incomingUser == user || $0.outgoingUser == user}
    }
    
    func call(id: CallID) -> Call? {
        return callsArray.filter{$0.id == id}.first
    }
    
    func currentCall(user: User) -> Call? {
        return callsArray.filter{($0.incomingUser == user || $0.outgoingUser == user) && ($0.status == .talk || $0.status == .calling) }.first
        
    }
}
