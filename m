Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A2C40A92F;
	Mon, 27 Jul 2026 13:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785157399; cv=none; b=HPoflV36op4V2DTc5uCqRin87kI2I8+12M5JoQ6Y6GVxewtESa8eR7B1OPrDp29qn3ESUMT5V0fap6kKSVee02v4ZcUK0mYZmRn5xxnp+V40p4Q03pMTjbcZHR9rwGZSN+9RkZuH7mqXJGG8SCLRJLlJwzyS8JkRR3isDxnfyj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785157399; c=relaxed/simple;
	bh=RrFmearDQyNTrXJqVRhAKts0+V+u+AtA+yHimQ5nyLY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iToODVaQJGSDtrey1ZvkRmZb/0uiYmvhbX5qE4tuSN1Px31Q5slU8+z1jGexleNRy9IEk6geSvI15LmZtujGsrSDkOUgU90s89IQO49BCAw3EOBSLCZTMBH9yr0VuISBIXOIH3linfPgKvSaRJnhSDVBjkRn18FhZouFmVrPkJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=mUG1p50p; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="mUG1p50p"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=kUt65GKSqyj98NXe/npD3+O2Bp8K4k77GlLKHHo0EGc=; b=mUG1p50p0fu3TYQH0hC1vDPcj9
	GL7CM4La1Bx1Szg1lJVY/w1AX77NSpE7rCJ4ANAOmZQXR7BQeYbLLNKvP5WgVyeV+oxmIoq46UuVW
	zTwnIbdbxMsZFItRN0v5f9u8BIGMorVuicOB/u3w6TVa5WqRyNZHZ98zlLLZCgYHtmIQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1woKz3-00EQo8-5l; Mon, 27 Jul 2026 15:03:05 +0200
Date: Mon, 27 Jul 2026 15:03:05 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Abid Ali <dev.taqnialabs@gmail.com>
Cc: alexandre.torgue@foss.st.com, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com, mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org, pabeni@redhat.com
Subject: Re: [PATCH] net: stmmac: enable MAC rx/tx after DMA start
Message-ID: <a13d65de-75fc-413c-90e2-0f1805c6394f@lunn.ch>
References: <ee639271-60dd-49f7-9e77-0ae47841754d@lunn.ch>
 <20260727055715.4430-1-dev.taqnialabs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260727055715.4430-1-dev.taqnialabs@gmail.com>

On Mon, Jul 27, 2026 at 05:57:15AM +0000, Abid Ali wrote:
> On Sun, Jul 26, 2026 at 18:15:20 +0000, Andrew Lunn wrote:
> > There should be a function which is the opposite of stmmac_hw_setup(),
> > which tears it down. What order are things done there? tear down is
> > generally done in the opposite order to setup, so does the "Disable
> > the MAC Rx/Tx" also need to move?
> 
> I have not seen the FIFO stall in the teardown in my testing,
> but the MAC Rx/Tx should be disabled before the DMA engine is stopped.
> For the normal path (__stmmac_release), phylink_stop() is called first
> which triggers stmmac_mac_link_down() -> stmmac_mac_set(false), so the
> MAC is already disabled before stmmac_stop_all_dma(). The teardown
> order is already correct there.

Thanks for checking. Please add a comment to the commit message about
this.

> 
> > Same comment for the opposite of stmmac_xdp_open().
> 
> Currently, stmmac_xdp_release() does:
> 
>     stmmac_stop_all_dma(priv);
>     ...
>     stmmac_mac_set(priv, priv->ioaddr, false);
> 
> The ordering is not followed here,  I'll make it follow the similar
> ordering to (__stmmac_release) in v2.

Great.


    Andrew

---
pw-bot: cr
	
