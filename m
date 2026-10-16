Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972B746983E
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 11:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792149649; cv=none; b=aqhTvc4AWNj5jp7DxdZa4GzB9iIg1MHzXltxMal9Jw82IrYynAGUP+OaLyGZqMFA4/0IDQLdVi3Q947SSwGHpq8n/vYYdEnNTufH5vKBSBPVGbJU/D5F7/gQf2mwVBTkXhicUP0dFsqsVqvvifhaFQ5JBSb3Xqe4QqLTi1kbdMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792149649; c=relaxed/simple;
	bh=tmWFUe4O5IyO+8CbBVqEmkvkD5jfEE2Ew7bX38+bRZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DFb0C6xGGh5EG9Crc7nz5eeoXVm0ugMgf4H3OVWE5XGi+JRzyFG+jkHQUi6366XI6n6sKiB//17FhkCUytbY/8YF6GYK8/zZLaYr4i2Eojc05Cz0Fz92iIsg9FUNiANyFQ1rQlTBZTpZJzEjGk6GDgxiCIPieZ2d+19+mGDp9gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=lUCuhSfi; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="lUCuhSfi"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c40447e25e6so115730966b.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 04:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1792149646; x=1792754446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vzZ+drt3dgf4DTiJO8FECQLY/kCD4mxzJHRqbEltdUk=;
        b=lUCuhSfietg2C8LyHurFBaVzhMwIbAYzKaSOx2g6NH0Yy2Tj+BBfsKT+jatlkONlhl
         /ieXeipWVY7GM/xQ3GJW/q6ZbQmAZOdY843Dek4dXJU+Zowb3ecANaT/NYNQo1HBO9eg
         rgXnfIlFE/mqi8zagoeEdiVj34uXLGT2Fi8ql4JdB7e0wGo5O61ASBBvjXRJ5E7vjRxT
         2/MsmBAI3x2mlaBACDVOaCXVIVD384gmIWWgyc9ZcUtg5KYRCsjkTBC8JxD7MmENRc6i
         YH1mTK0ia8TpYj91BAxJbwevjQIHbnTG6k2HSUf3bHvzyHweTrAeubaIgJ8bkDC7yDid
         7cog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792149646; x=1792754446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vzZ+drt3dgf4DTiJO8FECQLY/kCD4mxzJHRqbEltdUk=;
        b=N+OGF2/BNHunZnHCM8a7bH4YthDq6Z1GbkjgAMcBdEnIiEapzMVWnBkEVSjSaZ/kso
         rF138iQcJ4/iHEt5sYJ6PGT2TJ70ChUf1Nfi9fHm1U4ZVXy6qxEDhSgN8byrHkTWfnta
         shRyIh2jCvsvbvj6DWwcFOavIyCcffjWHBooOXmN1jv9GB5l3QqFhpzW7HAFuOScGbGz
         mgVYp+aVpTxDcbQwGq1byoNeIwNx9hOGmhnAe9QDHgnSHnV3TUixu0ZNC48b6hRIHVwH
         BhgD9Vr1XW+ZRP5B9/emUjW/Nqju9vWyQHtkO/5tAX1q9AzzfCyTCcvKFK1qgwb6e6gM
         F0Vw==
X-Forwarded-Encrypted: i=1; AKwUvBwtnSAX0BbH66vxLm9pjagE0hxmdYbgHirH+AZ5jxKugYCUcpeqLi/zppe4DrwozWyO3rfeU+U=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4QHuDOKW1vKUMc8H6H/aWQDmYhQcEin1dGDIn8IhEYvxfV/7+
	JaILE7DMFU/KX/cD1XFxqo4WOj6NRf/8Pa5LrdA40jXIkBUfmhgE3fzP+OhcfxyUsL0=
X-Gm-Gg: AYBFou34zkru/cpJO/mXWnrYLLt0FaE6E0j1ooPGd3plmJheJ5GSuipIDRucX5xAPOb
	QFe/vqDwhqqFcFYLww1XdDfvYdHtqPQGCiKGztsJy7VbDGiu5IrjRzMjtQxTggMYV3xjFHv/SGL
	7rNm42CdJipD7rb91or1i2YwWotBU05vwk+IsGpaRe2lvz1x5Bp/DFXQh3aKGOOTZqZh8nVWhdw
	Rr/jyPc7FYi4Q6o8RvfLN7NlFHB3Ua7vr5XZaYjkoH5pEtYR7sDwrvi3QSt5cP1Zsir/ocD9m00
	QFkNfnKqxf3ujyVTFUWPrXD3AEXN2wsbTCPHZ6M2w+gprbwpFXLZ3XwyhNiHtBPQGhhBWCP5UDp
	E2UNw3j3XXy9Gc1u7LThDrwrZ7iUWcx0IP+Sw8URBXOpddn96hny2JDWz2Bi3ctHG1GG2/8Suu+
	MaSpUdGRKkPZa/JZiQT7qvleFKOZmvCt/OEcFwxmYwKIjnBV9z/Vp9XEUuFMd83fGr/lcDH/sAN
	VvIa7Sd3zJGsSTDqU8lZOFjQZhxHLiIWDtJOs7LnS1or2CqZpzAsNzLmIj/aMTl6zQ/WPXmnPt7
	jomIVHFSBwclx/Gl4UlEwvtehPBs
