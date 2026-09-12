Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BA136E494
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 23:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789257093; cv=none; b=KVqJ4lVLoEHXfjwA2KvlR84PBL49GBdAP0xk7Yo+Bfb8uU3rtrrBHKXu/yp2iHndWFZkHNNrF/DG4Kh0Z8tz5zoE/VB4D410154FR76q9sqE8vmyd1YUL51ENBMqevoTS9vsTBFL/SSBdq8RDs/UiF73ggaY91iNqgyaRJHGP/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789257093; c=relaxed/simple;
	bh=fD9xegSujnsT4NKnlfjWBz0getfDwxDziPE/OzXLPzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jt9TyfmCYTlIhHqN+sYZj9rZm+jfVRFhZnKdQBNGsKegHnHW2bEhbj6gcuhf1K/l77WSeJJlWvj6mRhrQ4faiIPemrX2qbjJZw5mYfeIyaa6oh9Jy8xAx6J4PoCH1w0Siut/6h6YP4YZ8n3/ippYP4rRNnnmHfSGRWykUnDcBoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=o3VAHv82; arc=none smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="o3VAHv82"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-90cdfcbe20aso11652176d6.2
        for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 16:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789257090; x=1789861890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P9J6NG/MV7DU9c7t3z7uXv1DPj7gHWd/klA6eHMwHZo=;
        b=o3VAHv82RPTcsoGv+o/rwriT8Rva/nR2SAw4/upykMRGJPLF9EX7VKV/34/zJx6MzR
         u64cxRQM0MnVQZ0T5ACzOHRHPFQsfI9N6SOUj8jAn4Z1K7rxwqxF9OxHkERVcaXSzZaP
         jVOuM1pirXlmy+FE8ao4pcHQEeCyvrgfKOfMe/vtHRCbbpRooqUtEeRHBgpA9r7VQ+QP
         bwNqeQ1Er574ASxtAhyQ057IKCzUZm94Qmx8IleLYt6x94VG68ARPib4uo/jEIiKfUZ+
         J5FzBs09TxNcnWAxZ9k9Q8Cu68x6aBnbXUYrp9jzWgjpYZOR4pdZlccQg56l5KBG1fAF
         vuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789257090; x=1789861890;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P9J6NG/MV7DU9c7t3z7uXv1DPj7gHWd/klA6eHMwHZo=;
        b=GiVRnkIvrZFcVMyh5o3gTl5HyLDb18DFaOv6Oxy/Cr/+j2uOakhroEkcit6pWpbu08
         XJBB3ZR+EUsuUauQS7ANWUEX877qXeHtj1b5oTWGmnDHTvKTCN+vqoLnF7FSvGa/P55s
         sFMJp8ssM9fHCBKx0cIU9JYsfRRfsWVMxkNCy9QZaqvIUgwR3G9+TLlDoFhq2SaPJ2HT
         DSA0B5KZuL0n23wQQy5NBp2kLA63XDed4TUgDQoSgKkcxbllwO7q45WPYDXiZ+M+PW8s
         7BazpVWU79bX91c9XU6avTf3XrpnU7jVfquKPVbg7jJqjhfGyQykFna6LU0stXfRsqsi
         nNHQ==
X-Gm-Message-State: AFuF++lsXdfQ8p73kPuJ8oM+EaFSwB+FF6B1mfbufpIh+Gl4oB65GdNu
	cKWcyMLGxcFpvqkMsHUqZVmGaggteO2mZ1DGJneZlI+uDaW3klirl9Sl8Dkl4w==
