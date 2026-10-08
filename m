Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACBD83B47F1
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 17:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791481977; cv=none; b=EElAGCESBgtaFehv4VCGPkxfQevfp+RtgmzCV6G8v/vJTi/2WjEWc26BQeC61Xi+Gvq3SOasq1LrrJ1ls1r49Mkeh4OLXgupWD/dq8D/+OPUJ1WLqZilbpv9p8wX3EQReRiMHJj8lNEtNsfn6jzRQmW5Q+JuEfbjSLj1uQSWLQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791481977; c=relaxed/simple;
	bh=K8sJtTy8arsyLPVQc9/n8NVgxkq77Tb09oquQ0e8WBs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BlzGpX/gJluN/Q5r1K+Muh/Zo7RfXp7fW0he48d750gAhkCAEkRNs9tN1D88aOTt850A+Rx4yeauGg8fJuc3/97qqDPFpNFfPeUySm8JelY6Yp0QwHOKsnB+9afZ1ZNqWQVSTTQ8yi446VfOUnqEb38+BO4UkmCKCX7AbXvLhYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LhtZxjBa; arc=none smtp.client-ip=74.125.227.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LhtZxjBa"
Received: by mail-pj2-f0.google.com with SMTP id 98e67ed59e1d1-3a4883304bdso1448709a91.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 10:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791481976; x=1792086776; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L2jHQ5uSsWE1tJZ2r8Ki7n0PjxWkIoR+7RH2XBS7AsA=;
        b=LhtZxjBaU4oJSXufZoFjbkB60eFAcBiy5nTQMmxEPlSKKwZfZpgnhAlB2DHvem50gA
         yAugAwuESHCtmXf6LsKv0O6JYEuncbre8Eu5OZsFl03UAHfbukijFHxjlKMlR+JUUByg
         rl6Tj5glR/hzE7ipFiOBJgDjvcpt3XuPvPZ/QRalY0k20T72oCx14w01KKmbDd+zxiBP
         HjIYGCLTRpS8/u+p/OIoqUdy4ja2Rqo097CX3RO7RUpNRcmbp+fKUyQ+98TXV0aVpXeA
         EUccjZLcE1G0+PlCWGUabfOIUGU2tMA/yrosSjc33K6K1s4cxAKk/9WRB/hMJS8VcyRX
         4Wpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791481976; x=1792086776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=L2jHQ5uSsWE1tJZ2r8Ki7n0PjxWkIoR+7RH2XBS7AsA=;
        b=MZvf7/+L2IXm9Vd8kvv/qrD+vROaPwxNGLmh535Eb5pu10KV/QCQkpkPnvOjDsd+VW
         xMWEkUucGBnOrIqInLgdR66lh33CH5c7OFh0xknzPMZ0tM4nyVjHujxfDdXnredrzjtt
         WfLXOIHfypB/TtPfxHc5xhb5d5Oq+Bvy8IGcLTeIddDwDdbiZlaG0XVQty5iZi/KUvtY
         7qt21ecM0xvEb+cVAzdz1dDJo+CnAUgEmpq986oj88foDyZ9c9ba+zpE4ban6xeB84Wg
         Tjw379NELq3cLHXCH4tQw/1u3+srixjYyY0D99DTXGtPJp+mdVcnGKlXpZvLttgEKfTq
         z6iw==
X-Forwarded-Encrypted: i=1; AKwUvBzaZwdsVd4pKh0KO8gkDqNj3J6HJx/1g5FF7IeBUYkvZ5OujeLp6uCqAH9CqpQPxFJFPlKYDlk=@vger.kernel.org
X-Gm-Message-State: AFq9FYLFTtLgath4ThpaeVI8oVJRdNt7Y6Vrw+R5FEbyCcCPKF+dK6Er
	JaxbfOGmYF37HrumYGBDOUHqAe+MWL87UqC1EUMnBqz51wYJM28wjvlo
X-Gm-Gg: AYBFou0rRTUH9owrkjd2b6A99Hh5wQYCM20m0OJ5OAkjUJR/layDaRRjoJmz+rzE9Au
	0psDSZR8wM1LXeFNStQClKHrrEIgIf46Unpd3Yqmd7948fBhBqSn5WvAQlAaWZS4h5dVBHuJffU
	jd7zvv7tOXTMg7zERMQn17UTDJ+FPA1JM2Jr9nbEAaJ3vLNkgy87bqF6nEGCVC6XgrNtLTef10G
	xw9d12MH4YDrsjiCRa6bEbhqLbst89OIfTpC6dHjldbMs7nOyMLROPvy9NrDMLagtbIk8bb/kcw
	GvWVeP81ZXTSWLEuEpFATA4/q3NovMI7cy0x/hV7W8Grr6ZNaG3iYHZO9eVO6HNa2WG06E7wvNd
	Twqnrqq6MtILJByoRwfDnBzmeBuAWFC3iTOffztl3wBXpzEaIGb5fKPhyTdZAl6AJZrpIgaxCrU
	daGTajSSoZ7qZuXcvBJNsF3PdTYOyCx+8WMRHO6T6aj7VKJyRixBrC/eAyRbmBr7PJNanA
X-Received: by 2002:a17:90b:28d0:b0:3a8:768d:70e4 with SMTP id 98e67ed59e1d1-3a8a1b59a17mr5454105a91.17.1791481975880;
        Thu, 08 Oct 2026 10:52:55 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab3277c459sm144332a91.16.2026.10.08.10.52.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 10:52:55 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	David Wu <david.wu@rock-chips.com>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Coia Prant <coiaprant@gmail.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v11 1/6] net: pcs: xpcs: add ANRESTART support for SGMII link recovery
Date: Fri,  9 Oct 2026 01:51:55 +0800
Message-ID: <20261008175225.3375274-2-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261008175225.3375274-1-coiaprant@gmail.com>
References: <20261008175225.3375274-1-coiaprant@gmail.com>
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
index b415b93d77c15..6466e0ff2a98b 100644
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

