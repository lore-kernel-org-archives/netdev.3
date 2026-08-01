Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 228023C1D73;
	Sat,  1 Aug 2026 21:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785618658; cv=none; b=tEVHeemsYLfoyMjqBpLgR+4+OBCGopqWu3xymSJ8sDpJixwMqM83pS+G6KJqTyJCIPc3LtXRKGDtPOTJxALH0QiAt751cwX17cQGp0E+CKYh814h+exHXu+rGDe5iaFPW1J0NesXHhyT0G6cogR+mDyoRRJ5sXRGFuvW5WSIefI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785618658; c=relaxed/simple;
	bh=7ytS59q/d1LZxpTExwmoFhufllkMrTSSOJBL4YuTu1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtSXbz5Ia8pZIU5EBrBopB/F5KPS4+Dv9pLMs294ItJ7KaiEke8tQSExroJM+V5ykAyp0ySszBCmvsMANTCMIsXSFD+c5X/XVTOui2iqjn8g4qD3a85OslH+uKp8Rog3d9WQCiThY6RgjTHxAhg9m39L+PLJN89zuNV5+IuUUaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=h+Ye2Y2i; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="h+Ye2Y2i"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WpmQys7H6hIxilHgeHZVd3jnJ+OeJANKYZDRzFLoH74=; b=h+Ye2Y2iLLUJ1QQlXmbh01ySri
	9yuVBIQd6pnPs5s0P+r9KLT8oxLoZP8qHe7FSbIzmlvoXmQ80G7C0BaKFZOK67HRwRPly03vRf6x9
	A6zZK7VTniRo+CG2RmmvB5hifM1AhL526L4BKAw1DFdwZLRhxxirKHr7SnjCG35ahrE4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wqGyd-00FQOU-R5; Sat, 01 Aug 2026 23:10:39 +0200
Date: Sat, 1 Aug 2026 23:10:39 +0200
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
	linux-renesas-soc@vger.kernel.org,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: Re: [PATCH v2 06/10] net: pcs: xpcs: add ANRESTART support for SGMII
 link recovery
Message-ID: <cfddb747-11d0-476d-8402-e0886cca582e@lunn.ch>
References: <20260801142244.679437-2-coiaprant@gmail.com>
 <20260801142244.679437-8-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801142244.679437-8-coiaprant@gmail.com>

> -	/* Clear AN complete status or interrupt */
> -	if (state->an_complete)
> +	if (state->an_complete) {
> +		/* Clear AN complete status or interrupt */
>  		xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS, 0);
>  
> +		/* Initiate the next round of AN */
> +		xpcs_modify(xpcs, MDIO_MMD_VEND2, MII_BMCR, BMCR_ANRESTART,
> +				    BMCR_ANRESTART);
> +	}
> +

This probably needs more wide spread testing. I would be afraid that
if you kick off an AN cycle, you loose the link until it completes?
You would of noticed that on your hardware, but other hardware
obviously behaves differently...

   Andrew
