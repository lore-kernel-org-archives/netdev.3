Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86054370AF3
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 04:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790830140; cv=none; b=lbk1GpfMv58+JCJPwqLpaGW+oSRoWSWFn25R0X3J58FEje7rtn2CTXDxuYBX7emwK8i0HYstoWbWnhuwt27rWJRt6zPAoYiOFRJK1XRID/ULTlddjJ1L+eI+hb0itGqJzqa207hhphSySZlno8KhmCerqAx8y5iT+pg/lbCvUC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790830140; c=relaxed/simple;
	bh=6f8IW/rqQlByM91DeX36lrShEkY3bX/mo9CVl4qVf/A=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H3tBElDD8wbou+RPaSvl1VPGynEJGyr8KhWIUfgUu8f95QwqRVV0H4a9KG3ghZhZvpiOvsoyp+N035AqfJ53VEmtHmt6upEGhMJKRw885SPIf/Sn4O0P+Sg9O3Ew9ZRRQNB+kr2aTdoBJmLqOxBc+s6xb7u4cVBxDS+KO+mQjQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffBse+Mg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffBse+Mg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 639F01F00898;
	Thu,  1 Oct 2026 04:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790830138;
	bh=+DkSaRksPctjXLY66uQzr4FJ5P5R5gD4v5VRG5Ua6/4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ffBse+MgvYCzgPDKjt6Wl/ZNW+vsC8XCd777IJ/skDZNt/V676zXRyXCmiL80AR2s
	 Z0W4rp0LAxM3TefGSCSk9j6cTX22UfWQwrCl1pNhJt/w0NLmWY93VuHQhy7LxvM6wo
	 c7Or/uEcDkW6rjiPwMoP0aBCxh0GJwjJi/n31P+2DRAQFQ0i+Ng1X/IHywCVPFdQZs
	 4Zj7+f9vjfOElaw2fnBmzKV46YPBX/o1bls5MoHGxcw3vDpVAUZGEjd4ZDsG8YT8k4
	 AAY/lqwKrfBslM1e7l/30oKeFLCZmtAmzB7Axu4ZbVQbQu581TqXwaryXfVeVLPdhg
	 pHnhfqrujKMuQ==
Subject: Re: [PATCH net-next v3 2/2] net: stmmac: align real_num_tx_queues to
 mqprio configuration
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, olteanv@gmail.com,
 0x1207@gmail.com, daniel@riscstar.com, netdev@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Date: Thu, 01 Oct 2026 04:48:56 +0000
Message-ID: <179083013698.434549.12585855850118896867@kernel.org>
In-Reply-To:
 <20260928-stmmac-mqprio-prio-offload-v3-2-abbe181f5024@oss.qualcomm.com>
References:
 <20260928-stmmac-mqprio-prio-offload-v3-2-abbe181f5024@oss.qualcomm.com>
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

- [Medium] The value this patch stores as "the count required by the
  active mqprio offload" (`priv->xmit_qdisc.num_tx_queues`) is…
