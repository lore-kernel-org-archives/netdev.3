Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 331093F3285
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 10:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787567783; cv=none; b=ZHNJNnvRv+yNguGssd8wBQWQnmp5M9oJ+kdzXdApp65qcrmRBkI0yIssX8oqSS/V1RajoeRjY6HDJTGZP4vM0uggv8bSlyw6zv5Q3VwJRciJrkRBhbc9KYPoLbrsbZQ4uuAxDnlNLgcvOToPr+zUFNp77YO70k3HCeK3LuR+BJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787567783; c=relaxed/simple;
	bh=HPMzlJli+t0jHtZbEyH2APHafe3+Ww5wOFrR3uxIq08=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=KmNJGBKP2k89cd1I6ABCRwtGe6dBsIvVc+PveBH0IOsgXJdSE8CarizMlui9hjhQbpJQa6hRNWoOwBFrPpg40FThQci9RmVAc/BsPlUrUupGBHQlECJ2YszG+2dwG+dWE1QOhJ3CYowTrz6/dZNYxcjIOcPRRuW0QrBWGyn1EHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SjPbltRX; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SjPbltRX"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c2074710751so591703166b.1
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 03:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787567780; x=1788172580; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9ksoQiT+BjAikF2zC1mXDwrF3qYGTphHuPS40iNEe1A=;
        b=SjPbltRXs4JJxrLGrpX1iTQGNOPPhUn8AWY1WoNNwJYz6A5FhPRvN1nZnrDL2vcn+7
         YYA57VNNoLyvzic1+7Rp+93ZCZqu76iJj76rLwf5cryW/PzgA8ytqrFC5mc18AItB9Mr
         mimojYOZ2efXL31ub+gylzpBfAJdUp/4gnUwYUXAecf9+HplFiz1gXlu1y/IOAfcTicU
         jwjtAOBvt728v7gtLg04dl7RXDVIFo8Hz6lThW5EjiIxL4e56ClF4P33A19pPQ8Ah/qZ
         C6jjegQ3v4P2TJUcbLpyVBoJKznThAifQhtH+2HLUnrzqCabCbx0WcFCge7eQNbZsIAy
         kwLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787567780; x=1788172580;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=9ksoQiT+BjAikF2zC1mXDwrF3qYGTphHuPS40iNEe1A=;
        b=YQ97NQawEjYeck2u5NmhU9EHO+ryOjR8dkjdBHdtW4KqTHQDcAMEgxqzGC9CbhvhJX
         jJIIbA80LgmrzYF1o120pCgq5wrimgGYZlfL+MgJ66J7lVQWHO5UgU52tZxsDnhe2pPt
         uuoMXZz6kMtRawQ5dLD1qOXAbQj5+NSxIdAP2YObATlrmviewjdWS+M2RdQ20YrtboeY
         H4ft/cjNyitegMVz1pFoxH2mw1RiG4X1pQ/11cq8TdhSXhGFoSShkZsYW1CW4kXiW8/p
         XB7StOGQPZNeEY5rOuOWd1kVbyQlVNCAmUwN38A550z9Tr0SfnuCMXZBzc9lzvrBe5R3
         EHmw==
X-Gm-Message-State: AFuF++l8OzEj+r6nltknWN3L/ciqhuU85InaRD5NEmwJIOmQZIkSw8ff
	5XJJAY1+T6cFAtmzDpN1BMIwN/gQE4kHJLR9BBc/m81AWWjcy0MnUAcfQ+kPXBw+
X-Gm-Gg: AR+sD115C7F/aj/O89qxptdKldUEYq3I/oXaiQBnfM9Ap+Uw5GSkMkhnTqqjTSTA0f3
	WPqBO5pxZe+awUGocoAZG4gTyQdQHEpwTwW391gT9b3sHNTfz1Fw2NCNTlSDq4w9MKcBPN25B/B
	2+cVnSWmEdR9lVmCiOOTXitZa0WimQ715e9GMP85xu1hlhlBCcURipNO+dN6OjE+d4udKbRKrRo
	CQL8xy3XY9zyOjjJo3EN9BgGwBGAgSLQlUCWApUT1ubnNgbwtGPNiNqd0ereQWlOVzLq5ZMtyEL
	kToNLdrdH1PG0uUFpb2L+d5zkkocdCeZE39nxiRyaN1TkZj4KZjzUnjfbswk4pLZwpA0QqMtqvJ
	eM98VtcKTSuWNVhi8cPbiaNWP3JWGY8KbnJZmTIS7oe7suF7eCKhMSXAtn4R7Sq5BMkQF804HSh
	v9E32lnGUnn1j1vLacJB8nRrm8UH7Sm2vAIlnNfduCLJ1nGWkm+XJ9TmScGfkEVcsYCNfPa0Iga
	c9zqyzPCL7019vtT8E9Dk2PvSfd6IiOpYuOUF9apaRYaMK+SQVVeYbUseuM1I6VwiTNjeXY6sZY
	OcXD+tKOSovCinqtrofsGOjKGDBOO7aGnLk=
