Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E06D1402442
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 09:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786526200; cv=none; b=e94beoZIlH+edV85wkosNzDfGo5LYQZ4VAsEXuxsg8FKvcAdwRiw8hDbdViRH8HACY2lu2nUqBFPwsAslNPvjupomBpCO0P3jdJnuzkSVQuCRnDT21fYrM5jzh23VE6hwNF3NklRpqALpe6NzH7Gb4SX1lykGoLbkIIVxX6OwZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786526200; c=relaxed/simple;
	bh=ICXHGcoY2ecHvg+D5oryNwAq4fVUNQdRPWucFxZaqu4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MrHe4TzjRU/8asQBCWxIbJ0v64aOsY9hc7ZhSKOykNGoHYnVp3QL9Y1NlYCgtTNwJSVIUOzjp3QyfzF1Xt/dWmuPEP+EzDr/57rg9ueDu3GG/e3Se8hSyL5m0wWbO+tEuft/icXULRIQtqP6XFDXUzoQGeynSdnqDF6VB97zsd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HzJEKBqf; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HzJEKBqf"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-80bb41f7f3cso7696397b3.2
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 02:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786526198; x=1787130998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6z7Hza0H/onaxr+xIKCmR+SSdXzhyhvKR4KIJJ9N1+o=;
        b=HzJEKBqfEN+EIwsGLH8aw9mFGX/I+18qiEb7td6wZ6KLf7xF2n7u/RJdZLI6bFJCVq
         Al/43/CrOFQxzgVAnCd8DJzPKprcnaU2g8re9FPmLIJqtsC/WCwB0WuOBWXRGKILiHDK
         ujj0iLPhezw4S1dzDJPKA2zfU1SdrSeM65LfrVWzq9qAIFnCAEmttrL0FzX9qO/suRAd
         gpxteNcEuTbbYYiW/FZ5lPIkt11lCoDhM1mBstVVOXH0OFdw0wS9SDgZC+1mKl2CrzJW
         yTOSZZHZU4t60EUYEnxDB+UME5zEn/HZ7Z0W6EletscNCFmiybteeyDNKJuN3EdTkM/2
         qgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786526198; x=1787130998;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6z7Hza0H/onaxr+xIKCmR+SSdXzhyhvKR4KIJJ9N1+o=;
        b=dV6u28mGMAusln3zS3eSn0YMe+F+vky67eebr2byr6KLKZ6Yo1249vHwC8Ri9rIPb0
         b7CBa9OqSht+w1B2riuNeHIAHX93c31SOh41C3Loa5943QlGdFfDXb7AAyZYDXJsMboB
         zez2jaGbacGRZ591QrR+wtijT0i1j/zVywvTZyq3yQYRx/ePWXJE+9SdCTjZVT2KpMOJ
         SlIvueXQ9IuwLvVqLQlItYViKOx0oVLn6LNcQIbnOO5gFSDVuVN16vEbe4EtqlunHy3X
         +19fAPQNi3nINq8wM2m1KEnol26wkUtQA3hFSoPNxtgK0Vav/YvQiyHiL+q4T/rIRRDQ
         SL9g==
X-Gm-Message-State: AOJu0Yx3jQ+aLuHVxC2/BurIA/KJMl2NT+YC10vy3FAQEY52oLguwXwj
	lWX/xKMQQnd4ktkSi6FWDjZftxfwh/0DQIHE9F1r6BSZXDYZe5At+X5t
X-Gm-Gg: AR+sD13twcqLnSwPfRMclUPkKMC50/A+Bnjnj5qSYfR18iF7sMcHxoMCEk7+yaVUIZH
	yjkFbuzAjWj/bdcON/xt9rdXK4Eo/hZEOnkJ/HP0LVdJgyWx3KXLOsA8ZV8CgQG1Dfj7917F+oh
	kzCQpkaqyLoSm/2lovTrWJbPP5zDZAyii/ZJ0R0T+EQs8p3pqnCOaB5XNiXAoUGLy9mGfUdBS0R
	IkPks4wWLPjHA4509n+tI9LkVhIu9b+xh2TiOM5X7RqFq8OAIRQJo3RY5AURPjmCxQkbo5p/fHp
	bR57QFlR6joX2lsVQhtmwU+8ulii+HaYISfT7yLor9FdZ5dQmeVGHGdgJAhmLNtoknS0i4+oO6/
	UJ4q+X7FBxfTJvBUubzVSOZw5d0vJDPErTeu+eIi+S+H9Sj/rtN9A0HF/TFaTAWzC0nGzYePyFP
	BacmE0kTUJrs1txyxLNVxQXP9osIVS0UIm0ONgUWvDXU8z/hf4cb58WlP2x4DqbB0lAPKAuybtD
	jHVrKKGncCmnD3I475H1ytzLjrkqskQKusmHk3SfqTaVb1BaiuNKu1ON84Yo+/n2sRglQ7EhrqM
	jg==
X-Received: by 2002:a05:690c:16:b0:81d:c233:aea0 with SMTP id 00721157ae682-8310a4c21b5mr16836697b3.18.1786526197784;
        Wed, 12 Aug 2026 02:16:37 -0700 (PDT)
Received: from f4eb3c51122b.sjc.aristanetworks.com ([103.174.170.5])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-830a368e71esm10368327b3.8.2026.08.12.02.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 02:16:37 -0700 (PDT)
From: James <aslan.jnn@gmail.com>
To: Raju Rangoju <Raju.Rangoju@amd.com>,
	Prashanth Kumar K R <PrashanthKumar.K.R@amd.com>
