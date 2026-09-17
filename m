Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7FB39E164;
	Thu, 17 Sep 2026 15:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789657714; cv=none; b=PiIb0DjY98o+Oug9JfTCgoC28uYtJhrr2RXjvp9JrruZG2mgcrV/WQxgce2Ai9I+KuBIylTSdGfGlJ/uIgBbNcHwjdm02fJdMa8xfisixmAlEu1rHH1/Bmo9yWgrs4BUuufs4N1sorniNhYuTNaDcgZkvMk/3VPrI98RwZrSdyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789657714; c=relaxed/simple;
	bh=6Urlqpktwtq8QtAPgsPADbTm68qTmNbEco6pu13t0jQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=u0RujrEpjrYocRSfK/FMI30cLvCMiChdgO75Ru8KQWz7BScqxMXrmG7PkA14Tn2UCa/qEwyh3JWfX/s7FKnQmF/ee3ctkK5FqCjfP6cdJNQlCFhN+kCyyEn4q7CmRiCgfXFWwBc4//1X5mzbjISdEdxfQy/hvPxI9yF15WjHxJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PD9IWT1x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PD9IWT1x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B538B1F00893;
	Thu, 17 Sep 2026 15:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789657700;
	bh=eB96u+IWQTAT0J4Wbp7shtE3p6r8hJDFOcT9dCgxO+Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=PD9IWT1xDWwGeRAgL0XfFgRwkO/9UJW1yWqiF8nBxUua63/APRDVgT+oKbWLIrbnG
	 kg7lvpgckLOKVLgMvhzOzYztaYBjyQTWpHbRyL083eIybgHzsiQUMK7CnGCce3IWuf
	 GMFryB6C5HTC+Y/HVSVFq/Lfp90i5jiWmZi3cIt47Rc5Kx+jkcdC9z/aLLZlCAOmyq
	 UWqBwRqy2EBzh9cgaYPm5OvhF+8bwvUSaCC3ZsPjEe7n/V5kTrckDUSHaKPiZhf+ku
	 1hnOSj+W8I7biZR0gBpHEtcLZMHd/j/0LTujTPeYVqHfVRQ5R3aJxMaIDfO0qPBRwd
	 liutAVQgJnseQ==
Subject:
 Re: [PATCH net v7 2/2] net: stmmac: remove software VLAN tag stripping
From: netdev-bot+sashiko@kernel.org
To: peilinhe2020@163.com
Cc: netdev@vger.kernel.org, alexandre.torgue@foss.st.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 he.peilin@zte.com.cn, jiang.kun2@zte.com.cn, kuba@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com, maxime.chevallier@bootlin.com,
 mcoquelin.stm32@gmail.com, pabeni@redhat.com, vbridgers2013@gmail.com,
 xu.xin16@zte.com.cn
Date: Thu, 17 Sep 2026 15:08:19 +0000
Message-ID: <178965769932.22033.14308722904090067868@kernel.org>
In-Reply-To: <20260914150612.9798-3-peilinhe2020@163.com>
References: <20260914150612.9798-3-peilinhe2020@163.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 2 (1) · Low: 0

- [High] Loss of RX hardware checksum indication for every VLAN-tagged
  frame on cores without MAC-level stripping.
- [Medium] Undocumented user-visible netdev-feature change bundled with
  the cleanup.
