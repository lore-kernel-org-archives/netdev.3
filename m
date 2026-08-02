Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C97B171B1;
	Sun,  2 Aug 2026 19:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785697261; cv=none; b=um7cLqi2Y1nDxu5YSiuY9Aedp+bn6qvttYGcYjkSgjvB0HgQhKl8kyOY0V/tm2R2HIvtvm+LDXFCUeNOFnt/j7Upi8TM8TgcpfcTbEtVRbT6YLIU/Dlu7k6IlCr9VBHRsV8yOuX4BA1jfEdrKm3wEMA5Ut5m0xi09rZzglwomGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785697261; c=relaxed/simple;
	bh=EfT06c4bUG5RM6uvwUF2MIPaWAlOHTsViLXf2tLbKGI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GhJbi/TSTSypRLmFr4VhtgOAqkhlirFrm6iy7dah0qNGpeWhEO78OgX35QzmBf5AZT4aTgA4Mur9m9XryFRE3Q4r3qzsCvHLzulfxdZY3COQxhl6CWt4iq954bHBOmTTxFWxaU2cjG67uEZDHKddAF9/5HhzUKOjncYVvewrbo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fXRZGqyY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fXRZGqyY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=3ShKaSqVzpoKTOwv2WVILmoiM0sd7wX/pCkyn8buCZc=; b=fXRZGqyY1gL41dRfLIFcq8Dokz
	GcgcZXVeYXq1zbgcc5ZyBAmzbC0u5hqrStplnQZ+iEp3PSZv6NSCpp4rA/5VTitgS30L+YNtgrGUO
	x5bt2Yd5UN+G+vh9LuyONS2h6wd3zjmS5kL3nfrgY3k8KYHafnC4x7RR5ggbjSC9pUfk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wqbQM-00FbXo-49; Sun, 02 Aug 2026 21:00:38 +0200
Date: Sun, 2 Aug 2026 21:00:38 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Coia Prant <coiaprant@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Vinod Koul <vkoul@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Russell King <linux@armlinux.org.uk>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	David Heidelberg <david@ixit.cz>, netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH v2 07/10] net: pcs: xpcs: add Rockchip RK3568 platform
 glue driver
Message-ID: <ba5522ab-1e77-4236-89cd-9483ed1f2da0@lunn.ch>
References: <20260801142244.679437-2-coiaprant@gmail.com>
 <20260801142244.679437-9-coiaprant@gmail.com>
 <23d8e994-8552-466f-98e6-c47d5783525b@lunn.ch>
 <CALj3r0i5yVcJY8V75y0Hm5xjtZSBpH0DXSAWKsAUqguChVcxYA@mail.gmail.com>
 <302c67b0-6729-4930-a409-a2408dde33fc@lunn.ch>
 <58C6FD30-02CF-4DC8-BE7F-4E2AAC5985E4@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58C6FD30-02CF-4DC8-BE7F-4E2AAC5985E4@gmail.com>

> Hi Andrew,
> 
> You're right that the xpcs core uses C45 exclusively, and modern kernels
> no longer require C22 callbacks for mdiobus_register().
> 
> However, I'd prefer to keep them for two reasons:
> 1. Debugging tools (mdio-tools, ethtool, etc.) often use C22 reads to
>    inspect PHY/PCS registers. Having these callbacks makes debugging
>    much easier without having to patch the driver.
> 2. It keeps the driver consistent with pcs-xpcs-plat.c, which also
>    provides both C22 and C45 callbacks even though the xpcs core
>    only uses C45.
> 
> If you strongly prefer removing them to keep the code minimal, I can do
> that in v3. But I think the debug benefit justifies keeping them.

Keep them. I was thinking it side steps the issue of accidentally
mixing up C22 registers and C45 registers. But there are useful use
cases for C22.

      Andrew
