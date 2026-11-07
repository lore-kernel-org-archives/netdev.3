Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794015536;
	b=Uzygg90QYT6bbqh01Cg9CXRQCJdYE8NxZqrpFeBBmUMZFye9XeJT0qpSzW7VhLB+iCTS
	 mRrgrHlI/tHWcmWbIRwrWHlQgTiSptiTUxoP8cTQOjluQuGjUHDg2QiUz8Q8lDy6p7T3f
	 6BAFyjVYLUrL9AyBx/uxbBU8I4uf9tLXRIKADCqkoHa3mxS1EVGfSTAz8+S5Ml5HM67i/
	 nfqPgvveileGT8t12hwiKU6x9RPnR1XNAIToThsOlca1G7D80v4GS21VPkxrZBPbQqjHw
	 j9PlpHacKUqq/POWU6TTJfAt9HqAIFtVdwXDFl5oBuBFtpXbYgczJNnFBFDwEi1jHcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794015536;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=kRWp2TcXScmOtfr30jC2J8arJcwnqtscGONkpvfkMvk=;
	b=UlVcxx9noO/hVumMmGmzBZxvPbzsqIRXIJMpN0H2McMtXZ4vgiWUng2ZToE735gq+YUK
	 Fq/wNliZo/k3yep8zWAoAJHEd9Yhi9wSbR0WBoo4U/S/kShCxMHh3qqJAfqZi0YPbbVkj
	 1F3Y9X3Dc7HKYQtzMgGEU3mogJePIEWtE43fkKkJrFPCpzgCqqWTaIv138zYPkps044w7
	 o4JpDFwOxtS8SUOXXomRcsM5yyhs8IjlB/7cqM9NMKlMSJw8603onAOLhl1A1Ki2vcdki
	 6zB2MINXyX68W3uyo09gefJotLUahY2XmVo61iwx8wayfchPtFtK3tgN7kIANoTDPEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QehToZqy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FBB606A336;
	Sat,  7 Nov 2026 01:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QehToZqy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B79FD1F0089F;
	Sat,  7 Nov 2026 01:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794015536;
	bh=kRWp2TcXScmOtfr30jC2J8arJcwnqtscGONkpvfkMvk=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QehToZqyShJQT0UuFDLPt4nZKPmakvWETw5Y4i6fyLnjjF0ZM4UdCb/BAG2vBkf4y
	 ABy2MD14IB031Bn10sL5p1idYxY2kl80PopRKf2mGYx06rfWmvBCCHonwbQr9CCRTW
	 r8wfW10UT+cED/3OuqsZ5TsP10Pk+Vn6CGWhvHfdb7PYWh1osIKuR9EY+05sNHqwry
	 fmdTcG+arcIVPzIPPNAevoIpQugTCRjp4O8Ed398vkJpi56T2IVsEiN0kY41cbHH6w
	 A6jOpOfb8AOcXZbKfO+ixNXhhsR9szxdDqot98IhgscZrI+h7AHKa5THtR9txIat9D
	 uKRZLDSqJD4Bw==
Subject:
 Re: [PATCH net v2 2/5] net: mvneta: fix the removal of the mqprio offload
From: netdev-bot+sashiko@kernel.org
To: pepe.schlehofer@gmail.com
Cc: netdev@vger.kernel.org, marcin.s.wojtas@gmail.com, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 maxime.chevallier@bootlin.com, w@1wt.eu, linux-kernel@vger.kernel.org
Date: Sat, 07 Nov 2026 01:38:55 +0000
Message-ID: <179401553526.994134.11762131963747696411@kernel.org>
In-Reply-To: <20261103125021.70845-3-pepe.schlehofer@gmail.com>
References: <20261103125021.70845-3-pepe.schlehofer@gmail.com>
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

- [Low] The commit message of "net: mvneta: fix the removal of the mqprio
  offload" leaves out several things that…

