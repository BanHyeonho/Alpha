
public class Test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		String test = null;
		
		if( String.valueOf(test).contains(".S_") ) {
			System.out.println("111");
		}else if( String.valueOf(test).contains(".I_") ) {
			System.out.println("22");
		}else {
			System.out.println("333");
		}
		System.out.println(String.valueOf(test).length());
	}

}
