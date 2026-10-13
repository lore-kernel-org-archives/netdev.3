Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB548527594;
	Tue, 13 Oct 2026 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897590; cv=none; b=N3mk1NDQeFXypVpSCJrZi3qsswvmbwrMx+VcIpxdN4HDQIjl1wx6RoY6nKhhdSVx7zVwHvtaUIGZp6DJN6wul/7IEre/L0ONWlgsabSwJNisgb5ZkD75LERjllUZL/bgqyoD7CA3uB9oLhTReF3kfYGq2DQXSltZyUqs/MwvZqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897590; c=relaxed/simple;
	bh=Fvk0duV1ByfLRGs70IWm774Y8VFZAnYfDwRE6ecAra8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U9qsfnGZYdRl7Qfbz5aES1EWLT0DLWWmGz6Iw9bs2sQQvclWCQHylRky1XajiJMucnyaim0yFx/5s22HLbe/Xm8vjCOwllBO5879hNHwJ1EUReoiwHqXTZ6zV4TlR/olMKwPX2W4K/++Ad5Z+I05QJfsbtEsguM+w1We2DI6O+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MW2HEju3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MW2HEju3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F3FE1F00893;
	Tue, 13 Oct 2026 13:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791897589;
	bh=j2MnWdjNlyO8695B+moZ0cpISEgUnmiewDoPa1LyusA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MW2HEju3mIIrTtNJV0YaOCxHL1RY3jvH+e8liQqEb3Ijmp0Ty0gzVdV3OCedgwxFF
	 a+ZCRFGL7Pum3MlS/BJPQ6mNeGzU+PsP2UVZFPlNBk8FXjc7YHf2OZ1shwQVQx+40q
	 oQVXprCKwvmwRCdLY4EG+WX16HEv1WeR9rCEv7PPUkHNptEsP70qM05M/2HYgFB3fJ
	 BtDERIbii/TPXdhirm2yB4poqzrpCzogCB+wjc0B72NB+NPf8dKmJQQnLfsH+Eh1H7
	 yAbgx/oXG868hIm9jVSKyOFw8fvAuDkr9qcjIveh9lj29UKPdIICyWrFjeUNaxQRTn
	 4i/DeN2hm36hw==
From: Imre Kaloz <kaloz@kernel.org>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc: linux-mips@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lee Jones <lee@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org
Subject: [PATCH v2 38/53] net: ethernet: sgi: ioc3-eth: fall back to the platform MAC address
Date: Tue, 13 Oct 2026 15:16:58 +0200
Message-ID: <658e0c3fda5c8f898008b0972b493bdf433420d5.1791890466.git.kaloz@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1791890466.git.kaloz@kernel.org>
References: <cover.1791890466.git.kaloz@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The IOC3 on Fuel's system board has no MAC PROM on its 1-wire bus, so
ioc3eth_get_mac_addr() cannot succeed there and the probe defers for
ever. Ask eth_platform_get_mac_address() before deferring; on IP35
machines it answers from the L1 system controller. Once deferred probing
gives up with neither source answering, use a random address.

Signed-off-by: Imre Kaloz <kaloz@kernel.org>
---
 drivers/net/ethernet/sgi/ioc3-eth.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/sgi/ioc3-eth.c b/drivers/net/ethernet/sgi/ioc3-eth.c
index f86dd192a3d3..13102177ea88 100644
--- a/drivers/net/ethernet/sgi/ioc3-eth.c
+++ b/drivers/net/ethernet/sgi/ioc3-eth.c
@@ -850,6 +850,7 @@ static int ioc3eth_probe(struct platform_device *pdev)
 	struct ioc3_private *ip;
 	struct net_device *dev;
 	struct resource *regs;
+	bool random_mac = false;
 	u8 mac_addr[6];
 	int err;
 
@@ -858,9 +859,16 @@ static int ioc3eth_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Invalid resource\n");
 		return -EINVAL;
 	}
-	/* get mac addr from one wire prom */
-	if (ioc3eth_get_mac_addr(regs, mac_addr))
-		return -EPROBE_DEFER; /* not available yet */
+	/* get mac addr from one wire prom, or from the platform */
+	if (ioc3eth_get_mac_addr(regs, mac_addr) &&
+	    eth_platform_get_mac_address(&pdev->dev, mac_addr)) {
+		err = driver_deferred_probe_check_state(&pdev->dev);
+		if (err == -EPROBE_DEFER)
+			return err; /* not available yet */
+
+		dev_warn(&pdev->dev, "no MAC address, using a random one\n");
+		random_mac = true;
+	}
 
 	dev = alloc_etherdev(sizeof(struct ioc3_private));
 	if (!dev)
@@ -939,7 +947,10 @@ static int ioc3eth_probe(struct platform_device *pdev)
 
 	ioc3_mii_start(ip);
 	ioc3_ssram_disc(ip);
-	eth_hw_addr_set(dev, mac_addr);
+	if (random_mac)
+		eth_hw_addr_random(dev);
+	else
+		eth_hw_addr_set(dev, mac_addr);
 
 	/* The IOC3-specific entries in the device structure. */
 	dev->watchdog_timeo	= 5 * HZ;
-- 
2.47.3

