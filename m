Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44B8926ED48;
	Mon, 26 Jan 2026 14:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769437179; cv=none; b=TqXAqK9WUYj7XKehb2RBeWyIi9IY/9iUCwtzSGalrDnxJJp0cfjN3LUzbtZzCiqE3p2bFFlL+TKhpp2hi57+cZC4DzEb4z0twfAyuk1kJeIM/UJTTW/JSZ/I3rh8Pzn8F2sXHCJlWQeBQbhxpxHyBvBL/Iyo2Fq+xao+x6cxf4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769437179; c=relaxed/simple;
	bh=TpXsK9PxZwF5zKN3fZnpr8hLh2orNQ0NO1kdz6hQzAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BdIG+1kMdplNnAaXiEBtCYEghh+NebezVTHkWGzzo9SmUCJ24+ZqxJ5gudJIfVTo7tcZrV0vjuTchuzWHBDDdpb0lHlYj/OXkYE+Ar1ZQIcZa023kH95DZI5FM6Of9WUvkgv9xllj5mwa9I9fwoiAUdGdouzpu8jDFcH7vsjAYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=XRPM2Bej; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="XRPM2Bej"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JYp6VjePq5rB6Ftk12Ly1P63222SqpOZPLpSzqrkD1o=; b=XRPM2Bej1SvDsHmJgqZ7ExwB2I
	KNuBBv4covc0AJegtOLHzZwVS58k3nM3Fk77fzKUIhEDGRtZG5vM4mQA7uKDso3JcciZGyY8bq7wE
	JVEi30tdn9+gGlwzBbFIXrDfgGHhDOYQ3WadVX0tAtRzbqSgl+19Sn1tjTCLKE/whGKvp1llM8cKN
	SsG+bQvFht34vIhaZgCDAThDSpAzNbGchwBbmJcYKkP47gw/wQSux+J3pYbMsDaYBLe3fVr0xUjmk
	CORawtmonsTTCQD4cTxyg3+o1DwARi8wvBsmcyi9VBi9qK+HJvQ2oAyTNrHJKasJEzjKfUWZikZTi
	DJ10lGaA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:49008)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vkNR6-000000004vz-32Qn;
	Mon, 26 Jan 2026 14:19:24 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vkNR2-0000000050i-0y6m;
	Mon, 26 Jan 2026 14:19:20 +0000
Date: Mon, 26 Jan 2026 14:19:20 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Wei Fang <wei.fang@nxp.com>, hkallweit1@gmail.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	florian.fainelli@broadcom.com, xiaolei.wang@windriver.com,
	maxime.chevallier@bootlin.com, quic_abchauha@quicinc.com,
	quic_sarohasa@quicinc.com, imx@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: phy: add device link between MAC device and
 MDIO device
Message-ID: <aXd36DCR4n37Uq7S@shell.armlinux.org.uk>
References: <20260126104409.1070403-1-wei.fang@nxp.com>
 <2344001a-08c4-42f9-b4e6-116e39fbf1a3@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2344001a-08c4-42f9-b4e6-116e39fbf1a3@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Jan 26, 2026 at 03:13:26PM +0100, Andrew Lunn wrote:
> > The commit bc66fa87d4fd ("net: phy: Add link between phy dev and mac
> > dev") has created a device link between the MAC and the PHY if the MAC
> > uses a shared MDIO bus (The MDIO and the MAC are two separate devices).
> 
> > Sarosh Hasan tried to change the DL_FLAG_STATELESS flag to
> > DL_FLAG_AUTOREMOVE_SUPPLIER to fix the issue [1]. However, the solution
> > does not take into account the hot-swappable PHY devices (such as SFP).
> > so when the PHY device is unplugged, the MAC driver will automatically
> > be removed, which is not the expected behavior.
> > 
> > Therefore, to solve this issue of the shared MDIO bus, we create the
> > device link between the MAC device and the MDIO device, rather than
> > between the MAC device and the PHY device. And when the shared MDIO bus
> > is removed, all MAC drivers that depend on it will also be removed.
> 
> Shouldn't there be a full chain here? MAC->MDIO->PHY?
> 
> For the case of the SFP, maybe it should be
> 
> MAC->SFP Cage and I2C MDIO->PHY
> 
> So if the PHY inside an SFP disappears, the I2C MDIO bus is
> removed.

That's a crazy idea. The SFP cage driver handles the presence of the
I2C-based MDIO bus, and has to because the type of bus created depends
on the module, and the lifetime of the bus is determined by the time
that the module is plugged in, not whether there's a PHY present.

If removing a PHY on a MDIO bus results in the bus to which it was
connected to being removed, that's utterly stupid, because that
means all other PHYs will end up being removed when the bus goes away.

Consider a MDIO bus that has some independent PHYs and a DSA switch
connected. Do we really want removal of the PHY to destroy the MDIO
bus, and thus also take out the DSA switch?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
