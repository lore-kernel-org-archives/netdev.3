Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424E52EC0A1;
	Thu,  9 Apr 2026 14:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775744302; cv=none; b=CFVbVxE/xaAoufafeWBbO+/ylyIGMVwUjtYtfoJEycSO+1GSzYXEQRksmpgAGyGAeKtbmAF211jk7H3GvfriiIL51z+pcOjGCVPbfaCPFDUSQqBx5T2vlTU0CJN3ZQPvTCgHnWa4EWhRRDTcK1DvbEGkOfmxCP2CDqqmKE5JzuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775744302; c=relaxed/simple;
	bh=4A4ZuHU6Mfrc7kiPscqSplixiIxt4GUsIMH6c85gJqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ijvSODmuOnvOhphL5/wpzkM3zN7gTl3cBV4id7On+8nfBvi0Q3dWprjMcLT52Ci1WB9i1hh0me4fFQkx0rNO7RIOa11xtVp7WeRFSxdFIpHI53P2+68JG/XBqj7RB8SYvfwOLNZRsamWjvaRzmeUMmNXmGTXnPK/ZgGtxERJHF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=QeO4WRSC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="QeO4WRSC"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=AWCmcAsUvdxFHWsEA6Yf2MTwRBpfB9ta9uOqjx83LSo=; b=QeO4WRSC259SUATPde7ZPqvUzK
	AcnJvyz0avM5rEXwhAMMDCeVXhoi0O9ScfYU1rVHkrUIttFD2EVzMWQME1O4jpfh5hDHH9zy0/FDh
	GuRi46j9nOV5aBZG+bB7L92PnUeCpiam0UNZJhivT4wr6xhkHwFjF3nJ7/mA4TYYa0E6q7N3TRjl5
	JYBGvHarxHoBbEenky+rC/WLE7erlcUzeom25u6XCqBcZho9eopgtk34FcA/ecaDHgwzXvj6d+vzf
	SjF80fr8Xsb5Y7GRJviV+EQ3KyWFnXsP4IbtAKVpsPeoiG0DREmh7x9IXO9RBuimh/yShuHPZXuBD
	2RBwQfJw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40162)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1wAqD1-000000003hU-18Ip;
	Thu, 09 Apr 2026 15:18:15 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1wAqCy-000000004Sq-0dYN;
	Thu, 09 Apr 2026 15:18:12 +0100
Date: Thu, 9 Apr 2026 15:18:11 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Charles Perry <charles.perry@microchip.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: phy: fix a return path in get_phy_c45_ids()
Message-ID: <ade1I2o3lc-iH5w9@shell.armlinux.org.uk>
References: <20260409133654.3203336-1-charles.perry@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260409133654.3203336-1-charles.perry@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Apr 09, 2026 at 06:36:54AM -0700, Charles Perry wrote:
> The return value of phy_c45_probe_present() is stored in "ret", not
> "phy_reg", fix this. "phy_reg" always has a positive value if we reach
> this return path (since it would have returned earlier otherwise), which
> means that the original goal of the patch of not considering -ENODEV
> fatal wasn't achieved.
> 
> Fixes: 17b447539408 ("net: phy: c45 scanning: Don't consider -ENODEV fatal")
> Signed-off-by: Charles Perry <charles.perry@microchip.com>
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

Note: you don't need to resend just because you've received another r-b.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
