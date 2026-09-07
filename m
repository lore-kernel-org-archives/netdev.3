Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC401AC44D;
	Mon,  7 Sep 2026 19:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788809657; cv=none; b=ZeesHjRVfK90yDaBh1LcH5vI5IBUpiYVRq1lPuD0lfRu9Wp5mivnbxijey2EYu7EgVa+DoHFrbs34f88p11Y2mwJ9EJsAh/jqqRuF7UwUJsWne7DlPM8RqXqbqpiQL+ZYd5jTAM42KUl5H6JvL2MOOH85ov01uEohKjyq4UjQYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788809657; c=relaxed/simple;
	bh=ifHUP2wJHf7ohp5BmhUS6nzJx02vrmdQeuq2TqHeZ3M=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TpqaWyyqRm8eClLvuI3xZxDlYdmFYNNgppT0J17ADzbemFdXSvIxVZ9NOTr2KKSHRAuL2q6K0OJiEXT+rPJ4nV/YLT9pKCAnAbZAcNNyHYWkukM6VcTsLkcAHRRw4fRmUdhUXT90z0mLdwUL51XI83E8iuJAyVmdsDIxDQLhlic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NzJ02Vtq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NzJ02Vtq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2961F00A3A;
	Mon,  7 Sep 2026 19:34:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788809655;
	bh=L+y4ypMnZyhvI7tTgAJr+wK56+sIjKVxaJDzyIKwc94=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NzJ02Vtq3+bEhW2qJ5ON3NadBkY+D72g4wYWGHtTEFsVoWxy1f5OLSnnoV3DiRYgz
	 /3vOCltUbU01Dx4SEegB1YoV/eu8cwpq13ovH3oG07FR8xN83+DrFOWOdrrfwybvcJ
	 HkzT+lKQ3LatWjGk17/wMDv7V3cwUMUQsyPVEuRw2y0WhZNzB/uvl5HqOLRHaBFLEY
	 8ehwWkxIZnMsiwPv6PgF47dG2nXuUzbOTZQj6EsTJsdEEe0hW92QB6EJywgUsuLToL
	 S6ft4JUUq/4U/l9PKA4ScRqwRMk0LCVPQf8wJxKJfTLUuPv/2/ZajEvXb1D0/Q7G5m
	 G6tdVQHo2HTYw==
Subject: Re: [PATCH net-next v5 2/3] net: xilinx: axienet: Handle optional IRQ
 return value correctly
From: netdev-bot+sashiko@kernel.org
To: phucduc.bui@gmail.com
Cc: radhey.shyam.pandey@amd.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com,
 horms@kernel.org, andre.przywara@arm.com, hancock@sedsystems.ca,
 netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Mon, 07 Sep 2026 19:34:14 +0000
Message-ID: <178880965410.219967.16945994924537630103@kernel.org>
In-Reply-To: <20260903073252.339250-3-phucduc.bui@gmail.com>
References: <20260903073252.339250-3-phucduc.bui@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

- [Medium] net: xilinx: axienet: Handle optional IRQ return value
  correctly — the patch carries a `Fixes: 522856cefaf0` tag and a…

Pre-existing issues:
- [Medium] DT binding vs driver interrupt indexing mismatch (pre-
  existing, not touched by this patch).

--

net: xilinx: axienet: Handle optional IRQ return value correctly

This changes the informational check on lp->eth_irq in axienet_probe()
from "<= 0" to "< 0", on the grounds that platform_get_irq_optional()
never returns 0. The patch carries a Fixes tag pointing at 522856cefaf0.

No Link: tags were present in the commit header.

> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 207aecb5f8b9..3927ababf833 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -3052,7 +3052,7 @@ static int axienet_probe(struct platform_device *pdev)
>  		ndev->ethtool_ops = &axienet_ethtool_ops;
>  	}
>  	/* Check for Ethernet core IRQ (optional) */
> -	if (lp->eth_irq <= 0)
> +	if (lp->eth_irq < 0)
>  		dev_info(&pdev->dev, "Ethernet core IRQ not defined\n");

[Severity: Medium]

Is this change a functional no-op, and if so, is the Fixes tag warranted?

The commit message itself states:

    Errors other than -ENXIO are handled before this check,
    so -ENXIO is the only error value that can reach this point.

Combined with platform_get_irq_optional() never returning 0:

drivers/base/platform.c:platform_get_irq_affinity() {
	...
out_not_found:
	ret = -ENXIO;
out:
	if (WARN(!ret, "0 is an invalid IRQ number\n"))
		return -EINVAL;
	...
}

the set of values lp->eth_irq can hold when reaching this dev_info() is
{positive IRQ number, -ENXIO}. Over that set, "<= 0" and "< 0" select
exactly the same values, so no configuration behaves differently before or
after this patch.

Would it be better to drop the Fixes tag, note that no functional change is
intended, and avoid a stable backport of a change with no observable effect?

Alternatively, writing the test as:

	if (lp->eth_irq == -ENXIO)
		dev_info(&pdev->dev, "Ethernet core IRQ not defined\n");

would state the reachable condition directly.

There is also a consistency question. Every other test of this field in
the same file still uses "> 0", for example in axienet_device_reset():

	axienet_iow(lp, XAE_IE_OFFSET, lp->eth_irq > 0 ?

and in axienet_init_legacy_dma():

	if (lp->eth_irq > 0) {
		ret = request_irq(lp->eth_irq, axienet_eth_irq, IRQF_SHARED,

If treating 0 as an undefined IRQ is the problem being addressed, why are
the sites that actually request and enable the interrupt left using the
complementary "> 0" form, making this the only "< 0" test of eth_irq?

[Severity: Medium]

This isn't a bug introduced by this patch, but while looking at where
lp->eth_irq comes from, the interrupt indexing in axienet_probe() and the
binding appear to disagree.

Documentation/devicetree/bindings/net/xlnx,axi-ethernet.yaml describes a
fixed item order:

  interrupts:
    items:
      - description: Ethernet core interrupt
      - description: Tx DMA interrupt
      - description: Rx DMA interrupt
    ...
    minItems: 1

but the branch in axienet_probe() that reads the DMA resources from the
Ethernet node uses:

			lp->rx_irq = platform_get_irq(pdev, 1);
			lp->tx_irq = platform_get_irq(pdev, 0);
			lp->eth_irq = platform_get_irq_optional(pdev, 2);

that is, index 0 = Tx DMA, 1 = Rx DMA, 2 = Ethernet core.

For a device tree written strictly to the binding in that shape, would
axienet_eth_irq() end up bound to a DMA line, and the DMA handlers to the
wrong lines?

The same pair also seems to disagree on minItems: 1, since this path
requires index 1 unconditionally:

		if (!lp->rx_irq || !lp->tx_irq) {
			dev_err(&pdev->dev, "could not determine irqs\n");
			return -EINVAL;
		}

The axistream-connected and dmas paths use platform_get_irq_optional(pdev, 0)
for the Ethernet core interrupt and match the binding, and both yaml
examples are consistent with the driver, so only the
DMA-resources-on-the-Ethernet-node shape looks affected. There is no
in-tree DTS for xlnx,axi-ethernet-* to settle which side is correct.
Should the binding or the driver indexing be corrected in a separate patch?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903073252.339250-1-phucduc.bui%40gmail.com
