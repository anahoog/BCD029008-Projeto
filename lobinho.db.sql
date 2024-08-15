BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "Contato" (
	"idContato"	INTEGER,
	"telefone"	TEXT,
	"email"	TEXT,
	PRIMARY KEY("idContato" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Pessoa" (
	"cpf"	TEXT,
	"nome"	TEXT NOT NULL,
	"dataNasc"	TEXT NOT NULL,
	"endereco"	TEXT NOT NULL,
	"Contato_idContato"	INTEGER NOT NULL,
	FOREIGN KEY("Contato_idContato") REFERENCES "Contato"("idContato"),
	PRIMARY KEY("cpf")
);
CREATE TABLE IF NOT EXISTS "TipoSanguineo" (
	"tipo"	TEXT,
	PRIMARY KEY("tipo")
);
CREATE TABLE IF NOT EXISTS "Jovem" (
	"idJovem"	TEXT,
	"alergias"	TEXT,
	"TipoSanguineo_tipo"	TEXT NOT NULL,
	"recomendacaoPessoa"	INTEGER,
	FOREIGN KEY("idJovem") REFERENCES "Pessoa"("cpf"),
	FOREIGN KEY("TipoSanguineo_tipo") REFERENCES "TipoSanguineo"("tipo"),
	PRIMARY KEY("idJovem")
);
CREATE TABLE IF NOT EXISTS "Responsavel" (
	"idResponsavel"	TEXT,
	"parentesco"	TEXT NOT NULL,
	PRIMARY KEY("idResponsavel"),
	FOREIGN KEY("idResponsavel") REFERENCES "Pessoa"("cpf")
);
CREATE TABLE IF NOT EXISTS "Jovem_Responsavel" (
	"idJovem"	TEXT NOT NULL,
	"idResponsavel"	TEXT NOT NULL,
	FOREIGN KEY("idJovem") REFERENCES "Jovem"("idJovem"),
	FOREIGN KEY("idResponsavel") REFERENCES "Responsavel"("idResponsavel"),
	PRIMARY KEY("idJovem","idResponsavel")
);
CREATE TABLE IF NOT EXISTS "ParticipacaoAtividades" (
	"idParticipacaoAtividades"	INTEGER,
	"data"	TEXT NOT NULL,
	"descricao"	TEXT NOT NULL,
	"Jovem_idJovem"	TEXT NOT NULL,
	PRIMARY KEY("idParticipacaoAtividades" AUTOINCREMENT),
	FOREIGN KEY("Jovem_idJovem") REFERENCES "Jovem"("idJovem")
);
CREATE TABLE IF NOT EXISTS "Progressao" (
	"idProgressao"	INTEGER,
	"dataProgressao"	TEXT NOT NULL,
	"descricao"	TEXT NOT NULL,
	"Jovem_idJovem"	TEXT NOT NULL,
	FOREIGN KEY("Jovem_idJovem") REFERENCES "Jovem"("idJovem"),
	PRIMARY KEY("idProgressao" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "areaDeConhecimento" (
	"idareaDeConhecimento"	INTEGER,
	"conhecimento"	TEXT NOT NULL,
	PRIMARY KEY("idareaDeConhecimento" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Especialidade" (
	"idEspecialidade"	INTEGER,
	"nomeEspecialidade"	TEXT NOT NULL,
	"areaConhecimento"	TEXT NOT NULL,
	"numeroRequisitosTotais"	INTEGER NOT NULL,
	"areaDeConhecimento_idareaDeConhecimento"	INTEGER NOT NULL,
	"nivel"	INTEGER,
	FOREIGN KEY("areaDeConhecimento_idareaDeConhecimento") REFERENCES "areaDeConhecimento"("idareaDeConhecimento"),
	PRIMARY KEY("idEspecialidade" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "NivelEspecialidade" (
	"nivel"	INTEGER,
	"requisitosCumpridos"	INTEGER
);
CREATE TABLE IF NOT EXISTS "Insignia" (
	"id"	INTEGER,
	"nomeInsignia"	TEXT,
	"descricao"	TEXT,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "DistintivoProgressao" (
	"idDistintivoProgressao"	INTEGER,
	"nomeDistintivo"	TEXT NOT NULL,
	"descricaoRequisitos"	TEXT NOT NULL,
	PRIMARY KEY("idDistintivoProgressao" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Jovem_has_DistintivoProgressao" (
	"Jovem_idJovem"	TEXT NOT NULL,
	"DistintivoProgressao_idDistintivoProgressao"	INTEGER NOT NULL,
	PRIMARY KEY("Jovem_idJovem","DistintivoProgressao_idDistintivoProgressao"),
	FOREIGN KEY("DistintivoProgressao_idDistintivoProgressao") REFERENCES "DistintivoProgressao"("idDistintivoProgressao"),
	FOREIGN KEY("Jovem_idJovem") REFERENCES "Jovem"("idJovem")
);
CREATE TABLE IF NOT EXISTS "Jovem_has_Especialidade" (
	"Jovem_idJovem"	TEXT NOT NULL,
	"Especialidade_idEspecialidade"	INTEGER NOT NULL,
	FOREIGN KEY("Jovem_idJovem") REFERENCES "Jovem"("idJovem"),
	FOREIGN KEY("Especialidade_idEspecialidade") REFERENCES "Especialidade"("idEspecialidade"),
	PRIMARY KEY("Jovem_idJovem","Especialidade_idEspecialidade")
);
CREATE TABLE IF NOT EXISTS "Jovem_has_InsigniaInteresseEspecial" (
	"Jovem_idJovem"	TEXT NOT NULL,
	"InsigniaInteresseEspecial_idInsigniaInteresseEspecial"	INTEGER NOT NULL,
	FOREIGN KEY("InsigniaInteresseEspecial_idInsigniaInteresseEspecial") REFERENCES "Insignia"("id"),
	PRIMARY KEY("Jovem_idJovem","InsigniaInteresseEspecial_idInsigniaInteresseEspecial"),
	FOREIGN KEY("Jovem_idJovem") REFERENCES "Jovem"("idJovem")
);
CREATE TABLE IF NOT EXISTS "Requisitos_Insignia" (
	"idRequisitos_Insignia"	INTEGER,
	"Insignia_id"	INTEGER NOT NULL,
	FOREIGN KEY("Insignia_id") REFERENCES "Insignia"("id"),
	PRIMARY KEY("idRequisitos_Insignia" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "Requisito_Especialidade" (
	"Especialidade_idEspecialidade"	INTEGER NOT NULL,
	"Especialidade_areaDeConhecimento_idareaDeConhecimento"	INTEGER NOT NULL,
	PRIMARY KEY("Especialidade_idEspecialidade","Especialidade_areaDeConhecimento_idareaDeConhecimento"),
	FOREIGN KEY("Especialidade_idEspecialidade") REFERENCES "Especialidade"("idEspecialidade"),
	FOREIGN KEY("Especialidade_areaDeConhecimento_idareaDeConhecimento") REFERENCES "areaDeConhecimento"("idareaDeConhecimento")
);
COMMIT;
