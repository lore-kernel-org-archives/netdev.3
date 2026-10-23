Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792792947;
	b=gV4WduAOOKutXeB2pV9+2L0UNh977IgcKJmCvQMvTve+OpDKpnjzEx+3Y56hwVvkaKyi
	 vBi0W//Vdt7endBCPx42TYV15M7BTBC96FDJjgZfimtGGvGIxxn8bGqKh5LAZWym97FF4
	 vMkBocvwC1whV50FfmvoN3xTFA5uA1HImDYodTYkeEa2y3aGw/jKx5/gDEJKKhF84WVAW
	 FleVdCIaPzdFNZilUPe4cJdxFWcezGqGSWqeoPPV9bqKLK1IkeodBOTafKaIqPqh082Nf
	 uFHKfTdbZKWejlX/VaH19CD3ZbCQlVM0s/MSQOHZuZ9o6vi9D74KHdfZ5uhRPcooXdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792792947;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hWFZf5qzoOP3Eqtf+b0CgnFBhXe2isRGlfWcl89SBTU=;
	b=IL0qkVEPcGCokb5ZIxvwP72ciAFR6GKeyFoUk5hgnRDlYIeMmpWlkclWVMrhnPr8kPgO
	 DHhxwYfh1vyuSEtpwq07tjw+y0rJq7zcdt59BAXH6irQM0TIsjKrr9sqBeEeE8rw72LZ2
	 l1W+4JX1w/33asU0a4MNSsMY6O9BV0L3fWbmtZxi9rHR/Yhswn3tvUk9LOelsRCpXRRs4
	 D9AXstkBRDsN9IX1ThlFYrUtOfnZ5UQQk9GrzbCTUHrm+1sXyFBTEgDxQz1pf1T9bzf8Q
	 vZjiLSj/ZfS42+6KQT0ljPOKGVu6/wKpG0pCga76pq1HFarWN0gXbFFWm9pndi3wFvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kZ0zYtvS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B718606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 22:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kZ0zYtvS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD6331F01825;
	Fri, 23 Oct 2026 22:02:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792792946;
	bh=hWFZf5qzoOP3Eqtf+b0CgnFBhXe2isRGlfWcl89SBTU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kZ0zYtvSdetKX65EiQnlxX7mpvKHhggzFk1E6O0rKWGjMPYzsQZyQWnwontvF/BLT
	 isEOsZ2IBRkprzO7mqKyEWE0zOutKisTu6sdZLmceHnfgpHG2UdSQe+hrdxQBw7jgT
	 7aPcD9q67Sad9xJS1oc6LmKmrpSI6U3noqA0WIA8isvBKQgnB7D1kbYUVN1/YOYlyn
	 +rSvpxPpccQ2m2EFG7ptPBgf7l9yt5nT/YWzazZ9bwilUnMXxGWe8WKZl0DOy2RQhU
	 CvSnEpc10ncSY0VsgUSUYVgzoOWCVDbw8VFnd/rU60DyASEr6EHk97b/HtO4IS4yLO
	 I4TgConjHVVhQ==
From: Jakub Kicinski <kuba@kernel.org>
To: mhun512@gmail.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	shaojijie@huawei.com,
	ae878000@gmail.com
Subject: Re: [PATCH net v2] net: hns: stop service work before device resource teardown
Date: Fri, 23 Oct 2026 15:02:25 -0700
Message-ID: <20261023220225.3348758-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261019233213.792821-1-mhun512@gmail.com>
References: <20261019233213.792821-1-mhun512@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: hns: stop service work before device resource teardown

This patch moves the NIC_STATE_REMOVING setting and the service_task
cancellation in hns_nic_dev_remove() ahead of unregister_netdev() and the
ring/AE teardown. It also joins any in-flight ndo_tx_timeout() and shuts
down the service timer first. hns_nic_reset_subtask() now rechecks the
DOWN, REMOVING and RESETTING flags after taking RTNL.

> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
> index e905f10b894e..595fe3514056 100644
> --- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
> +++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
> @@ -2035,10 +2035,17 @@ static void hns_nic_reset_subtask(struct hns_nic_priv *priv)
>  		    (type == HNAE_PORT_DEBUG ? "debug" : "service"));
>  
>  	rtnl_lock();
> +	/* ndo_stop may have run while the diagnostic dump was in progress. */
> +	if (test_bit(NIC_STATE_DOWN, &priv->state) ||
> +	    test_bit(NIC_STATE_REMOVING, &priv->state) ||
> +	    test_bit(NIC_STATE_RESETTING, &priv->state))
> +		goto out;

[Severity: Low]
This is a pre-existing issue, but can the NIC_STATE_RESETTING test added
here ever be true?

NIC_STATE_RESETTING and NIC_STATE_REINITING are only set by the
test_and_set_bit()/usleep_range() loops in hns_nic_net_reset() and
hns_nic_net_reinit():

hns_nic_net_reset() {
	while (test_and_set_bit(NIC_STATE_RESETTING, &priv->state))
		usleep_range(1000, 2000);
	...
	clear_bit(NIC_STATE_RESETTING, &priv->state);
}

