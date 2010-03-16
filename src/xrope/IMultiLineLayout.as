package xrope
{
    /**
     * Interface for multi line layout.
     * @author eidiot
     */
    public interface IMultiLineLayout extends ILayoutGroup
    {
        /**
         * Line list in the layout.
         */
        function get lines():Array;
        /**
         * Align of each line.
         */
        function get lineAlign():String;
        /** @private */
        function set lineAlign(value:String):void;
    }
}