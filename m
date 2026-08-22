Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720DB3F86EE
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 15:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787413994; cv=none; b=eRzTQURwB5PR/tJfTQLfUgm28ULcrqvFMNHLzIuXLcBww8Ib5ejlVa1bJy5BXvX+hsYujvq8zhczhXRQ+9C1u9CFFEU/Ox5VOymx8UHHIX8/RK6rvVOnAOtF355XWqodqhyaGQ+eMuD7uslDgbv/iBxi1Rq/RbNvTqjs6jMyw7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787413994; c=relaxed/simple;
	bh=PEdLvA4GpT1cwRKppTTyjQ9Hm086QYTXZOhbR/7hS28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=siXzJbU3VuzD7v5L4UbZc+LPzIYWA1BYLEmMwWdTU4W9QpLo/TGtw2MZcYtp2khvOl+HrwxCEJM4wyJn142bLGDanxnjiDcAgOwR4S8grRJmy0MwPHV7q8ePkGzJJqDTQCm9FX1M4eZ36LFkZDkTFInfScmrxwGxOUoI0KyhnAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=Ollze9ua; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="Ollze9ua"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-69fab5a852cso3593318a12.0
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 08:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1787413990; x=1788018790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LtVl3RA330rX+Ddr3fAI1EuluyZ5pYws23mx3vWwVMo=;
        b=Ollze9uaPiuPgW88DZAMfAqt+pbmNmQcs2dJyUeGbOVPIWbsbblvnTG1rvxw+8Z0z6
         6cLAW7PQN7ADk3wq22payJdxt5f2n+jCYqFyGr1wpC1qO8IEMbGSmxwfqVqbjNr378Gx
         bWy5LDzV0PliYE7WGgnb++f9IcJxSImnERCRAKj/sbmCm+JUJJWphFBtP2CewvzBCFxg
         1sIkLpEkCqzxezTOUkuH8dtG9joY2cO/Hto31q2K4NpDJptHCEVS90lGltZBkYiepiJ9
         63x1C7jtEg/9lXYGJZyVfLUhtNPc/uWasuXPbVPVKLdRIVJEAWPeWiP8kKKusADrYW1R
         ZP1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787413990; x=1788018790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LtVl3RA330rX+Ddr3fAI1EuluyZ5pYws23mx3vWwVMo=;
        b=MWBUnR/aES+emTBR7EeeryyToCKuWDl8BOS8SCJIU6gsoiIgSQ4fjiPkyyG9Y4mV1B
         Fge/h0xYTbnx0fprQ+7NICJqXuNCF1FYG5aWmoz23bnioomSiMMaevRkOq6waj2c3zoy
         x2kqtZYgBHS0eOsU4JFSL2P5njR2kso2GrK1FlKU6IeHVJ9FXMqPggrbeAcTioWlM3sG
         CBIRm8NZLyXt0nLe6u9+AsqZjHxXlm6OoRhoARPLpdjQyAG8CcOtikPiIaE9caofIcM7
         y9Iv4UAjhfVmGAtXDADuaswjymJsefSvcXxo8orvzTz/X2a2NynTIU+1u6FzU5FhcaQd
         BIJw==
X-Forwarded-Encrypted: i=1; AHgh+Rpj866x6nT6rnQDdGg+PRgDJvNYj9Sr5ZQWbRJ9mSWHyPblWnKbvyjUSgfaAxLhqeVKIfR+LlY=@vger.kernel.org
X-Gm-Message-State: AFuF++lToMoqQKBmoz/DEkLKsWsWAcalBM8K5z/KyzkEQ9ekAb0ZtCgk
	WTVeIzYfq5vC8oa0c/pnOXxIDis3Q+v/0BrckW/j9bPxI0HipEI4SPUjU3ngFscnPcg=
X-Gm-Gg: AR+sD10ondnkrGejHSgJLrb7dy7rl/z8av+/G5yzlauOLGUOu3EcLtareF81I34cDrA
	7AOQK4UR23D7mlAdBEhV8ydLRAeLBfNwgCqtAHYimePhb5X8HLPEgJaZxWuTiHns+p3gt6iLbqA
	Ubq0CDpmdCVtbUwaeQw65JKb6ss6cu1adCc0AFfBuASytI6gOuhJp03jw9TALYVnaWeYKFA49u/
	/IN9FSU87LBLHMcI+JhcLuRbgRytZt+irYiX5JCX8tlCLYS0kIsyCgZCySPO8OCEUf9rIHbwzDo
	Wn66SOcgPK5VwPnjFlE/Tlhj8sVAq19sRddyrlstddFAI/2bkzAk42+BYpm9cMkI86t7G0jfK4r
	tIs5DFO5h+dKX2csXyh8zCqUu+fDWQ1L3Cekaq7RKx6T2leMoD0lVw3LpHK0jszptXFdQ0a/4Dl
	NH7uYI7HxeHHNN3HM2yOGCofX5nm8lIXbrElKNg4BTl2yQ6yFgumvX+8qROhitlcBGoAzfGQ52g
	Im2E6g+
X-Received: by 2002:a05:6402:2186:b0:6a1:2400:baea with SMTP id 4fb4d7f45d1cf-6a42f18a70cmr13414465a12.10.1787413990540;
        Sat, 22 Aug 2026 08:53:10 -0700 (PDT)
