{% set disabled_submit = captcha.enabled == 1 ? 'disabled="disabled"' : '' %}
{% set disabled_class = captcha.enabled == 1 ? 'layui-btn-disabled' : '' %}

<form class="layui-form account-form" method="POST" action="{{ url({'for':'home.account.pwd_login'}) }}">
    <div class="layui-form-item">
        <label class="layui-icon layui-icon-username"></label>
        <input class="layui-input" type="text" name="account" value="100015@163.com" autocomplete="off" placeholder="手机 / 邮箱" lay-verify="required">
    </div>
    <div class="layui-form-item">
        <label class="layui-icon layui-icon-password"></label>
        <input class="layui-input" type="password" name="password" value="123456" autocomplete="off" placeholder="密码" lay-verify="required">
    </div>
    {% if captcha.enabled == 1 %}
        <div id="captcha-block" class="layui-form-item">
            <div class="layui-input-block">
                <button id="captcha-btn" class="layui-btn layui-btn-fluid" type="button" data-app-id="{{ captcha.app_id }}">点击完成验证</button>
            </div>
        </div>
    {% endif %}
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button id="submit-btn" class="layui-btn layui-btn-fluid {{ disabled_class }}" {{ disabled_submit }} lay-submit="true" lay-filter="go">立即登录</button>
            <input type="hidden" name="return_url" value="{{ return_url }}">
            <input id="ticket" type="hidden" name="ticket">
            <input id="rand" type="hidden" name="rand">
        </div>
    </div>
</form>