Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B90AE3B960B;
	Wed, 15 Jul 2026 22:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784154363; cv=none; b=dqjroSNXUYyYsYAZq/zLT6EMUbmBxwRrconO6eqC3Wu51Z09H0OfeUk+Jv5ezDVycNU3nikZyGbl01rG/fKceOtSRPyO45b+ySyARXbNAvLQPLAAqAdTl0niJ9Mki7ZXzlmxxFfrbAita6op/U8/6DuU4aykY3UcdsmOw275mI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784154363; c=relaxed/simple;
	bh=/70FVNbjbdiONld20oDnriAli0zNHzB1jYVwC+HfmXM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UngOotwhYMb8v1qz471AM+cp2UFd8joQXPhEd67BzC+3sdk0dUZLkIzKiv0iDUyVXnjgZc+YEbn/oaOYk1k6vH/iEJzx2IB4d3BJg/hHaIQ1SZUZMAmM6A9tniOkS1RCR+QhAozwM0x14EmYYB9Y08pQ2BmH0k8sQwgtPr6gn70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Dciz/F9g; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Dciz/F9g"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=Icy4Hvg5BKzy0MO22FaDLrhFiZTRk9Gdc2zzdS1Erwo=; b=Dciz/F9g6FWjHSsbun+77shqW4
	0hQ9DtoRImUvzjKePBcn4qKxvrY5vP/Fg78ZZ2QEVawlWWLkD6Dw3aGwE6En0RfdKa6JimUgNaCWv
	/SOuLzXngpB3musTELt6CuuaQMQX4atCbfmwIxZ7kkJ8YzXCNExEnO0NuHKwTwRnlDNc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wk833-00CQuz-De; Thu, 16 Jul 2026 00:25:49 +0200
Date: Thu, 16 Jul 2026 00:25:49 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Coia Prant <coiaprant@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>, kuba@kernel.org,
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
	andrew+netdev@lunn.ch, robh@kernel.org, krzk+dt@kernel.org,
	heiko@sntech.de, netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org
Subject: Re: [RFC PATCH 07/10] net: pcs: xpcs: add Rockchip RK3568 platform
 glue driver
Message-ID: <039c2cce-e76e-4321-ba4a-cd80801f136e@lunn.ch>
References: <20260714191341.690906-1-coiaprant@gmail.com>
 <20260714191341.690906-8-coiaprant@gmail.com>
 <4823c1d9-51d9-45fa-a96c-f2caab1cb29e@bootlin.com>
 <CALj3r0h4cFd-tp9-UVxihL9-a1W7_4nvnKoXW_cP5WECKc66Hw@mail.gmail.com>
 <1d92078f-3009-43d1-a228-c3e67a1f4f4c@lunn.ch>
 <CALj3r0gBnyEVwo3rK-dKssYN9F4nFn93QJ24FVv8YBLjNNgPmg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALj3r0gBnyEVwo3rK-dKssYN9F4nFn93QJ24FVv8YBLjNNgPmg@mail.gmail.com>

> The current design
> ==================
> The dependency chain I chose is simple:
> 
>     stmmac (GMAC) -> pcs-handle -> XPCS node -> phys -> SerDes PHY

Maybe we need to be more accurate here.

In QSGMII I _think_ it is actually

stmmac (GMAC) -> pcs-handle -> XPCS node -\ 
stmmac (GMAC) -> pcs-handle -> XPCS node -------> phys -> SerDes PHY
stmmac (GMAC) -> pcs-handle -> XPCS node -/ /
stmmac (GMAC) -> pcs-handle -> XPCS node --/ 

There are four instances of stmmac, four instances of the XPCS, which
then all come together into one PHY.

When using SGMII, does it look like this ?

stmmac (GMAC) -> pcs-handle -> XPCS node -------> phys -> SerDes PHY
stmmac (GMAC) -> pcs-handle -> XPCS node -------> phys -> SerDes PHY
stmmac (GMAC) -> pcs-handle -> XPCS node -------> phys -> SerDes PHY
stmmac (GMAC) -> pcs-handle -> XPCS node -------> phys -> SerDes PHY

There are four of everything, all working independently.

Is there 1 QSGMII PHY and 4 SGMII PHYs? Or does one of the 4 phys
support SGMII + QSGMII, while 3 are SGMII only?

> 2. User misconfiguration: even with reference counting, if a user sets
>    `phys = <&combphy2 PHY_TYPE_SGMII>` for GMAC0 and
>    `phys = <&combphy2 PHY_TYPE_QSGMII>` for GMAC1, the same PHY would
>    be initialized in two different modes.

I would hope that results in -EINVAL.

  Andrew
