Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69BF4DD6F5
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 21:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790287201; cv=none; b=CxrV5I4uFYZlDzngW94tkX3RrA8m1AyeZL+Q+e8c+AmYOGl8i2tzg1VdgV+DZlgZ8OCZmozU8AZyawHeW2vaZxqUjal0q82ERs6oSBUYg6zRd4UXe7HF9zf1BavysBnZnSAlyp7wEb2Ahlk+yksSpEYfR/fFofENCVeqJGjWFYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790287201; c=relaxed/simple;
	bh=vEy4ilH+KqsEZF3cOIjyFr9T0T/kUsGLP7hbMpz+0Zo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tTgVgCJY4tEXB/J1qgmKVy+Ck0u+sHmW4uCkcDQg1Sm/A3NsZj4aKOGPJZS5Zk4GpiM1k4UnWfKqUisAOBRBroXTWFLe3y3uqxCk6T58B429bb3MkPT1kZnFoeB1qcTOOQYwLky1pFCnU7/NXviTpM/Xffw6m/L1LDGaYpbH8Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=V+JsaQuW; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="V+JsaQuW"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485984ebf5cso197587f8f.0
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 14:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1790287197; x=1790891997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7hECQ91MjmL9J8JDRPNlgIqAOO9M9chA074io5HZLms=;
        b=V+JsaQuWrCh81zWhB/brhgWaE3+h7l4y/BdyrxmhlnC/kTn+hXF1xQNd6ItGkGq3qc
         3DQmsXHlSfLXzAcLeY7s2+jRQSIktopVtv3uj+pyyavx0VrzVGduwgvtf6CgBZj6Fq4H
         SY5NQ8ZWgnddp8BiIYxoLYczzJqxNmV6ABg02rKreLsruuidMIs/7JLxoU/RLTX+NanL
         qtbF+p+M0VD85drK5GH6wiiiJBCkd+H1rfl/6KOerH3oLcD9W1GpUjLlh9pKbjs+rTu1
         w7H9sgsGIhXU0Ar1aXTiv3SOLoj4PeCUbEAvWETbG1fYhuAaPS082HodPcohPPFinPaa
         9SXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790287197; x=1790891997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7hECQ91MjmL9J8JDRPNlgIqAOO9M9chA074io5HZLms=;
        b=bVKynW3N02V4l4ClwbV+ybQoxDCnQgMAsCfhVXHZQSBspeh3vhl9U1uFSMI7u0xc3/
         5qyo5QC03BcHw60B3mQWxt9fSu8cSoxsvgEFnFf2N0EfVB/CNfre8h8n0CEYoIeN6BoL
         91BV+Yvz/iFmmHy05ROeYRKcdNyy/erIn+1kbXSbOCOIsaa1J02A0GIzdaKaDPhBsq4D
         8YPouDUuJfylAxOmCh7w8cTTo6DM82fmBqnqmn/Ofuy4iOqMs6hs5HZiZxBEUgf+4vab
         gcquaqFOXR2MwpD5aqWxFbmyzez2gG74o25Y+1KEBguFz7Ocn47+iS6GlFILJbXG4GzQ
         87Jw==
X-Forwarded-Encrypted: i=1; AKwUvBxnjeidkKNDg5c+sxEVZ0Vc432vRpW0UkbzKJSYXMKlfmVNiyxjEw7sDCR7xFS3cfsk8whXx+4=@vger.kernel.org
X-Gm-Message-State: AFuF++kyqwjayGGyPEY9DycpmFi28Hi5fyb/SaWPXiDTIPb2qnpdy8yE
	puadikr0RLKorq1cS7GIP+yojeqkIbI+zV++Lpi1Gze1DDGKvIukw1PcpIZ9wdtqMEA=
X-Gm-Gg: AYBFou2OkVSKOKlimgB4VpRdwxjwirWVBtrxetyIwM7NfPXsqAR+DnvA41WCdNBa4Y+
	ld/W8/ZeV0jgywnhLbaYbQsmUSng01iRfVq6r9B/U3a/JqIajQxseAyc+scVCEsWG/7Yz/HNnQx
	q8y2EZw3uNsWImxIRLBD3d06WkL6cloyMv3GsspltoMRz5jeASZOGdGcT1cikmb5ePWZ02ARTHg
	a3nL7DvAvVgpEd8lD5NFV2Qp4oS9B85tcfUhfEMa15Pa+oyh8MtaPWg7J6ExDmoohK5YyRmUpY/
	UC68BRDujPvkF4CS2TY69sao3+PeOR2RUTDTOIveQxJUFvpGOECvlCy/IopORAoSvUzGsN5OeZm
	iaAwzz/3acnzyZCaJLyCxkeAk5G6qnMHIFd+0YDhd1JkzSX/nGtlJEjGd87c4pNybzfKfMnnX56
	IuiyknMVBssnHginYd/jC3FI1cgW4dtY51UB8q0G7cO5kU+75hmdbm1iIFiz1Q
X-Received: by 2002:a05:6000:2584:b0:487:f93:c8d9 with SMTP id ffacd0b85a97d-48872ad7862mr6052233f8f.54.1790287197677;
        Thu, 24 Sep 2026 14:59:57 -0700 (PDT)
Received: from remote-01 ([84.17.55.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a34a638sm1922324f8f.9.2026.09.24.14.59.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 14:59:57 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org,
	Florian Fainelli <f.fainelli@gmail.com>,
	Mao Wenan <maowenan@huawei.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net v3 1/4] net: phy: refuse a second attach before touching the PHY
Date: Fri, 25 Sep 2026 00:59:47 +0300
Message-ID: <20260924215951.2127682-2-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260924215951.2127682-1-f@lex.la>
References: <20260924215951.2127682-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

phy_attach_direct() tests phydev->attached_dev only after it has taken
its references and, for a PHY with no driver, bound the generic one, and
then leaves through the error path that calls phy_detach(). That
phy_detach() works on the PHY's current attachment, so a second attach
of a PHY in use tears down the first consumer: it clears that netdev's
phydev pointer and the PHY's attached_dev, removes the sysfs links,
suspends the PHY and, for the generic driver, unbinds it, while the
first consumer goes on using the PHY.

Found in review of a change that makes phy_detach() put only the
module the attach recorded: with it, this path leaves the first
consumer's reference pinned. On a Keenetic KN-1012, a test module
attaching a second netdev to the EN8811H that the lan4 DSA port holds
got -EBUSY and left lan4 with no PHY; with this change lan4 kept it.

Test attached_dev before anything is taken and return from there.

Fixes: a7dac9f9c169 ("phy: fix error case of phy_led_triggers_(un)register")
Assisted-by: LLM
Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
 drivers/net/phy/phy_device.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 94b2e85e00a3..7046976c5b6a 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1757,6 +1757,11 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 	struct module *ndev_owner = NULL;
 	int err;
 
+	if (phydev->attached_dev) {
+		phydev_err(phydev, "PHY already attached\n");
+		return -EBUSY;
+	}
+
 	/* For Ethernet device drivers that register their own MDIO bus, we
 	 * will have bus->owner match ndev_mod, so we do not want to increment
 	 * our own module->refcnt here, otherwise we would not be able to
@@ -1798,12 +1803,6 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 			goto error_module_put;
 	}
 
-	if (phydev->attached_dev) {
-		dev_err(&dev->dev, "PHY already attached\n");
-		err = -EBUSY;
-		goto error;
-	}
-
 	phydev->phy_link_change = phy_link_change;
 	if (dev) {
 		phydev->attached_dev = dev;
-- 
2.53.0

