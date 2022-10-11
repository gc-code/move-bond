address 0x2 {
    module Bond {
        use Std::FixedPoint32;
        use 0x2::Coin;
        use 0x2::Date;

        struct Bond {
            principal: Coin::Coin,
            interestRate: FixedPoint32::FixedPoint32,
            dateOfIssue: Date::Date,

            interestDue: u64,
            totalInterestPaid: u64,
            paidInterest: Coin::Coin,
        }

        public fun create(principal: Coin::Coin,
                interestRate: FixedPoint32::FixedPoint32,
                dateOfIssue: Date::Date): Bond {
            let paidInterest = Coin::mint(0);
            let interestDue = 0;
            let totalInterestPaid = 0;
            Bond { principal, interestRate, dateOfIssue, interestDue, totalInterestPaid, paidInterest }
        }

        public fun principalValue(bond: &Bond): u64 {
            Coin::value(&bond.principal)
        }

        public fun interestRate(bond: &Bond): &FixedPoint32::FixedPoint32 {
            &bond.interestRate
        }

        public fun dateOfIssue(bond: &Bond): &Date::Date {
            &bond.dateOfIssue
        }

        public fun interestDue(bond: &Bond): u64 {
            bond.interestDue
        }

        public fun isInterestDue(bond: &Bond): bool {
            bond.interestDue > 0
        }

        public fun updateDate(bond: &mut Bond, date: Date::Date): u64 {
            let annualInterest = Coin::value(&bond.principal) / FixedPoint32::divide_u64(100, *&bond.interestRate);
            let elapsedMonthsLifetime = Date::elapsedMonths(&bond.dateOfIssue, &date);
            let addedInterest = (elapsedMonthsLifetime * annualInterest / 12) - bond.totalInterestPaid;
            bond.totalInterestPaid = bond.totalInterestPaid + addedInterest;
            bond.interestDue = bond.interestDue + addedInterest;
            bond.interestDue
        }

        public fun payInterest(bond: &mut Bond, payment: Coin::Coin): u64 {
            bond.interestDue = bond.interestDue - Coin::value(&payment);
            Coin::addCoin(&mut bond.paidInterest, payment);
            bond.interestDue
        }

        public fun withdrawInterest(bond: &mut Bond): Coin::Coin {
            let interestValue = Coin::value(&bond.paidInterest);
            Coin::splitCoin(&mut bond.paidInterest, interestValue)
        }

        public fun burn(bond: Bond): Date::Date {
            let Bond { principal, interestRate, dateOfIssue, interestDue, totalInterestPaid, paidInterest } = bond;
            Coin::burn(principal);
            Coin::burn(paidInterest);
            interestRate;
            interestDue;
            totalInterestPaid;
            dateOfIssue
        }
    }
}