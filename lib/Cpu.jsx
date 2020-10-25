import styles from "./styles.jsx";

const render = ({ output }) => {
  if (typeof output === "undefined") return null;
  return (
    <div style={output.loadAverage > 75 ? { color: styles.colors.red } : null}>
	<span>Cpu: {output.loadAverage}%</span>
    </div>
  );
};

export default render;
