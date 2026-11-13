Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.226
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794604584;
	b=FCanwTg5UsfVn3JGXirdFFN8MuwLr4jUPh8w3+tu9j2t8DWnQ+jIVsWMIllJDqaoXmRG
	 8ADX8YEiPYBYMGO0hV/g2UKn8X4elJ/7XzSTCcUTESdPjdkas/eR+1eN9wShwI15gaHZw
	 I3ZKKbJ7KdXt1ppG5fe7bGYMwSFRkiXzb4fjx5OtUrRsWkTBtpR+3+q31nHWTt/hF8ymP
	 bTtxppCpJJQL9rx9NbnH35tvKmof+TTQvsGvfMPasb7XVzPSKTVIsrF8uZ5hH2bzrt2As
	 fbGY5c71FutU7sw870fj2VCa0472FDG9l4H8A54vkUg9JXv7M8qOxdQn8yXYAjIKa/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794604584;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-DetectorID-Processed;
	bh=REMqjhcT8PUofM8kCe064WG9qt5BO/yjjbQ0zdHompI=;
	b=uWNeR4akqMCitwyhZmD+Ld8sErgflVJBboGvZwXYf2uPIMmXN+aGr2koip0dnLjX79nk
	 siWynyb9OJQtpgNAgGlRh6u5Tq7f+709/TaEDrwx3kibUdpZEYrrvXrPFtl7z6JrNZm4Q
	 VccXYAp3CtcvCFlyL2O/r3DMhg8e1RY5PF+IbLxBSRUxSYuhkqYDtLtnzm5F8E2FxZ86J
	 WgMJqW/0WMPgICIZ+nLDVz+86Lx3N18VP2WYC9XFyFjDDjwXbpHb0VdA3/FatMVG1j9iw
	 6mgZWBUr90tigq2n8/82poYlGUD1a7t/4gefDFe4ByKEYLH0IayoAvwJgQ5PUWs6e5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=F65JNHJs;
	arc=none smtp.remote-ip=209.85.214.226
Received: from mail-pl1-f226.google.com (mail-pl1-f226.google.com [209.85.214.226])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1302E606A882
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 21:16:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1302E606A882
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=F65JNHJs
Received: by mail-pl1-f226.google.com with SMTP id d9443c01a7336-2ed1e9ae5a8so5245225ad.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 13:16:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794604583; x=1795209383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=REMqjhcT8PUofM8kCe064WG9qt5BO/yjjbQ0zdHompI=;
        b=zqPzRRlO6wnnr00lAEQLwr4BUv/FYNX8wk9dn3ti1Q3Zp/CPzgoWpskLS4JLSLWpg6
         Az0czBpnPaWh/dNF3d0/P0ZwrM7h0Pg8R4SSuHoH+Tp0Gv5HMGhQAYooCnIV222Xkgge
         1VIXLzijxJ1vPSvTzlJc64nC4GFyvtUGOjqSLqxDehHfAtOM2voZeWAQeXlfRRROkKIS
         eYIe2D42FUVTBrmeKCLp6c65NQm/Z9LhEcYW50EpWwUMSkdjt8KZpPrS5+6L8J2Z4AmG
         DHZL2VSb9KsugbqcrIlKm03xzPQmQz5q+zV0I/HL8I6AzeKklLYasIV52e+t7hEKpTjz
         5+2Q==
X-Gm-Message-State: APuU4Z/N6+KluXpWRC7CYG/HDBbUDat/Z7fJP2QY8wI8Y3MCGYh2nkp0
	8aiAA+0pcsuEhgstlXNGsL2dQfWOwURwxlkXqogFEAWGGvawM29Tnn/J2XoGxDMeG/pCWhmhkEX
	ct1/+Oz+2VIwUdWZx8xJoroho8XFOVFtquIWFfS1vZuHvN+hbyzEp61trwLsW/TBq8QvWz+7xxS
	awMjUEfBLSiztWRw8PrZaeu5awk8UjUJZDs/PLmqIgQnoO2WAmePCNUYtNz9cXZwWG/dXtBIpcC
	9bNkm5C/r5h23Z4
X-Gm-Gg: AYBFou3MVysndIC/97Ggsjh4BThOb9myuLp0XahcWt+sSz4SkOB59/J/40GAqsY0ekv
	hqjgfJQWTyre33h4Rg5fbFdWanSq2dJxC2N0gsVeieYhvimM4hYW8wTbdJO3tUwABl9WQ1s7syt
	RMU9AD5HCQm+TL9BZC/NREKAPe/OozKAX9sYzt13VKWtCQfZfaLlMHhdakfuGWF9CPI1cSdbY71
	CCjHRF+0qKlFVRBapY2uiDHFWK5on2UPzyPbE6erN8hGLycZlXrFaTIoZYSGURm8b+fonBLn3TN
	L65IXe+2x6fvz5ITvqrSh0bQvTVK93H2g4RU2S2ae2xp7whfzO1WbHv9bY3u05CjXYwpP/a/7IR
	l5+otDoMGFGpTGywdD3/IxCj2rmQRUYujVnwbBHLPBy19xVNheAvMrDaUF51flO4n6JEnaTD3ne
	xUwYqir30Ec1NMUvwURKM1kUciBWAW/Mx2tofU6QNvd5w=
