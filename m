Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793140321;
	b=w3ofwPnfSj4kY09XP9vw8Cdo/rKQowo6QOUG1j3ecaelXRUE9/mI/oPF3J2Gc22bWliO
	 pi8s/5yvnaH+0B2GVWTdynTdD2JEcMFdCDtWdMAg+sOBhC0Eq5gTZD87aMUBmtGDaunu7
	 FzLO0Fq90akcaTGMKh9f26JSeiXZvlEPjZCjh8HWkLblb97mvf/3jBr3NUawGOcneAzic
	 wg8IBEtM9dupyiEoH4HN9qFHm/D/RwSFg3iSCQtV+Z/Oh1S90UgY4XUIPOERFVOT1DFc+
	 bCVLeQJxusC4eFeiJq/SfN0CG7l7QG0tu070WTxm41a6I6XSlbObWVfzD0wFltJz9Mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793140321;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qlkjggDKZvzL1qBD/gss+oMOAIYMRyrKeyJr/EKm3oQ=;
	b=uisucx+za6B/dv6J0Dj4xMYj9eo7foGbCqyyPJDWZXpn230VmCzZNvzzMsFujKQUz42s
	 G4y8ZLTo2kYjXerGesxuZPyHh47eXmJ2Ml+IrY1HWANpJNzbf+TPSKQlvEkLAQp8FZ10f
	 mfpkt+/7+oem2aMZ/88o36ndE7/D7Zj8VtPnh9q11za2F30J9ZIwEL+XJwLXic9yhMuFS
	 roi/BjYaxIMggzMp3Dw92iT7As94UknoJIBgUiRrGtvLXaSmS//RBeIYmcZD2L5KrZjWD
	 ON/sbWkGxvKSXwei5V1nRungcD04CqwATSclDGe6kA2y3hRqZ0QQTq2zVnm+b33o22A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IVYcG2rx;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07FE60A260C
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 22:32:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D07FE60A260C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IVYcG2rx
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1a2761c69fbso720746c88.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 15:32:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793140320; x=1793745120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qlkjggDKZvzL1qBD/gss+oMOAIYMRyrKeyJr/EKm3oQ=;
        b=IVYcG2rxhrnCuASVXg+H//hFJKkhpKHU1XWiw241uzglYBgilD5wbBYmLdCnDVIU4H
         xgTq8U+1g+IDgfqhJEZ6Qlm1gJk0CAZ5ETZ49899z8PSxxf7mkH/1GFmNx6/H9ol3IED
         qLmLwMjuG7Bui+mR/QcZ+HwVq7DTmaBnlubP5AF/F2tlY5M70pcapwn7mI0AK0Myhgz8
         oVfAoi5xVvguR2TdbodDWQeFA89HGLckBI6kkqEQVocmWzywA0wFdV0TMVwFRp6U/H5w
         RypEeIDSvkQT/aMDlIKwlpV7YO5oy433BkrDufRotzghOTBWctDMUIRLrv9uoLCwqq1q
         OZPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793140320; x=1793745120;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qlkjggDKZvzL1qBD/gss+oMOAIYMRyrKeyJr/EKm3oQ=;
        b=RV1VlypFGK5MpF4wNFTE9FiRdiJ4ZJUdlFWXUjY2yLUCQ1UwZtzC9p1GybHQRvYwBW
         ruZCcMpHaGEuqo2577a1FxhrA+m/VyW0E+2YQ5tR80pcKkX537fa/QDu+vNDorEB2zoX
         qt2Y6mAzUopfNIX69meyyB2lmCmBjKyf6m1HdRp18WuFByAbq8gPRwA03KfzJx1GKfy8
         YmvqPpInjw72gn825H+nfaPYJl6iDAo3sUp7ofAWrMwePXKLyC5dWHEuVoIZYVgQ7XXX
         bgyDyJDzYII6P/HTD+SjQivRCKXcHqwB9195ZjTLic/mpNxCE7VubK5g0iR5msSJFXaQ
         Zf4w==
X-Gm-Message-State: AFq9FYLQxjL7jHYmFKMFl+9MoR2CRc937j8++yNXC0stp1OTq/soCCCX
	D7jECKbRTD0mPEds/I8cW793tPOaGdmoBspUZXR+bo+AWyDuScwyjV3OWuHoDfc3
