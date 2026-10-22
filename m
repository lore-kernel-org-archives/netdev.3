Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.98
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792709841;
	b=AnUffbJhVgLfU813sI1WweeQhGseH5dWNUSRXJWl3uYogLn5amWJUXJDRE2ZKguauefM
	 HZ5cKjb86N3rNBV4bd0PfrMrp2hofKHv2rZd3Z6Gp45JnW0DFsu60SUjfsA9P1Ezhktte
	 PfytWRFOxO7iVXf3Fw+zaNHWdv6eAF5Mleo23U+k0VzKIKL1T1nM+uw0weLAmBsJvIIYW
	 MTc8pss+Yw5D7S9sd9f3XSM158Hgx8NjKoRPP9mBtPie1LkVmY6q0UU1wTKGnlJq0deKR
	 JT6jeEO2vkjMZ89wmshegfD1NdsHnaOy2ahYFGw+24eCH8a/URigD/Q8bgp3JGf9QVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792709841;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=OucDXYhGBdXsYkzJOkUEznMM0q6yUkDYhETeuLwQ0h8=;
	b=Q41ajuGOKcdi1lhxiQm8AtzqZWK8Gvk9KmwI6Bqa6O3JjR6rwFYHOSPM+mHaLftnit2k
	 k2CORQhLjFbAMSaf016x9Goo6eO+NurCxm9KvLxKKtTKARgOmbc3wIvx7WZPDaG55k2Tu
	 ww5mxayw2bAtvEEVnxDzRByxXRr1Qa/luZQhmxuBlQrUgH5liKHQKOfWgY2TWxSZroQHt
	 3zF66IAgAvuLKcGSG97gtQKWDSg3uwPjExcNMcHEjmU0CatUib2p+Cp82mmM+EJWTnN9w
	 02NhnyKG+bfSBuoxy3g1oD+1NPQgg2H+u83z8RKJE2PkbDg86mebWYbLpvj2uL1BaOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Wx4UHPbG;
	arc=none smtp.remote-ip=209.85.216.98
Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6599F606A332
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 22:57:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6599F606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=Wx4UHPbG
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3a4b3ac8fb7so181981a91.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792709841; x=1793314641;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OucDXYhGBdXsYkzJOkUEznMM0q6yUkDYhETeuLwQ0h8=;
        b=xQKb0Tc5Wxq8+eh9XkF6G+MAgUEdqekEK23twflnaQCCkaiR26u78O+hVNuBwtTftJ
         T3Qxn0j6XL9MAwwO4a6UvDp/cqv+n2zSijuc2IptbTUJpcskXePdRPFWDjWIDjUmfdwy
         ZWZ/fcplvrndsoTFeLG0rXsf4g8RWBCNRHw3pseFz7UplH70E/PSUVN/iAOiPNOd/iId
         Om/NAO2rpOx5uXnkSDejMOH4NDkZNLcZdLZAHqjbrbhC2AuBJVlXlhgGl8Ps2+8N5f/R
         tHh3oVjpVSmLoMl6n0F6QN63MH47VLTZA3dj1hGV11gvyQtGpkUncQ5DIWuNS6/uwH1j
         8h5w==
X-Gm-Message-State: AFq9FYLK4oqPr+ryhDVUgPttMKkYRtX0NIDYVny30obMseHNPOUZOnqQ
	KqiTrjvu1bHOwWyh8GByhX4TDmn+WQqynUw5MoWUNFd+0gNAEXwYXmwyp4rB9qIIQXCCsVZ3PsR
	2tCDytSwj75sneg9gD10U4ZvpEB+cxft4vBtSsI4pmFivWmi4tvdkn6NYzGEosYYBmsriyYZrYE
	EwrzmednNIAemPBszHk6V+6VRP+UW1I/BiKcvbHqWpB0VuilTRYMDdgao+lVkzYi+ZWRGWAaNV8
	bKQcVI+60sp4RRQ
