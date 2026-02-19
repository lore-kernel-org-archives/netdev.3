Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057E7347FD9;
	Thu, 19 Feb 2026 17:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771521351; cv=none; b=bJmKnI9UwI6STtT+S952XllRM1EZh7f9NRcFcDj/VB14F9sRnrUkpSZ9d/Gv6yUh+xFkEJBmwZ8QTGXU8yu/ub2sCzvKGCaMElAHeSDn+s4vs+giCpG4gfraVrCjrG/9E7gtJM4IZkx1GcebwhwXJSPPGvkGHluimra51NdCWNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771521351; c=relaxed/simple;
	bh=Z0fid7GKZ0S2gFUwP+qDQ4OUheH2uuuPnnfWCxc9lGM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qwSNrWM+wKS/uPbn8PX4cVIUqY+rLj0YtVptIXtEY+QDPfTeaZaG+h6TXpFAbWBOqUuVGnE20sUjwexdcNWPwiMEdDEZ8BRjKAaNr41xFyhnZohpYVBqdAGD92+5jODoA0yRFqvgrxKjwq0U4gT4Xb5fhyUxk7/1ONdNBykATmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=zQh91pz9; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="zQh91pz9"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cM70OYd11aX43VzlGzqVVTudN0NjBFLDvUsIhl9q5Kc=; b=zQh91pz99GJ7ShVmSZQtztJAEh
	60pzlNJ/LZ9D6kc7lGf37Ay+XLnfBrPB+LL6LOH6+XYivS17vQ6unxPkiRDsJVCu/NGcVnwazXKac
	f6znISTawuCJFQIA3WPnHQmF9qrYNFRnYlgIZ3ifZmtpkQYIed0vs8Wxo4XxDRatGTXFUHap71ljn
	UA3q+MzLcq9G/MNBL5zeGG/LbLY94iOkBBiEPFa4JCZYKfYbyV0t5YuCRyT6BNUQEvlj87km+RD9d
	VnQ2+ayE/6vYja3w32s90UVHGFGMoiK45CQsiu1lO1Bqh7X0sG/aRpoFH/dTayRxvp1VMWOkMFUE6
	BjdnLntQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59910)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1vt7cx-0000000017b-3iIH;
	Thu, 19 Feb 2026 17:15:47 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1vt7cw-000000003Uv-3ATr;
	Thu, 19 Feb 2026 17:15:46 +0000
Date: Thu, 19 Feb 2026 17:15:46 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Charles Perry <charles.perry@microchip.com>
Cc: netdev@vger.kernel.org, Sean Anderson <sean.anderson@linux.dev>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: macb: add support for reporting SGMII
 inband link status
Message-ID: <aZdFQu0VkVlWZOAw@shell.armlinux.org.uk>
References: <20260219170113.1774090-1-charles.perry@microchip.com>
 <20260219170113.1774090-2-charles.perry@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260219170113.1774090-2-charles.perry@microchip.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Thu, Feb 19, 2026 at 09:01:12AM -0800, Charles Perry wrote:
> This makes it possible to use in-band autonegotiation with
> SGMII.
> 
> If using a device tree, this can be done by adding the managed =
> "in-band-status" property to the gem node.
> 
> Signed-off-by: Charles Perry <charles.perry@microchip.com>
...
>     root@p64h:~# ifconfig eth1 up 10.180.59.33
>     macb 40004184000.ethernet eth1: PHY 4000c21e000.mdio-mdio:02 doesn't supply possible interfaces
>     macb 40004184000.ethernet eth1: PHY [4000c21e000.mdio-mdio:02] driver [Microsemi GE VSC8574 SyncE] (irq=POLL)
>     macb 40004184000.ethernet eth1: phy: sgmii setting supported 00000000,00000000,00000000,000042ff advertising 00000000,00000000,00000000,000042ff
>     macb 40004184000.ethernet eth1: configuring for inband/sgmii link mode
>     macb 40004184000.ethernet eth1: major config, requested inband/sgmii
>     macb 40004184000.ethernet eth1: interface sgmii inband modes: pcs=00 phy=03

As your PCS is now configurable, please implement the .pcs_inband_caps
method (which will make the above pcs != 0.)

Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
