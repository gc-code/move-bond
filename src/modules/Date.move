address 0x2 {
    module Date {
        struct Date has copy, drop {
            year: u64,
            month: u64,
            day: u64,
        }

        public fun create(year: u64, month: u64, day: u64): Date {
            Date { year, month, day }
        }

        public fun year(date: &Date): u64 {
            date.year
        }

        public fun month(date: &Date): u64 {
            date.month
        }

        public fun day(date: &Date): u64 {
            date.day
        }

        public fun elapsedMonths(date1: &Date, date2: &Date): u64 {
            let elapsedMonths = (year(date2) - year(date1)) * 12 + month(date2) - month(date1);
            if (day(date2) < day(date1)) {
                elapsedMonths = elapsedMonths - 1;
            };
            elapsedMonths
        }
    }
}