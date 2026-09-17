Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C64739D6DA
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 22:01:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789682501; cv=none; b=By61dg+2zEaG5Rg2U8dqmniezPiZGyR8hmwGdGrYc6nI7afHgHWHjugChcTuyjvllgVXcWNO9uoz+yyhJUVNOjtV0PPMAHVppPHw/6mPHaQO6cAVgBMLYGkw3aDbgfF/nLgdIaFIG1ar/uucVwyGrcikYKMo4F9aau8hAA6Pvtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789682501; c=relaxed/simple;
	bh=3FbVHQnTkGovq9MgVS1AQASJkqVSWyehhrk2OYOMakI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EknRuDjhSc/+ibnp1qd4cGK4Umt1JejsQntKMwuVlfX6F5dEQxMo6jhHFQlhdUuwwhAPSJYnEJH9OzB1tNnUl87npYNwu6w9uUvtfNlknhLjXBQ0Qw95wtMzfZGQx90hN+Q6PK1PerQiyx7uPASF6CWsA5S0Oe9gMFLFwgf33Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p1mutKsU; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p1mutKsU"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb74fso137867a91.3
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 15:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789682500; x=1790287300; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=s26IKeArHLYvAsw8SAUC36S/S5ndCgDyvi2cfvHZSzE=;
        b=p1mutKsUJfYS5DICIzP1SbGJtbXs6bFz50GqM6/1fpxp6XCMpmNA4+uHR7YVV/NTYh
         wprRa08STJaxRoeBO/3JzSLB0YM7dZTkOZ/odqIeKfQNnMxMcMLAlIRh07Z5M46fRiTI
         WuE1hIaUOaHvVkc+vWJTU2z2VwsACDPCU+cLFumui28cxLbgNTiZFWL5BGB6iWfWvdUI
         AlplhNZdXvZ2N/3+S02EdoQPbA5RSrG56lZl+Ei93fHoONjBiXAlAhdym4++DcxR0Mn3
         95mdWWJc4/lFnMK2L93IBIkLPRnJW4MqCsgz2UJihk1Cg0vb5Vd7o+EmjnDbswaOgrSl
         ytDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789682500; x=1790287300;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=s26IKeArHLYvAsw8SAUC36S/S5ndCgDyvi2cfvHZSzE=;
        b=mIqi+vcXMlIPBvmiLnt0kEXzPv1qRssArKkc1k4OM4SMdrLNx7HVa4y/yzXTddhPx9
         J4rzieEOGdDpg2ealydbM3sNlxb/GiGGyMNZaDiBBjWYtXa+w5thZRsgEtzl73+EzP4q
         oIiPhBCW8TwkuvkNosN5PVU40Q/gDS6lYdRL2pc003hGXRtqy/KJkIN/eDk5udIcpbEy
         d9r7ijAg4xvbNZqv48iYL4nOro4T/vJAN6uAeCs4bxAW19iSXWMA4xrCLbfWMopfi6jf
         dVbJW+pE9cpUSt5lWlmoLsDQTCeq5/4iKK66BjGrUyjDGJNHZgxuMAuN2w5Cuo4ZI004
         d4Ag==
X-Gm-Message-State: AFuF++nem8/QTNkZeN9+yfTyLlwkHnc0UNsZGsH2uAAI8tCyuwYNpyyt
	oU6cy/Cf4//6yc4IsGJYeeYLmxJ7KRiv7zc5gVMP8aj7zKXZQblWreFD7JIjbA==
X-Gm-Gg: AYBFou3LO2cA/LqzRaSWfGtIcCtMksbmIFTHFW2JeXpAEzqy2ehQgRU+c+r3Vu8rFB/
	M24GqRq4kNWod6caMIkVs+NDYh6fLzt+vfqtWlpoas88OyL4KoGiXMk/npfpDabGt0wr3+GN/xM
	QJwyvsgDzm9e/Vy/nYqgsZ1kM/1PQGLi3DRRygqCpG/TX+G/UuoeRaOhP+RW534zpx8StXgZskU
	7XKcMEHxN5rMg1htD8c35LTnt04qe2b6K8z5HQCSn2ZsiixiKrMmJN6OF08fdSAY4TXACDePys+
	4b+4VYfb6DQenF79B3JkBINV4LSUw//OfJtMmabySx1d9twswgTuhde9kC6nCnUBUGDoJ/pcele
	Mlc3ZUy+3gm4oYh/qPN/dDLsiT7ksReTU9Mq/2GwqSPBQbM0ATWE0zH4cJJBqy4kESHelrB1UY8
	zNvhXnyWFkb4+lXMa/Au7lBcOLKE1cqUeko90XuQMNzJEhzeIlj//r/A9iN4EV0VNWwuP1QS+7M
	axKh0ODkeh2mtiDgnTyLic448XqMh97L0nLPV3w9j18Cv9gdJ+rSy5DTByCKXRLe+UdcgipUXRi
	AcFNM6UBsoaM7hsbbtDkg7OJX7r7DK1JwWyVR3eDN+61DzaQyWEeGK4QM4I=
