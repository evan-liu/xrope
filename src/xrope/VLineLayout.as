package xrope
{
    import xrope.algorithms.BackwardAlgorithm;
    import xrope.algorithms.CenterAlgorithm;
    import xrope.algorithms.ForwardAlgorithm;
    import xrope.algorithms.MaxAlgorithm;
    import xrope.algorithms.MinAlgorithm;

    import flash.display.DisplayObjectContainer;
    /**
     * Vertical single line layout.
     * @author eidiot
     */
    public class VLineLayout extends AbstractLineLayout
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>XLineLayout</code>.
         * @param container             Container of the layout group.
         * @param x                     <code>x</code> value of the layout element.
         * @param y                     <code>y</code> value of the layout element.
         * @param width                 <code>width</code> value of the layout element.
         * @param height                <code>height</code> value of the layout element.
         * @param align                 Align of the layout group.
         * @param gap                   Gap value of the line layout.
         * @param useBounds             If use <code>getBounds()</code> for atom.
         * @param autoLayoutWhenAdd     If auto layout when a new element is added.
         * @param autoLayoutWhenChange  If auto layout when something has been changed.
         */
        public function VLineLayout(container:DisplayObjectContainer,
                                    x:Number = 0, y:Number = 0,
                                    width:Number = -1, height:Number = -1,
                                    align:String = "TL", gap:Number = 5,
                                    useBounds:Boolean = false,
                                    autoLayoutWhenAdd:Boolean = false,
                                    autoLayoutWhenChange:Boolean = true)
        {
            super(container, useBounds, autoLayoutWhenAdd, autoLayoutWhenChange);
            _x = x;
            _y = y;
            _width = width;
            _height = height;
            _align = align;
            _verticalGap = gap;
        }
        //======================================================================
        //  Overridden methods
        //======================================================================
        /** @private */
        override protected function fixWidth():void
        {
            _width = getMaxWidth();
        }
        /** @private */
        override protected function fixHeight():void
        {
            _height = getElementsAndGapsHeight();
        }
        /** @private */
        override protected function getStartY():Number
        {
            switch (_align)
            {
                case LayoutAlign.BOTTOM:
                case LayoutAlign.BOTTOM_LEFT:
                case LayoutAlign.BOTTOM_RIGHT:
                    return _y + _height;
                case LayoutAlign.CENTER:
                case LayoutAlign.LEFT:
                case LayoutAlign.RIGHT:
                    return _y + (_height - getElementsAndGapsHeight()) / 2;
            }
            return _y;
        }
        /** @private */
        override protected function getXAlgorithm():ILayoutAlgorithm
        {
            switch (_align)
            {
                case LayoutAlign.LEFT:
                case LayoutAlign.TOP_LEFT:
                case LayoutAlign.BOTTOM_LEFT:
                    return new MinAlgorithm();
                case LayoutAlign.RIGHT:
                case LayoutAlign.TOP_RIGHT:
                case LayoutAlign.BOTTOM_RIGHT:
                    return new MaxAlgorithm();
            }
            return new CenterAlgorithm();
        }
        /** @private */
        override protected function getYAlgorithm():ILayoutAlgorithm
        {
            switch (_align)
            {
                case LayoutAlign.BOTTOM:
                case LayoutAlign.BOTTOM_LEFT:
                case LayoutAlign.BOTTOM_RIGHT:
                    return new BackwardAlgorithm();
            }
            return new ForwardAlgorithm();
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function getElementsHeight():Number
        {
            var result:Number = 0;
            for each (var element:ILayoutElement in _elements)
            {
                result += element.height;
            }
            return result;
        }
        private function getGapsHeight():Number
        {
            return _verticalGap * (_elements.length - 1);
        }
        private function getElementsAndGapsHeight():Number
        {
            return getElementsHeight() + getGapsHeight();
        }
        private function getMaxWidth():Number
        {
            var result:Number = 0;
            for each (var element:ILayoutElement in _elements)
            {
                if (element.width > result)
                {
                    result = element.width;
                }
            }
            return result;
        }
    }
}