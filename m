Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74CA3E1CF0;
	Tue, 31 Mar 2026 11:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774956617; cv=none; b=k7j3JOalA4EB3bhL0ORXAZOQbyJW2ZtZc6C7bm5kokLpxItY8kkhvgrYgpEURLof6NkGvI2po/ep0p7Ncl39M+0ZS1UWeGnOWhxUDgaHrpQie+UmdNbwOrUrBN467NrL+gUX89Y2EJy/dUy8BHUKM/xHVpz001MIfHmSSslzAOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774956617; c=relaxed/simple;
	bh=30aOrOjH0VtHHJR1WNIenKxVIhqi9GN620JYohuupZ0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W66SxlX0JM3vsoLzVU3pYmWCtgZoN48zCkx8oFOWJo/5DVWWx6Jq4wKEawek+NwcBA01YYWrY5UaS2xkLbpAkhwYOdQXc9VJlKvQjAVIjPDScIAx2lJ2eK8+5aTAD+R5D18WeibpmzFab5QLlHyrsa8ApQ1jOhi8UJOFNgwy0Q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=GHqn8hBF; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="GHqn8hBF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Bz0tlaTdQmy6jb7z+6f/ZifhIJcsPpSr9rXnYYmL8kk=; b=GHqn8hBFIQQ+mc6ITteH3IPH3P
	tq1E/n7jn/glVaYm5FwrMQuescyEF9QFmWF9eWFq1grVq3/pPgLRqB6qLXRSnFzm/ZB2//I9+SL38
	Zo0ZgsW4AbvQEkQWKEn6ZUkho5ONGr6bijw7fQEeKabeF/5IpID1M+OVXS4buFRi0g5Z95D0Zsry0
	jjrHsr+jx2HNW6yNi3707sbkXXZijXmYSxAlTEnljbRCdCHgcqHrXkcKGjdroM8zIph7S6eum9nSe
	9RQITJHDCNP7MrEHB7Rf/H4r7VAse3c3MQrWawkX/AYONNyjae45u7wCUarQbyZAZefvfD1C74JuM
	K4L5yb1Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40030)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w7XI8-000000001l9-1n8V;
	Tue, 31 Mar 2026 12:29:52 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w7XI0-000000003g8-2ZmL;
	Tue, 31 Mar 2026 12:29:44 +0100
Date: Tue, 31 Mar 2026 12:29:44 +0100
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, Phil Elwell <phil@raspberrypi.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] net: phy: microchip: add downshift tunable
 support for LAN88xx
Message-ID: <acuwKGBn6UKfRCjU@shell.armlinux.org.uk>
References: <20260330224630.579937-1-nb@tipi-net.de>
 <20260330224630.579937-2-nb@tipi-net.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260330224630.579937-2-nb@tipi-net.de>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

On Tue, Mar 31, 2026 at 12:46:26AM +0200, Nicolai Buchwitz wrote:
> Implement the standard ETHTOOL_PHY_DOWNSHIFT tunable for the LAN88xx
> PHY. This allows runtime configuration of the auto-downshift feature
> via ethtool:
> 
>   ethtool --set-phy-tunable eth0 downshift on count 3
> 
> The LAN88xx PHY supports downshifting from 1000BASE-T to 100BASE-TX
> after 2-5 failed auto-negotiation attempts. Valid count values are
> 2, 3, 4 and 5.
> 
> This is based on an earlier downstream implementation by Phil Elwell.
> 
> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>

I didn't see a cover message. Please always include a cover message with
patch series.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
