Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793578163;
	b=pDoudS27Svyj6X3yhMHCdEOFEEYLuQ5+oqouzRF3zy/DXXlY2yROXPbMw8eUU//fAx7+
	 w+kz2oGut49Vv6eip+M4gXve3Pkj+IXfAprWTR551NJQqxS9p8/MlfZzQ5zAJBDhEmett
	 IuBFTXLk56gDxtmzpUW576sWlmogS8de7wH+l8VtdmWYs3hh5EflTaAN/4Tv0zSd0Xo6d
	 etj4D8cZupaQdTF+LVu7CVpEviUFzbpUkK8Wn+l3NCaEjCprPTAIdHHHoLA6XvO1he48L
	 TqSJkkFUWlryKDaTRVTj+nWubumf55gzkR/ySL3RYSX20qAHgzBBgTAZ2geiVA2mCFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793578163;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=7J6hEMF3m3bnNGhJeCVy6DNKvCreUC846t3x5pm1zuc=;
	b=JdRtOsZYFiUO6Ue+gbjEFjI0S68d8GBDdYoMj3D5AYe7keDXOfC+r9zpBuh1Pi3i91Wb
	 qbacRE/7Rc+1WgMNwfpwCS3tRj/P8Wzsry5GJTMW8XSf52QZ82Ni2ccZj4eiHIrB0Llke
	 ZTTnWx8WfBtTmAsXXLaaKcWDd7Dw/UNjdCBnPS3S769ZVFu7Ys6C1JJg6bSUnm6xnRkOk
	 OVrFVx6VjGcfQdnBEFipVWDF0zt+UucJopLLPOyRklVYOcwDiD7ZANmytT5gcAEsvyNNb
	 2R45XjQZuK/GZWshtepzVFL5/7xKba2145ZSCg07pWGB+T5OR/HkqYxxvDk8ioXhNQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bTmmR6bU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBAC606A324;
	Mon,  2 Nov 2026 00:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bTmmR6bU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65F5E1F000C1;
	Mon,  2 Nov 2026 00:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793578162;
	bh=7J6hEMF3m3bnNGhJeCVy6DNKvCreUC846t3x5pm1zuc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bTmmR6bUKqm4k86t3g55e9ps5OXCAAzhYI7i0cStKIi2WGmvVR0EOsE+Z9rlUPaZl
	 59o6gbqNXBi6lgpLJZSkSHbIm/9w/wuv82YEG10BQBGVGFIoeM08xAIK9f3tSB1W+f
	 /93L0Fc21mM3KJrNSlJkA0ZSKOvRur7DJAh4uaXJ8KiGcVBr0gE3nemVwlWRmiKb69
	 8H3NndWk8ghYFbDJ6AM7WF4rej+b01YhdvOuHXjeghlzsYCMkhFX9VSny8JZCcV29g
	 0ts/4a6cpv509g4bVA0KpJS+WgIRBXV0YGIeaItWu2mybLsEqK0s92cfqIJ6Jal9re
	 6cWdBeNoH77vQ==
Subject:
 Re: [PATCH net v3 2/2] net: dsa: b53: Enable legacy IGMP snooping controls
From: netdev-bot+sashiko@kernel.org
To: florian.fainelli@broadcom.com
Cc: netdev@vger.kernel.org, jonas.gorski@gmail.com, andrew@lunn.ch,
 olteanv@gmail.com, davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, linux@armlinux.org.uk, rmk+kernel@armlinux.org.uk,
 linux-kernel@vger.kernel.org
Date: Mon, 02 Nov 2026 00:09:20 +0000
Message-ID: <179357816089.3131.2008365378649919842@kernel.org>
In-Reply-To: <20261028235100.3892374-3-florian.fainelli@broadcom.com>
References: <20261028235100.3892374-3-florian.fainelli@broadcom.com>
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The commit message says: 'These legacy classifiers have fixed
  forwarding behavior, including query flooding which excludes the IMP…

--

net: dsa: b53: Enable legacy IGMP snooping controls

