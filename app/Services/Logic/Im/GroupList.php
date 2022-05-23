<?php
/**
 * @copyright Copyright (c) 2021 深圳市酷瓜软件有限公司
 * @license https://opensource.org/licenses/GPL-2.0
 * @link https://www.koogua.com
 */

namespace App\Services\Logic\Im;

use App\Builders\ImGroupList as ImGroupListBuilder;
use App\Library\Paginator\Query as PagerQuery;
use App\Repos\ImGroup as ImGroupRepo;
use App\Services\Logic\Service as LogicService;

class GroupList extends LogicService
{

    public function handle()
    {
        $pagerQuery = new PagerQuery();

        $params = $pagerQuery->getParams();

        $params['published'] = 1;
        $params['deleted'] = 0;

        $sort = $pagerQuery->getSort();
        $page = $pagerQuery->getPage();
        $limit = $pagerQuery->getLimit();

        $groupRepo = new ImGroupRepo();

        $pager = $groupRepo->paginate($params, $sort, $page, $limit);

        return $this->handleGroups($pager);
    }

    protected function handleGroups($pager)
    {
        if ($pager->total_items == 0) {
            return $pager;
        }

        $builder = new ImGroupListBuilder();

        $groups = $pager->items->toArray();

        $users = $builder->getUsers($groups);

        $baseUrl = kg_cos_url();

        $items = [];

        foreach ($groups as $group) {

            $group['avatar'] = $baseUrl . $group['avatar'];
            $group['owner'] = $users[$group['owner_id']] ?? new \stdClass();

            $items[] = [
                'id' => $group['id'],
                'type' => $group['type'],
                'name' => $group['name'],
                'avatar' => $group['avatar'],
                'about' => $group['about'],
                'user_count' => $group['user_count'],
                'msg_count' => $group['msg_count'],
                'owner' => $group['owner'],
            ];
        }

        $pager->items = $items;

        return $pager;
    }

}
