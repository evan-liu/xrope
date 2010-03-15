package xrope
{
    import xrope.algorithms.BackwardAlgorithm;
    import xrope.algorithms.CenterAlgorithm;
    import xrope.algorithms.ForwardAlgorithm;
    import xrope.algorithms.MaxAlgorithm;
    import xrope.algorithms.MinAlgorithm;

    import flash.display.DisplayObjectContainer;
    /**
     * Horizontal single line layout.
     * @author eidiot
     */
    public class HLineLayout extends AbstractLineLayout
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>HLineLayout</code>.
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
        public function HLineLayout(container:DisplayObjectContainer,
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
            _horizontalGap = gap;
        }
        //======================================================================
        //  Overridden methods
        //======================================================================
        /** @private */
        override protected function fixWidth():void
        {
            _width = getElementsAndGapsWidth();
        }
        /** @private */
        override protected function fixHeight():void
        {
            _height = getMaxHeight();
        }
        /** @private */
        override protected function getStartX():Number
        {
            switch (_align)
            {
                case LayoutAlign.RIGHT:
                case LayoutAlign.TOP_RIGHT:
                case LayoutAlign.BOTTOM_RIGHT:
                    return _x + _width;
                case LayoutAlign.CENTER:
                case LayoutAlign.TOP:
                case LayoutAlign.BOTTOM:
                    return _x + (_width - getElementsAndGapsWidth()) / 2;
            }
            return _x;
        }
        /** @private */
        override protected function getXAlgorithm():ILayoutAlgorithm
        {
            switch (_align)
            {
                case LayoutAlign.RIGHT:
                case LayoutAlign.TOP_RIGHT:
                case LayoutAlign.BOTTOM_RIGHT:
                    return new BackwardAlgorithm();
            }
            return new ForwardAlgorithm();
        }
        /** @private */
        override protected function getYAlgorithm():ILayoutAlgorithm
        {
            switch (_align)
            {
                case LayoutAlign.TOP:
                case LayoutAlign.TOP_LEFT:
                case LayoutAlign.TOP_RIGHT:
                    return new MinAlgorithm();
                case LayoutAlign.BOTTOM:
                case LayoutAlign.BOTTOM_LEFT:
                case LayoutAlign.BOTTOM_RIGHT:
                    return new MaxAlgorithm();
            }
            return new CenterAlgorithm();
        }
        //======================================================================
        //  Private methods
        //======================================================================
        private function getMaxHeight():Number
        {
            var result:Number = 0;
            for each (var element:ILayoutElement in _elements)
            {
                if (element.height > result)
                {
                    result = element.height;
                }
            }
            return result;
        }
        private function getElementsWidth():Number
        {
            var result:Number = 0;
            for each (var element:ILayoutElement in _elements)
            {
                result += element.width;
            }
            return result;
        }
        private function getGapsWidth():Number
        {
            return _horizontalGap * (_elements.length - 1);
        }
        private function getElementsAndGapsWidth():Number
        {
            return getElementsWidth() + getGapsWidth();
        }
    }
}