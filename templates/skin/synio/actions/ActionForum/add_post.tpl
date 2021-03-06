{include file='header.tpl' noSidebar=true}

{if $oConfig->GetValue('view.tinymce')}
	<script src="{cfg name='path.root.engine_lib'}/external/tinymce-jq/tiny_mce.js"></script>
	<script>
		jQuery(function($){
			tinyMCE.init(ls.settings.getTinymce());
		});
	</script>
{else}
	{include file='window_load_img.tpl' sToLoad='post_text'}
	<script>
		jQuery(function($){
			ls.lang.load({lang_load name="panel_b,panel_i,panel_u,panel_s,panel_url,panel_url_promt,panel_code,panel_video,panel_image,panel_cut,panel_quote,panel_list,panel_list_ul,panel_list_ol,panel_title,panel_clear_tags,panel_video_promt,panel_list_li,panel_image_promt,panel_user,panel_user_promt,panel_spoiler,panel_spoiler_promt,panel_spoiler_placeholder"});
			// Подключаем редактор
			$('#post_text').markItUp(ls.forum.getMarkitup());
		});
	</script>
{/if}

<h2 class="page-header">{include file="$sTemplatePathForum/breadcrumbs.tpl"}</h2>

<h4 class="page-subheader">{$aLang.plugin.forum.reply_for|ls_lang:'topic%%'} &laquo;<a href="{$oTopic->getUrlFull()}">{$oTopic->getTitle()}</a>&raquo;</h4>

<div class="fBox">
	<form action="" method="POST" enctype="multipart/form-data" id="form-post-add">
		<div class="forums-content fLayout-withright">
			<div class="fContainer fLayout-content-side fl-r">

			</div>
			<div class="fContainer fLayout-content">
				<div class="fLayout-pad">
					{hook run='form_forum_add_post_begin'}

					<p>
						<label for="post_title">{$aLang.plugin.forum.post_create_title}:</label>
						<input type="text" id="post_title" name="post_title" value="{$_aRequest.post_title}" class="input-text input-width-full" /><br />
						<span class="note">{$aLang.plugin.forum.post_create_title_notice}</span>
					</p>

					<textarea name="post_text" id="post_text" rows="20" class="mce-editor">{$_aRequest.post_text}</textarea>

					{if !$oConfig->GetValue('view.tinymce')}
						{include file='tags_help.tpl' sTagsTargetId="post_text"}
						<br />
						<br />
					{/if}

					{include file="$sTemplatePathForum/guest_block.tpl" event="post"}

					{hook run='form_forum_add_post_end'}
				</div>
			</div>
		</div>
		<div class="fSubmit">
			<input type="hidden" name="security_ls_key" value="{$LIVESTREET_SECURITY_KEY}" /> 
			<input type="hidden" name="action_type" value="add_post" />

			<button type="submit" name="submit_preview" onclick="return ls.forum.preview('form-post-add','text_preview');" class="button">{$aLang.topic_create_submit_preview}</button>
			<button type="submit" name="submit_post_publish" id="submit_post_publish" class="button button-primary">{$aLang.topic_create_submit_publish}</button>
		</div>
	</form>
</div>
<div class="topic-preview" style="display: none;" id="text_preview"></div>

{include file='footer.tpl'}