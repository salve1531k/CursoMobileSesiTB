package Model;

public class Professor extends Pessoa {
   //atributos - privados
  //Atributos - privados
  private double salario;
 

  //Métodos - públicos
  public Professor(String nome, String cpf, double salario) {
      super(nome, cpf);
      this.salario = salario;
  }

  //Getters and Setters

  public double getNota() {
      return salario;
  }


  public void setNota(double salario) {
      this.salario = salario;
  }
  @Override //Exibir informações
  public void exibirInformacoes(){
      super.exibirInformacoes();
      System.out.println("matricula: "+getNota());
  }


}