X-Received: by 2002:a17:907:1c27:b0:c21:382e:9a38 with SMTP id a640c23a62f3a-c2491c2a110mr1956621866b.2.1787567780329;
        Mon, 24 Aug 2026 03:36:20 -0700 (PDT)
Received: from localhost (89-73-120-30.dynamic.play.pl. [89.73.120.30])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-c24d6f203acsm168248066b.24.2026.08.24.03.36.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 03:36:19 -0700 (PDT)
From: Patryk Biel <pbiel7@gmail.com>
Date: Mon, 24 Aug 2026 12:36:12 +0200
Subject: [PATCH net v2] net: pcs: enable autonegotiation for 10g-usxgmii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-b4-fix-pcs-lynx-an-v2-1-9bb1dec96f0b@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJsejGoC/32NTQ6DIBCFr2Jm3WkALald9R6NCwqDTqJowBiN8
 e4lHKDL9/e9ExJFpgSv6oRIGyeeQxbqVoEdTOgJ2WUNSigtnkrgt0HPOy424XiEHU3A2jvpHtQ
 2ljTk4RIpVwr0A4FW6LI5cFrneJSjTZboH3OTKFErp3XdSjLev/vJ8Hi38wTddV0/fjqkf7kAA
 AA=
X-Change-ID: 20260820-b4-fix-pcs-lynx-an-3fd1d5e94ce6
To: Ioana Ciornei <ioana.ciornei@nxp.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Vladimir Oltean <vladimir.oltean@nxp.com>, Patryk Biel <pbiel7@gmail.com>
X-Mailer: b4 0.14.2

The Lynx PCS USXGMII setup programs the replicator advertisement, but
does not explicitly enable and restart in-band autonegotiation or program
the replicator link timers.

This leaves the PCS dependent on firmware or bootloader state. Systems
which do not get the USXGMII replicator preconfigured before Linux may
therefore fail to negotiate the link correctly.

After programming the USXGMII device ability, configure the replicator
BMCR with reset, autonegotiation enable and autonegotiation restart. Also
program the replicator link timer registers with the values used by the
ENETC/Felix setup.

Signed-off-by: Patryk Biel <pbiel7@gmail.com>
---
This is a follow-up to the discussion started here:

Link: https://lore.kernel.org/netdev/CA+DkFDaW_wJ5p9_P7pMpz-8iE6xeKkdF-MQcd2m2GcyVUE3S4Q@mail.gmail.com/

To summarize: on systems that don't rely on the U-Boot Felix switch
driver to pre-configure 10G-QXGMII in-band autonegotiation, the Lynx
PCS USXGMII code programs the replicator device ability but never
actually enables/restarts autonegotiation nor sets up the replicator
link timers. This leaves link establishment dependent on bootloader
state that isn't guaranteed to exist.

This series only addresses the PCS side of the problem: it configures
the USXGMII replicator BMCR (reset/AN enable/AN restart) and the link
timer registers whenever lynx_pcs_config_usxgmii() is called, so that
in-band AN comes up correctly regardless of what the bootloader did.

