Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792462561;
	b=4Rjg0WIKkgLjkC5OIVOQu47YgmIFk1C3M9InpwowlY6OEyzafcfkeq+izLSZXRcFYJX4
	 FvJCxUWB0yISxHUDIbKeE16K+U4GJMq+cjxrwKtPOChYfvE2NnMvo0UJ9fZTkkTJK0WEg
	 ePhItBalzdL11avXF+N1nUE1htjEq4xxHSvDOPmxurwRiLaLutGz+gwwp8EXzyQM3dvsb
	 YTub1tfKUOoQZn0sIErPk5U5EJ4JdA/HQ+Xf7bMRGGCgdtBX39+BCBRqmCobgLCjTfgOo
	 DVsBoQDset+m0Do0LSQToBqkt3tuO5nZDqHanM+vuUTQQR3VnpnpU0mMvK6py6MMVBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792462561;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=gtZ8T9izfzsjweeSbfKQJNhM7I6ABBXW3hJHKFzZxaw=;
	b=TNpuLUiyV0BFy7zQBDGLJ8ljWo4W9h/7l4MNpW2azMyQaQcURqICrSqfgnFWdg/yoCxf
	 2Lg7sJQE9WA9vk4ft06AJDP26a9cregd8sgCeYSolL0eC+9SfvtI0/AG9R29cCk7Du29R
	 Qiu+zaww4yQTesMdIEVERZ4IJSGLwk9RaxCfKtbed3kMlc7dp6x3uUmpM8fMLP+CfwHFn
	 fCiTgZTOkZQ5VB0HQ45KErL4XLR2HeLiIMhGBxyhVE5sBmfobRF6qQiokbv2btAn9nSEr
	 hzqd2p5qQjYilZxJ6+9jlM8bsQjp+KaBojN1QMmGX5tMyFlaB++oggz/fm2du6qduwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cdOM4ow7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3DE606A31A;
	Tue, 20 Oct 2026 02:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cdOM4ow7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2471F000C4;
	Tue, 20 Oct 2026 02:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792462560;
	bh=gtZ8T9izfzsjweeSbfKQJNhM7I6ABBXW3hJHKFzZxaw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cdOM4ow7D+EGkUXgBAs5t7yiU5AoCm5gg6pvm3fYlO7gnLSYVOSV79TkMQvSHdHDx
	 shwGPw5Zf75SiaNrVRTf4RxCb4W6+fbQM4ZHuSQvzscNsabYGXtfMoWWOInd5TjiUY
	 NzRgYw49z1+SvYKm+YREc5LUPAgxL/G7gjQxI2U3fo1+FCsHmcKu1+B9A0LcyuPB07
	 BgDVL/yug6mT2nfP/fE4IvPU0FQNbk66d6i8tmqHNZkGytlwRQLO7V8XPgf6hvAW4R
	 /sHFMOiK5pjDvBEkH0QnVym9ix3GNb4FlYrw81vWXDYJ1nrx4xG6Rwm1l155UDIV38
	 4+5u5+jGQz2Gw==
Subject: Re: [PATCH net] net: hns: retire service work before releasing device
 resources
From: netdev-bot+sashiko@kernel.org
To: mhun512@gmail.com
Cc: shenjian15@huawei.com, shaojijie@huawei.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, ae878000@gmail.com
Date: Tue, 20 Oct 2026 02:15:59 +0000
Message-ID: <179246255949.3135.9443785297870382318@kernel.org>
In-Reply-To: <20261016020035.3621768-1-mhun512@gmail.com>
References: <20261016020035.3621768-1-mhun512@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 (2) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] hns_nic_service_task() now takes rtnl_lock() on every run of
  the 1 Hz service work, on every port, around…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is a
  reachable kernel BUG.
- [High] This problem wasn't introduced by this patch, but the remove
  path still races with an AE-register notifier callback that is already…

--

net: hns: retire service work before releasing device resources

This patch reorders hns_nic_dev_remove(). It now sets NIC_STATE_REMOVING,
unregisters the AE notifier, waits for any TX timeout already running, and
drains the service timer and work before unregister_netdev(). It also takes
RTNL earlier in hns_nic_reset_subtask() and wraps the link status update in
hns_nic_service_task() with RTNL.

> diff --git a/drivers/net/ethernet/hisilicon/hns/hns_enet.c b/drivers/net/ethernet/hisilicon/hns/hns_enet.c
> index e905f10b894e8..977f054b00c31 100644
> --- a/drivers/net/ethernet/hisilicon/hns/hns_enet.c
> +++ b/drivers/net/ethernet/hisilicon/hns/hns_enet.c

[ ... ]

> @@ -2058,7 +2059,14 @@ static void hns_nic_service_task(struct work_struct *work)
>  	struct hnae_handle *h = priv->ae_handle;
>  
>  	hns_nic_reset_subtask(priv);
> -	hns_nic_update_link_status(priv->netdev);
> +
> +	rtnl_lock();
> +	/* Keep linkwatch events within the netdev's registered lifetime. */
> +	if (!test_bit(NIC_STATE_DOWN, &priv->state) &&
> +	    !test_bit(NIC_STATE_REMOVING, &priv->state))
> +		hns_nic_update_link_status(priv->netdev);
> +	rtnl_unlock();

[Severity: Medium]
Can this hold the global RTNL mutex for 200 ms or more on every service
cycle?

hns_nic_service_timer() re-arms every SERVICE_TIMER_HZ and schedules this
work. That means every port now takes RTNL once a second. Before this
patch, RTNL was only taken when NIC_STATE2_RESET_REQUESTED was set.

On a port where h->phy_dev is set and the PHY mode is
PHY_INTERFACE_MODE_XGMII, the locked section runs genphy_read_status()
and then hns_nic_adjust_link():

