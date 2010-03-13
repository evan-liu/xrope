package xrope.algorithms
{
    import xrope.ILayoutElement;
    /**
     * Algorithm for center element value.
     * @author eidiot
     */
    public class CenterAlgorithm extends AbstractLayoutAlgorithm
    {
        //======================================================================
        //  Overridden methods
        //======================================================================
        /** @inheritDoc */
        override public function calculate(currentElement:ILayoutElement,
                                           previousElement:ILayoutElement = null):Number
        {
            return valueOf(group) + (sizeOf(group) - sizeOf(currentElement)) / 2;
        }
    }
}