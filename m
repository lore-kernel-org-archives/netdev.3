Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794183823;
	b=ZpGA+3QunBxbOoGl3E1t+DDyK0AQZcaJvlSnRIikXfpJDF4r4T4gEnJqvGv8K6bMFz4F
	 OLJeXIV9Z0Y/0Qboa/bNReiZhX6pf41J+LIm0JwXljdSzLQKQAokuimf5qb8goD75GKRj
	 k/LzADCKmOtA4k1G/2qyaWvlZQyI+RnMKKeeUYeQ3canoV2lDwCIxAt+ccPNlNR6oHLeW
	 VmHHu2yKt43jvfr+UlQ0uo9VPA1ti9VnjmKdGH8MWXGs4glvPcv0vc1qT4PxkRyCN9lsK
	 TBSeSJGOs83gfCsczsQtlPPZxRWXQz1jvnidC3qxf3UUNBft3VIiibq/GJ18f1j3xww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794183823;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=fb+OgOz+Kkm9T6KX15g4rjKPgCT3BsFEwLgAd4OsAeo=;
	b=ZKijXm8epkkfz7twKErZ1VK/Kg5VVI+CfRu/y4WVvUx33ApXicM3/bVSSgUxTCbO2n45
	 u1+QOpxzFgrRime/ZkSHSZFLJNqp1mcm3qy2yxEYX7P7wIBLrs05goFZTakSq5OwjCO9J
	 gkg6JF/O0muUYhpNHqYvGHg4w10MKh6h7XFXO5qljDLoaWRKnjCtWvii93u/RlavWICE0
	 K7PmIY0Ism/UQ4oD03MkPWKt2O3Hn9dFDF35UFnLCURC1t2GIcMUdBfsdeCoX/DkNzBg/
	 1fFArvXfuF6+QBG/ePfaWNxOPBe/I7rLcWCVP2/8giN1HN2i2DyYLw/4JoGYRSJFJOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BaCAm4OE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB87D606A31C;
	Mon,  9 Nov 2026 00:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BaCAm4OE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9721D1F0089F;
	Mon,  9 Nov 2026 00:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794183822;
	bh=fb+OgOz+Kkm9T6KX15g4rjKPgCT3BsFEwLgAd4OsAeo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=BaCAm4OEoIJaJfq1zmTvbYS4VG7xYuNkmPJqJr4Rx4S5QNMADUzRFPYMZdJ/mXBhx
	 LaCTLMrkcstEd2Xenm9kvm9jaNxQ4KH/WF1wmT3EJMRu9u99JeJk0kCd5IncQbbvo1
	 7CQbBxF9y/93SMxqtkXCrkPuW5DzkiL+9SeSk+/nyR4zqqY0RqqMl+0XGxV8TsBS21
	 NcMVDn0Jfmg4SIspNV+7cguVvO3uJ/yGzziiRp3SzTZ5V0rv8HHrZ1nGwqNCIc54qZ
	 +9hEExyhXGOBS6vWB33N+gPfb436D18EUxWUNrdxbp+SFk/l7lRVCpvlN6NAG8Y5nS
	 ZdNbC5MsLeNAQ==
Subject: Re: [PATCH net v3 1/5] net: mvneta: lift the per-queue TX rate limits
From: netdev-bot+sashiko@kernel.org
To: pepe.schlehofer@gmail.com
Cc: netdev@vger.kernel.org, marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, w@1wt.eu, linux-kernel@vger.kernel.org
Date: Mon, 09 Nov 2026 00:23:41 +0000
Message-ID: <179418382115.994134.7847184519215065308@kernel.org>
In-Reply-To: <20261104224518.66487-2-pepe.schlehofer@gmail.com>
References: <20261104224518.66487-2-pepe.schlehofer@gmail.com>
X-sashiko-severity: Low
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

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] In drivers/net/ethernet/marvell/mvneta.c,
  mvneta_disable_per_queue_rate_limit() now writes every…

--

net: mvneta: lift the per-queue TX rate limits

When the per-queue TX rate limit is disabled, this commit sets the token
bucket refill registers of all TX queues to full rate. Without it, the
limits set by an earlier mqprio shaper stayed in effect after the shaper
was turned off.

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

[Severity: Low]
Does "full rate" here depend on MVNETA_REFILL_NUM_CLK_REG having been
programmed first?

A period of 1 means one base refill period. The length of that period
comes from MVNETA_REFILL_NUM_CLK_REG. As far as I can see, the only write
to that register in the driver is in mvneta_enable_per_queue_rate_limit():

	/* Set the base refill rate */
	mvreg_write(pp, MVNETA_REFILL_NUM_CLK_REG, refill_cycles);

mvneta_setup_mqprio() can reach the disable path without the enable path
ever having run:

	if (!num_tc) {
		mvneta_disable_per_queue_rate_limit(pp);
		...

	if (mqprio->shaper != TC_MQPRIO_SHAPER_BW_RATE) {
		mvneta_disable_per_queue_rate_limit(pp);
		return 0;
	}

One example is the first offloaded mqprio after boot with no bw_rlimit
shaper, such as one that only maps VLAN priorities to RX queues. Later
in the series, deleting such an offload, or a setup that fails before
mvneta_enable_per_queue_rate_limit() runs, also takes this path.

In those cases the per-queue refill registers are overwritten while
MVNETA_REFILL_NUM_CLK_REG still holds its hardware reset value. Before
this patch they kept their defaults on a port where the shaper was never
enabled.

If the reset period is long, could this cap the TX queues below line
rate? For example, with NUM_CLK at 0xffff cycles, MAX tokens per period
works out to roughly 2 Gbit/s, which is below a 2.5G port's rate.

This depends on the reset value of MVNETA_REFILL_NUM_CLK_REG, which
can't be checked from the code. Period 1 with the maximum value is the
fastest setting the register can encode, so this may never be visible in
practice.

Would it make sense to also program MVNETA_REFILL_NUM_CLK_REG on the
disable path, so the "full rate" setting doesn't depend on the enable
path having run first?

>  }
>  
>  static int mvneta_setup_queue_rates(struct mvneta_port *pp, int queue,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261104224518.66487-1-pepe.schlehofer%40gmail.com
