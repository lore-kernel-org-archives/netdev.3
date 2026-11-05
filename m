Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793873314;
	b=mfg7A3RpyaiEWOpYbI4vpoRH78d6ZRCnoqVdozkGmFg6KedHC3Y69yqrLaWQjkog71XZ
	 cfEo3ZW7yT6m07Ux7cJOnpK3psYeBsgVvVKbBsVEWGG6vywbJ4jbaHZc0R/27NwQIrX14
	 3bSV/59HU8QpI51gpKqwQ15t3NM5IcihnMnUcxhyk1HUStMZ41RThq98aar+kBHl3vvSA
	 LJnp+icy4lSfLOm7Gvg3DPTtNZdjPDk4RK4bIrHmaCzWK2jjErFmVw2cH3SLo9wKWCdDt
	 LdZzvKYfMk9YIPGKSlF8TR/SJsQTqipZdXLqVYfdDg4Sdar/LQqoxjvj7ZDCr/zkyVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793873314;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=TEM5oG0EbwSOS98Fx4qqr6WHxDPmtVe3raulzRfg0YI=;
	b=tmtFIKM6AF/ZGVxGWhAeSrVbvzrE/G950IIITHgWSNBW63Txs9wbCX9j9yRdcLge57oi
	 yHSWL+vKAhphh5NFRxWFbAxiJ4xwpj8zH//2kNk+VweVs7dVVFOO2DqhdA+zckey1rkKm
	 LnT7jy++UGN3SUAuCSiVPuUSSgWXxtx1NUjHhFAQ8Tq2JuqBOgRrEYUjh8nvCgbbdfhva
	 v4ZBFHDkkW9tdSWLiO2QmR6oGf1CDAXqryDC8VW6I7DwlKvjyHB2Ed/AEOQlCDQ1T4OBG
	 jnQTZvsY0WQVBAfXn4zq8fjnZAigFNRWUJW0Fgw7wAlz8CTPfqvK7FfQx/ziDIY229A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XVw1Ne30;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5B3606EE86;
	Thu,  5 Nov 2026 10:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XVw1Ne30
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D9D1F00919;
	Thu,  5 Nov 2026 10:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793873313;
	bh=TEM5oG0EbwSOS98Fx4qqr6WHxDPmtVe3raulzRfg0YI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XVw1Ne30HCouQB1rwdBXS0bjIUenJoHnpLT80ZPc+Mc82gb3zxipikX7c7XaP8zTY
	 Hdlthv/tBNDBl3pwdCGK3UCM1Jv6O/IXCuhmnAXDxp95tY2xz5RN3dgGbw5IDsnRIG
	 0PGLpKaNEQpc7N9yYFCiHDR8ArS1Igmst9EZlJE3MekyXmkcFAP04HdP64RyZPq1AU
	 XgI5mGV1LqHwBc6vdArl4jSbQICyS+xGzfWUc5sHbezomj1Q5bi1vy7Rbs/LqrpEY/
	 748dFmw0C7esiu3ykmfoKH2bP8eq9fgxMAB5mpS1m1KRXNGveP1m0p82XKBTy+NTWG
	 ftiw1w+ecs+pA==
Subject: Re: [PATCH net v3 05/14] net: pse-pd: do not reach a freed PHY from
 the notification worker
From: netdev-bot+sashiko@kernel.org
To: github@szelinsky.de
Cc: o.rempel@pengutronix.de, kory.maincent@bootlin.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, broonie@kernel.org, lgirdwood@gmail.com,
 maxime.chevallier@bootlin.com, kyle.swenson@est.tech, ross@r-sc.ca,
 netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 05 Nov 2026 10:08:32 +0000
Message-ID: <179387331238.488856.9819726671704590547@kernel.org>
In-Reply-To: <20261103220217.1131971-6-github@szelinsky.de>
References: <20261103220217.1131971-6-github@szelinsky.de>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The patch changes what `pse_control::attached_phydev` means and
  how it must be locked, but the kernel-doc was not updated to match.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but
  `pse_send_ntf_worker()` uses the net_device without holding a…

--

net: pse-pd: do not reach a freed PHY from the notification worker