X-Received: by 2002:a17:90b:3ec4:b0:3a0:b312:1fbe with SMTP id 98e67ed59e1d1-3b1b0a1bdcemr3572322a91.23.1794604583307;
        Fri, 13 Nov 2026 13:16:23 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-119.dlp.protect.broadcom.com. [144.49.247.119])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3b1ae96f125sm5245417a91.4.2026.11.13.13.16.22
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Nov 2026 13:16:23 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93f20addba1so293721185a.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 13:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794604582; x=1795209382; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=REMqjhcT8PUofM8kCe064WG9qt5BO/yjjbQ0zdHompI=;
        b=F65JNHJsuKoNa+DxTouGa3jnTj32muWjNhCNJjr4ZxYGTsYPbYZE9s4LpEU25Z1+W4
         wy717nLY0e9Yvv7QdMdhAp1XJ1mH3TUvkOJYS6ro8n1zb/2nDNS9g2Eq8quFYDrM/8LY
         wrohySFVFeIhyYAUusQQK2eZ86Wvzpg6jEeYU=
X-Received: by 2002:a05:620a:6cc5:b0:93f:16d4:3bf0 with SMTP id af79cd13be357-9494bb53433mr686918885a.42.1794604581924;
        Fri, 13 Nov 2026 13:16:21 -0800 (PST)
X-Received: by 2002:a05:620a:6cc5:b0:93f:16d4:3bf0 with SMTP id af79cd13be357-9494bb53433mr686912685a.42.1794604581301;
        Fri, 13 Nov 2026 13:16:21 -0800 (PST)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9494c8f92bbsm273474385a.40.2026.11.13.13.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 13:16:19 -0800 (PST)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Carlos Soto <carlos.soto@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Nicolai Buchwitz <nb@tipi-net.de>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list),
	Mlody12 mlody12 <kudzo51@gmail.com>
Subject: [PATCH net-next 2/3] net: mdio: mdio-bcm-unimac: Poll for completion at 1us granularity
Date: Fri, 13 Nov 2026 13:15:53 -0800
Message-Id: <20261113211554.2058181-3-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261113211554.2058181-1-florian.fainelli@broadcom.com>
References: <20261113211554.2058181-1-florian.fainelli@broadcom.com>
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

The current polling code unconditionally waits 30us, which was sized for
a ~25us Clause 22 transaction, and then polls MDIO_CMD with a sleep of up
to 2ms between samples.

Adding Clause 45 support means that every access becomes two back to back
transactions (an ADDR cycle followed by a READ/WRITE cycle), so a fixed
delay sized for a single C22 transaction is no longer meaningful, and a
sleep of up to 2ms between samples can add significant latency to each
access when the transaction has not completed at the first sample.

Instead, poll the MDIO_START_BUSY bit every microsecond so that the
completion is noticed as soon as it happens, regardless of the type of
transaction. This turns the wait into a busy wait, which is bounded by a
timeout reduced from 100ms to 1ms: a 64 bit MDIO frame takes about 33us at
the lowest MDIO clock the driver can program from a 250MHz reference clock,
so even a two frame C45 access completes well within that.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Co-developed-by: Carlos Soto <carlos.soto@broadcom.com>
Signed-off-by: Carlos Soto <carlos.soto@broadcom.com>
---
 drivers/net/mdio/mdio-bcm-unimac.c | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/net/mdio/mdio-bcm-unimac.c b/drivers/net/mdio/mdio-bcm-unimac.c
index 6df824aba75e..15a9880c3573 100644
--- a/drivers/net/mdio/mdio-bcm-unimac.c
+++ b/drivers/net/mdio/mdio-bcm-unimac.c
@@ -6,8 +6,8 @@
  */
 
 #include <linux/clk.h>
-#include <linux/delay.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -36,6 +36,13 @@
 #define  MDIO_CLK_DIV_MASK	0x3F
 #define  MDIO_SUPP_PREAMBLE	(1 << 12)
 
+/* A 64 bit MDIO frame takes ~25us at 2.5MHz and ~33us at the lowest MDIO
+ * clock the driver can program from a 250MHz reference clock. A C45 access is
+ * two frames, so a 1ms timeout leaves a wide margin.
+ */
+#define MDIO_POLL_DELAY_US	1
+#define MDIO_POLL_TIMEOUT_US	1000
+
 struct unimac_mdio_priv {
 	struct mii_bus		*mii_bus;
 	void __iomem		*base;
@@ -79,14 +86,14 @@ static int unimac_mdio_poll(void *wait_func_data)
 	struct unimac_mdio_priv *priv = wait_func_data;
 	u32 val;
 
-	/*
-	 * C22 transactions should take ~25 usec, will need to adjust
-	 * if C45 support is added.
+	/* C22 transactions should take ~25 usec, C45 transactions take about
+	 * twice as long since they need an address and a data cycle.
 	 */
-	udelay(30);
-
-	return read_poll_timeout(unimac_mdio_readl, val, !(val & MDIO_START_BUSY),
-				 2000, 100000, false, priv, MDIO_CMD);
+	return read_poll_timeout_atomic(unimac_mdio_readl, val,
+					!(val & MDIO_START_BUSY),
+					MDIO_POLL_DELAY_US,
+					MDIO_POLL_TIMEOUT_US, false, priv,
+					MDIO_CMD);
 }
 
 static int unimac_mdio_read(struct mii_bus *bus, int phy_id, int reg)
-- 
2.34.1

