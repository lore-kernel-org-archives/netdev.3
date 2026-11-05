Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793879959;
	b=o5Pp3h3YOPfO4Kphch1lP7JadJ4wSyrgv+OyWWcauR5sL1yh0dv0OR5/1/Lj3g61raGS
	 pLFDSVIh10fdbgr/rYI1WMvrVqbIeatU/suD5by37v86+qZpuzGs4BaC7cijd38zJqPzQ
	 XuLCmenpcwTt1zDO9jZrDBx+ChsmjnwMHgBUfBKgAsOpjFyvXLKgzQBCnRzQTczGifxck
	 Va3SALqiJ3b54m3NfuwEdnTGQdi6h3ItOMOo4q4gd/GThn1U892vDehYrBuQjKaLg5FYj
	 rEZN6uyxH0KJu4DWFKegdX60qL+Uk1w0d4fNUmPBJUPUq6Joih3miI47/UoLmfj/pdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793879959;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=6UOX2DdtJrEU9Vfm428FmoY98pTrRMr9bz6LvGWRSeM=;
	b=RSqwGIzsvv9QfK4z7B21Dv7/Rr5Q8ZJlOMe8tHQFJ77ltSaCRN799K9ShADi5NGDVIwW
	 BQJhw9mYK3ZM3iU8g1Z6GDGiozEJlbQQqCIb7S8/rpVOuLhi0lJR+NDT4ISewKSnoVcIv
	 yVrkzhJ7r22avKJCDr3jZuRBxAFk2mcqyTDn+0D7OTCH351xWMsH40+dYmtrDHIX57eSG
	 FnHH6hcQlThZLROnyN55+dkeA/BqEPClmCrknH4CF9re1IDSwy9nl/4N6nTWhZKjzEuLp
	 duYmhAFlXpTBTDA4nz/8fCmbJb9aMk7jFEVWk6oFn1OvLGeTjHoW2J+7byRz26qUSZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CMTnQiZE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CE8606A31B;
	Thu,  5 Nov 2026 11:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CMTnQiZE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F34661F000C1;
	Thu,  5 Nov 2026 11:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793879958;
	bh=6UOX2DdtJrEU9Vfm428FmoY98pTrRMr9bz6LvGWRSeM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CMTnQiZEHB8VGiHag//9SCZTqU7XxMN8Zp8GgEWEQHnzpJubbUgxlZ0JkKRg0KM7L
	 6dYGCpe8etRHnmKGmF3maBVUfbktycJMfxWt6HJfbsX5lfMG3JgkT//xa9aOKMLwKk
	 gMu5KevzQBiS6iWpag3gmSvOBNDfAQDzuEtixI/TVvCNqsOu8z7d4K0SakUwdKYOv5
	 xzVSEivvZ9VKmdZNJPJHYva11xjH2rcieaoejRbaEa/ndplsgXeMzl/fcQheSkyQVw
	 hlaeRzm7BaWhCWDdYs5yuiIAswJbAWZstc9ifLVRq+MiauRSAV+Zy+FbvsR+QSox91
	 4Du1k8g5ZrfZg==
Date: Thu, 5 Nov 2026 12:59:14 +0100
From: Krzysztof Kozlowski <krzk@kernel.org>
To: Jacky Chou <jacky_chou@aspeedtech.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Po-Yu Chuang <ratbert@faraday-tech.com>, Eric Dumazet <edumazet@kernel.org>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue6KaGOiBbUEFUQ0ggbmV0LW5leHQgdjUgMS83XSBkdC1i?=
 =?utf-8?Q?indings=3A?= net: ftgmac100: Make Aspeed compatibles standalone
Message-ID: <20261105-ambrosial-natural-ibis-7cecb6@quoll>
References: <20261104-support_ast2700-v5-0-44057f4dde75@aspeedtech.com>
 <20261104-support_ast2700-v5-1-44057f4dde75@aspeedtech.com>
 <20261104-helpful-courageous-hedgehog-f05bbf@quoll>
 <SEYPR06MB513412E04F4F0AE8ADE0375E9D682@SEYPR06MB5134.apcprd06.prod.outlook.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SEYPR06MB513412E04F4F0AE8ADE0375E9D682@SEYPR06MB5134.apcprd06.prod.outlook.com>

On Wed, Nov 04, 2026 at 11:21:57AM +0000, Jacky Chou wrote:
> Hi Krzysztof,
> 
> Thank you for your reply.
> 
> > > The aspeed,ast2400-mac, aspeed,ast2500-mac, and aspeed,ast2600-mac
> > > compatibles are currently only valid when paired with the generic
> > > "faraday,ftgmac100" fallback: if a node ever bound through the generic
> > > entry alone, ftgmac100_probe() would set
> > > rxdes0_edorr_mask/txdes0_edotr_mask to BIT(15) instead of the Aspeed
> > > BIT(30), skip Aspeed clock setup, and leave the DMA mask too narrow.
> > 
> > And device would work or not? If device still works after all these steps above,
> > then why isn't fallback applicable?
> > 
> > Be explicit, because I have no clue whether Aspeed clock setup is necessary for
> > device to operate.
> > 
> 
> It is necessary: ftgmac100_setup_clk() enables the MAC's clock, and
> only runs when priv->is_aspeed is true - skipped if a node ever bound
> through the generic entry. Without ftgmac100_setup_clk(), the MAC on

This part is obvious.

> Aspeed platform would be left without a working clock, so it wouldn't
> be able to configure register and TX/RX at all.

So you are saying device will not work? Then make it obvious that clock
is necessary for basic register access.

Best regards,
Krzysztof

