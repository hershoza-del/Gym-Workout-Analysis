import os
import pandas as pd
import matplotlib.pyplot as plt
import numpy as np

df = pd.read_csv("/Users/hershoza/Downloads/gym_members_exercise_tracking.csv")

#where my charts will be saved as a separate folder
folder_name = os.path.join(os.path.expanduser("~"), "gym workout charts")
os.makedirs(folder_name, exist_ok=True)

def save_path(filename):
    return os.path.join(folder_name, filename)

print(f"Charts will be saved in: {folder_name}")

#brief analysis of the csv before changing it 
print(df.shape)
print(df.info())
print(df.describe())

print(df.isnull().sum())
print(df.duplicated().sum())

analysis = df.groupby("Gender")["Calories_Burned"].agg(['mean', 'min', 'max', 'count'])
print(analysis)

#changing the csv
df["Height (ins)"] = (df["Height (m)"] * 39.3701).round().astype(int)
df["Weight (lbs)"] = (df["Weight (kg)"] * 2.20462).round().astype(int)

df = df.drop(columns=["Max_BPM", "Resting_BPM", "BMI",
                      "Weight (kg)", "Height (m)"])

#boxplot, barchart, and scatterplot charts
bands = ["Beginner", "Intermediate", "Expert"]
df["level_name"] = df["Experience_Level"].map({1: "Beginner", 2: "Intermediate", 3: "Expert"})

fig, ax = plt.subplots(figsize=(8, 5))
df.boxplot(column="Fat_Percentage", by="level_name", ax=ax, grid=False,
           patch_artist=True,
           boxprops=dict(facecolor="green", edgecolor="black"),
           color=dict(whiskers="black", caps="black", medians="black"))
ax.set_title("Body Fat Percentage by Experience Level")
fig.suptitle("")          
ax.set_xlabel("Experience Level")
ax.set_ylabel("Body Fat Percentage (%)")
fig.tight_layout()
fig.savefig(save_path("boxplot.png"), dpi=150)
plt.close(fig)

water = (df.groupby(["level_name", "Gender"])["Water_Intake (liters)"].mean().unstack().reindex(bands))

fig, ax = plt.subplots(figsize=(8, 5))
water.plot(kind='bar', ax=ax, color=["lightpink", "powderblue"], edgecolor="black", rot=0)
for container in ax.containers:
    ax.bar_label(container, fmt="%.2f L", padding=3) 
ax.set_ylim(0, water.max().max() * 1.2)
ax.set_title("Average Water Intake by Experience Level and Gender")
ax.set_xlabel("Experience Level")
ax.set_ylabel("Mean Water Intake (liters)")
plt.xticks(rotation=20, ha="right")
fig.tight_layout()
fig.savefig(save_path("barchart.png"), dpi=150)
plt.close(fig)

jitter = np.random.uniform(-0.2, 0.2, size=len(df))
fig, ax = plt.subplots(figsize=(8, 5))
ax.scatter(df["Session_Duration (hours)"] + jitter, df["Calories_Burned"], alpha=0.6, s=15, color="red") 
ax.set_title("Session Duration vs. Calories Burned")
ax.set_xlabel("Session Duration (hours)")
ax.set_ylabel("Calories Burned")
fig.tight_layout()
fig.savefig(save_path("scatterplot.png"), dpi=150)
plt.close(fig)

#export changes to excel
df.to_excel("/Users/hershoza/Downloads/Gym Workout.xlsx", index=False)

