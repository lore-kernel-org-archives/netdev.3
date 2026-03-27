Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EBC3DBD46
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 09:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774604406; cv=none; b=qAVJC2EGFx9BcxQ8ubCN+hxlpgR7Ca5GdX+TfiM+/lNpkFFqK1qWClbw3HjVLkfNQ/C1tziO2hxWODnE/5Wl7XRLWi41tdLS7SxgIwLITJ3dtG8Z0OraLQ8XHYC+jE2GIcAP/+5bZnKfVRB+w3RcC3WqeQe1pRix4Ye8gSJP+B8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774604406; c=relaxed/simple;
	bh=rmmlf4KKWtRHguk2iBVhE8jcOsAloGPjFm1p9NESs3c=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BXVScZSGW7Y//JtZ1mOvogUWmIM4xDojJryTZMSttiD7KB75Uo09BoqVl0WNXaGSrJvO9xu6mstz3ug9Mjdq8mE4VRHL8mUK9wpnUd9s+TFPG+Zfz385QybpmTltl4MdZx+tCz/1IIkLjC48CrwYM/tE0FmgnJCYahDbC5zAbA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=fLfbgQ2U; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="fLfbgQ2U"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Sender:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WUPmq1A5eaO109OW3qO6eHS11Ep2OeWicoobVOUG9AI=; b=fLfbgQ2UujCA7PbAk0yuuAA5t1
	4MTeVFDKsrj8Gcggwihm9v+awDhPb78uHdVsxMyKgunZybO9QMzqEQt3M3bQOKgHCYjAEGgbMYNQJ
	wkHZRW7Ao8lvat74xIMHKZjhNv1WP1nSV6313Af66dsdjdkGcT/f7XbBNF94EwLDrXY2kYfqDxvIO
	I4SEY4ybTwcm/gp0ouGt59m7uQM9xB9uoHqNrpUASlLIGgk6L5c1NUjFXZcaOmKBrh3FYmOzl3fMh
	OADA9lfdW/Hatqz1qHSQnc+5d59ssjRWHssVbskYH8+g6K3v/YiSTUg0iAWFMIoNfB3cyLOeUUWR2
	HC+VcwQQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34894)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <linux@armlinux.org.uk>)
	id 1w63fX-000000005xG-0JIU;
	Fri, 27 Mar 2026 09:39:55 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <linux@shell.armlinux.org.uk>)
	id 1w63fU-000000007wj-3Q70;
	Fri, 27 Mar 2026 09:39:52 +0000
Date: Fri, 27 Mar 2026 09:39:52 +0000
From: "Russell King (Oracle)" <linux@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next 0/2] net: stmmac: fix and clean up TSO/GSO support
Message-ID: <acZQaDeCoib5S5UA@shell.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Russell King (Oracle) <linux@armlinux.org.uk>

This series:

1. moves setting priv->tso from stmmac_fix_features() to
   stmmac_set_features() as fix_features is not supposed to change
   driver state.

2. simplifies the TSO/GSP test in stmmac_xmit() to simply check if the
   skbuff is a GSO buffer, and whether the gso_type is one that we
   should handle.

A previous version of patch 1 was posted in February:

https://lore.kernel.org/r/E1vuU3X-0000000Ae9G-1Er8@rmk-PC.armlinux.org.uk/

 drivers/net/ethernet/stmicro/stmmac/stmmac.h      |  3 +-
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 38 +++++++++++------------
 2 files changed, 21 insertions(+), 20 deletions(-)

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
