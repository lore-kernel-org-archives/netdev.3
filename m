Received: from mail-pz2-f7.google.com (mail-pz2-f7.google.com [74.125.228.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7D873515D4
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 17:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789923783; cv=none; b=DNXPL/izOo5ltAd8hS1GWZf+qHu7c+xe+HMNQ016qllHbNUSmuvC13tUsx9Rxsw5c/g0chRN5wJCbEd+sUYJ7UopGHXg35AK/P9NSzgA+ooiiUHd4U0Ru/UbFn8RXjxZOjqQqdBoWi57DJ4bMa9qodOQ5wkuLVZLLvLLokw47nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789923783; c=relaxed/simple;
	bh=k9eLD1ZrXZD1iMizDWP4jTUk+ML36ocfJ7jazjazAIs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0slnSpGTwmUtZexU6KDCYbMV0DhNyPMKFOA8PVtudlkomVVDo/Z2Pi+OpSHINxW3okAo4IFlHsxtLSp3Nh/nOhFBNZJ4PEJMahoiFxRVyLXuaO2NMqn2XdDRpuRa1E9lVwZrw6uSh+RoyMqThNm27Gi8/Q60GTHsaQVIIu3UYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SQuWtDcE; arc=none smtp.client-ip=74.125.228.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQuWtDcE"
Received: by mail-pz2-f7.google.com with SMTP id 41be03b00d2f7-cc4b166d0dbso781657a12.1
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 10:03:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789923780; x=1790528580; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s/eBjsMbUu4KmQPd6dfybXXRKRWzlAuXWPZqO5pNdlA=;
        b=SQuWtDcEhZo0BLuuqbqYiePwXo9TrwmB71FZb/t8KQr+ftutAecETKXxmq3aCGnjQ+
         IXYSK8NuVs9jFZroIK5+yL9slZo4hhsRDIEVeVVMQlSaZkMCbCfcxi4R+ws0HYyRl6C+
         CbA784qWzNdSrJw8hzHN6vDE/Una2A7DpwDDMgEzSjStumIxnhse08vLRyxUhCwEVGu8
         b8NTAn3HUS34IhTxz2MqcJRa/9RSLTpWGku57O2/LiKcDHvN5yRDw0mW5O4hNtOeonPH
         rrep0lwGm3XKACOU+fYG0ZI7SXdvI4+ZRPVXFld9G/Qp4VZtTefZplLSNpr+O00aD7nl
         7g1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789923780; x=1790528580;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=s/eBjsMbUu4KmQPd6dfybXXRKRWzlAuXWPZqO5pNdlA=;
        b=grvc1DWQpdPqBQ946n5L+BKi80io4AD2PuGkKVs50scbXpo+SFOelKlLlAHrNaGKMJ
         mbsZ9/wwoZSUYBzIO4lUFO4F0uZLDjfHMTuyuKE9ILH1xwD8PCx8TXHxzuGsWvPNy5AU
         edeqh58sAJ1z/WivZhqEqS78xH06fN0r55v4k1w9fC0/zCwC4/kpgYg6dy6PvJ0ciDa8
         lCiErJ6X6t8G9EdEFoY5a8oqSCDoimetDBEaderRdvbH+e/MtHbvzHiLVjsMYWYWELef
         GXsL5R1QYDB2WN/FvWvHijFCKiwEYLi+lLkfIllwsW1dtvgrV//bkhWChZwfWLXs6/hX
         0dyQ==
X-Forwarded-Encrypted: i=1; AKwUvBwXwZ0dlqlQcp038UY5H8RP5Vfir99wiw1S5dCJl1drithZn5pHaJaY+Gf24ew1sJ8809hgk9I=@vger.kernel.org
X-Gm-Message-State: AFuF++mGWNPG1PCb3lYYTRFWGUs3kHBHySPwjehHOBkoDBj1Trb7ijxZ
	HaXo2djlQwkpTH5VRgLD18NUwPXqaOCNFH63w15jDPemp95kWYBn/Z4b
X-Gm-Gg: AYBFou0Zdt5QF/usiCn/RJKMGROuc77wJJAJKS8VNhR/b23tgou4+4zaKLW/mdatpDb
	WQ5W166eh5lkt94qzXjs/HpiKKNP6x7499n6QaiAqtktjFnVmLt5c2TsyJwCg+9Thj0f/trOLQw
	7A0ur03dT4e9WNaKrUIKJ/oQ0uv+c3JWRr7nmAj3jm+PrmEd3YwoHflkNYLzXyGpPbtTnN4NKpm
	7KCt2hpd1qoSBoxIO670cwzzzofadeHrZBAAX0MBPvnUw6xGAObePT/M0+JjHWXhqvfzsCFyxnz
	mvpvZlNQfiOjtoboXceXftDI4HjgCXTl8JoLA4OrPylJ/Wu8k427FxkFX2LgpCL3J6kqJqjkskz
	hGXiCN4x87T5/saXbTUxPE5RWk4/Ddpicmnyqr9DA5cpGlf71cWIJkgnmS26zx5gnq5nOl80MFP
	pOse+haNWYkLAglZw3PLjExM1MnH3BV+KnxvMxx+SS65L8FSznbzxHzj7NdU4JNxSyJja65A==
X-Received: by 2002:a05:6a00:ab89:b0:84a:29a7:f3b1 with SMTP id d2e1a72fcca58-874decf5c32mr11449622b3a.16.1789923780066;
        Sun, 20 Sep 2026 10:03:00 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a9d07425sm2140646b3a.42.2026.09.20.10.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 10:02:59 -0700 (PDT)
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
	linux-renesas-soc@vger.kernel.org,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v9 06/11] net: pcs: xpcs: add ANRESTART support for SGMII link recovery
Date: Mon, 21 Sep 2026 01:01:10 +0800
Message-ID: <20260920170116.3624104-7-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260920170116.3624104-1-coiaprant@gmail.com>
References: <20260920170116.3624104-1-coiaprant@gmail.com>
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

