Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793705354;
	b=FI08M1f9wrrxHSQlZ6r+DUMdYsphUEZv+gQbjHLqTT87tl5bxBRVRFMSeacyZqD79RuE
	 X+iJqk2+wK47kXsbKh+0J4jIaPLU0Co9TYawQeRGreuaL41KU6mv60g3eqUhFWV7vv5cj
	 b8LjbPste3O/B0gqftc7XqdzfI61vdVW+CFEwULrwqpJotCA/GHQx8Q+fOQUJcszIq86/
	 YoHCGNhQR6jG8nnRPXuh2jiVmKSI/mNyvKWC3EWFxy3WWgnPuGRDB3ihVPgsihfYc9FzQ
	 K8BwAV3v95F/nzeKL0oFvJE8GR2b+ekdS1k81gSTyrlu8wWdvdkSfvF0n5cHlhGrebQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793705354;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=RkE+5jbl3MXhsI1+nK0zwKtNh21gpq5P9pRPjsjzQxU=;
	b=qqf9I9YXkCf/Cs0PWp4lj1jqgSMmngxRI9OrunklqlFlpm0JaPGq6iWRl9AvMOL1YS+O
	 +LjMgJoGu/4zf1SOvNG7uUsPF/jYlhjrBAKo28f3lNnT+JlmWSVwZ3wvuN1WRA+TRR7/5
	 UVfpMp/IineBxohfIQL6ZzgecS/iVXLtz8EKvfx0VwiCU5bVmGIRxxNpeLbHj0iknZPAl
	 ZrmvjybQA9CHsU3O7ZLZ1IOwvTMUHZJNmFBHo8jg+3q9up5D4NMDTpfyEoE3xZe35vK3c
	 ucZnXoILzF711ZECFSTvV7YjWr5qJ69X/3QlvWU53ug6cFvRBPmKXl1c8s1Mj3V4fqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=meiwIxRM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CECD606A830;
	Tue,  3 Nov 2026 11:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=meiwIxRM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5468E1F0093A;
	Tue,  3 Nov 2026 11:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793705353;
	bh=RkE+5jbl3MXhsI1+nK0zwKtNh21gpq5P9pRPjsjzQxU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=meiwIxRMEj3mHQLqACGnF1yS6iR3cNriChr8t2yO708E5NCSCEKJvaG7UDM79AgPb
	 okezEHLXfCjEYKgTsJ1q0VTCxs42nbqGO+i5+futImrzceYKerk5irbBSLHlo/fX9d
	 HOh0Ud+/zuG2dAtMKpCKniM7alzpycFde8RaMDTSd5jf3GyBCG5QFvian/++G10+2z
	 YWI+YdIRmi2p3kbfnX+QWimF3iyxU8zOfk171upYj3AQqSq9ctdLuL3ZhfGrx46WsQ
	 uGOkYLDeN7nQjoXjmKHdzAFN9oJtbqae9keNRQtvvbleXaKYhJcof1SGYIBxYv6g9l
	 h2m6Drw9qAJWw==
Subject: Re: [PATCH net 1/3] net: mvneta: lift the per-queue TX rate limits
From: netdev-bot+sashiko@kernel.org
To: pepe.schlehofer@gmail.com
Cc: netdev@vger.kernel.org, marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, w@1wt.eu, linux-kernel@vger.kernel.org
Date: Tue, 03 Nov 2026 11:29:12 +0000
Message-ID: <179370535292.488856.1180058557980364241@kernel.org>
In-Reply-To: <20261102112816.12322-2-pepe.schlehofer@gmail.com>
References: <20261102112816.12322-2-pepe.schlehofer@gmail.com>
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 2 (2) · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] At this commit, the new token-bucket reset in
  mvneta_disable_per_queue_rate_limit()…