With this patch, pse_send_ntf_worker() looks up the pse_control and reads
attached_phydev under pse_list_mutex. It no longer relies on a reference
to the pse_control, so a removed PHY can no longer be reached. It also
clears attached_phydev and warns when a second PHY takes the same PI.

> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
> index eab7e25f2039b..af9eb29792706 100644
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c

[ ... ]

> @@ -268,6 +266,7 @@ pse_control_find_by_id(struct pse_controller_dev *pcdev, int id)
>  static struct net_device *pse_control_get_netdev(struct pse_control *psec)
>  {
>  	ASSERT_RTNL();
> +	lockdep_assert_held(&pse_list_mutex);
>  
>  	if (!psec || !psec->attached_phydev)
>  		return NULL;

[Severity: Low]
This isn't a bug, but should the kernel-doc be updated to match the new
rules?

pse_control_find_by_id() got a "Must be called with pse_list_mutex held"
note. The kernel-doc of pse_control_get_netdev() still only says:

 * Return: netdev pointer or NULL

The struct pse_control doc in pse_core.c also still describes the field as:

 * @attached_phydev: PHY device pointer attached by the PSE control

After this patch, pse_control_get_internal() sets attached_phydev to NULL
as soon as a second PHY shares the PI. It stays NULL while PHYs still hold
the pse_control.

The field can also now only be read under pse_list_mutex. That rule is
written down only in the block comment inside pse_send_ntf_worker().

Could the struct doc and the pse_control_get_netdev() doc mention the
locking requirement and the shared-PI NULL case?

[ ... ]

> @@ -1015,13 +1014,23 @@ static void pse_send_ntf_worker(struct work_struct *work)
>  		struct net_device *netdev;
>  		struct pse_control *psec;
>  
> -		psec = pse_control_find_by_id(pcdev, ntf.id);
> +		/* If attached_phydev is set, it names the only PHY that

[ ... ]

> +		 */
>  		rtnl_lock();
> +		mutex_lock(&pse_list_mutex);
> +		psec = pse_control_find_by_id(pcdev, ntf.id);
>  		netdev = pse_control_get_netdev(psec);
>  		if (netdev)
>  			ethnl_pse_send_ntf(netdev, ntf.notifs);

[Severity: High]
This is a pre-existing issue, but is the net_device itself still left
unprotected here?

The new locking keeps the phy_device alive. No reference is taken on
psec->attached_phydev->attached_dev, though.

ethnl_pse_send_ntf() dereferences that pointer in ethnl_fill_reply_header()
(dev->ifindex, dev->name) and in ethnl_multicast() (dev_net(dev)). Both
calls come after genlmsg_new(GFP_KERNEL), which can sleep.

Neither rtnl nor pse_list_mutex appears to keep the netdev alive. The
comment in phy_detach_internal() says:

		 * Drivers may detach without RTNL while dev is unregistered,

Also, free_netdev() asserts RTNL only while reg_state is
NETREG_UNREGISTERING. For a device that is already NETREG_UNREGISTERED it
goes straight to put_device().

As an in-tree example, hisi_femac_drv_remove() does:

	unregister_netdev(ndev);

	phy_disconnect(ndev->phydev);
	clk_disable_unprepare(priv->clk);
	free_netdev(ndev);

The last two calls there run without rtnl. Can this sequence happen?

worker                                 hisi_femac_drv_remove()
                                       unregister_netdev(ndev)
                                         (rtnl released)
rtnl_lock()
mutex_lock(&pse_list_mutex)
pse_control_get_netdev()
  returns attached_dev (still set)
ethnl_pse_send_ntf()
  genlmsg_new(GFP_KERNEL) sleeps
                                       phy_disconnect()
                                       free_netdev()
                                         put_device() frees the netdev
  ethnl_fill_reply_header(skb, netdev, ...)
    reads the freed netdev

The old worker also passed a netdev it held no reference to into
ethnl_pse_send_ntf(), so this predates the patch. The commit message only
covers the phy_device, and the code is unchanged at the end of the series.

Does the lifetime of the net_device need to be pinned here as well, in
addition to the phy_device?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103220217.1131971-1-github%40szelinsky.de
