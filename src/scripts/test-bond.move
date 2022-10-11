script {
    use Std::Debug;
    use Std::FixedPoint32;
    use 0x2::Coin;
    use 0x2::Bond;
    use 0x2::Date;

    fun main() {
        let principal = Coin::mint(1000);

        let dateOfIssue = Date::create(2022, 5, 15);
        let interestRate = FixedPoint32::create_from_rational(9, 2);
        let newBond = Bond::create(principal, interestRate, dateOfIssue, 10);

        let newDate = Date::create(2022, 6, 15);
        let interest = Bond::updateDate(&mut newBond, newDate);
        Debug::print(&interest);

        newDate = Date::create(2024, 6, 15);
        interest = Bond::updateDate(&mut newBond, newDate);
        Debug::print(&interest);

        newDate = Date::create(2024, 8, 20);
        interest = Bond::updateDate(&mut newBond, newDate);
        Debug::print(&interest);

        newDate = Date::create(2032, 6, 15);
        interest = Bond::updateDate(&mut newBond, newDate);
        Debug::print(&interest);

        newDate = Date::create(2032, 8, 15);
        interest = Bond::updateDate(&mut newBond, newDate);
        Debug::print(&interest);

        Bond::burn(newBond);
    }
}