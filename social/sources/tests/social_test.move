#[test_only]
module social::stake_test {
    use std::option;
    use std::signer;
    use std::string;
    use aptos_framework::account;
    use aptos_framework::genesis;
    // use aptos_framework::fungible_asset;
    use social::social::{Self};

    fun setup_test()  {
        genesis::setup();
        account::create_account_for_test(@0xabc);
        account::create_account_for_test(@0x123);
        social::init_module_for_test(&account::create_account_for_test(@social), @0xabc);
    }

    #[test(user=@0xabc)]
    fun test_e2e(user: &signer) {
        setup_test();
        social::first_time_stake_native_for_test(&account::create_account_for_test(@0xabc), 100_000_000, 100_000_000,  @0x123);
        assert!(social::get_protocol_stake_amount(@0xabc) == 100_000_000, 101);
        social::register_kol(&account::create_account_for_test(@0x123), @0xabc, 100_000_000);
        assert!(social::get_kol_stake_amount(@0x123, @0xabc) == 100_000_000, 102);
    }
}