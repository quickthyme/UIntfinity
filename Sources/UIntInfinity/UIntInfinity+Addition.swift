
public extension UIntInfinity {

    static func + (lhs: UIntInfinity, rhs: UIntInfinity) -> UIntInfinity {
        let (padL, padR) = padMax(lhs.value, rhs.value)
        let zipped = zip(padL, padR)
        let solved: (String, Bool) = zipped.lazy
            .reduce(("", false), ({ r, n in
                let (v, o) = add(n.0, n.1, r.1)
                return (r.0 + String(v), o)
            }))
        return UIntInfinity(raw: (solved.1) ? (solved.0 + "1") : (solved.0))
    }

    static func += (lhs: inout UIntInfinity, rhs: UIntInfinity) {
        lhs = lhs + rhs
    }
}

internal extension UIntInfinity {

    static func add(_ charL: Character,
                    _ charR: Character,
                    _ overflow: Bool) -> (Character, Bool) {
        guard
            let digitL = digitOf(charL),
            let digitR = digitOf(charR)
            else { return (Character(""), true) }

        let v: UInt8 = digitL + digitR + (overflow ? 1 : 0)

        return (v > 9)
            ? (Character("\(v - 10)"), true)
            : (Character("\(v)"), false)
    }
}
