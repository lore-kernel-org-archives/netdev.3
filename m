Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83C8146C4B7;
	Fri,  2 Oct 2026 08:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790930267; cv=none; b=Hwm5QHM2Josr/SUoTbCDZsbg4bGqjn7XbwVllXzHIxbcizlVn4sPDr2OIxNcpApM84lfYrEz5A0GP2Jnn/3Fd5jDdXGgxt1w816I4Jg70W7loiBoWlf4XrLIPA3NUY5bCcVxsoBIponyQ4Bjop16j7U+QUah1f/7dhe1k+dihBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790930267; c=relaxed/simple;
	bh=5rv+ThxWhaMmWN7HGMOapUO47tt4FgjT8Cs2MTGAaoU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ufs0tKsIsipEAvtpUPyODGrCrMeSGu3arP41q2HWJFL0w/6p/AtnTBts6YURQR/v+I5qrQLBwNIrLghAcdNx+n7ZN7Id5MIu1IWi9SrhVAvMxVf3RP/BlQ7GoxDem6qtqeDtv25nH4jfXrPc3H/46NDxOAKE5DT5yND+pxDXLuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NctdkWW1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NctdkWW1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BF221F00899;
	Fri,  2 Oct 2026 08:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790930266;
	bh=5o5SCapI3L7DNXmYYpH7Sbi3qiAsf3UPAxYLk7A7sww=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NctdkWW1+qSd+dRUCUKjhAt5OizSNKimhmetDLIjHCAmCpfMQkTOO/Cefx29IaCud
	 iaPBpkDjB6QicTB6wSyJopOtDqhD1syU18M+wtC9Ksq6/yujZUli5Fjy66cjLGZT26
	 CVgoQiD7qQwfibc24C4lt/3TFr1LYgZ+LcF/BUQzDHcfWk6TEf8Uubv/CqzKVsPzWc
	 ceyBGvu84TJcrAXyRhZeJ95QUWlbrZYeueL2TdB6O1WwIvmVLJ6yjzaRoczL33buNU
	 q5yjLnR2CFxtu6tV+Vo9qmeZaLES7jRbvlVng3JaMjBEBzqzfAm5HRxEWxEJTSAo1l
	 OR1oiwsy3nFRQ==
Subject:
 Re: [PATCH net v6 5/5] net: stmmac: Disable S-Tag processing on dwmac4
From: netdev-bot+sashiko@kernel.org
To: ovidiu.panait.rb@renesas.com
Cc: maxime.chevallier@bootlin.com, recv.jo@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, joabreu@synopsys.com,
 jun.ann.lai@intel.com, yi.fang.gan@intel.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Fri, 02 Oct 2026 08:37:44 +0000
Message-ID: <179093026479.434549.5508672622389418714@kernel.org>
In-Reply-To: <20260928203441.34876-6-ovidiu.panait.rb@renesas.com>
References: <20260928203441.34876-6-ovidiu.panait.rb@renesas.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The fix is incomplete: XGMAC still passes hardware-stripped
  802.1ad tags up the stack as 802.1Q.
- [Low] After this patch, the two S-VLAN selftests check for different
  things.

--

net: stmmac: Disable S-Tag processing on dwmac4

