Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB1AA47D450;
	Mon, 19 Oct 2026 07:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792393252; cv=none; b=cv1KmLf1k0fub5drR4hcQo1QGa7etT7jHqg9dbnrIFALYuFTwH+pKg7GpLTNWmL6sykZkFjaqgVwDkb8mByD19AF6L5EsROmneyveaF9oZQGw88z3xRv6z00a95jhDA560CeZW2MQavB6G1qeqwfwK7R0BaeFRkl06zSnue8GiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792393252; c=relaxed/simple;
	bh=o9ccJtBQN/UHaebcgJ1AB8L/RyzZ0eVWVRDgn2iPHMI=;
	h=Message-ID:Date:MIME-Version:CC:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Qbo7LaCoUzE24tiQSyVl2ysZ50Nl4mCB3esWr3VN7DLO2zi+0uKq/7KF+wPW/jtJmtZcf+LEZeqKPRxSYLle04hXKe2n8858PFcsyyAtiJpZZJjY7DO+L6zojxuqJ0fd4q4cxTMihUOO7q4Z1KTJSGYu/09BmONfcDt/GKCkCxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=odZIim5j; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="odZIim5j"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=uznnWvmHPQA48ZAqcGlW3kshcHeIrSRenmgmGp7j/Qc=;
	b=odZIim5jb8qGPFxAcWSOTVbPewXiSpKNEUtDtxDItD9PkR0iQpskiEKH9cPLs6wkP4O1AfEpJ
	9iiQRkxbp9elw1H6dpm1Z20MVcvP6eiZxTJakU/f7Q32T7uFh8WDtmsYqXKVZnXgrICoJG6UKSf
	bRHO8/Dt1KrQJsmRWBfP9F4=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4j7RJh3TXzzRhrr;
	Mon, 19 Oct 2026 15:00:36 +0800 (CST)
Received: from kwepemo500018.china.huawei.com (unknown [7.202.195.199])
	by mail.maildlp.com (Postfix) with ESMTPS id 8DE8540579;
	Mon, 19 Oct 2026 15:00:39 +0800 (CST)
