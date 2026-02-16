Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553481F2BAD;
	Mon, 16 Feb 2026 02:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771210498; cv=none; b=Rbuc/7M3owspUBUTmb0HCxST+OYQXMEZtvJ5kg+z3cq09RUCqkkwRFJk4dgNXoD4yzsShLpm7fb7/dmiZm9P/Hl1kwmPdm1XoyvHVV+RsThaDj8nSLNqnz/WQQhCNMXwm20gzlcFfKBFRKiG/G658PAEZNWYztt7qMy+XCp4QCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771210498; c=relaxed/simple;
	bh=dhD2Un/+zWQ8pAmDxdcWf/FiJ5g6Bg7vof+ve3Lz+Xg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nuiViNX76wglfBeLFC5TN766DpG3XpIEMfFukslv8PcIJFPNB98vvigu0EJdwcGTh6LqlB8sggWwv2xY+hYyI9aZJBwopMHZWWr3VuFPWQGKYMkqW1VqhceUJNNFIBckQyJPyKGOvoD6tKc9xq+3lDLWnr6KnKbml6ws8Ym3zpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=0OxRzroy; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="0OxRzroy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=4sMygde8jvR1ZunQ6nd6KSQmtTQBV5/0P7R8gM6T03k=; b=0O
	xRzroysGRNcYGXey1FB3hrLfr2ps6vnvagPdAi7hYnepF+DH+GiV81Hi61P3KurD+gLkDhtVHvVqN
	fPm5BrRxQ/QbWADFC/diQTi1fDtMkcAJC+8Cwdk4r8crlDXZiUDEA86wYAsSdd2b2fsBZ0ROyWeWx
	Ulc5ktfnqH3raQQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vrol4-007Ro7-Fg; Mon, 16 Feb 2026 03:54:46 +0100
Date: Mon, 16 Feb 2026 03:54:46 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Martin =?iso-8859-1?Q?P=E5lsson?= <martin@poleshift.se>
Cc: Thangaraj Samynathan <Thangaraj.S@microchip.com>,
	Rengarajan Sundararajan <Rengarajan.S@microchip.com>,
	UNGLinuxDriver@microchip.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: usb: lan78xx: scan all MDIO addresses on LAN7801
Message-ID: <d5e4a2e9-4ecd-4103-9537-74fbb58692ed@lunn.ch>
References: <0110019c5c13b668-dd1f5db3-309a-442a-b483-262c4edbb360-000000@eu-north-1.amazonses.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0110019c5c13b668-dd1f5db3-309a-442a-b483-262c4edbb360-000000@eu-north-1.amazonses.com>

On Sat, Feb 14, 2026 at 12:15:21PM +0000, Martin Pålsson wrote:
> The LAN7801 is designed exclusively for external PHYs (unlike the
> LAN7800/LAN7850 which have internal PHYs), but lan78xx_mdio_init()
> restricts PHY scanning to MDIO addresses 0-7 by setting phy_mask to
> ~(0xFF). This prevents discovery of external PHYs wired to addresses
> outside that range.
> 
> One such case is the DP83TC814 100BASE-T1 PHY, which is typically
> configured at MDIO address 10 via PHYAD bootstrap pins and goes
> undetected with the current mask.
> 
> Set phy_mask to 0 for the LAN7801 so that all 32 MDIO addresses are
> scanned during bus registration, allowing any external PHY to be
> discovered regardless of its address.
> 
> Signed-off-by: Martin Pålsson <martin@poleshift.se>

Since you are submitting this for net, it should have a Fixes: tag.

Also, since this is a 100Base PHY, i assume dev->interface needs to be
PHY_INTERFACE_MODE_MII? But it looks like lan78xx_get_phy() is hard
coding it to PHY_INTERFACE_MODE_RGMII_ID for the 7801. How is this
working out for you?

	Andrew
