Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794084200;
	b=dxz4HxUPLlpxfjAfe+BfwViCFKgmFQiY4rUsn+YDqyZXs60w5LtS+3Mr8CAq8uWTR1Ch
	 KKZUh3BLQCXze8TCkyrkI7Pjqca2ZWwu6NX62SDjdZsbt8YmPXy+e3S2L2LjRb8e4CP4e
	 cX7Qde3AtGR/1vKHXJjkauWEDFycO3YB7BEc0X+pdo3WwYRUya9eT0sG7UnMIbRJKcVky
	 84Ie2o+KqH+d/PC1YYmhUCS79UhKzXr7smpdr5NGhQeElCFpRcaY8wZbI9SUiSJceZzyd
	 ATcwcRGavLqghJuBjaka1ydetSZrfyJdVgLTdW239PgbHE6fmSRX7HyFMqf2HAMFRDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794084200;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=68bp6QK8kEx9w15xHAI7181CGoSCj6CC94TncfB0GEs=;
	b=fG7n6mwvHinviE3TYpbp6pQqzKEnerWchXFMat6kyGAP7tO1a6bXuUObPzFbRg6JHHQ9
	 F3IYhQLALUmXka6MbRip4Q0pOA1b4blMtB2gsnIzkKSOqBlPyh+GU8MlsZg/ToLzgHHaI
	 reIwx9b0Bei9EkKLoTFyvQXPUnvCi5lugYnZgWPe+tbI8u6Q1TvoSJpXB6aPYx3qWnUym
	 BhKh9fNANhaWtVgAbt82/VMq5MuR64+0fE0fajq8vsxnVx51szxWsyoPx+X2egDVkVhgD
	 lHAZfta3p9cSC9Zw4dr+TSUsM9LKtR5woQYUb09mT/5KQZWZ8fEMyE8KOTIDdDKhx+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=C6ixnZmr;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8D1606A326;
	Sat,  7 Nov 2026 20:43:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB8D1606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=C6ixnZmr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=68bp6QK8kEx9w15xHAI7181CGoSCj6CC94TncfB0GEs=; b=C6ixnZmrVhi5lYWRYgBi8GXTnE
	kwEAECAjtMqRKld7xoX4PkzCkX16Xk2SyDpurj8jVbd6uswsvUnuYpQj9yBQ/tIBHUhCWTzwLROqb
	kDEvAh95rSHADslkp3Cy5gofmbolBHo76XF7pRjxhKl3FximtDWDAwGVZk7aJEqclyaA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xPnFd-00F0HZ-8k; Sat, 07 Nov 2026 21:43:01 +0100
Date: Sat, 7 Nov 2026 21:43:01 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Po-Yu Chuang <ratbert@faraday-tech.com>,
	Eric Dumazet <edumazet@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue6KaGOiDlm57opoY6IFtQQVRD?=
 =?utf-8?Q?H_net-next_v5_1=2F7=5D_dt-bindings?= =?utf-8?Q?=3A?= net:
 ftgmac100: Make Aspeed compatibles standalone
Message-ID: <f44dead2-c5cb-4684-ac7d-2f4409af1ab3@lunn.ch>
References: <20261104-support_ast2700-v5-0-44057f4dde75@aspeedtech.com>
 <20261104-support_ast2700-v5-1-44057f4dde75@aspeedtech.com>
 <20261104-helpful-courageous-hedgehog-f05bbf@quoll>
 <SEYPR06MB513412E04F4F0AE8ADE0375E9D682@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <20261105-ambrosial-natural-ibis-7cecb6@quoll>
 <SI2PR06MB51406DA90F387ED0C64073869D772@SI2PR06MB5140.apcprd06.prod.outlook.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SI2PR06MB51406DA90F387ED0C64073869D772@SI2PR06MB5140.apcprd06.prod.outlook.com>

On Thu, Nov 05, 2026 at 12:49:28PM +0000, Jacky Chou wrote:
> > > > > The aspeed,ast2400-mac, aspeed,ast2500-mac, and aspeed,ast2600-mac
> > > > > compatibles are currently only valid when paired with the generic
> > > > > "faraday,ftgmac100" fallback: if a node ever bound through the
> > > > > generic entry alone, ftgmac100_probe() would set
> > > > > rxdes0_edorr_mask/txdes0_edotr_mask to BIT(15) instead of the
> > > > > Aspeed BIT(30), skip Aspeed clock setup, and leave the DMA mask too
> > narrow.
> > > >
> > > > And device would work or not? If device still works after all these
> > > > steps above, then why isn't fallback applicable?
> > > >
> > > > Be explicit, because I have no clue whether Aspeed clock setup is
> > > > necessary for device to operate.
> > > >
> > >
> > > It is necessary: ftgmac100_setup_clk() enables the MAC's clock, and
> > > only runs when priv->is_aspeed is true - skipped if a node ever bound
> > > through the generic entry. Without ftgmac100_setup_clk(), the MAC on
> > 
> > This part is obvious.
> > 
> > > Aspeed platform would be left without a working clock, so it wouldn't
> > > be able to configure register and TX/RX at all.
> > 
> > So you are saying device will not work? Then make it obvious that clock is
> > necessary for basic register access.
> > 
> 
> Yes, the MAC on Aspeed platform does not work at all. Without the clock, even basic register
> access to the MAC is not possible.

Then for this new compatible you can mark it required.

Maybe test what happens if you mark it required for all aspeed
compatibles. Do an .dts files fail the test tools?

	     Andrew
