package View;

import java.util.Scanner;

import Controler.Curso;
import Model.Aluno;
import Model.Professor;

public class App {
    public static void main(String[] args) throws Exception {
       //craiar curso e incluir professor
       Professor professor = new Professor(
        "José Prereira","123.456.789-00",15000);
        Curso curso = new Curso("Programação java",professor);
        //menu de opções
        int operacao;
        boolean continuar = true;
        Scanner sc = new Scanner(System.in);
       while (continuar) {
        System.out.println("=========");
        System.out.println("Escolha opção desejada:");
        System.out.println("1. Adicionar Aluno");
        System.out.println("2. Informação do Curso");
        System.out.println("3. exibir status da turma");
        System.out.println("4. Sair");
        System.out.println("=========");
        operacao = sc.nextInt();
        switch (operacao) {
            case 1://exibir informações do curso
                System.out.println("informe o Nome do aluno");
                String nomeA = sc.next();
                System.out.println("Informe o Cpf do aluno");
                String cpfA = sc.next();
                System.out.println("Informe o numero da matricula");
                String matriculaA = sc.next();
                System.out.println("Informe a nota do aluno");
                double notaA = sc.nextDouble();
                Aluno aluno = new Aluno(nomeA, cpfA, matriculaA, notaA);
                curso.adicionarAluno(aluno);
                System.out.println("Aluno Adicionado com sucesso");
                System.out.println("================");
                break;
            case 2://exibir informações do curso
                curso.exibirInformacoesCurso();

            case 3://exibir informações da sala
                curso.exibirstatusAluno();

                break;
            case 4:// sair
            System.out.println("Saindo...");
            continuar = false;
            default:
                System.out.println("informe um valor valído!");
                break;
        }
       }
       sc.close();
    }
}
