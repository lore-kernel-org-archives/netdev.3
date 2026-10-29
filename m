Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793308614;
	b=u0cV5eRbJEnuqM/YyDo+MYrcCtqT7g+ye5IRkO1dkdKv9+OQRrqHYVJuYDUliCYFKE5z
	 5UL6Xic75TPpr2qgyeGvtjAZmb1F2fITxKf025309aRpGE9k1mMGl2FpZ325klETGD22p
	 hv8CUNaEGWLl73JkWvC8EHKSie5+UlDHc7yTnlADe9YQrAMGxRClWTpggWA2IoCOlCh1s
	 wB01b0x1CaH8zaVHsYNUgVSuMFSyss+fxpznnn96Hnuhm2QHbHa0nX+UCtqfn3noo85r6
	 cTUoR5T1fiLWfp6Wo6Xso58iIwoV9Q4JJ2oCQ/rHeT0+uLYK7JOOYokla4+GH3QPx+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793308614;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=//FswPmpGUCUeaiDqBbIuHbgZKjvPl5eO/5v7O9w/Ro=;
	b=wa/srnQrj6zJLy77FOFqC7rkrJ4YpEf0E7G/Zswec6Ag17WOzwMTKfri0BSyVQS7y1LU
	 w1jIkrO4OTXLVgFjpAMo5yssTpvNi8aoOYZRKhattWOL7XZ6dxO7ABURyBYhJ/BKrReRL
	 U+Ov9RHUqVj2xQxAC8NW1rdwFEzgupo5biRw8GJjQOWMHUq/56t1hFVZCzV/6jSq4VLUf
	 GvXcNUe1FrQgTgb7AVpA41ytsiyGdPUoCKTm2wDvlEGMANdFWhTcb8vwuFcwwmhHA4bWo
	 rhzLMojtZmfuDtO0D2JWWnq8DIjiM4D09hUW0caFXZLgb0TEvZAd+lhE7phZlc2aCgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=cu3nR16R;
	arc=none smtp.remote-ip=209.85.214.226
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06B5160A5BC9
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 21:16:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 06B5160A5BC9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=cu3nR16R
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2e9995ce866so658335ad.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 14:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793308608; x=1793913408;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=//FswPmpGUCUeaiDqBbIuHbgZKjvPl5eO/5v7O9w/Ro=;
        b=qQww9ZZtcQ5EbQLXm1JlVgSnAtMcXa7Ta+8YHzZrUqdwR64DiShKf1F6uMvQQ8zPVX
         FJk3PFFsUBgkr3LT5XVeBl/BZfrNDpjp1Ll6AGvin+s/AzjscJmMj2dGgBnvCH88SLWQ
         N2FqpbzM9XzTHyYUdOsoRSYAFTOkXuihIgtU9zPW3b/qZkz5yTVsb4m2DqRaw/JOn4zI
         MG6LvZg9uPjGLhaDq9/hfoFZqkaQyyBtf08xARuPMRpZkcxdu6MwHGoORzk2huH00/VO
         viUBps08kVl+aM8OcpQPxl7/IZx6FA+dAH5osAvvtMBMn6neBfv3uxkoEMgmsOqDgyzN
         lWoA==
X-Gm-Message-State: AFq9FYLCnJDN8raa6p99CV2YApNcbCeVfI7BwQmg4aPzuPGjB3/+syPf
	RtWYMxKxAQoaT/AWcCHhVaxz0f/Hy6Jx07/l72f29iPyvH6g9CP6ET7qYxz7/UWmWD7QFVjp5L5
	0uCx4Jd6QKWAMpnp6AUrbDsTH965jD/hDuAIUyHVrs/hY5C3F+LRqPCqBGGYaYBDH6wC6XgTpM7
	msdRHMyQjj/2i6jMKcWIxMpRTSzGVQ2w/1ahQL74BMRN2E/xi4K9LQnt+c7zwRlDr4kNWd2vj2H
	ZCFf8yKVE0dbPfljwA=
X-Gm-Gg: AYBFou2FCCd7OknZoLzWxtB34AFRlil9qXlVkECK50aycJ6IO+7chVJWFtEGf658Ygo
	DZFJy3xurav9P//Fg4HTmxaoAQQlQCbRTghWtZOutUrV6mJLtgn3HJf8ziTYHc4PW74AjHhHK5M
	HJEf4lQJPK+ae1uq9b38pPj/5u44moe9JW2/+rODDM1eW5LwTTpXgQ0Rs/TB13Vypkqu3Ymb1s5
	4MQGEFy0e7g8Ixz8Pv+QXME4wEksX2JkzBikFZbj/yypdZN4xzsSrSZ+oD0nQJ8OZntwf9rJnG+
	cHPBj+8g30j56/8xGP85R1uUnRT/qgC8yRDGIn5Zecl7iN4bQyhS94lZi1w/0f2p7ea7RmnPUDJ
	QeVipe+XBAb4i9rRDuN5Tiv7KgqX7WLVM+aHj+3TttaRmw91nqiCfktK2nfHckprWvNrjNh+9wr
	ATpGRNTLJ3owvtw/tkJ1E1d4B399grHGtdyngo0031
