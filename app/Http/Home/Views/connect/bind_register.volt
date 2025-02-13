<form class="layui-form account-form" method="POST" action="{{ url({'for':'home.oauth.bind_register'}) }}">
    <div class="layui-form-item">
        <div class="layui-input-block">
            <input id="cv-account" class="layui-input" type="text" name="account" autocomplete="off" placeholder="手机 / 邮箱" lay-verify="required">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <input class="layui-input" type="password" name="password" autocomplete="off" placeholder="密码（字母数字特殊字符6-16位）" lay-verify="required">
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-inline verify-input-inline">
            <input class="layui-input" type="text" name="verify_code" placeholder="验证码" lay-verify="required">
        </div>
        <div class="layui-input-inline verify-btn-inline">
            <button id="cv-emit-btn" class="layui-btn layui-btn-primary layui-btn-disabled" type="button" disabled="disabled">获取验证码</button>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <div class="agree">
                <div class="left"><input id="register-agree" type="checkbox" name="agree" lay-skin="primary"></div>
                <div class="right">我已阅读并同意<a href="{{ terms_url }}" target="_blank">《用户协议》</a>和<a href="{{ privacy_url }}" target="_blank">《隐私政策》</a></div>
            </div>
        </div>
    </div>
    <div class="layui-form-item">
        <div class="layui-input-block">
            <button id="cv-submit-btn" class="layui-btn layui-btn-fluid layui-btn-disabled" disabled="disabled" lay-submit="true" lay-filter="go">注册并绑定帐号</button>
            <input type="hidden" name="provider" value="{{ provider }}">
            <input type="hidden" name="code" value="{{ request.get('code') }}">
            <input type="hidden" name="state" value="{{ request.get('state') }}">
            <input type="hidden" name="open_user" value='{{ open_user|json_encode }}'>
            <input id="cv-enabled" type="hidden" value="{{ captcha.enabled }}">
            <input id="cv-app-id" type="hidden" value="{{ captcha.app_id }}">
            <input id="cv-ticket" type="hidden" name="ticket">
            <input id="cv-rand" type="hidden" name="rand">
        </div>
    </div>
</form>