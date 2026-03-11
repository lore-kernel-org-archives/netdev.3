Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B1C63009CB;
	Wed, 11 Mar 2026 19:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773255960; cv=none; b=IgVWjTIuUjr8AmeVGKFtSDAGZVxC4ynWJ2062zUH81Dw1BunfISs57ADQVfiAqUK6YNlwK1me5siWBSmRLRJmKP0LHU972zI1Aev6tzLI2HVUNRyxG+xVRIoydJTkCMArmWGTY+sQab5FevjQX9w/hHP2NAc8vEdKnU0p7jIpDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773255960; c=relaxed/simple;
	bh=vp9EBnA90pAuNfzdkQ/1NTTq+tBucUNTIT8s+GHJpO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XJUllWjBo/lC98o4ljRTLAUwLQWwB7EICd0FROOIzbPwGKD8fgU8wnZXhTLLVCBjQaoh1Ek13UyaLeHYwx/KOQ0OlpmAQlECfMdclBU62HD9ZIXwk+Vvp+ZhFaCDZoOUaWenZ9Sc8Outg849QRfryJCigcGfoR0CNgD5Pqvknto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=S7ZDfcEr; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="S7ZDfcEr"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=5gRxnZD8U/5ckRzWr71ozFSAJCluHjpENwN4p7JUM2o=; b=S7ZDfcErva4VvLRf6BJtS+bE71
	V+CUHd/1dULG8mhX3qBVhVH9/n2BIn9oqGtazTrBGbOdDrjowC3KwjL1gm/WyIOjGdzkKL8sNomh6
	ouYz7m3ufNA6xwPa+cS/bdLmsUIXWML/zxqj15KxOWtZqFgYHXb21tYCUVKkayZ9A8Gw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1w0OsF-00BDzA-CF; Wed, 11 Mar 2026 20:05:39 +0100
Date: Wed, 11 Mar 2026 20:05:39 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: Handle PHY reset during initial PHY
 ID read
Message-ID: <5f8e32e1-c73c-4a3f-a1ff-21b78f764bfd@lunn.ch>
References: <20260302144458.3180702-1-wens@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260302144458.3180702-1-wens@kernel.org>

> This work was the result of Russell mentioning [1] that placing the
> reset GPIO under the PHY node in the device tree might result in it
> not working.
> 
> I also talked about this at Plumbers in Tokyo last year during the
> Device Tree MC. There a few people mentioned that MDIO reset handling
> has been a pain point.

It is definitely a pain point. I wish we never added support for
resets, just left it to the bootloader to get the hardware into a
usable state before starting linux.

Anyway, i don't really see this being a MDIO/PHY problem. It is a
generic device driver model problem. We need the core to have generic
code used for any enumerable bus, PCIe, USB, SDIO, MDIO etc to ensure
the clocks, resets, regulators, etc are in the correct state that the
probe can work.

Once the core has this facility, we can modify MDIO to make use of it,
if needed.

    Andrew

---
pw-bot: cr
