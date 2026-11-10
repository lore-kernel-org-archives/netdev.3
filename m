Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273377;
	b=yNFWht37fnGRUx6qJ2FdCYPSoBio3ODX28O1aw3ryJeBnPlOWoO2lPLYEo7hIZJeXQal
	 y0TDmcBjD0j7j8eHBiGr65dWlWQm6bijdQNtP9oOUL3Q6VO2flpoDoz+75VX/jX2LaZNY
	 rRS9oJj/l8JpdOrn+dxZb+lEKpYLPTHUKxdJ2VPoVR8nfVPG1Xr5vcgmvokESMSV2Z409
	 XpaZJ3kxWa3axqFhJ1Zy856BzfTNguK7NYUQI3dRcV3GW+uHZ6ugYyS6O38VRe3az1OJt
	 2eKbTliEaQFSaEc9uJgJ9kWoq+NtDlTbh5S7eORandKchBaDP8c1M6+7+SHmJOqZ4WQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273377;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MAiiscM7CAXaJM+Fc3kMybdqrpzytpvjPiVCbVKPxE0=;
	b=rcK+YwMZLnyzT67SCyjEHXf9QiZT1KCC4wOAGFBkiAwJtftUssGm+spPA3ySwhBkxws+
	 OIcs+0SCZBpZ+PuFzIlFxDCOuWJtvS0AnFVLvyhqjR1IWhruKhmSUeLJpcIgB5EximZ2n
	 CIZ8C2yOpjTfOgO0OR3q/99HKOjzS65g1814k65gieiIQhvpFZFvMlbAtELipV1vOVcdk
	 iVM/uq6SI621iWXQIpChVKLA+KT7ItwIsbukO9I34HkmENIKHchEb+FIqYN3HB1QaLiZR
	 obnMCnxoXhKwZIfjicrxsFRvCe0Vv0KjLmETWvCzPG1sMErIiEYrjaozdtNUH5Gfl1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oEKD4HGX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42AE606A325
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 01:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oEKD4HGX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C96C1F008A3;
	Tue, 10 Nov 2026 01:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273376;
	bh=MAiiscM7CAXaJM+Fc3kMybdqrpzytpvjPiVCbVKPxE0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oEKD4HGXF/6yCfp/Phx2NFJcPI4hAeQe/hmDP7scNJB8Kb/JdZkFH5l9tWY0nTQpB
	 bOjRyPlvdsr4mAtW+OTi3HJXSeXrShGcm1bUTAPzRrJq93x5uGPaU9m2UZ9z0tdwh0
	 dryu5CBYLiUu3r6oSMWrdhfpr6r60E0K9eFDRRJUuDp+2ZTdfpMfcaCbv+nSetTTma
	 tfJDmjgm9COxe++lJ+yW/H9zRI+TxsTjVGPBS+aCaNjMdMa9HsfhsHoFiccDViLjc9
	 R8DJrdeS8kyhbUmMDAr3bfTJCXOKuygmck2Ind1ztWFS+5V3TYNlSUKEZRYX2qW3W3
	 dK9E9QqAP9pfw==
From: Jakub Kicinski <kuba@kernel.org>
To: linusw@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	ulli.kroll@googlemail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	pabeni@redhat.com,
	mirq-linux@rere.qmqm.pl,
	mhun512@gmail.com,
	edumazet@kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next v6 02/15] net: ethernet: cortina: Keep PHY-less port bound for shared IRQ
Date: Mon,  9 Nov 2026 17:16:14 -0800
Message-ID: <20261110011614.1733382-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103-gemini-ethernet-fixes-3-v6-2-c4b5ff8a65d8@kernel.org>
References: <20261103-gemini-ethernet-fixes-3-v6-2-c4b5ff8a65d8@kernel.org>
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
net: ethernet: cortina: Keep PHY-less port bound for shared IRQ

This patch keeps a Gemini port child bound as an IRQ-only port when its
DT node has neither phy-handle nor fixed-link. That way the threaded
software free queue handler on port 1 stays registered. Ports are now
published to the parent under RTNL only after their IRQ and optional
netdev are ready, and geth_resize_freeq() refuses to run until both ports
are published.

> The software free queue interrupt is routed through port 1 even on
> boards which only connect a PHY to port 0. Since PHY setup was moved
> into probe, the PHY-less port fails to bind and releases the threaded
> handler needed by the shared queue.

