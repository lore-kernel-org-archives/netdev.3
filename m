Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793121818;
	b=FmEUa3IQ9lOZ9YePzwch6NIrefyC/mN4pM7ICoYESNMdqPJC3PK44MevfWmiy4vAA2ug
	 ZVBa2nIBGlzdteRIry/ekeaDF5yWS8WzF/2mcTu3S6aQQNQkq5EpGu5i5JB/7+V775Eoo
	 ohvYt4OsPjrk9pWT+Tc7pJNAtMOlLRGPKXvb3vCsST/I/hZzRjLBLjiEmLosuUhlUF3Zz
	 FAY3jhnmvn0K8ogVIDghwxkO92BSXOq6/E41ZQMjWyUleRscCSYWOWDnrgZh1xpIWw1sJ
	 TAI9BWH3f1a+NvDnSOs8y7LcxKREAZjJqe+/J+gXCEK2PKFxse6RqptHAOn2vENfHsA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793121818;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WyzPYgnAxCaB3shhfFY4mLt9DwvzhM4MTGjsJr4EZvU=;
	b=HHNvBu2GME37MQ3CRI7Cl3ay0h5FcR8mn5OKx9GAEzSwVAh0GLHeZJttity908Td9vUM
	 wvvKtNXh3jm3dMgSpj6vlnqFiGJlfdljwSIFp+R+swip2akDPm94PW1Qq9SjeD8kbNoQy
	 LH3y4FGh9oWucFDjCfTY3TnZxTv/hfBJHegSHwo0h0HaZSz+4ZPB+bDcHWJZOCrQyKZUN
	 XO2Ru4D3wDQeerMLqPTG/9NBVEkR3LWA3VftQWxH1Si/7Bg6IdbcHQqqOOAjD5V6BSKqe
	 1raFf1RLVMs/D6vFXtsZcj+B+Eu8vj+iP8B7yHFEqwV6hhLEmvWIZ+7JUZYf1rhEO/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q5F91Y0o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D5CB606A31A;
	Tue, 27 Oct 2026 17:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Q5F91Y0o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8712E1F01825;
	Tue, 27 Oct 2026 17:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793121817;
	bh=WyzPYgnAxCaB3shhfFY4mLt9DwvzhM4MTGjsJr4EZvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q5F91Y0oVkNb/GspDlDlV+Ar/4ksZP6qBQRYBky+gjqA73IjQbIXVp8RHAyo81xbn
	 /fMhWZxkkdLFzuAe7zK2eifM5fWEMDRfyPZ8dxHwWBwEQWv4/TyAjiZu9XVO1nTVrC
	 jf7u+pxMekw/BCArHVAOHLRpbV/dEi6fYW8xSu0N+881qnI3o/hne0b7+F1icbLd2Y
	 fO3gV2voONLy3YMp79EqNsQkMS8gl0Ze+4kWZTFMZ7mibYXOtPJp4HuGQlqJRl/xCJ
	 NBAxHvU+38TyITt4l64xcFOOOBbPCWAzklOUNraJtCVmwZ+4weiTHuMEKTrLTmJtGh
	 PzTDswU+9mJ6g==
From: Simon Horman <horms@kernel.org>
To: rosenp@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	rafal@milecki.pl,
	bcm-kernel-feedback-list@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	nbd@openwrt.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v3] net: bgmac: fix TX DMA unmapping and slot cleanup
Date: Tue, 27 Oct 2026 17:22:41 +0000
Message-ID: <20261027172240.416526-2-horms@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261022215235.3692083-1-rosenp@gmail.com>
References: <20261022215235.3692083-1-rosenp@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
Full review at: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022215235.3692083-1-rosenp@gmail.com?part=1
---
net: bgmac: fix TX DMA unmapping and slot cleanup

This patch fixes the bgmac_dma_tx_add() error path so that the head and
each mapped fragment are unmapped from their own slots. It also clears
dma_addr on every slot the failed packet touched. In
bgmac_dma_tx_ring_free() it picks the unmap function from the SOF flag
of the descriptor, unmaps before freeing, and clears slot->skb and
slot->dma_addr.

> This was found through code inspection by an LLM while hitting other
> bugs on an Asus RT-N16. It did not hit these ones specifically.
>
> Fixes: 9cde94506eac ("bgmac: implement scatter/gather support")
> Signed-off-by: Rosen Penev <rosenp@gmail.com>

[Severity: Low]
This isn't a bug, but the commit message says an LLM found these
problems. Should the trailers include an Assisted-by: tag?

Documentation/process/submitting-patches.rst says:

  If you used any sort of advanced coding tool in the creation of your
  patch, you need to acknowledge that use by adding an Assisted-by tag.

Documentation/process/coding-assistants.rst gives the format as
"Assisted-by: LLM [TOOL1] [TOOL2]". Step 6 of its procedure for finding
and fixing bugs also asks for an Assisted-by tag.

> diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
> index 3e9c57196a397..d44ee8ed32459 100644
> --- a/drivers/net/ethernet/broadcom/bgmac.c
> +++ b/drivers/net/ethernet/broadcom/bgmac.c

[ ... ]

> @@ -535,17 +540,19 @@ static void bgmac_dma_tx_ring_free(struct bgmac *bgmac,
>  		unsigned int len = ctl1 & BGMAC_DESC_CTL1_LEN;
>  
>  		slot = &ring->slots[i];
> -		dev_kfree_skb(slot->skb);
>  
> -		if (!slot->dma_addr)
> -			continue;
> +		if (slot->dma_addr) {
> +			if (le32_to_cpu(dma_desc[i].ctl0) & BGMAC_DESC_CTL0_SOF)
> +				dma_unmap_single(dma_dev, slot->dma_addr,
> +						 len, DMA_TO_DEVICE);
> +			else
> +				dma_unmap_page(dma_dev, slot->dma_addr,
> +					       len, DMA_TO_DEVICE);
> +			slot->dma_addr = 0;
> +		}
>  
> -		if (slot->skb)
> -			dma_unmap_single(dma_dev, slot->dma_addr,
> -					 len, DMA_TO_DEVICE);
> -		else
> -			dma_unmap_page(dma_dev, slot->dma_addr,
> -				       len, DMA_TO_DEVICE);
> +		dev_kfree_skb(slot->skb);
> +		slot->skb = NULL;

[Severity: Low]
If a pending packet wraps around the end of the ring, is the skb still
freed before all of its slots are unmapped?

The commit message says bgmac_dma_tx_ring_free() will "unmap before
freeing". That ordering only holds within a single slot, because the
loop walks slots in physical order from 0 to BGMAC_TX_RING_SLOTS - 1.

bgmac_dma_tx_add() puts fragments in consecutive slots modulo the ring
size, and sets slot->skb only on the last one:

drivers/net/ethernet/broadcom/bgmac.c:bgmac_dma_tx_add() {
    ...
		index = (index + 1) % BGMAC_TX_RING_SLOTS;
		slot = &ring->slots[index];
    ...
	slot->skb = skb;
    ...
}

Take a scatter/gather packet whose head (SOF) is in the last slot of the
ring and whose last fragment, which owns the skb, is in slot 0. The loop
reaches i == 0 first and calls dev_kfree_skb(), which releases skb->head
and the frag pages. Only later, at i == BGMAC_TX_RING_SLOTS - 1, does it
call dma_unmap_single() on the head buffer, which is already freed.

bgmac_stop() and the suspend path call bgmac_chip_reset() before
bgmac_dma_cleanup(), and the mappings are DMA_TO_DEVICE. So this may
have no visible effect, but it still breaks the DMA API rule that a
buffer is unmapped before it is freed.

bgmac_dma_tx_free() avoids this by walking from ring->start to
ring->end. Could the same be done here? Another option is to unmap every
slot in a first pass and free the skbs in a second pass.

>  	}
>  }

[Severity: High]
This is a pre-existing issue and was not introduced by this patch. When
request_irq() fails in bgmac_open(), are the RX buffers freed while the
hardware is still running?

drivers/net/ethernet/broadcom/bgmac.c:bgmac_open() {
	bgmac_chip_reset(bgmac);

	err = bgmac_dma_init(bgmac);
	...
	bgmac_chip_init(bgmac);

	err = request_irq(bgmac->irq, bgmac_interrupt, IRQF_SHARED,
			  net_dev->name, net_dev);
	if (err < 0) {
		dev_err(bgmac->dev, "IRQ request error: %d!\n", err);
		bgmac_dma_cleanup(bgmac);
		return err;
	}
    ...
}

By the time request_irq() fails, bgmac_dma_init() has enabled the RX DMA
engine, attached a mapped page to every RX descriptor and written
RX_INDEX. bgmac_chip_init() has also unmasked device interrupts with
bgmac_chip_intrs_on() and enabled the MAC with bgmac_enable().

bgmac_dma_cleanup() then unmaps and frees every RX buffer through
bgmac_dma_rx_ring_free(), and nothing stops the engine first.

Could a frame received before the next bgmac_chip_reset() be DMA'd into
pages that are already freed? The device interrupt also stays unmasked
on an IRQF_SHARED line with no bgmac handler registered.

bgmac_stop() quiesces the hardware before cleanup:

drivers/net/ethernet/broadcom/bgmac.c:bgmac_stop() {
    ...
	bgmac_chip_intrs_off(bgmac);
	free_irq(bgmac->irq, net_dev);

	bgmac_chip_reset(bgmac);
	bgmac_dma_cleanup(bgmac);
    ...
}

Should the bgmac_open() error path also call bgmac_chip_intrs_off() and
bgmac_chip_reset() before bgmac_dma_cleanup()?
