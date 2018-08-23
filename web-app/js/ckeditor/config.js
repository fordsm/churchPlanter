/*
Copyright (c) 2003-2011, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.editorConfig = function( config )
{
	// Define changes to default configuration here. For example:
	// config.language = 'fr';
	// config.uiColor = '#AADC6E';
	   config.format_p = { element : 'p', attributes : { 'class' : 'resource' } };
	   config.resize_enabled = false
	   config.width = '85%';
	   config.entities = false;
	   config.indentOffset = 4;
	   config.toolbar = [['Bold','Italic','-','NumberedList', 'BulletedList','-','PasteFromWord','PasteText']];
	   
};