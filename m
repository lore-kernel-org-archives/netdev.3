Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE07379C35;
	Sun, 27 Sep 2026 13:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790515074; cv=none; b=Fqaiw+RJyStIXjKFLgoyXtL97DPs5qV9o3XDtlItqamBe9l4AykrotlZQ10qh1zX/jESnM3vQr3yhVbqTEHt/cia5FkhkD95gc33shPIQXQdtYkSALnqZfeTlsQAQlvGJbzCFNs0RKUauGn1tKQqwcGtggDFulyXWInCYTxMh74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790515074; c=relaxed/simple;
	bh=ehAPXf1N5YPAbSkJGohYhfoCUuCi0NJhp5cZ9W40ejg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WRW9U0wS7D0s9I6LpWxFLS5zDGSv++USPL/CKd2tqfT2a/gX1vy2C6ctA5jzXGi7YoChmgH/FuPimOWbj3xqyfOxSy0nJN4bRxEDIayBVaYDiiJi4fK761ufnsU/LutrLyoCMziUw0Fg2e+Ai/RJCbKywoLStz6nrl4zpxdLF2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfieqZ+N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfieqZ+N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BAB51F000FF;
	Sun, 27 Sep 2026 13:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790515070;
	bh=SNTby+ZJfBPBO65NCLfxNLlVrsK2EF9fNY2XPiEaeRM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ZfieqZ+N2w5ggOafYJiZC/6jWGOPMLPOjWJbfsYNTqSB2vnjTn6Xb3vdX7jGWOREe
	 QR59kHbRuT0fFVCCEZg/fCUDXqfY5X3r9uwwwbpeJ16AKjSRzGjSkCrvxVVXsuD8Jy
	 putwzZZCCHj0Y23AkhGWIUdtYcymDetsyi7ncXERrMsBkiho3gy2wfwoVk2D63CLB+
	 55r4Jg4Wxn4AzjHI1MN2peVnhZXY7UL3XLfIHrfSlMyQNxL+7lTWDyRQCayNQAAVdw
	 L2eoPPwpcDj0BJ76enb6wQ9rIWQCsMCPQqmDuA2kBv6bJ+uIH5qlW0uEJ+Mymnj5sz
	 gANU2I93cZGsQ==
Subject: Re: [PATCH net-next 1/2] dpaa2-eth: use the DPMAC id as the devlink
 physical port number
From: netdev-bot+sashiko@kernel.org
To: vjardin@free.fr
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ioana.ciornei@nxp.com,
 vladimir.oltean@nxp.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 27 Sep 2026 13:17:49 +0000
Message-ID: <179051506971.2160803.13967739532547877580@kernel.org>
In-Reply-To: <20260923-for-upstream-dpaa2_ports-v1-1-b59c865edd00@free.fr>
References: <20260923-for-upstream-dpaa2_ports-v1-1-b59c865edd00@free.fr>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] dpaa2_eth_dl_port_check() gets its 'current' value from
  dpaa2_eth_dl_port_number(), which reads only the driver's cached…
- [Low] In dpaa2_eth_probe(), dpaa2_eth_setup_irqs() (dpaa2-eth.c:4997)
  enables the ENDPOINT_CHANGED IRQ before dpaa2_eth_dl_port_add()…

Pre-existing issues:
- [High] This problem was not introduced by this patch, but the new
  dpaa2_eth_dl_port_check() adds another priv access on the same path.

--

dpaa2-eth: use the DPMAC id as the devlink physical port number

This commit sets each DPNI's devlink physical port number to the id of
its connected DPMAC, so interfaces no longer all report p0 as
phys_port_name. Devlink port attributes cannot change after
registration. For that reason, the endpoint-changed IRQ handler logs a
warning when the DPMAC endpoint no longer matches the registered number.

> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-devlink.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-devlink.c
> index 8775c931106b4..8b2addd3f83ae 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-devlink.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-devlink.c
> @@ -213,16 +213,42 @@ void dpaa2_eth_dl_unregister(struct dpaa2_eth_priv *priv)

[ ... ]

