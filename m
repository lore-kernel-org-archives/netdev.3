Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792881780;
	b=t8H6kkiHilE4qh6pUPVELgOgyb/4D02EES9E6blc2Z3/O26OhF0GhhX13DPFc/XX+JA8
	 xEvC1ii1th+iCyDTQUMeDMf95LWU4AFSUpysY773h74uYuEzTZBaWkusK5Z6KLCKPp0Rw
	 c7TSOD1qGgwslN2FFBUH/itURHBwspWiNl6Jnt5+cD7IWIs0+uRxcGxLWyTPINlsXCVU9
	 rKNBEaZypaCPG4osqJRBU4WWk6zL3R+XbpGvMcLWgpPTTxr46YRuvb3hZR9ZNB1r8M/WO
	 NkkZ0owNVbiT2H7mtAPLrNO52U5yRmxawEvLg3RuPMUnaLoMJG4EXFzYr84d4oBmyiQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792881780;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=wf+P+A5liJam9Pg93ftnbZhlqsTVmpVJ3yNr8KFR810=;
	b=KFNtRpiS1dLuogAEMvFYaMbK86nrAD9n1YPKwPO454qx9sSWjnV16R0uHKhvESO+WkCp
	 GEoBMhTmAlobmumPR4CPacmZAwr1/ERvle1wj8JeGGUNHa900TsnmHt6Oo8rVCkiGFkd0
	 Yg0iH1GJicVIDegimyAPU4zYN+H91KMgVLco1ovFpri05UKNfyVx9udFKGbxRN/T4zZza
	 ROgK1KuBXb+R2l7qEHiLUGflGSBDvxBE2uWzBB84nkW8rTePNSR8pRdg14N6c9qhuzOXz
	 aKXd1nHwGIHm5Yna4hAL1vOY52cQeLIr9/gRTOhGahLIOchRedjxTYisjMW9T0ZJH7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KTn6GMa+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99CC5606A31A;
	Sat, 24 Oct 2026 22:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KTn6GMa+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DC81F01825;
	Sat, 24 Oct 2026 22:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792881780;
	bh=wf+P+A5liJam9Pg93ftnbZhlqsTVmpVJ3yNr8KFR810=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KTn6GMa+UFfb5q29sZ1bf10z5LXWI7UKCo949to3OxBeavfegaZxQO5FbX0kNMzi6
	 KPcZDdMStP3M5QYOEa4tqO7yTXWQKZCjZfM03elWUJnP5AhIdSlcBqH5fbtIiuM64m
	 i6RrSqTMpwgU3tNe4O5vav4XT0vPBJtjd3zErSZNOUgUH82sr9Hu0l/AtoojHvGreC
	 V3zOU4w/1oAMmSbQWpIdIUVHPMPMjzReKwPlFhfWDxBaJK0nAYIWctEwOUPxn3hLMT
	 majVlCB4KWw4GpspprxBQPYCfoKA95nR3sfXyzWfdRw/8gTie6odVzK8nWUlCgoxNE
	 m+t10ncc85EqQ==
Subject: Re: [PATCH net] net: emac: release DT PHY resources on teardown
From: netdev-bot+sashiko@kernel.org
To: rosenp@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 chunkeey@googlemail.com, linux-kernel@vger.kernel.org
Date: Sat, 24 Oct 2026 22:42:59 +0000
Message-ID: <179288177921.3134.4031881076104697843@kernel.org>
In-Reply-To: <20261020223002.1749284-1-rosenp@gmail.com>
References: <20261020223002.1749284-1-rosenp@gmail.com>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] emac_remove() calls the new emac_cleanup_phy() only after
  unregister_netdev() has returned, and the phylib PHY is still running…
- [Low] The new phy_disconnect() call in emac_cleanup_phy() runs without
  RTNL in both callers.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but busy_phy_map
  reservations are unbalanced.

--

net: emac: release DT PHY resources on teardown

This adds emac_cleanup_phy(), which disconnects phylib PHYs and
deregisters fixed-link PHYs. It is called from the err_unreg_commac
unwind in emac_probe() and from emac_remove() after unregister_netdev().

> diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
> index e7043523457c1..4124a90b18c49 100644
> --- a/drivers/net/ethernet/ibm/emac/core.c
> +++ b/drivers/net/ethernet/ibm/emac/core.c
> @@ -2810,6 +2810,16 @@ static int emac_init_phy(struct emac_instance *dev)
>  	return 0;
>  }
>  
> +static void emac_cleanup_phy(struct emac_instance *dev)
> +{
> +	struct device_node *np = dev->ofdev->dev.of_node;
> +
> +	if (dev->ndev->phydev && dev->phy.address >= 0)
> +		phy_disconnect(dev->ndev->phydev);

[Severity: Low]

Should RTNL be held around this phy_disconnect()? Neither caller takes
it. emac_remove() calls this after unregister_netdev() has already dropped
RTNL, and the err_unreg_commac unwind in emac_probe() never takes it.

For a PHY attached via of_phy_connect(), phy_disconnect() -> phy_detach()
reaches:

drivers/net/phy/phy_device.c:phy_detach() {
    ...
		hwprov = rtnl_dereference(dev->hwprov);
    ...
}

rtnl_dereference() is rcu_dereference_protected(p, lockdep_rtnl_is_held()).
With CONFIG_PROVE_RCU this would print a "suspicious
rcu_dereference_protected() usage" splat on every unbind of a phy-handle
EMAC. It would also print one on probe unwind once the PHY is attached,
for example when register_netdev() fails.

The netdev is unregistered or not yet registered at this point, so no
concurrent hwprov writer can exist. That makes this a lockdep splat
rather than a real race. smsc95xx_unbind() follows the same pattern.

Could emac_cleanup_phy() take rtnl_lock() around phy_disconnect()?

> +	if (of_phy_is_fixed_link(np))
> +		of_phy_deregister_fixed_link(np);
> +}
> +

[ ... ]

> @@ -3220,6 +3231,7 @@ static void emac_remove(struct platform_device *ofdev)
>  	unregister_netdev(dev->ndev);
>  
>  	cancel_work_sync(&dev->reset_work);
> +	emac_cleanup_phy(dev);

[Severity: High]

Can this leave ndev on the linkwatch event list after it has been freed?

unregister_netdev() has returned by now, but the phylib PHY attached by
emac_dt_phy_connect() is still running. emac_mdio_init_phy() starts it at
probe time:

static int emac_mdio_init_phy(struct mii_phy *phy)
{
	struct net_device *ndev = phy->dev;

	phy_start(ndev->phydev);
	return phy_init_hw(ndev->phydev);
}

The driver never calls phy_stop(), either from emac_close() or anywhere
else.

Suppose the interface is down at unbind time and the PHY link is up. This
happens if the interface was never opened, or if it was closed and the
link then toggled. Carrier is on, and unregister_netdev() does not clear
it. The new call then does:

emac_cleanup_phy()
  phy_disconnect()
    phy_stop()
      _phy_state_machine()     /* PHY_HALTED, phydev->link set */
        phy_link_down()
          phy_link_change(false)
            netif_carrier_off(ndev)
              linkwatch_fire_event()
                linkwatch_add_event()

netif_carrier_off() only returns early for NETREG_UNINITIALIZED.
linkwatch_add_event() does not check reg_state. So the unregistered ndev
is added to lweventlist, a netdev_hold() is taken, and linkwatch_work is
scheduled.

After emac_remove() returns, devres (devm_alloc_etherdev) calls
free_netdev(), and free_netdev() does not check link_watch_list. Within
about a second, linkwatch_event() -> __linkwatch_run_queue() would walk
lweventlist and dereference the freed net_device.

Before this patch, the PHY was torn down through the devm mdiobus
unregistration. phy_remove() only cancels state_queue and fires no
carrier events.

Would it help to call phy_stop() before unregister_netdev(), so the
carrier event gets flushed by netdev_run_todo()/linkwatch_sync_dev()?
Another option is to move phy_start()/phy_stop() into ndo_open/ndo_stop,
so the PHY is already halted with link down when phy_disconnect() runs.

>  
>  	if (emac_has_feature(dev, EMAC_FTR_HAS_TAH))
>  		tah_detach(dev->tah_dev, dev->tah_port);

[Severity: Medium]

This isn't a bug introduced by this patch, but it is in the same teardown
path. emac_cleanup_phy() guards on dev->phy.address >= 0, yet the
busy_phy_map update a few lines later in emac_remove() has no guard and
takes no lock:

drivers/net/ethernet/ibm/emac/core.c:emac_remove() {
    ...
	busy_phy_map &= ~(1 << dev->phy.address);
    ...
}

PHY-less and fixed-link instances set dev->phy.address = -1 in
emac_init_phy(), so this evaluates 1 << -1. That shift is undefined
behaviour, and UBSAN would report it as shift-out-of-bounds.

DT phy-handle instances get dev->phy.address = phy_dev->mdio.addr in
emac_dt_phy_connect() but never set a bit in busy_phy_map. Could this
clear a bit that another EMAC instance reserved during its own legacy
scan?

Bits are only set in the legacy scan loop in emac_init_phy():

			busy_phy_map |= 1 << i;

None of the emac_probe() error labels clear them. Do those addresses stay
reserved after a failed probe?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020223002.1749284-1-rosenp%40gmail.com
