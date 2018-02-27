package com.peter.shiro.util;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.TypeAdapter;
import com.google.gson.stream.JsonReader;
import com.google.gson.stream.JsonToken;
import com.google.gson.stream.JsonWriter;

public class JsonUtils {

	public static String toJsonString(Object object) {
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd'T'HH:mm:ssZ")
				.setVersion(1.0)
				.registerTypeAdapter(JSONArray.class, JSONARRAY)
				.registerTypeAdapter(JSONObject.class, JSONOBJECT).create();
		return gson.toJson(object);
	}

	public static <T> T fromJson(String json, Class<T> classOfT)
			throws JSONException {
		try {
			Gson gson = new Gson();
			return gson.fromJson(json, classOfT);
		} catch (Exception e) {
			throw new JSONException(e);
		}

	}

	public static <T> T fromJson(JSONObject jsonObject, Class<T> classOfT)
			throws JSONException {
		return fromJson(jsonObject.toString(), classOfT);

	}

	private static final TypeAdapter<JSONArray> JSONARRAY = new TypeAdapter<JSONArray>() {
		@Override
		public JSONArray read(JsonReader reader) throws IOException {
			if (reader.peek() == JsonToken.NULL) {
				reader.nextNull();
				return null;
			}
			try {
				String array = reader.nextString();
				return new JSONArray(array);
			} catch (JSONException e) {
				throw new IOException("error json parse ", e);
			}
		}

		@Override
		public void write(JsonWriter writer, JSONArray value)
				throws IOException {
			if (value == null) {
				writer.nullValue();
				return;
			}
			dump(writer, value);
		}

		private void dump(JsonWriter writer, Object value) throws IOException {
			try {
				if (value instanceof JSONArray) {
					writer.beginArray();
					JSONArray array = (JSONArray) value;
					for (int i = 0; i < array.length(); i++) {
						Object object = array.get(i);
						dump(writer, object);
					}
					writer.endArray();
				} else if (value instanceof JSONObject) {
					writer.beginObject();
					JSONObject jsonObject = (JSONObject) value;
					Iterator<String> iterator = jsonObject.keys();
					while (iterator.hasNext()) {
						String key = iterator.next();
						writer.name(key);
						Object object = jsonObject.get(key);
						dump(writer, object);
					}
					writer.endObject();
				} else if (value instanceof Integer) {
					writer.value(Long.valueOf((Integer) value));
				} else if (value instanceof Short) {
					writer.value(Double.valueOf((Short) value));
				} else if (value instanceof Long) {
					writer.value(Long.valueOf((Long) value));
				} else if (value instanceof Float) {
					writer.value(Float.valueOf((Float) value));
				} else if (value instanceof Double) {
					writer.value(Double.valueOf((Double) value));
				} else if (value instanceof Boolean) {
					writer.value((Boolean) value);
				} else if (value instanceof Date) {
					SimpleDateFormat sdf = new SimpleDateFormat(
							"yyyy-MM-dd'T'HH:mm:ssZ");
					writer.value(sdf.format((Date) value));
				} else {
					writer.value(value.toString());
				}
			} catch (JSONException e) {
				throw new IOException("error json parse ", e);
			}
		}
	};

	private static final TypeAdapter<JSONObject> JSONOBJECT = new TypeAdapter<JSONObject>() {
		@Override
		public JSONObject read(JsonReader reader) throws IOException {
			if (reader.peek() == JsonToken.NULL) {
				reader.nextNull();
				return null;
			}
			try {
				String array = reader.nextString();
				return new JSONObject(array);
			} catch (JSONException e) {
				throw new IOException("error json parse ", e);
			}
		}

		@Override
		public void write(JsonWriter writer, JSONObject value)
				throws IOException {
			if (value == null) {
				writer.nullValue();
				return;
			}
			dump(writer, value);

		}

		private void dump(JsonWriter writer, Object value) throws IOException {
			try {
				if (value instanceof JSONArray) {
					writer.beginArray();
					JSONArray array = (JSONArray) value;
					for (int i = 0; i < array.length(); i++) {
						Object object = array.get(i);
						dump(writer, object);
					}
					writer.endArray();
				} else if (value instanceof JSONObject) {
					writer.beginObject();
					JSONObject jsonObject = (JSONObject) value;
					Iterator<String> iterator = jsonObject.keys();
					while (iterator.hasNext()) {
						String key = iterator.next();
						writer.name(key);
						Object object = jsonObject.get(key);
						dump(writer, object);
					}
					writer.endObject();
				} else if (value instanceof Integer) {
					writer.value(Long.valueOf((Integer) value));
				} else if (value instanceof Short) {
					writer.value(Double.valueOf((Short) value));
				} else if (value instanceof Long) {
					writer.value(Long.valueOf((Long) value));
				} else if (value instanceof Float) {
					writer.value(Double.valueOf((Float) value));
				} else if (value instanceof Double) {
					writer.value(Double.valueOf((Double) value));
				} else if (value instanceof Boolean) {
					writer.value((Boolean) value);
				} else if (value instanceof Date) {
					SimpleDateFormat sdf = new SimpleDateFormat(
							"yyyy-MM-dd'T'HH:mm:ssZ");
					writer.value(sdf.format((Date) value));
				} else {
					writer.value(value.toString());
				}
			} catch (JSONException e) {
				throw new IOException("error json parse ", e);
			}
		}
	};
}
