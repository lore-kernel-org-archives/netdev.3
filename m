Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794603972;
	b=c3jA+k1A40GJywocc6blxTyaKComSDpSKcl79RCIToqrhZVBa+bTlfPeZtV2YJSWg0Yr
	 Gv9AZnVrg679wAkcIks1jhNE4qzH9VjqZrc03jzf86WW5bIbdaaQRkUoCvFzx2RuVq4HQ
	 wIv+cipMHoXNNVxEr5Ojt9qpon8EDxW1FDq4K+hT4mNexV79eCZZeFsDUXJluNii+xIPZ
	 9ozkmrSHY6nFyGob3E1vfxuLiEJWQsx/NRbQ5H1wetrTBBNW7l9MEaJ1rDAejEOcEJTRO
	 McCKMvsC7EsG1LnzQVsnr+B7EDYGbXRT3aQLBlaRZ5pqvaVJF4zyBo8CmrJbiGR376w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794603972;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=1kXcbvm0z7UiM619s9T7DtZLjsDWfr0JMHsOiwfZJ/E=;
	b=Hq5angGdPrWMTJ7mzalvakLARyVsDCUrXjD2kUdT2Cnc++YXO8duJFOXMj3nW87uiMlP
	 ZYim6XqB9monxox5Mr4SSOJ7ibPXHUTtoFM6UAxzCJruWeU6nb57Nn9xwi0nPVYEqgp33
	 B9vDhLJUuKpY42TIPrm5y9qDl1KnxZT62Buj0qtCj9THkGze9PzclWBE46R3H55JWV3fW
	 5w/hF5eYctXcMKSkO410WKRAngBUC73tx/8RBTqLgr2QAP79gQuqMKdXaBw6OVXs0ZSbF
	 7XZz2Tb4Jl6JvLsjp3DF5FIAK4EafJNpmUpcN8Tss1QCQpYITDzfQhDC2EuIiVHWQ0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=aBchvwHb;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2282606A335;
	Fri, 13 Nov 2026 21:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2282606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=aBchvwHb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=1kXcbvm0z7UiM619s9T7DtZLjsDWfr0JMHsOiwfZJ/E=; b=aBchvwHbNaXOhdjSZx9GbShvul
	tdiw9DRvJ9mDxFyDrAQyXmZFn4n9wHvp5tHczlVFRnXm74D9cWdxR4ZFImsjfwDbJc6M0aJaDKVhU
	oxXAoma6NJl0G6YSgeWIGR/qRMDHYnei31DG00HWl5PO/BC98blWaEo8MU5D7kpo9ipY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xRyT5-00GMcm-Gu; Fri, 13 Nov 2026 22:05:55 +0100
Date: Fri, 13 Nov 2026 22:05:55 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Daniel Golle <daniel@makrotopia.org>
Cc: joseph@telaak.dev, Hauke Mehrtens <hauke@hauke-m.de>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/2] net: dsa: mxl-gsw1xx: reset the switch
 through reset-gpios
Message-ID: <9804b024-236a-4791-aa55-d83a71b2598c@lunn.ch>
References: <20261112-mxl-gsw1xx-reset-v3-0-863e82074893@telaak.dev>
 <a2f45802-b75b-4a19-9508-2d1b5ebe473a@lunn.ch>
 <avcoghKd4CU13QI_@makrotopia.org>
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
In-Reply-To: <avcoghKd4CU13QI_@makrotopia.org>

> I *guess* that in this case the vendor wants to avoid using PHY
> address 0 which is widely misunderstood as being the "broadcast
> address" (which it is, but only in scope of AUI attachments and SFP
> modules).

There are no standard for copper SFP modules, so i find it hard to
accept that SFP modules expect 0 to work as a broadcast address.

> > Does the driver have an implicit assumption about the addresses of the
> > PHYs? Should the driver actually be writing this register to put the
> > PHYs at the expected address?
> 
> The driver does what is described in the device tree. Ie. boot firmware
> applying a non-default PHY addresses should just say so in the DT passed
> to Linux imho.

And this is what i was wondering about. Is it the DT which is wrong,
or the driver?

   Andrew
