Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB9546C82A
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 17:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787247711; cv=none; b=P6P/al+LBdgUfDnIrY7XIsda3ymj/DkxGsnMBgS988JLxJziE1axV8Z2JG1ydVvPBdgYyd8uv4W6IsUHpH1KSWftqFEpBqMo+8thftjKW7MieDgbEI2aShdno46tUNlKbcdW4Wp46e5enNDzQtSisurtlIPm1K8pzaZsPAieDAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787247711; c=relaxed/simple;
	bh=yVO4q/avhgZlEWYD9POUoJRZOo0EKu3RaMmUV42wuS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tyqy6nwMr9RvpohdR3bvm7wEchm1G8vbZ2Z6lFW3O3xqE45R55CFl7bWmUzjbJO92pyJhPYCguFydAOdPTlp1N10miZA1HPlT0AgF0D9xkkm72emw+8BR/+ihFKtcLulR7l2pVnVUwyZv3KM+0ovgi5JFLBfMgnTFzYZtVuYjoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BrUywSE+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrUywSE+"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4956869750eso793665e9.2
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 10:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787247708; x=1787852508; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=YF36P/EOT2pH1IA18dV55UPJUnVbIvUsggLUy2LloAA=;
        b=BrUywSE+ArUNW+464cy13qv7v4oQBk/Khtx9CFNrLy9n82kCL/Ft1frXeF+HCV7B5+
         2OxUMilmVp11SG7RqGO8dtXLM0gDyO9xmWy3LW1UE9394gyji6rmo4i9gVsf1VHVQG7+
         8PwTfOk6BqHdowftHLWAKTJCx8OQjh9bbWEnM85a97pjfZQ0021XISVdX59AOjxwm06V
         KJG9zQpjhBzFl+5mXa0F5dDXqM84aDxZ3AHxdYPfNJFc9Xzf+XrxYAuo4+KUqHj/MKEN
         KmuizOrLGYmeLB9z4rpxs5V7kGhrmGikJkI69bFGvkuf60RdlyMQT79+hNEPD9OrXueq
         X0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787247708; x=1787852508;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=YF36P/EOT2pH1IA18dV55UPJUnVbIvUsggLUy2LloAA=;
        b=BaOU4of6arlMR2Nn4FzVfXpAsyndx4rcaYFD2sR9xMD+aaCugqStJLW7u+8FENNAAd
         GSJI/nGIw43Lsfl4iOsSCZHRGk/1/azW9aGyK/4CmBLwpGa15WZdDeV0WOWKdeCqh9Tc
         aUlLrRZHPd6gX8VI9KnNv2RiSLfXY1T9cwQBJlT5MguUBc0ZuGfgkekGxzzn7lIP1Oho
         w8/0Nf3Tr59H0hGCGl0lXYD3hIIzniCBl5iUuvshdHPELW+7zlg1NE1tqjsBMyHktmlF
         wGDf9kw33TKNZgVqUhnP79P5dREBVWHw+nrDgofoyV9MlgaGrGhOZYfkSzqz6nh8h5Dg
         DCgg==
X-Gm-Message-State: AOJu0YyWltwr5CTQQxD+ib5SgXZPS2sjVJ+kU6ok/VLJy0F4LpMOkFrP
	tHvwelJvzZ46MZq+M+BM1KWz4hxow8nD4Fch1mD6BrhJZ0dm8/B3YCTd
X-Gm-Gg: AR+sD11lm5udGtLGt/U6hSqdec8R6hZNSftkNQ9LL5vo8RIYz4nDsq5DFf62vfEfts4
	oBNAaC/CP4rWzR4aQCyqK+AkAot6N9bGaj1l4PyrdC957O8sX6k9uek0xSpuLx0RHvJBiAQmuVz
	fE3dwqy2njojceubmOGYAs+36RGrLGQBxgX/aKx6f/+oZgd+Q168qgXbY91z/rXyC5+KawNanHv
	0OjNyEpGnNL2hteOx4V2i9oyFi825F8L5F0Wyi2zlOT1bOMqWcTMTxCp1Jd+HnMDv5gKTp4o/yy
	FiK85XeTsy4Y2iQYeC2R0b4F9AMegbaX7Xf1vGKcHxtE8Z4qAJuH0iyGJ9I9M2hHAM5U9ogFyOn
	nr3hjMz38gcxeQX+YLfZVEhuPZiH9hyCazurunV2RugmmriXqH9mv+3qg9LMjiKt3zTOcqlFn0v
	mpOyUzFp4HTfZZUfV5/01U8X3pgzhb3ymRMnSeIgYFveKtUvT9bKqUtIfXU69s7FL6XBitvdGd9
	ynsFD0LeLIjI0UCUQsiffzn3xjOFdrBBa2fu/yoj+7dOGpQNH6I8Jen3sSgpPH846zSH++frxzl
	DBdb+BIR1hsU1tCD5VHdicFnXNlxag==
