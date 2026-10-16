Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0325E3EFD04;
	Fri, 16 Oct 2026 21:06:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792184789; cv=none; b=HCdGKuMeuB04kZqW3oXPYCi+wmlBMkoRGQurkouIwzlrluRatcDEEAiSQMs+PtE22IdUZgMcVUejx5K6fQFgaASknKrZe7OcTBvtPzNB+umBcKWDrvuDm9QXc6WP3AI1nWAVOo58jP3Rl4sdblS/VdtMcz2Dw2wj76eG1PUCQ1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792184789; c=relaxed/simple;
	bh=IzwJfVp2kxmpdoLQf+XgRud+uhuJM1P3/ZHnsps1PgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gC/RJYD/bi8ZyQLCFLxtF0bYy90/If7GrtxyBsulmOdwgHZcpaob/Uu7HhtfwrF5q1u7fWHsHMy2Vei/C2eWmkwgMjQufM4YYp8LuNXQ5BSnaAcCRqIJ6ZBOetdqTqP57jCXFgLoWl+ZOun7P6uV/1TcwjrVfj5A3kubLrUNIWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wCtwaJZc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wCtwaJZc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=vAS2Gr3NeYg5wvMMHPUcZ5111hrdazaeXRxJGvQo2cw=; b=wCtwaJZckzkUVA/RHTAdPnqXXu
	yjzrMlbfLoncfcmM+k/WlLxmChbaTILFXLFhHRpghCAfV7GYSA5i8ttwiVJ4Vhc1qv78kbAkuJuBT
	zxjqOHwzj9VNeiBi/ofgn9vjNuZGmBZ9EvhZvzEBhw+HJ+L1VKF2UvxLrhqXWAnoYDAg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xHp84-00BE4M-Dj; Fri, 16 Oct 2026 23:06:16 +0200
Date: Fri, 16 Oct 2026 23:06:16 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 6/6] net: ftgmac100: Allow building on ARM64
Message-ID: <d6b2d632-c61a-4ad1-9f9c-581652d70c51@lunn.ch>
References: <20261015-support_ast2700-v3-0-8d7999171ac4@aspeedtech.com>
 <20261015-support_ast2700-v3-6-8d7999171ac4@aspeedtech.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261015-support_ast2700-v3-6-8d7999171ac4@aspeedtech.com>

On Thu, Oct 15, 2026 at 02:46:58PM +0800, Jacky Chou wrote:
> Allow the Faraday vendor menu and FTGMAC100 driver to be selected on
> ARM64 so AST2700 platforms can enable the MAC. The driver now programs
> the upper DMA address fields, so it no longer needs to be marked BROKEN
> for 64-bit builds.
> 
> AST2700 has no dedicated MACH_ASPEED_G7 symbol; unlike the 32-bit
> generations it is only gated by the common ARCH_ASPEED symbol. On
> 32-bit Aspeed platforms, arch/arm/mach-aspeed/Kconfig nests
> MACH_ASPEED_G4/G5/G6 under "if ARCH_ASPEED", so MACH_ASPEED_G6 already
> implies ARCH_ASPEED and is redundant once ARCH_ASPEED is part of the
> condition. Drop it and select MDIO_ASPEED directly on ARCH_ASPEED.
> 
> This does widen the MDIO_ASPEED select beyond AST2600: it is now also
> selected for AST2400/AST2500, which keep driving their embedded MDIO
> controller from FTGMAC100 itself and have no MDIO node for this driver
> to bind to, so it is built but stays unused there. Update the
> MDIO_ASPEED help text to describe this.
> 
> Signed-off-by: Jacky Chou <jacky_chou@aspeedtech.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