Cc: netdev@vger.kernel.org,
	Thomas.Lendacky@amd.com,
	James Nugraha <aslan.jnn@gmail.com>
Subject: [PATCH net] net: amd-xgbe: support receiving packets with bad FCS
Date: Wed, 12 Aug 2026 09:16:16 +0000
Message-ID: <20260812091616.35811-1-aslan.jnn@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: James Nugraha <aslan.jnn@gmail.com>

The driver currently sets the MAC_RCR.DCRCC bit whenever RX is enabled.
This disables hardware FCS validation, causing packets with a bad FCS to
be accepted unconditionally. Users cannot control this behavior because
the driver does not advertise NETIF_F_RXALL.

Advertise NETIF_F_RXALL and disable it by default. Update DCRCC when the
RXALL feature is enabled or disabled, and preserve the selected state
across RX and link stop/start cycles.

Fixes: c5aa9e3b8156 ("amd-xgbe: Initial AMD 10GbE platform driver")
Signed-off-by: James Nugraha <aslan.jnn@gmail.com>
---
Tests:
- Verified invalid-FCS packets are dropped with RXALL disabled.
- Verified invalid-FCS packets are received with RXALL enabled.
- Verified invalid-FCS packets are dropped again after RXALL is disabled.
- Verified the RXALL setting survives RX stop/start.
- Verified the RXALL setting survives link down/up.
- Verified RXALL is disabled by default.

 drivers/net/ethernet/amd/xgbe/xgbe-dev.c  |  3 +--
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c  |  7 ++++++-
 drivers/net/ethernet/amd/xgbe/xgbe-main.c |  7 +++++--
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
index 1f350d3bd..ad2030517 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-dev.c
@@ -3455,7 +3455,8 @@ static void xgbe_enable_rx(struct xgbe_prv_data *pdata)
 	XGMAC_IOWRITE(pdata, MAC_RQC0R, reg_val);
 
 	/* Enable MAC Rx */
-	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, DCRCC, 1);
+	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, DCRCC,
+			   !!(pdata->netdev->features & NETIF_F_RXALL));
 	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, CST, 1);
 	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, ACS, 1);
 	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, RE, 1);
@@ -3466,7 +3467,6 @@ static void xgbe_disable_rx(struct xgbe_prv_data *pdata)
 	unsigned int i;
 
 	/* Disable MAC Rx */
-	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, DCRCC, 0);
 	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, CST, 0);
 	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, ACS, 0);
 	XGMAC_IOWRITE_BITS(pdata, MAC_RCR, RE, 0);
 
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 3a79fd054..5fb81bea1 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -2247,13 +2247,14 @@ static int xgbe_set_features(struct net_device *netdev,
 {
 	struct xgbe_prv_data *pdata = netdev_priv(netdev);
 	struct xgbe_hw_if *hw_if = &pdata->hw_if;
-	netdev_features_t rxhash, rxcsum, rxvlan, rxvlan_filter;
+	netdev_features_t rxhash, rxcsum, rxvlan, rxvlan_filter, rxall;
 	int ret = 0;
 
 	rxhash = pdata->netdev_features & NETIF_F_RXHASH;
 	rxcsum = pdata->netdev_features & NETIF_F_RXCSUM;
 	rxvlan = pdata->netdev_features & NETIF_F_HW_VLAN_CTAG_RX;
 	rxvlan_filter = pdata->netdev_features & NETIF_F_HW_VLAN_CTAG_FILTER;
+	rxall = pdata->netdev_features & NETIF_F_RXALL;
 
 	if ((features & NETIF_F_RXHASH) && !rxhash)
 		ret = hw_if->enable_rss(pdata);
@@ -2284,6 +2285,10 @@ static int xgbe_set_features(struct net_device *netdev,
 	else if (!(features & NETIF_F_HW_VLAN_CTAG_FILTER) && rxvlan_filter)
 		hw_if->disable_rx_vlan_filtering(pdata);
 
+	if ((features & NETIF_F_RXALL) != rxall)
+		XGMAC_IOWRITE_BITS(pdata, MAC_RCR, DCRCC,
+				   !!(features & NETIF_F_RXALL));
+
 	pdata->netdev_features = features;
 
 	DBGPR("<--xgbe_set_features\n");
 
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-main.c b/drivers/net/ethernet/amd/xgbe/xgbe-main.c
index 0e8698928..898146b67 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-main.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-main.c
@@ -351,7 +351,8 @@ int xgbe_config_netdev(struct xgbe_prv_data *pdata)
 			      NETIF_F_GRO |
 			      NETIF_F_HW_VLAN_CTAG_RX |
 			      NETIF_F_HW_VLAN_CTAG_TX |
-			      NETIF_F_HW_VLAN_CTAG_FILTER;
+			      NETIF_F_HW_VLAN_CTAG_FILTER |
+			      NETIF_F_RXALL;
 
 	if (pdata->hw_feat.rss)
 		netdev->hw_features |= NETIF_F_RXHASH;
@@ -382,2 +382,4 @@ int xgbe_config_netdev(struct xgbe_prv_data *pdata)
 	netdev->features |= netdev->hw_features;
+	/* disable RXALL by default */
+	netdev->features &= ~NETIF_F_RXALL;
 	pdata->netdev_features = netdev->features;
