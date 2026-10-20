Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792502242;
	b=ZtnRuanOX01Z7HJBdrJw2ZYKm8qzzWk5X6DOC/BCNg1VOAOIiKkj+2m87UvO6/aVTVcu
	 /UYGHsFr/KZ+8FsNcWfP0RKI6+nfXIzz0Gn1AqSGacAuMHzO5vG/bYmS60rDmYx1+s3l9
	 lxpVoLFIRo1kwUjTTqf5rE4PCyigNHhmFuS3nbGH4Cb3tRh8+jyX3Px+A5QtqQeR3LZzw
	 I/DuO4Vh+Ey6YGVPCHS8ApnieEfRmYfObldbx6ZHn1T9EUIWUsGVZJ4KL78mxrXvJ+T6i
	 PNvf7rITLUeUds6iwmfvMqfKQ2862J2IrktKVGk1Jpo5pCd0e4T2L2Kf2IPkMOebgxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792502242;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=YdVnxrvkhHt9mjANzsaK5MP3THwExPR4ircmNBidooE=;
	b=Cd9GeOGNyybUPSndMECbxePwzKt86aA/iSt5lX+I95/VXk9WdjIEtTlhPpiUHnIytpT7
	 gMGUIhrYQxHubJSpQ5aG01eoptzLeYimUnOn/moh6LK6eiFXABqJr0Ykay+F+iAa9B+B0
	 xumRnllcem5pe3JqSeRc6J7yWF8NopWB3ZtRWHrIbUM/lse2ErhYiyLXw4bA9/Gxqg8pP
	 8VIe77dGXGaJ70Ta4+3GdkGFyQ+xFcXvef8H9uRuDJ79eTh2WZZy1FdiC514aZUhr13yw
	 vhmdiRukISVzoUOYx6KVTreOK6C63y6U0c4E8sPJDTogFtiV0fU84F/7bLR0oD/zZTA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UzxpwiBM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3731F606A31C;
	Tue, 20 Oct 2026 13:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UzxpwiBM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F6F81F000C4;
	Tue, 20 Oct 2026 13:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792502241;
	bh=YdVnxrvkhHt9mjANzsaK5MP3THwExPR4ircmNBidooE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=UzxpwiBMNkZVpY2VxiZgi8WbHrD9Btojc9Ame/mtdjTofHtvZFMjKaCRLEbcNTorz
	 3ZeIFKwxTa8OZH/4EjId0R8n/N0XyIgXWupxAQLoA7LAbuYjLdtr6mbRnZ0Z04lZc1
	 x7s8bZRN0UEoqOCoyrUAIQbVmL7PdVQfMs/wfYeH/Q9EWiuDvnk1jhFE98+qYsdHrt
	 X5XhMNjHhyKNB6QQ/QSFebeiCA0gdaBwpyOSdNfUDoMTDWbYCqKjWJ52t4+/7idIST
	 mhfyJ1+D/GKk0oPTO6OrWPQjggu6vU8An7LBCUZzCBcwNgWhOtf6QehtzmVSJHHYtS
	 zlgNiY/apP6FQ==
Subject: Re: [PATCH net-next] net: ti: icssm-prueth: use
 dev_close()/dev_open() in icssm_prueth_change_mode()
From: netdev-bot+sashiko@kernel.org
To: saivarun@couthit.com
Cc: danishanwar@ti.com, parvathi@couthit.com, rogerq@kernel.org,
 pmohan@couthit.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, afd@ti.com,
 basharath@couthit.com, horms@kernel.org, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, pratheesh@ti.com,
 vigneshr@ti.com, praneeth@ti.com, srk@ti.com, j-rameshbabu@ti.com,
 m-malladi@ti.com, rogerq@ti.com, krishna@couthit.com, mohan@couthit.com
Date: Tue, 20 Oct 2026 13:17:20 +0000
Message-ID: <179250224009.3135.4883643346445826814@kernel.org>
In-Reply-To: <20261016105206.167094-1-saivarun@couthit.com>
References: <20261016105206.167094-1-saivarun@couthit.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 2 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new br_members rollback in
  icssm_prueth_port_offload_fwd_mark_update() undoes the wrong port.
