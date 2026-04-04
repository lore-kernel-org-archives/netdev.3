Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5831A2BF3F3;
	Sat,  4 Apr 2026 06:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775285048; cv=none; b=PNbQBGONF1X41dh3dUOGTcd8ce+2EnEXHVNqT8GWIIZxtEIa3YkvtCfUxNyOgOe0XmD0iYBqDj7MJ5TTrX00ziz4BRorNnz61uGLbxN3JKfj3P7pI+DWbFj531F+e/5KwVs7VLf0y1n215fzasVi3uDmCvx8hhqgNTIONWBffmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775285048; c=relaxed/simple;
	bh=x05nqRjEHWLQWzEHMCjY0tDYnNv1SSdoVNj88zDSeT8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fMYYqahRih40V5yRQu8USAP4R1ClgXS74y++C6h8CyNlFTzY11tXvZjHD/0nfCDzLGDRYTzv/6KUit2esBWx0vJz5lnPAXkG+PXFTA5QA24oD0fWi+TvWiuxZg6xj8Q3NrhPzhBNgwKOkrK5YiWfZpdD7dSB3/9kPfkB1gg9QFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=a82YAwe8; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="a82YAwe8"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=UQiGmN146/W+he3B13Q2MvA5WD+THDjeVeUfvMPP2oU=; b=a82YAwe8Lf7zFmVnbTKAeKAVjN
	wHWGepxXj0SYalczmGxrWCwrunXiAW4kdvdRoT0EM5e8Nu6pYJDQBTdRyw+YRWZb6H/bMAunLMnvo
	97kwe+JFfTLE9Bz50EuvXrynH2GxCxrgcqmNpc9GngQON2Vblge1Cu+llEPYaoF5Hgi3lid5TxoNU
	/s4sDe2e9iPAKZUURS4mcYMsa2+kDAjnvHa/8tSfUEMLTQmoG0SzHcR+PNp64dg2Ci6nhhXu0GvtY
	4ppu5sYPRNRy2zzLqrKSsU4Qr0Z8PEH3CcuYzb/zkAqqT1HwDH7n6JmroUD70TMMjYLYPd5dpklh+
	P684iFfQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:42770)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w8ujh-000000006LB-0Hez;
	Sat, 04 Apr 2026 07:44:01 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w8ujc-000000007Za-41FV;
	Sat, 04 Apr 2026 07:43:57 +0100
Date: Sat, 4 Apr 2026 07:43:56 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Nicolai Buchwitz <nb@tipi-net.de>, netdev@vger.kernel.org,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next 1/3] net: phy: add support for disabling
 PHY-autonomous EEE
Message-ID: <adCzLJFP7M2MFW7t@shell.armlinux.org.uk>
References: <20260403090656.733985-1-nb@tipi-net.de>
 <20260403090656.733985-2-nb@tipi-net.de>
 <fcf80c9b-de04-469f-b66b-b39760fc9af4@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcf80c9b-de04-469f-b66b-b39760fc9af4@lunn.ch>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Fri, Apr 03, 2026 at 05:27:33PM +0200, Andrew Lunn wrote:
> > +	/**
> > +	 * @disable_autonomous_eee: Disable PHY-autonomous EEE
> > +	 *
> > +	 * Some PHYs manage EEE LPI autonomously without forwarding LPI
> > +	 * signaling to the MAC.
> 
> My understanding is that LPI is always from the MAC to the PHY?

It's bi-directional. The MAC sends LPI, but it also receives LPI from
the PHY as well.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