This enables the IP-layer IGMP classifier (bit 3 of the global management
configuration register) on BCM5325E, BCM5365, BCM5389, BCM5397/5398 and
BCM63xx, which were previously skipped in b53_enable_mcast_snooping(). On
BCM6318 and BCM63268 it also clears the IGMP redirection enable to select
snooping mode. BCM5325M and unidentified BCM5325 variants remain excluded.

> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
> index e54f6d4d1f7bb..957a1501d3f49 100644
> --- a/drivers/net/dsa/b53/b53_common.c
> +++ b/drivers/net/dsa/b53/b53_common.c
> @@ -841,12 +841,29 @@ int b53_enable_mcast_snooping(struct b53_device *dev)
>  	u16 val16;
>  	u32 val;
>  	int ret;
> +	u8 val8;
>  
> -	/* Older switches use different IGMP controls, not HL_PRTC_CTRL. */
> -	if (is5325(dev) || is5365(dev) || dev->chip_id == BCM5389_DEVICE_ID ||
> -	    is5397_98(dev) || is63xx(dev))
> +	/* BCM5325M snooping uses the mirroring engine instead. */
> +	if (is5325(dev) && !is5325e(dev))
>  		return 0;
>  
> +	/* Older switches classify IGMP in the global management register.
> +	 * They do not provide the separate MLD controls of newer switches.
> +	 */
> +	if (is5325e(dev) || is5365(dev) ||
> +	    dev->chip_id == BCM5389_DEVICE_ID || is5397_98(dev) || is63xx(dev)) {
> +		ret = b53_read8(dev, B53_MGMT_PAGE, B53_GLOBAL_CONFIG, &val8);
> +		if (ret)
> +			return ret;
> +
> +		val8 |= GC_IGMP_IP_EN;
> +		/* Disable the separate IGMP redirection mode on BCM6318/63268. */
> +		if (is6318_268(dev))
> +			val8 &= ~GC_IGMP_RED_EN_6318_268;
> +
> +		return b53_write8(dev, B53_MGMT_PAGE, B53_GLOBAL_CONFIG, val8);
> +	}

[Severity: High]
The commit message says:

  These legacy classifiers have fixed forwarding behavior, including
  query flooding which excludes the IMP on BCM5397/5398 and BCM63xx.

The message describes this as fixed hardware behavior. Isn't it actually
something this patch turns on?

Before this change, b53_enable_mcast_snooping() returned early on
BCM5397/5398 and BCM63xx, so GC_IGMP_IP_EN stayed clear. IGMP general
queries to 01:00:5e:00:00:01 were then forwarded as ordinary multicast.
The IMP has PORT_CTRL_RX_MCST_EN set, and the bridge never installs MDB
entries for 224.0.0.x, so those queries reached the CPU.

This path now runs unconditionally at setup:

  b53_setup()
    b53_enable_mcast_snooping()
      val8 |= GC_IGMP_IP_EN;
      b53_write8(dev, B53_MGMT_PAGE, B53_GLOBAL_CONFIG, val8);

On BCM6318/63268, snooping mode is also selected explicitly. With that in
place, would queries from an external querier on any switch port stop
reaching the CPU on these chips?

If so, these cases look affected:

  - the bridge can no longer learn multicast router ports or detect other
    queriers from the queries it receives

  - the host IGMP stack on br0, or on standalone user ports (for example
    an igmpproxy upstream on a WAN port), never answers general queries,
    so the upstream router would expire the host's memberships after the
    group membership interval

  - on standalone ports, where the port VLAN mask only allows the IMP, a
    query flooded excluding the IMP would reach no port at all

This patch carries a Fixes: tag and would likely be picked up for stable.
Should BCM5397/5398 and BCM63xx keep returning early until queries can
still be delivered to the IMP with the classifier enabled?

> +
>  	/* IGMPv2 and MLDv1 reports use the group's destination MAC. Once
>  	 * the first listener is offloaded, ordinary multicast forwarding
>  	 * can keep subsequent reports from reaching the bridge CPU.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261028235100.3892374-1-florian.fainelli%40broadcom.com
