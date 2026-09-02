Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EA947F79B
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 15:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788362974; cv=none; b=qX5TOlM1wgph6OK1icYXVByd1H8AIKbu0Mf2drOxclX1tFXoT6/DJk4Z2w4QQcaRJqdPXgckqrmP8640qLiNigMfKF1tZbl+66QJeVjGCTXIkbrAKwJC34LZm/hhPw3xI6gnMVryNcTe2eq5pDqCeMvdpRqJM7jgTLrNs7SmpOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788362974; c=relaxed/simple;
	bh=bijU2jnkO+Iz4jiHhEnFrtC9/YwzwRE2+3H5/R9wvus=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UWq2QxfltOGwlWWVUxHJ6kILYLrNYykt66IHFZBCTyeiYds2+0wJkHDQ0pONaYVzVh+6uwJHt617wODy1WhhkoFK04z/d1/3Zea7IEvry1qJx8W7cW8RKWDV2sdtB0O8PaErQapb8u1wL2DNUtWPaP9WMP51ZeUOGJPEL0FGjSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bUGCUKKR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bUGCUKKR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129811F000E9;
	Wed,  2 Sep 2026 15:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788362972;
	bh=Ff2cdz7fwsnmaf5KnGrXuakUCkPe3sYFjYXAWGmfpeY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bUGCUKKRkcJPHetPZa+L66yEfGL+46CFIZch73+KGdZyPDdx1xKywZq6tZ0Gq/hFW
	 QAJcuIzfVEhC00eV2rvSi0af3CnILBoVyBFD9KARRZ0zl/09LEEh8LYRpBvStE+XVO
	 PSCfX4TKTrnKhvICHIelEYE4e4V6b35GX7/rc3Qf8/0BDuziJfQu7GgshkuS+bc5DD
	 pbJYzjeZPqy3AHvRzDf9Q14/NFBimzmgCTBY7g6uLdii87SU6lno/phIvUgi59qATa
	 NhYbAGbTwVYhb+n0WPL+cwXUmnBO7w4yW9LFv1kr3ydGYeMyXRnpUQG2cJ8ghIGGP6
	 vMaOOOshw8M8g==
Subject: Re: [net] net: airoha: enable RX_DONE interrupt for RX queue 31
From: netdev-bot+sashiko@kernel.org
To: lorenzo@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
Date: Wed, 02 Sep 2026 15:29:31 +0000
Message-ID: <178836297161.3394541.17329602881799623239@kernel.org>
In-Reply-To: <20260830-airoha-rxdone-rxq31-v1-1-830a91503f2f@kernel.org>
References: <20260830-airoha-rxdone-rxq31-v1-1-830a91503f2f@kernel.org>
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

Critical: 0 · High: 1 · Medium: 0 · Low: 0

- [High] Incomplete fix: the patch only adds BIT(31) to
  RX_IRQ1_BANK_PIN_MASK, so the exact defect the commit message…

--

net: airoha: enable RX_DONE interrupt for RX queue 31

This adds BIT(31) to RX_IRQ1_BANK_PIN_MASK so that RX queue 31's RX_DONE
interrupt is routed to IRQ bank 1.  The stated goal is that the queue gets
drained and its buffers returned to the page pool.

> diff --git a/drivers/net/ethernet/airoha/airoha_eth.h b/drivers/net/ethernet/airoha/airoha_eth.h
> index fa9a8edce22f..8277c1c87bb3 100644
> --- a/drivers/net/ethernet/airoha/airoha_eth.h
> +++ b/drivers/net/ethernet/airoha/airoha_eth.h
> @@ -538,7 +538,7 @@ struct airoha_wdma_info {
>  
>  /* RX queue to IRQ mapping: BIT(q) in IRQ(n) */
>  #define RX_IRQ0_BANK_PIN_MASK			0x839f
> -#define RX_IRQ1_BANK_PIN_MASK			0x7fe00000
> +#define RX_IRQ1_BANK_PIN_MASK			0xffe00000
>  #define RX_IRQ2_BANK_PIN_MASK			0x20
>  #define RX_IRQ3_BANK_PIN_MASK			0x40

[Severity: High]
Does this leave the same problem in place for the other RX rings?  After the
change the union of the four bank masks is:

  0x839f | 0xffe00000 | 0x20 | 0x40 = 0xffe083ff

so rings 0-9, 15 and 21-31 are covered, but bits 10-14 and 16-20 are still
clear in every bank mask.

Those rings are still allocated and filled, because airoha_qdma_init_rx() in
drivers/net/ethernet/airoha/airoha_eth.c gates only on RX_DONE_INT_MASK:

	if (!(RX_DONE_INT_MASK & BIT(i))) {
		/* rx-queue not binded to irq */
		continue;
	}

	err = airoha_qdma_init_rx_queue(&qdma->q_rx[i], qdma,
					RX_DSCP_NUM(i));

and in drivers/net/ethernet/airoha/airoha_regs.h RX_DONE_INT_MASK expands to
0xffffffff:

	#define RX_DONE_HIGH_OFFSET	fls(RX_DONE_HIGH_INT_MASK)
	#define RX_DONE_INT_MASK	\
		((RX_DONE_HIGH_INT_MASK << RX_DONE_HIGH_OFFSET) | RX_DONE_LOW_INT_MASK)

with RX_DONE_HIGH_INT_MASK and RX_DONE_LOW_INT_MASK both 0xffff.  So the
"rx-queue not binded to irq" comment filters nothing and all 32 rings get
programmed into hardware and filled from the page pool.

Meanwhile airoha_qdma_hw_init() only unmasks RX_DONE according to the pin
masks:

	airoha_qdma_irq_enable(&qdma->irq_banks[i], QDMA_INT_REG_IDX1,
			       INT_RX1_MASK(RX_IRQ_BANK_PIN_MASK(i)));
	airoha_qdma_irq_enable(&qdma->irq_banks[i], QDMA_INT_REG_IDX2,
			       INT_RX2_MASK(RX_IRQ_BANK_PIN_MASK(i)));

and airoha_qdma_rx_napi_poll() re-arms through the same mask:

	for (i = 0; i < ARRAY_SIZE(qdma->irq_banks); i++) {
		if (!(BIT(qid) & RX_IRQ_BANK_PIN_MASK(i)))
			continue;

Since rx_intr_mask in airoha_irq_handler() comes from the per-bank irqmask,
rings 10-14 and 16-20 are never passed to napi_schedule(), so
airoha_qdma_rx_process() never runs for them and their buffers stay pinned
from probe until airoha_qdma_cleanup_rx_queue().  Is that not exactly the
behaviour the commit message describes as a bug for ring 31?

Ring 11 stands out here, since RX_DSCP_NUM() gives it 128 descriptors, the
same as rings 2 and 15 which are mapped to bank 0:

	#define RX_DSCP_NUM(_n)			\
		((_n) ==  2 ? 128 :		\
		 (_n) == 11 ? 128 :		\
		 (_n) == 15 ? 128 :		\
		 (_n) ==  0 ? 1024 : 16)

while BIT(11) is absent from all pin masks, and the ring this patch enables
(31) uses the default 16 descriptors.

Would it make sense to give airoha_qdma_init_rx() and the pin masks a single
source of truth, either by having the masks cover every ring init_rx arms, or
by having init_rx key off RX_IRQ_BANK_PIN_MASK()?

Alternatively, if the sparse mapping is deliberate and those rings are simply
unused by the hardware configuration, does the justification given for
BIT(31) still hold?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260830-airoha-rxdone-rxq31-v1-1-830a91503f2f%40kernel.org
