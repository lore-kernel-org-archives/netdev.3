Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A3350C2AF
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 15:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788795567; cv=none; b=G/UrB7qSNMwoY77bph2x89uwhU7ZYgX+2XufAU8lhPMfSnTBTZ7+nuY7AVk/6Vgm1+EBPtx4ZUvjQJFVLNINjBCAqnpovbcuM4KUbWMQ7WfIZ3WYUCN2zz3sTKR46EMRKiMuw2/VroXZ+2mVPsSzuM6kmOBmyfe9lv5MpYq1dck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788795567; c=relaxed/simple;
	bh=iCQafZpFqsdcijM7wQ/VBsqWEiby6qk8Gp6Xz65rtD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cMyejzmIRiYxYplooTeZPkoWKM9pzT1v8tYa4tm3Y7egdzk0xeca4ZbKTwEhaK38nfDV2uuL60sEgV/XriQOH1yDMXVJvrd3BxOjtnCiJbeEa1teUcfLo7gTzEulSDs2KuFfCLBJwVdLT2s5nNNEgnOG8JYtk06sS961RYWh7q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nq3peZFv; arc=none smtp.client-ip=74.125.227.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nq3peZFv"
Received: by mail-pj2-f1.google.com with SMTP id d9443c01a7336-2cb3f5bb19aso11936305ad.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 08:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788795563; x=1789400363; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7inwahIcNU1aV9djAHi258zSUQz0eW0dslHEgzobBAI=;
        b=nq3peZFvmzK87LoeWIpAIpyGBN4zVxHSK9kgopmCrgyEeldFt3bSk8VWcWHZva4G+M
         SVGiyKBEPm4Ir3PYejzyUpBa7ZBSbA5yNPUPaAMjPACDzgWDEnQIy1t2NsARUl4fWpVD
         UYLj3SOR+U4AExfQ9i66C9rrPsh4hs6RmYTT8/2kt7cggshcb6LcB5l5nrSSEB/xkFdn
         Uuy3weqqrUSWxSFFFxDXvdd/EQQWFOvePMqmu0h5R3gUltD73wuNl4S3MBY9DyKHw4KO
         PEkYUQAUrmNcVuVDfKhqp9isRC9/mALt3xVq0gJr+0YY5P4NSE06gIAxPJDBOv2gweYa
         MnHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788795563; x=1789400363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7inwahIcNU1aV9djAHi258zSUQz0eW0dslHEgzobBAI=;
        b=obktkUr8r4XCrGdc+V2ELpm2t1x7N3RT04XFkNlaR8W19ZpkilZQbm58r1ouC3oOMq
         tT9TMDdMZDrb/nT0GqOieaQHji6epxyTwP6H120k5tdK2KF3bH1U+TGxYlIvTk/s4+6+
         PfHzzQ4YDZq73s3Ruo9yosLtrvUs4iD8y6iBSrMI0rNDOD/xn6Qwc/SjeeQve687PhS9
         JnSBn0T+WHS6iN+ifPRGuyt/1mvzAAdu8Ns/YbAtNjDuWMJxYx8jfoEg4P52qm0Leu0g
         gPKoxr6tlvqKLB68YLKnMKAmnKy3+Q+01spcLGJo7QfsoHCz+gONNFHRVe+oppGRynJJ
         xhRg==
X-Forwarded-Encrypted: i=1; AKwUvByM2rLpIRqUKvqPensag2z6rdbNF98BEhEgl7F2Aqynte1vsuYkQPeVdv09tfaq0khrTlar0TM=@vger.kernel.org
X-Gm-Message-State: AFuF++luUUEiqFPc+wrwAUu7OlJzMlZeD7b7DvHnGLUAvwJCOl1ZO/mo
	KkaHSkzb1DdUnaWkkq0oWY/Ie4r8uqE6Hu6jZ+397cT4RHJ0SDsUa3wH
