import styles from "./styles.jsx";

const render = ({ output }) => {
  let charging = output.charging;
  let percentage = output.percentage;
  let remaining = output.remaining;
  return (
    <div>
      <div
        style={
          percentage < 10 && charging == false
            ? { color: styles.colors.red }
            : null
        }
      >
	  <span>{charging ? "(C)": null}Batt: {percentage}%</span>
      </div>
    </div>
  );
};

export default render;