Every caller appears to hold RTNL already. hns_nic_net_reset() is reached
from the ethtool self-test path (__lb_up(), __lb_down(),
hns_nic_self_test()) and from hns_nic_net_reinit(). The only caller of
hns_nic_net_reinit() is hns_nic_reset_subtask(), under rtnl_lock().

That would make this recheck dead code once rtnl_lock() is held. The bit
loops also use flags as locks, which lockdep cannot see. Would
lockdep_assert_rtnl_held() or a real mutex be clearer there?

> +
>  	/* put off any impending NetWatchDogTimeout */
>  	netif_trans_update(priv->netdev);
>  	hns_nic_net_reinit(priv->netdev);
>  
> +out:
>  	rtnl_unlock();
>  }

[Severity: Medium]
This isn't a bug introduced by this patch, but the rest of
hns_nic_service_task() still runs without RTNL after this rtnl_unlock():

hns_nic_service_task() {
	...
	hns_nic_reset_subtask(priv);
	hns_nic_update_link_status(priv->netdev);
	h->dev->ops->update_led_status(h);
	hns_nic_update_stats(priv->netdev);
	...
}

hns_nic_net_down() (ndo_stop) only stops the timer. It does not wait for
a service_task that is already queued or running:

hns_nic_net_down() {
	...
	(void) timer_delete_sync(&priv->service_timer);
	netif_tx_stop_all_queues(ndev);
	netif_carrier_off(ndev);
	netif_tx_disable(ndev);
	priv->link = 0;
	...
}

Could a worker in hns_nic_update_link_status()->hns_nic_adjust_link()
then call netif_carrier_on() and netif_tx_wake_all_queues() on the stopped
device? It could also set priv->link back to 1, or call
need_adjust_link()/adjust_link() on the hardware while ops->stop() is
running.

With an XGMII PHY, the worker also calls genphy_read_status() and
hns_nic_adjust_link() without phydev->lock. That can run at the same time
as the phylib state machine runs the same adjust_link callback.

hns_ae_update_stats() appears to read only registers and ring->stats, and
ndo_stop does not free those. So the result looks like inconsistent
carrier/link state, not memory corruption. The v2 notes say RTNL around
the link-status update was dropped on purpose.

>  
> @@ -2398,6 +2405,18 @@ static void hns_nic_dev_remove(struct platform_device *pdev)
>  	struct net_device *ndev = platform_get_drvdata(pdev);
>  	struct hns_nic_priv *priv = netdev_priv(ndev);
>  
> +	set_bit(NIC_STATE_REMOVING, &priv->state);
> +
> +	/* Join any ndo_tx_timeout() which might have queued service_task. */
> +	if (ndev->reg_state != NETREG_UNINITIALIZED) {
> +		netif_tx_lock_bh(ndev);
> +		netif_tx_unlock_bh(ndev);
> +	}
> +
> +	/* Stop the timer producer before draining the service worker. */
> +	timer_shutdown_sync(&priv->service_timer);
> +	cancel_work_sync(&priv->service_task);
> +
>  	if (ndev->reg_state != NETREG_UNINITIALIZED)
>  		unregister_netdev(ndev);

[Severity: High]
This is a pre-existing issue, but what serialises hns_nic_dev_remove()
against the HNAE AE-registration notifier?

If hns_nic_try_get_ae() failed during probe, the NIC stays on the raw
ae_chain. Remove then reads ndev->reg_state without a lock, both in the
new tx lock join above and here. It tears down ring_data, the PHY and
ae_handle, and only then calls hnae_unregister_notifier().

Meanwhile, a DSAF AE probe on another CPU can run:

hnae_ae_register()
  raw_notifier_call_chain(&ae_chain, HNAE_AE_REGISTER, NULL)
    hns_nic_notifier_action()
      hns_nic_try_get_ae()
        hnae_get_handle()
        hns_nic_init_phy()
        hns_nic_init_ring_data()
        register_netdev(ndev)

ae_chain is a RAW_NOTIFIER_HEAD. hnae_register_notifier() and
hnae_unregister_notifier() take no lock, and hns_nic_notifier_action()
does not check NIC_STATE_REMOVING.

If remove saw NETREG_UNINITIALIZED (or ring_data == NULL) before the
callback finished, can free_netdev() run on a netdev that is now
registered? In that case free_netdev() frees the queues and then hits:

	BUG_ON(dev->reg_state != NETREG_UNREGISTERED);

The core would also keep a reference to the freed netdev, and the new
handle and rings would leak. Remove can also set priv->ae_handle to NULL
while the callback is still using it.

raw_notifier_chain_unregister() only unlinks the entry and does not wait
for a running callback. Moving the unregister earlier would not be enough
on its own.

This does not affect the service work fix in this patch: REMOVING is set
first and the timer is shut down. The commit message also says the
notifier ordering was left alone on purpose.

[ ... ]
-- 
pw-bot: cr