X-Gm-Gg: AYBFou3MQtTXtNl9nnDPMqRM6Ss3AANkWyHBy8jc1nwyucH1xDV97BGstB+msjB9Rhz
	FZjNKf1BM9R/cjYYuerRaNajT5BTWPQBIQ7anIASkAZ/1ly1Plf94pwDCHEL429aHiYuup76I9Q
	BAWcMYcN3+X5mFEdQNUbTMRg2+gRsRX3HA8DUZHEzS6kutAQJcvX011a1YMLOB45w29otvd8x/e
	VrL8TcpPm1VbNLk/zbgIdxbT7EOxTflNHxcfQy/ne/FjQIbjjXTyYxhlxa+fHKVlAvZKWekRGtQ
	V/r8rjtE0w3oLpo5xsUEys4FQPWqTQTbOqwDFCyHpYTF+Ayso1ecD4nLe1/hPWpHMkvdmJVgUXF
	fJVLGW/8DDLLgBpFth3N5Wuj+78pRBzt8IXN/Bcu8vRbK4ATwWyXQY2ygh+frTvvJeZOarbAEbv
	KRg5S5vD5Zdu1crL17qbTVNH/jhE7Py11hHnE2vqCPdMk5eShBm5j3SRpaEK4rvdh79FjkU/e3q
	wrz29Sr6OSHIdneyQm7vEOYuRzz3CVkeFeHMTXo5Q7ukKxzcylfqrgx1nFQ5jOagmFav6mFKDug
	tNhP9FL9vol6zNfe9NNSlIYW+S4SefXE3UXn1h+P3bEZYk9bXUj8obv+pIc=
X-Received: by 2002:a05:622a:64a:b0:530:4310:53a3 with SMTP id d75a77b69052e-530e81d49c7mr71418151cf.48.1789257090557;
        Sat, 12 Sep 2026 16:51:30 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-530cd3ab1d1sm54050791cf.17.2026.09.12.16.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 16:51:29 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: phy: marvell: wake the system only from the WoL event
Date: Sat, 12 Sep 2026 16:51:25 -0700
Message-ID: <20260912235125.151370-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Enable waking the system from a WoL event on the 88E1318S/88E1510.

When WoL is enabled, m88e1318_set_wol() now calls enable_irq_wake()
on the PHY's IRQ and marks the MDIO device as a wakeup source so the
underlying GPIO interrupt raises the system from suspend, and reverses
both on disable.

With WoL active the PHY must stay powered to detect a magic packet,
but without masking, phy_suspend() would leave every interrupt
enabled, so a link status change or any other PHY event would assert
INTn and spuriously wake the system. Set PHY_ALWAYS_CALL_SUSPEND on
the 88E1318S/88E1510 drivers so that phy_suspend() still calls their
suspend callbacks with WoL enabled, and have those callbacks keep the
PHY awake while writing the interrupt enable register (CSIER/IMASK)
down to only the WoL event bit.

marvell_config_intr() rewrites the whole CSIER register with
MII_M1011_IMASK_INIT on resume, clearing the WoL enable bit. Re-arm
WOL_EIE in the resume callbacks so the WoL interrupt stays active for
the next sleep cycle.

Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/phy/marvell.c | 145 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 138 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index f71cffa88406..70aaa09f2047 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -30,6 +30,8 @@
 #include <linux/ethtool_netlink.h>
 #include <linux/phy.h>
 #include <linux/phy_port.h>
+#include <linux/pm_wakeirq.h>
+#include <linux/property.h>
 #include <linux/marvell_phy.h>
 #include <linux/bitfield.h>
 #include <linux/of.h>
@@ -1902,6 +1904,61 @@ static int marvell_resume(struct phy_device *phydev)
 	return err;
 }
 
