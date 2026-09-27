Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622A73C8700;
	Sun, 27 Sep 2026 13:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790515076; cv=none; b=nYuQuh1Kmf80HPvQrzQ67yAWfBkOT+qdypUnRvd6ovEBdaRlVLng2cZTkHy/xlcEX8iAtqpxx6tsNBXcgmr6J4qefyue79zmlJJIi792IuCLyzi/R/PJwyY0ToF857HVoxXfZSt4pu01AcKAG95clrtNZxXko5NSz7Y2Yw30c2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790515076; c=relaxed/simple;
	bh=Rvj+GX0KeBSGW3bAxkUZn/cDy5Uev5pqi0+sFrDqYP8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=mm1J6fWEr3CkJBMvoLfQ6uA2ldNTLVC2qOTBUh5f/7V9LXjkxu8OcuEU9lKfn71Rh5rnUNYLAIHAsEk4RWRhrHDt3z0Yv62lGiBcP310rBO2rpxek6lw+3tKUZzvTUUdbP9SphWdzUVj3PCfWFkeEbLEDdbram8GbxMFVQXCYUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfYgWGR+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfYgWGR+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 605531F00893;
	Sun, 27 Sep 2026 13:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790515071;
	bh=+ESx11kR48L0Zb+ZsjyPc5kF3jPZYj5UPKu8WkwD0/s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=JfYgWGR+w+/3A/r34zBy5JFHRj1370ye4PeRVv5UsD9r/m+gAGbs+/4rLlKX6EYwl
	 JJrMuesWCkjr81sZfsSiUlOKbJGmwXrg+5KIFtZjKZcjoOAXGsouGJP+ke74QpXrV7
	 fScMtpdE0wvpEAtvxezT0Z9Hy5KJU+nPvTmNeJSDYBVzMePDukWrr2WkVhs5ENkeXg
	 2xTgmXunWWhbF9860m+F/yOx1ow7a74zB3dbpVpWh96nZNhRrsbBVu09JhUauLiMLX
	 5Q1N0MV19zkKnLymGx6O/4S+9hmOGbTq/UB/KfgiIXLY8r+FaACqk0IuayolK2wEAt
	 KWTh6Kz/rIV0w==
Subject: Re: [PATCH net-next 2/2] dpaa2-eth: DPNIs without a DPMAC should be
 virtual devlink ports
From: netdev-bot+sashiko@kernel.org
To: vjardin@free.fr
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, ioana.ciornei@nxp.com,
 vladimir.oltean@nxp.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 27 Sep 2026 13:17:50 +0000
Message-ID: <179051507094.2160803.2316498936147241429@kernel.org>
In-Reply-To: <20260923-for-upstream-dpaa2_ports-v1-2-b59c865edd00@free.fr>
References: <20260923-for-upstream-dpaa2_ports-v1-2-b59c865edd00@free.fr>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] dpaa2_eth_probe() calls dpaa2_eth_setup_irqs()
  (dpaa2-eth.c:4997), which enables DPNI_IRQ_EVENT_ENDPOINT_CHANGED,…
- [Low] The commit message says that making DPNIs without a DPMAC virtual
  means "only the DPNIs that serve a DPMAC report one, and \"p<dpmac…
- [Low] After this patch, a DPNI with no DPMAC is registered as
  DEVLINK_PORT_FLAVOUR_VIRTUAL.

--

dpaa2-eth: DPNIs without a DPMAC should be virtual devlink ports

This commit registers a DPNI's devlink port as DEVLINK_PORT_FLAVOUR_VIRTUAL
when the DPNI has no DPMAC endpoint at probe time. Otherwise the port is
DEVLINK_PORT_FLAVOUR_PHYSICAL and numbered by the DPMAC id.
dpaa2_eth_dl_port_check() now counts a virtual port as port number 0 when
it compares against the current endpoint.

> A virtual port has no phys_port_name, so only the DPNIs that serve a
> DPMAC report one, and "p<dpmac id>" never collides.

[Severity: Low]
Is this still true when the topology changes after probe?

dpaa2_eth_dl_port_add() picks the flavour and number once, from priv->mac
at probe time. When DPNI_IRQ_EVENT_ENDPOINT_CHANGED fires later,
dpni_irq0_handler_thread() connects or disconnects the MAC. It then only
calls dpaa2_eth_dl_port_check(), which prints a warning and keeps the old
attrs.

For example, DPNI A is probed while connected to dpmac.3 and registers a
physical "p3" port. dpmac.3 is then disconnected from A and connected to
DPNI B, which is probed afterwards (for example, created with restool and
found by the DPRC rescan). B also registers a physical "p3" port, so two
netdevs report phys_port_name "p3".