- [Medium] Commit-message/tagging defects: a cleanup that removes
  advertised netdev features carries `Fixes: b93819854d6e ("stmmac: Add…

Pre-existing issues:
- [Medium] RX VLAN offload is advertised for DWXLGMAC, whose VLAN ops
  cannot perform it: `__stmmac_dvr_probe()` sets NETIF_F_HW_VLAN_CTAG_RX…

--

net: stmmac: remove software VLAN tag stripping

This removes stmmac_rx_vlan() and its two call sites in stmmac_rx() and
stmmac_dispatch_skb_zc(), on the grounds that GRO has handled non
hardware accelerated VLAN frames since 2015.  It also stops advertising
NETIF_F_HW_VLAN_CTAG_RX / NETIF_F_HW_VLAN_STAG_RX unconditionally and
instead sets only NETIF_F_HW_VLAN_CTAG_RX inside the dwmac_is_xmac()
branch in __stmmac_dvr_probe().

A couple of questions about the commit message first:

>     Fixes: b93819854d6e ("stmmac: Add vlan rx for better GRO performance.")
>     Signed-off-by: Peilin He <he.peilin@zte.com.cn>
>     Maxime Chevallier <maxime.chevallier@bootlin.com>

[Severity: Medium]
The body describes a cleanup ("no longer necessary and only adds
complexity") and no failure mode, yet the change carries a Fixes: tag and
also removes advertised netdev features.  Is the Fixes: tag intended here?
With it, stable and AUTOSEL tooling will pick up a user visible feature
removal (rx-vlan-offload turning off on dwmac100/dwmac1000,
rx-vlan-stag-hw-parse disappearing everywhere) into trees where nothing is
broken.

The dependency on the companion patch ("net: stmmac: selftests: Prevent RXC
from being disabled in LPI") is only mentioned in the changelog below the
--- separator, so it is not part of the permanent commit log.  Should that
dependency be recorded in the commit message so a lone backport of this
patch does not regress the selftests?

Also, the line

    Maxime Chevallier <maxime.chevallier@bootlin.com>

has no trailer prefix (Reviewed-by/Suggested-by/Co-developed-by), so the
attribution is ambiguous and checkpatch will complain about it.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 62c3441911e71..0d097094fa453 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -5049,24 +5049,6 @@ static netdev_features_t stmmac_features_check(struct sk_buff *skb,
>  	return vlan_features_check(skb, features);
>  }
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

[ ... ]

> @@ -5435,9 +5417,7 @@ static void stmmac_dispatch_skb_zc(struct stmmac_priv *priv, u32 queue,
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
Does this drop RX checksum offload for every VLAN tagged frame when
priv->hw->hw_vlan_en is false?

With the else branch gone, the 802.1Q/802.1AD header stays in the payload,
and the checksum decision right below is gated on
stmmac_has_ip_ethertype():

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_has_ip_ethertype() {
	proto = __vlan_get_protocol(skb, eth_header_parse_protocol(skb),
				    &depth);

	return (depth <= ETH_HLEN) &&
		(proto == htons(ETH_P_IP) || proto == htons(ETH_P_IPV6));
}

For a freshly built RX skb, napi_build_skb() leaves skb->mac_len as 0 and
eth_type_trans() does not set it, so __vlan_get_protocol_offset() starts
parsing at ETH_HLEN:

net/core/skbuff.c:__vlan_get_protocol_offset() {
	unsigned int vlan_depth = skb->mac_len, parse_depth = VLAN_MAX_DEPTH;
	...
	} else {
		vlan_depth = ETH_HLEN;
	}

A single tagged frame then yields depth == ETH_HLEN + VLAN_HLEN == 18, so
the depth <= ETH_HLEN test fails and stmmac_has_ip_ethertype() returns
false for all still-tagged frames.  Before this change stmmac_rx_vlan()
had already popped the tag, so depth stayed at 0 and the hardware verdict
was honoured.

In this zero copy path there is no status & csum_none term at all, so the
result is skb_checksum_none_assert() for every tagged frame even though
the COE result is available.

Should stmmac_has_ip_ethertype() be taught to tolerate an in-payload VLAN
tag (or be evaluated with mac_len set) as part of this change?

> @@ -5929,9 +5909,6 @@ static int stmmac_rx(struct stmmac_priv *priv, int limit, u32 queue)
>  		if (priv->hw->hw_vlan_en)
>  			/* MAC level stripping. */
>  			stmmac_rx_hw_vlan(priv, priv->hw, p, skb);
> -		else
> -			/* Driver level stripping. */
> -			stmmac_rx_vlan(priv->dev, skb);
>  
>  		skb->protocol = eth_type_trans(skb, priv->dev);
>  

[Severity: High]
Same question for the main receive path.  stmmac_rx() has:

	if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb) ||
	    (status & csum_none))
		skb_checksum_none_assert(skb);
	else
		skb->ip_summed = CHECKSUM_UNNECESSARY;

Since stmmac_has_ip_ethertype() now sees the VLAN ethertype and a depth of
18, does every tagged IPv4/IPv6 frame fall back to software checksum
validation on cores where hw_vlan_en is false, i.e. dwmac100/dwmac1000
after the probe hunk below, and any xmac core with ethtool -K rxvlan off?
dwmac1000 does report rx_coe_type1/type2, so the hardware result exists.

> @@ -7990,9 +7967,8 @@ static int __stmmac_dvr_probe(struct device *device,
>  	ndev->features |= ndev->hw_features | NETIF_F_HIGHDMA;
>  	ndev->watchdog_timeo = msecs_to_jiffies(watchdog);
>  #ifdef STMMAC_VLAN_TAG_USED
> -	/* Both mac100 and gmac support receive VLAN tag detection */
> -	ndev->features |= NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_STAG_RX;
>  	if (dwmac_is_xmac(priv->plat->core_type)) {
> +		ndev->features |= NETIF_F_HW_VLAN_CTAG_RX;
>  		ndev->hw_features |= NETIF_F_HW_VLAN_CTAG_RX;
>  		priv->hw->hw_vlan_en = true;
>  	}

[Severity: Medium]
This hunk changes what ethtool -k reports, but the commit message only
talks about deleting the software stripping helper.  Could the changelog
cover the feature changes too?

On dwmac100/dwmac1000, rx-vlan-offload goes from on [fixed] to off, and
there is no hardware replacement: the MAC100 and GMAC entries in
stmmac_hw[] in hwif.c have no .vlan member at all.

NETIF_F_HW_VLAN_STAG_RX is now gone on every core, including xmac cores
where the MAC still strips S-tags and reports them as C-tags:

drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c:vlan_set_hw_mode() {
		value |= VLAN_TAG_STRIP_ALL;

drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c:vlan_rx_hw() {
		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vid);

Is the advertisement now inconsistent with what the hardware does there?

There is also a side effect on platforms that end up with no
NETIF_F_VLAN_FEATURES bit in priv->dev->features:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_phylink_setup() {
	if (!(priv->plat->flags & STMMAC_FLAG_RX_CLK_RUNS_IN_LPI) &&
	    !(priv->dev->features & NETIF_F_VLAN_FEATURES))
		config->eee_rx_clk_stop_enable = true;

so EEE RX clock stop becomes permitted where it previously was not.  That
consequence is acknowledged only in the companion selftests patch; should
it be described here as well?

[Severity: Medium]
This isn't a bug introduced by this patch, but since the block is being
rewritten here it may be worth revisiting: the gate is the core family
rather than the presence of the VLAN callbacks.  dwmac_is_xmac() returns
true for DWMAC_CORE_XGMAC, and the DWXLGMAC_ID entry in stmmac_hw[] in
hwif.c binds dwxlgmac2_vlan_ops:

drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c {
	const struct stmmac_vlan_ops dwxlgmac2_vlan_ops = {
		.update_vlan_hash = dwxgmac2_update_vlan_hash,
		.enable_vlan = vlan_enable,
	};

With neither .set_hw_vlan_mode nor .rx_hw_vlan, both
stmmac_set_hw_vlan_mode() and stmmac_rx_hw_vlan() are
stmmac_do_void_callback() no-ops, so EVLS/EVLRXS is never programmed and
no tag is ever put in skb->vlan_tci, while ethtool still shows
rx-vlan-offload as on.  Would gating on the presence of .rx_hw_vlan and
.set_hw_vlan_mode be more accurate than dwmac_is_xmac()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914150612.9798-1-peilinhe2020%40163.com
