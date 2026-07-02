public class RestObjectWrapper {
	public String id;
    public String name;
    public ObjectData data;
    public String message;
    public class ObjectData{
        public String color;
        public String capacity;
        public Decimal price;
        public Integer year;
        @JsonProperty('CPU model')
        public String cpuModel;
        @JsonProperty('Hard disk size')
        public String hardDiskSize;
    }
}