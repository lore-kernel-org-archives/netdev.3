Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794015535;
	b=g2ivipAdlUH3aOaVgM82stU+11JcNNIKx09nBq/ijN7FTEREmDogywRk4LGlFvr/QZ0U
	 qEng/1GTa7AKaYI3ElQd4rYN8E5XEKPjPHvh0xyPETTpk0BarVdqIAWf3Me9YZ1dLGhp9
	 uDGZIh+6Exny2zlzq+9hxUxm6tmaC/Tjs+GnsiBHWmzjE1upZxDcxaV4ltYyfsbJvnsw4
	 u/8mzDkrnwUxnU9EMYo7p271T7hT/OCnczNMN5rJYVJGY/zJGvbYPGrzvHiPTeknDIjXH
	 Iz/Bn6Bo4FolEbWXk+CaBuXrjGtXHSdgm+OZeqAgiaonouGyf24Iz1EmttOUsoeI9MA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794015535;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=k7HQpG4ipLwzF4zu1Mb4Urr7qI0fUMoVV9IxTQEATQE=;
	b=fSx2G13e+r3o/1ZzvsfQLUrIJOqifFH+p/oP8THInqLiDMJMsh9ZswAESsuNU7mQaeFx
	 EoMe7KSErui4BNpAArqveMMOhtvK4trl4vsbuEX7UwBysvxtT/5I8w/VGbYeGCeDe/FmN
	 WjVvS+V5uxV+973bv4Ig4e4lFpVppJfYRra+vMLP2mhJRhcqzoBNnZkKzat7QEICpfB48
	 gZ7N4e4pRj4x6orUA+4YNGsjLEVPAdIiwTGRXEDW75my6uh1bIpkglMCjbGOSK7BtMTry
	 wcVToMKSB5+d6uuxr9I7i6IQjDZbBUxuyt3AUIf0EtyMOoZPRLctNjbzCHSjRa2i0eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gu06lvpv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B453606A32D;
	Sat,  7 Nov 2026 01:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gu06lvpv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79D0C1F008A1;
	Sat,  7 Nov 2026 01:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794015535;
	bh=k7HQpG4ipLwzF4zu1Mb4Urr7qI0fUMoVV9IxTQEATQE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Gu06lvpvJZOdN8qUhq73xCDVnf88xx06oShtm2AgThdG1kSC09uODvo9f2evDuuVQ
	 7dGo5bzscBffZSIu+vCWPFqSj2kJEBirwfsTz43GYWgd0Rfnyq39zWRg80TN7Irqsa
	 nH77OmQduP3llkK69QasFIQW57rrFBydhZmeN5a7pOR5EOgoRhM8/Yvn6TlaIiw4+I
	 0rN+44sHbDKJ5k6Fm0Qrtewx8387Pk6fApoG0I/FrjjXx2x3/cEv4knRSfaITqqkFC
	 PKKWsB3v+qtc2599drRidRI84vI7uVfD5hjxZzfgXaGG4sV+s7aBo8OmmF9vdA43V4
	 qT+Q77fwmnnDQ==
Subject: Re: [PATCH net v2 1/5] net: mvneta: lift the per-queue TX rate limits
From: netdev-bot+sashiko@kernel.org
To: pepe.schlehofer@gmail.com
Cc: netdev@vger.kernel.org, marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, w@1wt.eu, linux-kernel@vger.kernel.org
Date: Sat, 07 Nov 2026 01:38:53 +0000
Message-ID: <179401553399.994134.12541545181842770767@kernel.org>
In-Reply-To: <20261103125021.70845-2-pepe.schlehofer@gmail.com>
References: <20261103125021.70845-2-pepe.schlehofer@gmail.com>
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

- [Medium] In drivers/net/ethernet/marvell/mvneta.c, the new code in
  mvneta_disable_per_queue_rate_limit() writes refill period 1 and…

--

net: mvneta: lift the per-queue TX rate limits

After this patch, mvneta_disable_per_queue_rate_limit() also writes refill
period 1 and the maximum refill value into the token bucket refill register
of every TX queue. Before, it only changed the mode bits in
MVNETA_TXQ_CMD1_REG. The goal is to stop the old mqprio per-queue limits
from staying in effect once the shaper is turned off.

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
> +	for (queue = 0; queue < txq_number; queue++)
> +		mvreg_write(pp, MVNETA_TXQ_BUCKET_REFILL_REG(queue), val);

[Severity: Medium]
Is "full rate" guaranteed here when MVNETA_REFILL_NUM_CLK_REG has never
been programmed?

The period field is counted in units of the base period:

/* Number of Base Period to wait between each bucket refill */
#define MVNETA_TXQ_BUCKET_REFILL_PERIOD	1000

The only place the driver writes that base period is
mvneta_enable_per_queue_rate_limit():

	/* Set the base refill rate */
	mvreg_write(pp, MVNETA_REFILL_NUM_CLK_REG, refill_cycles);

Neither mvneta_defaults_set() nor probe write it. Enable also returns
before this write if clk_get_rate() gives 0 or refill_cycles is greater
than MVNETA_REFILL_MAX_NUM_CLK.

On a fresh boot, adding an offloaded mqprio without a shaper goes
straight to the disable path, and no enable has run before it:

mvneta_setup_tc()->mvneta_setup_mqprio():

	if (mqprio->shaper != TC_MQPRIO_SHAPER_BW_RATE) {
		mvneta_disable_per_queue_rate_limit(pp);
		return 0;
	}

Before this patch, the hardware's reset-default bucket values were left
alone on this path. Now they are overwritten. The resulting rate then
depends on the unknown reset value of MVNETA_REFILL_NUM_CLK_REG and on
MVNETA_TXQ_TOKEN_SIZE_REG(q). The driver only guarantees the token size
is at least MTU * 8 bits, via mvneta_txq_max_tx_size_set().

The units of the base period register are documented for V3 mode. This
write happens right after the port is switched to V1 mode
(SEL_V1 | BW_LIM_EN). Does the period field mean the same thing there?

The test in the commit message covers the case where an earlier enable
had already set the base period to about 100 ns. Could the base period
also be programmed here? The comparable mvpp2 code writes
MVPP2_TXP_SCHED_PERIOD_REG before it sets refill period 1 and the maximum
tokens.

Later patches in the series also reach this function from qdisc deletion
and from the error unwind, and the base period is still not set there.

>  }
>  
>  static int mvneta_setup_queue_rates(struct mvneta_port *pp, int queue,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103125021.70845-1-pepe.schlehofer%40gmail.com