Pre-existing issues:
- [Medium] In this patch's tree, mvneta_setup_mqprio()
  (drivers/net/ethernet/marvell/mvneta.c) returns -EINVAL or ret part-…

--

net: mvneta: fix the removal of the mqprio offload

This patch moves the qopt.hw check in mvneta_setup_mqprio() so that it
only applies when num_tc is non-zero. The all-zero configuration passed
by mqprio_disable_offload() can then reach the teardown path. That path
clears the RX priority map, disables the per-queue rate limits and resets
the traffic classes.

> Tested on a Turris Omnia (Armada 385) with 10 Mbit/s limits on a
> 100 Mbit/s link. After the qdisc was deleted, only TX queues 0-3 were
> used and the link carried 19 Mbit/s. With this patch and the previous
> one, the queues above 3 are used again and the link reaches 94 Mbit/s.

[Severity: Low]
This isn't a bug, but the bug fixes section of
Documentation/process/maintainer-netdev.rst says:

  All bug fixes must state how the issue was discovered and validated,
  and how the fix was tested.

Could the commit message say how the problem was found? For example,
was it seen in real use, or found by code inspection?

The same section asks for reproduction steps to be included when they
are short (roughly 10 lines or fewer). Could the tc commands be added?
That would be adding an mqprio qdisc with hw 1, shaper bw_rlimit and
max_rate, followed by tc qdisc del.

It also asks whether the fix was tested against the reproducer and
against kernel selftests. The hardware test is described, but selftests
are not mentioned.

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
>  	if (num_tc > rxq_number)
>  		return -EINVAL;
>  

[Severity: Medium]
This is a pre-existing issue, not one introduced by this patch. While
looking at the teardown path, though: what happens to the hardware state
when mvneta_setup_mqprio() fails part-way through?

Later in the same function:

	ret = mvneta_enable_per_queue_rate_limit(pp);
	if (ret)
		return ret;

	for (tc = 0; tc < mqprio->qopt.num_tc; tc++) {
		for (txq = mqprio->qopt.offset[tc];
		     ...
			ret = mvneta_setup_queue_rates(pp, txq,
						       mqprio->min_rate[tc],
						       mqprio->max_rate[tc]);
			if (ret)
				return ret;
		}
	}

By the time these returns run, the function has already called:

  netdev_set_num_tc()
  netdev_set_tc_queue()
  mvneta_map_vlan_prio_to_rxq()
  mvneta_enable_per_queue_rate_limit()

It may also have written MVNETA_TXQ_BUCKET_REFILL_REG() for earlier
queues. The rxq >= rxq_number and txq >= txq_number checks also return
-EINVAL without undoing any of this.

On the qdisc side, mqprio_enable_offload() sets hw_offload only on
success:

	err = dev->netdev_ops->ndo_setup_tc(dev, TC_SETUP_QDISC_MQPRIO,
					    &mqprio);
	if (err)
		return err;

	priv->hw_offload = mqprio.qopt.hw;

So mqprio_destroy() takes the netdev_set_num_tc(dev, 0) branch and never
calls mqprio_disable_offload(). As a result, the num_tc == 0 teardown in
the driver never runs for a failed setup.

Take two TCs where tc1's max_rate is not a multiple of
MVNETA_TXQ_RATE_LIMIT_RESOLUTION, or where tc1 has a non-zero min_rate.
mvneta_setup_queue_rates() then fails for tc1 after tc0's queues have
already been programmed.

Would tc0's TX queues then stay rate-limited, with the VLAN priority to
RXQ map still programmed, and no mqprio qdisc attached?

This looks like it is fixed later in this series by "net: mvneta: unwind
a failed mqprio setup". That patch turns these returns into goto err. The
err label then calls mvneta_clear_rx_prio_map(),
mvneta_disable_per_queue_rate_limit() and netdev_reset_tc().

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261103125021.70845-1-pepe.schlehofer%40gmail.com