>  int dpaa2_eth_dl_port_add(struct dpaa2_eth_priv *priv)
>  {
>  	struct devlink_port *devlink_port = &priv->devlink_port;
>  	struct devlink_port_attrs attrs = {};
>  
>  	attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
> +	attrs.phys.port_number = dpaa2_eth_dl_port_number(priv);
>  	devlink_port_attrs_set(devlink_port, &attrs);
>  	return devlink_port_register(priv->devlink, devlink_port, 0);
>  }
>  
> +void dpaa2_eth_dl_port_check(struct dpaa2_eth_priv *priv)
> +{
> +	u32 registered = priv->devlink_port.attrs.phys.port_number;
> +	u32 current_number = dpaa2_eth_dl_port_number(priv);

[Severity: Low]
Can this read of priv->devlink_port.attrs race with probe and remove?

In dpaa2_eth_probe(), the endpoint-changed IRQ is enabled before the
devlink port attributes are filled in:

dpaa2_eth_probe() {
    ...
	err = dpaa2_eth_setup_irqs(dpni_dev);
    ...
	err = dpaa2_eth_dl_port_add(priv);
    ...
}

dpaa2_eth_dl_port_check() reads attrs.phys.port_number without a lock
and without checking that the port is registered. The mac_lock only
covers the current_number side.

dpaa2_eth_dl_port_add() reads the DPMAC id under mac_lock. It only
publishes that id after dropping the lock, through the plain struct copy
in devlink_port_attrs_set().

Consider this interleaving:

probe:
dpaa2_eth_dl_port_add()
    dpaa2_eth_dl_port_number()   <- reads DPMAC id N, drops mac_lock

IRQ thread, ENDPOINT_CHANGED with had_mac == true:
dpaa2_eth_disconnect_mac()       <- priv->mac = NULL
dpaa2_eth_dl_port_check()
    registered = 0               <- attrs still zeroed
    current_number = 0           <- returns without a warning

probe:
    devlink_port_attrs_set()     <- publishes port_number = N
    devlink_port_register()

Wouldn't this register pN for a DPNI that no longer has a DPMAC, and
never print the warning? The attrs are zeroed by alloc_etherdev(), and
DEVLINK_PORT_FLAVOUR_PHYSICAL is 0, so registered reads as 0 here.

Now take the opposite order: DPMAC M is connected before
dpaa2_eth_dl_port_add() runs. That case seems to print a spurious
"0 is stale, now M" warning, and then M is registered correctly.

The unlocked read also races with the struct copy in
devlink_port_attrs_set(), which KCSAN would likely flag.

On the remove side, dpaa2_eth_remove() calls dpaa2_eth_dl_port_del()
before fsl_mc_free_irqs(). The check can therefore also run against a
port that is already unregistered.

This still seems to be present after the follow-up patch in this series.
That patch adds a read of attrs.flavour on the same unlocked path.

> +
> +	if (registered == current_number)
> +		return;
> +
> +	netdev_warn(priv->net_dev,
> +		    "devlink port number %u is stale, the DPMAC endpoint is now %u (0: none); rebind the DPNI to update it\n",
> +		    registered, current_number);
> +}

[ ... ]

> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
> index 6f1046c9cc515..def2d5c0e7f7e 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth.c
> @@ -4771,6 +4771,8 @@ static irqreturn_t dpni_irq0_handler_thread(int irq_num, void *arg)
>  			dpaa2_eth_disconnect_mac(priv);
>  		else
>  			dpaa2_eth_connect_mac(priv);
> +
> +		dpaa2_eth_dl_port_check(priv);

[Severity: Low]
Does the "current" value used by dpaa2_eth_dl_port_check() really
reflect the firmware endpoint?

dpaa2_eth_dl_port_number() only looks at the driver's cached priv->mac.
The warning text, however, says "the DPMAC endpoint is now %u (0: none)".

The return value of dpaa2_eth_connect_mac() is ignored here. Suppose
fsl_mc_get_endpoint() finds a real DPMAC but the connect then fails, for
example on a kzalloc failure, a dpaa2_mac_open() error, or
dpaa2_mac_connect() returning -EPROBE_DEFER or another error. In that
case priv->mac stays NULL and current_number is 0.

If the registered number is N, wouldn't the warning then say the
endpoint is 0 (none) while firmware actually has a DPMAC attached?

If the registered value is 0, registered == current_number and nothing
is printed. That happens even though the DPNI is now connected to a
DPMAC in firmware and its devlink attributes are stale. The
-EPROBE_DEFER case is especially quiet, because dpaa2_eth_connect_mac()
only reports it with netdev_dbg().

Also, when had_mac is true the handler only disconnects. Take a normal
disconnect followed by a reconnect to the same dpmac.N. The disconnect
prints the "stale ... rebind the DPNI" warning, but the reconnect, which
makes the attributes correct again, prints nothing. Could this push
users into a rebind that isn't needed?

This also seems to remain after the follow-up patch in the series, which
only changes how registered is computed.

[Severity: High]
This is a pre-existing issue and was not introduced by this patch, but
the new dpaa2_eth_dl_port_check() call adds another priv access on this
path. Can dpni_irq0_handler_thread() run after priv has been freed?

dpaa2_eth_setup_irqs() installs the handler with
devm_request_threaded_irq(). Neither dpaa2_eth_remove() nor the probe
error unwind calls devm_free_irq() or synchronize_irq(). Both only call
fsl_mc_free_irqs(), which just returns the IRQ resources to the pool:

drivers/bus/fsl-mc/fsl-mc-allocator.c:fsl_mc_free_irqs() {
    ...
	for (i = 0; i < irq_count; i++) {
		irqs[i]->mc_dev = NULL;
		fsl_mc_resource_free(&irqs[i]->resource);
	}

	mc_dev->irqs = NULL;
}

Both paths then free the portal and the netdev:

dpaa2_eth_remove() {
    ...
	fsl_mc_free_irqs(ls_dev);
    ...
	fsl_mc_portal_free(priv->mc_io);
    ...
	free_netdev(net_dev);
}

devres only releases the managed IRQ after the remove or probe callback
returns. Suppose a LINK_CHANGED or ENDPOINT_CHANGED thread is already
running in that window, for example blocked on the shared mc_io portal.
Wouldn't it use the freed portal through dpni_dev->mc_io (set to
priv->mc_io in dpaa2_eth_setup_dpni())? It would also touch priv->mac,
priv->mac_lock and now priv->devlink_port.attrs, all of which live in
the freed netdev.

A link flap from the remote partner seems enough to hit this. The flap
would have to arrive during unbind, or during a late probe failure after
dpaa2_eth_setup_irqs() succeeded.

>  	}
>  
>  	return IRQ_HANDLED;

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923-for-upstream-dpaa2_ports-v1-0-b59c865edd00%40free.fr
