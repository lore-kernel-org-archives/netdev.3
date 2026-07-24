Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F14A2B9A4;
	Fri, 24 Jul 2026 17:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784914064; cv=none; b=cG/2Rw/hI3fXH5Bv0XV1YS2Zqgtu2MU/FmPqT7+Zqj6T2F+use1SNeEXnsZsnnvafVa7LLFtayzFtph9ScilxE8xtUoOuwc3qEX+eRVFoVU8iSqiQbXmYGUr2g5zFpB9c2Aq7Lfrc7Voy8KQeYs6+nlO6Dt6H4+0KvqfggwTMWM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784914064; c=relaxed/simple;
	bh=VNBYEBI3coRk9cGz52ouuQpmSVOjBLClUZVqGu29B7c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iPGxOAiHHsZ+D3Jb7VwptoNB/g1Gl9696V5I4jR13CbYfavqrg+4VurV5MFJPsck7OuujayNgtlfB8XpS+oMzuEjtrap4pVrYSQBKUWWtFj+8XNaj8xr8emOoIiEcgsH5+0kSwZuD7oOgOrdhL1dyV+zDv3QzkJRCjOhU57PgPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=cCsaz4us; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="cCsaz4us"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=ro00yatS75JN42IKDzQDRfOkTGnfP3MfRMbok4rG/+A=; b=cCsaz4usQAp8IDRYs1dp6QngoW
	oS1efSy8nAtjNpjxc5qcInDxls65sQzLSpdw0y3m098NyJ1G2AAMhnvbUh0ANseCjjKgFIUa7fVoc
	WDLUNrATL7gUbU7graBPXdJEYEf68DHhcyKecbkHYwyK9qBs++Im87+4unKkgDLfdoxg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wnJgJ-00E1xt-7N; Fri, 24 Jul 2026 19:27:31 +0200
Date: Fri, 24 Jul 2026 19:27:31 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>, linux-usb@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 03/13] ax88179_178a: Use MMD accessor
 functions for AX88179A
Message-ID: <47c17221-c332-427c-ab61-69dd288afcfc@lunn.ch>
References: <20260724-ax88179a-v3-0-bdde4f905883@birger-koblitz.de>
 <20260724-ax88179a-v3-3-bdde4f905883@birger-koblitz.de>
 <6cbd0d83-9802-4e02-ba1b-4cf76cb51659@lunn.ch>
 <7a83bba0-2c70-458d-babc-e54581a2e158@birger-koblitz.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a83bba0-2c70-458d-babc-e54581a2e158@birger-koblitz.de>

> > > -	val = ax88179_phy_read_mmd_indirect(dev, MDIO_PCS_EEE_ABLE,
> > > -					    MDIO_MMD_PCS);
> > > +	val = ax_read_mmd(dev, MDIO_MMD_PCS, MDIO_PCS_EEE_ABLE);
> > 
> > All these look to be standard EEE registers. phylib should be handling
> > this for you. Put a printk in genphy_c45_read_eee_cap1() and make sure
> > it is being called.
> > 
> > Basically, anything which is part of 802.3 clause 22 or clause 45
> > should have helpers in phylib, and in most cases, phylib itself will
> > take care of it. A MAC driver touching the PHY is generally a bad
> > design, a layer violation. So any driver using phylink or phylib, all
> > direct access to the PHY needs to be removed.
> > 
> This is again the existing code targeting the AX179, I just used the
> new MMD accessor functions that target both architectures. I cannot convert
> that with any confidence that it will work without having those devices.
> One would need to write PHY drivers and use phylink to make the mess
> go away.

This is where having a clean, separate driver will help.

You cannot have the MAC driver touching the PHY when using
phylink/phylib. You need to ensure none of this code is actually
used. And if it is not used, you don't need to touch it like this.

      Andrew