X-Received: by 2002:a17:90b:380b:b0:39e:4fec:d6e5 with SMTP id 98e67ed59e1d1-39e550707e6mr1200498a91.16.1789682499730;
        Thu, 17 Sep 2026 15:01:39 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14395cfb0b1sm14235004c88.5.2026.09.17.15.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 15:01:38 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Michael Stapelberg <michael@stapelberg.de>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: phy: marvell: keep WOL_EIE across interrupt reconfiguration
Date: Thu, 17 Sep 2026 15:01:36 -0700
Message-ID: <20260917220136.97017-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the 88E1318S/88E1510, copper page register 0x12 is both the
MII_M1011_IMASK interrupt mask used by marvell_config_intr() and the
CSIER register in which m88e1318_set_wol() arms the WoL interrupt
(MII_88E1318S_PHY_CSIER_WOL_EIE). marvell_config_intr() rewrote the
whole register, so any interrupt reconfiguration (for example the
phy_disable_interrupts() on link down behind mvneta) silently cleared
WOL_EIE: m88e1318_get_wol() still reported WAKE_MAGIC, but a matched
magic packet was no longer routed to INTn and the board did not wake.

Give these two PHYs a dedicated config_intr that preserves WOL_EIE with
a read-modify-write, and a handle_interrupt that also claims the WoL
event mirrored in the interrupt status register. Other Marvell PHYs keep
the plain marvell_config_intr()/marvell_handle_interrupt().

Fixes: 3871c3876f80 ("mv643xx_eth with 88E1318S: support Wake on LAN")
Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/phy/marvell.c | 70 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 66 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index f71cffa88406..0897cfcd6ab7 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -425,6 +425,68 @@ static irqreturn_t marvell_handle_interrupt(struct phy_device *phydev)
 	return IRQ_HANDLED;
 }
 
+/*
+ * On the 88E1318S/88E1510, copper page register 0x12 serves two
+ * masters: it is the MII_M1011_IMASK interrupt mask for the generic
+ * Marvell interrupt handling, and m88e1318_set_wol() sets the WoL
+ * interrupt enable bit (MII_88E1318S_PHY_CSIER_WOL_EIE) in it. The
+ * interrupt routines below therefore preserve that bit, so reconfiguring
+ * the PHY interrupts cannot disarm Wake-on-LAN behind the user's back.
+ */
+static int m88e1318_config_intr(struct phy_device *phydev)
+{
+	int val, err;
+
+	val = phy_read(phydev, MII_88E1318S_PHY_CSIER);
+	if (val < 0)
+		return val;
+
+	if (phydev->interrupts == PHY_INTERRUPT_ENABLED) {
+		err = marvell_ack_interrupt(phydev);
+		if (err < 0)
+			return err;
+
+		err = phy_write(phydev, MII_88E1318S_PHY_CSIER,
+				MII_M1011_IMASK_INIT |
+				(val & MII_88E1318S_PHY_CSIER_WOL_EIE));
+	} else {
+		/* Disable the PHY interrupts, but keep WOL_EIE set so an
+		 * armed magic packet still asserts INTn while the
+		 * interface is down or the machine is suspended.
+		 */
+		err = phy_write(phydev, MII_88E1318S_PHY_CSIER,
+				val & MII_88E1318S_PHY_CSIER_WOL_EIE);
+		if (err < 0)
+			return err;
+
+		err = marvell_ack_interrupt(phydev);
+	}
+
+	return err;
+}
+
+static irqreturn_t m88e1318_handle_interrupt(struct phy_device *phydev)
+{
+	int irq_status;
+
+	irq_status = phy_read(phydev, MII_M1011_IEVENT);
+	if (irq_status < 0) {
+		phy_error(phydev);
+		return IRQ_NONE;
+	}
+
+	/* Claim events from the IMASK_INIT set as well as the WoL event
+	 * mirrored from WOL_EIE in the enable register.
+	 */
+	if (!(irq_status & (MII_M1011_IMASK_INIT |
+			    MII_88E1318S_PHY_CSIER_WOL_EIE)))
+		return IRQ_NONE;
+
+	phy_trigger_machine(phydev);
+
+	return IRQ_HANDLED;
+}
+
 static int marvell_set_polarity(struct phy_device *phydev, int polarity)
 {
 	u16 val;
@@ -3817,8 +3879,8 @@ static struct phy_driver marvell_drivers[] = {
 		.config_init = m88e1318_config_init,
 		.config_aneg = m88e1318_config_aneg,
 		.read_status = marvell_read_status,
-		.config_intr = marvell_config_intr,
-		.handle_interrupt = marvell_handle_interrupt,
+		.config_intr = m88e1318_config_intr,
+		.handle_interrupt = m88e1318_handle_interrupt,
 		.get_wol = m88e1318_get_wol,
 		.set_wol = m88e1318_set_wol,
 		.resume = genphy_resume,
@@ -3925,8 +3987,8 @@ static struct phy_driver marvell_drivers[] = {
 		.config_init = m88e1510_config_init,
 		.config_aneg = m88e1510_config_aneg,
 		.read_status = marvell_read_status,
-		.config_intr = marvell_config_intr,
-		.handle_interrupt = marvell_handle_interrupt,
+		.config_intr = m88e1318_config_intr,
+		.handle_interrupt = m88e1318_handle_interrupt,
 		.get_wol = m88e1318_get_wol,
 		.set_wol = m88e1318_set_wol,
 		.resume = m88e1510_resume,
-- 
2.55.0

