const String databaseName = 'pm.db';
const int databaseVersion = 1;

// -----------    Users table   -------------
const String userTableName = 'Users';
const String userIdField = 'id';
const String userNameField = 'username';
const String userBalanceField = 'balance';
const String userIsSelectedField = 'isSelected';

// -----------    Cards table   -------------
const String cardsTableName = 'Cards';
const String cardsIdField = 'id';
const String cardsNameField = 'card_name';
const String cardBalanceField = 'card_balance';
const String cardUserIdField = 'user_id';

// -----------    Budgets table   -------------
const String budgetsTableName = 'Budgets';
const String budgetsIdField = 'id';
const String budgetsPlaceField = 'place';
const String budgetsAmountField = 'amount';
const String budgetsDateField = 'budget_date';
const String budgetsTypeField = 'type';
const String budgetsUserIdField = 'user_id';
const String budgetsCardIdField = 'card_id';
