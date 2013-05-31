CKEDITOR.editorConfig = function( config )
{
  config.language = 'ru';
  config.font_defaultLabel = 'Arial';
  config.uiColor = '#888888';
  config.toolbar = 'Medi';

  config.toolbar_Medi =
      [
        { name: 'document', items : [ 'Source'] },
        { name: 'basicstyles', items : [ 'Bold','Italic','Underline','Strike','Subscript','Superscript','-','RemoveFormat' ] },
        { name: 'paragraph', items : [ 'NumberedList','BulletedList','-','Outdent','Indent','-','Blockquote','CreateDiv',
          '-','JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'] },
        { name: 'links', items : [ 'Link','Unlink','Anchor' ] },
        { name: 'styles', items : [ 'Format','FontSize' ] },
        { name: 'insert', items : [ 'Image','Flash','Table','HorizontalRule','Smiley','SpecialChar','PageBreak','Iframe' ] },
        { name: 'colors', items : [ 'TextColor','BGColor' ] },
        { name: 'tools', items : [ 'Maximize', 'ShowBlocks','-','About' ] }
      ];
};