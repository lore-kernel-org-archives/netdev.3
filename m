Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793698804;
	b=v6iufagG4esRZSvJLY6jJRDxSAdYW2zfP83m4/0B+RXYT9ActmedPGbbvDaEpFSetBUV
	 JqHBP9jyMJ8vIvfP14Dp1U0MmOB7/MLLqzuFq0w1x09TgXoscWrC4RjSgz8kJ694ZubW8
	 ftfZx/p4AG0RMtCXiq4ZjosivnQ6iHRk9Mvy+tBkkVBRc7+ktEoVNnxp27ufZnnY6EvoO
	 hhuVv5Hd7xB0xMx3KLR4Ca1ZbPobJs/t1zAsKe+pWdnYJueK9D7PHzYcOTmNh2Wn5l2ZI
	 +n4J++Izswcy98Vbr7KHhMw/uv3Jd60rejn7e6fgVAbrbUkYo0JMMM3WyWNL1J4s+nA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793698804;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=SxWl47Zl4zSv6hrWucnwr8CzOQ1TbBYqBciLqiXEt4I=;
	b=hy5sxzT2GVW6NeR8+nz8LIcQ9KKfwvEgO7kJTAd7vqKMQf/MJEjsxa4fz9tk0OOy4cj3
	 a5aMoO1pfhCv9dTPVRZYpjHseDm0s53FS/ClSj9JUZzeAYcmz5XoP2Uc7ox/mhZkrC3/e
	 xcK7iIRwWIHJdVEuA2GGuBrz7WRzlWjMbygy8yjdER2w3ipOo3sXnoy25Apr5bMb0mhxI
	 D5wpIErqHQm08GQ/nfl4UHymsoiel9uObrJ9ME9T0ncS/m9VgH8sBVUFy3hSN/ZaylCJQ
	 OFS9v+Q0SJcLaURLHfqSfX+5kt08SnUROgfxQLzDARZ+XKZe/RguFTf775Tz1x8ZQCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j0x3VAey;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24898606D805;
	Tue,  3 Nov 2026 09:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j0x3VAey
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E6C31F00919;
	Tue,  3 Nov 2026 09:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793698803;
	bh=SxWl47Zl4zSv6hrWucnwr8CzOQ1TbBYqBciLqiXEt4I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=j0x3VAeyyNguDXq1IJjZYYg+GvvhKVj3fvRwGxj6NTwPtHsudPFQGdx9DMI9DPGrX
	 uQE4IvwwRe3RzpEqDw7Fp58QS753x14hObD8t/NZt/lRbtqtlw5ZGS79hajQgiTKUh
	 FJ076WtpetDHuPyZV9LOX3ZWTyxX6e+iMe0Ezrfq2rmI+hD31h7S1BVUico0ReqK/C
	 RTzGaXLXwsp4aZosxhCAe8vIokPCduI8XopjPm7Fu/JkYCQl9sype3mH1AfbPzZv5C
	 PrD4/oIfUhW+KzmPH4rbhR9GGpL5NcwqlWT4DEZMJxUHchi/KYdtm50fakytqv1jUq
	 y2JjFGnFB1Xiw==
Subject: Re: [PATCH] net: ti: icssg-prueth: Fix device_node refcount leak in
 prueth_probe()
From: netdev-bot+sashiko@kernel.org
To: laixiangwu@cmss.chinamobile.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, danishanwar@ti.com, rogerq@kernel.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 03 Nov 2026 09:40:02 +0000
Message-ID: <179369880262.488856.8946204452140783033@kernel.org>
In-Reply-To: <20261030085651.1944-1-laixiangwu@cmss.chinamobile.com>
References: <20261030085651.1944-1-laixiangwu@cmss.chinamobile.com>
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

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The SR1.0 sibling driver keeps the same device_node refcount
  leak, and this patch does not touch it.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but the port-
  node loop in prueth_probe()…
- [Low] This problem wasn't introduced by this patch, but the DT binding
  and the driver disagree on whether "ti,mii-rt" is required.

--

net: ti: icssg-prueth: Fix device_node refcount leak in prueth_probe()

In icssg_prueth.c, prueth_probe() returned directly with -ENODEV when the
ti,mii-g-rt or ti,mii-rt syscon lookup failed. This patch changes both
returns to goto put_cores, so the eth0_node/eth1_node references are
dropped on those error paths.

> diff --git a/drivers/net/ethernet/ti/icssg/icssg_prueth.c b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> index 591be5c8056b4..9b971d1dfd8cf 100644
> --- a/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> +++ b/drivers/net/ethernet/ti/icssg/icssg_prueth.c
> @@ -2258,13 +2258,15 @@ static int prueth_probe(struct platform_device *pdev)
>  	prueth->miig_rt = syscon_regmap_lookup_by_phandle(np, "ti,mii-g-rt");
>  	if (IS_ERR(prueth->miig_rt)) {
>  		dev_err(dev, "couldn't get ti,mii-g-rt syscon regmap\n");
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto put_cores;
>  	}