This commit limits NETIF_F_HW_VLAN_STAG_RX and NETIF_F_HW_VLAN_STAG_FILTER
to DWMAC_CORE_XGMAC. The reason given is that dwmac4 cannot report which
tag type was stripped, and vlan_rx_hw() hardcodes ETH_P_8021Q. On dwmac4,
802.1ad tags are then left in the packet for the software VLAN path.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 2ce6e2724bcb..b837e8e27a35 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -8005,14 +8005,18 @@ static int __stmmac_dvr_probe(struct device *device,
>  	ndev->watchdog_timeo = msecs_to_jiffies(watchdog);
>  #ifdef STMMAC_VLAN_TAG_USED
>  	/* Both mac100 and gmac support receive VLAN tag detection */
> -	ndev->features |= NETIF_F_HW_VLAN_CTAG_RX | NETIF_F_HW_VLAN_STAG_RX;
> +	ndev->features |= NETIF_F_HW_VLAN_CTAG_RX;
> +	if (priv->plat->core_type == DWMAC_CORE_XGMAC)
> +		ndev->features |= NETIF_F_HW_VLAN_STAG_RX;
> +
>  	if (dwmac_is_xmac(priv->plat->core_type)) {
>  		ndev->hw_features |= NETIF_F_HW_VLAN_CTAG_RX;
>  		priv->hw->hw_vlan_en = true;
>  	}

[Severity: High]
Won't XGMAC still pass hardware-stripped 802.1ad tags up the stack as
802.1Q after this change?

The commit message says that on dwxgmac2 "the outer tag type can be
determined based on that info". However, nothing in this patch or the rest
of the series actually does that.

dwxgmac210_vlan_ops still uses vlan_rx_hw() as .rx_hw_vlan, and that
function is unchanged:

drivers/net/ethernet/stmicro/stmmac/stmmac_vlan.c:vlan_rx_hw() {
	if (hw->desc->get_rx_vlan_valid(rx_desc)) {
		u16 vid = hw->desc->get_rx_vlan_tci(rx_desc);

		__vlan_hwaccel_put_tag(skb, htons(ETH_P_8021Q), vid);
	}
}

dwxgmac2_wrback_get_rx_vlan_valid() accepts the ET_LT values with an S-tag
outer tag, but it returns only a bool, so the tag type is lost:

	return et_lt >= XGMAC_ET_LT_VLAN_STAG &&
	       et_lt <= XGMAC_ET_LT_DVLAN_STAG_CTAG;

On XGMAC, hw_vlan_en is still set and STAG_RX/STAG_FILTER are still
advertised. stmmac_fix_features() also still ties STAG_RX to CTAG_RX.
Creating an 802.1ad VLAN on an XGMAC with vlhash then leads to:

stmmac_vlan_rx_add_vid(is_svlan = true)
  dwxgmac2_update_vlan_hash()    /* sets VLAN_ESVL */

and on receive:

stmmac_rx()
  stmmac_rx_hw_vlan()
    vlan_rx_hw()                 /* tags the skb as ETH_P_8021Q */

vlan_do_receive() then looks up (ETH_P_8021Q, vid), so the 802.1ad VLAN
device never gets the frame. Isn't this the same QinQ ping failure the
commit message describes?

Also, if an 802.1Q VLAN with the same VID exists, would S-tagged frames
from the wire be delivered to that interface instead?

Should vlan_rx_hw() take the protocol from ET_LT on XGMAC? Or should S-tag
offload be turned off on XGMAC as well?

>  	if (priv->dma_cap.vlhash) {
>  		ndev->features |= NETIF_F_HW_VLAN_CTAG_FILTER;
> -		ndev->features |= NETIF_F_HW_VLAN_STAG_FILTER;
> +		if (priv->plat->core_type == DWMAC_CORE_XGMAC)
> +			ndev->features |= NETIF_F_HW_VLAN_STAG_FILTER;
>  	}

[Severity: Low]
On dwmac4, vlhash no longer implies NETIF_F_HW_VLAN_STAG_FILTER. Should
stmmac_test_svlanfilt() in stmmac_selftests.c be updated to match? It
still checks only:

	if (!priv->dma_cap.vlhash)
		return -EOPNOTSUPP;

Its sibling, stmmac_test_svlanfilt_perfect(), checks the feature flag:

	if (!(priv->dev->features & NETIF_F_HW_VLAN_STAG_FILTER))
		return -EOPNOTSUPP;

On a dwmac4 with vlhash, __stmmac_test_svlanfilt() calls
vlan_vid_add(priv->dev, htons(ETH_P_8021AD), tpriv->vlan_id). Without
STAG_FILTER, vlan_hw_filter_capable() returns false for 802.1ad. As a
result, stmmac_vlan_rx_add_vid() is never called and no S-VLAN filter is
programmed.

The test still runs, and for i > 0 the loop treats a missing tpriv->ok as
success:

		ret = tpriv->ok ? 0 : -ETIMEDOUT;
		if (ret && !i) {
			goto vlan_del;
		} else if (!ret && i) {
			ret = -EINVAL;
			goto vlan_del;
		} else {
			ret = 0;
		}

Can "SVLAN Filtering" then report a pass on hardware that no longer uses
S-VLAN filtering, while the perfect variant is skipped?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928203441.34876-1-ovidiu.panait.rb%40renesas.com
