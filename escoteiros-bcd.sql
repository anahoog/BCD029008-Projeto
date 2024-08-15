-- SQLite Script for DB Browser

-- -----------------------------------------------------
-- Schema escoteiros
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Table `Contato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Contato` (
  `idContato` INTEGER PRIMARY KEY AUTOINCREMENT,
  `telefone` TEXT NULL,
  `email` TEXT NULL
);

-- -----------------------------------------------------
-- Table `Pessoa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Pessoa` (
  `cpf` TEXT PRIMARY KEY,
  `nome` TEXT NOT NULL,
  `dataNasc` TEXT NOT NULL,
  `endereco` TEXT NOT NULL,
  `Contato_idContato` INTEGER NOT NULL,
  FOREIGN KEY (`Contato_idContato`) REFERENCES `Contato` (`idContato`)
);

-- -----------------------------------------------------
-- Table `TipoSanguineo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `TipoSanguineo` (
  `tipo` TEXT PRIMARY KEY
);

-- -----------------------------------------------------
-- Table `Jovem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Jovem` (
  `idJovem` TEXT PRIMARY KEY,
  `alergias` TEXT NULL,
  `TipoSanguineo_tipo` TEXT NOT NULL,
  `recomendacaoPessoa` INTEGER NULL,
  FOREIGN KEY (`TipoSanguineo_tipo`) REFERENCES `TipoSanguineo` (`tipo`),
  FOREIGN KEY (`idJovem`) REFERENCES `Pessoa` (`cpf`)
);

-- -----------------------------------------------------
-- Table `Responsavel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Responsavel` (
  `idResponsavel` TEXT PRIMARY KEY,
  `parentesco` TEXT NOT NULL,
  FOREIGN KEY (`idResponsavel`) REFERENCES `Pessoa` (`cpf`)
);

-- -----------------------------------------------------
-- Table `Jovem_Responsavel`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Jovem_Responsavel` (
  `idJovem` TEXT NOT NULL,
  `idResponsavel` TEXT NOT NULL,
  PRIMARY KEY (`idJovem`, `idResponsavel`),
  FOREIGN KEY (`idJovem`) REFERENCES `Jovem` (`idJovem`),
  FOREIGN KEY (`idResponsavel`) REFERENCES `Responsavel` (`idResponsavel`)
);

-- -----------------------------------------------------
-- Table `ParticipacaoAtividades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `ParticipacaoAtividades` (
  `idParticipacaoAtividades` INTEGER PRIMARY KEY AUTOINCREMENT,
  `data` TEXT NOT NULL,
  `descricao` TEXT NOT NULL,
  `Jovem_idJovem` TEXT NOT NULL,
  FOREIGN KEY (`Jovem_idJovem`) REFERENCES `Jovem` (`idJovem`)
);

-- -----------------------------------------------------
-- Table `Progressao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Progressao` (
  `idProgressao` INTEGER PRIMARY KEY AUTOINCREMENT,
  `dataProgressao` TEXT NOT NULL,
  `descricao` TEXT NOT NULL,
  `Jovem_idJovem` TEXT NOT NULL,
  FOREIGN KEY (`Jovem_idJovem`) REFERENCES `Jovem` (`idJovem`)
);

-- -----------------------------------------------------
-- Table `areaDeConhecimento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `areaDeConhecimento` (
  `idareaDeConhecimento` INTEGER PRIMARY KEY AUTOINCREMENT,
  `conhecimento` TEXT NOT NULL
);

-- -----------------------------------------------------
-- Table `Especialidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Especialidade` (
  `idEspecialidade` INTEGER PRIMARY KEY AUTOINCREMENT,
  `nomeEspecialidade` TEXT NOT NULL,
  `areaConhecimento` TEXT NOT NULL,
  `numeroRequisitosTotais` INTEGER NOT NULL,
  `areaDeConhecimento_idareaDeConhecimento` INTEGER NOT NULL,
  `nivel` INTEGER NULL,
  FOREIGN KEY (`areaDeConhecimento_idareaDeConhecimento`) REFERENCES `areaDeConhecimento` (`idareaDeConhecimento`)
);

