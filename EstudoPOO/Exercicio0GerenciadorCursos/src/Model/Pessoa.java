package Model;

public class Pessoa { //Emcapsulamento
    //atributos - privados
    private String nome;
    private String cpf;
    

    //métodos
public Pessoa(String nome, String cpf) {
        this.nome = nome;
        this.cpf = cpf;
    }
//Getters and Setters    


public String getNome() {
    return nome;
}


public void setNome(String nome) {
    this.nome = nome;
}


public String getCpf() {
    return cpf;
}


public void setCpf(String cpf) {
    this.cpf = cpf;
}
//Exibir alterações
public void exibirInformacoes(){
    System.out.println("Nome: "+getNome());
    System.out.println("Cpf:"+getCpf());
}




}
