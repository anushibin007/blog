<jsp:root version="2.0"
    xmlns:jsp="http://java.sun.com/JSP/Page"
    xmlns:c="http://java.sun.com/jsp/jstl/core"
    xmlns:template="http://beehive.apache.org/netui/tags-template-1.0">
<jsp:directive.page session="false" />
<jsp:directive.page isELIgnored="false" />

<!--
  Template used for all "normal" assistant jsps in the console
  Use when you want:
  buttonBar
  stepTitle
  stepIntroduction
  form
  buttonBar
-->

<div class="contenttable">
    <!-- display the navigation buttons -->
    <div class="upperButtonBar">
        <template:includeSection name="buttonBar"/>
    </div>
    <!-- include the step title here-->
    <div class="stepTitle">
        <template:includeSection name="stepTitle"/>
    </div>
    <!-- include the step intro text here-->
    <div class="stepIntro">
        <template:includeSection name="stepIntroduction"/>
    </div>

    <template:includeSection name="form"/>

    <!-- display the navigation buttons -->
    <div class="lowerButtonBar">
        <template:includeSection name="buttonBar"/>
    </div>
</div>
</jsp:root>
