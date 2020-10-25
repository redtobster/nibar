const render = ({ output }) => {
  if (typeof output === "undefined") return null;
  const connected = output.connected;
  const name = output.name;
  const left = output.left;
  const right = output.right;
  if (connected !== "1") return null;
  return <div>{output.name} {output.left}%(L) {output.right}%(R)</div>;
};

export default render;
