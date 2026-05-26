Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08D2D3B0AD7;
	Tue, 26 May 2026 16:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813617; cv=none; b=eQpgmTkxCVkVW55/2ab54buc7Dw9kFKlSXSPwJcXDLkMKHxSgy+F5dnNQ78yP8Rr2rl+7c1wdoY8fQkov5QPgWvU9gEjHcfNtIQ4V6MnkR3qgbIHUEeeWQYXxHqEKonGsSejdhAEAslguj4Q+5xELBHBDGstVhmdGiwUzEYatkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813617; c=relaxed/simple;
	bh=aPTkqXfEch8byIVOLFa1JdqdWURP8numOx+ffNQJYFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mLCmXr3SiS9vjAmqBIt+dYFkaklJpkrFTfmaWhV/3byjRTK9erll+MO6XxtHl+b82mfo6jdIGJ29qCZzMjOMt8WA0CDnDm1MbSmEZrInkW6zV44yJMUt/8469qwUyxLUwBaOcuDYDh6hlI6k6aa5fKLqIKe4u89JzGvxjALzUyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oUSzmAy6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oUSzmAy6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=CTye0P8ZXq82Hm2dPRhlCNkqticSJAIJFMEVqokLbwo=; b=oUSzmAy6uQAe9nD+uC4BoGMMoW
	G05gKW6/VuC0SeyVpqV9tGNWuk/MjLexHSAJYYssrKAoJgRsDIHcoBIKX4hZ2u0oHIIVaU4bzg9cD
	PsrLzYuTxj49Ih7+vc7+k7nY4uz9FflhZvKh3ksemY0gq7GQ+34LBJRdXVwn4vq6vG8k=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wRup5-004cCX-5K; Tue, 26 May 2026 18:40:07 +0200
Date: Tue, 26 May 2026 18:40:07 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Thangaraj Samynathan <thangaraj.s@microchip.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 1/2] net: lan743x: add RMII strap status
 detection for PCI11x1x
Message-ID: <8eb1d177-b176-40bf-a77d-434aa2b9189e@lunn.ch>
References: <20260526154054.19829-1-thangaraj.s@microchip.com>
 <20260526154054.19829-2-thangaraj.s@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526154054.19829-2-thangaraj.s@microchip.com>

> +	if (!adapter->is_sgmii_en && strap & STRAP_READ_USE_RMII_EN_) {
> +		if (strap & STRAP_READ_RMII_EN_)
> +			adapter->is_rmii_en = true;
> +	}

What does it mean when both SGMII and RMII is strapped? What if
neither is strapped?

> +
>  	netif_dbg(adapter, drv, adapter->netdev,
>  		  "SGMII I/F %sable\n", adapter->is_sgmii_en ? "En" : "Dis");

Since there is a netif_dbg() for sgmii, maybe add one for rmii, so the
code is somewhat symmetrical?

>  	struct lan743x_rx       rx[LAN743X_USED_RX_CHANNELS];
>  	bool			is_pci11x1x;
>  	bool			is_sgmii_en;
> +	bool			is_rmii_en;

Are there other strapping bits? Are we going to get is_gmii_en, and
is_rgmii_en?

Does a collection of bools make sense, when the interface modes are
typically mutually exclusive at the hardware level? Would an enum be
better? Or why not phy_interface_t ?

	Andrew
