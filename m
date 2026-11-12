Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794459215;
	b=1nZum08gTZVtVmwNu+IAlhUIrOQOCom8zayevb+MDZxGjlq3Bv2FEroXJedlkl7m6kir
	 ZzQhoUUwVx1tJbvix1IIGpGZg4O+eVbfKDbKztbWksBF9oa4x8KN9qrd1i98TCc1hFcKW
	 0zkboc7c1qrm7F5jzzHCbWSj2zGrhVt5EJyNGPJOO0Vuy09GS8PZMtNOYGXZ5xO4IxBFb
	 cP6psPuCkmE3B5Q3xfgggocyAr8F03Xpues0wp9DSYikaWbi8J5CxTh4eXP8fr8PKpHBs
	 wKg2rWBcMtSjadi6FOmKck6ud6ktFKWw+uUgvJT8rcbb7xmM2MDO0yDU/HRC1de+eCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794459215;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jFIH548lIGR831rTuuZKYy9OsQLDm4lptzmx0LF/Teo=;
	b=nUoZFmGDU3IMOsC3QOd+1YkF4usoKC5PiUXYG3qYGp7E0aIGkcVfU/yaBbSzA+VA8t5G
	 3MEMslGu8tebh6uPKo05OsbEsx+Ty7G4FHsAe2IBFNw3WCBIn8pJgC/YlyD3jmEDc12+h
	 eRT5Sv3LVOgv7dacduNrylsw7nENtbgwespcA+0xgb3amJJcOT2WIQMPwpFOQmtKaH757
	 79gNQLPb5PIs3sbkTtSqh6t1ZNsEHdh5kisIPNUcEuWFfvF/KpdjdA678Dno9FaP1uCiV
	 5OhOc3IumKL4LXrYPWqdlY3OmpDXCGv85kQG3xwuguy29p3Bte4iuPZmB4lKFPjEPxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NIQGBmX+;
	arc=none smtp.remote-ip=74.125.82.180
Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EC5F606A334
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 04:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EC5F606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NIQGBmX+
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso8192273eec.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 20:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794459214; x=1795064014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jFIH548lIGR831rTuuZKYy9OsQLDm4lptzmx0LF/Teo=;
        b=NIQGBmX+gB/td2jTgeQJHS0l1U0N/7qJuZlSzsKPGmZCC+pLoqfGjKXBa+PU9VNzd5
         T1yQ47rp63xSNQ934qqBgiakvDT+bzaORp5BUpEq8gUz1JrL0guNlq81FgmVNPJb8DLY
         FIqWful2hr41vzOOOpoO/urDxhfD2YbEcEW4e7JNxC34f4RaxWgXB4xpYAKVMd1CBCgL
         IMH5sOaVzmXAd5V8QVe8wqfOIQ7KGm62bPrWyDtcUaPZN0wmqYw+FNC6S6Y9Y/R2+Fxr
         rwpW/+x4C116FN0mPtG7B5zzkklM8rHdh4BB3jfGmWrltm1fvd2uxtkV++S+4qVnHwZL
         /k5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794459214; x=1795064014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=jFIH548lIGR831rTuuZKYy9OsQLDm4lptzmx0LF/Teo=;
        b=Noqg3U0D7eE6WsXB1jWpZf8ojINCH18GXtSc4iSwKF6pQzFGpzmaBZmeAudIY9nIQo
         LfIaqOLxZbwFrQteoLP2Jvk6gYUv7OEMwDRCJlO1+IP8JaYkSTADyrIOYFxaLJ5HwAqG
         Jqu/n+hV7jlr31tNst3BEVJp5gSBo/RrHzQeficLY0KAJYqgRzLE6tk+dF+AD8Wm5aj2
         GGkC4UtmIeAhFZOFJwLSKPYxZrh3EXZN86GphMNdIeT8HtudreYJ2+tpLL9ftNKWzWDT
         SLyDlryrMJXpq4UYiLJOzhV9UsJOl29r7CNJzwlEzb8anL45vNPcjzXdUgWmxHo9RD6I
         Z3mQ==
X-Gm-Message-State: APuU4Z964hvRPu1gSqsDlBIRhHGHomKYPly0koW2XirKP6K4Ql88KOJH
	19Y64wRZ41DJPD7xvzEG5AavpLvmGy1APKvO2j7JeGQv10ZoNXvVPs/t134hBA==
X-Gm-Gg: AYBFou1eke+Ggga42tWtgXC27eIjDQim8sAV+9jxDEAzCno4NF3jTzZDiYHwO0mstf5
	Ohj8XKTD4K65m3ivIGo2hPc1ZIHlkGVRM1N45UuOYdi+05TugIrtH8VpELrJiVK6snk/UONz01i
	7fXTR061XWaqdU6sHP9hgDIL14KrUVME7XOnur2MOsj6ToD7XAaMxCCAE51j6ri5LOyMApvdEkL
	hMPVfZvhTctPuij/rzbiy/ny88WghfB5zTR8MsPaooQ5I61Z3G22deqJXyT1+GMUkXt5cFDGUWJ
	8KXpi7zbpObsebBucocU8dOyuEfEndzreoNblhw2PwvReFWORUAsipkpYEjaOMwRyJYwofuIE+l
	a+3HKckfV7/8YDwH118wYHpE+SVMg5ONk612lilv3pD1GkjjSzIgLNsehay2plI+1SvFYGOF4nR
	J3xXL0wxRo9x03v73mt6Wy7wvniI1fZjQMih5Ac0MzOdUsAkgoFAnLH2QLeNnIXAkLiXttpQ+7n
	R6MRP+u/Fp7LBuC0oZqzUNCNUzInB0i9IxKwtN4HKiAQqrVMivz/trPLqswc4vFIqyyAluxgT1S
	7LupWE81
