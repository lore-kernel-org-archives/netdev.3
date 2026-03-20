Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78FDE35773F;
	Fri, 20 Mar 2026 08:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773996127; cv=none; b=SBMuOythNeSgk2gqMOGnYN+ge+fUgpc4AU8wsK5FXHwXR08556PWC2z/vpE78xtstXZWkKOF/r+YuvjBC9Ml82Uw2cGE+Ry/zL035fWesg4QLyCvuzOB57B+V2GH4UUwGmNzVqfyOAvhp+zfZzw5VeFsEklIUBEz34/ntRtxT9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773996127; c=relaxed/simple;
	bh=2goOUVs+18OkdbIgm+nvew2eiVT6u5QWWwYJVbfCgLs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Va7/MY6kMQn0NK427iRYlAZZhUJOKPLVl0KnQPq0h53bmwRCyh8lCM1cm2CluoK9H7VDhEFPYflf+3pVrcUpy5VLZEO1kvGf5hCNGToxIUR+uOq6jFN9T1gwxCMOYkL+W1WFlmh6BFxVsL3Mvu5Q9pF9y9mpM2TPDvEC3U4we9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=rcfOk2m5; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="rcfOk2m5"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=5S1jC4GzKRWZlRIWjIEJX66RpWiCwNLjwF++K0MsrPk=; b=rcfOk2m5zGtNf8qVGdqfySzpmh
	Ina0KbLvEhcXQPtstjplYuTxsXVdHbqCsRSyubjPUS1Ddpm34CqTc8cZoxGP+p33qj99Dmle+geRd
	LW7XzrgNRUt+KiXrnqOxxIMV33ILQge2m5H6PRLQ26XZcezJcnWdJDQkQvi3wRtDpBtcAmnn9GK5t
	qz415YBYHroEA5F2pZDJSsolrhEEJdV35kCoxEBFdPy6dp1r84wOBo/3YQ5TGnfg/Z2Gf1elhec3z
	jsYQnP2jum3LO8ahIutsRiskvUUyW+QmWtvFPvBRn28Yb/2pjayq0MBsda32tXOEtoj5cHn6eeOYR
	4bIH61Xw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:55662)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w3VQa-000000005nM-236X;
	Fri, 20 Mar 2026 08:41:56 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w3VQT-000000000ft-2FXE;
	Fri, 20 Mar 2026 08:41:49 +0000
Date: Fri, 20 Mar 2026 08:41:49 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: yangg9 <cohenyang511@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	kuba@kernel.org, yangg9@xiaopeng.com, edumazet@google.com,
	pabeni@redhat.com, mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com, maxime.chevallier@bootlin.com,
	vladimir.oltean@nxp.com, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: stmmac: close reset IRQ window and avoid double free
Message-ID: <ab0ITVGxiX5w7-0k@shell.armlinux.org.uk>
References: <20260320061955.833785-1-cohenyang511@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260320061955.833785-1-cohenyang511@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Mar 20, 2026 at 02:19:55PM +0800, yangg9 wrote:
> From: yangg9 <yangg9@xiaopeng.com>
> 
> During reset, stmmac_reset_subtask() used to set STMMAC_DOWN before IRQs
> were freed in __stmmac_release(). That leaves a window where interrupts can
> still fire after the device is marked down, which may lead to interrupt
> storms while the interface is transitioning.
> 
> Move stmmac_free_irq() earlier in the reset flow, before setting
> STMMAC_DOWN, so the reset path no longer has that interrupt window.
> 
> Since IRQs are now released in stmmac_reset_subtask(), guard IRQ release in
> __stmmac_release() with STMMAC_DOWN to avoid a second free_irq() during the
> same reset sequence.
> 
> This removes the interrupt-storm window in reset and prevents double IRQ
> release.
> 
> Signed-off-by: yangg9 <yangg9@xiaopeng.com>

I want to review this, but from this afternoon I may be out of range of
LTE signal for about 24h, and thus have no Internet access.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
