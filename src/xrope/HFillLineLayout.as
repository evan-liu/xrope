package xrope
{
    import xrope.algorithms.AlgorithmFactory;
    import xrope.algorithms.ForwardAlgorithm;

    import flash.display.DisplayObjectContainer;

    public class HFillLineLayout extends AbstractFillLineLayout
    {
        //======================================================================
        //  Constructor
        //======================================================================
        /**
         * Construct a <code>HFillLineLayout</code>.
         * @param container             Container of the layout group.
         * @param x                     <code>x</code> value of the layout element.
         * @param y                     <code>y</code> value of the layout element.
         * @param width                 <code>width</code> value of the layout element.
         * @param height                <code>height</code> value of the layout element.
         * @param align                 Align of the layout group.
         * @param useBounds             If use <code>getBounds()</code> for atom.
         * @param autoLayoutWhenAdd     If auto layout when a new element is added.
         * @param autoLayoutWhenChange  If auto layout when something has been changed.
         */
        public function HFillLineLayout(container:DisplayObjectContainer,
                                        width:Number, height:Number,
                                        x:Number = 0, y:Number = 0,
                                        align:String = "C",
                                        useMargin:Boolean = true,
                                        useBounds:Boolean = false,
                                        autoLayoutWhenChange:Boolean = true)
        {
            super("width", container, x, y, width, height, align, useMargin, useBounds, autoLayoutWhenChange);
        }
        //======================================================================
        //  Overridden methods
        //======================================================================
        /** @private */
        override protected function getStartX():Number
        {
            return _x + margin;
        }
        /** @private */
        override protected function getXAlgorithm():ILayoutAlgorithm
        {
            return new ForwardAlgorithm();
        }
        /** @private */
        override protected function getYAlgorithm():ILayoutAlgorithm
        {
            return AlgorithmFactory.getYAlgorithmForHLayout(_align);
        }
    }
}