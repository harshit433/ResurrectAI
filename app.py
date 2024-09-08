from flask import Flask, render_template, request
from unsloth.chat_templates import get_chat_template
from unsloth import FastLanguageModel

app = Flask(__name__)

max_seq_length = 2048
model, tokenizer = FastLanguageModel.from_pretrained(
    model_name="ressurectAI/base",
    max_seq_length=max_seq_length,
    dtype=None,
)
tokenizer = get_chat_template(
    tokenizer,
    mapping={"role": "from", "content": "value", "user": "Person", "assistant": "Gandhi"},
    chat_template="chatml",
)
FastLanguageModel.for_inference(model)

@app.route("/chatbot")
def home():
    return render_template("index.html")

@app.route("/get")
def get_bot_response():
    userText = request.args.get('msg')
    messages = [
    {"from": "Person", "value": "Gandhi ji, {}".format(userText)},
    ]
    inputs = tokenizer.apply_chat_template(
    messages,
    tokenize=True,
    add_generation_prompt=False,
    return_tensors="pt",
    ).to("cuda")
    a = model.generate(input_ids=inputs, max_new_tokens=1024,use_cache=True)
    return str(tokenizer.batch_decode(a)[0].split('assistant\n')[1].replace('<|im_end|>','').strip())

app.run(debug = True)