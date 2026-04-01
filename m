Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3EE0376BCD
	for <netdev@vger.kernel.org>; Wed,  1 Apr 2026 07:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775028088; cv=none; b=oNj4rRO05lE+VYc6Nbwmo0A2Cgu/fToT17AX7EybOdHySTLZ9pLzaUyJ5Db2n+SHD8NVZO7wAa6mUictc+fFx39x/0VMauGWlUhuVgZ/10CCUNfjVwHJEHjFyQktm1qBYfvDjQeMoTVBHMhtpmvKQEQCPqGTmtGJoeSAQKmo1EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775028088; c=relaxed/simple;
	bh=LBvFdJSCHlB/Eno4ARxh88ZmtM0Xoa//nJt4IQgk7GM=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=gqipETgFr8n+y3J4sUU47o/eBE8ArmuGjptJxC1fgygizN7LjGKCKAVunXg9az61cAi5yiEm0FHWv4pwPT7p4xeDfb3RlqQdfkPvtlHmXbHJfcnjHZrcn1Un8sJmB5yO8eRpNHml4BUQXtEMICUXEfHvyaqRugM1US9XitV2KBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=xga1V+rY; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="xga1V+rY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=n+HY1v6K7+3S1W+xgQPRi1IM8CgGBePKt4HiS0CKizY=; b=xga1V+rYa68nBzhLxefeYUC+YP
	PV10PJJvnsU6aFTZ/33/qdzmMT+jVnnQwl8ush7XUjanooN909UKCYw7cqbkWyOQpBO//mRGMbrNN
	ig//Mazu4aOlpa/8u7PykA538opRYxsEbpGk8lWNsFVgaYN2ly79lBNufzh+RE+QgqhwrRGrBVO8a
	Km3UQXHRMzfFB4dZ67sXDQb5HIqW1F6U3AXVhHGQc80FlZDIJ0MF4U4n2BWFqgvzEoa/OVm+7iMqZ
	+Yu4VrN1zSnL6tuFvIbxx2EEFakuBH+hDZv2UTPKO3wxE946aaPVMYcXbr5okw/CV2ahhfUgMBP/z
	JFijIxHw==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:37596 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1w7ptA-000000002fk-0Y28;
	Wed, 01 Apr 2026 08:21:20 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1w7pt9-0000000East-1YAO;
	Wed, 01 Apr 2026 08:21:19 +0100
In-Reply-To: <aczHVF04LIGq_lYO@shell.armlinux.org.uk>
References: <aczHVF04LIGq_lYO@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	netdev@vger.kernel.org,
	Ong Boon Leong <boon.leong.ong@intel.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH net-next v2 02/14] net: stmmac: fix .ndo_fix_features()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1w7pt9-0000000East-1YAO@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Wed, 01 Apr 2026 08:21:19 +0100

netdev features documentation requires that .ndo_fix_features() is
stateless: it shouldn't modify driver state. Yet, stmmac_fix_features()
does exactly that, changing whether GSO frames are processed by the
driver.

Move this code to stmmac_set_features() instead, which is the correct
place for it. We don't need to check whether TSO is supported; this
is already handled via the setup of netdev->hw_features, and we are
guaranteed that if netdev->hw_features indicates that a feature is
not supported, .ndo_set_features() won't be called with it set.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index cd76f62e1b6e..c80b4a375ddb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6073,14 +6073,6 @@ static netdev_features_t stmmac_fix_features(struct net_device *dev,
 	if (priv->plat->bugged_jumbo && (dev->mtu > ETH_DATA_LEN))
 		features &= ~NETIF_F_CSUM_MASK;
 
-	/* Disable tso if asked by ethtool */
-	if ((priv->plat->flags & STMMAC_FLAG_TSO_EN) && (priv->dma_cap.tsoen)) {
-		if (features & NETIF_F_TSO)
-			priv->tso = true;
-		else
-			priv->tso = false;
-	}
-
 	return features;
 }
 
@@ -6107,6 +6099,8 @@ static int stmmac_set_features(struct net_device *netdev,
 			stmmac_enable_sph(priv, priv->ioaddr, sph_en, chan);
 	}
 
+	priv->tso = !!(features & NETIF_F_TSO);
+
 	if (features & NETIF_F_HW_VLAN_CTAG_RX)
 		priv->hw->hw_vlan_en = true;
 	else
-- 
2.47.3

