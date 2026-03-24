Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AB43E9588
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 10:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774349222; cv=none; b=HPbL5KTF15WVRE0kTb5ZS+LeyQVhYHktmMJJko4wZa0Jd3LIm0S6tS4QeOOjxPIp4v1pQWCZfyDMTz5Ne8K/zm1mirG1HLAUFqa5AzUYgACCEXbmhTrVM3KG0el4Iq33UNMjqkxapKV8biL5ppXSUz5wbaKsv50R6HRG1ED9vcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774349222; c=relaxed/simple;
	bh=xTBTMRjWA8k5ExC0fP6E18xLZV/FhiB6e7u765YTHlk=;
	h=From:To:Cc:Subject:MIME-Version:Content-Disposition:Content-Type:
	 Message-Id:Date; b=lt5YKNRuEETv90zTWKn9RhAC+kPjkFbHFJhjz+l3mhdcSD3RS47HKbUdbgpShSvFqUZLZoy8/1KehYRWRpZTdjwwxVJ/AKQm1Fkf8aP0p4O0QMub7DVusyKAV8Mr99GZo0yser98iWv22cflvWxWTk0oKN5TjcAKyvhwfwuI/xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=tIh2iGEF; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="tIh2iGEF"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
	:Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
	Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=mmd67WnZ8GHcXG/fRhAesnqFzrQYoabu3N0l1etz53o=; b=tIh2iGEFNylLH+7pSZrxJz/1i/
	piQ8vQ8GwPdqI4fa4NZtLBz6dHYJziF6WB8/o0wySoyWKyhh4ruEN63kB0AK+8FGkpdHKcPI8cF+U
	Cb/KD32Kv339lluaF83enJztV1aHrfZz9i/CYpj7ggErPMYSnAtYtmkDcs+NMDBKN09+8StiR+wdL
	0xisdCahtAR9tvbyid286EtUrVS54/iCE50gEJk7KpeqpwCLVX1vM4pIknsjYndgwt3UPnAt0r97r
	0DtdZA8syxPlVdLbd25CAfBsjN6vU/OkSjG8BcA8/2glbhEYWhfOn4RaLVb1Ar72GemmnPGy6FzLn
	3zHiwFDw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:56516 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w4zHh-000000001oF-1ZMn;
	Tue, 24 Mar 2026 10:46:53 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w4zHg-0000000DmC4-2oyb;
	Tue, 24 Mar 2026 10:46:52 +0000
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next] net: phylink: use phylink_expects_phy() in
 phylink_fwnode_phy_connect()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w4zHg-0000000DmC4-2oyb@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Tue, 24 Mar 2026 10:46:52 +0000

The tests in phylink_expects_phy() and phylink_fwnode_phy_connect() are
identical (by intention). Use phylink_expects_phy() to decide whether
to ignore a call to phylink_fwnode_phy_connect().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/phy/phylink.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index f80cd13c8e32..087ac63f9193 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -2295,14 +2295,12 @@ int phylink_fwnode_phy_connect(struct phylink *pl,
 	struct phy_device *phy_dev;
 	int ret;
 
-	/* Fixed links and 802.3z are handled without needing a PHY */
-	if (pl->cfg_link_an_mode == MLO_AN_FIXED ||
-	    (pl->cfg_link_an_mode == MLO_AN_INBAND &&
-	     phy_interface_mode_is_8023z(pl->link_interface)))
+	if (!phylink_expects_phy(pl))
 		return 0;
 
 	phy_fwnode = fwnode_get_phy_node(fwnode);
 	if (IS_ERR(phy_fwnode)) {
+		/* PHY mode requires a PHY to be specified. */
 		if (pl->cfg_link_an_mode == MLO_AN_PHY)
 			return -ENODEV;
 		return 0;
-- 
2.47.3

