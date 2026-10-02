Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7658344C4FE;
	Fri,  2 Oct 2026 08:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790930264; cv=none; b=m8pTSqkXZiUc76oP8EjBtZyghmHOuRlaqw4gRf9Tg58QO/n2Xi1jtv1AIUXxUrOdiQRUTb8Zp/duAWu680vO/4eyKAPV6EBByBkUbPpm4q/bkqyF4NZl/3I5+6kDJdseu5oqpfFuDW40BndU1YWB/m2DKBLpRO8C363F/Xh7ctU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790930264; c=relaxed/simple;
	bh=VZvy7b8gg8LxwDcWP30VQpZf+d1pkZHMpIdfMQtzQgw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pEEnxC5lTroMp8ke9p/1DFn2kUTul9tDPXt8rW94Fzfq6xGzGgp9HwEvyq+JFj6Ps/pkwm5WMH4XJJA+Dg76ddx715yBVxxspMQ3BA3Yh77RiUDKl/zowNdDT+nzTJbwUuJYNLmpc+aBacsHxK9zZan0sr4VtXy5b41BhVdBVf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L7cxux2w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L7cxux2w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62CFD1F00893;
	Fri,  2 Oct 2026 08:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790930263;
	bh=Ca3NJmloy5CY1dK3ZsDSlMX2KFBwCZJbczLgVJy9Vb0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=L7cxux2wcZaU+JAQJJPDtAo8C0VkdEHKSchMkRJnTtk4w3U5vo2jHZOzknN+bek/d
	 V4EYVx8MKy7sEmc3HoI94Ii+CCaPj5o2ATsQ3d+8kDvH59YKj9ZA8zrSGC4Zs4SD5J
	 D9N4gwy6y1TV2XIpvNb81HlhViWTPh6tG/3vTKV6IVlplEn7hEXrIX8nJfs6SXuly+
	 8XErtRchny2PAnkNkUFwHOdK37BaShRi2SKrs4B88IEqpXtjT/LWuWhJrBDotEmZgO
	 dSzWSbZU3q+iotfoC7+/f92e9sv24mn2t4t5cPVADj/GQbASM3xDtCYePtFgLG0QhE
	 MjCpdLbBteK0Q==
Subject: Re: [PATCH net v6 2/5] net: stmmac: Stop toggling the EDVLP bit
From: netdev-bot+sashiko@kernel.org
To: ovidiu.panait.rb@renesas.com
Cc: maxime.chevallier@bootlin.com, recv.jo@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 jun.ann.lai@intel.com, yi.fang.gan@intel.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 02 Oct 2026 08:37:41 +0000
Message-ID: <179093026198.434549.6427889648540734554@kernel.org>
In-Reply-To: <20260928203441.34876-3-ovidiu.panait.rb@renesas.com>
References: <20260928203441.34876-3-ovidiu.panait.rb@renesas.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The COE benefit that the commit message gives as its reason
  for this change never shows up in this tree.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but it is still
  there at the end of the series for XGMAC 2.10.

--

net: stmmac: Stop toggling the EDVLP bit

The EDVLP bit is no longer set and cleared in the VLAN hash update paths
when an 802.1ad VLAN is registered. It is now always set from
vlan_set_hw_mode(), and a new dwxlgmac2_set_hw_vlan_mode() callback sets it
on dwxlgmac2 as well.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
> index 983a90cb9767..200b34588c7f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c

[ ... ]

> @@ -222,6 +219,7 @@ static void vlan_set_hw_mode(struct mac_device_info *hw)
>  	void __iomem *ioaddr = hw->pcsr;
>  	u32 value = readl(ioaddr + VLAN_TAG);
>  
> +	value |= VLAN_EDVLP;
>  	value &= ~VLAN_TAG_CTRL_EVLS_MASK;
>  
>  	if (hw->hw_vlan_en)

[Severity: Medium]
The commit message says EDVLP is kept always enabled "so that COE can work
for packets with an inner VLAN header". Does the driver actually use the
checksum offload result for those packets?

stmmac_has_ip_ethertype() in stmmac_main.c rejects any frame that still has
a VLAN header in the payload:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_has_ip_ethertype() {
    ...
	proto = __vlan_get_protocol(skb, eth_header_parse_protocol(skb),
				    &depth);

	return (depth <= ETH_HLEN) &&
		(proto == htons(ETH_P_IP) || proto == htons(ETH_P_IPV6));
}

