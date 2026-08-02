# 2026-08-02T09:51:39.428500429
import vitis

client = vitis.create_client()
client.set_workspace(path="hasitha_optimization")

status = client.add_platform_repos(platform=["/home/cse/Documents/WorkSpaces/vaddWS/kv260_custom"])

comp = client.create_hls_component(name = "hasitha_hls_component",cfg_file = ["hls_config.cfg"],template = "empty_hls_component")

comp = client.get_component(name="hasitha_hls_component")
comp.run(operation="C_SIMULATION")

cfg = client.get_config_file(path="/home/cse/Documents/WorkSpaces/vaddWS/hasitha_optimization/hasitha_hls_component/hls_config.cfg")

cfg.set_values(key="syn.file", values=["/home/cse/Documents/WorkSpaces/vaddWS/dylan-hls/mine.cpp", "/home/cse/Documents/WorkSpaces/vaddWS/baseline/sha256.cpp", "/home/cse/Documents/WorkSpaces/vaddWS/baseline/sha256.h"])

cfg.set_values(key="syn.blackbox.file", values=[])

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

cfg.set_value(section="hls", key="clock", value="200MHz")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

cfg.set_values(key="syn.file", values=["/home/cse/Documents/WorkSpaces/vaddWS/dylan-hls/mine.cpp", "/home/cse/Documents/WorkSpaces/vaddWS/baseline/sha256.h"])

cfg.set_values(key="syn.blackbox.file", values=[])

cfg.set_values(key="syn.file", values=["/home/cse/Documents/WorkSpaces/vaddWS/dylan-hls/mine.cpp"])

cfg.set_values(key="syn.blackbox.file", values=[])

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp = client.create_app_component(name="miner_host",platform = "$COMPONENT_LOCATION/../../kv260_custom/export/kv260_custom/kv260_custom.xpfm",domain = "linux_psu_cortexa53")

comp = client.get_component("miner_host")

status = comp.set_sysroot(sysroot="/home/cse/Documents/WorkSpaces/vaddWS/xilinx-zynqmp-common-v2025.2/sysroots/cortexa72-cortexa53-amd-linux")

proj = client.create_sys_project(name="miner_system_sha256", platform="$COMPONENT_LOCATION/../../kv260_custom/export/kv260_custom/kv260_custom.xpfm", template="empty_accelerated_application" , build_output_type="xsa")

proj = client.get_sys_project(name="miner_system_sha256")

status = proj.add_container(name="miner_binary_container_1")

proj = proj.add_component(name="hasitha_hls_component", container_name="miner_binary_container_1")

proj = proj.add_component(name="miner_host")

comp = client.get_component(name="miner_host")
comp.build(target="x86sim")

comp.build(target="hw")

comp.build(target="hw")

comp.build(target="hw")

comp.build(target="hw")

comp = client.get_component("/home/cse/Documents/WorkSpaces/vaddWS/hasitha_optimization/miner_host")

status = comp.update_sysroot_toolchain(sysroot_toolchain="/home/cse/Documents/WorkSpaces/vaddWS/xilinx-zynqmp-common-v2025.2/sysroots/cortexa72-cortexa53-amd-linux")

comp = client.get_component("/home/cse/Documents/WorkSpaces/vaddWS/hasitha_optimization/miner_host")

status = comp.use_sysroot_toolchain(use_sysroot_toolchain=True)

comp = client.get_component("/home/cse/Documents/WorkSpaces/vaddWS/hasitha_optimization/miner_host")

status = comp.update_sysroot_toolchain(sysroot_toolchain="/home/cse")

comp = client.get_component("/home/cse/Documents/WorkSpaces/vaddWS/hasitha_optimization/miner_host")

status = comp.use_sysroot_toolchain(use_sysroot_toolchain=False)

comp.build(target="hw")

comp.set_app_config(key = "USER_COMPILE_SOURCES", values = ["/home/cse/Documents/WorkSpaces/vaddWS/hasitha_optimization/miner_host/cmdlineparser.cpp", "/home/cse/Documents/WorkSpaces/vaddWS/hasitha_optimization/miner_host/cmdlineparser.h", "/home/cse/Documents/WorkSpaces/vaddWS/hasitha_optimization/miner_host/logger.cpp", "/home/cse/Documents/WorkSpaces/vaddWS/hasitha_optimization/miner_host/logger.h", "/home/cse/Documents/WorkSpaces/vaddWS/hasitha_optimization/miner_host/sha256_miner_host.cpp"])

comp.set_app_config(key = "USER_COMPILE_SOURCES", values = ["/home/cse/Documents/WorkSpaces/vaddWS/hasitha_optimization/miner_host/cmdlineparser.cpp", "/home/cse/Documents/WorkSpaces/vaddWS/hasitha_optimization/miner_host/cmdlineparser.h", "/home/cse/Documents/WorkSpaces/vaddWS/hasitha_optimization/miner_host/logger.cpp", "/home/cse/Documents/WorkSpaces/vaddWS/hasitha_optimization/miner_host/sha256_miner_host.cpp"])

comp.set_app_config(key = "USER_COMPILE_SOURCES", values = ["/home/cse/Documents/WorkSpaces/vaddWS/hasitha_optimization/miner_host/cmdlineparser.cpp", "/home/cse/Documents/WorkSpaces/vaddWS/hasitha_optimization/miner_host/logger.cpp", "/home/cse/Documents/WorkSpaces/vaddWS/hasitha_optimization/miner_host/sha256_miner_host.cpp"])

comp.set_app_config(key = "USER_COMPILE_SOURCES", values = ["/home/cse/Documents/WorkSpaces/vaddWS/hasitha_optimization/miner_host/cmdlineparser.cpp", "/home/cse/Documents/WorkSpaces/vaddWS/hasitha_optimization/miner_host/sha256_miner_host.cpp"])

comp.set_app_config(key = "USER_COMPILE_SOURCES", values = ["/home/cse/Documents/WorkSpaces/vaddWS/hasitha_optimization/miner_host/cmdlineparser.cpp", "/home/cse/Documents/WorkSpaces/vaddWS/hasitha_optimization/miner_host/sha256_miner_host.cpp"])

comp.set_app_config(key = "USER_COMPILE_SOURCES", values = ["/home/cse/Documents/WorkSpaces/vaddWS/hasitha_optimization/miner_host/cmdlineparser.cpp", "/home/cse/Documents/WorkSpaces/vaddWS/hasitha_optimization/miner_host/sha256_miner_host.cpp", "/home/cse/Documents/WorkSpaces/vaddWS/hasitha_optimization/miner_host/logger.cpp"])

comp.set_app_config(key = "USER_HEADER_SOURCES", values = ["/home/cse/Documents/WorkSpaces/vaddWS/hasitha_optimization/miner_host/cmdlineparser.h"])

comp.set_app_config(key = "USER_HEADER_SOURCES", values = ["/home/cse/Documents/WorkSpaces/vaddWS/hasitha_optimization/miner_host/cmdlineparser.h", "/home/cse/Documents/WorkSpaces/vaddWS/hasitha_optimization/miner_host/logger.h"])

comp.build(target="hw")

comp.build(target="hw")

comp.build(target="hw")

vitis.dispose()

