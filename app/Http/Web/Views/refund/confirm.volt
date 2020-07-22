{% extends 'templates/layer.volt' %}

{% block content %}

    {%- macro item_info(confirm) %}
        {% if confirm.item_type == 'course' %}
            {% set course = confirm.item_info.course %}
            {% set expiry_flag = course.refund_expiry_time < time() ? '（已过期）' : '' %}
            <div class="order-item">
                <p>课程名称：<span>{{ course.title }}</span></p>
                <p>退款期限：<span>{{ date('Y-m-d H:i:s',course.refund_expiry_time) }} {{ expiry_flag }}</span></p>
                <p>退款金额：<span class="price">{{ '￥%0.2f'|format(course.refund_amount) }}</span>退款比例：<span class="price">{{ 100 * course.refund_percent }}%</span></p>
            </div>
        {% elseif confirm.item_type == 'package' %}
            {% set courses = confirm.item_info.courses %}
            {% for course in courses %}
                {% set expiry_flag = course.refund_expiry_time < time() ? '（已过期）' : '' %}
                <div class="order-item">
                    <p>课程名称：<span>{{ course.title }}</span></p>
                    <p>退款期限：<span>{{ date('Y-m-d H:i:s',course.refund_expiry_time) }} {{ expiry_flag }}</span></p>
                    <p>退款金额：<span class="price">{{ '￥%0.2f'|format(course.refund_amount) }}</span>退款比例：<span class="price">{{ 100 * course.refund_percent }}%</span></p>
                </div>
            {% endfor %}
        {% endif %}
    {%- endmacro %}

    <table class="layui-table order-table" lay-size="lg">
        <tr>
            <td>退款项目</td>
            <td>退款金额</td>
            <td>订单金额</td>
        </tr>
        <tr>
            <td>{{ item_info(confirm) }}</td>
            <td><span class="price">{{ '￥%0.2f'|format(confirm.refund_amount) }}</span></td>
            <td><span class="price">{{ '￥%0.2f'|format(order.amount) }}</span></td>
        </tr>
    </table>
    <br>
    {% if confirm.refund_amount > 0 %}
        <form class="layui-form layui-form-pane" method="post" action="{{ url({'for':'web.refund.create'}) }}">
            <div class="layui-form-item layui-form-text">
                <label class="layui-form-label">退款原因</label>
                <div class="layui-input-block">
                    <textarea class="layui-textarea" name="apply_note" lay-verify="required"></textarea>
                </div>
            </div>
            <br>
            <div class="layui-form-item text-center">
                <button class="layui-btn" lay-submit="true" lay-filter="go">申请退款</button>
                <input type="hidden" name="order_sn" value="{{ order.sn }}">
            </div>
        </form>
    {% else %}
        <div class="text-center">没有符合条件的退款项目</div>
    {% endif %}

{% endblock %}

{% block inline_js %}

    <script>
        layui.use(['jquery', 'layer'], function () {
            var index = parent.layer.getFrameIndex(window.name);
            parent.layer.title('申请退款', index);
        });
    </script>

{% endblock %}