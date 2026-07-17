Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B073ADBA3
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 07:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784274253; cv=none; b=jGDm3pwsZFmszaoG44oo56moRddICbSm6TtdnYPbcJta8j8X5JF3e0chhHuh0WupCwRPh3itjCR26RIw3hg8kPxwQtik2trvGFVQDhePFNi/PZBgpZ4OhLr4t1DWQtzv4OlRFW3+AilYlOYo/QMSEMWPtpnDRDZW2lVmD5i4CiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784274253; c=relaxed/simple;
	bh=pD/Fr7j7LC+S7XDE6hgjwu9ZKftutKyPHkQZ8/uVhes=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ciS4Vb890gZbbfIc2f1j7j93Xk7a9v/fDyqiXEefpttlpvHIFLuGqni68k4gICmpC9b5YPzena/Al61xWIMC3HHPswBwlxOcCXi0lAzwhiigDT4iLcq9L1/209fHhj8od9L5biRq9iNBbM6ZWdPle3CMy16eLt9aMS/0wZsuCg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aAXgLN8H; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aAXgLN8H"
Received: by mail-pj2-f4.google.com with SMTP id d9443c01a7336-2cabe9335f1so42926945ad.0
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 00:44:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784274251; x=1784879051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FUjQiBhhn7qizDAcVRjlQTGe1kqerqqbLUUA/pK1im4=;
        b=aAXgLN8HovhLg7LogaFQgoJpgeUgBYsQFO201v4vXHRAvmTLPK2h+bJaItvaNW6ILJ
         PDXVJhE4KNrq33TktRA+K7wotXEX7OxnY2RWsZGbJBkYDfZTIaDKR4LQR07tD/k1KLb4
         2bV5SxHBAOeX/hZAqZJ6S8nkRzb25F3i4pXqhdk14cynVz8QRh1TTyXsZQvQ3SfVELG/
         aU6yxMumMeNyPVKgFEumaHKKKbZycVUEOeGeYXw1KKTsFRjQFJqMwAcoQisn94jcxTCI
         gnCTMckPJUnD9cDi1in4IhcYE57MgYrew+MP1p4JMGRkuczeoeVKxXX6efgVICipeFtY
         nscw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784274251; x=1784879051;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FUjQiBhhn7qizDAcVRjlQTGe1kqerqqbLUUA/pK1im4=;
        b=fASCUVQg94FQTAbQlfbGj1CHQMqjVR7PoP9BzqQS4rF/UkEToJppnwTN/32elb5hLs
         G2ZHcnWy2xLMEAaKYKFTDyTreXuU2DYJ+Sa8z5nk/w+PW+M77TxxtC7SIj9ceQ6MdlwZ
         HeJ0/nTE7sXpsB6iMhBYG4Cgd8QaBEmAPVIEXIibE4YzacV0QjWiFqKORZxP6iB0hhAW
         jowvrfxRBsbek80zE9/eAMhg1ATtkns0GqHfbAd0wTEetD7LOpw2OfUoDMhS2st1t20W
         N03cc3kh/zeDyD+EkhyEqklDsdwVdG3u3aP7M7XahEturoj/1MqKUE7cHKQbLToIgFZc
         Z1YQ==
X-Forwarded-Encrypted: i=1; AHgh+RrKI143zYdEK4fU7cUnPFAwrqPTPbYteVrSiaJw34wTgo/I2F3EHc6d+8iF57mIsjUHXxCNZ6E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOSWlIhNMQ8hdDn4bbtbf1o3+Cfeq1P25LG3q+JPvBG02Kx6jT
	cg6rk48dD2wzpFIMRA6t24NyXvrhl8tJ1NLLex1XoY/DgMqX7ty6W+Bq
X-Gm-Gg: AfdE7cmXF5IFzBTEsr3AggpodMfcmK/JjZK//b26nbgHwYi4Uy1N3COxTZc8IygE9vJ
	hnSH1XLvHnFLA8u3WzxykdtOWF1EhBjqg1ctPomPLEWLQj7tjJIoZIfRPCfe50OvDJWm0U8Gou6
	Tu0w4Ip+wuzrdOH8vQJeKucZ9dELStt7qW4gKYduQC0TK2iG1HFC5mpteiDT0VfI8GGiJ1x0VRS
	C7EI1rlox+rqZsOP49kIhVIwOxgyQl0XqvVcgRElaUzSQWDExYDhTBt+PvpZ8mKDKI1er2BEKpe
	6Of1F2Wjo9mDGVG4/vVpW7O1ebijE7o7INdubPdljtNpHsClLeaGYo4rRbnpBt6bys0QDG8NQ7S
	6Dc23gitwavDo2kRy/FTdmkfNRAZTET0jdS3UdprCPJfcruYEMmM4YZScuio+4RvTKFRq4r1CRh
	CA