It intentionally does NOT yet remove the "only supports in-band AN for
now" limitation, nor does it wire up neg_mode-based configuration to
support the managed = "in-band-status" property being absent from the
device tree. That part still needs more work/testing on my side (in
particular the in-band-disable path isn't behaving as expected yet
with the PHY I'm testing against), and I'd like to discuss the right
approach for it separately before sending a follow-up series.

Feedback welcome, especially on whether this is an acceptable
incremental step or whether it should be bundled together with the
neg_mode/in-band-disable work
---
Changes in v2:
- Reorder local variable declarations in lynx_pcs_config_usxgmii().
- Move USXGMII replicator link timer configuration before the autonegotiation restart.
- Use phylink_get_link_timer_ns() instead of hardcoded USXGMII 
  replicator link timer values, converting to 3.2 ns register step.
- Link to v1: https://lore.kernel.org/r/20260820-b4-fix-pcs-lynx-an-v1-1-62d66391eaff@gmail.com
---
 drivers/net/pcs/pcs-lynx.c | 47 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 4 deletions(-)

diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
index a92081560e641ad2b297b7395cc72bf2f59ea16c..564c8a3d2b06fde92a249308f955566d6baac36f 100644
--- a/drivers/net/pcs/pcs-lynx.c
+++ b/drivers/net/pcs/pcs-lynx.c
@@ -20,6 +20,9 @@
 #define IF_MODE_SPEED_MSK		GENMASK(3, 2)
 #define IF_MODE_HALF_DUPLEX		BIT(4)
 
+/* USXGMII replicator link timer step is 3.2 ns (312.5 MHz clock) */
+#define USXGMII_LINK_TIMER_VAL(ns)	((u32)((ns) * 10 / 32))
+
 struct lynx_pcs {
 	struct phylink_pcs pcs;
 	struct mdio_device *mdio;
@@ -156,6 +159,9 @@ static int lynx_pcs_config_usxgmii(struct mdio_device *pcs,
 {
 	struct mii_bus *bus = pcs->bus;
 	int addr = pcs->addr;
+	int link_timer_ns;
+	u32 link_timer;
+	int ret;
 
 	if (neg_mode != PHYLINK_PCS_NEG_INBAND_ENABLED) {
 		dev_err(&pcs->dev, "%s only supports in-band AN for now\n",
@@ -164,10 +170,43 @@ static int lynx_pcs_config_usxgmii(struct mdio_device *pcs,
 	}
 
 	/* Configure device ability for the USXGMII Replicator */
-	return mdiobus_c45_write(bus, addr, MDIO_MMD_VEND2, MII_ADVERTISE,
-				 MDIO_USXGMII_10G | MDIO_USXGMII_LINK |
-				 MDIO_USXGMII_FULL_DUPLEX |
-				 ADVERTISE_SGMII | ADVERTISE_LPACK);
+	ret = mdiobus_c45_write(bus, addr, MDIO_MMD_VEND2, MII_ADVERTISE,
+				MDIO_USXGMII_10G | MDIO_USXGMII_LINK |
+				MDIO_USXGMII_FULL_DUPLEX |
+				ADVERTISE_SGMII | ADVERTISE_LPACK);
+	if (ret < 0) {
+		dev_err(&pcs->dev, "could not set USXGMII replicator config\n");
+		return ret;
+	}
+
+	link_timer_ns = phylink_get_link_timer_ns(interface);
+	if (link_timer_ns > 0) {
+		link_timer = USXGMII_LINK_TIMER_VAL(link_timer_ns);
+
+		ret = mdiobus_c45_write(bus, addr, MDIO_MMD_VEND2,
+					LINK_TIMER_LO, link_timer & 0xffff);
+		if (ret < 0) {
+			dev_err(&pcs->dev, "could not set USXGMII Link Timer 1\n");
+			return ret;
+		}
+
+		ret = mdiobus_c45_write(bus, addr, MDIO_MMD_VEND2,
+					LINK_TIMER_HI, (link_timer >> 16) & 0x1f);
+		if (ret < 0) {
+			dev_err(&pcs->dev, "could not set USXGMII Link Timer 2\n");
+			return ret;
+		}
+	}
+
+	/* Configure autonegotiation */
+	ret = mdiobus_c45_write(bus, addr, MDIO_MMD_VEND2, MII_BMCR,
+				BMCR_RESET | BMCR_ANENABLE | BMCR_ANRESTART);
+	if (ret < 0) {
+		dev_err(&pcs->dev, "could not set USXGMII replicator control config\n");
+		return ret;
+	}
+
+	return ret;
 }
 
 static int lynx_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,

---
base-commit: 7cbfb180945ce529608e4d4e24a6d483699fab1e
change-id: 20260820-b4-fix-pcs-lynx-an-3fd1d5e94ce6

Best regards,
-- 
Patryk Biel <pbiel7@gmail.com>

