Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA012E738D;
	Fri, 24 Jul 2026 15:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784907374; cv=none; b=Ks4KeMw6SW1ODlqxDIv8SmGaNF2feJ880DF1ZZViFspkP/ky9eoHU4VAx0zqmRU0+9fOJrqLInXR6IV5i8HT1sAlz0mYGY+GOEzOD1RDFnR875aJ1QbFqeTD0Vmcs32b8TK39zFOfTbS/JMZ3sf5t6MRwOxZPtz3nZD0ecSa0A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784907374; c=relaxed/simple;
	bh=f3+vC818R5xkommvddVXwvo73Bpix9I7sjScboY2iPw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bKWc2364xRvNWA4RxVPYUciCZHesRlX2vUWI1gnYoQwveeVGDLIfvHeBKUCTfr83hqLBYNMG+h6XgFUt+QUlT+gM5Fj9Ssc6LPmYG5/k7y4NN+mMkJBp8OtbeC8gUCqrHj/msh/vDjqP39LjNkKrNFUkzsZ1mR2b+7y7DzzUUY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=ZkVX50U0; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="ZkVX50U0"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AVDyZDKPCuizFwxSRPCBuoMBJnyBbe/mVwwAs++lu4c=; b=ZkVX50U0nCtHP4IRIyp0sT5mgG
	cWa/hp6r7HOoLSmqOySxlSGk70E+iqE6Cp+sNs/5T7ceKUs6YBfnYNy/wF4VLVl1rXCXfDiQupQbs
	j9Nr6BS/7hX4b7vzYHP64+C0NoM4OAi4815bndF5PfBLqSYJDdICZWoudi79EQsYKf38=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wnHwL-00E19n-Nr; Fri, 24 Jul 2026 17:35:57 +0200
Date: Fri, 24 Jul 2026 17:35:57 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 05/13] ax88179_178a: Use phylink in
 get/set_link_ksettings
Message-ID: <6042ea40-376c-43d9-97ab-13243b946a50@lunn.ch>
References: <20260724-ax88179a-v3-0-bdde4f905883@birger-koblitz.de>
 <20260724-ax88179a-v3-5-bdde4f905883@birger-koblitz.de>
 <0327f4da-a443-4500-871e-ef561bbc9281@lunn.ch>
 <f66c5d19-fac6-459b-b3d0-354893258073@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f66c5d19-fac6-459b-b3d0-354893258073@birger-koblitz.de>

On Fri, Jul 24, 2026 at 05:06:07PM +0200, Birger Koblitz wrote:
> 
> Thanks for reviewing the patch-series, Andrew!
> On 7/24/26 15:38, Andrew Lunn wrote:
> > > +	if (data->phylink)
> > 
> > When did this appear? Am i missing a patch somewhere?
> > 
> 
> In [PATCH net-next v3 02/13] ax88179_178a: Add HW support for AX179A-based chips:+	struct mii_bus *mdio;
> +	struct phy_device *phydev;
> +	struct phylink *phylink;
> +	struct phylink_config phylink_config;
> But admittedly, this is a rather big patch, which I was unable to break apart
> due to in particular int ax88179a_bind() referencing most of the rest.

Ah, sorry. I took a quick look and assumed it was just adding new
devices.

Does it make sense to do the conversion without adding new devices?
That might make the patch smaller.

But i know converting to phylink often is one big patch. Sometimes you
can do some refactoring first to add helpers, but not always.

      Andrew
