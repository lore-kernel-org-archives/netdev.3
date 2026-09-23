Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6CAB530E0A;
	Wed, 23 Sep 2026 13:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790169533; cv=none; b=LhTySBhJWkecQClAateqbbPSTX0nqe8I1qiablydauyUdpYYQOQ7DTCXeBBKKfXWOF3EqqU7RmXYSNCx7mwci12c7aZ0M+b9SsGC06x4/f3ea+dEzuksvH3xN5pB1CxMoybPv2VU7i9B2z2g08R0+AE8bjFGSGkzc8d3OVF4C+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790169533; c=relaxed/simple;
	bh=2MJCcjMSqZYU61/mlzu7p8PU+iqPW2XcXJ3DCvdViEU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UgghvKeN1c5TvsgIzfZr+YbevBPfeqU0XdCQvOXJ2Zwal3W2F9/FAusc2KDg9SAzW91vI8wfg1iIAYIhLM5SYYyOJq4oG9FP9po0dxBvCxH/iIE0HwH9lQY+Xa4Bxxw/TTAzvgXCwHndd+upB6VTbXQ+rQFaYiYWwr4bu4UpcTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwYzPxCk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwYzPxCk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62B241F000FF;
	Wed, 23 Sep 2026 13:18:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790169520;
	bh=BSvIUUVPs3vpcQNZgqtwmOeR8QwxCnzKrnKsdXZdJDg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=RwYzPxCkykj0IQENtEr3Mgo85N/GX2p1skjSQ4ANKdJkqYfdVQh7kVFHnpxNTROV0
	 T0Payhqnn1InAdkRxmaEkOiJKPuaTbWVfa2qLODC+gwaISmG13z4GQ453hhYTfZUZt
	 qcsPbOrclw5jrzxLf+P/eeMMoexYuctB0NWfR+bFw5cqZnklQdJzj/1dp2R6FUsy2x
	 xFYVvkuIXiJP54SVzfZMN6dftT2kLHUBKJmeS1TQjyKjNzpZDbD3xvARUvSCchF5ku
	 voAuzgCEGKVcBRZKDxtm4ZHzQqyjR2j+9vpfRrioUr1Xd8E2g+upIqHdawZUJyVO6s
	 NUlFqjuJcBJxA==
Subject:
 Re: [PATCH net v8 2/2] net: stmmac: remove software VLAN tag stripping
