Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F66C1A6809;
	Tue,  4 Aug 2026 02:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785812030; cv=none; b=EFsx//O9moHcihdcaJ+b/nGjXjSGbMejPsDcngURv0lASAKplUhzyrFJ2bAOE9VgX1M3WOG0tvHCGyxgVYWLNm3CHCy8gk7Efkk9j6Gr0l3veDC66uS6xzGYULoj5/QpDJz8JRnDDQFjG/7z7VlGL0Wlvh3cqD64j8Ht/FrZ3UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785812030; c=relaxed/simple;
	bh=kK5Tx8FFFQ47mP05ikhEX2IFhrZ7+GdR9l4nZl29jiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ap8tXkOYTw7VWlIeekpqcUf2XV02EACYElmCQ46BemLGHfY7SwXuoFJWQbiAh89Wr19Nh1D3EW7bbnqxZFQrCea6bcIOs1dGs9DmQXPs1nvXuoiXcoeudBZG2wguy/myHWlwRd1BxtLYvjde1hzJiKZEnbalqg2nWaRiH5GcJ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lFwn2scV; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lFwn2scV"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=IsQlcnApQ5yTWyBgwu7AHLGT/eRyiK29Qhu3u+8huV4=; b=lFwn2scVNrt3frs61Y32q/dVdQ
	/Ay4Nl2OSJFbIYdlwGBFlnZUFGT6DhGTu3i0EIZVxMmk8oBJFrzoMLox/mXYrwl+l8PRQ8Ab5bxp2
	IAdHGSUeXArMVxHWQaPLiWeF4zNCi+iK9tm84N2Vo04Wn4xjFbcLFI7PZrczeXsy61QY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wr5Hd-00Fto4-KL; Tue, 04 Aug 2026 04:53:37 +0200
Date: Tue, 4 Aug 2026 04:53:37 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Andre Przywara <andre.przywara@arm.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Liu Changjie <liucj1228@outlook.com>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 6/6] arm64: dts: allwinner: a523: x96qpro+: enable
 Ethernet support
Message-ID: <ad2e46d5-53db-49b2-a128-7c54883e18eb@lunn.ch>
References: <20260803101452.2993721-1-andre.przywara@arm.com>
 <20260803101452.2993721-7-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803101452.2993721-7-andre.przywara@arm.com>

> +&gmac1 {
> +	clocks = <&ccu CLK_BUS_EMAC1>, <&ccu CLK_MBUS_EMAC1>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&rgmii1_pins>;
> +	phy-mode = "rgmii-id";
> +	phy-handle = <&ext_rgmii_phy>;
> +	phy-supply = <&reg_cldo3>;
> +
> +	tx-internal-delay-ps = <200>;
> +	rx-internal-delay-ps = <500>;

500ns is quite big. How did you come to this value? Do you have the
schematic & gerber files? Does the lines look unbalanced?

	Andrew
