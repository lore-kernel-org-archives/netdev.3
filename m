Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569BF2EA173
	for <netdev@vger.kernel.org>; Wed, 20 May 2026 01:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779241379; cv=none; b=UGC4RP9Lh613lLUUVQ9Ez84D0GiIr8qEliCvpaMnByBfXECuA8e3SScZlvfDLBH910LleOKEOHGUQTV7BtofF4cFQGF9grxSU1UMTd6vtFlmwvERxDvcV/cuAoc8H5113stwdYu1KyH0m93BehLhtCNfVVSRB/L7wkcJ8oa8yso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779241379; c=relaxed/simple;
	bh=PdhaT0ubVsqOYRHBTCDGo5ORHCvLcaGvwG0rXj/+06k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p0SHym3YFJUcky7hBOsQIhvbLL+WA8ZIOC8Kiop2TBnU+85mXbRzPudy8VrZbI8jg9crs2CFoiIFjHAEYy6V0GPo3f7xC7JO8HLi7CjIWGrHAahrkpWnSivRLHNC5aniaTVEHhJ+v+qsVqXqwiQeo502Rv8bXMg1IlW9nqzHSC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=q1ytBg52; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="q1ytBg52"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=R2W75KT3KTm9jbc7uZbaII6tAFYHP5USfGcUSXCiF7Y=; b=q1ytBg52QLdnuOrPBqT1Gu8LCo
	LFTv/9zooaddGwSJb0NkJ0hdETctBFsLA5bdwO40OtxKDsYoE6giQCgNEJq8xDoJ8+d8F5a8iPviy
	jPufhYc3BEAZwW0SXUZu0U1RO6W9hJH6lfUoWel/AR9uwzf+mQgPQEo3sJr7wfppf794=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wPVxM-003l5T-Hv; Wed, 20 May 2026 03:42:44 +0200
Date: Wed, 20 May 2026 03:42:44 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Markus Stockhausen <markus.stockhausen@gmx.de>
Cc: Daniel Golle <daniel@makrotopia.org>,
	"hkallweit1@gmail.com" <hkallweit1@gmail.com>,
	"linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"chris.packham@alliedtelesis.co.nz" <chris.packham@alliedtelesis.co.nz>
Subject: Re: [PATCH 3/9] net: mdio: realtek-rtl9300: Add ports to info
 structure
Message-ID: <87c64246-5f3e-44d5-8d62-6778c771e83c@lunn.ch>
References: <20260519165747.1288903-1-markus.stockhausen@gmx.de>
 <20260519165747.1288903-4-markus.stockhausen@gmx.de>
 <agydm8V25M-jy5o6@makrotopia.org>
 <85d5f162-8999-43d4-b879-6e5e686246f7@lunn.ch>
 <01d801dce7c2$a0a08ba0$e1e1a2e0$@gmx.de>
 <fff19211-a41a-481d-a6a6-4429a6901129@lunn.ch>
 <agzoaMnmeVpjiFC0@makrotopia.org>
 <82214c5e-23d5-4615-b2ae-81985fb573f8@lunn.ch>
 <10121615-6F47-2A48-825A-0AC1E0C0F0C1@hxcore.ol>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10121615-6F47-2A48-825A-0AC1E0C0F0C1@hxcore.ol>

> > Do any of these MDIO busses appear on the 
> > outside? Somewhere i can connect an 
> > external PHY, or another switch in cascade?
> 
> Yes. See 6.14 in datasheet [1]
> We even can disable/enable each on RTL931x

So how do you handle that this external PHY is not for a port of the
switch? It is for an i210 hanging off the PCIe bus, or a USB-Ethernet
dongle? Linux itself would have no problem with that.

	Andrew
