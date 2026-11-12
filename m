Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794527257;
	b=0d2PlCE31ba6gBIUmH9ZhUmFVfWP7QU1+XIo2nnv/Pozsl0TXF3T2vRK8RPHX3ImoL3p
	 IpFXUNSzQVDmyB+PRydEL4uBfEabaFFlEA73cknXxo5rK78AW8pKomCZK25BLPAjkeYZC
	 Jev8LCkQhr/C3vsMIfXbbVH+L0jHwt5WFuYe9XjQ9iwsNX/R9xETWMhHw6fOTbwc33099
	 baDAvVYZnbrLNKkVxCkFvKcuf9gI9CklhRUyYPJDEunS9RsomY9gnX/pOhOdjp5zVBGmx
	 MQLJlThCqAjLboN/02eWl3eqsjwJaELYLfJRjJHKfl+2NulATnQhmlVLN1RdetWcBCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794527257;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=ihiq+0qddYW2J+cwl+nH5pr1pmcIs2DvPvGp5YujItE=;
	b=HJUsxWScm5sEOUYP4JVVh5udNcr81oOGHbBplV/B2Z8BPsJ0wFNNezzhNFqcItr3QJ0d
	 SBqRBM367ncSmu9kklr6CQ57xlirKJwfhX7nJHNGVckEPVEFtjCIXdXTGZDizcupn1D0B
	 WtKxwBfPofZmM004a0sHU+wyu/vqH0B9PBeAXgtXkeRO09pjZw0Nequ1fOUkRB8wAwwh2
	 2rbngnNwciVh/o9jHGoInsHor4mRcu1aI4V2gjokuXuD1ODtcxrkHKJS0F28AtJXmm/LQ
	 JLQIuq3c6irV77cix2k0+hXPrxH1Qi1MJv2enDDgphp0Z6bD5rObKNyfnbb/FDkAofw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iDhs6wU2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403B4606A321;
	Thu, 12 Nov 2026 23:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iDhs6wU2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4301F000C5;
	Thu, 12 Nov 2026 23:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794527256;
	bh=ihiq+0qddYW2J+cwl+nH5pr1pmcIs2DvPvGp5YujItE=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=iDhs6wU2RWdAuAsKAj9BTZP4O9whlnUCeeRWRZ86YVknzdYZybxJjR8v9UpF2c/D/
	 4Y+cHpL2KHoA/cwnU5Z0OX/qhwqii0nLOtz+yYkn//3O8HBX8l2Su7yKg5ch/x4eEP
	 QCy7CYuXiGvYPX9SnsjhhRrP1IFO74+6y+NdspjPvEEmH6XGJbi8mrbDou0l9QCp4y
	 HPz1uIXfcPyBA0IYKVvqjXXKUz28WrZLrTXOiqQQYUiH1KfvrWkFHkiQexJf9YScXr
	 /T2lCT264WXKfhaPqu59TvvxAxXNE+pPj8wx07PH5eq+J23QR60zNM04cZFLQzdVi3
	 DHpxH85131v/Q==
Subject: Re: [PATCH net-next v4 1/3] net: ethernet: mtk_eth_soc: reset RX DMA
From: netdev-bot+sashiko@kernel.org
To: sandeeph@loljews.com
Cc: netdev@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, matthias.bgg@gmail.com,
 angelogioacchino.delregno@collabora.com, linux@armlinux.org.uk,
 mason-cw.chang@mediatek.com, frank-w@public-files.de,
 linux-mediatek@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
Date: Thu, 12 Nov 2026 23:47:35 +0000
Message-ID: <179452725530.2199510.183276812923001293@kernel.org>
In-Reply-To: <patch-6b45cf654903652eb4ed98e2e7514f5c@loljews.com>
References: <patch-6b45cf654903652eb4ed98e2e7514f5c@loljews.com>
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

- [Low] The commit message does not accurately describe the change.

--

net: ethernet: mtk_eth_soc: reset RX DMA

This patch moves the DMA_MAPPING_ERROR initialisation of dma_addr in
mtk_poll_rx() to the top of the RX loop, so it is reset on every
iteration. On MTK_36BIT_DMA SoCs, a descriptor that is released through
release_desc without a new mapping then keeps its own high address bits
in rxd2.

> net: ethernet: mtk_eth_soc: reset RX DMA
>
> [ ... ]
>
> With MTK_36BIT_DMA and DRAM above 4 GiB the hardware then DMAs the next
> frame to an address that is neither buffer, and the driver passes the
> stale contents of the untouched buffer up the stack.

[Severity: Low]
This isn't a bug, but could the subject line be more specific?

The patch only resets the local dma_addr variable at the top of each
iteration of the loop in mtk_poll_rx(). No RX DMA engine is reset.

In this driver, "reset" usually refers to the hardware/SER reset code
(MTK_RESETTING, mtk_hw_reset(), reset.monitor_work). Someone reading the
shortlog, or a stable backporter, could take this for a change to the
reset path.

Should the body also say that this completes commit 6e0490fc36cd ("net:
ethernet: mtk_eth_soc: fix SER panic with 4GB+ RAM")?

That commit added this check at release_desc in mtk_poll_rx():

		if (MTK_HAS_CAPS(eth->soc->caps, MTK_36BIT_DMA)) {
			if (unlikely(dma_addr == DMA_MAPPING_ERROR))
				addr64 = FIELD_GET(RX_DMA_ADDR64_MASK,
						   rxd->rxd2);
			else
				addr64 = RX_DMA_PREP_ADDR64(dma_addr);
		}

The check only works if dma_addr is DMA_MAPPING_ERROR on every release
path. Since commit e10a35abb3da ("net: ethernet: mtk_eth_soc: fix
uninitialized variable"), dma_addr is set only once, before the loop. So
the MTK_RESETTING path that 6e0490fc36cd was fixing can still pick up the
high bits of a buffer mapped for an earlier descriptor in the same poll.

mtk_rx_clean() then unmaps an address built from mismatched high and low
bits:

			if (MTK_HAS_CAPS(eth->soc->caps, MTK_36BIT_DMA))
				addr64 = RX_DMA_GET_ADDR64(rxd->rxd2);

			dma_unmap_single(eth->dma_dev, ((u64)rxd->rxd1 | addr64),
					 ring->buf_size, DMA_FROM_DEVICE);

This is the SER panic described in 6e0490fc36cd. The body covers the
misdirected DMA and the stale data passed up the stack, but not this
unmap during SER.

Would it make sense to mention it and reference 6e0490fc36cd in the
commit message?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/patch-fc08a7ef40667bf3017366e452e6d3c0%40loljews.com
