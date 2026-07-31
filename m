Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE4430C148;
	Fri, 31 Jul 2026 02:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785464626; cv=none; b=F31Pv9ijYn0DOZc/gP34RVqwKnm+3/y+nJg6iUOy00bszxYuKa1HgGDMybSk+YbDNxSLWlwWY9kWmO0WVHCjc6N7uh2IELeKFdK7JhNeAzm80IVV32l/N+cESVQnSTt8btXk3bS27VzW/q+fvhL3ueghofMCrdmayHFvYNdxQzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785464626; c=relaxed/simple;
	bh=8BRHcmistHDBmIiaTRcrhBqPcrM2kuzsc7XQj8Zodu4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m6Qk0KZ7Fxvn1o9lRbDFOP2X43tjL7Xxkq3+fasJHeHN1I19EL/wRnEGPjyf/3CGYTweR3tOLKDxXDwEZK24ySv2pQfbe7Vdfye0wInzYbw3UZOG5MUUY4H6ENuw7QmL4fRY7qffFtxIGioOrgH0yEMAk+de9yLI478dp/x6/lA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YXSvxZrQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YXSvxZrQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 086971F00A3D;
	Fri, 31 Jul 2026 02:23:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785464624;
	bh=r0PEGKw9UGz84oi3O40dpzd9p7ghj/PbbGurjUD3kLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YXSvxZrQyOecuSIV7ok42pjZvkJfaTmkfEuSgS0T+5AU1GGPDNV4jOOYAbTEE4mmh
	 lOY1NMFhuFfMRMswanvw+Js3pYsCax4qEsnAU+cL6ZDG1RRWu11OE0dYnhFYbSHQAc
	 z3VJH+gVpXQXLm4tiljPi77qTiXi8sfAYn+Vcl9a/5warrpE2lI7PoXqoCiQv9ES5e
	 T8/6YX4mG8owYwF5lPSM9VTXDhmQFe69BNWmMU0XRElkwqQX4Wy5p5V+UGdytSbSWd
	 JdxNA/GLST2/XDoYPihEeEIa84yYmVh61qEw+YhK4KiVnigzkljR5Ld/gydFmIELCo
	 twJNzlIvbiYmg==
From: Jakub Kicinski <kuba@kernel.org>
To: bastien.curutchet@bootlin.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	woojung.huh@microchip.com,
	UNGLinuxDriver@microchip.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	richardcochran@gmail.com,
	linux@armlinux.org.uk,
	horms@kernel.org,
	maxime.chevallier@bootlin.com,
	pascal.eberhard@se.com,
	miquel.raynal@bootlin.com,
	thomas.petazzoni@bootlin.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 07/10] net: dsa: tag_ksz: share code for KSZ8795 and KSZ9893 xmit operations
Date: Thu, 30 Jul 2026 19:23:43 -0700
Message-ID: <20260731022343.800348-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727-ksz-new-ptp-v3-7-caba39e680e3@bootlin.com>
References: <20260727-ksz-new-ptp-v3-7-caba39e680e3@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
--- Patch [7]: [PATCH net-next v3 07/10] net: dsa: tag_ksz: share code for KSZ8795 and KSZ9893 xmit operations ---
commit 801d0cdc8ef18f0fbd60b1d666b46b36437fd06e
Author: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>

net: dsa: tag_ksz: share code for KSZ8795 and KSZ9893 xmit operations

This factors the duplicated tail-tag encoding of ksz8795_xmit() and
ksz9893_xmit() into a new ksz_common_xmit() helper parameterized by
do_tstamp, prio and override_mask.  As a side effect ksz8795_xmit() now
returns through ksz_defer_xmit() instead of returning the skb directly.

> diff --git a/net/dsa/tag_ksz.c b/net/dsa/tag_ksz.c
> index f58ce0f0e9e42..f8b40437c5fa4 100644
> --- a/net/dsa/tag_ksz.c
> +++ b/net/dsa/tag_ksz.c
> @@ -218,6 +218,37 @@ static struct sk_buff *ksz_defer_xmit(struct dsa_port *dp, struct sk_buff *skb)
>  	return NULL;
>  }
>  
> +static struct sk_buff *ksz_common_xmit(struct sk_buff *skb,
> +				       struct net_device *dev,
> +				       bool do_tstamp,
> +				       u8 prio,
> +				       u8 override_mask)
> +{
> +	struct dsa_port *dp = dsa_user_to_port(dev);
> +	struct ethhdr *hdr;
> +	u8 *tag;
> +
> +	if (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb)) {
> +		kfree_skb(skb);
> +		return NULL;
> +	}
> +
> +	/* Tag encoding */
> +	if (do_tstamp)
> +		ksz_xmit_timestamp(dp, skb);
> +
> +	tag = skb_put(skb, KSZ_INGRESS_TAG_LEN);
> +	hdr = skb_eth_hdr(skb);
> +
> +	*tag = dsa_xmit_port_mask(skb, dev);
> +	*tag |= prio;
> +
> +	if (is_link_local_ether_addr(hdr->h_dest))
> +		*tag |= override_mask;
> +
> +	return ksz_defer_xmit(dp, skb);
> +}
> +