X-Gm-Gg: AYBFou2HBHKFzIrp8frCkWq0ZSDcvfRmetPTDqWptkrOY8coliZXywraRzaJxqGnqdh
	ysfR2kJKyKOk4qK54nvKAPIs8kgM6tOXqG8qLDU9Um0bzPftYtmwCiokLO0u54xtO1LzZwyX5a5
	V2qiACyxdZLie2trJYFfkdyCrPK5KAxpRvDwDf6Qe86m30h7LRIbvYT6wL0bAbe69eTgFaqR5Im
	le5/waIzqdqwb92fv2sy5u6Da0tTk//QStEPexbLomYoWIIzeUvu8kgXUk+dY5dUVQXFGNY2bqw
	fy73QxkZmkGP2xsYxMBY583Ldc2jSojlAyWXJ+7CHW1NROjgLRnq4BIQ6vjeCaQm/yG1liAaNMI
	vR15N9LHGpZHgmUDFfwBhtz9X6J/4JOSDUl4QOIj1vD+P1wcFpSsnFwOCHsPMOkw5QF5uRYGCGj
	r3MAcnMjZfn2pKBlw0jhrCeDLFnqNByJDMq/uEQj/Ost4=
X-Received: by 2002:a17:90a:d80b:b0:3a7:e126:4980 with SMTP id 98e67ed59e1d1-3adce066466mr193958a91.43.1792709840607;
        Thu, 22 Oct 2026 15:57:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3adcd82a39bsm156690a91.2.2026.10.22.15.57.20
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Oct 2026 15:57:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-917baea8e5dso7400696d6.3
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1792709839; x=1793314639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OucDXYhGBdXsYkzJOkUEznMM0q6yUkDYhETeuLwQ0h8=;
        b=Wx4UHPbGv07jfQfElS3JNkHG6sMmKyEFEeiXrPfHvsyPnLMt28MWyf+fTju445KYiY
         YUO3jF0ufRmQeFfrLxA/w/BIpb41IEo2ueYEpmBBCL/BbomNaXJO9dVnNvh9NVGiUr/Y
         KxL0pKCdfePLykN3YtbCdPQosjJmVt8zmCHGo=
X-Received: by 2002:a05:6214:268b:b0:91b:83b7:b252 with SMTP id 6a1803df08f44-91c3a63bbaemr4401056d6.3.1792709839268;
        Thu, 22 Oct 2026 15:57:19 -0700 (PDT)
X-Received: by 2002:a05:6214:268b:b0:91b:83b7:b252 with SMTP id 6a1803df08f44-91c3a63bbaemr4400676d6.3.1792709838659;
        Thu, 22 Oct 2026 15:57:18 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c395025d0sm4501656d6.5.2026.10.22.15.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 15:57:17 -0700 (PDT)
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
	Russell King <linux@armlinux.org.uk>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net 3/6 RESEND] net: dsa: b53: constrain SerDes interfaces to initialized PCSes
Date: Thu, 22 Oct 2026 15:56:53 -0700
Message-ID: <20261022225656.1387306-4-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022225656.1387306-1-florian.fainelli@broadcom.com>
References: <20261022225656.1387306-1-florian.fainelli@broadcom.com>
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

Publish the supported interface bitmap on each successfully discovered
PCS and use it for capability reporting and PCS selection. Clear the
parallel interfaces inherited from the common switch code on ports whose
mux selects a SerDes. A failed discovery must not leave a usable serial
interface advertised without its PCS.

Stop advertising 2500BASE-X: the driver neither selects its baud rate nor
supports 2.5G in the MAC override code. The downstream robo SerDes speed
setter likewise only implements 10/100/1000. Keep SGMII and 1000BASE-X on
both lanes until a complete 2.5G programming path is available.

Report discovery failures at the SRAB port to make missing capabilities
diagnosable.

Fixes: 0e01491de646 ("net: dsa: b53: Add SerDes support")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/dsa/b53/b53_serdes.c | 28 ++++++++--------------------
 drivers/net/dsa/b53/b53_srab.c   |  9 +++++++--
 2 files changed, 15 insertions(+), 22 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_serdes.c b/drivers/net/dsa/b53/b53_serdes.c
