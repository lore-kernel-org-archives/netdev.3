Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2004E41D4D6;
	Thu, 24 Sep 2026 19:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790277667; cv=none; b=n3YoMBrn26+Imod1dML/2TFb/AxuskVHdGfURsIakCP/DaDOiIQs9AntsbQepOVDrYYpSiafWOAbE6b812cNZteLKulQ4BUA8JiqdMD5b0CLBzAwGA/o1Bhvju8yIwA6cNJOIL3oRexeTDK8JKuleB9m5KBUB50qH1VzrOSq8fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790277667; c=relaxed/simple;
	bh=LNxq4aWGrayX+acmdcjGo6pLPXqLqS3ooYkiAVvrr4Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y6iSdl1/34YKjg43FVMT2TBzg4lyGpjF+O6SrOa4G6XAn8Oc/riFGZLcUMF4tLXeXnsyqLmq6VlParhdPUtohkDvGooUiWiuNchvNYRf9gLpddeet6IIjE+0CzHohAXcl5NVO2879Y1WQLQR9jgWYwfSStSCN6Dkz+VrZkRSCFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=CEvtyGGo; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="CEvtyGGo"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=JRGUzJeAb9373dYG2Hcp/JcBsDkM9zpmDHUjB+AWXQw=; b=CEvtyGGozT1cpLrf5J+sfocgaG
	3jHtrd4MEoFk9qxps9Iy8XDJNnjZLbLs14b3c2YwTaALdgapGGTikiF2/8rSSLdbE0m4QfbDA1HaF
	AwjdAcmcRe+sqxlYI4v53uZsmd+ZGdSks2W6ofgY2RqJ29BVOXO1Q7VUU9ot10jpEbWo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9p04-0074JW-Aa; Thu, 24 Sep 2026 21:20:56 +0200
Date: Thu, 24 Sep 2026 21:20:56 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: phy: marvell: add support for PHY LEDs
 polarity modes
Message-ID: <7bfb3053-bece-4f0b-8997-0c84f46f724c@lunn.ch>
References: <20260923204614.471409-1-olek2@wp.pl>
 <ac224909-5f7d-447e-a0f9-be0d1565a700@lunn.ch>
 <a174b2c7-3778-4f8c-be5a-2bd94bfe09ed@wp.pl>
 <c9c0e770-6bea-4acb-aca2-ac56f044ddef@lunn.ch>
 <faa87607-4be0-49f6-aafc-a37b3d9a237b@wp.pl>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faa87607-4be0-49f6-aafc-a37b3d9a237b@wp.pl>

On Thu, Sep 24, 2026 at 08:43:36PM +0200, Aleksander Jan Bajkowski wrote:
> Hi Andrew,
> 
> On 24/09/2026 00:54, Andrew Lunn wrote:
> > > The number of LEDs depends on the PHY variant:
> > > 88E1112 -> 4
> > > 88E1116R -> 3
> > > 88E1240 -> 4
> > > 88E1318S -> 3
> > > 88E1510 -> 3
> > > 88E1545 -> 4
> > > 88E1548P -> 4
> > Ah, i had a quick look at the current code, and all the functions have
> > a switch statement with case 0, 1, 2. So i assumed that all PHYs have
> > the same number of LEDs.
> > 
> > So any PHY which does have 4 is currently not supported?

> Correct. Although some PHY variants support 4 LEDs, only three can be
> configured via the LED API. The fourth LED can only be configured via
> the 'marvell,reg-init' property.

'marvell,reg-init' is deprecated and should not be used in anything
modern. The code should be changed to support 4 LEDs when 4 exist.

	Andrew