[Severity: Medium]
The subject says this fixes the device_node refcount leak in
prueth_probe(). Does the SR1.0 variant of the driver still have the same
leak?

drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c has its own
prueth_probe(). Its port loop takes the same of_node_get() references on
eth0_node/eth1_node, and it still returns directly here:

drivers/net/ethernet/ti/icssg/icssg_prueth_sr1.c:prueth_probe() {
    ...
	prueth->miig_rt = syscon_regmap_lookup_by_phandle(np, "ti,mii-g-rt");
	if (IS_ERR(prueth->miig_rt)) {
		dev_err(dev, "couldn't get ti,mii-g-rt syscon regmap\n");
		return -ENODEV;
	}

	prueth->mii_rt = syscon_regmap_lookup_by_phandle(np, "ti,mii-rt");
	if (IS_ERR(prueth->mii_rt)) {
		dev_err(dev, "couldn't get ti,mii-rt syscon regmap\n");
		return -ENODEV;
	}
    ...
}

That file already has a put_cores label that calls of_node_put() on both
nodes. prueth_put_cores() checks each pru/rtu/txpru pointer for NULL, and
at this point those pointers are still zero from devm_kzalloc(). So the
same "ret = -ENODEV; goto put_cores;" change looks like it would work
there too.

CONFIG_TI_ICSSG_PRUETH_SR1 builds the SR1 driver, and in-tree DTs use it,
for example k3-am65-iot2050-common-pg1.dtsi with compatible
"ti,am654-sr1-icssg-prueth".

Should the SR1 driver get the same fix, perhaps as a companion patch with
its own Fixes: tag?

>  
>  	prueth->mii_rt = syscon_regmap_lookup_by_phandle(np, "ti,mii-rt");
>  	if (IS_ERR(prueth->mii_rt)) {
>  		dev_err(dev, "couldn't get ti,mii-rt syscon regmap\n");
> -		return -ENODEV;
> +		ret = -ENODEV;
> +		goto put_cores;
>  	}

[Severity: Low]
This is a pre-existing issue and was not introduced by this patch. The
driver treats ti,mii-rt as mandatory here, but the DT binding does not.

In Documentation/devicetree/bindings/net/ti,icssg-prueth.yaml, ti,mii-rt
is only listed under properties. The top-level required list has
ti,mii-g-rt but not ti,mii-rt:

required:
  - compatible
  - sram
  - dmas
  - dma-names
  - ethernet-ports
  - ti,mii-g-rt
  - interrupts
  - interrupt-names

The binding's example node sets ti,mii-g-rt, ti,pa-stats and ti,iep, but
not ti,mii-rt. A DT written from that example would pass schema
validation and then fail here with "couldn't get ti,mii-rt syscon
regmap".

All in-tree users (k3-am642-*, k3-am654-*, k3-am65-iot2050-common.dtsi)
provide ti,mii-rt, so in-tree boards are not affected.

Should ti,mii-rt be added to the binding's required list and to its
example?

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch. While
looking at the eth0_node/eth1_node references, the port loop earlier in
prueth_probe() also seems to have a few related problems:

drivers/net/ethernet/ti/icssg/icssg_prueth.c:prueth_probe() {
    ...
	for_each_child_of_node(eth_ports_node, eth_node) {
		u32 reg;

		if (strcmp(eth_node->name, "port"))
			continue;
		ret = of_property_read_u32(eth_node, "reg", &reg);
		if (ret < 0) {
			dev_err(dev, "%pOF error reading port_id %d\n",
				eth_node, ret);
		}

		of_node_get(eth_node);

		if (reg == 0) {
			eth0_node = eth_node;
			...
		} else if (reg == 1) {
			eth1_node = eth_node;
			...
		} else {
			dev_err(dev, "port reg should be 0 or 1\n");
		}
	}
    ...
}

When of_property_read_u32() fails, the code only logs the error and
keeps going. Can the reg == 0 and reg == 1 checks then read an
uninitialized reg?

In the else branch, is the reference taken by of_node_get(eth_node) ever
dropped?

If two available port nodes both have reg = <0> (or both have <1>), the
second assignment to eth0_node (or eth1_node) overwrites the first. Does
the first node's reference leak in that case?

Related to that, can this check ever fire?

	if (eth0_node == eth1_node) {
		dev_err(dev, "port0 and port1 can't have same reg\n");
		of_node_put(eth0_node);
		return -ENODEV;
	}

Each iteration stores a different node into at most one slot. The two
pointers can only be equal when both are NULL, and the earlier
!eth0_node && !eth1_node check already returns in that case. So a DT with
duplicate reg values would probe successfully instead of failing.

The SR1 copy of this loop in icssg_prueth_sr1.c has the same pattern.

>  
>  	prueth->pa_stats = syscon_regmap_lookup_by_phandle(np, "ti,pa-stats");

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261030085651.1944-1-laixiangwu%40cmss.chinamobile.com
