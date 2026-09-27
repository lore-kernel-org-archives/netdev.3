Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E70983E0C57;
	Sun, 27 Sep 2026 19:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790537462; cv=none; b=bF2wjwMORgr23128RvZcaGRm0xT45z90zH3lBQUU/NQafgtwt5K6RhutgrD5ufMuhz0ljgz0gK7t+BZO8xrEft2u/qonbz2WW3MjmM+MjOFakSl5197gH15+e6rUaq9gzCkew8Na4TgwlHrMHosQc6X/qcDbG9ojr9YXaL0IgQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790537462; c=relaxed/simple;
	bh=s5CklLZrT+S7vZWUtUja5Hz0PUvpWoEMCtZIBQJqi1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nV969u/txf/YURSwUzOCamAVL3C4X9KtgCzRGBIQB9OaBfYGpyobtEapa7J+pviEJWcY+ke8QnzgaMkE069HYczaQCHL41qq6oUdPMYEa+hi1V0ZNSjiokGI+A3WdJULXZSN11fl+GSm8605j6aSwZA+Z2AEsH6OZSboyFGFz8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rTnmOxbY; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rTnmOxbY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=dUmekkaLB7pJaNtNJP1pyWK+1wzVpak1sZK828FP73c=; b=rT
	nmOxbY0BMzVeWBuohg3lcYp97UC/9bz9gEbPdlOgaw2BFYXxII9TidLK5+jeyF7hwe5rtIVUPGrZm
	LqOg8R9FnPdlOr3JAxJao5koYnO59ZVqXAPZvZyGh1UFjIIW0atknS1LmzO8840jrtUv89zCzzC9T
	5zYmg3Fck89Pf5E=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xAuaB-007Ydo-IB; Sun, 27 Sep 2026 21:30:43 +0200
Date: Sun, 27 Sep 2026 21:30:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: =?utf-8?B?5YiYIOaYjOadsA==?= <liucj1228@outlook.com>
Cc: Andre Przywara <andre.przywara@arm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Russell King <linux@armlinux.org.uk>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Luo Jie <jie.luo@oss.qualcomm.com>,
	Wolfram Sang <wsa+renesas@sang-engineering.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v2 0/2] net: phy: Add Maxio MAE0621A support
Message-ID: <ca958017-7a32-4a39-bf88-5a82c0869d58@lunn.ch>
References: <MN0PR19MB609154F210DF84DCB29D3696ACC62@MN0PR19MB6091.namprd19.prod.outlook.com>
 <2635661d-4be2-4abf-84aa-c3024941f787@arm.com>
 <2ecfaee1-921b-4d2a-bac3-ce2467b24ea7@lunn.ch>
 <MN0PR19MB609160C34AEEADC6C74F08E1AC8E2@MN0PR19MB6091.namprd19.prod.outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MN0PR19MB609160C34AEEADC6C74F08E1AC8E2@MN0PR19MB6091.namprd19.prod.outlook.com>

On Sun, Sep 27, 2026 at 04:21:50PM +0000, 刘 昌杰 wrote:
> Hi Andrew,
> 
> I checked the schematics and tested the broadcast control on an LCKFB Taishan Pi 3M (which has an MAE0621A-Q3C at PHY address 1, ID 0x7b744412).

Thanks for this testing.

> For the RGMII delays, pin 24 (RXD1/TXDLY) is pulled down (4.7k) and
> pin 25 (RXD0/RXDLY) is pulled up (4.7k). So the hardware straps are
> TXDLY=0 and RXDLY=1. Per Table 7-3 in the datasheet, this disables
> the TX delay and enables a 2ns RX delay. This matches the DT using
> `phy-mode="rgmii-rxid"` and the RK3576 GMAC `tx_delay=<0x24>`.

Unfortunately, this works, but is wrong.

https://elixir.bootlin.com/linux/v6.15/source/Documentation/devicetree/bindings/net/ethernet-controller.yaml#L287

phy-mode="rgmii-rxid" means the PCB is adding the delay, which is not
true. The PHY is. What would normally happen is that the DT would
contain rgmii-id, indicating the PCB has no delays.
PHY_INTERFACE_MODE_RGMII_ID would be passed to the PHY driver, and it
would then reconfigure the PHY to insert both RX and TX delays. The
strapping is ignored.

At the moment, we don't have the ability to override the strapping. We
also cannot verify what the PHY is actually doing against what the MAC
would like it to do. So we can get into situations where it is wrong.

> For the broadcast test: initially, PHYCR1 (page 0xa43, reg 0x18) was
> 0x2118 (bit 13 set). Reading the PHY ID from both addr 0 and 1
> returned 0x7b744412. After clearing bit 13 on addr 1, addr 0 stopped
> responding (returned 0xffff), while addr 1 kept working. I didn't
> send any writes to addr 0.

Cool. Having the PHY respond on two addresses is bad. Linux can think
there are two PHYs. It can suspend and resume it twice etc. 

	Andrew