On RX, EVLS=STRIP_ALL strips only the outer tag and EIVLS is never
programmed, so the inner 802.1Q header stays in-band. Both stmmac_rx() and
stmmac_dispatch_skb_zc() then drop the hardware result:

	if (unlikely(!coe) || !stmmac_has_ip_ethertype(skb) ||
	    (status & csum_none))
		skb_checksum_none_assert(skb);

On TX, stmmac_features_check() clears the checksum features for the same
skbs. STAG_TX is not advertised, so a QinQ frame always has at least one
in-band tag:

	if (priv->plat->tx_queues_cfg[queue].coe_unsupported ||
	    !stmmac_has_ip_ethertype(skb))
		features &= ~(NETIF_F_IP_CSUM | NETIF_F_IPV6_CSUM);

This holds whether or not EDVLP is set. No later patch in the series changes
stmmac_has_ip_ethertype(). The later patch "net: stmmac: Rename double VLAN
references to svlan" also says "the networking core does not support
offloads for the inner tag anyway".

This patch changes VLAN_TAG programming on all DWMAC4/5, XGMAC and XLGMAC
cores. Could the COE rationale be dropped or corrected in the commit
message? If COE for inner-VLAN frames is the goal, does
stmmac_has_ip_ethertype() also need updating, along with a Fixes: tag?

> @@ -254,11 +252,9 @@ static void dwxgmac2_update_vlan_hash(struct mac_device_info *hw, u32 hash,
>  
>  		value |= VLAN_VTHM | VLAN_ETV;
>  		if (is_double) {
> -			value |= VLAN_EDVLP;
>  			value |= VLAN_ESVL;
>  			value |= VLAN_DOVLTC;
>  		} else {
> -			value &= ~VLAN_EDVLP;
>  			value &= ~VLAN_ESVL;
>  			value &= ~VLAN_DOVLTC;
>  		}

[Severity: High]
This problem was not introduced by this patch. It is still present on
XGMAC 2.10 cores at the end of the series, though.

Registering an 802.1ad VID follows this call chain, with is_double set:

stmmac_vlan_rx_add_vid()->stmmac_vlan_update()->dwxgmac2_update_vlan_hash()

That sets ESVL and DOVLTC. With hw_vlan_en, which is the default on XGMAC,
vlan_set_hw_mode() also programs EVLS=STRIP_ALL and EVLRXS. The MAC then
strips 0x88A8 outer tags and writes the TCI into RDES0.

dwxgmac2_wrback_get_rx_vlan_valid() accepts the S-tag packet types:

	return et_lt >= XGMAC_ET_LT_VLAN_STAG &&
	       et_lt <= XGMAC_ET_LT_DVLAN_STAG_CTAG;

However, vlan_rx_hw() always reports the stripped tag as a C-tag:

drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c:vlan_rx_hw() {
	if (hw->desc->get_rx_vlan_valid(rx_desc)) {
		u16 vid = hw->desc->get_rx_vlan_tci(rx_desc);

		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vid);
	}
}

Won't S-tagged frames then go to an 802.1Q upper device with the same VID,
or be dropped, and never reach the 802.1ad upper device? The software path
in stmmac_rx_vlan() does tell ETH_P_8021AD apart, so the two paths disagree.

The last patch in the series, "net: stmmac: Disable S-Tag processing on
dwmac4", stops advertising STAG_RX/STAG_FILTER only on dwmac4. Its commit
message says the XGMAC tag type can be derived from ET_LT. Yet vlan_rx_hw()
is unchanged, and XGMAC still advertises the S-tag features in
__stmmac_dvr_probe():

	if (priv->plat->core_type == DWMAC_CORE_XGMAC)
		ndev->features |= NETIF_F_HW_VLAN_STAG_RX;

On XGMAC, should vlan_rx_hw() use ET_LT to report ETH_P_8021AD, or should
XGMAC also stop advertising the S-tag features?

S-tag recognition appears to be controlled by ESVL/DOVLTC, not EDVLP.
Setting EDVLP unconditionally here does not seem to make this worse.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928203441.34876-1-ovidiu.panait.rb%40renesas.com
