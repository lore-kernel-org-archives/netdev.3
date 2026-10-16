Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927942EC0A4;
	Fri, 16 Oct 2026 08:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792139017; cv=none; b=FODnpiOer0dNkeprD+xlI0Bd5+jIzGnITQ+mhK3BDifzYW4flRoDgooOy5aeZfHA4bL3duD+8N1FVCgk3UVuiI3s1D4SAg7i7sLHcclBI9NN2tkKXCRMF4jJfVSWndH3ImWf0lZrCqcU5xoIecDRIevTxx0obccotLsbebUfskk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792139017; c=relaxed/simple;
	bh=xw8krlJdXOTKOBJ6KwmsMvV3jpT9EDV8kD+SABruImc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RrdPlwwk5665MCF/kCc9F8JZO2qHwsmlJv2dq1lvzUSnmST6gRaorNilGAiDcJ0nq4U0dCZ7g7D16p6pevCm53jPM0E6m0ci+Uvw3b0vQUXw4H38rIkmLHUa4skCd/f6AlVkjHPyIzK+4Ts5jR2rssQJmqfAH/Q/bXUQr0a3rQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Ke2qrQfn; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Ke2qrQfn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1792139016; x=1823675016;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xw8krlJdXOTKOBJ6KwmsMvV3jpT9EDV8kD+SABruImc=;
  b=Ke2qrQfnzx1ReMdx9anMuGNFgpuszgRCKy7ALmMfMtcXrCEPm+C0nNYj
   FFEgH9F/ouhiBht+kyA3k1V8E4eSU9QodVbCtb24vhAsHlrQ/nQSqLjaI
   qHeiEndIgMaMg1wysBJ4Rb92tUlF1daOXN3+d8atVs1mkRFpCHTFG1Srg
   eeknEz3JOq+Lc4Y3N2Hk7xrmPc0dwwe59GO3R4s/wijuVtzrslPlPZQem
   DRePmJwP8iCpuHII+3jk6FT8gACj16+HO37LF5Xk7BmjcZfJBTDxMPkVC
   ZI8XKI94dVFG/eTue/n29wMJwdHkglRXd4YxFEQBVCnoG/dF2Hmf9gC6N
   w==;
X-CSE-ConnectionGUID: b51GVT9OTT2iDWhDvh9MPA==
X-CSE-MsgGUID: kApJifJFQ/idQEaHt503EA==
X-IronPort-AV: E=Sophos;i="6.27,161,1787036400"; 
   d="scan'208";a="232221585"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 16 Oct 2026 01:23:34 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 16 Oct 2026 01:23:34 -0700
Received: from DEN-DL-M70577.microsemi.net (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Fri, 16 Oct 2026 01:23:31 -0700
Date: Fri, 16 Oct 2026 10:23:30 +0200
From: Daniel Machon <daniel.machon@microchip.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Thomas Fourier <fourier.thomas@gmail.com>, Iyappan Subramanian
	<iyappan@os.amperecomputing.com>, Keyur Chudgar
	<keyur@os.amperecomputing.com>, Quan Nguyen <quan@os.amperecomputing.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, "open list:NETWORKING DRIVERS"
	<netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2] drivers: net: xgene: Fix dma_unmap_single()
 size
Message-ID: <20261016082330.j6pqrxwjbuhgvzjr@DEN-DL-M70577.microsemi.net>
References: <20261015124547.29996-2-fourier.thomas@gmail.com>
 <6046e419-2a1d-4e01-9f0d-f718ba8bfda9@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6046e419-2a1d-4e01-9f0d-f718ba8bfda9@lunn.ch>

> > In xgene_enet_refill_bufpool(), the skb->data is dma-mapped with length
> > len which is set to XGENE_ENET_STD_MTU which equals 1536. However, in
> > xgene_enet_delete_bufpool(), the same buffer is unmapped with length
> > XGENE_ENET_MAX_MTU which is 9600. This may erroneously unmap other
> > DMA buffers or cause other issues.
> > 
> > Change unmap length to XGENE_ENET_STD_MTU.
> 
> I don't know this driver, so i could be wrong.....
> 
> map/unmap is expensive, because it needs to flush/invalidate the cache
> etc. So the hot path part of the code, dealing with real frame data,
> sometimes only maps/unmaps the length of the frame, which is less than
> the length of the buffer, particularly when jumbo is involved.
> 
> So you could allocate a buffer for 9600 jumbo, but in the hot path
> only map/unmap part of it, but when you release the buffer, you need
> to unmap the full 9600 size of the buffer, to be on the safe size.

I don't think that applies here. The bufpool skbs are mapped and unmapped in the
RX path with XGENE_ENET_STD_MTU, never with the frame length. The teardown unmap
with XGENE_ENET_MAX_MTU is the only mismatch (AFAICT), and that is what this
patch fixes.

> 
> Please look at the driver and consider this. As i said, i could be
> wrong...
> 
> 	Andrew
>

/Daniel

