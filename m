Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4141FF1C7;
	Sun, 12 Jul 2026 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783864211; cv=none; b=E3fIOPLCoL1rSNZt/sJoE39Q5Rkaez/8fqFRPxGsxusRTUiOUPeg/3k+u8OgOzSA852cVYfQPP09HUBaHbx7C2fm0t3xxhwNX7kAguPa0mJVUh5dSMlh+BnfMtivI1i2BTmCKCIm/y5nbk/BORWPb9tCCyuCLgUHuntFfmx3qwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783864211; c=relaxed/simple;
	bh=d1jcEnPcnzVCs1WAGyTkfmji/4DAeVJaukvqVtizUpo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZPHKXHALcfi5l7gZEdOB8m1ooF3nAP8m45cN/dRHBuNAd3SK3ehFlzZyCpQSij54oOW8K/8NtL9v/KcpIUZo4btZoOuvw4epd62MEerTjHZk63RaIHQQTu4Gz53uxvJGhzZ1J+Cq9Kw8UWurDwATztVN9X6Jl0luQiCAox8HZ+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Ok/hkJ5D; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Ok/hkJ5D"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aJQLR1BZeiLOJtrMrJZsDmYK7XktL1Qw34JZsr4WT9U=; b=Ok/hkJ5DV6vMXXo56g9YdXpbOk
	7ywYGl6xicj493JvdcbNXNUxSp8gA+nMZ5XXPPS2bXPXli32bj0R/6lPT+fqiswTmtxTbtjfpLUin
	/lYT6Dz7ruNgsZXQSZAjHXyRLrPFJ8PXLtyEXkQRX03NJRnoD0CvO9gJ2LKiyKLZhGnk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wiuYx-00Bv9D-IP; Sun, 12 Jul 2026 15:49:43 +0200
Date: Sun, 12 Jul 2026 15:49:43 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Inochi Amaoto <inochiama@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Yixun Lan <dlan@kernel.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	netdev@vger.kernel.org, linux-riscv@lists.infradead.org,
	spacemit@lists.linux.dev, linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	E Shattow <e@freeshell.de>, Han Gao <gaohan@iscas.ac.cn>
Subject: Re: Failed to reinit phy of spacemit-dwmac when reset-gpio is present
Message-ID: <8689bf7d-e00d-4097-bd3c-4d7d7844d1d2@lunn.ch>
References: <20260712045233.800748-1-inochiama@gmail.com>
 <bc78469c-3f45-4234-88b0-49f050d651db@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc78469c-3f45-4234-88b0-49f050d651db@bootlin.com>

> > --- a/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
> > +++ b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
> > @@ -196,7 +196,8 @@ &eth0 {
> > 
> >  	mdio {
> >  		phy0: phy@1 {
> > -			compatible = "ethernet-phy-ieee802.3-c22";
> > +			compatible = "ethernet-phy-id001c.c916",
> > +				     "ethernet-phy-ieee802.3-c22";
> 
> Indeed that's merely a workaround :(

Despite is being a workaround, there has not been much progress on a
generic framework for dealing with clocks, resets, regulators etc,
before probing PHYs. So this is probably what you want to do.

       Andrew
