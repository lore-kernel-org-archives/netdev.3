Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E4AD1E515;
	Tue, 28 Jul 2026 01:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785201379; cv=none; b=JiynXoZ/9KX6O2AqmxK4DM/RXd8G0RQzsAIOfYxt18wxZP0yQzvg1bESNKmC6BhhthZmXkClogssWAdhjSvTBSqXA9ZD+az8+2Yka6KiMv43/M/DvPkZoU7dt9OgVdJuafXB9WQxosHPm+r2X7uePGb2YqzYrl0v/5JrLEpGy2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785201379; c=relaxed/simple;
	bh=lKmj5xwYrCz5xP21kJtj9tAHiRxx4Dpk0OoOrVjU6Ak=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L1W8TYicmHYp676RY5NV2f2dAOIySINA40+zeduaS/N32k77QY0bnG096L5L5R/1QcbmVbexcxP6PZYNpLz2pe005rzKYXDY3PRbX0sAvahfb9g0lFk10qizRa4Zb4m63YbmqDzvISf2bFlstWO53xjML678tWyfHhnJAezXpyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LsL2B/kK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LsL2B/kK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97B351F000E9;
	Tue, 28 Jul 2026 01:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785201377;
	bh=ahIXQYf79mj0HUrVAAIajF7mHrwV6GuajWIcWx8ItlA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LsL2B/kKGM6ilnMn2HqwiffyXW3t+f1Fv9/7czypmBLTU+t4QPL32FpMySae6ohs6
	 r2WlPFHK6ls+B+AdyCuaVQ7pe+sj1QcEvzeiACYdZCb/VTlFwzwk4J/zWRKDlIPkdu
	 yhLQ3q38EC88GeXoaAlwb9ht0uWHJeqPkn9lmEcvCUkPBpujhMunDC3LGpifSC0B7K
	 R+9ONahsdubHI6Xf3Kw55o2lDeOFN/a3wFfU1k0RsFOMSbXwbEmOIlI5Ca9w64Xozs
	 eV7s6iooMKzHfMrLC7/rTlT+e17OMzM4XUuXTAtzjwpNgENmO6n/6xNcyChK04CkH2
	 KnS/vYHJJWGFw==
Date: Mon, 27 Jul 2026 18:16:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Zxyan Zhu <zxyan0222@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: stmmac: dwxgmac2: configure INTM for
 per-channel interrupt routing
Message-ID: <20260727181617.19604f9c@kernel.org>
In-Reply-To: <f979a974-a9ad-4f4d-9e57-9f88900298a2@bootlin.com>
References: <20260723132457.3061337-1-zxyan0222@gmail.com>
	<f979a974-a9ad-4f4d-9e57-9f88900298a2@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 15:50:50 +0200 Maxime Chevallier wrote:
> On 7/23/26 15:24, Zxyan Zhu wrote:
> > The XGMAC DMA_MODE register has an INTM field (bits 13:12) that
> > controls interrupt routing behavior for DMA transfer completion
> > events:
> > 
> >   00 (default): sbd_perch_* are pulse signals, sbd_intr_o is also
> >                 asserted for each completion event.
> >   01:          sbd_perch_* are level signals, sbd_intr_o is NOT
> >                 asserted for packet transfer completion events.
> > 
> > When multi-MSI is enabled (dma_cfg->multi_msi_en), per-channel TX/RX
> > interrupts are expected to arrive on their dedicated lines
> > (sbd_perch_tx_intr_o / sbd_perch_rx_intr_o).  In the default INTM=00
> > mode, sbd_intr_o also fires for DMA completion events, but the
> > multi-MSI handler stmmac_mac_interrupt() only processes MAC-layer
> > events (LPI, PMT, timestamps) and does not service DMA channels,
> > silently dropping the interrupt.
> > 
> > Set INTM to mode 1 when multi-MSI is enabled, following the same
> > pattern as the GMAC4 DMA_BUS_MODE_INTM configuration in commit
> > 6ccf12ae111e ("net: stmmac: use interrupt mode INTM=1 for multi-MSI").
> > 
> > Signed-off-by: Zxyan Zhu <zxyan0222@gmail.com>  
> 
> Same logic as in dwmac4, this looks good to me,

Is this a fix tho? The commit message reads like DMA irqs are
completely ignored. But neither this commit nor 6ccf12ae111e
really explain much to an outsider..
