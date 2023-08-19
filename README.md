# Projeto de Exemplo: Clean Architecture com TDD, BLoC e Cubit

Este repositório contém um projeto de exemplo que demonstra a implementação da Clean Architecture utilizando as práticas de Desenvolvimento Orientado a Testes (TDD), BLoC (Business Logic Component) e Cubit. Além disso, o projeto também aborda a realização de requisições HTTP para interação com serviços externos.

## Objetivo

O objetivo deste projeto é fornecer um exemplo básico de como organizar um aplicativo usando a Clean Architecture, uma abordagem que visa separar as responsabilidades de diferentes camadas do sistema. A aplicação inclui a implementação de testes automatizados para garantir a qualidade do código e a manutenção da integridade ao longo do tempo.

## Estrutura do Projeto

O projeto está estruturado em várias camadas, cada uma com uma responsabilidade específica:

- **Presentation**: Constituida pela interface do usuário, Blocs e Cubits

- **Domain**: Constituida pela Entidade central da aplicação e seus casos de uso com interfaces do repository.

- **Data**: Camada que lida com a obtenção e armazenamento de dados. Aqui, as chamadas de API HTTP e o acesso a bancos de dados são implementados.

- **Core**: Este módulo contém exceções e classes utilitárias que são compartilhadas por todas as outras camadas.
