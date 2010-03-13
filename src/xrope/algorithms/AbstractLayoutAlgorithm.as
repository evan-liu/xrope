package xrope.algorithms
{
    import xrope.ILayoutAlgorithm;
    import xrope.ILayoutElement;
    import xrope.ILayoutGroup;
    /**
     * Abstract class for layout Algorithm.
     * @author eidiot
     */
    public class AbstractLayoutAlgorithm implements ILayoutAlgorithm
    {
        //======================================================================
        //  Variables
        //======================================================================
        /** @private */
        protected var group:ILayoutGroup;
        /** @private */
        protected var valueKey:String;
        /** @private */
        protected var sizeKey:String;
        /** @private */
        protected var startValue:Number;
        /** @private */
        protected var gap:Number;
        //======================================================================
        //  Public methods: IXLayoutAlgorithm
        //======================================================================
        /** @inheritDoc */
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
        /** @inheritDoc */
        public function calculate(currentElement:ILayoutElement,
                                  previousElement:ILayoutElement = null):Number
        {
            // To be overridden by subclasses.
            return 0;
        }
        //======================================================================
        //  Protected methods
        //======================================================================
        /** @private */
        protected function sizeOf(target:ILayoutElement):Number
        {
            return target[sizeKey];
        }
        /** @private */
        protected function valueOf(target:ILayoutElement):Number
        {
            return target[valueKey];
        }
    }
}