index 87771e3788f7..d521050d7c8f 100644
--- a/drivers/net/dsa/b53/b53_serdes.c
+++ b/drivers/net/dsa/b53/b53_serdes.c
@@ -273,24 +273,11 @@ void b53_serdes_phylink_get_caps(struct b53_device *dev, int port,
 	if (lane == B53_INVALID_LANE)
 		return;
 
-	switch (lane) {
-	case 0:
-		/* It appears lane 0 supports 2500base-X and 1000base-X */
-		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
-			  config->supported_interfaces);
-		config->mac_capabilities |= MAC_2500FD;
-		fallthrough;
-	case 1:
-		/* It appears lane 1 only supports 1000base-X and SGMII */
-		__set_bit(PHY_INTERFACE_MODE_1000BASEX,
-			  config->supported_interfaces);
-		__set_bit(PHY_INTERFACE_MODE_SGMII,
-			  config->supported_interfaces);
-		config->mac_capabilities |= MAC_1000FD;
-		break;
-	default:
-		break;
-	}
+	if (lane >= B53_N_PCS || !dev->pcs[lane].dev)
+		return;
+
+	phy_interface_copy(config->supported_interfaces,
+			   dev->pcs[lane].pcs.supported_interfaces);
 }
 EXPORT_SYMBOL(b53_serdes_phylink_get_caps);
 
@@ -304,8 +291,7 @@ struct phylink_pcs *b53_serdes_phylink_mac_select_pcs(struct b53_device *dev,
 	    !dev->pcs[lane].dev)
 		return NULL;
 
-	if (!phy_interface_mode_is_8023z(interface) &&
-	    interface != PHY_INTERFACE_MODE_SGMII)
+	if (!test_bit(interface, dev->pcs[lane].pcs.supported_interfaces))
 		return NULL;
 
 	return &dev->pcs[lane].pcs;
@@ -351,6 +337,8 @@ int b53_serdes_init(struct b53_device *dev, int port)
 	pcs->dev = dev;
 	pcs->lane = lane;
 	pcs->pcs.ops = &b53_pcs_ops;
+	__set_bit(PHY_INTERFACE_MODE_SGMII, pcs->pcs.supported_interfaces);
+	__set_bit(PHY_INTERFACE_MODE_1000BASEX, pcs->pcs.supported_interfaces);
 
 	return 0;
 }
diff --git a/drivers/net/dsa/b53/b53_srab.c b/drivers/net/dsa/b53/b53_srab.c
index 9988a83fa7b7..77e81e1a414a 100644
--- a/drivers/net/dsa/b53/b53_srab.c
+++ b/drivers/net/dsa/b53/b53_srab.c
@@ -451,9 +451,11 @@ static void b53_srab_phylink_get_caps(struct b53_device *dev, int port,
 
 	switch (p->mode) {
 	case PHY_INTERFACE_MODE_SGMII:
+		/* The mux connects this port to a SerDes, not a parallel bus. */
+		phy_interface_zero(config->supported_interfaces);
 #if IS_ENABLED(CONFIG_B53_SERDES)
 		/* If p->mode indicates SGMII mode, that essentially means we
-		 * are using a serdes. As the serdes for the capabilities.
+		 * are using a SerDes. Ask it for the supported interfaces.
 		 */
 		b53_serdes_phylink_get_caps(dev, port, config);
 #endif
@@ -588,8 +590,11 @@ static void b53_srab_mux_init(struct platform_device *pdev)
 		case MUX_CONFIG_SGMII:
 			p->mode = PHY_INTERFACE_MODE_SGMII;
 			ret = b53_serdes_init(dev, port);
-			if (ret)
+			if (ret) {
+				dev_err(dev->dev, "port %d SerDes unavailable: %pe\n",
+					port, ERR_PTR(ret));
 				continue;
+			}
 			break;
 		case MUX_CONFIG_MII_LITE:
 			p->mode = PHY_INTERFACE_MODE_MII;
-- 
2.53.0

