package xrope.algorithms
{
    import xrope.ILayoutElement;
    /**
     * Algorithm for max element value.
     * @author eidiot
     */
    public class MaxAlgorithm extends AbstractLayoutAlgorithm
    {
        //======================================================================
        //  Overridden methods
        //======================================================================
        /** @inheritDoc */
        override public function calculate(currentElement:ILayoutElement,
                                  previousElement:ILayoutElement = null):Number
        {
            return valueOf(group) + sizeOf(group) - sizeOf(currentElement);
        }
    }
}