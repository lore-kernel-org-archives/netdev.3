Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFD83D0914
	for <netdev@vger.kernel.org>; Mon, 30 Mar 2026 12:32:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774873973; cv=none; b=emzLNSRcisdl25xVfKui5D/UopTHxVwzmoSRsW+JIdFO4615QyBJc3tBdLdJxr/HAsbvh/DWA2sZr2EXsiNrTYau9Vmm7WNIDQa7ITZPFAvTAPKzYyjFmWAemuAtU0RfGUEbpyH8iYZzdf0e0FdvHUM/Xv7MtmwrkHaD+nlDHq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774873973; c=relaxed/simple;
	bh=qTef9Y3NMxe+o3njNmJimFXzqpRgcjc0hEZwDqJWqPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NjKukYeqD3vGrzYQV8+zpwc686tFX6k4aqFsjRGu8pmaxph1qp3gbGKHSkd2CiTJMBosvi5rL7djM2onpTbvvfso+VQoPA+3B9of+cnKdSp+hiVbd0uV/DoygWvCpolLA2XIclhHn5+FEfAYyFzhyGRjSBn8MntUc9IKMgal6y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=wzSqs23y; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="wzSqs23y"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=x3Kcwxaz4yBp1v+INCmF72EmNBovcjM9LS/BwH6HzfE=; b=wzSqs23ymZRFsB6G+vgPNhRb/l
	aTZ4mEOi+hgwcDuV00wQA6Mj74CCCn5K2OnuZaQY8TehecTJ0K54H7JrJ7Zsp5m7yq/s6v/l28vgF
	JfN2vC95DRI7jGTmwuMm+bomSsbuWBozn5U8DY2ge0P0+dV4NXsUWuevOzk3J2ELO6xPE0HZ8cXo1
	I6ixrCvEtYgeNR9tgah0UgtsMW8SdrVbmC3YLrC8EKiFFObUwjPJ49S4v2rSKeAuayQe3Wksb6H9S
	5ScpsvwzzHwYwIFNYk6ra/chfPE8BAVlcDDz+M2vB2M5B4OKrodAkmll0g4k6tD5SOWbk3sIrzRC4
	wEFiVPkg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:51310)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w7BnS-000000000TQ-2byx;
	Mon, 30 Mar 2026 13:32:46 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w7BnR-000000002fZ-0lGQ;
	Mon, 30 Mar 2026 13:32:45 +0100
Date: Mon, 30 Mar 2026 13:32:45 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Alexis Lothore <alexis.lothore@bootlin.com>
Subject: Re: [PATCH net-next] net: phylink: allow PHYs to be attached in
 802.3z inband mode
Message-ID: <acptbbfTt_FJgms6@shell.armlinux.org.uk>
References: <E1w66jW-0000000E3qS-23fW@rmk-PC.armlinux.org.uk>
 <a5d7aedb-9770-492f-b528-0a28a652279b@bootlin.com>
 <acatrPb1DdHuyVoL@shell.armlinux.org.uk>
 <30a2cad9-fa2c-4abe-ad51-983d70564c7c@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30a2cad9-fa2c-4abe-ad51-983d70564c7c@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Mon, Mar 30, 2026 at 02:26:58PM +0200, Andrew Lunn wrote:
> > As I've recently said, I think we're more or less boxed in between a
> > rock and a hard place because of the hacks that qcom-ethqos introduced
> > with its PCS support. At the moment, I am failing to see any path where
> > the stmmac PCS can be programmed for inband according to phylink's
> > wishes and qcom-ethqos can be made to work without its hacks.
> > 
> > This all ultimately comes back to the half-hearted phylink conversion
> > of stmmac that was done behind my back without my review. Had the
> > conversion been done fully, and kept up with the phylink changes for
> > PCS support, then we probably wouldn't be in this situation today.
> > 
> > Unfortunately, the driver is going to keep breaking all the time that
> > it abuses phylink, and at the moment I see no way to stop this sodding
> > driver abusing phylink.
> 
> "The needs of the many outweigh the needs of the few"
> 
> The MAC driver is used by a lot of different SoCs. If qcom-ethqos
> caused this problem, should we consider breaking backwards
> compatibility for it, if that opens up a path for getting clean
> phylink integration for all the other variants?

Consider something like mvneta (which supports 2.5G speeds) connected
to a 2.5G PHY that uses 2500BASE-X for 2.5G speeds, and SGMII for
slower speeds with inband.

How should this be described in DT?

	phy-mode = "2500base-x";
	managed = "in-band-status";

will fail today, as these tests will refuse to attach a PHY in that
setup, and without a PHY attached, we will never know if it switches
to SGMII mode.

This patch makes phylink more flexible and permissive.

However, as has been found, this patch causes problems for stmmac,
so it needs a different approach, because stmmac interprets an
optional PHY as "we must have a PHY if we don't we fail" at the
moment.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