hns_nic_adjust_link() {
    ...
		if (h->dev->ops->need_adjust_link(h, ndev->phydev->speed,
						  ndev->phydev->duplex)) {
			...
			netif_carrier_off(ndev);
			msleep(200);
			h->dev->ops->adjust_link(h, ndev->phydev->speed,
						 ndev->phydev->duplex);
    ...
}

On XGMAC ports, hns_xgmac_config() never sets mac_drv->need_adjust_link,
so hns_mac_need_adjust_link() always returns true:

hns_mac_need_adjust_link() {
    ...
	if (mac_ctrl_drv->need_adjust_link)
		return mac_ctrl_drv->need_adjust_link(mac_ctrl_drv,
			(enum mac_speed)speed, duplex);
	else
		return true;
}

So with the link up, msleep(200) runs under RTNL on every cycle. On AE v2,
hns_ae_adjust_link() also calls hns_ae_wait_flow_down(). This blocks
rtnetlink and every other RTNL user system-wide, and the delay adds up
across ports.

Is RTNL needed here for the reason given in the comment?
hns_nic_dev_remove() now sets NIC_STATE_REMOVING and calls
timer_shutdown_sync() and cancel_work_sync() before unregister_netdev().
Any running worker therefore finishes while the netdev is still
registered. The lock seems to add only serialization of the
NIC_STATE_DOWN check against ndo_stop.

[ ... ]

> @@ -2398,6 +2406,21 @@ static void hns_nic_dev_remove(struct platform_device *pdev)
>  	struct net_device *ndev = platform_get_drvdata(pdev);
>  	struct hns_nic_priv *priv = netdev_priv(ndev);
>  
> +	set_bit(NIC_STATE_REMOVING, &priv->state);
> +	if (priv->notifier_block.notifier_call)
> +		hnae_unregister_notifier(&priv->notifier_block);
> +	priv->notifier_block.notifier_call = NULL;

[Severity: High]
This is a pre-existing issue, but can hns_nic_dev_remove() still race with
an hns_nic_notifier_action() callback that is already running?

ae_chain is a RAW_NOTIFIER_HEAD. DSAF probe walks it with no lock:

hnae_ae_register() {
    ...
	ret = raw_notifier_call_chain(&ae_chain, HNAE_AE_REGISTER, NULL);
    ...
}

hnae_unregister_notifier() only calls raw_notifier_chain_unregister().
That unlinks the entry but does not wait for a callback that is already
running. DSAF probe and enet remove run under different device locks, so
nothing orders them.

Suppose the callback is inside hns_nic_try_get_ae() when remove starts:

CPU1 (DSAF probe)
hnae_ae_register()
  raw_notifier_call_chain()
    hns_nic_notifier_action()
      hns_nic_try_get_ae()
        hnae_get_handle()
        hns_nic_init_ring_data()
        register_netdev()

CPU2 (enet unbind)
hns_nic_dev_remove()
  set_bit(NIC_STATE_REMOVING, ...)
  hnae_unregister_notifier()
  timer_shutdown_sync() / cancel_work_sync()
  reg_state still NETREG_UNINITIALIZED -> skips unregister_netdev()
  ring_data still NULL -> skips hns_nic_uninit_ring_data()
  ae_handle still NULL -> skips hnae_put_handle()
  free_netdev()

Could free_netdev() then free a netdev that is partway through
registration? That would leak the handle, the module and cls_dev
references, and ring_data. The callback and remove could also both
release the handle at the same time.

After hns_nic_try_get_ae() returns, the callback also writes to priv:

	if (!hns_nic_try_get_ae(priv->netdev)) {
		hnae_unregister_notifier(&priv->notifier_block);
		priv->notifier_block.notifier_call = NULL;
	}

That write would land in freed memory, and the chain walk may then read
nb->next from the freed priv.

hns_nic_notifier_action() never checks NIC_STATE_REMOVING. Moving the
notifier unregistration to the top of remove makes the window smaller but
does not seem to close it.

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
> +
>  	if (ndev->reg_state != NETREG_UNINITIALIZED)
>  		unregister_netdev(ndev);

[Severity: High]
This isn't a bug introduced by this patch, but is
reg_state != NETREG_UNINITIALIZED the right test for unregister_netdev()?
The patch uses the same test for the new netif_tx_lock_bh() barrier. The
barrier itself is harmless, because alloc_netdev allocated the TX queues.

If register_netdevice() fails in netdev_register_kobject(), reg_state is
left as NETREG_UNREGISTERED:

net/core/dev.c:register_netdevice() {
    ...
	ret = netdev_register_kobject(dev);

	netdev_lock(dev);
	WRITE_ONCE(dev->reg_state, ret ? NETREG_UNREGISTERED : NETREG_REGISTERED);
	netdev_unlock(dev);

	if (ret)
		goto err_uninit_notify;
    ...
}

A NETDEV_REGISTER notifier veto also ends in NETREG_UNREGISTERED once
netdev_run_todo() runs.

hns_nic_try_get_ae() handles this as an ordinary failure through
out_reg_ndev_fail. hns_nic_dev_probe() then registers the AE notifier and
returns 0, so the driver stays bound. On a later unbind or rmmod:

hns_nic_dev_remove()
  unregister_netdev()
    ...
      unregister_netdevice_many_notify()
        BUG_ON(dev->reg_state != NETREG_REGISTERED);

Should both guards test reg_state == NETREG_REGISTERED instead?

There is a related case. If the AE notifier, which is still registered,
fires later, hns_nic_try_get_ae() calls register_netdev() again on the
same device. register_netdevice() would then hit:

	BUG_ON(dev->reg_state != NETREG_UNINITIALIZED);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016020035.3621768-1-mhun512%40gmail.com