X-Received: by 2002:a17:907:3ea0:b0:c3f:98d4:dfd0 with SMTP id a640c23a62f3a-c3f98d4e648mr377283866b.45.1792149645861;
        Fri, 16 Oct 2026 04:20:45 -0700 (PDT)
Received: from threadripper-fedora-workstation (dh207-15-194.xnet.hr. [88.207.15.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c408e32c075sm63947666b.11.2026.10.16.04.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 04:20:45 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lxu@maxlinear.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	michael@walle.cc,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: lrosu@maxlinear.com,
	luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH net-next v2 2/5] net: phy: mxl-gpy: add MxL86211C VDDP supply
Date: Fri, 16 Oct 2026 13:19:33 +0200
Message-ID: <20261016112033.949026-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016112033.949026-1-robert.marko@sartura.hr>
References: <20261016112033.949026-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Read the VDDP supply voltage and configure the MxL86211C MDIO, MDC,
and MDINT pads for the matching 1.8 V or 3.3 V level.

Keep the shared GPY driver buildable without regulator support; only
the MxL86211C probe requires the supply.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v2:
- Replace the MDIO regulator provider with a VDDP supply consumer.
- Set the pad voltage from the supply's reported voltage.
- Keep the shared driver buildable with CONFIG_REGULATOR=n.

 drivers/net/phy/mxl-gpy.c | 63 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 62 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
index 089a1a9e5bc61..fbac7c49b4759 100644
--- a/drivers/net/phy/mxl-gpy.c
+++ b/drivers/net/phy/mxl-gpy.c
@@ -14,6 +14,7 @@
 #include <linux/polynomial.h>
 #include <linux/property.h>
 #include <linux/netdevice.h>
+#include <linux/regulator/consumer.h>
 
 /* PHY ID */
 #define PHY_ID_GPYx15B_MASK	0xFFFFFFFC
@@ -110,6 +111,10 @@
 #define VSPEC1_SGMII_ANEN_ANRS	(VSPEC1_SGMII_CTRL_ANEN | \
 				 VSPEC1_SGMII_CTRL_ANRS)
 
+/* Packet Manager Control */
+#define VSPEC1_PM_CTRL		0x0c
+#define VSPEC1_PM_CTRL_MDIO_VOL	BIT(14)
+
 /* Temperature sensor */
 #define VSPEC1_TEMP_STA	0x0E
 #define VSPEC1_TEMP_STA_DATA	GENMASK(9, 0)
@@ -140,6 +145,7 @@ struct gpy_priv {
 	u8 fw_minor;
 	u32 wolopts;
 	u64 rx_errors;
+	struct regulator *vddp;
 
 	/* It takes 3 seconds to fully switch out of loopback mode before
 	 * it can safely re-enter loopback mode. Record the time when
@@ -390,6 +396,61 @@ static int gpy_probe(struct phy_device *phydev)
 	return 0;
 }
 
+static int mxl86211c_configure_mdio_voltage(struct phy_device *phydev,
+					    struct regulator *vddp)
+{
+	int voltage;
+	int val;
+
+	voltage = regulator_get_voltage(vddp);
+	if (voltage < 0)
+		return voltage;
+
+	switch (voltage) {
+	case 1800000:
+		val = VSPEC1_PM_CTRL_MDIO_VOL;
+		break;
+	case 3300000:
+		val = 0;
+		break;
+	default:
+		phydev_err(phydev, "unsupported VDDP voltage: %d\n", voltage);
+		return -EINVAL;
+	}
+
+	return phy_modify_mmd(phydev, MDIO_MMD_VEND1, VSPEC1_PM_CTRL,
+			      VSPEC1_PM_CTRL_MDIO_VOL, val);
+}
+
+static int mxl86211c_probe(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	struct gpy_priv *priv;
+	struct regulator *vddp;
+	int ret;
+
+	vddp = devm_regulator_get(dev, "vddp");
+	if (IS_ERR(vddp))
+		return dev_err_probe(dev, PTR_ERR(vddp),
+				     "failed to get VDDP supply\n");
+	if (!vddp)
+		return dev_err_probe(dev, -EOPNOTSUPP,
+				     "VDDP supply requires regulator support\n");
+
+	ret = mxl86211c_configure_mdio_voltage(phydev, vddp);
+	if (ret)
+		return ret;
+
+	ret = gpy_probe(phydev);
+	if (ret)
+		return ret;
+
+	priv = phydev->priv;
+	priv->vddp = vddp;
+
+	return 0;
+}
+
 static bool gpy_sgmii_need_reaneg(struct phy_device *phydev)
 {
 	struct gpy_priv *priv = phydev->priv;
@@ -1406,7 +1467,7 @@ static struct phy_driver gpy_drivers[] = {
 		.name		= "Maxlinear Ethernet MxL86211C",
 		.get_features	= genphy_c45_pma_read_abilities,
 		.config_init	= gpy21x_config_init,
-		.probe		= gpy_probe,
+		.probe		= mxl86211c_probe,
 		.inband_caps	= gpy_inband_caps,
 		.config_inband	= gpy_config_inband,
 		.suspend	= genphy_suspend,
-- 
2.56.0