-- -----------------------------------------------------
-- Table `NivelEspecialidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `NivelEspecialidade` (
  `nivel` INTEGER NULL,
  `requisitosCumpridos` INTEGER NULL
);

-- -----------------------------------------------------
-- Table `Insignia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Insignia` (
  `id` INTEGER PRIMARY KEY AUTOINCREMENT,
  `nomeInsignia` TEXT NULL,
  `descricao` TEXT NULL
);

-- -----------------------------------------------------
-- Table `DistintivoProgressao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `DistintivoProgressao` (
  `idDistintivoProgressao` INTEGER PRIMARY KEY AUTOINCREMENT,
  `nomeDistintivo` TEXT NOT NULL,
  `descricaoRequisitos` TEXT NOT NULL
);

-- -----------------------------------------------------
-- Table `Jovem_has_DistintivoProgressao`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Jovem_has_DistintivoProgressao` (
  `Jovem_idJovem` TEXT NOT NULL,
  `DistintivoProgressao_idDistintivoProgressao` INTEGER NOT NULL,
  PRIMARY KEY (`Jovem_idJovem`, `DistintivoProgressao_idDistintivoProgressao`),
  FOREIGN KEY (`Jovem_idJovem`) REFERENCES `Jovem` (`idJovem`),
  FOREIGN KEY (`DistintivoProgressao_idDistintivoProgressao`) REFERENCES `DistintivoProgressao` (`idDistintivoProgressao`)
);

-- -----------------------------------------------------
-- Table `Jovem_has_Especialidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Jovem_has_Especialidade` (
  `Jovem_idJovem` TEXT NOT NULL,
  `Especialidade_idEspecialidade` INTEGER NOT NULL,
  PRIMARY KEY (`Jovem_idJovem`, `Especialidade_idEspecialidade`),
  FOREIGN KEY (`Jovem_idJovem`) REFERENCES `Jovem` (`idJovem`),
  FOREIGN KEY (`Especialidade_idEspecialidade`) REFERENCES `Especialidade` (`idEspecialidade`)
);

-- -----------------------------------------------------
-- Table `Jovem_has_InsigniaInteresseEspecial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Jovem_has_InsigniaInteresseEspecial` (
  `Jovem_idJovem` TEXT NOT NULL,
  `InsigniaInteresseEspecial_idInsigniaInteresseEspecial` INTEGER NOT NULL,
  PRIMARY KEY (`Jovem_idJovem`, `InsigniaInteresseEspecial_idInsigniaInteresseEspecial`),
  FOREIGN KEY (`Jovem_idJovem`) REFERENCES `Jovem` (`idJovem`),
  FOREIGN KEY (`InsigniaInteresseEspecial_idInsigniaInteresseEspecial`) REFERENCES `Insignia` (`id`)
);

-- -----------------------------------------------------
-- Table `Requisitos_Insignia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Requisitos_Insignia` (
  `idRequisitos_Insignia` INTEGER PRIMARY KEY AUTOINCREMENT,
  `Insignia_id` INTEGER NOT NULL,
  FOREIGN KEY (`Insignia_id`) REFERENCES `Insignia` (`id`)
);

-- -----------------------------------------------------
-- Table `Requisito_Especialidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Requisito_Especialidade` (
  `Especialidade_idEspecialidade` INTEGER NOT NULL,
  `Especialidade_areaDeConhecimento_idareaDeConhecimento` INTEGER NOT NULL,
  PRIMARY KEY (`Especialidade_idEspecialidade`, `Especialidade_areaDeConhecimento_idareaDeConhecimento`),
  FOREIGN KEY (`Especialidade_idEspecialidade`) REFERENCES `Especialidade` (`idEspecialidade`),
  FOREIGN KEY (`Especialidade_areaDeConhecimento_idareaDeConhecimento`) REFERENCES `areaDeConhecimento` (`idareaDeConhecimento`)
);
