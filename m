Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794459245;
	b=HmcR2eBm4rOY3i3qodwZx7ntNJxKveWaYYVvk1xDqPMLcH+ZkY1kte5J63asGkDWvSL3
	 0M1m2TFhE9pHExsjDLqPTo9AH85XxWmGeqyAfPDu6DADGDtjPYRmO81q+MjACbvk8U5Dt
	 /j3wdwjy3m9sHt9g46E2kd71AEKkx6riba4vd33deIsgGulJYeeLDzwfwHRMkF0vzbyX/
	 IWSLauS7Alk1fWe9heA47R8fj42Ut1Moi4BLup+ZB51w7Kcun0izLxxiOAPDq1t8Brfh9
	 nmtePPkWCmj3MXy5p10S6NP9olQQbVwMdBCRyc8TnVa/iRCi0VP/gg/uZ3qNBAXs9wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794459245;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LZWh9LU/nAWUZuRUFQR3AdsNrL+pqhM3F3VmMPsPiXw=;
	b=PuS7ek1yRQFMCAm0nY/NE0AZwt28ZwpTAsaztwDyEtYGO1DzjKggEw9FsW4zInGNkBza
	 aIMMTZj/B0suJaFEOdoEEtjOR53lAAwj/qut8X61OIAiDMOMuXwj+r1wBwrZEQB3c1Ab0
	 Q9zVuYuJbNHLGa7Ddemy1Hjsbyp4Ef+cFnBNhm4GdzDjAaaNijNO7qe43KXwer/x18ZYF
	 CatzwJMHseYzw9w9tHvunh1QQID0HTAVERIIi1E9QScAxKzcCb0lu7FP0CLC9Osqvzlro
	 sDhg132imBoSgycWV2GJG9fcUCgZRZp951YMHnGL4D3dhR9pslzCRs1CF1DdyJs9sxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cOJwvI4H;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3647D606A331
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 04:54:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3647D606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cOJwvI4H
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-372bdb942dbso4970240eec.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 20:54:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794459244; x=1795064044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LZWh9LU/nAWUZuRUFQR3AdsNrL+pqhM3F3VmMPsPiXw=;
        b=cOJwvI4H1fuGqx3IBEmnw66lr/EHRfalL5K7ukBFmIhkkh+E0e+ZWajfEwB+rjEToz
         oiwb8q8/ZvB9L6AKSqVcVM5C9QrNywcG1puUkEBTJuMghwTNMPsJrX3w12vMvo/Ej4Cz
         Ms9oHFriv6yQ2gdQkiNX/l02DJAjzAmchLLIZP0bShC9bWTJ+zpIsU1Q5BfCkt5BXDzm
         xQG5AYnH7Wwrre/aJr3BuSNZVIxbS9s/9YXQ3LBwE6yVUDhbRUrWlLLvmDDFXZ20sUPJ
         jxV0m4zj1Z7CFNcuFyaTSs7T87F9EPio+l4jb7HdOr2JdJc2frvQBLy3Ll7L5tjCyqXq
         eYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794459244; x=1795064044;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LZWh9LU/nAWUZuRUFQR3AdsNrL+pqhM3F3VmMPsPiXw=;
        b=PPZFAiLYQIBuWOU6ECkRV5BkR6H+5kLHvr9u/yRI1Wcp0sAFUhLcmm/WYRxqt55oDk
         1tgpzZHUhDocKL9IQ1RW13NH3avcv4c5AYUlbZMIKGefG+dD96ocQpekPGz/ioZ4NiyV
         d+tjStuJqLg5xeuteE6dOQPVspBUahdWiT0CNudUIM7/uYRYm1bKVDJOwKxmMCbUxu6P
         7E2cAp47hu4qZGb5DHGo0ssPtCf53xvX5zjLb4vCHfrrPSGhIxqqp3h6ht5PcFOZgp0M
         iEm18oWk0t2AwrXTxP1r5kyUvyRSY3lWXCEYSHZ+InvkrHhmgoH2waTU98gla4ux8lR7
         B2Kw==
X-Gm-Message-State: APuU4Z9W4E8ucpEK4qK5FdzN65pQ6GIbtFC7sVoHIMUz3Kz9h7S4CfyH
	BTMbsSFuR2oecAtdeMdO1TzLxPTJNQHYVWM9XXOrlbVWBJ3GgE5XyKyOwn6vdQ==
