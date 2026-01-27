Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9196631328C
	for <netdev@vger.kernel.org>; Tue, 27 Jan 2026 16:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769530686; cv=none; b=Ol+fwy7KW+b4tZzC7yX4UkV3f+uXCgJXg/MShCFlqwAAnYa5jhNfQQmRMbRs2kB9jaQkgYpOzRSySQeP+f6Bhm9hNt9fSZiRHxmKgn/EVU6I7oydAgCFFsGu6MxSWksUByHfd/cJHfk7yldBFPrBtgULUE8sE/d8vMsJSRUEwr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769530686; c=relaxed/simple;
	bh=ZcNWtYJLIeryb15EqaIHjsT/CHKImJVZ9MYEChHRjRI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OfPXNfyouGr0uM0K/YClxJ5+iHDTdBc1XAx/5l5gXegHE4I1eXgj/fikcymhNGutLcsbETvUXJbNPtRu6o8OE0Bi5tl+balq1o9gJFEYXR456PkxMd1Ck1C39Cy5WyzXU1pVhe5sp5n7Loewt1CVI7miCoe3OXs61FELKj7PE6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i1fRsSxV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i1fRsSxV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987AEC116C6;
	Tue, 27 Jan 2026 16:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769530686;
	bh=ZcNWtYJLIeryb15EqaIHjsT/CHKImJVZ9MYEChHRjRI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=i1fRsSxV9eVplljd+MJ6yUFvekmXAaHasq2TxJPzMmEmHW6XOVTGJPY5H5/PpjoPt
	 5lV896kGw0/406DS2MElUeHkkQc68yLkwtDyND7plvjq1EQuZtwr+8jDvS4H2WrF+i
	 VqmNtJdv05LND6Fzfa0CMHrQ4Qgs5nq7GgTqblB7w+ySjgOS3pPrtLWtdSxt4mSByF
	 2kF9Lia/W5vBPtEWCvXn84V4mPNmRLpTRZ+T6hwR/kArs10I4s000LpEsISzBjRxaL
	 O3Wwc1tumTy48rBSBsxvOC97A/BRRS2BwPC9GfsAW/JYW08WtyAUaR9BBsWxXrGYnF
	 eL92+wnW9rJ4w==
Date: Tue, 27 Jan 2026 08:18:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: linux-stm32@st-md-mailman.stormreply.com, andrew+netdev@lunn.ch,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 pabeni@redhat.com, linux-rockchip@lists.infradead.org, heiko@sntech.de,
 alexandre.torgue@foss.st.com, andrew@lunn.ch, davem@davemloft.net,
 edumazet@google.com
Subject: Re: [net-next,v2,06/22] net: stmmac: rk: add SoC specific ->init()
 method
Message-ID: <20260127081804.64841f65@kernel.org>
In-Reply-To: <aXidBha0FahIS6Du@shell.armlinux.org.uk>
References: <E1vkL28-00000005usi-30YC@rmk-PC.armlinux.org.uk>
	<20260127004020.3785641-1-kuba@kernel.org>
	<aXgMIYPiL9JK-c_K@shell.armlinux.org.uk>
	<aXidBha0FahIS6Du@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Jan 2026 11:09:58 +0000 Russell King (Oracle) wrote:
> > > If ops->init() fails here, does bsp_priv->phy_reset need to be released?
> > > 
> > > Earlier in rk_gmac_setup(), at line 1610, the code calls:
> > > 
> > >     bsp_priv->phy_reset = of_reset_control_get(plat->phy_node, NULL);
> > > 
> > > of_reset_control_get() is not a devm-managed function, so the reset control
> > > would need to be explicitly released with reset_control_put() on error paths.
> > > 
> > > This new error return happens after phy_reset could have been acquired (when
> > > the device has an integrated PHY), but before the function successfully
> > > returns. If this path is taken, it appears the reset control would be leaked.
> > > 
> > > Currently no SoC sets ops->init so this path cannot trigger, but when a
> > > future SoC implements this callback, the leak would occur on init failure
> > > for devices with integrated PHYs.  
> > 
> > However, the driver does not release this resource when cleaning up, so
> > that's already a bug as the driver currently stands. I think this could
> > be converted to devm_reset_control_get(), which would resolve both
> > leakages, but not sure.  
> 
> Note that fixing this is going to add yet another patch to the series,
> because this is a pre-existing bug in the driver. It can't be replaced
> with devm_reset_control_get(), because this driver is getting resources
> for a foreign device (we don't have the struct device pointer.)
> 
> So, it isn't going to be a simple patch to fix this.

Would it work to make that plus patches 1-4,6 a separate series?
