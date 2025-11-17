// scripts/export-abis.ts
import fs from "fs";
import path from "path";

/** Add your contract names here (no `.sol` extension) */
const contracts = ["PBALend"]; // e.g. ["PBALend", "PBAToken", "PBAMarket"]

/** Convert PascalCase or camelCase -> CAPITAL_SNAKE_CASE */
function toCapitalSnakeCase(name: string): string {
  return name
    .replace(/([a-z0-9])([A-Z])/g, "$1_$2")
    .replace(/([A-Z]+)([A-Z][a-z0-9]+)/g, "$1_$2")
    .toUpperCase();
}

/** Remove quotes around valid identifier keys (for prettier TS output) */
function unquoteKeys(jsonStr: string) {
  return jsonStr.replace(/"([A-Za-z_$][A-Za-z0-9_$]*)"\s*:/g, "$1:");
}

/** Export ABI for a given contract */
function exportAbi(contractName: string) {
  const foundryPath = path.resolve(`out/${contractName}.sol/${contractName}.json`);
  const outputPath = path.resolve(`frontend/src/abis/${contractName}Abi.ts`);

  if (!fs.existsSync(foundryPath)) {
    console.warn(`⚠️ ABI not found for ${contractName} at ${foundryPath}`);
    return;
  }

  const file = JSON.parse(fs.readFileSync(foundryPath, "utf8"));
  const abi = file.abi;
  const prettyJson = JSON.stringify(abi, null, 2);
  const tsFriendly = unquoteKeys(prettyJson);

  const constName = toCapitalSnakeCase(`${contractName}Abi`);
  const tsContent = `// Auto-generated from Foundry build — DO NOT EDIT
// ${new Date().toISOString()}
export const ${constName} = ${tsFriendly} as const;
`;

  fs.mkdirSync(path.dirname(outputPath), { recursive: true });
  fs.writeFileSync(outputPath, tsContent, "utf8");

  console.log(`✅ Exported ${contractName} ABI → ${outputPath} (${constName})`);
}

/** Run exporter */
function main() {
  console.log("🔄 Exporting Foundry ABIs to frontend...");
  contracts.forEach(exportAbi);
}

main();
