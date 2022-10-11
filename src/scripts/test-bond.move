script {
    use Std::Debug;
    use Std::FixedPoint32;
    use Std::Option;
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

        // Try getting the principal
        let principal1 = Bond::withdrawPrincipal(&mut newBond);
        Debug::print(&principal1);
        Option::destroy_none<Coin::Coin>(principal1);

        newDate = Date::create(2032, 6, 15);
        interest = Bond::updateDate(&mut newBond, newDate);
        Debug::print(&interest);

        // Try getting the principal again
        let principal2 = Bond::withdrawPrincipal(&mut newBond);
        Debug::print(&principal2);
        let principalCoin = Option::extract<Coin::Coin>(&mut principal2);
        Coin::burn(principalCoin);
        Option::destroy_none(principal2);

        newDate = Date::create(2032, 8, 15);
        interest = Bond::updateDate(&mut newBond, newDate);
        Debug::print(&interest);

        Bond::burn(newBond);
    }
}