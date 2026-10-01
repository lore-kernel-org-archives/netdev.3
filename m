Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AC5827473;
	Thu,  1 Oct 2026 12:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790858461; cv=none; b=i3HR5jDAFRQgtdhz5x04sDY6Edk+4UgFIABvr9wFMmq0zEivAoG/BL+LzDQbdgcLIVgpPXJ48Am3OUxhFCgSIAdgy5vPA/QM2ubR3/Iro1pltp6Ce5GZW2CtsA2JvF3TMzFsKjyrmf1xNYoUQ4xM59cIQYcWIq7mnRWBKBEXxfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790858461; c=relaxed/simple;
	bh=1JAJlQNmrKtkAfVL5Sfp8KnmJqonyTb57j9Oe+QTa98=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwvbY3/YH4zaog47MVT9yv5qwg0lRhf7UKUv4bPR1ZnE1ZvUd/7DrXEZcF31fY1eSQpEEE1owFlr/V4VqtcMOBGe4+sYrtGXl2uncGJ0exNm2alDtRN4WKExwiN1G2ZDEUx3xYG8gPwXulCymBxjKvn7iIcftuu4N2LrgqT9xec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rgsndd40; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rgsndd40"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=RpxymfVofoWeJsFlJ5P2vwYEqoxBbg4TTGHUHS+KpRU=; b=rgsndd40Q7LCqxSRIJxEbwkR6x
	4Dtpt6Qp53kGiTA1b4woTlhPntj/DEUmsYBSwceFU8qojbKK/+Q3NPXVn6qZodt/OrKJK44tBqM+7
	c1KkJ82a5zpjoJ14smol5cMngwBfDJOKDPn0Jwg+MKN6EQJGmI34v+dVuOQVL551qchM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xCG5e-008Nb2-Bp; Thu, 01 Oct 2026 14:40:46 +0200
Date: Thu, 1 Oct 2026 14:40:46 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: iav@iav.lv
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: stmmac: mask the MAC interrupt while
 resume resets the MAC
Message-ID: <47a5be82-c09f-486b-a7e3-35e6edb89ad6@lunn.ch>
References: <20260930-stmmac-irq-shut-v1-1-104d1a1dcb28@iav.lv>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930-stmmac-irq-shut-v1-1-104d1a1dcb28@iav.lv>

> stmmac_resume() resets the MAC in stmmac_hw_setup(). On dwmac1000 the
> reset clears the interrupt mask

For my understanding, it is the hardware reset which clears the mask,
not software?

If it is hardware, that is an odd hardware design.

   Andrew
