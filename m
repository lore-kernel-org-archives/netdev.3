Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BDD3AFCE3;
	Mon,  7 Sep 2026 19:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788809658; cv=none; b=XxHDVDi5OVAQyOegKS0CGfbcCoGlWgxRTcCi60JY6q9tr+x4PVD6IIuyhTwC32hHwEIYWWjRRAOiYX4bzDmx236aGus24lhhOV8kHBq4jW9eCG/JBjh5p9UBquwZKvGz+GLIY8oG9JGJoI6/4K5W4TGv0OV2pn3FPRsIpK/l9Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788809658; c=relaxed/simple;
	bh=qp2/ZqZJ8EsG2Oh13hLMzL0XOOZAnkxrvumQSBMH1bY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dAyqPbMlkKd1b+Q40T0SrosJDUzSDcqQsQ7NHX0g1tst303LkUEvLmrsgLqi7YORf9XH09PJgpXJUT4Ew3Wy48L9HUeNS7S2YkiGHaVJIAFGfSQcsdG+qsgK7CglkoOsMcsKKJkw96rDumiEfZ5Ak1uVzL9c7D2Vg1vGNNrCEno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o3IT22Gs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o3IT22Gs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59DD1F00A3D;
	Mon,  7 Sep 2026 19:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788809656;
	bh=r92QJnEK1Mm6AeF5NI2zhBEQ+pWTenUKONO/hQTom24=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=o3IT22GsD/B/QO6WNgY5PQIJ76IODUIckqWiQ+Hw3qQ2Q7opXkBr9CefeZJwgLrax
	 n568KOyUbUgX3kDMuRavlwXNvF7uRsqxwqU5IccTl6YBlLsyiFnqP4iKqJBq6+8PWJ
	 rbk7wzMVsZvIn0foCDyiUxoRnDt+Q9e5SaD1ygSHVq8NJnk72HgXC+KctyLnhEENj/
	 q8lcbrxxvmNMyhX0R9/t4nG4Lz+WFfMsYupa1yphMTF1ogBenckleqsBTBNOUo4xdT
	 upJVfxkykf2DP2vpxc/qMYuAQQ4+BJlERJTwZW4NKjTPdMDf7MqPSItUQXP7stUinq
	 zSJafXEEDtPSA==
Subject:
 Re: [PATCH net-next v5 3/3] net: xilinx: axienet: Fix IRQ error handling
From: netdev-bot+sashiko@kernel.org
To: phucduc.bui@gmail.com
Cc: radhey.shyam.pandey@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com,
 horms@kernel.org, andre.przywara@arm.com, hancock@sedsystems.ca,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Mon, 07 Sep 2026 19:34:15 +0000
Message-ID: <178880965548.219967.14368880612178322930@kernel.org>
In-Reply-To: <20260903073252.339250-4-phucduc.bui@gmail.com>
References: <20260903073252.339250-4-phucduc.bui@gmail.com>
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
issue(s) to consider:

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0

- [High] Incomplete fix: the axistream-connected branch of
  axienet_probe() still cannot request a probe retry, and this patch now…

Pre-existing issues:
- [Medium] DT binding and driver disagree on interrupt index ordering.

--

net: xilinx: axienet: Fix IRQ error handling

This changes the DMA IRQ validation in axienet_probe() so that a zero
result from irq_of_parse_and_map() returns -EINVAL instead of -ENOMEM,
and adds explicit propagation of negative error codes coming from
platform_get_irq().

> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 3927ababf833..782f903d318f 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -2971,10 +2971,14 @@ static int axienet_probe(struct platform_device *pdev)
>  			dev_err(&pdev->dev, "could not map DMA regs\n");
>  			return PTR_ERR(lp->dma_regs);
>  		}
> -		if (lp->rx_irq <= 0 || lp->tx_irq <= 0) {
> +		if (!lp->rx_irq || !lp->tx_irq) {
>  			dev_err(&pdev->dev, "could not determine irqs\n");
> -			return -ENOMEM;
> +			return -EINVAL;
>  		}

[Severity: High]
Does turning the zero case into a permanent -EINVAL remove the chance of a
probe retry for the axistream-connected branch?

In that branch the IRQs come from:

		lp->rx_irq = irq_of_parse_and_map(np, 1);
		lp->tx_irq = irq_of_parse_and_map(np, 0);

irq_of_parse_and_map() folds every failure into 0, including the case where
the interrupt provider's IRQ domain is not registered yet:

drivers/of/irq.c:irq_of_parse_and_map() {
	if (of_irq_parse_one(dev, index, &oirq))
		return 0;

	return irq_create_of_mapping(&oirq);
}

irq_create_of_mapping() also returns 0 when no domain is found, so
"not ready yet" and "malformed DT" are indistinguishable here, and
axienet_probe() now converts both into a terminal -EINVAL with no
-EPROBE_DEFER path.

Would of_irq_get(np, index) be a better fit? It is documented to return
-EPROBE_DEFER if the IRQ domain is not yet created, and 0 only when the
interrupt is genuinely absent, which would let a single pair of checks

		if (irq < 0)
			return irq;
		if (!irq)
			return -EINVAL;

cover both the axistream and the platform_get_irq() branches.

Could the commit message also mention that the deferral case stays
unhandled with irq_of_parse_and_map(), or use of_irq_get() so that it is?

> +		if (lp->rx_irq < 0)
> +			return lp->rx_irq;
> +		if (lp->tx_irq < 0)
> +			return lp->tx_irq;

Are these two checks reachable for the axistream-connected branch?
irq_of_parse_and_map() returns an unsigned int virq, so they only ever fire
for the values obtained from platform_get_irq(), which makes the added
error handling asymmetric between the two IRQ sources.

>  		if (lp->eth_irq < 0 && lp->eth_irq != -ENXIO)
>  			return lp->eth_irq;
>

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch, but since
the patch hardens validation on exactly this branch, it may be worth
reconciling: the driver and the binding disagree on the interrupt index
order.

The direct-resource branch of axienet_probe() reads:

		lp->rx_irq = platform_get_irq(pdev, 1);
		lp->tx_irq = platform_get_irq(pdev, 0);
		lp->eth_irq = platform_get_irq_optional(pdev, 2);

Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml describes the
opposite positional order:

  interrupts:
    items:
      - description: Ethernet core interrupt
      - description: Tx DMA interrupt
      - description: Rx DMA interrupt

The same probe function treats index 0 on the ethernet node as the Ethernet
core IRQ in the axistream and dmas branches:

		lp->eth_irq = platform_get_irq_optional(pdev, 0);

so index 0 has two meanings inside one function and at most one of them can
match the binding.

The binding text is also self-inconsistent: it says the Ethernet core
interrupt is optional while placing it first in a positional items list with
minItems: 1, which is only expressible when the optional entry is last, as
the driver assumes.

For a three-interrupt DT written from the documented order, all three values
are positive, so neither !lp->rx_irq || !lp->tx_irq nor the new < 0 tests
reject it, and axienet_init_legacy_dma() goes on to request_irq() the
Ethernet core line as a DMA handler. Should the binding or the driver be
corrected so the two agree?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903073252.339250-1-phucduc.bui%40gmail.com