From: netdev-bot+sashiko@kernel.org
To: peilinhe2020@163.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 he.peilin@zte.com.cn
Date: Wed, 23 Sep 2026 13:18:38 +0000
Message-ID: <179016951891.2160803.13955157449938739742@kernel.org>
In-Reply-To: <20260919125413.18058-3-peilinhe2020@163.com>
References: <20260919125413.18058-3-peilinhe2020@163.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 3 · Medium: 0 (1) · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] stmmac_has_ip_ethertype() parses the VLAN chain at the wrong
  offset on RX, so widening the bound from `depth <= ETH_HLEN` to `depth…
- [High] The same helper is the TX gate: stmmac_features_check()
  (ndo_features_check) clears NETIF_F_IP_CSUM/NETIF_F_IPV6_CSUM when…
- [High] The widened `depth <= VLAN_ETH_HLEN` bound removes the last
  software guard that kept the driver from claiming CHECKSUM_UNNECESSARY…
- [Low] The patch silently fixes a live, user-visible feature-
  advertisement bug on DWXLGMAC but carries no Fixes: tag.

Pre-existing issues:
- [Medium] Removing NETIF_F_HW_VLAN_STAG_RX from the advertised features
  does not stop the MAC from stripping S-tags and reporting them as…
- [Low] priv->hw->hw_vlan_en is a plain bool flipped from process context
  in stmmac_set_features() (under rtnl) while it is read concurrently by…

--

net: stmmac: remove software VLAN tag stripping

This removes stmmac_rx_vlan() and its two call sites, relaxes the depth
check in stmmac_has_ip_ethertype() so a single in-payload VLAN tag is
tolerated, and changes the RX VLAN feature advertisement in
__stmmac_dvr_probe() to depend on the presence of .set_hw_vlan_mode and
.rx_hw_vlan.

A few questions below.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 1fb5f804ea23..232b1e7e031c 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -4769,7 +4769,11 @@ static bool stmmac_has_ip_ethertype(struct sk_buff *skb)
>  	proto = __vlan_get_protocol(skb, eth_header_parse_protocol(skb),
>  				    &depth);
>  
> -	return (depth <= ETH_HLEN) &&
> +	/* Software VLAN stripping is gone, so a single VLAN tag may
> +	 * still be present. The MAC RX checksum result still applies
> +	 * to the inner IP packet.
> +	 */
> +	return (depth <= VLAN_ETH_HLEN) &&
>  		(proto == htons(ETH_P_IP) || proto == htons(ETH_P_IPV6));
>  }

[Severity: High]
On the RX side, is the VLAN chain parsed at the right offset here?  Both
RX callers advance skb->data before calling this helper:

	skb->protocol = eth_type_trans(skb, priv->dev);

	if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb) ||
	    (status & csum_none))

eth_type_trans() calls eth_skb_pull_mac(), which is just:

	static inline struct ethhdr *eth_skb_pull_mac(struct sk_buff *skb)
	{
		struct ethhdr *eth = (struct ethhdr *)skb->data;

		skb_pull_inline(skb, ETH_HLEN);
		return eth;
	}

and it never assigns skb->mac_len.  The skb is built with
napi_build_skb()/napi_alloc_skb() so mac_len is still 0 at this point;
skb_reset_mac_len() only runs later in __netif_receive_skb_core(), after
napi_gro_receive().

__vlan_get_protocol() passes mac_offset 0, and the walk then does:

net/core/skbuff.c:__vlan_get_protocol_offset() {
	unsigned int vlan_depth = skb->mac_len, parse_depth = VLAN_MAX_DEPTH;

	if (vlan_depth) {
		...
		vlan_depth -= VLAN_HLEN;
	} else {
		vlan_depth = ETH_HLEN;
	}
		vh = skb_header_pointer(skb, mac_offset + vlan_depth,
					sizeof(vhdr), &vhdr);
	...
}

With mac_len == 0 the first VLAN header is expected at skb->data +
ETH_HLEN, but after the pull the real tag sits at skb->data + 0, so the
read lands 14 bytes too far.  For a tagged IPv4 frame
h_vlan_encapsulated_proto is then read from IP header bytes 12..13, i.e.
the first two bytes of the source address; for IPv6 it is source address
bytes 4..5, and for a tagged ARP frame it is sender-MAC bytes 4..5.

That leads to two effects.  First, the ordinary tagged IPv4/IPv6 frame
fails the proto comparison, so the MAC RX checksum result is still
discarded and dwmac100/dwmac1000 lose CHECKSUM_UNNECESSARY for the VLAN
traffic that previously got it via stmmac_rx_vlan() with depth 0.  Does
that contradict the commit message claim:

    "Adjust stmmac_has_ip_ethertype() to tolerate a single in-payload
    VLAN tag so that the MAC RX checksum offload result is still used
    for tagged IPv4/IPv6 frames on cores without MAC-level stripping."

Second, when those mis-read bytes do happen to equal 0x0800 or 0x86DD
(for instance a tagged frame with a source address in 8.0.0.0/16, which
the sender chooses), depth becomes 18 and the new bound accepts it, so
CHECKSUM_UNNECESSARY is set for frames whose real EtherType is not IP.
The old depth <= ETH_HLEN bound could not reach that state because a
VLAN walk always yields 18.

Would it work to run the helper before eth_type_trans(), or to pass an
explicit mac_offset that accounts for the ETH_HLEN pull?

> @@ -5049,24 +5053,6 @@ static netdev_features_t stmmac_features_check(struct sk_buff *skb,
>  	return vlan_features_check(skb, features);
>  }

[Severity: High]
stmmac_has_ip_ethertype() is also the TX gate in stmmac_features_check():

	if (priv->plat->tx_queues_cfg[queue].coe_unsupported ||
	    !stmmac_has_ip_ethertype(skb))
		features &= ~(NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM);

Unlike the RX side, the parse offset is correct there, because
__dev_queue_xmit() has done skb_reset_mac_header() and mac_len is either
0 or 18, so depth 18 is genuinely accepted after this change.  That
re-enables hardware checksum (and therefore TSO, via
harmonize_features()) for frames that already carry one VLAN tag in the
payload when ndo_features_check runs: DSA tag_8021q frames such as
sja1105 in VLAN-aware mode, and bridged/forwarded tagged
CHECKSUM_PARTIAL frames from tap/vhost guests.  vlan_features_check()
only masks multi-tagged frames, so a single in-payload tag passes
through.

Isn't that the class of frames that commit c2945c435c99 ("net: stmmac:
Prevent DSA tags from breaking COE") excluded with depth <= ETH_HLEN, on
the grounds that "on TX these tagged frames are ignored by the checksum
offload engine and IP header checker of some stmmac cores"?  If the COE
does not skip the tag, the descriptor CIC request is ignored and the
frame goes out with the pseudo-header sum still in the L4 checksum
field, and there is no TX-side fallback.

Was this TX effect intended?  The changelog only describes the RX
rationale, and c2945c435c99 carried a Fixes: tag and went to stable.

>  
> -static void stmmac_rx_vlan(struct net_device *dev, struct sk_buff *skb)
> -{
> -	struct vlan_ethhdr *veth = skb_vlan_eth_hdr(skb);
> -	__be16 vlan_proto = veth->h_vlan_proto;
> -	u16 vlanid;
> -
> -	if ((vlan_proto == htons(ETH_P_8021Q) &&
> -	     dev->features & NETIF_F_HW_VLAN_CTAG_RX) ||
> -	    (vlan_proto == htons(ETH_P_8021AD) &&
> -	     dev->features & NETIF_F_HW_VLAN_STAG_RX)) {
> -		/* pop the vlan tag */
> -		vlanid = ntohs(veth->h_vlan_TCI);
> -		memmove(skb->data + VLAN_HLEN, veth, ETH_ALEN * 2);
> -		skb_pull(skb, VLAN_HLEN);
> -		__vlan_hwaccel_put_tag(skb, vlan_proto, vlanid);
> -	}
> -}
> -
>  /**
>   * stmmac_rx_refill - refill used skb preallocated buffers
>   * @priv: driver private structure
> @@ -5435,9 +5421,7 @@ static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
>  	if (priv->hw->hw_vlan_en)
>  		/* MAC level stripping. */
>  		stmmac_rx_hw_vlan(priv, priv->hw, p, skb);
> -	else
> -		/* Driver level stripping. */
> -		stmmac_rx_vlan(priv->dev, skb);
> +
>  	skb->protocol = eth_type_trans(skb, priv->dev);
>  
>  	if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb))

[Severity: High]
Can the relaxed bound make the driver claim CHECKSUM_UNNECESSARY for
frames the COE never validated?  In this zero-copy path the descriptor
status is not consulted at all:

	if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb))
		skb_checksum_none_assert(skb);
	else
		skb->ip_summed = CHECKSUM_UNNECESSARY;

and in stmmac_rx() the extra status term cannot express "not checked":

drivers/net/ethernet/stmicro/stmmac/dwmac4_descs.c:dwmac4_wrback_get_rx_status() {
	if (rdes1 & RDES1_IP_HDR_ERROR) { x->ip_hdr_err++; ret |= csum_none; }
	if (rdes1 & RDES1_IP_CSUM_BYPASSED)
		x->ip_csum_bypassed++;
	...
	if (rdes1 & RDES1_IP_PAYLOAD_ERROR) { x->ip_payload_err++; ret |= csum_none; }
}

RDES1_IP_CSUM_BYPASSED is only counted, never mapped to csum_none, so
status & csum_none stays clear for a frame the engine skipped.  Before
this change, any frame whose payload still began with a VLAN header gave
depth 18 > ETH_HLEN and was downgraded to CHECKSUM_NONE; now depth 18 is
accepted.  Cases where the COE legitimately bypasses include an
802.1ad/QinQ frame whose inner tag remains after the outer one is
stripped, and IP fragments.

Combined with the offset question above, the accept on RX is reached via
the mis-read EtherType, i.e. from payload bytes the sender picks, so a
corrupt L4 checksum can be handed to the stack as verified.  Should the
descriptor bypass bit be consulted before setting
CHECKSUM_UNNECESSARY, at least in the zero-copy path?

> @@ -5929,9 +5913,6 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  		if (priv->hw->hw_vlan_en)
>  			/* MAC level stripping. */
>  			stmmac_rx_hw_vlan(priv, priv->hw, p, skb);
> -		else
> -			/* Driver level stripping. */
> -			stmmac_rx_vlan(priv->dev, skb);
>  
>  		skb->protocol = eth_type_trans(skb, priv->dev);
>  

[Severity: Low]
This is a pre-existing issue and not introduced by this patch, but after
the else branch is gone, priv->hw->hw_vlan_en becomes the only gate for
recovering the VLAN ID from the descriptor.  The flag is a plain bool
written from process context in stmmac_set_features():

	if (features & NETIF_F_HW_VLAN_CTAG_RX)
		priv->hw->hw_vlan_en = true;
	else
		priv->hw->hw_vlan_en = false;

	phylink_rx_clk_stop_block(priv->phylink);
	stmmac_set_hw_vlan_mode(priv, priv->hw);

and read from softirq context in stmmac_rx() and
stmmac_dispatch_skb_zc(), with no READ_ONCE/WRITE_ONCE, no barrier and
no NAPI quiescing between the flag update and the MAC strip-mode
register write.  On the disable transition the flag is cleared first, so
frames whose tag the MAC already stripped are delivered with
stmmac_rx_hw_vlan() skipped and the VLAN ID lost.  Is it worth making
the flag update and the register write ordered while this code is being
touched?

> @@ -7990,9 +7971,10 @@ static int __stmmac_dvr_probe(struct device *device,
>  	ndev->features |= ndev->hw_features | NETIF_F_HIGHDMA;
>  	ndev->watchdog_timeo = msecs_to_jiffies(watchdog);
>  #ifdef STMMAC_VLAN_TAG_USED
> -	/* Both mac100 and gmac support receive VLAN tag detection */
> -	ndev->features |= NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_STAG_RX;
> -	if (dwmac_is_xmac(priv->plat->core_type)) {
> +	if (priv->hw->vlan &&
> +	    priv->hw->vlan->set_hw_vlan_mode &&
> +	    priv->hw->vlan->rx_hw_vlan) {
> +		ndev->features |= NETIF_F_HW_VLAN_CTAG_RX;
>  		ndev->hw_features |= NETIF_F_HW_VLAN_CTAG_RX;
>  		priv->hw->hw_vlan_en = true;
>  	}

[Severity: Low]
This ops-presence check also fixes a live advertisement bug on DWXLGMAC.
The ops table there provides neither callback:

drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
	const struct stmmac_vlan_ops dwxlgmac2_vlan_ops = {
		.update_vlan_hash = dwxgmac2_update_vlan_hash,
		.enable_vlan = vlan_enable,
	};

so with the old dwmac_is_xmac() test that core advertised
rx-vlan-offload and set hw_vlan_en while rx_hw_vlan was a no-op and the
MAC was never programmed to strip.  That is the same problem
8eb301bd7b0f4 ("net: stmmac: enable HW-accelerated VLAN stripping for
gmac4 only") addressed for gmac/xgmac, and 534df0c1724b7 ("net: stmmac:
dwxgmac2: Add support for HW-accelerated VLAN stripping") reintroduced
for XLGMAC by widening the condition to all xmac cores.  Should this
carry a Fixes: 534df0c1724b7 tag, or be split into its own patch so it
can be backported separately from the cleanup?

[Severity: Medium]
This is a pre-existing issue rather than something this patch
introduces, but does dropping NETIF_F_HW_VLAN_STAG_RX actually change
what the hardware does?  hw_vlan_en is still set here, and
stmmac_set_features() derives it from the single C-tag bit, after which:

drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c:vlan_set_hw_mode() {
	if (hw->hw_vlan_en)
		/* Always strip VLAN on Receive */
		value |= VLAN_TAG_STRIP_ALL;
	...
}

drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c:vlan_rx_hw() {
	if (hw->desc->get_rx_vlan_valid(rx_desc)) {
		u16 vid = hw->desc->get_rx_vlan_tci(rx_desc);

		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vid);
	}
}

Once an 802.1ad VLAN is configured, vlan_update_hash() sets VLAN_ESVL /
VLAN_EDVLP / VLAN_DOVLTC, so an outer S-tag is recognised, stripped by
VLAN_TAG_STRIP_ALL and then reported as ETH_P_8021Q on an interface that
now declares S-tag RX offload unsupported.  The S-VID can then land on an
802.1Q upper device with the same VID.  Since the commit message gives
this as a motivation:

    "NETIF_F_HW_VLAN_STAG_RX is no longer advertised, as the hardware
    reports stripped S-tags as C-tags."

would it be clearer to state that the strip/report behaviour itself is
unchanged and only the feature bit is removed?  The driver selftest
validator still expects ETH_P_8021AD metadata for an outer S-tag.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260919125413.18058-1-peilinhe2020%40163.com
