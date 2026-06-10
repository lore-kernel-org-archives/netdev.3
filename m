Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D377840D564;
	Wed, 10 Jun 2026 08:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781079990; cv=none; b=Grxbc7ZAqPA42sU12grN7tPDqLLVhAf+N8+I9bsHoWZebR/8mJeMVlwlbr8oikqZGXwIXyjXxHL4q5Tst5gy7WZu9ZLuup8TJ9xHtvTJRKYbO6xb23dEEQRKV9UHm1SM2PU5YVi0adEXElr/ZUFNkbszDOFRVFXuqE0DgQvSJrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781079990; c=relaxed/simple;
	bh=CE6fif61sNWUh9FU6JTE4s11+udFuO0BVYvsdYApmkk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WVqbiHw140fC8upSuL/oUXI9XWZHldi4qOIjLI+xDKx4Cg2MSgurXHyvTpbMlfzN040zvkm6tnd5QXreuWQGhRdY7iX70g2HzL2b8MFY+J8jyjMzi+pIes06aNMhM5qzKRw1PvdRelXiJcsJftWMPnxLDG8ZTxuwyo8az1f3ElY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NoPoQkhJ; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NoPoQkhJ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=udwkBPqowRrP2z38Fo4TtqpDwr4OIjaawCNIBaU9tK0=; b=NoPoQkhJCPn0NMZ75AIyKkFAoH
	Phf2hgxwfQxcCn/Z7qGX5KI4gtSy0kfZM45c88McpV9qd85cKDqr+0IDFm9fQ51YjGLVz+cIuHFsm
	hcpvMU06/Yvhd3WW5MnBHIpGaIjZ06ebNFJk4/lpl7PVY94htTZN8qy4HyiXH2NukyBc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wXEGK-006wlD-R1; Wed, 10 Jun 2026 10:26:12 +0200
Date: Wed, 10 Jun 2026 10:26:12 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Minda Chen <minda.chen@starfivetech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Giuseppe Cavallaro <peppe.cavallaro@st.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org
Subject: Re: [net-next v1 2/6] net: stmmac: Checking whether priv->phylink if
 NULL in NCSI case
Message-ID: <f3a32c42-27b2-496f-b236-02c33bee1773@lunn.ch>
References: <20260610072420.64699-1-minda.chen@starfivetech.com>
 <20260610072420.64699-3-minda.chen@starfivetech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260610072420.64699-3-minda.chen@starfivetech.com>

> +static inline bool stmmac_phylink_expects_phy(struct phylink *link)
> +{
> +	if (link)
> +		return phylink_expects_phy(link);
> +
> +	return false;
> +}
> +
> +static inline int stmmac_phylink_pcs_pre_init(struct phylink *link, struct phylink_pcs *pcs)
> +{
> +	if (link)
> +		return phylink_pcs_pre_init(link, pcs);
> +
> +	return 0;
> +}
> +
> +static inline void stmmac_phylink_start(struct phylink *link)
> +{
> +	if (link)
> +		phylink_start(link);
> +}
> +
> +static inline void stmmac_phylink_stop(struct phylink *link)
> +{
> +	if (link)
> +		phylink_stop(link);
> +}

Please take a step back and think about the Linux big picture
architecture.

What is stmmac specific here? If you were to add NCSI support to
another driver which uses phylink, would it need to replicate all
this?

When you consider how the MAC is configured, does it need to know it
is connected to an NCSI? Can the MAC tell the difference between NSCI,
fixed-link, a PHY or an SFP? Or does the MAC just need to know RGMII,
the link is up, send frames?

Please look at adding generic support for NSCI in phylink, and see if
the existing phylink mac ops covers everything needed for configuring
the MAC.

	Andrew