[Severity: Low]
Does this description understate what happens on the parent tree?

Before this patch, gemini_ethernet_port_probe() published the port before
PHY setup:

	if (!id)
		geth->port0 = port;
	else
		geth->port1 = port;

	gemini_ethernet_init(geth);
	...
	ret = gmac_setup_phy(netdev);

port is embedded in netdev_priv() of a devm_alloc_etherdev_mqs() netdev.
On dns-313, nas4210b, nas4220b, rut1xx, wbd111 and dir-685,
ethernet-port@1 has no phy-mode or phy-handle. gmac_setup_phy() therefore
fails, and devres frees the netdev while geth->port1 still points into it.

The next gmac_open() on port 0 then reaches geth_resize_freeq(), which
used to do:

	other_netdev = geth->port1->netdev;

	if (other_netdev && netif_running(other_netdev))
		return -EBUSY;

Isn't that a use-after-free of the port 1 private data?

The commit message also doesn't mention the new phy_disconnect() on the
register_netdevice() failure path. Before this patch, a register_netdev()
failure jumped to unprepare with the PHY still attached to a netdev that
devres was about to free.

Could the commit message describe the dangling geth->port1 pointer and
the phy_disconnect() fix?

> diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
> index bf7652b04f1ba..79c0463642928 100644
> --- a/drivers/net/ethernet/cortina/gemini.c
> +++ b/drivers/net/ethernet/cortina/gemini.c

[ ... ]

> @@ -2600,6 +2632,16 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
>  	if (ret)
>  		goto unprepare;
>  
> +	if (!of_property_present(np, "phy-handle") &&
> +	    !of_phy_is_fixed_link(np)) {
> +		dev_info(dev, "no PHY, keeping port for shared IRQ\n");
> +		port->netdev = NULL;
> +		rtnl_lock();
> +		gemini_port_publish(port);
> +		rtnl_unlock();
> +		return 0;
> +	}
> +
>  	ret = gmac_setup_phy(netdev);
>  	if (ret) {
>  		netdev_err(netdev,

[ ... ]

> @@ -2607,9 +2649,15 @@ static int gemini_ethernet_port_probe(struct platform_device *pdev)
>  		goto unprepare;
>  	}
>  
> -	ret = register_netdev(netdev);
> -	if (ret)
> +	rtnl_lock();
> +	ret = register_netdevice(netdev);
> +	if (!ret)
> +		gemini_port_publish(port);
> +	rtnl_unlock();
> +	if (ret) {
> +		phy_disconnect(netdev->phydev);
>  		goto unprepare;
> +	}

[Severity: Medium]
Does this fully cover a port 1 that describes a PHY but fails to set it
up?

Only a node with neither phy-handle nor fixed-link takes the IRQ-only
publish path. Port 1 can instead have phy-handle (wbd222, ssi1328) or
fixed-link (sl93512r, sq201). If gmac_setup_phy() then fails, probe still
does goto unprepare without publishing the port. The register_netdevice()
failure path above does the same.

gmac_setup_phy() returns -ENODEV, not -EPROBE_DEFER, whenever
of_phy_get_and_connect() returns NULL:

	phy = of_phy_get_and_connect(netdev,
				     dev->of_node,
				     gmac_adjust_link);
	if (!phy)
		return -ENODEV;

That covers a PHY that doesn't answer at its MDIO address, a PHY device
that was never registered, and an unsupported phy-mode.

In that case devres releases port 1's threaded software free queue
handler, and geth->port1 stays NULL. The new check in geth_resize_freeq()
then fails permanently:

	if (!geth->initialized || !geth->port0 || !geth->port1)
		return -ENODEV;

gmac_open() only tolerates -EBUSY:

	err = geth_resize_freeq(port);
	...
	if (err && (err != -EBUSY)) {
		netdev_err(netdev, "could not resize freeq\n");
		goto err_stop_phy;
	}

Wouldn't every open of the working port 0 then fail with "could not
resize freeq"?

This looks like the same port 0 breakage that 3e813d61401a introduced.
Before that commit, a PHY failure was deferred to ifup and port 1 stayed
bound.

The gmac_setup_phy() failure path also appears to be unchanged in the
final revision of the series.