[Severity: Medium]
Can this dereference NULL for the KSZ8795 tagger?  ksz_defer_xmit() reads
ds->tagger_data and the tagger private data before using them:

net/dsa/tag_ksz.c:ksz_defer_xmit() {
	struct ksz_tagger_data *tagger_data = ksz_tagger_data(dp->ds);
	struct ksz_tagger_private *priv = ksz_tagger_private(dp->ds);
	...
	if (!clone)
		return skb;  /* no deferred xmit for this packet */

	xmit_work_fn = tagger_data->xmit_work_fn;
	xmit_worker = priv->xmit_worker;
	...
}

Both pointers are only populated by ksz_connect(), and ksz8795_netdev_ops
does not install it:

static const struct dsa_device_ops ksz8795_netdev_ops = {
	.name	= KSZ8795_NAME,
	.proto	= DSA_TAG_PROTO_KSZ8795,
	.xmit	= ksz8795_xmit,
	.rcv	= ksz8795_rcv,
	.needed_tailroom = KSZ_INGRESS_TAG_LEN,
};

compared with ksz9893_netdev_ops which has .connect = ksz_connect and
.disconnect = ksz_disconnect.  ksz87xx_connect_tag_protocol() and
ksz88xx_connect_tag_protocol() in drivers/net/dsa/microchip/ksz8.c also
just return 0 for DSA_TAG_PROTO_KSZ8795, so ds->tagger_data stays NULL for
these switches.

So after this change the only thing keeping ksz8795_xmit() from a NULL
dereference is KSZ_SKB_CB(skb)->clone always being NULL.

Is that invariant actually enforced anywhere?  The ksz87xx/ksz88xx
dsa_switch_ops export .port_hwtstamp_set = ksz_hwtstamp_set and
.port_txtstamp = ksz_port_txtstamp unconditionally, dsa_user_hwtstamp_set()
adds no capability gate, and ksz_set_hwtstamp_config() sets the flag before
the register write and returns the error without reverting it, with no
dev->info->ptp_capable check:

drivers/net/dsa/microchip/ksz_ptp.c:ksz_set_hwtstamp_config() {
	...
		prt->hwts_tx_en = true;

		ret = ksz_rmw16(dev, regs[PTP_MSG_CONF1], PTP_1STEP, PTP_1STEP);
		if (ret)
			return ret;
	...
}

For these chips regs[] is ksz8795_regs, whose last initialized index is
REG_PORT_PME_CTRL (23) while PTP_MSG_CONF1 is 28, so regs[PTP_MSG_CONF1] is
an out-of-bounds read and the write can well be rejected, which is exactly
the path that leaves hwts_tx_en latched.

Once hwts_tx_en is set on such a port, ksz_port_txtstamp() attaches a clone
based on that flag alone:

drivers/net/dsa/microchip/ksz_ptp.c:ksz_port_txtstamp() {
	...
	KSZ_SKB_CB(skb)->clone = clone;
	...
}

and then dsa_user_xmit() -> ksz8795_xmit() -> ksz_common_xmit() ->
ksz_defer_xmit() gets past the "if (!clone)" early exit and loads
tagger_data->xmit_work_fn from a NULL pointer.  Before this patch
ksz8795_xmit() returned the skb directly and never touched ds->tagger_data,
so the same misconfiguration only leaked the clone.

The commit message states:

    Clones are only created by the KSZ driver when the PTP feature is
    enabled. Since KSZ8795 doesn't support PTP, returning the SKB directly
    or ksz_defer_xmit() is the same.

Could this assumption be expressed in the code, for instance by keying the
ksz_defer_xmit() call off do_tstamp, or by adding a DEBUG_NET_WARN_ON()
for a clone on a tagger without tagger_data?  Note also that
ksz8795_netdev_ops uses .needed_tailroom = KSZ_INGRESS_TAG_LEN only, so
there is no room for the 4 byte PTP tag if a future user of this helper
passes do_tstamp = true with that tailroom.

>  static struct sk_buff *ksz9477_xmit(struct sk_buff *skb,
>  				    struct net_device *dev)
>  {
> @@ -308,23 +339,7 @@ MODULE_ALIAS_DSA_TAG_DRIVER(DSA_TAG_PROTO_KSZ9477, KSZ9477_NAME);
>  
>  static struct sk_buff *ksz8795_xmit(struct sk_buff *skb, struct net_device *dev)
>  {
> -	struct ethhdr *hdr;
> -	u8 *tag;
> -
> -	if (skb->ip_summed == CHECKSUM_PARTIAL && skb_checksum_help(skb)) {
> -		kfree_skb(skb);
> -		return NULL;
> -	}
> -
> -	/* Tag encoding */
> -	tag = skb_put(skb, KSZ_INGRESS_TAG_LEN);
> -	hdr = skb_eth_hdr(skb);
> -
> -	*tag = dsa_xmit_port_mask(skb, dev);
> -	if (is_link_local_ether_addr(hdr->h_dest))
> -		*tag |= KSZ8795_TAIL_TAG_OVERRIDE;
> -
> -	return skb;
> +	return ksz_common_xmit(skb, dev, false, 0, KSZ8795_TAIL_TAG_OVERRIDE);
>  }

[ ... ]
