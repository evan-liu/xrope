package xrope
{
    import xrope.algorithms.ForwardAlgorithm;

    import flash.display.DisplayObjectContainer;
    /**
     * @author eidiot
     */
    public class AbstractLineLayout extends AbstractLayoutGroup
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>XLineLayout</code>.
         */
        public function AbstractLineLayout(container:DisplayObjectContainer,
                                            autoLayoutWhenAdd:Boolean = false,
                                            autoLayoutWhenChange:Boolean = true)
        {
            super(container, autoLayoutWhenAdd, autoLayoutWhenChange);
        }
        //======================================================================
        //  Overridden methods
        //======================================================================
        override protected function layoutElements():void
        {
            fixSize();
            var xAlgorithm:ILayoutAlgorithm = getXAlgorithm();
            xAlgorithm.beReady(this, "x", "width", getStartX(), _horizontalGap);
            var yAlgorithm:ILayoutAlgorithm = getYAlgorithm();
            yAlgorithm.beReady(this, "y", "height", getStartY(), _verticalGap);
            var previousElement:ILayoutElement;
            for each (var element:ILayoutElement in _elements)
            {
                element.x = xAlgorithm.calculate(element, previousElement);
                element.y = yAlgorithm.calculate(element, previousElement);
                previousElement = element;
            }
        }
        //======================================================================
        //  Protected methods
        //======================================================================
        protected function fixSize():void
        {
            if (_width <= 0)
            {
                fixWidth();
            }
            if (_height <= 0)
            {
                fixHeight();
            }
        }
        protected function fixWidth():void
        {
        }
        protected function fixHeight():void
        {
        }
        protected function getStartX():Number
        {
            return _x;
        }
        protected function getStartY():Number
        {
            return _y;
        }
        protected function getXAlgorithm():ILayoutAlgorithm
        {
            return new ForwardAlgorithm();
        }
        protected function getYAlgorithm():ILayoutAlgorithm
        {
            return new ForwardAlgorithm();
        }
    }
}