import { normalizeComponents } from "./utils"

function getAttributeJson(ref, attributeName) {
    const data = ref.el.getAttribute(attributeName)
    return data ? JSON.parse(data) : {}
}

function detach(node) {
    node.parentNode?.removeChild(node)
}

function insert(target, node, anchor) {
    target.insertBefore(node, anchor || null)
}

function noop() { }

function getSlots(ref) {
    const slots = {}

    for (const slotName in getAttributeJson(ref, "data-slots")) {
        const slot = () => {
            return {
                getElement() {
                    const base64 = getAttributeJson(ref, "data-slots")[slotName]
                    const element = document.createElement("div")
                    element.innerHTML = atob(base64).trim()
                    return element
                },
                update() {
                    detach(this.savedElement)
                    this.savedElement = this.getElement()
                    insert(this.savedTarget, this.savedElement, this.savedAnchor)
                },
                c: noop,
                m(target, anchor) {
                    this.savedTarget = target
                    this.savedAnchor = anchor
                    this.savedElement = this.getElement()
                    insert(this.savedTarget, this.savedElement, this.savedAnchor)
                },
                d(detaching) {
                    if (detaching) detach(this.savedElement)
                },
                l: noop,
            }
        }

        slots[slotName] = [slot]
    }

    return slots
}

function getProps(ref) {
    return {
        ...getAttributeJson(ref, "data-props"),
        live: ref,
        $$slots: getSlots(ref),
        $$scope: {},
    }
}

function findSlotCtx(component) {
    // The default slot always exists if there's a slot set
    // even if no slot is set for the explicit default slot
    return component.$$.ctx.find(ctxElement => ctxElement?.default)
}

export function getHooks(components) {
    components = normalizeComponents(components)

    const SvelteHook = {
        mounted() {
            console.log('SveltHook')
        },

        updated() {
            // Set the props
            this._instance.$set(getProps(this))

            // Set the slots
            const slotCtx = findSlotCtx(this._instance)
            for (const key in slotCtx) {
                slotCtx[key][0]().update()
            }
        },

        destroyed() {

        },
    }

    return {
        SvelteHook,
    }
}
