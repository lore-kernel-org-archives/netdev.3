Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750C83812FB;
	Mon,  5 Oct 2026 07:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791187069; cv=none; b=pCalL/qzZSQi78PvppDnEBWzMBkC+HCTqkpVEUS9uqQA59QMuAbFvv+fFkws8LBsjrV4NWG/8K+cqMl0I5mPvLzWL29GIy4QytFOraQIk9yTsd6F5D5nocz5JONuJzzgwrqg2IQwG0nx22O2r+mPKGrFdrLc/Si0yF/hPomt6lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791187069; c=relaxed/simple;
	bh=Gc3+6O7CPkZerct4WY/uQD/0qWp1zjVUvtcJtvPmgiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RJVFlLwdEsGFgRjIeVzD86fhIc0zA61oong9tiMD91Z9CCuaVR+VZ3p++OqaCPzy/i/hjPqeAmAlScSQvBz/R+hwHaOZNXwQwEW7gqVIIul0vwsx57akO+xeg+peG8Yxa75DSrF4TJze2aTrLeHvowvz3Rhgrp+dWFTmKYTflo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com; spf=pass smtp.mailfrom=mucse.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpsz11t1791186966tb9e098e3
X-QQ-Originating-IP: MOSCcuIsKn5rVUMGikr2b+wyuWMtjx19XS6RF+oU/fE=
Received: from localhost ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 05 Oct 2026 15:56:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5788011073947090870
EX-QQ-RecipientCnt: 11
Date: Mon, 5 Oct 2026 15:56:04 +0800
From: Yibo Dong <dong100@mucse.com>
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, vadim.fedorenko@linux.dev,
	u.kleine-koenig@baylibre.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yaojun@mucse.com
Subject: Re: [PATCH net-next v15 2/5] net: rnpgbe: Add basic TX packet
 transmission support
Message-ID: <A2F6060F00810557+20261005075604.GA249181@nic-Precision-5820-Tower>
References: <6D27C9B66CC66B49+20261004065907.225043-1-dong100@mucse.com>
 <179118576556.434549.14822449779690822259@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179118576556.434549.14822449779690822259@kernel.org>
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: Mfp0Jgl+fd1fDAw2tzHOuYgife/h9IBmumdPEyhR63vCMlL5jyOxKJ+z
	gPaK4DCxMEa/b6kZmgo/bOwOnTvotuZAZ96EfVeZrFL2DiodxudivbuzBPkNpCGig3Weo7v
	JCckxsEcszrik6/YBN2SZilvPHJca6JYv2Y4H2luGVtA8MDEfVfs5fL9WBOi61poeD+lcJR
	Zz8JUBBNPr0Bs539TI1s0Rwp+icdYu09q4G73z0t9k3xOtHH8DcekhkpZEwi92QmBU7EBUf
	y+884UvsL0+O9wyCUR8Pe8vWxfUFTN2d3RXk2N6AsjUJFeL/eZJurb0zxmwJsGmFCAsNm8e
	MkLTmhfzQTJwlsV772kCP6WM6MygdhwB9GxKvOECHL/HIRvhthrtG2+wYqC8aSJyvr829qU
	C4uiPIUJK6CdNNLbtAN2N20pzOl/gkqIXfxkifBffMWgplzxBVy2eDQVtrBD5y4e5VDmEzX
	raLpKbzbAgij5+PqVPQZYKDlNb/v+m4J4xcdQR2IOPDNE3m3wHl2hy1ktC2aVFPB+MZRK+c
	aXdVompja9XczzFgjwrC0fzCiY8p8zROcrRMTy+xRfLe1urz5T8k527zth+nAye/sEaGPlN
	87NlNx9kOdYjVMstEkxmNPwpzta45okzALVoGI5vOIjeHMF0OFDarU8jWW+eqUdDJE5vVhr
	GNUGPxIXq41hym8TCglIoLoKw8WV+Jqf05uQ7oc6ZDBVecvPhN57GMHUUMe6tDZb2P9OW8m
	2/vVaQNbVgSe+d639esg6sr3xgRS9t9nHjsLfHCI7ygCPPKFomMcT1avdka04GQaZBaIeAz
	LwNIfDv+NJTtMER6I8K3boQvPLgivm/gVjxMe7FN4IzIxJoy6uUAfJajUJoaVfzIW/m1FkC
	EBRH4QH3+/jz/9btiFabfzhfzOLJOzzHdd/EDTh13e89jMsF/kf+gtNgjgk/3wN+wUv9dfZ
	NqPBU5xL6CuVzTRaBLGYY7NNXQvNpJVQnGOFtYRB5+M948wUXE/p/xPNSAy9x04n0CrkcX2
	gguiFOjrfLzTYYN7u7ugzvOCmt0/fynZtLGmfhGSTD91Wgi80mueBP6hsMx94SrI+utymXz
	ynYFTdcQNeD8hvJo+nqZeb7dj3Oo5sPe6l6OSqjW/zJ
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

