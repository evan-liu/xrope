package xrope
{
    import xrope.algorithms.ForwardAlgorithm;

    import flash.display.DisplayObjectContainer;
    /**
     * Abstract class for single line layout.
     * @author eidiot
     */
    public class AbstractLineLayout extends AbstractLayoutGroup
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>XLineLayout</code>.
         * @param container             Container of the layout group.
         * @param useBounds             If use <code>getBounds()</code> for atom.
         * @param autoLayoutWhenAdd     If auto layout when a new element is added.
         * @param autoLayoutWhenChange  If auto layout when something has been changed.
         */
        public function AbstractLineLayout(container:DisplayObjectContainer,
                                            useBounds:Boolean = false,
                                            autoLayoutWhenAdd:Boolean = false,
                                            autoLayoutWhenChange:Boolean = true)
        {
            super(container, useBounds, autoLayoutWhenAdd, autoLayoutWhenChange);
        }
        //======================================================================
        //  Overridden methods
        //======================================================================
        /** @private */
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
        /** @private */
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
        /** @private */
        protected function fixWidth():void
        {
        }
        /** @private */
        protected function fixHeight():void
        {
        }
        /** @private */
        protected function getStartX():Number
        {
            return _x;
        }
        /** @private */
        protected function getStartY():Number
        {
            return _y;
        }
        /** @private */
        protected function getXAlgorithm():ILayoutAlgorithm
        {
            return new ForwardAlgorithm();
        }
        /** @private */
        protected function getYAlgorithm():ILayoutAlgorithm
        {
            return new ForwardAlgorithm();
        }
    }
}