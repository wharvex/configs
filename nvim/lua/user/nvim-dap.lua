local status_ok, dap = pcall(require, "dap")
if not status_ok then
	return
end

local py_status_ok, dap_python = pcall(require, "dap-python")
if not py_status_ok then
	return
end

dap_python.setup("/usr/bin/python")

dap.configurations.java = {
	{
		type = "java",
		request = "attach",
		name = "Attach",
	},
}
