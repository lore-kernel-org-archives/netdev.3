Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792923800;
	b=vKIC3msGtd1dTMnQnoxMVvH9frgTvVdqfx5aMGfwPvg4YD7Oi/PnEdPkMYsKLuHFiL2n
	 aXRoE97PYAXI/+DLwRF5KxYGLE0C4Qnp5ac8MCqqzmBYa7hzVNcKL9a533rtsnBoaWZ/O
	 LJ2mJntgYxDoIIT0Kgck4+Sz8auuNX66XS1n1sOc9cQWrTFCf1z1a7qZ7oGbMPQJvsyWy
	 Clk98HS6qiwthSO3v1p+wqJN3dwtjpVKCaVtouJRPR4ssz2/Bg+DqgTub9+fUAfPnD5jQ
	 EFFmWAlKfTwhdO8TJUb4zYQ80+ui0mH0kF7gUt6GGLFsDMe8lQSaZ3elMrgE8Ey0+ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792923800;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=w95aXfaTlSC/mmAOAutRA9tld83ZI3mo7QlNMfyhpMc=;
	b=sSK0co9x2AMVppx2BXo6iy4zzbTtMs51MR4P4r6x84MY8xEdk3QNe0DKErEkba+JXtmD
	 LhDjjK+ngzpQpg7ClmhlKy4XDp5vIwv2RDuPu+K0vPH7oCL3BLDxU23NMMr5LT7Spk9t2
	 3g/+FSDrUMdAyyWxIxQDnn9S64XqB2Ec5FAVRzXpknfD+w/XQSKUAEkbzFh5+yHr06He2
	 A5xhCGQ3UgwowOu8jnWm6dWawM6vp9hDNKBkDRNY0daJc+DIC5bhSu5QC58qOcjrL0qTk
	 72w7P9e1bukucBg5PESQ04XCv6MGQmiUjgTg5tGOL+Cu3/sBVwUXaRBHzqywUCU1iLg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sb0cUpY6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBB47606A31A;
	Sun, 25 Oct 2026 10:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Sb0cUpY6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76DB71F01825;
	Sun, 25 Oct 2026 10:23:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792923799;
	bh=w95aXfaTlSC/mmAOAutRA9tld83ZI3mo7QlNMfyhpMc=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Sb0cUpY6LcpSOuZbXvEXNK7UBIZkNmNbywAx/XoShzxMeBtfRspjYceKhN4KPJOEH
	 efNDba8/7rZXiAJN9u7AtwLQJu/7B0N9U3UNhlWAAYq+PECfZuyeLOub9w3XY8+0fZ
	 HLpg57JHTEw3tgugGTevK2f9RMCAjmxVcmoP01tIAZBZ27qpuUuIzmqKaouqj7a8OP
	 D2gr7T67+7j9ZiqBKXwrb5PjScTKJAEiv4yTKZcRSCO2OwZrhIfkHFoxcOhlyMcIsH
	 dEJdWFIFyMOI4TeW1vxS6f3vLmqLIrOd1aMFPnUBYwGUodFCgYgPiRzNEnP1VEIHlD
	 Ugqahkqar49UA==
Subject: Re: [PATCH net-next v3 1/2] dt-bindings: net: qcom,bam-dmux: Add
 memory-region and qcom,vmid properties
From: netdev-bot+sashiko@kernel.org
To: vishnu.santhosh@oss.qualcomm.com
Cc: stephan@gerhold.net, andrew+netdev@lunn.ch, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, edumazet@kernel.org, linux-arm-msm@vger.kernel.org,
 netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, deepak.singh@oss.qualcomm.com
Date: Sun, 25 Oct 2026 10:23:17 +0000
Message-ID: <179292379798.3134.3640182983987741764@kernel.org>
In-Reply-To:
 <20261021-qcom-bam-dmux-vmid-ext-v3-1-cedd1f681102@oss.qualcomm.com>
References:
 <20261021-qcom-bam-dmux-vmid-ext-v3-1-cedd1f681102@oss.qualcomm.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The new memory-region/qcom,vmid properties only cover the bam-
  dmux client node.
- [Low] Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml still
  says (lines 18-21): "Note that this schema does not directly describe…
- [Low] Baseline decision: false (resolved later in the series).

--

dt-bindings: net: qcom,bam-dmux: Add memory-region and qcom,vmid properties

