Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C33754052D9;
	Fri, 25 Sep 2026 23:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790378242; cv=none; b=koTk7RC/zDfXRZhAa1ZJYg8XNSe4jnL+y3LUzbN0xO3FQ7eGnYoaG+gWdagxvb8jD63bk752/3ZbFf9QrJnWnXWDQLcFJjbaIcSI4sYpGxXpCsBgreYGEarKGeKyhbfIAoWQlgIUOmVpy3N1C6lm7IHDxueSYMGWAfz+8XwBV1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790378242; c=relaxed/simple;
	bh=+vKXCBtdk637c0n1Wkj8QfS5F31BiucdN9/XpNxmgmg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U07bNtG46clVw3EmmzTjyIb5nl6e+qqE1Mero5yY2mC2iV7dXG+5hv6Gz+C9pLbGprMYtSELiBDdp9ucF59j/sa5BhjcTjxdqyj98ILF6EtSWmKoWkieUPfqTaWS0rq7zRWkz7dRda/wh8jss1+W+0AMIcNL4DYgFRijVBYQAvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=LaQ1gqcX; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="LaQ1gqcX"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9mGHywWFBuS1brYkfWRhdDtGg9HQW7eaDie7RYOA7Yo=; b=LaQ1gqcXVllIYPL90gvLN41r64
	4CP0b4KPbejRnLB/W2H99ZyG9lrN8ebav14G4K2Ix3SzJiun2jU2kOaf/q+C6VhhRZ+mnPU/fEbu2
	WPbdvzs1l2if/IifL486lRwxHcEZflTMjIjXyXHcu63j2DwoVzK+VM7zrb6R6Kjq5yck=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xAFAH-007KDl-30; Sat, 26 Sep 2026 01:17:13 +0200
Date: Sat, 26 Sep 2026 01:17:13 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Vasilij Strassheim <v.strassheim@linutronix.de>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Martin Kaistra <martin.kaistra@linutronix.de>,
	Benedikt Spranger <b.spranger@linutronix.de>
Subject: Re: [PATCH net-next v3 6/8] net: dsa: soce: Add basic support for
 SoC-e switch IP cores
Message-ID: <6c75787b-f06c-4d85-8fc4-5bd7b2a30716@lunn.ch>
References: <20260923-devel-vstrassheim-soce-dsa-ml-v3-0-ddebafcb9ba7@linutronix.de>
 <20260923-devel-vstrassheim-soce-dsa-ml-v3-6-ddebafcb9ba7@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923-devel-vstrassheim-soce-dsa-ml-v3-6-ddebafcb9ba7@linutronix.de>

> +static void soce_sw_read_core_version(struct soce_dsa_local *local,
> +				      u8 *version, u8 *subversion,
> +				      u16 *revision)
> +{
> +	u32 regval;
> +
> +	regval = readl(local->base_addr + SOCE_CORE_VERSION_OFFSET);
> +	*version = (u8)(regval >> SOCE_CORE_VERSION_VERSION_SHIFT);
> +	*subversion = (u8)(regval >> SOCE_CORE_VERSION_SUBVERSION_SHIFT);
> +	*revision = (u16)regval;

FIELD_GET() would make this more readable. 

> +static int soce_sw_detect_features(struct soce_dsa_local *local,
> +				   u32 *numports)
> +{
> +	void __iomem *base = local->base_addr;
> +	u32 implemented_numports;
> +	u32 licensed_numports;
> +	u32 regval;
> +
> +	regval = readl(base + SOCE_LIC_FEATURES_OFFSET);
> +	licensed_numports = FIELD_GET(SOCE_LIC_FEATURES_NUM_PORTS_MASK, regval);
> +	if (!licensed_numports || licensed_numports > SOCE_MAX_NUM_PORTS)
> +		return -EINVAL;
> +
> +	regval = readl(base + SOCE_IMPL_FEATURES0_OFFSET);
> +	if (!(regval & SOCE_IMPL_FEATURES0_DSA))
> +		return -ENODEV;
> +
> +	implemented_numports =
> +		FIELD_GET(SOCE_IMPL_FEATURES0_NUM_PORTS_MASK, regval);
> +	if (implemented_numports < SOCE_MIN_NUM_PORTS ||
> +	    implemented_numports > licensed_numports)
> +		return -EINVAL;

Maybe add dev_err() here for all these error cases. It will help
somebody debug why there switch fails to probe.

	 Andrew
