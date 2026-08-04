Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE1436F434;
	Tue,  4 Aug 2026 02:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785811440; cv=none; b=MetwnjysY1dJW6lQAQEzOXdG69flyCFpGbgtRzRc4MnmIF5R1sPj1tZzdYT1BvqsKncCVgbbmoQSfPvMgpaRt4hSfZa98/BFLsIz/xZHsYctckhZqfgqMk8Usg4NboM4Cu96TOMF7yCnEA2qLVbsSVpc6uRGQFt/6PZtBgdZvBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785811440; c=relaxed/simple;
	bh=uM8nd2RxB+mlipGWeM2GkT90aC2ch9iqClZSjXh+rY0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chg6ILYVRKEgSovA7cDb3jKIEEawa/h6zAO0TsBKQm55ADf9/1JmFzrD0L+aciCezK8qWmycb9otYjJR+B8h/FbpnPUWs2dkZZhIkj3n9lZ3NEeXH1zLUx1vO/F3X/yIOx/Z/NWpYRdwpdIobiiq9I9vLxxvre/CjorVpEPyblo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=diW6+82f; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="diW6+82f"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=gpT1FAd/Ou6ubtzqCbG7hgWwpUpLT83GDnqC3oQIUbw=; b=diW6+82fctwCE+HQww2Ii6cSFa
	a9Dm8AJVjUmp34KLNiqKnGXkM7uPqxSOYXOT28SGPhOTj/mRWVpM7Aa6bCbxIGpTpvZJJLKAcd9O6
	udhLuhcNwpH7BsYXEucYFyba838Qecm9z1viQPUP64bvcUe7jCQhAUSduK7ad9k38aaM=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wr58A-00FtgY-3f; Tue, 04 Aug 2026 04:43:50 +0200
Date: Tue, 4 Aug 2026 04:43:50 +0200
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
Subject: Re: [PATCH 2/6] net: phy: maxio: parse and enable PHY clock from
 generic DT binding
Message-ID: <e27ef42e-a140-4501-b1a8-f1c728eb2ecc@lunn.ch>
References: <20260803101452.2993721-1-andre.przywara@arm.com>
 <20260803101452.2993721-3-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803101452.2993721-3-andre.przywara@arm.com>

On Mon, Aug 03, 2026 at 12:14:48PM +0200, Andre Przywara wrote:
> The generic PHY DT binding features a clocks property, which describes
> the clock input to the PHY. Typically this is a crystal oscillator, so
> it works without software interaction. But some boards want to save some
> pennies on that part, and let a clock fanout pin from the SoC provide this
> clock signal. In this case the PHY probe routine needs to enable this
> clock explicitly.
> 
> Look for a "clocks" property inside the PHY node and enable that clock,
> if one is provided.
> 
> This allows boards with a SoC-driven PHY clock to use the PHY. Please
> note that without the clock enabled, the PHY will not be detected on the
> MDIO bus, so the PHY-ID needs to be explicitly named in the PHY
> compatible string:
> 	compatible = "ethernet-phy-id7b74.4411";
> 
> Signed-off-by: Andre Przywara <andre.przywara@arm.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
