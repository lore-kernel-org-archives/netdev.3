Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C66F331EAB;
	Thu, 11 Jun 2026 16:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781196260; cv=none; b=Ktc09SlLap3ipLTHprBKF6+xphRVrSgH4h73yDTe8jsEV3MFTM8ZtumOfREMtZbEzJmzBWFKwWfkijejCSfsMYhmMJtLasaaiEL6uDyeBA1F3Q8sff1X3fHr+o1N89gJA0jybf4lzTB6T1A/6hE0hozUZiNEbVhwog9zRJcCKlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781196260; c=relaxed/simple;
	bh=iQne3Cad+P22Bim3dFLBnd2UXnKDchpZL0ap2Q+X9wc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VA1dcgx0nV+WEdYUmvTKBRzqTMgUa9oPpN3WIJPOMXHc7EZpExR12Vw8A+K00MlYYSBQj/c4PLG5MaSC6n57d7WkHhQ88m58m1s9pqi5QQC8XNv5mcpKirPxs390xWU4mKSPJsb+wnIfnKON5zY8wDAdusuTi84UrkppEACJAoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fea6H4j7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fea6H4j7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AD611F00893;
	Thu, 11 Jun 2026 16:44:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781196258;
	bh=sAMz/1/Y8/IUyrVqhndViEyUWWexrKqsIq7TAusEZ5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Fea6H4j7uyJf+McLb52gVVmX+57LNd1xnqdnoO3kcz8EL+gh6Bx1vTGF+iYGbAOgC
	 LzCT883FmTy8dp64Vt4U+Gw2b+jmbVH6P8P5yNlcMct86rZJctGJFNMPuKjDLkL+p8
	 c16Mea4MJTsdh22f8neEwVwTOMY7O8RK7h/Vd4OM4orlPuJsfVFoyphnpwWRdN1qjS
	 oG59hsOpvrAeHG6ZxVJBF1TJf1tVMmu1wiY7azbkwcL5GLyiAvVz8fNQOUusTLWPfS
	 4cp3KZnrbGFmky9iXgZuKH8pPnKlOq2Dnu35dDkHANtInIcE3gBpiRuZXrNPfqrKpB
	 eDNeU2mv/3Ubw==
Date: Thu, 11 Jun 2026 17:44:14 +0100
From: Simon Horman <horms@kernel.org>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
	rmk+kernel@armlinux.org.uk, maxime.chevallier@bootlin.com,
	Jose.Abreu@synopsys.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: stmmac: xgmac2: disable RBUE in default RX
 interrupt mask
Message-ID: <20260611164414.GX3920875@horms.kernel.org>
References: <20260609121703.9736-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609121703.9736-1-muhammad.nazim.amirul.nazle.asmade@altera.com>

On Tue, Jun 09, 2026 at 05:17:03AM -0700, muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> From: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> 
> Enabling the RX Buffer Unavailable (RBUE) interrupt is counterproductive
> and can trigger a MAC interrupt storm under heavy RX pressure. When the
> DMA runs out of RX descriptors it fires RBUE continuously until software
> refills the ring.
> 
> However, RBUE is redundant: the normal RX completion interrupt (RIE)
> already triggers NAPI, which processes completed descriptors and refills
> the ring, causing the DMA to resume. The RBUE handler itself only sets
> handle_rx - the same outcome as RIE.
> 
> On Agilex5 under heavy RX pressure, the MAC interrupt (which includes
> RBUE) was observed firing 1,821,811,555 times against only 2,618,627
> actual RX completions - a ~695x ratio - confirming the severity of the
> storm.
> 
> RBUE does not provide OOM recovery. If page_pool is exhausted,
> stmmac_rx_refill() cannot advance the DMA tail pointer, the DMA stays
> suspended, and RBUE fires again on the next NAPI completion - a storm
> with no forward progress. This patch trades that storm for a clean
> stall with the same RX outcome. Proper OOM recovery is a pre-existing
> gap outside the scope of this fix.
> 
> Note: as a consequence of disabling RBUE, the rx_buf_unav_irq ethtool
> counter will always read 0 on XGMAC2 devices. This behaviour is already
> inconsistent across DWMAC core versions.
> 
> Remove RBUE from XGMAC_DMA_INT_DEFAULT_EN and XGMAC_DMA_INT_DEFAULT_RX
> to prevent the interrupt storm while keeping normal RX handling intact.
> 
> Fixes: d6ddfacd95c7 ("net: stmmac: Add DMA related callbacks for XGMAC2")
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Signed-off-by: Nazim Amirul <muhammad.nazim.amirul.nazle.asmade@altera.com>
> ---
> Changes in v3:
> - Clarified that RBUE does not provide OOM recovery even when enabled;
>   disabling it trades an interrupt storm for a clean stall with the same
>   RX outcome (Simon Horman, Paolo Abeni)

Reviewed-by: Simon Horman <horms@kernel.org>