X-Gm-Gg: AYBFou1fPPwGpC37NXAN7/umsXgfk+3beGUusI3lFffFey23k7jPAMFqN6sdZe40ji6
	Cjyk/jfq99L/muREU39VRXc51sFiU9osxQRIbq5+UzRvzy9RN1eC1QETiLVGvWPAvfKOss8pAaj
	lsjwdOATByvvs4ZrgvdSXO9GIMqYJvb9sdW/XkLWJ1TSrTecsOAQEGX6YTVtdEz3gC2svx5KD7s
	0DCDYxc5cgOolYluP34AxYFK2UOCDxrZuFVfsIx8Xirds/ts8DGEHz39d2dFac3ZC7D+p7oEBWm
	wj1f98zpR9oaGZJws9BlQn8SuFV+aKNbyl+ZQCFkH8X740e2TLyPyc6CvwmB6jZA7nkpXOb4CC1
	T5oza/W3QDIuoHFX3xUoMyZDN9JPq3L83duSS8G5ZQyZnWvEWOcftatn0ZhMkd27QaVUb202Ix8
	l+4Qg06JABzvwaYmwhdMFGGlaWkaaZcSj+TjhpIqojvb13+1EdhdtFmNKViX9ntGPJIkAMnY1ho
	eIPXDv92IvqfoRQ2jdz4n7gg5mrK3pVXy0k+LC637soOeapE8xKDIMt3sJsLnWwzpXLw26I3m/b
	pJJLH5Q3lySEyo9CvEVowUKTV/NTt4CbdnPp8a6ZHPBMEiw2ncycTQkILrxFLpswXCGciqOqfVZ
	/
X-Received: by 2002:a05:7022:fd04:b0:16c:eaf1:335d with SMTP id a92af1059eb24-1a6ce2fea82mr1069692c88.30.1793140319805;
        Tue, 27 Oct 2026 15:31:59 -0700 (PDT)
Received: from eldorado (ip70-187-214-22.oc.oc.cox.net. [70.187.214.22])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a6d98c93d7sm1130735c88.13.2026.10.27.15.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 15:31:59 -0700 (PDT)
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
Subject: [PATCH net 04/11] net: au1000: report MDIO transaction timeouts
Date: Tue, 27 Oct 2026 15:31:33 -0700
Message-ID: <20261027223140.3774570-5-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027223140.3774570-1-f.fainelli@gmail.com>
References: <20261027223140.3774570-1-f.fainelli@gmail.com>
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

The MDIO write callback reports success even if the controller stays
busy and no write is issued. Propagate timeout errors and wait for write
completion so failure of the final transaction is reported to phylib as
well. Return ETIMEDOUT for read timeouts too.

Fixes: 0638dec01e89 ("[PATCH] net: au1000_eth: PHY framework conversion")
Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/net/ethernet/amd/au1000_eth.c | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/amd/au1000_eth.c b/drivers/net/ethernet/amd/au1000_eth.c
index 70319b432182..a507a524370f 100644
--- a/drivers/net/ethernet/amd/au1000_eth.c
+++ b/drivers/net/ethernet/amd/au1000_eth.c
@@ -278,7 +278,7 @@ static int au1000_mdio_read(struct net_device *dev, int phy_addr, int reg)
 		mdelay(1);
 		if (--timedout == 0) {
 			netdev_err(dev, "read_MII busy timeout!!\n");
-			return -1;
+			return -ETIMEDOUT;
 		}
 	}
 
@@ -292,14 +292,14 @@ static int au1000_mdio_read(struct net_device *dev, int phy_addr, int reg)
 		mdelay(1);
 		if (--timedout == 0) {
 			netdev_err(dev, "mdio_read busy timeout!!\n");
-			return -1;
+			return -ETIMEDOUT;
 		}
 	}
 	return readl(mii_data_reg);
 }
 
-static void au1000_mdio_write(struct net_device *dev, int phy_addr,
-			      int reg, u16 value)
+static int au1000_mdio_write(struct net_device *dev, int phy_addr,
+			     int reg, u16 value)
 {
 	struct au1000_private *aup = netdev_priv(dev);
 	u32 *const mii_control_reg = &aup->mac->mii_control;
@@ -311,7 +311,7 @@ static void au1000_mdio_write(struct net_device *dev, int phy_addr,
 		mdelay(1);
 		if (--timedout == 0) {
 			netdev_err(dev, "mdio_write busy timeout!!\n");
-			return;
+			return -ETIMEDOUT;
 		}
 	}
 
@@ -320,6 +320,17 @@ static void au1000_mdio_write(struct net_device *dev, int phy_addr,
 
 	writel(value, mii_data_reg);
 	writel(mii_control, mii_control_reg);
+
+	timedout = 20;
+	while (readl(mii_control_reg) & MAC_MII_BUSY) {
+		mdelay(1);
+		if (--timedout == 0) {
+			netdev_err(dev, "mdio_write busy timeout!!\n");
+			return -ETIMEDOUT;
+		}
+	}
+
+	return 0;
 }
 
 static int au1000_mdiobus_read(struct mii_bus *bus, int phy_addr, int regnum)
@@ -344,8 +355,7 @@ static int au1000_mdiobus_write(struct mii_bus *bus, int phy_addr, int regnum,
 	 */
 	au1000_enable_mac(dev, 0);
 
-	au1000_mdio_write(dev, phy_addr, regnum, value);
-	return 0;
+	return au1000_mdio_write(dev, phy_addr, regnum, value);
 }
 
 static int au1000_mdiobus_reset(struct mii_bus *bus)
-- 
2.53.0