X-Received: by 2002:a05:693c:8947:10b0:36f:14ef:ad08 with SMTP id 5a478bee46e88-376850ced2cmr4362199eec.9.1794459214221;
        Wed, 11 Nov 2026 20:53:34 -0800 (PST)
Received: from eldorado ([2600:8802:b00:1f88::287])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfc6sm23921585eec.17.2026.11.11.20.53.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 20:53:30 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jijie Shao <shaojijie@huawei.com>,
	Simon Horman <horms@kernel.org>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	David Yang <mmyangfl@gmail.com>,
	Herbert Valerio Riedel <hvr@gnu.org>,
	Jeff Garzik <jeff@garzik.org>,
	Danny Kukawka <danny.kukawka@bisect.de>,
	Mugunthan V N <mugunthanvnm@ti.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH net v2 03/12] net: au1000: disconnect the PHY before freeing the MDIO bus
Date: Wed, 11 Nov 2026 20:52:45 -0800
Message-ID: <20261112045301.3669532-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112045301.3669532-1-f.fainelli@gmail.com>
References: <20261112045301.3669532-1-f.fainelli@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Balance phy_connect() on probe failure and removal. Otherwise PHY
interrupts, device references and the attachment to the freed netdev
survive teardown. Disconnect before unregistering the bus while its MDIO
callbacks and MAC registers remain usable.

PHY teardown can re-enable the MAC for MDIO even if the interface was
never opened. Reset the MAC after PHY and MDIO bus teardown, before
releasing descriptors and register mappings. Skip MAC control accesses
when mac_enabled is clear, since stopping an already clock-gated MAC
hangs MTX-1. Always clear the DMA descriptor control bits and TX state.

The teardown corrections were identified by Sashiko AI review and
hardware testing, with OpenAI Codex assisting implementation, validation
and commit-message consolidation. Previously validated on MTX-1 with
opened and never-opened removal, rebind and traffic; both removal cases
left the MAC enable register at zero. MIPS build and extracted-function
ASan/UBSan checks passed before this series was consolidated.

Fixes: 0638dec01e89 ("[PATCH] net: au1000_eth: PHY framework conversion")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/amd/au1000_eth.c | 26 +++++++++++++++++---------
 1 file changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
index 58bc8e1b539d..7063f9e5bc7c 100644
--- a/drivers/net/ethernet/amd/au1000_eth.c
+++ b/drivers/net/ethernet/amd/au1000_eth.c
@@ -584,14 +584,17 @@ static void au1000_reset_mac_unlocked(struct net_device *dev)
 	struct au1000_private *const aup = netdev_priv(dev);
 	int i;
 
-	au1000_hard_stop(dev);
+	if (aup->mac_enabled) {
+		au1000_hard_stop(dev);
 
-	writel(MAC_EN_CLOCK_ENABLE, aup->enable);
-	wmb(); /* drain writebuffer */
-	mdelay(2);
-	writel(0, aup->enable);
-	wmb(); /* drain writebuffer */
-	mdelay(2);
+		writel(MAC_EN_CLOCK_ENABLE, aup->enable);
+		wmb(); /* drain writebuffer */
+		mdelay(2);
+		writel(0, aup->enable);
+		wmb(); /* drain writebuffer */
+		mdelay(2);
+		aup->mac_enabled = 0;
+	}
 
 	aup->tx_full = 0;
 	for (i = 0; i < NUM_RX_DMA; i++) {
@@ -603,8 +606,6 @@ static void au1000_reset_mac_unlocked(struct net_device *dev)
 		aup->tx_dma_ring[i]->buff_stat &= ~0xf;
 	}
 
-	aup->mac_enabled = 0;
-
 }
 
 static void au1000_reset_mac(struct net_device *dev)
@@ -1287,6 +1288,8 @@ static int au1000_probe(struct platform_device *pdev)
 	return 0;
 
 err_out:
+	if (dev->phydev)
+		phy_disconnect(dev->phydev);
 	if (aup->mii_bus)
 		mdiobus_unregister(aup->mii_bus);
 
@@ -1334,9 +1337,14 @@ static void au1000_remove(struct platform_device *pdev)
 	struct resource *base, *macen;
 
 	unregister_netdev(dev);
+	if (dev->phydev)
+		phy_disconnect(dev->phydev);
 	mdiobus_unregister(aup->mii_bus);
 	mdiobus_free(aup->mii_bus);
 
+	/* PHY teardown may have re-enabled the MAC for MDIO accesses. */
+	au1000_reset_mac(dev);
+
 	for (i = 0; i < NUM_RX_DMA; i++)
 		if (aup->rx_db_inuse[i])
 			au1000_ReleaseDB(aup, aup->rx_db_inuse[i]);
-- 
2.53.0