+/* marvell_wol_suspend_intrs
+ *
+ * With WoL enabled the PHY has to stay powered to keep detecting a WoL
+ * packet, so instead of entering low power mode, mask all interrupt
+ * sources except the WoL event. On the 88E1318S/88E1510 the interrupt
+ * mask (MII_M1011_IMASK) is the same register as the Copper Specific
+ * Interrupt Enable Register (MII_88E1318S_PHY_CSIER), so writing only
+ * the WoL event enable bit unmask just that event.
+ */
+static int marvell_wol_suspend_intrs(struct phy_device *phydev)
+{
+	int oldpage, ret;
+
+	oldpage = phy_save_page(phydev);
+	if (oldpage < 0)
+		return oldpage;
+
+	ret = marvell_write_page(phydev, MII_MARVELL_COPPER_PAGE);
+	if (ret < 0)
+		goto out;
+
+	ret = __phy_write(phydev, MII_88E1318S_PHY_CSIER,
+			  MII_88E1318S_PHY_CSIER_WOL_EIE);
+out:
+	return phy_restore_page(phydev, oldpage, ret);
+}
+
+/* marvell_wol_resume_intrs
+ *
+ * marvell_config_intr() rewrites the whole MII_M1011_IMASK register
+ * (which is MII_88E1318S_PHY_CSIER) with MII_M1011_IMASK_INIT on
+ * resume, clearing the WoL event interrupt enable bit. Re-arm it if
+ * WoL is still enabled so a later WoL event keeps waking the system.
+ */
+static int marvell_wol_resume_intrs(struct phy_device *phydev)
+{
+	int oldpage, ret;
+
+	if (!phydev->wol_enabled)
+		return 0;
+
+	oldpage = phy_save_page(phydev);
+	if (oldpage < 0)
+		return oldpage;
+
+	ret = marvell_write_page(phydev, MII_MARVELL_COPPER_PAGE);
+	if (ret < 0)
+		goto out;
+
+	ret = __phy_set_bits(phydev, MII_88E1318S_PHY_CSIER,
+			     MII_88E1318S_PHY_CSIER_WOL_EIE);
+out:
+	return phy_restore_page(phydev, oldpage, ret);
+}
+
 /* m88e1510_resume
  *
  * The 88e1510 PHY has an erratum where the phy downshift counter is not cleared
@@ -1934,9 +1991,25 @@ static int m88e1510_resume(struct phy_device *phydev)
 
 		/* downshift enabled, with previous counter value */
 		err = m88e1011_set_downshift(phydev, cnt);
+		if (err < 0)
+			return err;
 	}
 
-	return err;
+	return marvell_wol_resume_intrs(phydev);
+}
+
+/* m88e1510_suspend
+ *
+ * If WoL is enabled the PHY receiver has to keep running to detect a
+ * magic packet, so keep it awake and unmask only the WoL event at the
+ * PHY. Otherwise suspend both the fiber and copper interfaces as usual.
+ */
+static int m88e1510_suspend(struct phy_device *phydev)
+{
+	if (phydev->wol_enabled)
+		return marvell_wol_suspend_intrs(phydev);
+
+	return marvell_suspend(phydev);
 }
 
 static int marvell_aneg_done(struct phy_device *phydev)
