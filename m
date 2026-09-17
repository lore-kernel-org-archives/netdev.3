Received: from mail-pj2-f11.google.com (mail-pj2-f11.google.com [74.125.227.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EC9B3D1A81
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 20:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789678083; cv=none; b=pYN4UEDuk/mngVXsq9svQ7Ry4vrsDZGUmd7ich769KnyGuLjuzU6Kr9qC3eHLO0U5LoGsmAndED+t/x0vLe7z+fmkhJ6yKni4WSfAj8QVsYYoUZCfTymPNexXqPXiuXWimTMLTWDo4iniwOoig0eaP3S27cTcgiGmALY4Amd8Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789678083; c=relaxed/simple;
	bh=k9eLD1ZrXZD1iMizDWP4jTUk+ML36ocfJ7jazjazAIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ghUHYFOwJAx/amvT173icPLh7tDEr9XP0nVu8UamaYkQZitwskxZJEPm02/F6MW+f79F1KUhXOY/8mO4C6OZ7eRTYCdVVXpSgagyzCNerj/pc7JYUmNjSB/6jmEwBVUTHHq227dSGyOHQ3dtY89jJrHDN9DC9jRIopJcrsKHv3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GZ9qugkI; arc=none smtp.client-ip=74.125.227.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GZ9qugkI"
Received: by mail-pj2-f11.google.com with SMTP id 98e67ed59e1d1-39569e136f9so64919a91.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 13:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789678080; x=1790282880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s/eBjsMbUu4KmQPd6dfybXXRKRWzlAuXWPZqO5pNdlA=;
        b=GZ9qugkItfV559YN7ktm7UuIEEoSYtRiFq9uRbqWwXE9tU2vxMkcOG6vdSmj0/diGw
         onIG2ZQW0acpybA6VaJzvcMKEYMzDxXa82RF+6WR5vZg1oADaNXYhlgGCrOuyQhY2SRx
         DxYcTCmJNnar1wDcK3FP0vkDmpIeTe7cpC9I2YwI2NbLx9CFzM+I21Gc6Ovogq3JwR1F
         JomRXtYz3vffWgFSHUCZ726w6XBB6GnMtuEvNncuRvnhWKD097/nCyXZYwDpa0z/qj8h
         KsjgOKAPC9G0DQdDWxEm4E5TUyQTyh6mq6YTdwPsqhsGSNtDyk+L6dNRVR9SJ5yCIurf
         8A2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789678080; x=1790282880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s/eBjsMbUu4KmQPd6dfybXXRKRWzlAuXWPZqO5pNdlA=;
        b=ffY42BWRF2Qai3mG0XSqYzG7+8LGOUcM4TCjF8a3k8rtUgx7LLezuzkCuoO6K+u5WA
         nCU66EG6lrvPXKo91R4vpsq1DjtMOkkYTzEuBP+WVZ83s6PZXchMRqVC2GyjDr6c9BBZ
         0pGE+pxHQ6WKW+EtxZEl2jk45sPAka3XDtC4r0zxwT1HmGyH8+1FlFkO0SF9LeHAjBTu
         nacVpCfgJy051w8wPybeNLii93p7uc7VYu2TrIsDyMNnC3QLUidLfG0CpJOVL2/Jlj7H
         4pcWyp68sWolTcmFQuhKF5iJ5KJh+1j6d4Tn/KM8AjSVzpNUeG1Efi0DVj482bZUHzff
         CL9w==
X-Forwarded-Encrypted: i=1; AKwUvByhrqQS1KrckDYfhS0WXIw+Ysowe5/SBVQeIVxHEGhdqHBE1WLWDKdPlzdm9Z/zEd5uIe8HbiI=@vger.kernel.org
X-Gm-Message-State: AFuF++lcHPX5dk5N2D3Ap2UzDzTV80au2qHENR77dirW10RVN+8Kx6QC
	3yqn5cnPgiTWUxdq/incit6oqjGuqRh9XQrt9somhwYEk+/BlBBtkZbL
X-Gm-Gg: AYBFou1u33PzrjaI/uErSlA6Kg3wJb9SPe4GJNhonwOcYzdU3+FRFIS2JUC12scHyu4
	AvwHqrO8gcqTqqI/ZHzXjqwEIdrEyFDWuZQrSBZjnGm34qf72k6/FvvVKEYDk9MrJOHpPvqRgBF
	nRJt4qSiGJOZ0sWN7PO9LXOY4BC4Uj0b0Tvb0ZeO7agdI3LrdblPNOnTdgWFkjePMqOQJA/+UTg
	FLj+Ax5ZHPo5EIZdnROr01pZcvGViT7qEKHrgqnnUn9zAV26zDOwFUoSygCrHeza7KtgDEDDPgq
	PEPaQwEaHwwYZgDsdem4JRZlZc9v38AwBvMoa/9q7+fVSZhISMJYcmJ14I9A0A79U2fP9xN5QVd
	o33TNBWQaFLLn7pRkpUz0iE9xLTpsASkAfojuU5t4xV8SxZ3NU7pqPDHqs3pdpNO8mYkSpvbJ7Y
	vwQ4j/oCsXMPpTqzDrm/QPWkmate9hkwuepGvp38DDSHKOSDdUd06OHdLfsVvoxxgTA3vREno=
X-Received: by 2002:a17:90b:3147:b0:39d:eda6:8a0b with SMTP id 98e67ed59e1d1-39e54c9ccdemr697045a91.21.1789678079561;
        Thu, 17 Sep 2026 13:47:59 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e50a4bc22sm1232196a91.17.2026.09.17.13.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 13:47:58 -0700 (PDT)
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
Subject: [PATCH net-next v7 06/11] net: pcs: xpcs: add ANRESTART support for SGMII link recovery
Date: Fri, 18 Sep 2026 04:46:17 +0800
Message-ID: <20260917204624.2427486-7-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260917204624.2427486-1-coiaprant@gmail.com>
References: <20260917204624.2427486-1-coiaprant@gmail.com>
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
   negotiation process. Propagate the return value of the restart so
   errors are not silently ignored.

The restart cannot go through the .pcs_an_restart op: phylink only
calls it for 802.3z interfaces, and SGMII is not one. Changing hardware
state from pcs_get_state() is already done elsewhere in this driver
(xpcs_get_state_c73() calls xpcs_soft_reset() and xpcs_do_config()),
so the same pattern is used here.

The latch is cleared before issuing the restart, not after: clearing it
afterwards would discard a freshly latched ANCMPLT from the new
negotiation. If an MDIO access fails at this point, it indicates an
unrecoverable hardware condition until reset.

Also clear DW_VR_MII_AN_INTR_STS in xpcs_config_aneg_c37_sgmii() before
starting AN, matching what xpcs_config_aneg_c37_1000basex() already does.
On the non-inband path the function now returns the result of that write
instead of the DIG_CTRL1 modify.

Update the comment in xpcs_config_aneg_c37_sgmii() to note that although
the DesignWare databook says AN restart is not needed for MAC side SGMII,
some implementations (e.g. Rockchip RK3568) require it to recover the
link after a disconnect.

This is not a fix for an existing mainline platform: the affected
platform (RK3568 XPCS) is introduced later in the same series.

Tested-by: Jiawen Wu <jiawenwu@trustnetic.com>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 drivers/net/pcs/pcs-xpcs.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 0337e2bcc0125..8c3875b6985b9 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -761,7 +761,9 @@ static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
 	 *    DW xPCS used with DW EQoS MAC is always MAC side SGMII.
 	 * 4) VR_MII_DIG_CTRL1 Bit(9) [MAC_AUTO_SW] = 1b (Automatic
 	 *    speed/duplex mode change by HW after SGMII AN complete)
-	 * 5) VR_MII_MMD_CTRL Bit(12) [AN_ENABLE] = 1b (Enable SGMII AN)
+	 * 5) VR_MII_AN_INTR_STS = 0x0 (Clear CL37 AN complete status)
+	 * 6) VR_MII_MMD_CTRL Bit(12) [AN_ENABLE] = 1b (Enable SGMII AN)
+	 *    VR_MII_MMD_CTRL Bit(9) [AN_RESTART] = 1b (Restart SGMII AN)
 	 *
 	 * Note that VR_MII_MMD_CTRL is MII_BMCR.
 	 *