This adds two optional properties to the qcom,bam-dmux binding,
memory-region and qcom,vmid. They confine BAM-DMUX DMA mappings to a
restricted DMA pool that is shared with the modem through SCM. It also
adds a qcom,shikra-bam-dmux compatible, with qcom,bam-dmux as fallback,
which requires both properties.

> diff --git a/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml b/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
> index 33746c238513d..f7388d24c8612 100644
> --- a/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
> +++ b/Documentation/devicetree/bindings/net/qcom,bam-dmux.yaml
> @@ -22,7 +22,11 @@ description: |
>  
>  properties:
>    compatible:
> -    const: qcom,bam-dmux
> +    oneOf:
> +      - const: qcom,bam-dmux
> +      - items:
> +          - const: qcom,shikra-bam-dmux
> +          - const: qcom,bam-dmux

[Severity: Low]
The description at the top of this binding still says:

  Note that this schema does not directly describe a hardware block but rather
  a firmware convention that combines several other hardware blocks (such as the
  DMA engine). As such it is specific to a firmware version, not a particular
  SoC or hardware version.

This patch adds the first SoC-specific compatible. Should that text be
updated too?

The commit message also doesn't explain why the no-SoC-compatible design
is being dropped. The only effect of qcom,shikra-bam-dmux is the allOf/if
block that makes memory-region and qcom,vmid required. The driver's
of_match table only lists the generic "qcom,bam-dmux".

Separately, the subject line only says "Add memory-region and qcom,vmid
properties". Could it also mention the new compatible, since that adds to
the DT ABI?

[ ... ]

> @@ -72,6 +76,22 @@ properties:
>        - const: tx
>        - const: rx
>  
> +  memory-region:
> +    maxItems: 1
> +    description:
> +      Phandle to a reserved-memory node compatible with restricted-dma-pool.
> +      The BAM-DMUX device uses the pool for DMA mappings.

[Severity: Medium]
Does a pool on the bam-dmux node cover everything the BAM accesses on
Shikra?

The pool only affects dma_map_single(dmux->dev, ...) in
bam_dmux_skb_dma_map(). The BAM descriptor FIFOs are allocated on the BAM
controller's own device in drivers/dma/qcom/bam_dma.c:

bam_alloc_chan() {
    ...
	bchan->fifo_virt = dma_alloc_wc(bdev->dev, BAM_DESC_FIFO_SIZE,
					&bchan->fifo_phys, GFP_KERNEL);
    ...
}

bam_chan_init_hw() then programs that address into the hardware:

	writel_relaxed(ALIGN(bchan->fifo_phys, sizeof(struct bam_desc_hw)),
			bam_addr(bdev, bchan->id, BAM_P_DESC_FIFO_ADDR));

The companion patch "net: wwan: qcom_bam_dmux: Assign restricted DMA pool
to remote processor" says that "BAM-DMUX DMA mappings and BAM descriptor
FIFOs must therefore be constrained to a designated memory region", and
that accesses outside that region "can trigger an XPU violation". It also
says the FIFOs are covered only "When the BAM DMA controller references
the same pool".

However, Documentation/devicetree/bindings/dma/qcom,bam-dma.yaml defines
no memory-region property and has additionalProperties: false. Nothing in
the series changes that.

So a schema-valid Shikra DT would leave the descriptor FIFOs outside the
shared pool, and a DT that works would fail dtbs_check. Should
qcom,bam-dma.yaml get a memory-region property as part of this series?

> +
> +  qcom,vmid:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    maxItems: 1
> +    items:
> +      minimum: 1
> +      maximum: 63
> +    description:
> +      VMID of the remote execution environment that is granted access to the
> +      restricted DMA pool through SCM.

[Severity: Low]
Nothing reads qcom,vmid or does the SCM assignment at this point in the
series. A Shikra DT that binds through the qcom,bam-dmux fallback would
bounce buffers into a pool the modem has not been given access to. Is
that gap between this patch and the next one acceptable?

The next patch in the series, "net: wwan: qcom_bam_dmux: Assign
restricted DMA pool to remote processor", appears to resolve it. It adds
bam_dmux_assign_dma_pool() to bam_dmux_probe(). That function reads
qcom,vmid and calls qcom_scm_assign_mem() with HLOS and the remote VMID
before the DMA channels are requested. The patch also adds
bam_dmux_reclaim_dma_pool(), which runs on remove and on probe error.

The driver matches the fallback compatible and handles the property
whenever it is present. So the fallback semantics look correct by the
end of the series, and this is noted only for completeness.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021-qcom-bam-dmux-vmid-ext-v3-0-cedd1f681102%40oss.qualcomm.com
