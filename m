Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30AB022126C;
	Mon,  5 Oct 2026 07:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791185768; cv=none; b=b3oL7gbpi0AwLmURN1lugGnsbkaob7XzsHHtZfzKaAIAgHAxZZkfv0P9IlwsETIwVJmFvo9fldXWbOHhis6GfJH2ilcGx4Wrs003QPwdRoaExFXTDWEH893GwNb5p3AEOtKPY2o4T1YANKa6wB5d3My3FOjSB8E4jqO/w4YaCJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791185768; c=relaxed/simple;
	bh=5bW341mNy7bZHuN78QdT5YngIZz9P9NZihdkflMPTJY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r2nrlxIo0LVRQDYBoWKUH9h/Csq0C6Bf23W9SWWV7WzmYYK4SvPnnn4PNFjbFEVPmN2WPfmTOV78SPyGBRrIdJlgAbmom/gekvDHuOj65a1jTIpgJOYs8TWd71Qm0bS4DuBqTU5xAKxOZ3QvGo+2rBcUPlSf4hx1SL/4ajsJzps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRwYErRA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRwYErRA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1837E1F000FF;
	Mon,  5 Oct 2026 07:36:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791185766;
	bh=DtoGrpgRMqXshmIxrknP+jPu5g650gKrBo4XsnQvXUU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MRwYErRAgeuHMigjLHA1GMcVgqhLDtRGERm6P56q6H36MbH8TgOD5XKNAY4CyrBRy
	 +j483si5wU5LhkAqxKRDr7lzEjGXyI7IOYhebKogiUj8qHQtienx2nr7Qc1EumnGUl
	 BXgEXZaAgw0drRRSUe/mu4mACLlPSYknCKSxyNtoe5J3lY2oUnoyiLxfvWy/B/ymFj
	 edi6AtDWA4Hm+LV/drmAObaoTYSi3HumcG7EjAVkQT1KiQ4B2nFs85dvpoIbkZnYT5
	 nfXnwyqzBcBl4nDqJ8nKXP3y1JEa381JAUYul91l6hqzUZAj5Vdc4ECNXuIn/V1KxX
	 kuMne6ghX40Iw==
Subject: Re: [PATCH net-next v15 2/5] net: rnpgbe: Add basic TX packet
 transmission support
From: netdev-bot+sashiko@kernel.org
To: dong100@mucse.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
 u.kleine-koenig@baylibre.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, yaojun@mucse.com
Date: Mon, 05 Oct 2026 07:36:05 +0000
Message-ID: <179118576556.434549.14822449779690822259@kernel.org>
In-Reply-To: <6D27C9B66CC66B49+20261004065907.225043-1-dong100@mucse.com>
References: <6D27C9B66CC66B49+20261004065907.225043-1-dong100@mucse.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] rnpgbe_probe() now calls dma_set_mask_and_coherent(&pdev->dev,
  DMA_BIT_MASK(56)) and ignores the return value.
- [Low] rnpgbe_add_adapter() calls netif_carrier_off(netdev) just before
  register_netdev().

--

net: rnpgbe: Add basic TX packet transmission support

This commit adds the TX path for the rnpgbe driver: TX descriptor and
buffer management, rnpgbe_xmit_frame_ring(), ring setup and teardown, and
TX completion handling in rnpgbe_clean_tx_irq(). It also keeps the
carrier off at registration, sets 56-bit streaming and coherent DMA masks,
and enables NETIF_F_HIGHDMA when the mask allows it.

> diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> index 6022a1a2ddf1e..265a3fcb07beb 100644
> --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c

[ ... ]

> @@ -206,6 +254,14 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
>  		goto err_clear_interrupt;
>  	}
>  
> +	netdev->features |= NETIF_F_SG;
> +	netdev->hw_features |= NETIF_F_SG;
> +	if (dma_get_mask(&pdev->dev) > DMA_BIT_MASK(32)) {
> +		netdev->features |= NETIF_F_HIGHDMA;
> +		netdev->hw_features |= NETIF_F_HIGHDMA;
> +	}
> +
> +	netif_carrier_off(netdev);
> +	err = register_netdev(netdev);

[Severity: Low]
In this commit, does anything under drivers/net/ethernet/mucse/ ever call
netif_carrier_on()?

rnpgbe_add_adapter() sets NOCARRIER before register_netdev(). With the
carrier off, dev_activate() returns early:

net/sched/sch_generic.c:dev_activate() {
    ...
	if (!netif_carrier_ok(dev))
		/* Delay activation until next carrier-on event */
		return;
    ...
}

So the normal stack never reaches the new path
rnpgbe_xmit_frame()->rnpgbe_xmit_frame_ring()->rnpgbe_tx_map(), and
rnpgbe_clean_tx_irq() never has completions to handle at this revision.

The commit message says:

    Keep carrier state off during registration so transmit remains gated
    until a valid link state is established.

This patch does not add anything that establishes link state. The later
commit "net: rnpgbe: Add link status handling support" fills the gap:
rnpgbe_link_is_up() calls netif_carrier_on(netdev) from the service task.
Before this patch every frame was dropped in ndo_start_xmit anyway, so
nothing that used to work stops working.

Could the commit message say that the carrier is only turned on by a
later patch in the series?

>  	if (err)
>  		goto err_remove_mbx;

[ ... ]

> @@ -248,12 +304,7 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (err)
>  		return err;
>  
> -	err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(56));
> -	if (err) {
> -		dev_err(&pdev->dev,
> -			"No usable DMA configuration, aborting %d\n", err);
> -		goto err_disable_dev;
> -	}
> +	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(56));

[Severity: Medium]
Should the return value of dma_set_mask_and_coherent() still be checked
here?

Before this patch, rnpgbe_probe() logged "No usable DMA configuration,
aborting" and jumped to err_disable_dev when setting the mask failed. With
this change, a failure is silently ignored:

include/linux/dma-mapping.h:dma_set_mask_and_coherent() {
	int rc = dma_set_mask(dev, mask);
	if (rc == 0)
		dma_set_coherent_mask(dev, mask);
	return rc;
}

If dma_set_mask() fails, neither mask is set. Both stay at the PCI default
and probe goes on to register the netdev. The only visible effect is that
the dma_get_mask() check in rnpgbe_add_adapter() quietly leaves out
NETIF_F_HIGHDMA, with no diagnostic for the user.

The commit message describes this hunk as "Configure streaming and
coherent DMA masks" and does not mention that the error check was
removed. The call is still unchecked at the end of the series.

>  
>  	err = pci_request_mem_regions(pdev, rnpgbe_driver_name);
>  	if (err) {

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/B438B0A83ACCA2DE%2B20261004065604.224873-1-dong100%40mucse.com
