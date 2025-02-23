{% extends 'templates/main.volt' %}

{% block content %}

    {% set sort_val = request.get('sort','trim','latest') %}
    {% set pager_url = url({'for':'home.question.pager'}, params) %}
    {% set hot_questions_url = url({'for':'home.widget.hot_questions'}) %}
    {% set top_answerers_url = url({'for':'home.widget.top_answerers'}) %}
    {% set my_tags_url = url({'for':'home.widget.my_tags'},{'type':'question'}) %}

    <div class="breadcrumb">
        <span class="layui-breadcrumb">
            <a href="/">首页</a>
            <a><cite>问答</cite></a>
        </span>
    </div>

    <div class="layout-main">
        <div class="layout-content">
            <div class="content-wrap wrap">
                <div class="layui-tab layui-tab-brief search-tab">
                    <ul class="layui-tab-title">
                        {% for sort in sorts %}
                            {% set class = sort_val == sort.id ? 'layui-this' : 'none' %}
                            <li class="{{ class }}"><a href="{{ sort.url }}">{{ sort.name }}</a></li>
                        {% endfor %}
                    </ul>
                    <div class="layui-tab-content">
                        <div class="layui-tab-item layui-show">
                            <div id="question-list" data-url="{{ pager_url }}"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="layout-sidebar">
            {% if auth_user.id > 0 %}
                <div class="sidebar" id="sidebar-my-tags" data-url="{{ my_tags_url }}"></div>
            {% endif %}
            <div class="sidebar" id="sidebar-hot-questions" data-url="{{ hot_questions_url }}"></div>
            <div class="sidebar" id="sidebar-top-answerers" data-url="{{ top_answerers_url }}"></div>
        </div>
    </div>

{% endblock %}

{% block include_js %}

    {{ js_include('home/js/question.list.js') }}

{% endblock %}