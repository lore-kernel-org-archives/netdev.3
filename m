Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9110B202F70;
	Thu, 10 Sep 2026 05:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789017875; cv=none; b=P5qxw17TsvWqFfCfclMoIn9qSl8x4QH1yXLCG56ayEFhbN/ZBCk4qDTYihEXykRTcA8sHPdlQAShTe9vtZYwNchhekZCQ0pKP4uH89NsAQmK48XbOZc360IyTpxhcisUffHYGjBhgyj9QhIaE4bx09c1LHchE2H7grGP4sdSI6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789017875; c=relaxed/simple;
	bh=Z8h+pGouIufseFE4o33WSUBphKVOavnRzai/hq1E2rA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=J2S7j2OU3FUeu/jhzxlp2620W4mj23YAKeM39btkbZfCJeveuTX2gtjhIPYA/zuEhHHX8WI7FA4iYGne5HWG6rOqIyhkzpCZhIf+zeNN1CJYwcIZRY49gO+p/JwmF+J6gSGmqhUxbwMDRixhMBIfnODUBCesO0pNlCHI2+3Ql+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OywiKZtQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OywiKZtQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9847F1F00893;
	Thu, 10 Sep 2026 05:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789017874;
	bh=PEC6nt3vrsRKDroa5BH8c3PyJBsiu7afAiaLn+a4ork=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=OywiKZtQhA1ucXk0nlPEYGcui0A5w6vks8qaYrmsZQDyqHnDgn1rvD0ivb9bdqKWi
	 aimNMcgjsw6UDGABHBI8BaoOwyfbqdUbEYqV+fu05QV7IIPHKtgNXP7t7hxYtXiob+
	 Ep2OKXtULqUdGtVViITSffLDXKZcQ/wNAhSgZCUQuUlGsPCFVgRCuPY6y4oymp0DJC
	 nBUjAcljHtzQqUN0hcuWiLgrvZmUJq8Xp8bqZPYJUTGUKQHJn3dJyWHvdd6uLKcsVp
	 mkQYhlM7YMf15126ZskGT8aiKSE/Bb/y2EQWBKMHksY4JlbD3kmV42G0GGKdJxmurH
	 xeu0SSW/Noyug==
Subject:
 Re: [PATCH net-next v6 3/3] net: xilinx: axienet: Fix IRQ error handling
From: netdev-bot+sashiko@kernel.org
To: phucduc.bui@gmail.com
Cc: radhey.shyam.pandey@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com,
 horms@kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Thu, 10 Sep 2026 05:24:33 +0000
Message-ID: <178901787314.219967.14642070814356568514@kernel.org>
In-Reply-To: <20260909045450.16176-4-phucduc.bui@gmail.com>
References: <20260909045450.16176-4-phucduc.bui@gmail.com>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 (2) · Low: 0

- [Medium] Understated impact / missing Fixes: tag.

Pre-existing issues:
- [Medium] DT binding and driver disagree on the ethernet-node
  `interrupts` list.
- [Medium] IRQ mapping leaked on probe error paths.

--

net: xilinx: axienet: Fix IRQ error handling

The probe path in axienet_probe() gets its DMA interrupts either from
irq_of_parse_and_map(), which returns 0 on failure, or from
platform_get_irq(), which returns a negative errno. The patch splits the
old combined "<= 0" test so that a zero mapping returns -EINVAL and a
negative platform_get_irq() result is propagated unchanged.

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
> +		if (lp->rx_irq < 0)
> +			return lp->rx_irq;
> +		if (lp->tx_irq < 0)
> +			return lp->tx_irq;

[Severity: Medium]
Is the commit message understating what these two new checks change?

In the branch without "axistream-connected", the interrupts come from:

	lp->rx_irq = platform_get_irq(pdev, 1);
	lp->tx_irq = platform_get_irq(pdev, 0);

and platform_get_irq() -> platform_get_irq_optional() -> __platform_get_irq()
-> of_irq_get() returns -EPROBE_DEFER when irq_find_host() finds no domain
for the parsed interrupt parent. The code being removed turned that into
-ENOMEM:

	if (lp->rx_irq <= 0 || lp->tx_irq <= 0) {
		dev_err(&pdev->dev, "could not determine irqs\n");
		return -ENOMEM;
	}

The driver core does not retry probing on -ENOMEM, so an axienet instance
whose interrupt controller is registered after the ethernet device never
appears at all. With the new "lp->rx_irq < 0" / "lp->tx_irq < 0" returns,
the deferred probe request reaches the driver core again.

The commit message describes this only as "propagate the original error code
returned by platform_get_irq() instead of returning -ENOMEM", and the
changelog says "Drop the Fixes: tag as this patch is intended for net-next".
Could the message mention the restored deferred probe behaviour, and would a
Fixes: tag be appropriate given that behaviour change?

[Severity: Medium]
This isn't a bug introduced by this patch, but the block being reworked here
enforces an interrupt ordering that disagrees with the binding.

Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml documents:

  interrupts:
    items:
      - description: Ethernet core interrupt
      - description: Tx DMA interrupt
      - description: Rx DMA interrupt
    ...
    minItems: 1

while the no-"axistream-connected" branch of axienet_probe() reads:

	lp->rx_irq = platform_get_irq(pdev, 1);
	lp->tx_irq = platform_get_irq(pdev, 0);
	lp->eth_irq = platform_get_irq_optional(pdev, 2);

that is, index 0 as Tx DMA, index 1 as Rx DMA and index 2 as the Ethernet
core interrupt.

For a device tree written to the documented order, does this put the Ethernet
core interrupt into tx_irq and the Tx DMA interrupt into rx_irq while probe
still succeeds? And does a binding-legal single-entry interrupts list get
rejected by exactly this block, now with -EINVAL or a propagated
platform_get_irq() error?

Which of the two is correct, the binding or the driver?

>  		if (lp->eth_irq < 0 && lp->eth_irq != -ENXIO)
>  			return lp->eth_irq;
>  

[Severity: Medium]
This is a pre-existing issue, but does this error path leak the virq mapping
created by irq_of_parse_and_map()?

The "axistream-connected" branch does:

	lp->rx_irq = irq_of_parse_and_map(np, 1);
	lp->tx_irq = irq_of_parse_and_map(np, 0);

and irq_dispose_mapping() does not appear anywhere in
drivers/net/ethernet/xilinx/xilinx_axienet_main.c, including in
axienet_remove().

So if rx_irq maps successfully and tx_irq comes back as 0, the new

	if (!lp->rx_irq || !lp->tx_irq) {
		dev_err(&pdev->dev, "could not determine irqs\n");
		return -EINVAL;
	}

returns with the rx_irq mapping still in place. The same applies to the later
returns in this branch, for example the platform_get_irq_optional() error, the
__axienet_device_reset() failure and dma_set_mask_and_coherent(). The old
-ENOMEM return had the same problem, so this isn't a new leak, but should the
mapping be disposed on these paths?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260909045450.16176-1-phucduc.bui%40gmail.com
