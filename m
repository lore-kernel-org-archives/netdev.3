Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69187202997
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 18:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773513867; cv=none; b=LJtQ3qr/6GlwqCjf35AKAriXuPg5wRPL6UdJ+SpIAj3duYJpiR1d8XFYoFFSWrkr1bpqsGjTPz2NUUD3juwhHbhFtM831sLnD1kq/8CinFWYS5WJaf6NnbZ3LgfQi0HeMnX0iod/6EuWtWNUT56PN2PkaxVyRTynW5UYbLRZO6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773513867; c=relaxed/simple;
	bh=xbcM82RVr3yDUQlakbEdsCYZgEdnC7asCnHIpw0vaRk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YSLhl5JVpGK9t83UdSBDaqdAojnrMo/y03pkDPsObF8TjuWJuIpVqKCxZKqsX/RYHnAJQI/WCn3EhE77V0KuR3cHVRrg5CAnvhscf/lhhgOHgaCLgqXmsAgSqbDzTMXNfxkURxyaIq5VtRxRD8vSjIXUpOW1mwUBMtbGgomOB9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=IPLnu5VZ; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="IPLnu5VZ"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TJXDOAuibrTACPFJ3gdjAYh5dbMS4QxQVjJNGrVmr0o=; b=IPLnu5VZ1CAdIU5GB5g/Hnmhug
	s60qZYxorCKslsE8hFzZ0E7qXflq7dcOGeml53EG8J1cW5MzmvJn9y+anEaI9qTH/vvkb7KSYLMtf
	LpIft26AG/SK5O+XdQ9nfqXgE+zHLpN2wLI+CE7/qdLQuH7la7IlifUI96E177OXnQlXZd4Dvqzhf
	/ZLo7KDtjW/Lw6shHB0L2s4FqH7UvpLEo3ywI7cfXYqS0y59c+apj/TQVJPcDApzrQeDTZ2j8eljl
	ZUJEUc3xv09gioNtK4uM3668fJF9z21BMvEdhdqk9qswhfafoq4Pw7UuEKNfuuA8gQbZP9kPm7y9H
	Oihs8TXA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:46488)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w1TyD-000000002Ny-276D;
	Sat, 14 Mar 2026 18:44:17 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w1TyA-0000000010B-409f;
	Sat, 14 Mar 2026 18:44:14 +0000
Date: Sat, 14 Mar 2026 18:44:14 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next] net: stmmac: avoid passing pci_dev
Message-ID: <abWsfr7XZE5zFulv@shell.armlinux.org.uk>
References: <E1w0evI-0000000CzY7-1fyo@rmk-PC.armlinux.org.uk>
 <20260314094423.6a908938@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260314094423.6a908938@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Sat, Mar 14, 2026 at 09:44:23AM -0700, Jakub Kicinski wrote:
> On Thu, 12 Mar 2026 12:13:52 +0000 Russell King (Oracle) wrote:
> > To avoid unexpectedly exposing the device name through ethtool where
> > it wasn't provided before, add a flag priv->plat->provide_bus_info
> > to enable this, which only dwmac-intel needs to set.
> 
> Seems fine, but maybe as a separate patch we can expose it for all
> devices? Is there anything special about platform devices here?

Apart from the obvious UAPI change, I don't think so, and I don't
know why the driver hasn't exposed it for platform devices as well,
other than maybe nobody caring about this.

If there's no objections, then priv->plat->provide_bus_info can be
removed and we can expose dev_name(priv->device) unconditionally.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