X-Gm-Gg: AYBFou3RZDN5yujCKQYnmmSwzuahf3xH/Cb99/lTFitZ1rdN88QG8QcQzJRG80xJgzZ
	vd2NYBgkvJlXpe4z6M4Fy5CKStLpHtsy+made0ymVP79QdwNGcDHQSd7oufJCMs7304aEEggKUp
	ce4eeTeTi0JTBCQvINcyD8xKcqjHYiXY43PACCI7hJXdy4r1O2RnTsbf+vP75CxPY7QNaNs0Gfh
	WH8GTLw1r5gQ1HI8wnBnqQXFPs+n3J2qsaWrsqvqkuGrqwckdi0r2Mt17FVvJVOz2uzbmBsMRpn
	Okp7Zzgo8Y9T2uqtYuGL2BCZpVkxsf/bEIZdb9jAJz2l/rSD5ZBqF9s5K7k3WzmVYpZ7TRkS/wD
	Ovhm0MmcPJ2l6bycFVHZZ/3Ggy1xT5Naq7ZOEL9QzoAp8wZGPhueYeFyOBIUHXcnynF+OPSTJdQ
	3NkQXfYQtH3dBWQPL+gV1T/MwagpnWy25Y0zNXF8Om6wULsMocpjsvw0k+xMM=
X-Received: by 2002:a17:90b:384b:b0:38e:524:8797 with SMTP id 98e67ed59e1d1-39b261e79f1mr34240199a91.13.1788795562857;
        Mon, 07 Sep 2026 08:39:22 -0700 (PDT)
Received: from server.lan ([150.230.217.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260fdf9asm21690121a91.9.2026.09.07.08.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:39:22 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Vinod Koul <vkoul@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Coia Prant <coiaprant@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Russell King <linux@armlinux.org.uk>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	David Heidelberg <david@ixit.cz>,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-renesas-soc@vger.kernel.org,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v4 06/10] net: pcs: xpcs: add ANRESTART support for SGMII link recovery
Date: Mon,  7 Sep 2026 23:37:09 +0800
Message-ID: <20260907153713.2572547-8-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260907153713.2572547-2-coiaprant@gmail.com>
References: <20260907153713.2572547-2-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On some hardware using the DesignWare XPCS IP (e.g., RK3568 MAC side
SGMII), the PCS does not automatically restart auto-negotiation when the
link goes down and comes back up. Without an explicit ANRESTART, the link
stays down forever.

Add BMCR_ANRESTART in two places:
1. In xpcs_config_aneg_c37_sgmii(), when starting AN, set ANRESTART
   alongside ANENABLE to initiate a fresh negotiation.
2. In xpcs_get_state_c37_sgmii(), when link is down and AN completion is
   detected, clear the interrupt and trigger ANRESTART to restart the
   negotiation process.

Tested-by: Jiawen Wu <jiawenwu@trustnetic.com>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 drivers/net/pcs/pcs-xpcs.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 0337e2bcc0125..50b9cdf94fdaa 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -816,9 +816,14 @@ static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
 	if (ret < 0)
 		return ret;
 
+	/* Clear CL37 AN complete status */
+	ret = xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS, 0);
+	if (ret < 0)
+		return ret;
+
 	if (neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED)
 		ret = xpcs_write(xpcs, MDIO_MMD_VEND2, MII_BMCR,
-				 mdio_ctrl | BMCR_ANENABLE);
+				 mdio_ctrl | BMCR_ANENABLE | BMCR_ANRESTART);
 
 	return ret;
 }
@@ -1093,10 +1098,15 @@ static int xpcs_get_state_c37_sgmii(struct dw_xpcs *xpcs,
 		return 0;
 	}
 
-	/* Clear AN complete status or interrupt */
-	if (state->an_complete)
+	if (state->an_complete) {
+		/* Clear AN complete status or interrupt */
 		xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS, 0);
 
+		/* Initiate the next round of AN */
+		xpcs_modify(xpcs, MDIO_MMD_VEND2, MII_BMCR, BMCR_ANRESTART,
+			    BMCR_ANRESTART);
+	}
+
 	return 0;
 }
 
-- 
2.47.3