Received: from [10.67.121.233] (10.67.121.233) by
 kwepemo500018.china.huawei.com (7.202.195.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 19 Oct 2026 15:00:38 +0800
Message-ID: <e17bcdcf-3ae6-4444-ae18-aed0f98d5a6b@huawei.com>
Date: Mon, 19 Oct 2026 15:00:37 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
CC: <shaojijie@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Ijae Kim <ae878000@gmail.com>
Subject: Re: [PATCH net] net: hns: retire service work before releasing device
 resources
To: Myeonghun Pak <mhun512@gmail.com>, Jian Shen <shenjian15@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>
References: <20261016020035.3621768-1-mhun512@gmail.com>
From: Jijie Shao <shaojijie@huawei.com>
In-Reply-To: <20261016020035.3621768-1-mhun512@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemo500018.china.huawei.com (7.202.195.199)


on 2026/10/16 10:00, Myeonghun Pak wrote:
> The remove path releases ring, PHY and accelerator resources before
> canceling service work, allowing use-after-free. A pending worker can
> also reinitialize the device or publish linkwatch events after
> unregister.
>
> Set REMOVING, synchronize an in-flight TX timeout, then shut down the
> service timer and drain work before unregister invokes ndo_stop.
> Serialize reset and link-update state checks and operations with
> unregister under RTNL.
>
> Compile-tested with Clang 22.1.2 (W=1); not tested on hardware.
>
> This issue was identified as part of our ongoing research while
> reviewing kernel code.
>
> Fixes: b5996f11ea54 ("net: add Hisilicon Network Subsystem basic ethernet support")
> Assisted-by: LLM
> Co-developed-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Ijae Kim <ae878000@gmail.com>
> Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
> ---
>   drivers/net/ethernet/hisilicon/hns/hns_enet.c | 37 ++++++++++++++-----
>   1 file changed, 27 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
> index e905f10b894e..977f054b00c3 100644
> --- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
> +++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
> @@ -2024,21 +2024,22 @@ static void hns_nic_reset_subtask(struct hns_nic_priv *priv)
>   		return;
>   	clear_bit(NIC_STATE2_RESET_REQUESTED, &priv->state);
>   
> -	/* If we're already down, removing or resetting, just bail */
> +	rtnl_lock();
> +	/* Serialize the reset decision with ndo_stop and unregister. */
>   	if (test_bit(NIC_STATE_DOWN, &priv->state) ||
>   	    test_bit(NIC_STATE_REMOVING, &priv->state) ||
>   	    test_bit(NIC_STATE_RESETTING, &priv->state))
> -		return;
> +		goto out;
>   
>   	hns_nic_dump(priv);

Since hns_nic_dump() can be highly time-consuming, is it really appropriate
to execute it inside the rtnl_lock critical section? Holding the global
RTNL lock for a long period might block the entire network control path
and impact system responsiveness.


>   	netdev_info(priv->netdev, "try to reset %s port!\n",
>   		    (type == HNAE_PORT_DEBUG ? "debug" : "service"));
>   
> -	rtnl_lock();
>   	/* put off any impending NetWatchDogTimeout */
>   	netif_trans_update(priv->netdev);
>   	hns_nic_net_reinit(priv->netdev);
>   
> +out:
>   	rtnl_unlock();
>   }
>   
> @@ -2058,7 +2059,14 @@ static void hns_nic_service_task(struct work_struct *work)
>   	struct hnae_handle *h = priv->ae_handle;
>   
>   	hns_nic_reset_subtask(priv);
> -	hns_nic_update_link_status(priv->netdev);
> +
> +	rtnl_lock();
> +	/* Keep linkwatch events within the netdev's registered lifetime. */
> +	if (!test_bit(NIC_STATE_DOWN, &priv->state) &&
> +	    !test_bit(NIC_STATE_REMOVING, &priv->state))
> +		hns_nic_update_link_status(priv->netdev);
> +	rtnl_unlock();
> +
>   	h->dev->ops->update_led_status(h);
>   	hns_nic_update_stats(priv->netdev);
>   
> @@ -2398,6 +2406,21 @@ static void hns_nic_dev_remove(struct platform_device *pdev)
>   	struct net_device *ndev = platform_get_drvdata(pdev);
>   	struct hns_nic_priv *priv = netdev_priv(ndev);
>   
> +	set_bit(NIC_STATE_REMOVING, &priv->state);
> +	if (priv->notifier_block.notifier_call)
> +		hnae_unregister_notifier(&priv->notifier_block);
> +	priv->notifier_block.notifier_call = NULL;
> +
> +	/* Join a TX timeout that passed the REMOVING check before work drain. */
> +	if (ndev->reg_state != NETREG_UNINITIALIZED) {
> +		netif_tx_lock_bh(ndev);
> +		netif_tx_unlock_bh(ndev);
> +	}
> +
> +	/* Stop the timer and drain work before ndo_stop touches the hardware. */
> +	timer_shutdown_sync(&priv->service_timer);
> +	cancel_work_sync(&priv->service_task);

The commit message states "Serialize ... with unregister under RTNL",
but cancel_work_sync() has now been moved before unregister_netdev(),
which already drains the service_task.
Is the RTNL serialization in hns_nic_reset_subtask() still necessary?

> +
>   	if (ndev->reg_state != NETREG_UNINITIALIZED)
>   		unregister_netdev(ndev);
>   
> @@ -2411,12 +2434,6 @@ static void hns_nic_dev_remove(struct platform_device *pdev)
>   	if (!IS_ERR_OR_NULL(priv->ae_handle))
>   		hnae_put_handle(priv->ae_handle);
>   	priv->ae_handle = NULL;
> -	if (priv->notifier_block.notifier_call)
> -		hnae_unregister_notifier(&priv->notifier_block);
> -	priv->notifier_block.notifier_call = NULL;
> -
> -	set_bit(NIC_STATE_REMOVING, &priv->state);
> -	(void)cancel_work_sync(&priv->service_task);
>   
>   	/* safe for ACPI FW */
>   	of_node_put(to_of_node(priv->fwnode));
