Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F823B14DE;
	Thu,  8 Oct 2026 03:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791431480; cv=none; b=jzy2ro/YCqtVzQP931ArcZyz6pnEa5EwfOo5oetsem3/yCmN/ThRgZwDD6xbpZpz4cMhunHM2U21dSEY9F+x+vdihinDldEd2zsZdxD+rvmI/An8wFNCHdc0FqqrLWXapp41zwDb2GpoxJ7Cx/Cnw7pmR1q9hD8Yit8luiJaYGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791431480; c=relaxed/simple;
	bh=gNeiBeIBcPq+3N6f0e6/oenfPkBMrSQA5YVjwdyOuis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CKKxCjYbmqGChjLisXuX/wqcNImO4cQj0GZWkMrf3Iq6jPGwvMU9QDv9qjTOnX/etie9eMNoMqQSQ1rJ+3UfwIr0mh1+2fGNDs1tOy3B6qD1JcPC60bHvsEVvaEptX+RdzYVSftbDMsZV4A/EQkf5JktQprEeZ+PN6bXck+6nEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=EN93VUpU; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=yb5jeqEB; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="EN93VUpU";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="yb5jeqEB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791431477;
	bh=gNeiBeIBcPq+3N6f0e6/oenfPkBMrSQA5YVjwdyOuis=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=EN93VUpUXZJuPagWMdSqlMI5x0eHSr+5u6JxhwPEVZkvzrKKhpFA/bUKbfEVMEPqz
	 4wNUdphfDAL+3nFGLxMem6GOFDSgir5cTACCynhezyN8qXwJYV+dI5afmhZ8VOx11E
	 UFFXJN7YhKpCNbEfxvP+FooNndk9jEy7dVTcdeIFGGx1FUK9G67e8Fsgc8RVt1Ks9n
	 BjgnNjSV/WlEYx1jwmlCGRVZCqhxKaJZqeBxOMhOJkblMD22IvJt6WK7yAXamQr3PE
	 gw+qdlwSsBL+ciJZ89ZRA7KOeOeMwdOlqCJNul4PpdInlvBDwj9ict8U3/HpMKxjwm
	 FU8vlAOMUlEkQ==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id F14E347285; Thu,  8 Oct 2026 03:51:17 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791431475;
	bh=gNeiBeIBcPq+3N6f0e6/oenfPkBMrSQA5YVjwdyOuis=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=yb5jeqEBzTqBm4B2PF9JyH4O1SFzhavGDRCaTrgxOQauayBn+ZBm1XF4703EF5qLP
	 cOFqn2AMMM+P2f1an8y/P+qJtHS75bpVg1qBElSefPhR84F4aN5xzQaHH6ccgssIxS
	 5ES1EgBzt+fzV5aVIi7YhV01pxTPEmEu28AcagbM3pVhfRv/tUvSbvDfGeCaxejU1u
	 nYSFzUF9Omy87tZy2unDZSN3OLcMeOl6kHaJBbLR/8+HaSfqx0R++SYFbjLKU0gvO2
	 wshNPNgfJfOF1w/JFMdspMH4i+BOk2AxgcOBo5HUAekbnhh6NBPLxWZngfI78hx9a3
	 aOOfDUGOfjZOw==
Received: from AMDDesktop.lan (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 08D7D470CF;
	Thu,  8 Oct 2026 03:51:15 +0000 (UTC)
From: Birger Koblitz <mail@birger-koblitz.de>
Date: Thu, 08 Oct 2026 05:51:08 +0200
Subject: [PATCH net-next v18 02/13] phylib: Add support for PHYs with
 broken forced mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-ax88179a-v18-2-6fa1d4c40422@birger-koblitz.de>
References: <20261008-ax88179a-v18-0-6fa1d4c40422@birger-koblitz.de>
In-Reply-To: <20261008-ax88179a-v18-0-6fa1d4c40422@birger-koblitz.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Russell King <linux@armlinux.org.uk>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
 Eric Dumazet <edumazet@kernel.org>, Eric Dumazet <edumazet@kernel.org>
Cc: linux-usb@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, 
 Jianhui Xu <neuromoments@gmail.com>, 
 Birger Koblitz <mail@birger-koblitz.de>, Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.14.2

Add support for PHYs which only supported auto-negotiated
speed modes. This prevents a kernel warning and stack-trace within the
phy_state_machine when PHYs return -EOPNOTSUPP from config_aneg()
because they do not support forced modes.

Signed-off-by: Birger Koblitz <mail@birger-koblitz.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
---
 drivers/net/phy/phy.c | 7 +++++++
 include/linux/phy.h   | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/phy/phy.c b/drivers/net/phy/phy.c
index fce9bc7be3304b408c9f3ec9b5b95c76d3680a88..079c53516f424ca5f8d50292f1912af04b45b07a 100644
--- a/drivers/net/phy/phy.c
+++ b/drivers/net/phy/phy.c
@@ -354,6 +354,9 @@ int phy_mii_ioctl(struct phy_device *phydev, struct ifreq *ifr, int cmd)
 			switch (devad) {
 			case MII_BMCR:
 				if ((val & (BMCR_RESET | BMCR_ANENABLE)) == 0) {
+					if (phydev->drv &&
+					    (phydev->drv->flags & PHY_BROKEN_FORCED))
+						return -EOPNOTSUPP;
 					if (phydev->autoneg == AUTONEG_ENABLE)
 						change_autoneg = true;
 					phydev->autoneg = AUTONEG_DISABLE;
@@ -1190,6 +1193,10 @@ int phy_ethtool_ksettings_set(struct phy_device *phydev,
 	      duplex != DUPLEX_FULL)))
 		return -EINVAL;
 
+	if (autoneg == AUTONEG_DISABLE && phydev->drv &&
+	    (phydev->drv->flags & PHY_BROKEN_FORCED))
+		return -EOPNOTSUPP;
+
 	mutex_lock(&phydev->lock);
 	phydev->autoneg = autoneg;
 
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 7c5098a0dd6cd1ffbfc5f55240cd68e41bfb2d73..4143bffdcdb9b293a6e717a41816c05a2c5a252b 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -64,6 +64,7 @@ extern const int phy_basic_ports_array[3];
 #define PHY_RST_AFTER_CLK_EN	0x00000002
 #define PHY_POLL_CABLE_TEST	0x00000004
 #define PHY_ALWAYS_CALL_SUSPEND	0x00000008
+#define PHY_BROKEN_FORCED	0x00000010
 #define MDIO_DEVICE_IS_PHY	0x80000000
 
 /**

-- 
2.47.3

