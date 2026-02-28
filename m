Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3C0430BBA
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 21:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772313170; cv=none; b=JBGNR1bCAiEpNIX8NTrdsB1ijN2OxjjUfyXXeDLS4zm+HMB1Zdkhh4OAwGcSW11EGF2Al+GLPr599rHgbO+VYrWd3uj3wsLAoCPYAkou3F6CDFeApk2/QnEyjmOdEwdw9Io4+3i5FTrab3KCAjVtBLh3N01dMHPIBRfGaJ1t10Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772313170; c=relaxed/simple;
	bh=LVNdPoCszoOTuGSA29xqsmniMw0OBN+/sMcRxeRyuSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JFIoJT0sr8tQJBMVqGoIFzlmuo9YWaF2eVMT2rzhpHCcjAIIhsoitQFeMlUYVQ+5NxfHrSsvfhjPYIla1qMvcmIJFnvRjdVbafrSNEmSXB+yhdN/QV+N+yY0feYBOxuCU3o0/UA31vxeaE0Kjl/Gj7z3S6O7IEjIZUQ5ayo6OLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQn1FFJg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQn1FFJg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86372C116D0;
	Sat, 28 Feb 2026 21:12:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772313169;
	bh=LVNdPoCszoOTuGSA29xqsmniMw0OBN+/sMcRxeRyuSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IQn1FFJgA6zPj76ZI6DhpifM63w5SO4U1kCJxsd+Diz0TFwzHja5ln1bfCiMV+oUF
	 K9+eJqPakUVr3XyNtz075OcuzFOXiIfvFoX9v/EC5NJQVjaRoolZbekPL058s2fu4Z
	 pytD0IWvIPrBjRnid2TwCI4Y5olheMR5hQO315XUIw0DpR1/U4NndkD43yld6LYmoz
	 h6mW9alyZlTfq2BldWpds9ZT5D5PE9mdetKHU+7r6MRWrgr8aqPZv3eX4E34P3CDfW
	 vyqhMiHqUc1RtpRIeA4jhTFmmrmN+uIlzC00dwB0f2VcTC4Ectr0L6nIOVkQuBMYgI
	 FibnEAnK8vCiQ==
From: Jakub Kicinski <kuba@kernel.org>
To: jiawenwu@trustnetic.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	mengyuanlou@net-swift.com,
	netdev@vger.kernel.org,
	horms@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com
Subject: Re: [net-next,v2,7/8] net: wangxun: add Tx timeout process
Date: Sat, 28 Feb 2026 13:12:46 -0800
Message-ID: <20260228211246.4033548-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227073450.23680-8-jiawenwu@trustnetic.com>
References: <20260227073450.23680-8-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: wangxun: add Tx timeout process

Implement .ndo_tx_timeout to handle Tx side timeout event. When Tx timeout
event occur, it will triger driver into reset process.

> diff --git a/drivers/net/ethernet/wangxun/libwx/Makefile b/drivers/net/ethernet/wangxun/libwx/Makefile
> index a71b0ad77de3..c8724bb129aa 100644
> --- a/drivers/net/ethernet/wangxun/libwx/Makefile
> +++ b/drivers/net/ethernet/wangxun/libwx/Makefile
> @@ -4,5 +4,5 @@
>
>  obj-$(CONFIG_LIBWX) += libwx.o
>
> -libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o wx_ptp.o wx_mbx.o wx_sriov.o
> +libwx-objs := wx_hw.o wx_lib.o wx_ethtool.o wx_ptp.o wx_mbx.o wx_sriov.o wx_err.o
>  libwx-objs += wx_vf.o wx_vf_lib.o wx_vf_common.o

[ ... ]

> diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> index 4dd7de79431c..0ed33480b4f4 100644
> --- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
> +++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c

[ ... ]

> @@ -779,9 +803,11 @@ static int ngbe_probe(struct pci_dev *pdev,
>  	eth_hw_addr_set(netdev, wx->mac.perm_addr);
>  	wx_mac_set_default_filter(wx, wx->mac.perm_addr);
>
> +	ngbe_init_service(wx);
> +
>  	err = wx_init_interrupt_scheme(wx);
>  	if (err)
> -		goto err_free_mac_table;
> +		goto err_cancel_service;
>
>  	/* phy Interface Configuration */
>  	err = ngbe_mdio_init(wx);
> @@ -801,6 +827,9 @@ static int ngbe_probe(struct pci_dev *pdev,
>  	wx_control_hw(wx, false);
>  err_clear_interrupt_scheme:
>  	wx_clear_interrupt_scheme(wx);
> +err_cancel_service:
> +	timer_delete_sync(&wx->service_timer);
> +	cancel_work_sync(&wx->service_task);
>  err_free_mac_table:
>  	kfree(wx->rss_key);
>  	kfree(wx->mac_table);
> @@ -826,6 +855,8 @@ static void ngbe_remove(struct pci_dev *pdev)
>  	struct wx *wx = pci_get_drvdata(pdev);
>  	struct net_device *netdev;
>
> +	cancel_work_sync(&wx->service_task);
> +

Should timer_delete_sync(&wx->service_timer) be called before
cancel_work_sync(&wx->service_task) in ngbe_remove()?

The service timer is self-rearming and calls mod_timer() to reschedule
itself and wx_service_event_schedule() to queue work every 2 seconds:

drivers/net/ethernet/wangxun/libwx/wx_lib.c:wx_service_timer()
{
	...
	wx_service_event_schedule(wx);
	mod_timer(&wx->service_timer, ...);
}

If the timer fires after cancel_work_sync returns, it can queue new work
that runs concurrently with or after device teardown. The probe error path
shows the correct order:

ngbe_probe() error path:
err_cancel_service:
	timer_delete_sync(&wx->service_timer);
	cancel_work_sync(&wx->service_task);

This stops the timer first to prevent new work from being queued, then
cancels any pending work.
-- 
pw-bot: cr
