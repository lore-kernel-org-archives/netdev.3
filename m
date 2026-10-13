Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 643D354938C
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 21:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791926158; cv=none; b=ma45n6RymobCt2lUSIxPNE+IH7Vl66vX8S0I7LqZ6RrXmSt/0xr2gpjUHGfv9qdOvYVG58f5JWCtUeUt9PkeJIphoEQjTloGXmZTpC3XdsfnzimnTjW+7mq0yak02rpXieSSxa30jFzmetyMZVTwLyJxF3zH+roVT+Iqiu93PCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791926158; c=relaxed/simple;
	bh=G/E/Op9Jl0CUUYs3E3cbKzAmVpTBm25JlhxT0Wivp/E=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=inogTpRerUA0U9r1poe99xFGKPuhjYMQ5PUGV5JqyItw6k4JSxKqY3GdEK/lhk0t9Mv92LP1jqi60BbDQ2xzoYMSmIx/3Osyd4S5ylpskfzdIdcJRRrXjVPNMB4gNkvrKWOP+UcTQijIuw+K2oVjiNKnEAdT4hlquYNEj/ze7fI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CirzbTWD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CirzbTWD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D48C1F000FF;
	Tue, 13 Oct 2026 21:15:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791926155;
	bh=d5fkY+/d2fGHi/pup3lozU4tXD6DVvT5u2aPg9q7kC8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=CirzbTWDKjHmmzLfN8Amc1iCFgI0EuBGKswPpY/IWSjflsUnay73wh4bDqV3aD8QA
	 Wo7s2RKSficLHTZmeh7Nhn3jY9899UPFUWNk7BMzbpSymW64JgfB6voh1xbp8EJTfO
	 QbRECyHWJwf0FSaas9NfqH/K9V3aTZHc5azqKYnYvL2qhKeV+sfRn7mEriJmj/uxJF
	 WWeQ33v3ni6gJP3tWSTJEuk+oh5u1CIxFIX+Ul88ITQSxyBHq07BlQV1dt9Okw1D+3
	 uWznEnIDmEEzFPga7he0KMT4ePkdI8GNeT7sPQeBNJoYgBzfaa2uBaHfD0V6AyE63C
	 kSAnRJIV7jGSw==
Subject: Re: [PATCH net-next] net: stmmac: fix mqprio and cbs combination
From: netdev-bot+sashiko@kernel.org
To: lorenzo.bianconi@oss.qualcomm.com
Cc: maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, dcaratti@redhat.com,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 daniel@riscstar.com
Date: Tue, 13 Oct 2026 21:15:54 +0000
Message-ID: <179192615470.434549.15391678719442132292@kernel.org>
In-Reply-To:
 <20261012-stmmac-mqprio-cbs-combo-v1-1-831e323eb4ef@oss.qualcomm.com>
References:
 <20261012-stmmac-mqprio-cbs-combo-v1-1-831e323eb4ef@oss.qualcomm.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The commit message says the strict-priority scheduler selected
  by the channel-mode mqprio offload and the per-queue CBS shaper "are…

--

net: stmmac: fix mqprio and cbs combination

This patch removes the checks that stopped the channel-mode mqprio offload
and the CBS offload from being enabled together. It drops the AVB queue
rejection in tc_mqprio_validate_chan_mode(), the prio_offload check in
tc_setup_cbs(), and the matching AVB check in stmmac_reinit_queues().

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> index ea1f97d6f0bd5..175236ba379d0 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c

[ ... ]

> @@ -1350,18 +1346,6 @@ static int tc_mqprio_validate_chan_mode(struct stmmac_priv *priv,
>  		return -EOPNOTSUPP;
>  	}
>  
> -	/* Forcing strict priority conflicts with the CBS algorithm
> -	 * of AVB queues, so reject the offload when any queue is
> -	 * configured as AVB.
> -	 */
> -	for (i = 0; i < pdata->tx_queues_to_use; i++) {
> -		if (pdata->tx_queues_cfg[i].mode_to_use == MTL_QUEUE_AVB) {
> -			NL_SET_ERR_MSG_MOD(mqprio->extack,
> -					   "SP conflicts with AVB queues");
> -			return -EOPNOTSUPP;
> -		}
> -	}
> -

