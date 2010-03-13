package xrope
{
    /**
     * Interface for a layout element.
     * @author eidiot
     */
    public interface ILayoutElement
    {
        //======================================================================
        //  Properties
        //======================================================================
        //------------------------------
        //  x
        //------------------------------
        /**
         * <code>x</code> value of the layout element.
         */
        function get x():Number;
        /** @private */
        function set x(value:Number):void;
        //------------------------------
        //  y
        //------------------------------
        /**
         * <code>y</code> value of the layout element.
         */
        function get y():Number;
        /** @private */
        function set y(value:Number):void;
        //------------------------------
        //  width
        //------------------------------
        /**
         * <code>width</code> of the layout element.
         */
        function get width():Number;
        /** @private */
        function set width(value:Number):void;
        //------------------------------
        //  height
        //------------------------------
        /**
         * <code>height</code> value of the layout element.
         */
        function get height():Number;
        /** @private */
        function set height(value:Number):void;
    }
}