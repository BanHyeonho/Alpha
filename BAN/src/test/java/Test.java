public class Test {

	public static void main(String[] args) {
		// TODO Auto-generated method stub

		String a = "http://localhost/oauthReceive";
		
		System.out.println(a.lastIndexOf("/"));
		System.out.println(a.substring(0, a.lastIndexOf("/")));
		System.out.println(a.substring(0, a.lastIndexOf("/")).replace("http://", "") );
		System.out.println(a.substring(a.lastIndexOf("/")));
	}

}