[Severity: High]

The commit message says:

  The strict-priority scheduler selected by the channel-mode mqprio
  offload and the per-queue CBS shaper are independent MTL settings and do
  not conflict

Is that true on XGMAC/XLGMAC cores? They use dwmac510_tc_ops, so both
tc_setup_dwmac510_mqprio() and tc_setup_cbs() can be reached on them.

On XGMAC, SP and CBS look like two values of the same per-TC TSA field.
dwxgmac2_prog_mtl_tx_algorithms() rewrites that field on every TC:

drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c:dwxgmac2_prog_mtl_tx_algorithms() {
    ...
	for (i = 0; i < MTL_MAX_TX_QUEUES; i++) {
		value = readl(ioaddr + XGMAC_MTL_TCx_ETS_CONTROL(i));
		value &= ~XGMAC_TSA;
		if (ets)
			value |= XGMAC_ETS;
		writel(value, ioaddr + XGMAC_MTL_TCx_ETS_CONTROL(i));
	}
}

dwxgmac2_config_cbs() turns CBS on by writing the same field:

drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c:dwxgmac2_config_cbs() {
    ...
	value = readl(ioaddr + XGMAC_MTL_TCx_ETS_CONTROL(queue));
	value &= ~XGMAC_TSA;
	value |= XGMAC_CC | XGMAC_CBS;
	writel(value, ioaddr + XGMAC_MTL_TCx_ETS_CONTROL(queue));
}

With this check gone, what happens if a TX queue is already in AVB mode?
One way to get there is a DT mtl-tx-config queue with snps,avb-algorithm.
In that case stmmac_open()->stmmac_mtl_configuration() programs CBS for the
queue when the device is opened.

After that, "tc qdisc replace ... mqprio ... mode channel hw 1" now
succeeds and runs:

tc_setup_dwmac510_mqprio()
  tc_mqprio_validate_chan_mode()
  tc_mqprio_config_queue_prio()
    stmmac_prog_mtl_tx_algorithms(priv, priv->hw, MTL_TX_ALGORITHM_SP)
      dwxgmac2_prog_mtl_tx_algorithms()

Would this also clear TSA on the AVB queue and turn CBS off in hardware?
Nothing calls stmmac_configure_cbs() again afterwards. Meanwhile
tx_queues_cfg[].mode_to_use still says MTL_QUEUE_AVB, so the driver state
and the hardware would disagree until the next ndo_open.

Removing mqprio seems to cause the same problem. prio_offload can now be
true while AVB queues exist, and stmmac_reset_tc_mqprio() then does:

	stmmac_prog_mtl_tx_algorithms(priv, priv->hw,
				      priv->plat->tx_sched_algorithm);

On XGMAC this rewrites TSA on every TC again (to ETS or SP). That would
wipe CBS on any AVB queue and not restore it.

The example in the commit message (mqprio first, then the cbs children)
works because config_cbs runs after the SP write.

On dwmac4/EQoS the claim does seem to hold.
dwmac4_prog_mtl_tx_algorithms() only touches MTL_OPERATION_SCHALG_MASK, and
CBS is enabled separately through MTL_ETS_CTRL_AVALG.

The commit in the Fixes: tag added these checks on purpose:

  Forcing strict priority conflicts with the CBS algorithm of AVB queues

Should the checks be kept for XGMAC? Or could the mqprio set and reset
paths call stmmac_configure_cbs() again after reprogramming the TX
algorithm?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012-stmmac-mqprio-cbs-combo-v1-1-831e323eb4ef%40oss.qualcomm.com
