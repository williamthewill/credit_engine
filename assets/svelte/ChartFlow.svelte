<script>
  import { onMount, afterUpdate, onDestroy } from "svelte";
  import chartFlowHook from "js/hooks/chartFlowHook";

  export let live;
  export let redraw;
  export let title;

  // chartFlowHook({ onMount, afterUpdate, onDestroy, live }, redraw, title);
  chartFlowHook({ onMount, afterUpdate, onDestroy, live }, redraw, title);
</script>

<div id="wrapper">
  <div class="col">
    <div
      class="drag-drawflow"
      draggable="true"
      ondragstart="drag(event)"
      data-node="somar"
    >
      <i class="fa fa-solid fa-plus"></i><span> Somar</span>
    </div>
    <div
      class="drag-drawflow"
      draggable="true"
      ondragstart="drag(event)"
      data-node="maiorque"
    >
      <i class="fab fa fa-greater-than"></i><span> Maior que</span>
    </div>
    <div
      class="drag-drawflow"
      draggable="true"
      ondragstart="drag(event)"
      data-node="menorque"
    >
      <i class="fab fa fa-less-than"></i><span> Menor que</span>
    </div>
    <div
      class="drag-drawflow"
      draggable="true"
      ondragstart="drag(event)"
      data-node="iguala"
    >
      <i class="fab fa fa-less-than"></i><span> Igual a</span>
    </div>
    <div
      class="drag-drawflow"
      draggable="true"
      ondragstart="drag(event)"
      data-node="multiplicarpor"
    >
      <i class="fa-solid fa-xmark"></i><span> Multiplicar por</span>
    </div>
    <div
      class="drag-drawflow"
      draggable="true"
      ondragstart="drag(event)"
      data-node="dividirpor"
    >
      <i class="fa-solid fa-divide"></i><span> Dividir por</span>
    </div>
    <div
      class="drag-drawflow"
      draggable="true"
      ondragstart="drag(event)"
      data-node="senao"
    >
      <i class="fa-solid fa-divide"></i><span> Se não</span>
    </div>
    <div
      class="drag-drawflow"
      draggable="true"
      ondragstart="drag(event)"
      data-node="aceitar"
    >
      <i class="fa-solid fa-check"></i><span> Aceitar</span>
    </div>
    <div
      class="drag-drawflow"
      draggable="true"
      ondragstart="drag(event)"
      data-node="rejeitar"
    >
      <i class="fa-solid fa-square-xmark"></i><span> Rejeitar</span>
    </div>
    <div
      class="drag-drawflow"
      draggable="true"
      ondragstart="drag(event)"
      data-node="apidrivendados"
    >
      <i class="fa-solid fa-down-left-and-up-right-to-center"></i><span>
        API Driven Dados</span
      >
    </div>
  </div>
  <div class="col-right">
    <div class="menu">
      <ul>
        <li
          onclick="editor.changeModule('Home'); changeModule(event);"
          class="selected"
        >
          Home
        </li>
        <li onclick="editor.changeModule('Other'); changeModule(event);">
          Other Module
        </li>
      </ul>
    </div>
    <div id="drawflow" ondrop="drop(event)" ondragover="allowDrop(event)">
      <div class="btn-export" onclick="console.log(editor.export())">
        Export
      </div>
      <div class="btn-clear" onclick="editor.clearModuleSelected()">Clear</div>
      <div class="btn-load-data" onclick="showpopup(event)">
        Carrgar Dados
        <div class="modal" style="display:none">
          <div class="modal-content">
            <span class="close" onclick="closemodal(event)">&times;</span>
            <textarea></textarea>
            <button type="button" onclick="connectAPIDriven(event)"
              >Conectar</button
            >
          </div>
        </div>
      </div>
      <div class="btn-publish" phx-click="publish">Publicar</div>
      <div class="btn-lock">
        <i
          id="lock"
          class="fas fa-lock"
          onclick="editor.editor_mode='fixed'; changeMode('lock');"
        >
        </i>
        <i
          id="unlock"
          class="fas fa-lock-open"
          onclick="editor.editor_mode='edit'; changeMode('unlock');"
          style="display:none;"
        >
        </i>
      </div>
      <div class="bar-zoom">
        <i class="fas fa-search-minus" onclick="editor.zoom_out()"></i>
        <i class="fas fa-search" onclick="editor.zoom_reset()"></i>
        <i class="fas fa-search-plus" onclick="editor.zoom_in()"></i>
      </div>
    </div>
  </div>
</div>
