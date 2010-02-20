package xrope.algorithms
{
    import xrope.ILayoutAlgorithm;
    import xrope.ILayoutElement;
    import xrope.ILayoutGroup;
    /**
     * @author eidiot
     */
    public class AbstractLayoutAlgorithm implements ILayoutAlgorithm
    {
        //======================================================================
        //  Variables
        //======================================================================
        protected var group:ILayoutGroup;
        protected var valueKey:String;
        protected var sizeKey:String;
        protected var startValue:Number;
        protected var gap:Number;
        //======================================================================
        //  Public methods: IXLayoutAlgorithm
        //======================================================================
        /**
         * @inheritDoc
         */
        public function beReady(group:ILayoutGroup,
                                valueKey:String, sizeKey:String,
                                startValue:Number, gap:Number):void
        {
            this.group = group;
            this.valueKey = valueKey;
            this.sizeKey = sizeKey;
            this.startValue = startValue;
            this.gap = gap;
        }
        /**
         * @inheritDoc
         */
        public function calculate(currentElement:ILayoutElement,
                                  previousElement:ILayoutElement = null):Number
        {
            // To be overridden by subclasses.
            return 0;
        }
        //======================================================================
        //  Protected methods
        //======================================================================
        protected function sizeOf(target:ILayoutElement):Number
        {
            return target[sizeKey];
        }
        protected function valueOf(target:ILayoutElement):Number
        {
            return target[valueKey];
        }
    }
}