On Mon, Oct 05, 2026 at 07:36:05AM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] rnpgbe_probe() now calls dma_set_mask_and_coherent(&pdev->dev,
>   DMA_BIT_MASK(56)) and ignores the return value.
> - [Low] rnpgbe_add_adapter() calls netif_carrier_off(netdev) just before
>   register_netdev().
> 
> --
> 
> net: rnpgbe: Add basic TX packet transmission support
> 
> This commit adds the TX path for the rnpgbe driver: TX descriptor and
> buffer management, rnpgbe_xmit_frame_ring(), ring setup and teardown, and
> TX completion handling in rnpgbe_clean_tx_irq(). It also keeps the
> carrier off at registration, sets 56-bit streaming and coherent DMA masks,
> and enables NETIF_F_HIGHDMA when the mask allows it.
> 
> > diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> > index 6022a1a2ddf1e..265a3fcb07beb 100644
> > --- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> > +++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
> 
> [ ... ]
> 
> > @@ -248,12 +304,7 @@ static int rnpgbe_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> >  	if (err)
> >  		return err;
> >  
> > -	err = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(56));
> > -	if (err) {
> > -		dev_err(&pdev->dev,
> > -			"No usable DMA configuration, aborting %d\n", err);
> > -		goto err_disable_dev;
> > -	}
> > +	dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(56));
> 
> [Severity: Medium]
> Should the return value of dma_set_mask_and_coherent() still be checked
> here?
> 
> Before this patch, rnpgbe_probe() logged "No usable DMA configuration,
> aborting" and jumped to err_disable_dev when setting the mask failed. With
> this change, a failure is silently ignored:
> 
> include/linux/dma-mapping.h:dma_set_mask_and_coherent() {
> 	int rc = dma_set_mask(dev, mask);
> 	if (rc == 0)
> 		dma_set_coherent_mask(dev, mask);
> 	return rc;
> }
> 
> If dma_set_mask() fails, neither mask is set. Both stay at the PCI default
> and probe goes on to register the netdev. The only visible effect is that
> the dma_get_mask() check in rnpgbe_add_adapter() quietly leaves out
> NETIF_F_HIGHDMA, with no diagnostic for the user.
> 
> The commit message describes this hunk as "Configure streaming and
> coherent DMA masks" and does not mention that the error check was
> removed. The call is still unchecked at the end of the series.
> 
I left the return value unchecked because dma_set_mask_and_coherent()
does not fail for masks wider than 32 bits.
Similar feedback for other patches point this out:
https://lore.kernel.org/netdev/20260814123330.4b8056f5@kernel.org/
> >  
> >  	err = pci_request_mem_regions(pdev, rnpgbe_driver_name);
> >  	if (err) {
> 
> -- 
> Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/B438B0A83ACCA2DE%2B20261004065604.224873-1-dong100%40mucse.com
> 
