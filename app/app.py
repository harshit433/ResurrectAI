from fastapi import FastAPI, HTTPException
from pydantic import BaseModel
import uvicorn
from peft import AutoPeftModelForCausalLM
from transformers import AutoTokenizer

app = FastAPI()

# Load the model from Hugging Face
model_name = "ressurectAI/Gandhi10.0"

model = AutoPeftModelForCausalLM.from_pretrained(
    "ressurectAI/Gandhi10.0", # YOUR MODEL YOU USED FOR TRAINING
    load_in_4bit = False,
)
tokenizer = AutoTokenizer.from_pretrained("ressurectAI/Gandhi10.0")
messages = []

class PredictionRequest(BaseModel):
    text: str

@app.get("/")
def welcome():
    return {"message":"Welcome to the ResurrectAI"}

@app.post("/predict")
async def predict(request: PredictionRequest):
    try:
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

if __name__ == "__main__":
    uvicorn.run(app, host="127.0.0.1", port=8000)