X-Received: by 2002:a17:903:1a30:b0:2e3:598:75b8 with SMTP id d9443c01a7336-2eb364b0dc1mr5697745ad.27.1793308608185;
        Thu, 29 Oct 2026 14:16:48 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-28.dlp.protect.broadcom.com. [144.49.247.28])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2eb36935cf9sm121475ad.27.2026.10.29.14.16.47
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Oct 2026 14:16:48 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-9308eafb465so577344185a.2
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 14:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793308607; x=1793913407; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=//FswPmpGUCUeaiDqBbIuHbgZKjvPl5eO/5v7O9w/Ro=;
        b=cu3nR16RAdsJ5xY2rnUiRopuM59Nqqp0xX964Zk+REPuxZhGLSOd5xjiQX57pz4bGY
         zZinYzZVrzFxBGQ87gFeXy2dThaZa2wUW9qUK/fWnG3HMiw/41gyjK4bvzKgcg4cHi+L
         hCbNKxtIk+6xYqiEJpp3HY2GuHq5nPVIgXvZE=
X-Received: by 2002:a05:620a:444b:b0:93e:7dfa:2f3f with SMTP id af79cd13be357-944216fefebmr85371485a.62.1793308606939;
        Thu, 29 Oct 2026 14:16:46 -0700 (PDT)
X-Received: by 2002:a05:620a:444b:b0:93e:7dfa:2f3f with SMTP id af79cd13be357-944216fefebmr85366585a.62.1793308606424;
        Thu, 29 Oct 2026 14:16:46 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca314f888sm6326926d6.35.2026.10.29.14.16.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 14:16:45 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Jon Mason <jon.mason@broadcom.com>,
	Arnd Bergmann <arnd@arndb.de>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net v4 1/2] net: ethernet: bgmac: preserve forced 2.5 Gbps link speed
Date: Thu, 29 Oct 2026 14:15:39 -0700
Message-ID: <20261029211540.4123250-2-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261029211540.4123250-1-florian.fainelli@broadcom.com>
References: <20261029211540.4123250-1-florian.fainelli@broadcom.com>
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Northstar and Northstar Plus use a 2.5 Gbps internal link between the
AMAC and the switch.  BGMAC_FEAT_FORCE_SPEED_2500 makes bgmac_miiconfig()
configure that speed, but bgmac_adjust_link() subsequently replaces it
with the synthetic fixed PHY's 1 Gbps speed.

Use the forced speed when processing link changes so the MAC remains at
2.5 Gbps.  Together with configuring the switch IMP port for its 2 Gbps
mode, this eliminates the output queue discards that caused approximately
1000 TCP retransmissions per second during an iperf3 transmit test.

Restrict the platform forced-speed flag to Northstar Plus using the SoC
compatible, since Hurricane2 shares the AMAC compatible. Other platform
AMACs without a phy-handle must continue following the fixed PHY speed.
The BCMA path already selects the flag only for the Northstar family.

Fixes: f6a95a24957a ("net: ethernet: bgmac: Add platform device support")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/ethernet/broadcom/bgmac-platform.c | 3 ++-
 drivers/net/ethernet/broadcom/bgmac.c          | 8 ++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bgmac-platform.c b/drivers/net/ethernet/broadcom/bgmac-platform.c
index 4e266ce41180..4880b1890481 100644
--- a/drivers/net/ethernet/broadcom/bgmac-platform.c
+++ b/drivers/net/ethernet/broadcom/bgmac-platform.c
@@ -243,7 +243,8 @@ static int bgmac_probe(struct platform_device *pdev)
 		bgmac->phy_connect = platform_phy_connect;
 	} else {
 		bgmac->phy_connect = bgmac_phy_connect_direct;
-		bgmac->feature_flags |= BGMAC_FEAT_FORCE_SPEED_2500;
+		if (of_machine_is_compatible("brcm,nsp"))
+			bgmac->feature_flags |= BGMAC_FEAT_FORCE_SPEED_2500;
 	}
 
 	return bgmac_enet_probe(bgmac);
diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index 669eb7ce7d40..9ef7307edd41 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -1430,11 +1430,15 @@ void bgmac_adjust_link(struct net_device *net_dev)
 {
 	struct bgmac *bgmac = netdev_priv(net_dev);
 	struct phy_device *phy_dev = net_dev->phydev;
+	int speed = phy_dev->speed;
 	bool update = false;
 
+	if (bgmac->feature_flags & BGMAC_FEAT_FORCE_SPEED_2500)
+		speed = SPEED_2500;
+
 	if (phy_dev->link) {
-		if (phy_dev->speed != bgmac->mac_speed) {
-			bgmac->mac_speed = phy_dev->speed;
+		if (speed != bgmac->mac_speed) {
+			bgmac->mac_speed = speed;
 			update = true;
 		}
 
-- 
2.53.0

