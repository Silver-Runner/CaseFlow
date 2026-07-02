public class empData {
    
  public List<string> printEmpNames (map<integer,string> EmpData){
        map<integer,string> fetchData = EmpData;
        List<string> empNames = fetchData.values();
        return empNames;
    }
    public integer printAgeOfEmp (string empName){
        map<string,integer> empData = new map<string,integer>();
        empData.put('Rishabh',23);
        empData.put('Shivam',22);
        empData.put('Ankit',21);
        empData.put('Arsh',22);
        return empData.get(empName);
    }
}