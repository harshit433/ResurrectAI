from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
from peft import AutoPeftModelForCausalLM
from transformers import AutoTokenizer

app = FastAPI()

model = AutoPeftModelForCausalLM.from_pretrained(
    "ressurectAI/Gandhi10.0", # YOUR MODEL YOU USED FOR TRAINING
    load_in_4bit = False,
)
tokenizer = AutoTokenizer.from_pretrained("ressurectAI/Gandhi10.0")

class PredictionRequest(BaseModel):
    text: str
    data: list

@app.get("/")
def read_root():
    return {"message":"Welcome to the ResurrectAI"}

@app.post("/predict")
async def predict(request: PredictionRequest):
    try:
        messages = reversed(request.data)
        messages.append({'role':'user','content':request.text})
        inputs = tokenizer.apply_chat_template(
        messages,
        tokenize=True,
        add_generation_prompt=True,
        return_tensors="pt",
        )
        result = model.generate(input_ids=inputs, max_new_tokens=512,use_cache=True)
        response = str(tokenizer.batch_decode(result)[-1].split('assistant\n')[-1].replace('<|im_end|>','').strip())
        messages.append({'role':'assistant','content':response})
        return {'Gandhi Ji':response}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))