Received: from ownbook.home.lex.la ([84.17.55.225])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3ff16c546sm12396250a12.21.2026.08.22.08.53.08
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 22 Aug 2026 08:53:09 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksei Sviridkin <f@lex.la>
Subject: [PATCH net-next 2/3] net: phy: restore the interrupt after a generic-driver bind cycle
Date: Sat, 22 Aug 2026 18:52:58 +0300
Message-ID: <20260822155259.87146-3-f@lex.la>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822155259.87146-1-f@lex.la>
References: <20260822155259.87146-1-f@lex.la>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fwnode_mdiobus_phy_device_register() resolves the interrupt declared
for a PHY once, at MDIO bus registration. If no specific driver is
available when the PHY is attached, the generic driver binds and
phy_probe() parks the device in polling mode, since the generic driver
has no interrupt callbacks. phy_detach() releases the generic driver
so a specific driver can bind later, but nothing brings the interrupt
back: the firmware node is never re-read after bus registration, so
the specific driver attaches with irq == PHY_POLL,
phy_request_interrupt() is never reached, and the PHY is polled for
the rest of the uptime with nothing in the logs but the "irq=POLL"
attach line.

A DSA switch probing before the rootfs is mounted produces exactly
that cycle for a PHY whose driver is a module: the generic driver
binds and fails validation during switch setup, and the real driver
binds at ifup. Observed on an MT7981B board with an Airoha EN8811H on
an MT7531 port: the device tree declares the INT_B line, yet the
attach says irq=POLL and the interrupt is never claimed.

Save the interrupt when the generic driver binds and give it back when
that driver is released. The restore runs before the device becomes
bindable again, so a concurrently arriving specific driver cannot
observe or overwrite the intermediate state. Only the value the
generic-driver cycle took is restored. A PHY already parked in polling
mode before that cycle, by a failed phy_request_interrupt() or by a
driver that chose PHY_POLL in its own probe, had PHY_POLL saved, so the
restore is skipped. The PHY_F_NO_IRQ and no-interrupt-support checks in
phy_attach_direct() still apply to whichever driver binds next.

Signed-off-by: Aleksei Sviridkin <f@lex.la>
---
Testing

MT7981B board, mt7530 switch, Airoha EN8811H whose INT_B line is in
the device tree, driver in a module on the rootfs, together with the
next patch: the attach line reports irq=15 instead of irq=POLL, the
EINT is claimed, its counter advances on link changes forced from the
link partner, and there is no interrupt storm. The SoC's internal PHY
on the same board, which has no interrupt in its bus table, keeps
irq=POLL through the same boot, so the save-restore pair does not
resurrect an interrupt the device never had. Consistent across
reboots. Hardware testing was done on 6.18 with this exact
shape of the change; on net-next the files are compile-tested.

The saved value uses zero as "nothing saved"; no registration path
produces a valid interrupt number of zero, and non-positive values are
never restored.
 drivers/net/phy/phy_device.c | 13 +++++++++++++
 include/linux/phy.h          |  6 ++++++
 2 files changed, 19 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 94b2e85e0..6047dce61 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1780,6 +1780,7 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 		else
 			d->driver = &genphy_driver.mdiodrv.driver;
 
+		phydev->genphy_saved_irq = phydev->irq;
 		phydev->is_genphy_driven = 1;
 	}
 
@@ -1897,6 +1898,9 @@ int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 error_module_put:
 	module_put(d->driver->owner);
 	phydev->is_genphy_driven = 0;
+	if (phydev->genphy_saved_irq > 0 && phydev->irq == PHY_POLL)
+		phydev->irq = phydev->genphy_saved_irq;
+	phydev->genphy_saved_irq = 0;
 	d->driver = NULL;
 error_put_device:
 	put_device(d);
@@ -1965,6 +1969,15 @@ void phy_detach(struct phy_device *phydev)
 	 * real driver could be loaded
 	 */
 	if (phydev->is_genphy_driven) {
+		/* Give back the interrupt phy_probe() parked when the generic
+		 * driver bound, before the device becomes bindable again. A
+		 * PHY that was in polling mode for any other reason had
+		 * PHY_POLL saved, and the restore is skipped.
+		 */
+		if (phydev->genphy_saved_irq > 0 && phydev->irq == PHY_POLL)
+			phydev->irq = phydev->genphy_saved_irq;
+		phydev->genphy_saved_irq = 0;
+
 		device_release_driver(&phydev->mdio.dev);
 		phydev->is_genphy_driven = 0;
 	}
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 5f8d65868..43e20b19e 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -591,6 +591,10 @@ struct phy_oatc14_sqi_capability {
  *      - Bits [31:24] are reserved for defining generic
  *        PHY driver behavior.
  * @irq: IRQ number of the PHY's interrupt (-1 if none)
+ * @genphy_saved_irq: value of @irq before the generic driver bound, given
+ *                    back when that driver is released; zero outside a
+ *                    generic bind cycle, and non-positive values are
+ *                    never restored
  * @phylink: Pointer to phylink instance for this PHY
  * @sfp_bus_attached: Flag indicating whether the SFP bus has been attached
  * @sfp_bus: SFP bus attached to this PHY's fiber port
@@ -762,6 +766,8 @@ struct phy_device {
 	 */
 	int irq;
 
+	int genphy_saved_irq;
+
 	/* private data pointer */
 	/* For use by PHYs to maintain extra state */
 	void *priv;
-- 
2.43.0