X-Received: by 2002:a05:600c:4e8b:b0:499:872b:abd4 with SMTP id 5b1f17b1804b1-499b829ef81mr10110875e9.6.1787247707429;
        Thu, 20 Aug 2026 10:41:47 -0700 (PDT)
Received: from localhost (89-73-120-30.dynamic.play.pl. [89.73.120.30])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-499aa17fc80sm169674395e9.14.2026.08.20.10.41.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2026 10:41:46 -0700 (PDT)
From: Patryk Biel <pbiel7@gmail.com>
Date: Thu, 20 Aug 2026 19:41:40 +0200
Subject: [PATCH] net: pcs: enable autonegotiation for 10g-usxgmii
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260820-b4-fix-pcs-lynx-an-v1-1-62d66391eaff@gmail.com>
X-B4-Tracking: v=1; b=H4sIAFQ8h2oC/x2MQQqAIBAAvyJ7bkGtpPpKdCjdaiFMFMKI/p50H
 JiZBxJFpgSDeCDSxYlPX0BVAuw++42QXWHQUhvZaYlLgytnDDbhcfuMs8d6dcq11DeWDJQwRCr
 KPx2n9/0AM3hLmmQAAAA=
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
 drivers/net/pcs/pcs-lynx.c | 40 ++++++++++++++++++++++++++++++++++++----
 1 file changed, 36 insertions(+), 4 deletions(-)

diff --git a/drivers/net/pcs/pcs-lynx.c b/drivers/net/pcs/pcs-lynx.c
index a92081560e641ad2b297b7395cc72bf2f59ea16c..33655079fe51dba9dc96b0f7a79c4303e9492463 100644
--- a/drivers/net/pcs/pcs-lynx.c
+++ b/drivers/net/pcs/pcs-lynx.c
@@ -20,6 +20,9 @@
 #define IF_MODE_SPEED_MSK		GENMASK(3, 2)
 #define IF_MODE_HALF_DUPLEX		BIT(4)
 
+#define ENETC_PCS_REPL_LINK_TIMER_1_DEF	0x0003
+#define ENETC_PCS_REPL_LINK_TIMER_2_DEF	0x06a0
+
 struct lynx_pcs {
 	struct phylink_pcs pcs;
 	struct mdio_device *mdio;
@@ -154,6 +157,7 @@ static int lynx_pcs_config_usxgmii(struct mdio_device *pcs,
 				   const unsigned long *advertising,
 				   unsigned int neg_mode)
 {
+	int ret;
 	struct mii_bus *bus = pcs->bus;
 	int addr = pcs->addr;
 
@@ -164,10 +168,38 @@ static int lynx_pcs_config_usxgmii(struct mdio_device *pcs,
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
+	/* Configure autonegotiation */
+	ret = mdiobus_c45_write(bus, addr, MDIO_MMD_VEND2, MII_BMCR,
+				BMCR_RESET | BMCR_ANENABLE | BMCR_ANRESTART);
+	if (ret < 0) {
+		dev_err(&pcs->dev, "could not set USXGMII replicator control config\n");
+		return ret;
+	}
+
+	ret = mdiobus_c45_write(bus, addr, MDIO_MMD_VEND2, LINK_TIMER_LO,
+				ENETC_PCS_REPL_LINK_TIMER_1_DEF);
+	if (ret < 0) {
+		dev_err(&pcs->dev, "could not set USXGMII Link Timer 1\n");
+		return ret;
+	}
+
+	ret = mdiobus_c45_write(bus, addr, MDIO_MMD_VEND2, LINK_TIMER_HI,
+				ENETC_PCS_REPL_LINK_TIMER_2_DEF);
+	if (ret < 0) {
+		dev_err(&pcs->dev, "could not set USXGMII Link Timer 2\n");
+		return ret;
+	}
+
+	return ret;
 }
 
 static int lynx_pcs_config(struct phylink_pcs *pcs, unsigned int neg_mode,

---
base-commit: 91ec2035134982b98fab0609a9fd8480e8217dc1
change-id: 20260820-b4-fix-pcs-lynx-an-3fd1d5e94ce6

Best regards,
-- 
Patryk Biel <pbiel7@gmail.com>