- [High] The bug this patch fixes (a failed direct ndo_open() leaves
  IFF_UP/__LINK_STATE_START set with NAPI disabled, so a later…
- [Medium] In icssm_prueth_change_mode(), the switch from
  netdev_ops->ndo_stop()/ndo_open() to dev_close()/dev_open() turns an…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  prueth->hw_bridge_dev is shared by both MAC ports and each side only…

--

net: ti: icssm-prueth: use dev_close()/dev_open() in icssm_prueth_change_mode()

This patch replaces the direct ndo_stop()/ndo_open() calls in
icssm_prueth_change_mode() with dev_close()/dev_open(). If dev_open()
fails, it closes the ports already reopened and falls back to EMAC mode.
It also undoes the br_members update from icssm_prueth_ndev_port_link()
when the switch to switch mode fails.

> diff --git a/drivers/net/ethernet/ti/icssm/icssm_prueth.c b/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> index b42c98e861e08..d50aa0992c33d 100644
> --- a/drivers/net/ethernet/ti/icssm/icssm_prueth.c
> +++ b/drivers/net/ethernet/ti/icssm/icssm_prueth.c

[ ... ]

> @@ -1115,11 +1115,7 @@ static int icssm_prueth_change_mode(struct prueth *prueth,
>  		if (!portstatus[i])
>  			continue;
>  
> -		ret = ndev->netdev_ops->ndo_stop(ndev);
> -		if (ret < 0) {
> -			netdev_err(ndev, "failed to stop: %d", ret);
> -			return ret;
> -		}
> +		dev_close(ndev);

[Severity: Medium]
Is a full administrative down/up of every running port intended here?

dev_close() goes through __dev_close_many(). That sends
NETDEV_GOING_DOWN and NETDEV_DOWN, clears IFF_UP and emits RTM_NEWLINK.
dev_open() sends NETDEV_UP. The old ndo_stop()/ndo_open() calls produced
none of these events.

So each switch to switch mode (the second port joins the bridge) and each
switch back to EMAC mode (the last port leaves) now affects every running
port, including the sibling port that has nothing to do with the bridge
operation. On those ports it:

  - flushes IPv6 addresses (with the default keep_addr_on_down=0)
  - removes routes and multicast memberships
  - runs br_stp_disable_port() and then re-enables STP on bridge ports
  - shows link-down events to userspace

For example, say eth0 leaves the bridge and gets an IP configuration.
When eth1 leaves later, eth0 is dev_close()'d and dev_open()'d. Won't
eth0 lose that configuration?

dev_close() is also called on the joining port in the middle of
br_add_if(), from inside that port's own NETDEV_CHANGEUPPER notifier.

Now consider a dev_open() failure. The err_dev_open path added below
closes ports 0..i-1 and port i stays down. Ports after i were closed in
the first loop and are never reopened. So every port that was up ends up
administratively down. The "Fall back to EMAC mode" step only changes
eth_type.

The commit message says this "keeps IFF_UP consistent" but doesn't
mention these user-visible side effects. Could they be described in the
commit message, or avoided?

>  	}
>  
>  	if (mode == PRUSS_ETHTYPE_EMAC || mode == PRUSS_ETHTYPE_SWITCH) {
> @@ -1141,14 +1137,25 @@ static int icssm_prueth_change_mode(struct prueth *prueth,
>  		if (!portstatus[i])
>  			continue;
>  
> -		ret = ndev->netdev_ops->ndo_open(ndev);
> +		ret = dev_open(ndev, NULL);
>  		if (ret < 0) {
>  			netdev_err(ndev, "failed to start: %d", ret);
> -			return ret;
> +			goto err_dev_open;
>  		}
>  	}

[Severity: High]
This fixes the double napi_disable() in icssm_prueth_change_mode(). Is
the same pattern still reachable through the PM callbacks?

icssm_prueth_suspend() calls icssm_emac_ndo_stop() directly on each
running interface. That disables NAPI but leaves the interface
administratively up. icssm_prueth_resume() then does:

	if (netif_running(ndev)) {
		ret = icssm_emac_ndo_open(ndev);
		if (ret < 0) {
			netdev_err(ndev, "failed to start: %d", ret);
			return ret;
		}
		netif_device_attach(ndev);
	}

icssm_emac_ndo_open() can fail before napi_enable(). Examples are
icssm_prueth_sw_emac_config(), icssm_prueth_sw_init_fdb_table(),
icss_iep_init(), the PRU boot and icssm_emac_request_irqs(). The
interface is then left IFF_UP and detached, with NAPI disabled. Any later
ports in the loop are not reopened.

A later ip link set dev down, or unregister on driver unbind, then
reaches:

__dev_close_many()
    ops->ndo_stop(dev)    /* still called after a DETACH event */
        icssm_emac_ndo_stop()
            napi_disable()

napi_disable_locked() then loops on:

	while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC))
		usleep_range(20, 200);

Both bits are still set from the first disable, so it spins forever while
holding RTNL. Should the resume path get the same fix?

>  
>  	return 0;
> +
> +err_dev_open:
> +	for (j = 0; j < i; j++) {
> +		if (portstatus[j])
> +			dev_close(prueth->emac[j]->ndev);
> +	}
> +
> +	/* Fall back to EMAC mode */
> +	prueth->eth_type = PRUSS_ETHTYPE_EMAC;
> +
> +	return ret;
>  }

[ ... ]