X-Gm-Gg: AYBFou3GNb2oU3f+tU7NhaeWLM5kKiJh+9VDOCNDJcUgD2JHbNtfMwUD4gO+qkt8zza
	2uqkF01KrpFjr0EsdwCb13YJAW5IGpu3evi2f9AwBFsvbjcBRVbCd9an6xAXRlDUj3MSwWiLJ/o
	AOt2XcTsOzfm/hSBVn8Ds321LBVVoc0wAcK4y74f92581XQjNuY5Q8YlmwGHaq6IdS2bQxxmzLi
	C9lDKzIf8ClPQYCSw0LnJVX1Qp60r0aDOlBQjXSWMIbqqRxkFjJijn5GntXZPXTe/IZoUxWGMfU
	F7aO3SvXkPRd0p2wWnBOz5bcrOxWdIAzd9AL+QoDnYdMsFsvtrHlEfVPaZQZnASFO+XgKQnIXH+
	razKx0LFVY+lb/fHEzrbJrfNjwZ+XKqtdVFFSxl8s1jp1ze+jpoc/l7LnLEZzW5SHVqOrIpWNzu
	USFHXwdeOsc4+gYpx9xU3Mddcq1F9iJJFkKdWjcU6SWt8HiojkdMQK25sv1DvEJPZvGy021g1XY
	RmqvC4VbPB2F3IAyN787oY6xTGzyTezv7r0ve0xCH5TPfQG17hs6JBaVUV2sCjvpSgRu+CcVtWG
	apxB4LpNiQkjDdmh82kR06LZI3GAcA==
X-Received: by 2002:a05:693c:69d5:b0:369:f961:ccf8 with SMTP id 5a478bee46e88-37686175110mr5574040eec.19.1794459244294;
        Wed, 11 Nov 2026 20:54:04 -0800 (PST)
Received: from eldorado ([2600:8802:b00:1f88::287])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfc6sm23921585eec.17.2026.11.11.20.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 20:53:58 -0800 (PST)
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
Subject: [PATCH net v2 08/12] net: au1000: restore receive filtering before enabling RX
Date: Wed, 11 Nov 2026 20:52:50 -0800
Message-ID: <20261112045301.3669532-9-f.fainelli@gmail.com>
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

MAC initialization overwrites the receive mode, dropping promiscuous and
multicast settings after a watchdog reset without notifying the network
stack. Restore the requested filtering before the control write that
enables RX, avoiding a window with the wrong filter.

Factor receive-mode programming into a helper shared by initialization
and the receive-mode callback. Hold the address-list lock before the
device lock through initialization so the filter snapshot stays current.
Protect callback control-register updates with the device lock as well.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/amd/au1000_eth.c | 23 ++++++++++++++++++++---
 1 file changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
index f127c0184036..67f4899c34a6 100644
--- a/drivers/net/ethernet/amd/au1000_eth.c
+++ b/drivers/net/ethernet/amd/au1000_eth.c
@@ -683,6 +683,8 @@ static const struct ethtool_ops au1000_ethtool_ops = {
 	.set_link_ksettings = phy_ethtool_set_link_ksettings,
 };
 
+static u32 au1000_rx_mode(struct net_device *dev, u32 reg);
+
 /*
  * Initialize the interface.
  *
@@ -704,6 +706,7 @@ static int au1000_init(struct net_device *dev)
 	/* bring the device out of reset */
 	au1000_enable_mac(dev, 1);
 
+	netif_addr_lock_bh(dev);
 	spin_lock_irqsave(&aup->lock, flags);
 
 	writel(0, &aup->mac->control);
@@ -736,11 +739,14 @@ static int au1000_init(struct net_device *dev)
 		control |= MAC_FULL_DUPLEX;
 	}
 
+	control = au1000_rx_mode(dev, control);
+
 	writel(control, &aup->mac->control);
 	writel(0x8100, &aup->mac->vlan1_tag); /* activate vlan support */
 	wmb(); /* drain writebuffer */
 
 	spin_unlock_irqrestore(&aup->lock, flags);
+	netif_addr_unlock_bh(dev);
 	return 0;
 }
 
@@ -1034,13 +1040,12 @@ static void au1000_tx_timeout(struct net_device *dev, unsigned int txqueue)
 	netif_wake_queue(dev);
 }
 
-static void au1000_multicast_list(struct net_device *dev)
+/* Caller holds the address-list lock and aup->lock. */
+static u32 au1000_rx_mode(struct net_device *dev, u32 reg)
 {
 	struct au1000_private *aup = netdev_priv(dev);
-	u32 reg;
 
 	netif_dbg(aup, drv, dev, "%s: flags=%x\n", __func__, dev->flags);
-	reg = readl(&aup->mac->control);
 	if (dev->flags & IFF_PROMISC) {			/* Set promiscuous. */
 		reg |= MAC_PROMISCUOUS;
 	} else if ((dev->flags & IFF_ALLMULTI)  ||
@@ -1061,7 +1066,19 @@ static void au1000_multicast_list(struct net_device *dev)
 		reg &= ~(MAC_PROMISCUOUS | MAC_PASS_ALL_MULTI);
 		reg |= MAC_HASH_MODE;
 	}
+	return reg;
+}
+
+static void au1000_multicast_list(struct net_device *dev)
+{
+	struct au1000_private *aup = netdev_priv(dev);
+	unsigned long flags;
+	u32 reg;
+
+	spin_lock_irqsave(&aup->lock, flags);
+	reg = au1000_rx_mode(dev, readl(&aup->mac->control));
 	writel(reg, &aup->mac->control);
+	spin_unlock_irqrestore(&aup->lock, flags);
 }
 
 static const struct net_device_ops au1000_netdev_ops = {
-- 
2.53.0

