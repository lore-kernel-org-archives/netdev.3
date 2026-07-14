Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3DD232AAA0
	for <netdev@vger.kernel.org>; Tue, 14 Jul 2026 09:11:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784020287; cv=none; b=DHWLG8kaiWJZpiqsMzEJpZ2UFa51IN4V+H0S50vK7K5ZEztjxl1RwHW0X4r1l0Vjx9gHZnZOdkZa4dJL9E49cQtbSF63+IFE+q5iRl3VrZof9LWW+Ubg4tNwJkmkqgYR8J1Z+W+eV4huaHFWEoQuiwi8dnCMP1qmpTZvjpUWY+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784020287; c=relaxed/simple;
	bh=hmqYnkqLMl5fodv6f58MXefjHkuvGk/CLmAhE37t90k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T0OKitooIaMy/iMyZB9mIvZqcgpr/D5q5WN3jvs7pUHq0u5geqzKMUZVkOQoH3CUTV/thRm7+pNCBN+0FjFgK3nkK1x11+atKE276iCsUXjELC+mzqlzDjjZMhIkhGEy8lxM/Qi09kn8l7K1h9kfxM51Kojw33CG52/OG316AHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mWFGx/eG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mWFGx/eG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DC81F00A3A;
	Tue, 14 Jul 2026 09:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784020286;
	bh=IINPYP0zFv5P6kZBIYvDO4JsKAiXHzz0lpzI0/NUFlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mWFGx/eGkGLANtU2vK2cWxFT9ebPV2xAH+gh/2CQ6OAnxpmqSMgnIzL9yipEZ+Snr
	 TgJ686HUE89CMW3Y2lTfRoa30rKXYCK946ZkVKkwbQfuDF0x579EvCkwyNMjNmPLzV
	 ZzXbM36yVSay8aNZUBxUPfr7st9vmkZl1GmADLT92AdEb+VxET9PLKAAeSrm0ub943
	 5UvrT1Xc1ekFejy8WpuaQv4oIJK9FfehqINsHx9X76VgCVnuUl0k1u3HWcJeaehVt6
	 cTZWM0TMH1qUaZvECobHOg1ANRVepZ/UKd3czWZHCxCsNJWvS0pIrVtJdcBGuGgUh3
	 vu/Wd3VKvdJgA==
From: Simon Horman <horms@kernel.org>
To: jiawenwu@trustnetic.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	mengyuanlou@net-swift.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	linux@armlinux.org.uk,
	aleksandr.loktionov@intel.com,
	jacob.e.keller@intel.com,
	michal.swiatkowski@linux.intel.com,
	kees@kernel.org,
	joe@dama.to,
	leitao@debian.org,
	shaojijie@huawei.com,
	u.kleine-koenig@baylibre.com,
	weirongguang@kylinos.cn,
	larysa.zaremba@intel.com,
	fabio.baltieri@gmail.com
Subject: Re: [PATCH net-next v10 4/5] net: wangxun: implement soft quiesce for PCIe error recovery
Date: Tue, 14 Jul 2026 10:11:13 +0100
Message-ID: <20260714091113.1815787-1-horms@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707061455.39564-5-jiawenwu@trustnetic.com>
References: <20260707061455.39564-5-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://sashiko.dev
---
--- Patch [4]: [PATCH net-next v10 4/5] net: wangxun: implement soft quiesce for PCIe error recovery ---
commit 1b8a0e5e722ffb89c8fe24492e80dca44f3410f2
Author: Jiawen Wu <jiawenwu@trustnetic.com>

net: wangxun: implement soft quiesce for PCIe error recovery

This commit introduces a soft quiesce path for PCIe error recovery. It adds
WX_STATE_DOWN and WX_STATE_RESETTING state checks to subtasks to block
execution, explicitly avoiding a cancellation of the service task to speed
up recovery.

> diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> index c8a4822d38194..a65312c8078fa 100644
> --- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
> +++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
[ ... ]
> @@ -3383,5 +3383,23 @@ void wx_service_timer(struct timer_list *t)
>  }
>  EXPORT_SYMBOL(wx_service_timer);
>  
> +void wx_soft_quiesce(struct wx *wx)
> +{
> +	if (!netif_running(wx->netdev) ||
> +	    test_and_set_bit(WX_STATE_DOWN, wx->state))
> +		return;
> +
> +	pci_clear_master(wx->pdev);
> +	netif_tx_stop_all_queues(wx->netdev);
> +	netif_carrier_off(wx->netdev);
> +	netif_tx_disable(wx->netdev);
> +	wx_napi_disable_all(wx);
> +	wx_ptp_quiesce(wx);
> +
> +	clear_bit(WX_FLAG_NEED_PF_RESET, wx->flags);
> +	timer_delete_sync(&wx->service_timer);

[Severity: High]
The commit message notes the service task is deliberately not cancelled here
to avoid delaying PCIe error recovery. However, does omitting
cancel_work_sync(&wx->service_task) open a race window with the subtasks
that rely on the WX_STATE_DOWN flag?

> +}
> +EXPORT_SYMBOL(wx_soft_quiesce);

> diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> index a8773712cff82..a7bde03a98feb 100644
> --- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
> +++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
[ ... ]
> @@ -94,6 +94,10 @@ static void txgbe_module_detection_subtask(struct wx *wx)
>  {
>  	int err;
>  
> +	if (test_bit(WX_STATE_DOWN, wx->state) ||
> +	    test_bit(WX_STATE_RESETTING, wx->state))
> +		return;
> +

[Severity: High]
Does this state check adequately protect against concurrent MMIO access
during a PCIe reset?

If the task passes this check, it subsequently sleeps for 200ms:

txgbe_main.c:txgbe_module_detection_subtask() {
    ...
    if (!test_and_clear_bit(WX_FLAG_NEED_MODULE_RESET, wx->flags))
        return;

    /* wait for SFF module ready */
    msleep(200);

    err = txgbe_identify_module(wx);
    ...
}

If wx_soft_quiesce() runs on another CPU during this msleep(), it will set
WX_STATE_DOWN and begin a hardware reset. 

When the task wakes up from the sleep, will it call txgbe_identify_module()
and perform MMIO reads (such as rd32(wx, WX_GPIO_EXT)) while the device is
in reset?

Could this time-of-check to time-of-use race lead to Master Aborts or
fatal PCIe errors during AER recovery?

>  	if (!test_and_clear_bit(WX_FLAG_NEED_MODULE_RESET, wx->flags))
>  		return;