The same limit applies in two other cases:

- A DPNI probed with no endpoint stays virtual, with no phys_port_name,
  after a DPMAC is connected to it.
- A DPNI whose DPMAC was disconnected stays a physical port with no
  connector behind it.

The earlier patch in this series already says the registered attributes
cannot change at runtime, and it warns the user to rebind. So the issue
here is the wording.

Could the commit message limit the claim to endpoints that are fixed at
probe time, or that are followed by a rebind?

> diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-devlink.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-devlink.c
> index 8b2addd3f83ae..30e6cb2190dbd 100644
> --- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-devlink.c
> +++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-eth-devlink.c
> @@ -230,16 +230,23 @@ int dpaa2_eth_dl_port_add(struct dpaa2_eth_priv *priv)
>  	struct devlink_port *devlink_port = &priv->devlink_port;
>  	struct devlink_port_attrs attrs = {};
>  
> -	attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
>  	attrs.phys.port_number = dpaa2_eth_dl_port_number(priv);
> +	if (attrs.phys.port_number)
> +		attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL;
> +	else
> +		attrs.flavour = DEVLINK_PORT_FLAVOUR_VIRTUAL;
>  	devlink_port_attrs_set(devlink_port, &attrs);

[Severity: Medium]
Can this race with the endpoint changed IRQ thread during probe?

dpaa2_eth_probe() enables the IRQ before it sets up the devlink port:

dpaa2_eth_probe() {
    ...
	err = dpaa2_eth_setup_irqs(dpni_dev);
    ...
	err = dpaa2_eth_dl_port_add(priv);
    ...
}

dpaa2_eth_dl_port_number() reads the DPMAC id under mac_lock. The flavour
choice and the struct copy in devlink_port_attrs_set() happen after the
lock is dropped. dpaa2_eth_dl_port_check() reads priv->devlink_port.attrs
without taking any lock.

One possible interleaving:

probe thread:
dpaa2_eth_dl_port_add()
  dpaa2_eth_dl_port_number()        /* returns N */

IRQ thread:
dpni_irq0_handler_thread()
  dpaa2_eth_disconnect_mac()        /* priv->mac = NULL */
  dpaa2_eth_dl_port_check()
    /* attrs are still zeroed from alloc_etherdev_mq(), flavour reads
       as DEVLINK_PORT_FLAVOUR_PHYSICAL (0), registered = 0,
       current_number = 0, no warning */

probe thread:
  attrs.flavour = DEVLINK_PORT_FLAVOUR_PHYSICAL   /* number N */
  devlink_port_attrs_set()
  devlink_port_register()

The port is then registered as a physical "pN" port for a DPNI that no
longer has a DPMAC, and nothing is logged. In the reverse case, where a
DPMAC is connected inside this window, the check prints a spurious "port
number 0 is stale" warning.

The plain read and write of devlink_port.attrs at the same time also
looks like a data race that KCSAN would report.

Would any of these avoid the race?

- Register the devlink port before dpaa2_eth_setup_irqs().
- Hold mac_lock across the number read and devlink_port_attrs_set().
- Skip the check until the port is registered.

>  	return devlink_port_register(priv->devlink, devlink_port, 0);
>  }
>  
>  void dpaa2_eth_dl_port_check(struct dpaa2_eth_priv *priv)
>  {
> -	u32 registered = priv->devlink_port.attrs.phys.port_number;
> +	const struct devlink_port_attrs *attrs = &priv->devlink_port.attrs;
>  	u32 current_number = dpaa2_eth_dl_port_number(priv);
> +	u32 registered = 0;
> +
> +	if (attrs->flavour == DEVLINK_PORT_FLAVOUR_PHYSICAL)
> +		registered = attrs->phys.port_number;
>  
>  	if (registered == current_number)
>  		return;

[Severity: Low]
Is the warning that follows still accurate for a virtual port?

	netdev_warn(priv->net_dev,
		    "devlink port number %u is stale, the DPMAC endpoint is now %u (0: none); rebind the DPNI to update it\n",
		    registered, current_number);

When a virtual DPNI later gains a DPMAC, this prints "devlink port number
0 is stale, the DPMAC endpoint is now N".

Devlink core does not report a port number for virtual ports.
devlink_nl_port_attrs_put() emits DEVLINK_ATTR_PORT_NUMBER only for the
physical, cpu and dsa flavours. __devlink_port_phys_port_name_get()
returns -EOPNOTSUPP for virtual ports.

So the message names a port number that devlink port show never
displayed. It also does not say that the stale parts are the flavour and
the missing phys_port_name.

Could the wording be updated for the virtual case?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923-for-upstream-dpaa2_ports-v1-0-b59c865edd00%40free.fr