@@ -769,7 +771,14 @@ static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
 	 *	 SR_MII_AN_ADV. MAC side SGMII receives AN Tx Config from
 	 *	 PHY about the link state change after C28 AN is completed
 	 *	 between PHY and Link Partner. There is also no need to
-	 *	 trigger AN restart for MAC-side SGMII.
+	 *	 trigger AN restart for MAC-side SGMII on most devices.
+	 *
+	 * Note: While the DesignWare databook states that AN restart is
+	 *	 not needed for MAC side SGMII, some implementations (e.g.
+	 *	 Rockchip RK3568) exhibit a timing quirk when integrated with
+	 *	 phylink and do not restart AN automatically when the link
+	 *	 comes back up. An explicit AN restart is required on those
+	 *	 parts to recover the link after a disconnect.
 	 */
 	mdio_ctrl = xpcs_read(xpcs, MDIO_MMD_VEND2, MII_BMCR);
 	if (mdio_ctrl < 0)
@@ -816,9 +825,14 @@ static int xpcs_config_aneg_c37_sgmii(struct dw_xpcs *xpcs,
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
@@ -1093,9 +1107,18 @@ static int xpcs_get_state_c37_sgmii(struct dw_xpcs *xpcs,
 		return 0;
 	}
 
-	/* Clear AN complete status or interrupt */
-	if (state->an_complete)
-		xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS, 0);
+	if (state->an_complete) {
+		/* Clear AN complete status or interrupt */
+		ret = xpcs_write(xpcs, MDIO_MMD_VEND2, DW_VR_MII_AN_INTR_STS, 0);
+		if (ret < 0)
+			return ret;
+
+		/* Initiate the next round of AN */
+		ret = xpcs_modify(xpcs, MDIO_MMD_VEND2, MII_BMCR, BMCR_ANRESTART,
+				  BMCR_ANRESTART);
+		if (ret < 0)
+			return ret;
+	}
 
 	return 0;
 }
-- 
2.47.3