@@ -1969,8 +2042,12 @@ static void m88e1318_get_wol(struct phy_device *phydev,
 static int m88e1318_set_wol(struct phy_device *phydev,
 			    struct ethtool_wolinfo *wol)
 {
+	struct device *dev = &phydev->mdio.dev;
+	bool wol_enable;
 	int err = 0, oldpage;
 
+	wol_enable = !!(wol->wolopts & (WAKE_MAGIC | WAKE_PHY));
+
 	oldpage = phy_save_page(phydev);
 	if (oldpage < 0)
 		goto error;
@@ -2075,7 +2152,49 @@ static int m88e1318_set_wol(struct phy_device *phydev,
 	}
 
 error:
-	return phy_restore_page(phydev, oldpage, err);
+	err = phy_restore_page(phydev, oldpage, err);
+	if (err < 0)
+		return err;
+
+	if (device_can_wakeup(dev) && wol_enable != device_may_wakeup(dev)) {
+		err = device_set_wakeup_enable(dev, wol_enable);
+		if (err < 0) {
+			/* Roll back the PHY WoL config if the PM state update failed */
+			struct ethtool_wolinfo wol_off = { .wolopts = 0 };
+			int rollback_err = m88e1318_set_wol(phydev, &wol_off);
+
+			if (rollback_err < 0)
+				phydev_err(phydev,
+					   "Failed to disable WoL after wakeup enable error %d\n",
+					   rollback_err);
+		}
+	}
+
+	return err;
+}
+
+/* m88e1318_suspend
+ *
+ * If WoL is enabled keep the PHY awake so it can detect a magic packet
+ * while the system is asleep, unmasking only the WoL event at the PHY.
+ * Otherwise suspend the PHY normally.
+ */
+static int m88e1318_suspend(struct phy_device *phydev)
+{
+	if (phydev->wol_enabled)
+		return marvell_wol_suspend_intrs(phydev);
+
+	return genphy_suspend(phydev);
+}
+
+static int m88e1318_resume(struct phy_device *phydev)
+{
+	int err = genphy_resume(phydev);
+
+	if (err < 0)
+		return err;
+
+	return marvell_wol_resume_intrs(phydev);
 }
 
 static int marvell_get_sset_count(struct phy_device *phydev)
@@ -3587,14 +3706,25 @@ static int m88e1318_led_hw_control_get(struct phy_device *phydev, u8 index,
 
 static int marvell_probe(struct phy_device *phydev)
 {
+	struct device *dev = &phydev->mdio.dev;
 	struct marvell_priv *priv;
 
-	priv = devm_kzalloc(&phydev->mdio.dev, sizeof(*priv), GFP_KERNEL);
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
 	phydev->priv = priv;
 
+	if (device_property_present(dev, "wakeup-source") &&
+	    phy_interrupt_is_valid(phydev)) {
+		int ret = devm_pm_set_wake_irq(dev, phydev->irq);
+
+		if (ret)
+			return ret;
+
+		device_set_wakeup_capable(dev, true);
+	}
+
 	return marvell_hwmon_probe(phydev);
 }
 
@@ -3813,6 +3943,7 @@ static struct phy_driver marvell_drivers[] = {
 		.phy_id_mask = MARVELL_PHY_ID_MASK,
 		.name = "Marvell 88E1318S",
 		/* PHY_GBIT_FEATURES */
+		.flags = PHY_ALWAYS_CALL_SUSPEND,
 		.probe = marvell_probe,
 		.config_init = m88e1318_config_init,
 		.config_aneg = m88e1318_config_aneg,
@@ -3821,8 +3952,8 @@ static struct phy_driver marvell_drivers[] = {
 		.handle_interrupt = marvell_handle_interrupt,
 		.get_wol = m88e1318_get_wol,
 		.set_wol = m88e1318_set_wol,
-		.resume = genphy_resume,
-		.suspend = genphy_suspend,
+		.resume = m88e1318_resume,
+		.suspend = m88e1318_suspend,
 		.read_page = marvell_read_page,
 		.write_page = marvell_write_page,
 		.get_sset_count = marvell_get_sset_count,
@@ -3920,7 +4051,7 @@ static struct phy_driver marvell_drivers[] = {
 		.name = "Marvell 88E1510",
 		.driver_data = DEF_MARVELL_HWMON_OPS(m88e1510_hwmon_ops),
 		.features = PHY_GBIT_FIBRE_FEATURES,
-		.flags = PHY_POLL_CABLE_TEST,
+		.flags = PHY_POLL_CABLE_TEST | PHY_ALWAYS_CALL_SUSPEND,
 		.probe = marvell_probe,
 		.config_init = m88e1510_config_init,
 		.config_aneg = m88e1510_config_aneg,
@@ -3930,7 +4061,7 @@ static struct phy_driver marvell_drivers[] = {
 		.get_wol = m88e1318_get_wol,
 		.set_wol = m88e1318_set_wol,
 		.resume = m88e1510_resume,
-		.suspend = marvell_suspend,
+		.suspend = m88e1510_suspend,
 		.read_page = marvell_read_page,
 		.write_page = marvell_write_page,
 		.get_sset_count = marvell_get_sset_count,
-- 
2.55.0