> @@ -1661,11 +1670,20 @@ static int icssm_prueth_port_offload_fwd_mark_update(struct prueth *prueth)
>  	 */
>  	if (set_val && !PRUETH_IS_SWITCH(prueth)) {
>  		ret = icssm_prueth_change_mode(prueth, PRUSS_ETHTYPE_SWITCH);
> -		if (ret < 0)
> +		if (ret < 0) {
>  			dev_err(prueth->dev, "Failed to enable Switch mode\n");
> -		else
> +			emac = prueth->emac[0];
> +			spin_lock_irqsave(&emac->addr_lock, flags);
> +
> +			prueth->br_members &= ~BIT(emac->port_id);
> +			if (!prueth->br_members)
> +				prueth->hw_bridge_dev = NULL;

[Severity: High]
Does this roll back the right port? emac[0] is MAC0 (port_id MII0). The
bit that needs undoing was set by icssm_prueth_ndev_port_link() for
netdev_priv(ndev), the port that is joining. That port isn't passed to
this helper.

set_val is only 1 when br_members has both BIT(PRUETH_PORT_MII0) and
BIT(PRUETH_PORT_MII1) set. So this failure always comes from the second
port to join.

In the usual order (eth0/MII0 joins first, eth1/MII1 second), this clears
MII0 and leaves br_members == BIT(MII1). But eth0 is still a bridge port,
and the core has removed eth1.

The driver never gets an unlink event for eth1 afterwards:

  - __netdev_upper_dev_link() handles a NETDEV_CHANGEUPPER notifier
    error with only __netdev_adjacent_dev_unlink_neighbour()
  - br_add_if() jumps to err5, which skips netdev_upper_dev_unlink()

After the rollback, br_members still has the other port's bit set. Can
the hw_bridge_dev = NULL assignment here ever run?

When eth0 later leaves or br0 is deleted,
icssm_prueth_ndev_port_unlink() clears the MII0 bit, which is already
clear. br_members stays BIT(MII1), so hw_bridge_dev is never reset. The
driver holds no reference on the bridge, so once br0 is freed the pointer
dangles.

One possible sequence:

  ip link set eth0 master br0
  ip link set eth1 master br0   (change_mode fails, MII0 bit cleared)
  ip link del br0               (hw_bridge_dev not reset)
  ip link set eth0 up           (dev_open -> ndo_set_rx_mode)

icssm_emac_ndo_set_rx_mode() then walks the freed bridge's mc list:

	if (prueth->hw_bridge_dev) {
		netdev_for_each_mc_addr(ha, prueth->hw_bridge_dev) {

The SWITCHDEV_OBJ_ID_HOST_MDB delete path in icssm_switchdev.c has the
same dereference. Every later bridge link also fails with -EOPNOTSUPP,
because hw_bridge_dev != br_ndev.

The pre-patch code left the same dangling pointer, so this only fixes it
when MII0 happens to be the second port to join.

Could the rollback be done in icssm_prueth_ndev_port_link() instead, or
could the joining emac be passed in, so it uses that port's port_id and
addr_lock?

> +
> +			spin_unlock_irqrestore(&emac->addr_lock, flags);

[Severity: High]
This isn't a bug introduced by this patch, but is prueth->hw_bridge_dev
protected consistently between the two ports?

Both MACs share it, but each side only takes its own port's addr_lock.
icssm_prueth_ndev_port_unlink() clears it under the unlinking port's
emac->addr_lock, plus RTNL:

	spin_lock_irqsave(&emac->addr_lock, flags);

	if (!prueth->br_members)
		prueth->hw_bridge_dev = NULL;

icssm_emac_ndo_set_rx_mode() on the other port walks it under that
port's own emac->addr_lock and netif_addr_lock:

	if (prueth->hw_bridge_dev) {
		netdev_for_each_mc_addr(ha, prueth->hw_bridge_dev) {
			hash = icssm_emac_get_mc_hash(ha->addr,
						      emac->mc_filter_mask);
			icssm_emac_mc_filter_bin_allow(emac, hash);
		}
	}

The two lock sets don't overlap. ndo_set_rx_mode can also run without
RTNL here, for example from an unprivileged IPv6 multicast join:

ipv6_sock_mc_join()->dev_mc_add()

Suppose the unlink sets hw_bridge_dev to NULL while the other port is
inside this loop. The loop condition reloads
&prueth->hw_bridge_dev->mc.list (the out-of-line
icssm_emac_mc_filter_bin_allow() call forces the reload). That near-NULL
address never matches the real list head.

Could the walk then circle the bridge's mc list forever with IRQs
disabled? If the NULL is seen as the loop starts, it would be a near-NULL
dereference instead.

The bridge's mc list is also walked without the bridge's own address
lock.

> +		} else {
>  			dev_info(prueth->dev,
>  				 "TI PRU ethernet now in Switch mode\n");
> +		}
>  	}

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261016105206.167094-1-saivarun%40couthit.com
