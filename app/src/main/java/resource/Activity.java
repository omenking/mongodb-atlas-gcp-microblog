package api;

public class Activity {
  
	private final long id;
	private final String message;
	private final String handle;

	public Activity() {
		this.id = -1;
		this.message = "";
    this.handle = "";
	}

	public Activity(long id, String message, String handle) {
		this.id = id;
		this.message = message;
    this.handle = handle;
	}

	public long getId() {
		return id;
	}

	public String getMessage() {
		return message;
	}
  
	public String getHandle() {
		return handle;
	}
}