const render = ({ output }) => {
  if (typeof output === "undefined") return null;
  const status = output.status;
  const ssid = output.ssid;
  if (status === "inactive") return <div>Not connected</div>;
  return <div>Wifi: {output.ssid}</div>;
};

export default render;
