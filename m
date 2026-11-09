Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794183824;
	b=Ea54IdR9G/dM01QZyxVZ1LqZvNUCNXYvf+aQ2/INEhdDPpVj9xRfEagsGv5iIqXYjzE2
	 /9iKPrCHEPoqknsFYhw5q8oPIQy2EeNiGapJAsnHYZEMGEnThXG3CV7eUtssEIpNMg/RH
	 tUAX0d/qtrUDQtgllHmmoXB1yoNc3JtsAtP/dxaCGSvd88xCVraR9kacgn4lzCQMOpYUU
	 ukOvVT46jJ3nFN6FNYZqOR9/3W4+VS1EzAvSYX3pAUIzRjSynnBeyiVEnrZlB5PaMnJxO
	 KI/uxkUCrPCm4X4GxfUctmUdsOcB6Qrs2BCIB/6lcU6g1l09vu2CYQG1KCnnqJnXbtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794183824;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Lx6Grov/zc6oWr79TRH0xIwUDqb9Dyp00t6EBxy04Zw=;
	b=uOX3rWIXhJOCeUJhZHFDRUsVWGAFDwiRUPFwOHTPOH/HP4iu0xAL7YShxRpuRz0BvQwA
	 ijuqDzbQUn5SDpdo0FQECpVs75KxYtrgii1lG7hZuZs36fFoSvDdzJzA9BoxWqTM44gjd
	 /0S4zSTBaUgTvZMGCmCOpAvA51KgruIN6yDXkKf0GUDigl/MaDHkIBefC51gI4hTOvDRK
	 o7JFZSJsa6FBrXFKkzN/AzHBqTHKo9dbNtSKyQFrPJbXjxPGsJUObNRvNJWOP1TWg6Tnz
	 u3FQCmDPlpOuTFl3CeyYtxpDsopRteKNOg2ZCfAWhQvwb1SS4KVR8vD7VKEPrueUejA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eCuNuszQ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7029606A325;
	Mon,  9 Nov 2026 00:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=eCuNuszQ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B89401F008A1;
	Mon,  9 Nov 2026 00:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794183823;
	bh=Lx6Grov/zc6oWr79TRH0xIwUDqb9Dyp00t6EBxy04Zw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=eCuNuszQtbev08wTuIKXZPdpM2SIIZghiteSuHX5AIKhZBBBFUlNRt0tw2nqAfyvp
	 8ox6TP3h6u3dPTV2o6hHvE6Zjs2pttnHwYtKGoy1WDYJQQAJVFOf1BKz/MAWFhNiQG
	 15hWaqqp9H0eYsnZYv/+fZ61BQNmAoWJF3WuDewrejfJ+KJov7q7w4zs5AFEIIcypt
	 psWld0g2SSA8P+XTg7CkRKbOp7MzSPeaCRN035OZN86dYzlAIbVc7Ni9Ns2DTNfdz9
	 F1xeCTDAA51r4FLyTUy01iU4K3Vcx480aw+8W/jRrT9+6FPl3PPcmF9PkPa1iXzziH
	 wruyWU2Obc+rQ==
Subject:
 Re: [PATCH net v3 2/5] net: mvneta: fix the removal of the mqprio offload
From: netdev-bot+sashiko@kernel.org
To: pepe.schlehofer@gmail.com
Cc: netdev@vger.kernel.org, marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, w@1wt.eu, linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 00:23:42 +0000
Message-ID: <179418382232.994134.527743544498761844@kernel.org>
In-Reply-To: <20261104224518.66487-3-pepe.schlehofer@gmail.com>
References: <20261104224518.66487-3-pepe.schlehofer@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] With this patch, an all-zero mqprio teardown always reaches
  the global hardware reset in mvneta_setup_mqprio()…

--

net: mvneta: fix the removal of the mqprio offload

This patch lets mvneta_setup_mqprio() reach its teardown code when
mqprio_disable_offload() passes an all-zero configuration. Deleting an
offloaded mqprio qdisc now clears the traffic classes and the per-queue
rate limits. The qopt.hw check now applies only when num_tc is non-zero.

> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index 9b9efac2846ef..79711a117c39c 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -5251,11 +5251,12 @@ static int mvneta_setup_mqprio(struct net_device *dev,
>  	int rxq, txq, tc, ret;
>  	u8 num_tc;
>  
> -	if (mqprio->qopt.hw != TC_MQPRIO_HW_OFFLOAD_TCS)
> -		return 0;
> -
>  	num_tc = mqprio->qopt.num_tc;
>  
> +	/* On removal the qdisc passes an all-zero qopt, with hw 0 */
> +	if (num_tc && mqprio->qopt.hw != TC_MQPRIO_HW_OFFLOAD_TCS)
> +		return 0;
> +

[Severity: Medium]

Can this teardown wipe out the configuration of a replacement mqprio
qdisc?

Take an offloaded mqprio root that gets replaced under a new handle with
something like:

  tc qdisc replace dev ethX root handle 2: mqprio ... hw 1 \
      mode channel shaper bw_rate max_rate ...

The core sets up the new qdisc before it destroys the old one:

tc_modify_qdisc()
  qdisc_create()
    mqprio_init()
      mqprio_enable_offload()
        mvneta_setup_mqprio()        /* num_tc = N, hw = 1 */
  qdisc_graft()
    notify_and_destroy()
      mqprio_destroy()               /* old qdisc, hw_offload == 1 */
        mqprio_disable_offload()
          mvneta_setup_mqprio()      /* all-zero qopt */

Before this patch, the hw == 0 early return ignored the second call. Now
that call goes through to the port-wide reset in mvneta_setup_mqprio():

	mvneta_clear_rx_prio_map(pp);

	if (!num_tc) {
		mvneta_disable_per_queue_rate_limit(pp);
		netdev_reset_tc(dev);
		return 0;
	}

The reset does three things:

  - it writes 0 to MVNETA_VLAN_PRIO_TO_RXQ
  - it sets TXQ_CMD1 back to the V1 limiter and refills every TXQ bucket
    at MVNETA_TXQ_BUCKET_REFILL_VALUE_MAX
  - it resets dev->num_tc

The replacement qdisc had just programmed all of this state. With the
rest of the series, the zero call also clears txq_fixed_prio in
mvneta_setup_tc().

The new qdisc still has priv->hw_offload set, so tc shows "hw 1" and the
configured max_rate values. The hardware, however, does no shaping and
steers every VLAN priority to RX queue 0.

mqprio has no .change op. Replacing under a new handle is therefore the
only way to change the configuration without deleting the qdisc first.

The commit message says:

  "Replacing an offloaded mqprio qdisc under a new handle with another
  qdisc that sets traffic classes therefore loses them, as with software
  mqprio."

Software mqprio has no hardware shaper or RX steering to lose. Does this
description cover the mqprio-over-mqprio case, where the rates and RX
steering are dropped while tc still reports them?

The later patch "net: mvneta: keep the TX rate limits across open and
MTU change" treats the same symptom ("tc still shows the configured
rates" while they are not applied) as a bug. No later patch in the series
seems to handle this replace path.

Other mqprio offload drivers, such as enetc_setup_tc_mqprio() and
am65_cpsw_setup_mqprio(), also treat num_tc == 0 as an unconditional
teardown. The problem comes from the core's create-before-destroy
ordering, which those drivers share.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104224518.66487-1-pepe.schlehofer%40gmail.com