- [Low] This patch carries `Fixes: 195e4f409a40` ("net: stmmac: support
  fp parameter of tc-mqprio", Sep 2024), but it depends on the commit…
- [Low] The hardware TX queue priority map (PSTQx on dwmac4/5, PSTC on
  XGMAC) becomes stale or inconsistent after `ethtool -L` while a…

--

net: stmmac: align real_num_tx_queues to mqprio configuration

This patch stores the TX queue count used by the active mqprio offload
in priv->xmit_qdisc.num_tx_queues. stmmac_hw_setup() now uses that value
instead of plat->tx_queues_to_use for real_num_tx_queues. The patch also
makes stmmac_reinit_queues() reject TX counts below the count the
offload needs.

> Fixes: 195e4f409a40 ("net: stmmac: support fp parameter of tc-mqprio")

[Severity: Low]
Can this patch be applied to a tree that only has 195e4f409a40?

It depends on the earlier commit in this series, "net: stmmac: add tc
mqprio hw queue priority offload", which is a new feature. That commit
added the xmit_qdisc struct in struct stmmac_priv, which this patch
extends.

It also added the hunk context used here. That context is the
"if (priv->xmit_qdisc.prio_offload) {" restore block in
stmmac_reset_tc_mqprio() and the tc_mqprio_config_queue_prio() call in
tc_setup_dwmac510_mqprio().

The bug being fixed already exists at 195e4f409a40. In that tree,
stmmac_hw_setup() calls
netif_set_real_num_tx_queues(dev, priv->plat->tx_queues_to_use), and
tc_setup_dwmac510_mqprio() lowers real_num_tx_queues to the offloaded
count.

Stable tooling that uses the Fixes: tag will not be able to apply this
patch unless it also takes the feature commit. Could the fix be reworked
to apply to net on its own? If not, could the commit message mention
the dependency?

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 27e4e86e3c8b..1c25d1c129d4 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

[ ... ]

> @@ -7676,6 +7676,10 @@ int stmmac_reinit_queues(struct net_device *dev, u8 rx_cnt, u8 tx_cnt)
>  	struct stmmac_priv *priv = netdev_priv(dev);
>  	int ret = 0, i;
>  
> +	if (priv->xmit_qdisc.enabled &&
> +	    tx_cnt < priv->xmit_qdisc.num_tx_queues)
> +		return -EINVAL;
> +

[Severity: Low]
While a channel-mode mqprio offload is active, this check still lets
tx_cnt grow, or shrink as far as num_tx_queues. Does xmit_qdisc.prio[]
stay in sync with the new queue count?

At install time, tc_mqprio_config_queue_prio() fills prio[i] only for
i < tx_queues_to_use. After ethtool -L raises the TX count, the path
stmmac_open()->stmmac_hw_setup()->stmmac_mtl_configuration()->
stmmac_mac_config_tx_queues_prio() programs every queue from prio[]:

	for (i = 0; i < priv->plat->tx_queues_to_use; i++)
		stmmac_tx_queue_prio(priv, priv->hw,
				     priv->xmit_qdisc.prio[i], i);

For the new queues, this writes the probe-time DT priority
(plat->tx_queues_cfg[i].prio). Channel mode would give those queues 0,
since they are outside every TC.

dwmac4_tx_queue_priority() clears only the target queue's field:

	value &= ~GMAC_TXQCTRL_PSTQX_MASK(queue);
	value |= (prio << GMAC_TXQCTRL_PSTQX_SHIFT(queue)) &
					GMAC_TXQCTRL_PSTQX_MASK(queue);

As a result, one 802.1p priority can be mapped to both a mqprio TC
queue and a newly added queue.

The reverse sequence looks possible too: shrink tx_cnt while mqprio is
active, delete the qdisc, then grow again. stmmac_reset_tc_mqprio()
restores defaults only up to the reduced count:

	for (i = 0; i < priv->plat->tx_queues_to_use; i++) {

That leaves the mqprio-era 0 values in prio[] for the upper queues. The
later increase writes those values while prio_offload is false, so the
DT-configured priorities for those queues are lost.

The prio[] state was added by the earlier "net: stmmac: add tc mqprio
hw queue priority offload" commit in this series. Before that commit,
stmmac_mac_config_tx_queues_prio() read plat->tx_queues_cfg directly.

The runtime impact may be small. These fields mostly select which
queues a received PFC frame pauses, and stmmac does not enable PFC
reception.

Should stmmac_reinit_queues() recompute prio[] for the new count? The
alternative would be to refuse any tx_cnt change while prio_offload is
set.

[ ... ]

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index 07cf4582ed76..8bdc411e902f 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c

[ ... ]

> @@ -1438,6 +1441,9 @@ static int tc_setup_dwmac510_mqprio(struct stmmac_priv *priv,
>  	if (mode == TC_MQPRIO_MODE_CHANNEL)
>  		tc_mqprio_config_queue_prio(priv, qopt);
>  
> +	priv->xmit_qdisc.num_tx_queues = num_tx_queues;
> +	priv->xmit_qdisc.enabled = true;
> +

[Severity: Medium]
Is num_tx_queues the right value to store here? Earlier in
tc_setup_dwmac510_mqprio(), it is computed as the sum of the counts,
but the validation checks offset + count:

	if (qopt->offset[i] + qopt->count[i] >
	    priv->plat->tx_queues_to_use) {
	...
	num_tx_queues += qopt->count[i];

mqprio_validate_queue_counts() rejects ranges that are out of bounds or
overlap. It still allows gaps and a non-zero first offset.
tc_mqprio_validate_chan_mode() requires offset[i] == i only in channel
mode, so DCB-mode layouts like "queues 1@0 1@2" or "queues 2@1" are
accepted.

For those layouts, netif_set_real_num_tx_queues(ndev, num_tx_queues)
reaches netif_setup_tc():

	/* If TC0 is invalidated disable TC mapping */
	if (res.offset + res.count > txq) {
		...
		WRITE_ONCE(dev->num_tc, 0);
		return;
	}
	...
		if (res.offset + res.count > txq) {
			...
			netdev_set_prio_tc_map(dev, i, 0);

With "1@0 1@2" the sum is 2, so every priority mapped to TC1 moves to
TC0. With "2@1", TC0 needs 3 queues but only 2 are real, so num_tc is
set to 0.

In both cases the function still returns success, with enabled = true
and num_tx_queues = 2.

This patch now keeps that value. stmmac_hw_setup() reapplies it on
every open and resume, and the new check in stmmac_reinit_queues()
compares tx_cnt against it.

That check allows sum <= tx_cnt < max(offset + count), which leaves
tx_cnt below queues that tc_to_txq[] still references. For "2@1", it
rejects tx_cnt values below 2 even though num_tc is already 0.

The sum-of-counts calculation predates this patch. Here it becomes the
"count required by the active mqprio offload" that the commit message
depends on.

Would storing max(offset[i] + count[i]) make the saved value, the
stmmac_reinit_queues() check and the stmmac_hw_setup() restore agree
with the validation?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928-stmmac-mqprio-prio-offload-v3-0-abbe181f5024%40oss.qualcomm.com
