const render = ({ output }) => {
  if (typeof output === "undefined") return null;
  const count = output.count;
  return <div>Pomo: {count}</div>;
};

export default render;
