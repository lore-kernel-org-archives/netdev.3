Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37972531B09;
	Tue,  8 Sep 2026 11:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788867998; cv=none; b=vFKMuYp2Bcs/ocf0GCOZbpyNFrnVCKMk5xbObc2Swi03q9sF+3RikvXrKmnnG93r8p0LEzZfNMlqigKiMyjKN6PBORBBdbeIKwRrtk5zgI7USkXasK9ZOuKpSq+Jqs6EeYr3dftT0QJiD34AVCx3iOjzH1Jiz8EuZJKBveOi4AY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788867998; c=relaxed/simple;
	bh=udaUPos8qeX6niqQOjR7IRAqpmdcwnEyvXML18aAfjA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nssrIRM3RYhTDlKLnck/gi6UYNHhFSYKsJo0iU7COtwTEZdI96wvBx21jsIY0rSzEUOdTS6f2sMdF82GAQowVRZedmclt1eHhcfIasZuOiiJqwx/vA0vHd7zTKdpdzH/X4VJ64oAm9hKhnu6eoQpbueA1z+eB4zEO3+OltQ1dOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5HgeJdS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5HgeJdS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 936B21F00A3A;
	Tue,  8 Sep 2026 11:46:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788867991;
	bh=ouzEKVJXsfjO99UBVwzaAPFaYYY6ZMo1TvSb3eu46gI=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=B5HgeJdSGLv9pAPw3eCiPdkFs/5qosc8MpC4nBAMot24HG8ijoKEMuIAnGTIlUrlH
	 ORghexK5Wlm2T9vYhI34XGIg2Yq+egSGdj+06c7RDrEF9gDNuLb/715KC5wqwn38lB
	 jkUhyLf69IOnHG+qOwFa01OpI6fq0gwaoNhnS8pdbHvFmG9s4x3HZFlZliYmFEFwTP
	 zU6YV5OWdYEzDRAS3cDKCg2QVDpC9tGRM9auy+cUJ4ao3oT4PLPdtQ6/aAkL4MKbml
	 oMTG9JpW8wbwvkHHYgin9BTQgvR5vHLUWyYSEe1zDk+p1WPr1b1GEYKJyrSAFT57Tl
	 FTQzFep6N2CjQ==
Subject: Re: [PATCH net-next 12/14] net: pch_gbe: Remove obsolete 32-bit DMA
 mask fallback
From: netdev-bot+sashiko@kernel.org
To: zhouruizhe@resnics.com
Cc: michael.chan@broadcom.com, pavan.chebbi@broadcom.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 08 Sep 2026 11:46:30 +0000
Message-ID: <178886799012.219967.9931005997243012418@kernel.org>
In-Reply-To: <20260903084339.870562-13-zhouruizhe@resnics.com>
References: <20260903084339.870562-13-zhouruizhe@resnics.com>
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

- [High] pch_gbe (Intel EG20T / OKI ML7223/ML7831 GbE) is a 32-bit-DMA-
  only controller, but after this patch `pch_gbe_probe()` requests…

--

net: pch_gbe: Remove obsolete 32-bit DMA mask fallback

This removes the DMA_BIT_MASK(32) retry in pch_gbe_probe() and keeps only
the DMA_BIT_MASK(64) request, on the grounds that the DMA API guarantees
masks of 32 bits or wider and that retrying a narrower mask is incorrect.
The error check and dev_err() are retained.

> diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
> index 88c5c52e0e38..ba3d10f9aec6 100644
> --- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
> +++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
> @@ -2504,12 +2504,10 @@ static int pch_gbe_probe(struct pci_dev *pdev,
>  	if (ret)
>  		return ret;
>  
> -	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64))) {
> -		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
> -		if (ret) {
> -			dev_err(&pdev->dev, "ERR: No usable DMA configuration, aborting\n");
> -			return ret;
> -		}
> +	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
> +	if (ret) {
> +		dev_err(&pdev->dev, "ERR: No usable DMA configuration, aborting\n");
> +		return ret;
>  	}

[Severity: High]
Can this device actually address 64 bits?  After this change the 64-bit
request is the only mask pch_gbe_probe() ever installs, and the fallback
that used to leave the device with a 32-bit mask is gone.

The descriptors in pch_gbe.h only carry a 32-bit address:

	struct pch_gbe_rx_desc {
		u32 buffer_addr;
		...
	};

	struct pch_gbe_tx_desc {
		u32 buffer_addr;
		...
	};

and the ring registers in struct pch_gbe_regs are 32-bit with no
companion high-address register:

	u32 RX_DSC_BASE;
	u32 RX_DSC_SIZE;
	...
	u32 TX_DSC_BASE;

pch_gbe_configure_tx() narrows the coherent ring address into a u32 local
and programs it with one iowrite32():

	u32 tdba, tdlen, dctrl;
	...
	tdba = adapter->tx_ring->dma;
	tdlen = adapter->tx_ring->size - 0x10;
	iowrite32(tdba, &hw->reg->TX_DSC_BASE);
	iowrite32(tdlen, &hw->reg->TX_DSC_SIZE);
	iowrite32(tdba, &hw->reg->TX_DSC_SW_P);

pch_gbe_configure_rx() does the same with rdba, and the per-packet paths
store dma_addr_t straight into the u32 descriptor fields:

	pch_gbe_tx_queue():
		tx_desc->buffer_addr = (buffer_info->dma);

	pch_gbe_alloc_rx_buffers():
		rx_desc->buffer_addr = (buffer_info->dma);

There is no lower_32_bits()/upper_32_bits() handling anywhere in the
driver.  With a 64-bit mask declared, dma_alloc_coherent() and
dma_map_single() may return addresses above 4 GB, which are then silently
truncated into these u32 fields and registers.  Does that leave the MAC
bus-mastering to the truncated address, writing received frames into
unrelated memory, transmitting unrelated memory, or walking a bogus
descriptor ring, with nothing reported?

Since dma_direct_supported() accepts any mask of 32 bits or wider, the
64-bit request always succeeds under direct mapping, so this looks like
the live path rather than a theoretical one.  The driver is buildable for
MIPS_GENERIC and X86_32 (dma_addr_t is 64-bit with PAE) as well as
COMPILE_TEST:

	depends on PCI && (MIPS_GENERIC || X86_32 || COMPILE_TEST)

Would requesting DMA_BIT_MASK(32) here, i.e. the width the hardware
actually implements, be the right way to apply the cited
dma-api-howto guidance instead of keeping the 64-bit request?

One smaller point on the changelog.  It says the error check is retained
"so that a genuine DMA setup failure is still reported and aborts
initialization", but by the same premise quoted just above it ("The DMA
API guarantees support for masks of 32 bits or wider"), can that
dev_err()/return ret branch ever be taken for a mask of 32 bits or wider?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260903084339.870562-1-zhouruizhe%40resnics.com
