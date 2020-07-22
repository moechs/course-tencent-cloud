<?php

namespace App\Http\Web\Controllers;

use App\Services\Frontend\Order\OrderInfo as OrderInfoService;
use App\Services\Frontend\Refund\RefundCancel as RefundCancelService;
use App\Services\Frontend\Refund\RefundConfirm as RefundConfirmService;
use App\Services\Frontend\Refund\RefundCreate as RefundCreateService;
use App\Services\Frontend\Refund\RefundInfo as RefundInfoService;
use Phalcon\Mvc\View;

/**
 * @RoutePrefix("/refund")
 */
class RefundController extends Controller
{

    /**
     * @Get("/confirm", name="web.refund.confirm")
     */
    public function confirmAction()
    {
        $sn = $this->request->getQuery('sn');

        $service = new OrderInfoService();

        $order = $service->handle($sn);

        $service = new RefundConfirmService();

        $confirm = $service->handle($sn);

        $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
        $this->view->setVar('order', $order);
        $this->view->setVar('confirm', $confirm);
    }

    /**
     * @Post("/create", name="web.refund.create")
     */
    public function createAction()
    {
        $service = new RefundCreateService();

        $service->handle();

        $content = [
            'location' => $this->url->get(['for' => 'web.my.refunds']),
            'msg' => '申请退款成功',
        ];

        return $this->jsonSuccess($content);
    }

    /**
     * @Get("/info", name="web.refund.info")
     */
    public function infoAction()
    {
        $sn = $this->request->getQuery('sn');

        $service = new RefundInfoService();

        $refund = $service->handle($sn);

        $this->view->setRenderLevel(View::LEVEL_ACTION_VIEW);
        $this->view->setVar('refund', $refund);
    }

    /**
     * @Post("/cancel", name="web.refund.cancel")
     */
    public function cancelAction()
    {
        $sn = $this->request->getPost('sn');

        $service = new RefundCancelService();

        $service->handle($sn);

        $content = [
            'location' => $this->url->get(['for' => 'web.my.refunds']),
            'msg' => '取消退款成功',
        ];

        return $this->jsonSuccess($content);
    }

}
