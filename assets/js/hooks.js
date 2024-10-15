import chartFlowHook from "./hooks/chartFlowHook"
import { createLiveJsonHooks } from "live_json"


let Hooks = {
    ...createLiveJsonHooks(),
    ChartFlowHook: chartFlowHook,
}

export default Hooks
