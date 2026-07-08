Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54F152D7BF;
	Wed,  8 Jul 2026 13:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783515860; cv=none; b=QPhIJl09wEO2U5ziachO6H+oHfR9vXLGx85TGmXXGkcaIFabSvUlY8S6C0d64j4y+RA2572GQfKwJ8dsnP2wrTHc+HaMl4DWSWU2HF7LHO7RgeOSLB8d0v2VJzq5W0Uy7Sb51B7f5SfCpKLE/ZhwGQLsCxXN5nAdZsup56I8TvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783515860; c=relaxed/simple;
	bh=JXmP3skyaaMi4BY4n7w3R6Ut2ADHA6ulYgIRlMj/YXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLq9HmRMyVDFQ5+7l1GfIPYrg55o7jf9t46u/EkdD/BEHlHiFhnM69pqaZpkSl4zbgXCrY5bMuKNuIfZUbWQZg25lBPWICz6ZHrjkU05jGiug/2t73WRG+jAIRkr3cpZz4fmQHal/kqd7NH8OfGunBWFLQ8n5KXHYnVc3/QrYeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=VgX5Gph6; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="VgX5Gph6"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=mD6KjjgfwpBL/g4vGVwQBgC2tYhaN/n2+ryjbjSF3IE=; b=VgX5Gph6KJX3vRkpfoOfuxI5i2
	lQpOQj9FSVs6D/+Q9WgxnbK7Iu3P83HgnMCKKfd5qJuaRoNj4CdDir5oiYWeLwnjwIW6CD+RATm10
	yEIqVJBuJoIjSxiqKXjELd89Dda5CqdnBGpdC8e3KHu2yqmLWbZtXV6ZhML2K5m/Qb/0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1whRwY-00BJt8-OC; Wed, 08 Jul 2026 15:04:02 +0200
Date: Wed, 8 Jul 2026 15:04:02 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Ben Brown <Ben.Brown@alliedtelesis.co.nz>
Cc: "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Subject: Re: [PATCH] net: phy: marvell: Add soft reset for 88E1510
Message-ID: <0c9c5fe2-6b91-42d2-8582-80f9a47df827@lunn.ch>
References: <20260702225034.1062457-1-ben.brown@alliedtelesis.co.nz>
 <3536a59f-405c-452a-a7d6-359c0ea1b151@lunn.ch>
 <c0d760ff-fe66-48df-bd9f-3226dfdc97fc@alliedtelesis.co.nz>
 <3c493e6f-b5d8-42ed-a752-fdce6452926d@lunn.ch>
 <c77dd281-9ae2-4634-a670-bd6c70afb3df@alliedtelesis.co.nz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c77dd281-9ae2-4634-a670-bd6c70afb3df@alliedtelesis.co.nz>

> > Lets take a step back.
> > 
> > What sort of reset are we talking about? Software or hardware?
> > 
> > 	Andrew
> 
> It is doing a hardware reset using a GPIO line.
> 
> When linked down the phy gets put into reset using a hardware GPIO line,
> during link up the phy initializes the hardware using phy_init_hw(),
> which de-asserts that reset GPIO. Then trivial setup is done before
> the driver specific config_init().
> 
> When we are doing the marvell m88e1510_config_init() the first page
> write is not applying so it ends up writing configuration to the wrong 
> registers. When testing fixes adding a 15us sleep before changing the 
> page also meant the page was updated correctly.

  reset-gpios:
    maxItems: 1
    description:
      The GPIO phandle and specifier for the PHY reset signal.

  reset-assert-us:
    description:
      Delay after the reset was asserted in microseconds. If this
      property is missing the delay will be skipped.

  reset-deassert-us:
    description:
      Delay after the reset was deasserted in microseconds. If
      this property is missing the delay will be skipped.


What delays are you using?

     Andrew
