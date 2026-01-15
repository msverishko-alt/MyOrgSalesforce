public class AccountHandler {
    public static void insertAccount(Integer count) {
    	
        List <Account> addAccounts = new List <Account> ();
        
        Integer N = 0;
        
        while (N < count){
            addAccounts.add(new Account (
             Name = 'Acme Inc ' + N,
                    AccountNumber = 'A000' + N
            )
          );
            N++;
                
        }
        
        insert addAccounts;
    }
}