X-Received: by 2002:a17:902:ce0d:b0:2cc:9a86:9c42 with SMTP id d9443c01a7336-2cf349eb316mr15543705ad.45.1784274251165;
        Fri, 17 Jul 2026 00:44:11 -0700 (PDT)
Received: from server.lan ([150.230.217.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf3448fba7sm6062165ad.6.2026.07.17.00.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 00:44:10 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Jiawen Wu <jiawenwu@trustnetic.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Coia Prant <coiaprant@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net: pcs: xpcs: fix SGMII state reading
Date: Fri, 17 Jul 2026 15:43:25 +0800
Message-ID: <20260717074324.3250043-2-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 2a22b7ae2fa3 ("net: pcs: xpcs: adapt Wangxun NICs for SGMII mode")
added a path in xpcs_get_state_c37_sgmii() that reads speed/duplex from
BMCR after AN completes. However, BMCR does not reflect the negotiated
result on the hardware where this has been tested:

- On RK3568 (MAC side SGMII), BMCR returns a fixed hardware reset value
- Wangxun engineer Jiawen Wu confirmed that on their side, "BMCR looks
  like it only wants to be return as 0" [0]

The correct information is available in CL37_ANSGM_STS, which contains
the actual link status and negotiated speed/duplex.

This bug was previously masked by phylink core, which overrides the PCS
link state with the PHY state when a PHY is present:

        /* If we have a phy, the "up" state is the union of both the
         * PHY and the MAC
         */
        if (phy)
                link_state.link &= pl->phy_state.link;

Thus, when the link is down, the PHY's link_down state is applied on top
of whatever the PCS reports, hiding the broken PCS state reading path.

Modify xpcs_get_state_c37_sgmii() to:
1. Read link state from CL37_ANSGM_STS
2. If link is up, report speed/duplex from CL37_ANSGM_STS
3. Remove the broken BMCR reading path entirely

Also properly set state->an_complete to reflect the AN completion status,
and clear CL37_ANCMPLT_INTR when link is down to avoid stale state.

[0] https://lore.kernel.org/all/000c01dd1593$2ac0b0f0$804212d0$@trustnetic.com/

Fixes: 2a22b7ae2fa3 ("net: pcs: xpcs: adapt Wangxun NICs for SGMII mode")
Cc: stable@vger.kernel.org
Tested-by: Jiawen Wu <jiawenwu@trustnetic.com>
Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 drivers/net/pcs/pcs-xpcs.c | 32 +++++++-------------------------
 1 file changed, 7 insertions(+), 25 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index e69fa2f0a0e8d..0337e2bcc0125 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1058,6 +1058,7 @@ static int xpcs_get_state_c37_sgmii(struct dw_xpcs *xpcs,
 
 	/* Reset link_state */
 	state->link = false;
+	state->an_complete = false;
 	state->speed = SPEED_UNKNOWN;
 	state->duplex = DUPLEX_UNKNOWN;
 	state->pause = 0;
@@ -1069,6 +1070,8 @@ static int xpcs_get_state_c37_sgmii(struct dw_xpcs *xpcs,
 	if (ret < 0)
 		return ret;
 
+	state->an_complete = ret & DW_VR_MII_AN_STS_C37_ANCMPLT_INTR;
+
 	if (ret & DW_VR_MII_C37_ANSGM_SP_LNKSTS) {
 		int speed_value;
 
@@ -1086,34 +1089,13 @@ static int xpcs_get_state_c37_sgmii(struct dw_xpcs *xpcs,
 			state->duplex = DUPLEX_FULL;
 		else
 			state->duplex = DUPLEX_HALF;
-	} else if (ret == DW_VR_MII_AN_STS_C37_ANCMPLT_INTR) {
-		int speed, duplex;
-
-		state->link = true;
-
-		speed = xpcs_read(xpcs, MDIO_MMD_VEND2, MII_BMCR);
-		if (speed < 0)
-			return speed;
-
-		speed &= BMCR_SPEED100 | BMCR_SPEED1000;
-		if (speed == BMCR_SPEED1000)
-			state->speed = SPEED_1000;
-		else if (speed == BMCR_SPEED100)
-			state->speed = SPEED_100;
-		else if (speed == 0)
-			state->speed = SPEED_10;
-
-		duplex = xpcs_read(xpcs, MDIO_MMD_VEND2, MII_ADVERTISE);
-		if (duplex < 0)
-			return duplex;
 
-		if (duplex & ADVERTISE_1000XFULL)
-			state->duplex = DUPLEX_FULL;
-		else if (duplex & ADVERTISE_1000XHALF)
-			state->duplex = DUPLEX_HALF;
+		return 0;
+	}
 
+	/* Clear AN complete status or interrupt */
+	if (state->an_complete)
 		xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS, 0);
-	}
 
 	return 0;
 }
-- 
2.47.3

