export default chartFlowHook = (Svelte, ...props) => {
  console.log("chartFlowHook Hook staterd");

  [redraw, title] = props;
  let live = Svelte.live;

  console.log(redraw)
  console.log(title)

  debounce = function (func, wait, immediate) {
    var timeout;
    return function () {
      var context = this, args = arguments;
      var later = function () {
        timeout = null;
        if (!immediate) func.apply(context, args);
      };
      var callNow = immediate && !timeout;
      clearTimeout(timeout);
      timeout = setTimeout(later, wait);
      if (callNow) func.apply(context, args);
    };
  };

  Svelte.onMount(() => {
    console.log('onMount')
    var id = document.getElementById("drawflow");
    window.editor = new Drawflow(id);
    editor.reroute = true;
    editor.reroute_fix_curvature = true;
    editor.force_first_input = false;

    editor.start();
    //     editor.import({
    //        drawflow: {
    //          Other: {
    //            data: {
    //              "16": {
    //                id: 16,
    //                name: "rejeitar",
    //                data: {},
    //                class: "rejeitar",
    //                html:
    //                  "\n        <div>\n          <div class=\"title-box\"><i class=\"fa-solid fa-square-xmark\"></i> Rejeitar</div>\n        </div>\n        ",
    //                typenode: false,
    //                inputs: {
    //                  input_1: {
    //                    connections: [
    //                      {
    //                        node: "17",
    //                        input: "output_1"
    //                      }
    //                    ]
    //                  }
    //                },
    //                outputs: {},
    //                pos_x: 868,
    //                pos_y: 419
    //              },
    //              "17": {
    //                id: 17,
    //                name: "iguala",
    //                data: {
    //                  number: ""
    //                },
    //                class: "iguala",
    //                html:
    //                  "\n          <div style=\"height:236px\">\n            <div class=\"title-box\"><i class=\"fab fa fa-less-than\"></i> Igual a</div>\n            <div class=\"box\">\n              <input type=\"text\" df-number placeholder=\"Adicione um número\"><br><br>\n            </div>\n            <div class=\"losango\"></div>\n          </div>\n          ",
    //                typenode: false,
    //                inputs: {
    //                  input_1: {
    //                    connections: [
    //                      {
    //                        node: "18",
    //                        input: "output_1"
    //                      }
    //                    ]
    //                  }
    //                },
    //                outputs: {
    //                  output_1: {
    //                    connections: [
    //                      {
    //                        node: "16",
    //                        output: "input_1"
    //                      }
    //                    ]
    //                  }
    //                },
    //                pos_x: 548,
    //                pos_y: 326
    //              },
    //              "18": {
    //                id: 18,
    //                name: "somar",
    //                data: {
    //                  number: ""
    //                },
    //                class: "somar",
    //                html:
    //                  "\n        <div>\n          <div class=\"title-box\"><i class=\"fab fa fa-plus\"></i> Somar</div>\n          <div class=\"box\">\n            <input type=\"text\" df-number placeholder=\"Adicione um número\"><br><br>\n          </div>\n        </div>\n        ",
    //                typenode: false,
    //                inputs: {
    //                  input_1: {
    //                    connections: []
    //                  }
    //                },
    //                outputs: {
    //                  output_1: {
    //                    connections: [
    //                      {
    //                        node: "17",
    //                        output: "input_1"
    //                      }
    //                    ]
    //                  }
    //                },
    //                pos_x: 241,
    //                pos_y: 377
    //              }
    //            }
    //          },
    //          Home: {
    //            data: {
    //              "14": {
    //                id: 14,
    //                name: "maiorque",
    //                data: {
    //                  number: ""
    //                },
    //                class: "maiorque",
    //                html:
    //                  "\n        <div style=\"height:236px\">\n          <div class=\"title-box\"><i class=\"fab fa fa-greater-than\"></i> Maior que</div>\n          <div class=\"box\">\n            <input type=\"text\" df-number placeholder=\"Adicione um número\"><br><br>\n          </div>\n          <div class=\"losango\"></div>\n        </div>\n        ",
    //                typenode: false,
    //                inputs: {
    //                  input_1: {
    //                    connections: [
    //                      {
    //                        node: "15",
    //                        input: "output_1"
    //                      }
    //                    ]
    //                  }
    //                },
    //                outputs: {
    //                  output_1: {
    //                    connections: []
    //                  }
    //                },
    //                pos_x: 793,
    //                pos_y: 223
    //              },
    //              "15": {
    //                id: 15,
    //                name: "multiplicarpor",
    //                data: {
    //                  number: ""
    //                },
    //                class: "multiplicarpor",
    //                html:
    //                  "\n        <div>\n          <div class=\"title-box\"><i class=\"fa-solid fa-xmark\"></i> Multiplicar por</div>\n          <div class=\"box\">\n            <input type=\"text\" df-number placeholder=\"Adicione um número\"><br><br>\n          </div>\n        </div>\n        ",
    //                typenode: false,
    //                inputs: {
    //                  input_1: {
    //                    connections: []
    //                  }
    //                },
    //                outputs: {
    //                  output_1: {
    //                    connections: [
    //                      {
    //                        node: "14",
    //                        output: "input_1"
    //                      }
    //                    ]
    //                  }
    //                },
    //                pos_x: 542,
    //                pos_y: 276
    //              }
    //            }
    //          }
    //        }
    //      }
    // )
    live.pushEvent("get_data_to_import", {}, ({ data_to_import }) => {
      editor.import(data_to_import);
    });

    live.pushEvent("api_driven", {}, ({ data }) => {
      window.apiDrivenData = data;
    });

    saveData = () => {
      console.log('Saving...')

      const data_to_save = editor.export();

      live.pushEvent("save_data", { data_to_save }, ({ was_saved }) => {
        console.log('Was saved', was_saved)
      });

    }

    // Events!
    editor.on('nodeCreated', debounce(e => { saveData() }, 500, true))

    editor.on('nodeRemoved', debounce(e => { saveData() }, 500, true))

    editor.on('nodeSelected', function (id) {
      console.log("Node selected " + id);
    })

    editor.on('moduleCreated', debounce(e => { saveData() }, 500, true))

    editor.on('moduleChanged', function (name) {
      console.log("Module Changed " + name);
    })

    editor.on('connectionCreated', debounce(e => { saveData() }, 500, true))

    editor.on('connectionRemoved', debounce(e => { saveData() }, 500, true))

    editor.on('zoom', function (zoom) {
      console.log('Zoom level ' + zoom);
    })

    editor.on('translate', debounce(e => {
      console.log(e)
      saveData()
    }, 500, true))

    editor.on('addReroute', function (id) {
      console.log("Reroute added " + id);
    })

    editor.on('removeReroute', function (id) {
      console.log("Reroute removed " + id);
    })

    editor.on('nodeMoved', debounce(e => { saveData() }, 500, true));

    editor.on('click', debounce(e => {
      // args = "--request POST \
      // --url https://platform.datarisk.io/api/prediction/income/v1 \
      // --header 'Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Ik9aZTQwdVFNdWRXUm9sd09LT1RzNSJ9.eyJodHRwczovL2RhdGFyaXNrLmlvL3JlcXVlc3QtaXAiOiIyMC4xMjIuMjQwLjMyIiwiaHR0cHM6Ly9kYXRhcmlzay5pby9jbGllbnQtaWQiOiJwUUkyQXJ0T0VyZDA5OUQ5Q0g0NElNTkRHcmRuQmE4eiIsImh0dHBzOi8vZGF0YXJpc2suaW8vY29tcGFueS1lbWFpbCI6IndpbGxpYW1tdWxsZXItY29kZUBob3RtYWlsLmNvbSIsImh0dHBzOi8vZGF0YXJpc2suaW8vcmVzZXQtcXVvdGEiOiJOZXZlciIsImh0dHBzOi8vZGF0YXJpc2suaW8vcXVvdGEtYW1vdW50IjoiMTAiLCJodHRwczovL2RhdGFyaXNrLmlvL3N1YnNjcmlwdGlvbi10eXBlIjoiRnVsbCIsImh0dHBzOi8vZGF0YXJpc2suaW8vdXNlci1zdWJzY3JpcHRpb24iOiJhdXRoMHw2NjU2MjczNWE2NjY2NTEyZTM4OTg2YTEiLCJodHRwczovL2RhdGFyaXNrLmlvL2NvbXBhbnlSZWdpc3RyYXRpb25OdW1iZXIiOiIxMjM0NTY3ODkiLCJpc3MiOiJodHRwczovL2Rldi1xbGNiMGxpaHZsMG16OG8yLnVzLmF1dGgwLmNvbS8iLCJzdWIiOiJwUUkyQXJ0T0VyZDA5OUQ5Q0g0NElNTkRHcmRuQmE4ekBjbGllbnRzIiwiYXVkIjoiaHR0cHM6Ly9wbGF0Zm9ybS5zdGFnaW5nLmRhdGFyaXNrLmlvL2FwaS8iLCJpYXQiOjE3MTY5MjI0MjIsImV4cCI6MTcxNzAwODgyMiwic2NvcGUiOiJjcmVhdGU6YjJiL2VtcGxveW1lbnQtc3RhYmlsaXR5LXNjb3JlX3YxIGNyZWF0ZTpiMmIvaW5jb21lLXByZWRpY3Rpb25fdjEiLCJndHkiOiJjbGllbnQtY3JlZGVudGlhbHMiLCJhenAiOiJwUUkyQXJ0T0VyZDA5OUQ5Q0g0NElNTkRHcmRuQmE4eiIsInBlcm1pc3Npb25zIjpbImNyZWF0ZTpiMmIvZW1wbG95bWVudC1zdGFiaWxpdHktc2NvcmVfdjEiLCJjcmVhdGU6YjJiL2luY29tZS1wcmVkaWN0aW9uX3YxIl19.CUU5j91IxnZxg7V4zVkKYyg-K7PUbWkCP76DCBmW1F6bctD2uS47hP_ITlytBvHHEzLfw_htynmpq7IsRAvtFZpCGnhjw1e_BU5NgXCk49PKDmOI4MAZLmEdgAvbrzCLVNEtxHEhz-oHjIin5GF20d_qIhEleUVuwefcyNU1PTWxsrxl8rRL0bQjy8GCN_NY-rJ2EvQAoraj2rm4kdHZUpOfwsMiZ49WFhGNus4xfeAi6pRbkqnezvmvDrUlZG45PldqD_v9LqjTJkzID7yHvW7EQ6ma0p8JSGIos7YpQIr75fWuxw0Kq-nf0b_8PQNdU0S49pklBuUXEF11ZdjYag' \
      // --header 'Content-Type: application/json' \
      // --data '{ 'cpf': '84342013991'}'"

      // this.pushEvent("data_driven", { args }, ({ resp }) => {
      //   console.log('connected', resp)
      // });

    }, 500, true));

    /* DRAG EVENT */

    /* Mouse and Touch Actions */

    var elements = document.getElementsByClassName('drag-drawflow');
    // for (var i = 0; i < elements.length; i++) {
    //   elements[i].addEventListener('touchend', window.drop, false);
    //   elements[i].addEventListener('touchmove', positionMobile, false);
    //   elements[i].addEventListener('touchstart', window.drag, false);
    // }

    console.log(elements)
    Array.from(elements).forEach(function (element) {
      element.addEventListener('touchend', window.drop, false);
      element.addEventListener('touchmove', positionMobile, false);
      element.addEventListener('touchstart', window.drag, false);
    });

    var mobile_item_selec = '';
    var mobile_last_move = null;
    function positionMobile(ev) {
      mobile_last_move = ev;
    }

    window.allowDrop = function (ev) {
      ev.preventDefault();
    }

    window.drag = function (ev) {
      if (ev.type === "touchstart") {
        mobile_item_selec = ev.target.closest(".drag-drawflow").getAttribute('data-node');
      } else {
        ev.dataTransfer.setData("node", ev.target.getAttribute('data-node'));
      }
    }

    window.drop = function (ev) {
      if (ev.type === "touchend") {
        var parentdrawflow = document.elementFromPoint(mobile_last_move.touches[0].clientX, mobile_last_move.touches[0].clientY).closest("drawflow");
        if (parentdrawflow != null) {
          addNodeToDrawFlow(mobile_item_selec, mobile_last_move.touches[0].clientX, mobile_last_move.touches[0].clientY);
        }
        mobile_item_selec = '';
      } else {
        ev.preventDefault();
        var data = ev.dataTransfer.getData("node");
        addNodeToDrawFlow(data, ev.clientX, ev.clientY);
      }

    }

    function addNodeToDrawFlow(name, pos_x, pos_y) {
      if (editor.editor_mode === 'fixed') {
        return false;
      }
      pos_x = pos_x * (editor.precanvas.clientWidth / (editor.precanvas.clientWidth * editor.zoom)) - (editor.precanvas.getBoundingClientRect().x * (editor.precanvas.clientWidth / (editor.precanvas.clientWidth * editor.zoom)));
      pos_y = pos_y * (editor.precanvas.clientHeight / (editor.precanvas.clientHeight * editor.zoom)) - (editor.precanvas.getBoundingClientRect().y * (editor.precanvas.clientHeight / (editor.precanvas.clientHeight * editor.zoom)));

      switch (name) {
        case 'somar':
          var somar = `
            <div>
              <div class="title-box"><i class="fab fa fa-plus"></i> Somar</div>
              <div class="box">
                <input type="text" df-number placeholder="Adicione um número"><br><br>
              </div>
            </div>
            `;
          editor.addNode('somar', 1, 1, pos_x, pos_y, 'somar', { "number": '' }, somar);
          break;
        case 'maiorque':
          var maiorque = `
            <div style="height:236px">
              <div class="title-box"><i class="fab fa fa-greater-than"></i> Maior que</div>
              <div class="box">
                <input type="text" df-number placeholder="Adicione um número"><br><br>
              </div>
              <div class="losango"></div>
            </div>
            `;
          editor.addNode('maiorque', 1, 2, pos_x, pos_y, 'maiorque', { "number": '' }, maiorque);
          break;
        case 'menorque':
          var menorque = `
              <div style="height:236px">
                <div class="title-box"><i class="fab fa fa-less-than"></i> Menor que</div>
                <div class="box">
                  <input type="text" df-number placeholder="Adicione um número"><br><br>
                </div>
                <div class="losango"></div>
              </div>
              `;
          editor.addNode('menorque', 1, 2, pos_x, pos_y, 'menorque', { "number": '' }, menorque);
          break;
        case 'iguala':
          var iguala = `
              <div style="height:236px">
                <div class="title-box"><i class="fab fa fa-less-than"></i> Igual a</div>
                <div class="box">
                  <input type="text" df-text placeholder="Adicione um valor"><br><br>
                </div>
                <div class="losango"></div>
              </div>
              `;
          editor.addNode('iguala', 1, 2, pos_x, pos_y, 'iguala', { "text": '' }, iguala);
          break;
        case 'multiplicarpor':
          var multiplicarpor = `
            <div>
              <div class="title-box"><i class="fa-solid fa-xmark"></i> Multiplicar por</div>
              <div class="box">
                <input type="text" df-number placeholder="Adicione um número"><br><br>
              </div>
            </div>
            `;
          editor.addNode('multiplicarpor', 1, 1, pos_x, pos_y, 'multiplicarpor', { "number": '' }, multiplicarpor);
          break;
        case 'dividirpor':
          var dividirpor = `
            <div>
              <div class="title-box"><i class="fa-solid fa-divide"></i> Dividir por</div>
              <div class="box">
                <input type="text" df-number placeholder="Adicione um número"><br><br>
              </div>
            </div>
            `;
          editor.addNode('dividirpor', 1, 1, pos_x, pos_y, 'dividirpor', { "number": '' }, dividirpor);
          break;
        case 'senao':
          var senao = `
            <div>
              <div class="title-box"><i class="fa-solid fa-divide"></i> Se não</div>
            </div>
            `;
          editor.addNode('senao', 1, 1, pos_x, pos_y, 'senao', {}, senao);
          break;
        case 'aceitar':
          var aceitar = `
            <div>
              <div class="title-box"><i class="fa-solid fa-check"></i></i> Aceitar</div>
            </div>
            `;
          editor.addNode('aceitar', 1, 0, pos_x, pos_y, 'aceitar', {}, aceitar);
          break;
        case 'rejeitar':
          var rejeitar = `
            <div>
              <div class="title-box"><i class="fa-solid fa-square-xmark"></i> Rejeitar</div>
            </div>
            `;
          editor.addNode('rejeitar', 1, 0, pos_x, pos_y, 'rejeitar', {}, rejeitar);
          break;
        case 'apidrivendados':
          const container = document.createElement('div');
          const titleBox = document.createElement('div');
          titleBox.setAttribute('class', 'title-box')

          const icon = document.createElement('i');
          icon.setAttribute('class', 'fa-solid fa-down-left-and-up-right-to-center');

          titleBox.appendChild(icon);
          titleBox.innerHTML = 'API Driven';

          container.appendChild(titleBox);

          const select = document.createElement('select');
          select.setAttribute('class', 'proList');
          select.setAttribute('df-option', '');

          productList = window.apiDrivenData;

          productList.forEach(renderProductList);

          function renderProductList(element, index, arr) {
            let option = document.createElement('option');
            option.setAttribute('class', 'item');
            option.setAttribute('value', element);

            select.appendChild(option);

            option.innerHTML = option.innerHTML + element;
          }

          container.appendChild(select);

          const apidrivendados = container.outerHTML

          editor.addNode('apidrivendados', 1, 1, pos_x, pos_y, 'apidrivendados', { 'option': 'Idade' }, apidrivendados);
          break;

        default:
      }
    }


    var transform = '';
    window.showpopup = function (e) {
      // e.target.closest(".drawflow-node").style.zIndex = "9999";
      if (e.target.children[0]) {
        e.target.children[0].style.display = "block";
        //document.getElementById("modalfix").style.display = "block";

        //e.target.children[0].style.transform = 'translate('+translate.x+'px, '+translate.y+'px)';
        transform = editor.precanvas.style.transform;
        editor.precanvas.style.transform = '';
        editor.precanvas.style.left = editor.canvas_x + 'px';
        editor.precanvas.style.top = editor.canvas_y + 'px';
        console.log(transform);

        //e.target.children[0].style.top  =  -editor.canvas_y - editor.container.offsetTop +'px';
        //e.target.children[0].style.left  =  -editor.canvas_x  - editor.container.offsetLeft +'px';
      }
    }

    window.closemodal = function (e) {
      // e.target.closest(".drawflow-node").style.zIndex = "2";
      e.target.parentElement.parentElement.style.display = "none";
      // document.getElementById("modalfix").style.display = "none";
      editor.precanvas.style.transform = transform;
      editor.precanvas.style.left = '0px';
      editor.precanvas.style.top = '0px';
    }

    window.connectAPIDriven = (e) => {
      args = "--request POST \
          --url https://platform.datarisk.io/api/prediction/income/v1 \
          --header 'Authorization: Bearer eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCIsImtpZCI6Ik9aZTQwdVFNdWRXUm9sd09LT1RzNSJ9.eyJodHRwczovL2RhdGFyaXNrLmlvL3JlcXVlc3QtaXAiOiIyMC4xMjIuMjQwLjMyIiwiaHR0cHM6Ly9kYXRhcmlzay5pby9jbGllbnQtaWQiOiJwUUkyQXJ0T0VyZDA5OUQ5Q0g0NElNTkRHcmRuQmE4eiIsImh0dHBzOi8vZGF0YXJpc2suaW8vY29tcGFueS1lbWFpbCI6IndpbGxpYW1tdWxsZXItY29kZUBob3RtYWlsLmNvbSIsImh0dHBzOi8vZGF0YXJpc2suaW8vcmVzZXQtcXVvdGEiOiJOZXZlciIsImh0dHBzOi8vZGF0YXJpc2suaW8vcXVvdGEtYW1vdW50IjoiMTAiLCJodHRwczovL2RhdGFyaXNrLmlvL3N1YnNjcmlwdGlvbi10eXBlIjoiRnVsbCIsImh0dHBzOi8vZGF0YXJpc2suaW8vdXNlci1zdWJzY3JpcHRpb24iOiJhdXRoMHw2NjU2MjczNWE2NjY2NTEyZTM4OTg2YTEiLCJodHRwczovL2RhdGFyaXNrLmlvL2NvbXBhbnlSZWdpc3RyYXRpb25OdW1iZXIiOiIxMjM0NTY3ODkiLCJpc3MiOiJodHRwczovL2Rldi1xbGNiMGxpaHZsMG16OG8yLnVzLmF1dGgwLmNvbS8iLCJzdWIiOiJwUUkyQXJ0T0VyZDA5OUQ5Q0g0NElNTkRHcmRuQmE4ekBjbGllbnRzIiwiYXVkIjoiaHR0cHM6Ly9wbGF0Zm9ybS5zdGFnaW5nLmRhdGFyaXNrLmlvL2FwaS8iLCJpYXQiOjE3MTY5MjI0MjIsImV4cCI6MTcxNzAwODgyMiwic2NvcGUiOiJjcmVhdGU6YjJiL2VtcGxveW1lbnQtc3RhYmlsaXR5LXNjb3JlX3YxIGNyZWF0ZTpiMmIvaW5jb21lLXByZWRpY3Rpb25fdjEiLCJndHkiOiJjbGllbnQtY3JlZGVudGlhbHMiLCJhenAiOiJwUUkyQXJ0T0VyZDA5OUQ5Q0g0NElNTkRHcmRuQmE4eiIsInBlcm1pc3Npb25zIjpbImNyZWF0ZTpiMmIvZW1wbG95bWVudC1zdGFiaWxpdHktc2NvcmVfdjEiLCJjcmVhdGU6YjJiL2luY29tZS1wcmVkaWN0aW9uX3YxIl19.CUU5j91IxnZxg7V4zVkKYyg-K7PUbWkCP76DCBmW1F6bctD2uS47hP_ITlytBvHHEzLfw_htynmpq7IsRAvtFZpCGnhjw1e_BU5NgXCk49PKDmOI4MAZLmEdgAvbrzCLVNEtxHEhz-oHjIin5GF20d_qIhEleUVuwefcyNU1PTWxsrxl8rRL0bQjy8GCN_NY-rJ2EvQAoraj2rm4kdHZUpOfwsMiZ49WFhGNus4xfeAi6pRbkqnezvmvDrUlZG45PldqD_v9LqjTJkzID7yHvW7EQ6ma0p8JSGIos7YpQIr75fWuxw0Kq-nf0b_8PQNdU0S49pklBuUXEF11ZdjYag' \
          --header 'Content-Type: application/json' \
          --data '{ 'cpf': '84342013991'}'"

      const curl = e.target.closest('.modal-content').getElementsByTagName('textarea')[0].value

      live.pushEvent("data_driven", { args: curl }, ({ resp }) => {
        console.log('connected', resp)
      });
    }

    window.changeModule = function (event) {
      var all = document.querySelectorAll(".menu ul li");
      for (var i = 0; i < all.length; i++) {
        all[i].classList.remove('selected');
      }
      event.target.classList.add('selected');
    }

    window.changeMode = function (option) {
      if (option == 'lock') {
        lock.style.display = 'none';
        unlock.style.display = 'block';
      } else {
        lock.style.display = 'block';
        unlock.style.display = 'none';
      }

    }
  });

  Svelte.afterUpdate(e => {
    console.log('afterUpdate')
    live.pushEvent("get_data_to_import", {}, ({ data_to_import }) => {
      console.log("get_data_to_import")
      editor.import(data_to_import);
    });

    live.pushEvent("api_driven", {}, ({ data }) => {
      console.log("api_driven")
      console.log(data)
      window.apiDrivenData = data;
    });
  })

  Svelte.onDestroy(e => {
    console.log('onDestroy')
  })
};