- [Medium] Only mvneta_disable_per_queue_rate_limit() resets the buckets.
- [Low] The new 'full rate' bucket value in
  mvneta_disable_per_queue_rate_limit() is `(1 <<…

Pre-existing issues:
- [Medium] mvneta_setup_mqprio() calls
  mvneta_enable_per_queue_rate_limit() (line 5294), which switches…
- [Medium] mvneta_resume() never re-applies the TX shaper state
  programmed by mvneta_setup_mqprio(): the MVNETA_TXQ_CMD1_REG mode…

--

net: mvneta: lift the per-queue TX rate limits

This patch changes mvneta_disable_per_queue_rate_limit(). It now also
reprograms the token bucket refill register of every TX queue to one base
period and MVNETA_TXQ_BUCKET_REFILL_VALUE_MAX tokens. As a result, the
per-queue limits set by an mqprio shaper no longer stay in effect once the
shaper is turned off.

> diff --git a/drivers/net/ethernet/marvell/mvneta.c b/drivers/net/ethernet/marvell/mvneta.c
> index ea755cf05b9ef..9b9efac2846ef 100644
> --- a/drivers/net/ethernet/marvell/mvneta.c
> +++ b/drivers/net/ethernet/marvell/mvneta.c
> @@ -5204,9 +5204,16 @@ static int mvneta_enable_per_queue_rate_limit(struct mvneta_port *pp)
>  static void mvneta_disable_per_queue_rate_limit(struct mvneta_port *pp)
>  {
>  	u32 val = mvreg_read(pp, MVNETA_TXQ_CMD1_REG);
> +	int queue;
>  
>  	val |= (MVNETA_TXQ_CMD1_BW_LIM_SEL_V1 | MVNETA_TXQ_CMD1_BW_LIM_EN);
>  	mvreg_write(pp, MVNETA_TXQ_CMD1_REG, val);
> +
> +	/* The token buckets still limit the queues, refill them at full rate */
> +	val = (1 << MVNETA_TXQ_BUCKET_REFILL_PERIOD_SHIFT) |
> +	      MVNETA_TXQ_BUCKET_REFILL_VALUE_MAX;

[Severity: Low]
Is this value still full rate if MVNETA_REFILL_NUM_CLK_REG was never
programmed?

The refill period here is one base period, and MVNETA_REFILL_NUM_CLK_REG
sets the base period. Only mvneta_enable_per_queue_rate_limit() writes
that register:

	/* Set the base refill rate */
	mvreg_write(pp, MVNETA_REFILL_NUM_CLK_REG, refill_cycles);

mvneta_disable_per_queue_rate_limit() also runs on ports where the shaper
was never enabled. One example is a first "tc qdisc add ... mqprio ... hw 1"
with no shaper:

drivers/net/ethernet/marvell/mvneta.c:mvneta_setup_mqprio() {
	...
	if (mqprio->shaper != TC_MQPRIO_SHAPER_BW_RATE) {
		mvneta_disable_per_queue_rate_limit(pp);
		return 0;
	}
	...
}

On those ports, every bucket refill register loses its reset default. The
new value has a real ceiling that depends on the reset value of NUM_CLK.

If the 16 bit field is at 0xffff cycles with a clock of about 250 MHz, this
still allows about 2 Gbit/s. That is below line rate only on 2500Base-X. A
reset value of 0 has undefined effect. The testing in the commit message
ran after the shaper had been enabled, so NUM_CLK was already programmed
there.

For comparison, mvpp2_defaults_set() in the mvpp2 driver programs the base
period together with refill period 1 and max tokens:

	mvpp2_write(port->priv, MVPP2_TXP_SCHED_PERIOD_REG,
		    port->priv->tclk / USEC_PER_SEC);

Could the disable path program MVNETA_REFILL_NUM_CLK_REG as well, so the
result does not depend on the hardware reset value?

> +	for (queue = 0; queue < txq_number; queue++)
> +		mvreg_write(pp, MVNETA_TXQ_BUCKET_REFILL_REG(queue), val);
>  }

[Severity: Medium]
Does this reset run when an offloaded mqprio qdisc with a shaper is
deleted?

On deletion, mqprio_destroy()->mqprio_disable_offload() passes an
all-zero offload struct to the driver:

net/sched/sch_mqprio.c:mqprio_disable_offload() {
	struct tc_mqprio_qopt_offload mqprio = { { 0 } };
	...
}

qopt.hw is 0, so mvneta_setup_mqprio() returns before it reaches the
!num_tc branch that calls mvneta_disable_per_queue_rate_limit():

drivers/net/ethernet/marvell/mvneta.c:mvneta_setup_mqprio() {
	...
	if (mqprio->qopt.hw != TC_MQPRIO_HW_OFFLOAD_TCS)
		return 0;
	...
	if (!num_tc) {
		mvneta_disable_per_queue_rate_limit(pp);
		netdev_reset_tc(dev);
		return 0;
	}
	...
}

After "tc qdisc del dev X root" of an mqprio with "shaper bw_rlimit", the
TX queues seem to stay in V3 mode with the old refill values. The commit
message says:

    The per-queue rate limits set by mqprio stay in effect after the
    shaper is turned off.

At this commit, only the path that sets up mqprio again without a shaper
gets the new reset.

The next patch in the series, "net: mvneta: fix the removal of the mqprio
offload", changes the check to:

	if (num_tc && mqprio->qopt.hw != TC_MQPRIO_HW_OFFLOAD_TCS)
		return 0;

With that change, the all-zero teardown request reaches the reset. Could
the commit message mention this dependency, or could the two patches be
reordered?

[Severity: Medium]
Only the disable path resets the buckets. At this commit, can queues
outside the new TC ranges keep stale limits?

mvneta_enable_per_queue_rate_limit() does not touch the per-queue bucket
registers. The setup loop in mvneta_setup_mqprio() reprograms only the
queues inside the new offset/count ranges:

	for (tc = 0; tc < mqprio->qopt.num_tc; tc++) {
		for (txq = mqprio->qopt.offset[tc];
		     txq < mqprio->qopt.count[tc] + mqprio->qopt.offset[tc];
		     txq++) {
			...
			ret = mvneta_setup_queue_rates(pp, txq, ...);

Take shaper config A (for example queues 0-7 at 10 Mbit/s) and shaper
config B (only queue 0). mqprio has no change operation, so A has to be
deleted before B is installed. As described above, the driver ignores
that deletion, and queues 1-7 keep A's refill values.

Traffic that picks a TX queue without regard to TC is then still
throttled. Examples are XDP_TX and ndo_xdp_xmit, which use
pp->txqs[cpu % txq_number].

Once "net: mvneta: fix the removal of the mqprio offload" is applied, the
destroy of A reaches the num_tc == 0 branch and every queue is refilled at
full rate. So the issue is gone by the end of the series.

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch.
However, the new full rate reset is not used on the error paths of
mvneta_setup_mqprio(). Can a rejected shaper config leave queues
throttled?

mvneta_setup_mqprio() switches to V3 mode before all TCs are validated:

	ret = mvneta_enable_per_queue_rate_limit(pp);
	if (ret)
		return ret;

	for (tc = 0; tc < mqprio->qopt.num_tc; tc++) {
		...
			ret = mvneta_setup_queue_rates(pp, txq, ...);
			if (ret)
				return ret;

Suppose TC0 has a valid max_rate and TC1 fails in
mvneta_setup_queue_rates(). TC1 fails if min_rate is non-zero, or if
max_rate is zero, not a multiple of 10 kbit/s, or above
MVNETA_TXQ_BUCKET_REFILL_VALUE_MAX. The function then returns -EINVAL,
TC0's queues are already programmed, and nothing is rolled back.

sch_mqprio sets priv->hw_offload only when ndo_setup_tc() succeeds. So
mqprio_destroy() takes the netdev_set_num_tc(dev, 0) branch and never
calls back into the driver:

	if (priv->hw_offload && dev->netdev_ops->ndo_setup_tc)
		mqprio_disable_offload(sch);
	else
		netdev_set_num_tc(dev, 0);

The missing rollback dates back to 2551dc9e398c and is still there at the
end of the series. Now that mvneta_disable_per_queue_rate_limit() resets
the buckets, could the error paths call it?

[Severity: Medium]
This isn't a bug introduced by this patch, but does mvneta_resume()
restore the shaper registers?

Three things hold the shaper state:

- the MVNETA_TXQ_CMD1_REG mode bits
- MVNETA_REFILL_NUM_CLK_REG
- the per-queue MVNETA_TXQ_BUCKET_REFILL_REG values

They are written only by mvneta_enable_per_queue_rate_limit(),
mvneta_disable_per_queue_rate_limit() and mvneta_setup_queue_rates(). All
three are called from mvneta_setup_mqprio(). The resume path
re-initializes the port defaults and rings but calls none of them.

If the controller loses register state across suspend, the hardware
shaper goes back to reset defaults. tc would still report the mqprio
shaper configuration.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261102112816.12322-1-pepe.schlehofer%40gmail.com
