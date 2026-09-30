Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00AE94CDDE5
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 12:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790770997; cv=none; b=KsEx3XxHfq/wWFV+AgwnbNwXT0jHNM9EEEnqEM+B7tWaKLZC3SD7LQJ51PEUUXqGIrtblKfHJhdHeZxtixLITC2O/2x4uXyu6uSg1EfzVw3YDe8uWF6HK6OJb3BZEf2FytiTGclnknyh+o+8+tyNDgg5aftfAlYgzTFGR9nBwZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790770997; c=relaxed/simple;
	bh=lCAO3m7pPWSlsGO1CEHjSeQTi5D8RumJXFsrJ/RkN7Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BPn7lIP9ub+/nL3sLTKtDs/g1xvk7dwyuBHbP95QvECNP0jg0bY2eAyQo1nnUrYdUiwrj2xBaDMHlSZueTkbh0kHckle7eyZDSOd8yRLgsER65mH+hdIGQWmgWq0MVDy3PHm/xSyA6c4p9SfrI3W/zZHWM9n/oh6RLDXwx0orSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=NgP/vIBR; arc=none smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="NgP/vIBR"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6a6056ac81fso7940351a12.2
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 05:23:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1790770994; x=1791375794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NXwcYZBPUfY9xt/E1IEm9kp87hTQAPeWDQTTI+zufpw=;
        b=NgP/vIBRyLXcZ+JWBADihUwC5RHo3snEWv3FBNaFA2swEC3LDKTD9MQZI1pub/74rM
         6iko5Ux9W7wtEBVXOLZUh9s9xjl/VXzlNygtgal3Zgh9lWWe9/0Qw4q9FUBxTdnPyTmb
         On/EGStwvj5JPdwxprJYPWa125lhP8jzfSQxTjsCDNcR3FaaYta8o5Mphxv2ZM3NDOlM
         TSObSHK16k5WW/0+a/hrTZFFtyTNc/28s6X5sB6W21OqyH8fBMzENqBFF0FqOHYELyEm
         /RrCXI4HZhuOaCdsmwNtSfPQMf6GR0PyI5P/M7EXcefTqOjORFr1zoHVnQQIPWXbEiEA
         /7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790770994; x=1791375794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NXwcYZBPUfY9xt/E1IEm9kp87hTQAPeWDQTTI+zufpw=;
        b=FD7hZm9AB1086J3a1+JLtZUUpxTnGarJADo92s+1m5ROzJj2zsVAyQOUOC5an4VlIE
         k2qJskyG+g3FQEdu4M5CKB9bEx7ugaShu5r9dnFMJSZ2CM/PXIAYraHHX290XGCE4FWl
         /ybkMBu5rKiaBGrwO3lSCxcnuUF0U+6ErGeNTh0mMtCkA/AJ94E2UWgoB90MxM3/ZeTx
         2Vw8NMs3JeVlQUzflKoPA+gWq1focexkg+IzNKB2dtQowveEtKzt67vx/tNmrwPpuEX3
         RUZd5UkBfSTMyH1aAbUAdqlOoqv6dLfo4yvXCfKVckG941FI1W5c/f9t99asJaDKhCNy
         9vwg==
X-Forwarded-Encrypted: i=1; AKwUvByRFpPAtseRIEP4aQgFRO+xEEaxtpGg7nR4SDxIsYi2Ip5f9VQWylEOqvMF5Fo23fnjcon7d8E=@vger.kernel.org
X-Gm-Message-State: AFq9FYIr1nbabNata5fqd8FNuKVwyFNcJqeTP5ZqrP/HMPXQWgM4hBbq
	Fg/Fs6hGxHr9hUflVfTe1g+TLO9vC78EL3vOiFydxhY0oqZ0SAIdZuWYIsET8hSwz/o=
X-Gm-Gg: AYBFou2OpeYgv6LSNDFc4l4HUCIKWbjwZ1y8BWOHzzz4xmHlv6yCaoHFPEM7nnkNG0x
	pJJvTC+3RlF48PGL9K+p5PMBHTzxt/z1kcHQbcNkrxV0ucqIxmYTMwjfjVSLEaU+wZSCpj6K1U6
	VhPS3kfsLYevQdHsEBQRGVnDdcJiOl7Kx2pIwFVPjcYS4g+61/Vz+mgnNPZNMlZBAmHoFdSx2A0
	Atyewe9TnXlXEsC8gU2P9Toa5gslF0DeP2qXt96rcRyPd0APViiIixITIio52veefZ1gfiWlsG6
	1uJGPrni074YgsU6sGjc7hPYtKH0ZH1Nb5rCIs0B1UG+ga49BIgywaxohbhnW5xW32fsd81OS9d
	AJDJTa++xUvVcVOfxjXsyWCZYqPHL640cRIQNmKxjumau7P9Js4P5nfDMsCgxWgrZzygbEoeLRO
	aIjQnKWrFxCwG+dPp40hjxZJwmh9W6IiUyOTQ+CrmSHtthzS2zYPdjjK6r/M59b1idSYVhqE4Lx
	wV3Ro7DgBsd1pLuZNaJCq4yQQzDM5Kk6n/ZK/1sPhBeQoN+nN9BEMZBJQ9+jbscAZkA5o1JX+eK
	qi4K+kX1lLO5wdi09rhi1u5NNvr0dwGWdwlOAxo8vWhEYRU+HQ==
X-Received: by 2002:a05:6402:5507:b0:6aa:9fd4:35fb with SMTP id 4fb4d7f45d1cf-6ae198f5504mr859863a12.8.1790770994020;
        Wed, 30 Sep 2026 05:23:14 -0700 (PDT)
Received: from threadripper-fedora-workstation (dh207-15-187.xnet.hr. [88.207.15.187])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ae1568e5a3sm744042a12.20.2026.09.30.05.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 05:23:13 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	hkallweit1@gmail.com,
	lxu@maxlinear.com,
	michael@walle.cc,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 2/5] net: phy: mxl-gpy: add MxL86211C MDIO I/O regulator
Date: Wed, 30 Sep 2026 14:22:14 +0200
Message-ID: <20260930122305.293686-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260930122305.293686-1-robert.marko@sartura.hr>
References: <20260930122305.293686-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MxL86211C can configure its MDIO, MDC, and MDINT pads for
1.8 V or 3.3 V signaling through VSPEC1_PM_CTRL.MDIO_VOL.

MxL86211C is a bit weird in the sense that it power the MDIO pins via
the VDPP pad, so you must provide it with 1.8V or 3.3V there.

However, it does not automatically configure the VSPEC1_PM_CTRL.MDIO_VOL
bit and defaults to 3.3V, so if you are using 1.8V in order to have
reliable MDIO communication you must set that bit.

So, model the MDIO I/O voltage setting as a regulator.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/net/phy/Kconfig   |  1 +
 drivers/net/phy/mxl-gpy.c | 74 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/Kconfig b/drivers/net/phy/Kconfig
index d3835597e3795..bdaee0cb4829d 100644
--- a/drivers/net/phy/Kconfig
+++ b/drivers/net/phy/Kconfig
@@ -302,6 +302,7 @@ config MAXLINEAR_GPHY
 	tristate "Maxlinear Ethernet PHYs"
 	select POLYNOMIAL if HWMON
 	depends on HWMON || HWMON=n
+	depends on REGULATOR
 	help
 	  Support for the Maxlinear GPY115, GPY211, GPY212, GPY215,
 	  GPY241, GPY245 PHYs.
diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
index 089a1a9e5bc61..4cbbfae046317 100644
--- a/drivers/net/phy/mxl-gpy.c
+++ b/drivers/net/phy/mxl-gpy.c
@@ -14,6 +14,8 @@
 #include <linux/polynomial.h>
 #include <linux/property.h>
 #include <linux/netdevice.h>
+#include <linux/regulator/driver.h>
+#include <linux/of.h>
 
 /* PHY ID */
 #define PHY_ID_GPYx15B_MASK	0xFFFFFFFC
@@ -110,6 +112,10 @@
 #define VSPEC1_SGMII_ANEN_ANRS	(VSPEC1_SGMII_CTRL_ANEN | \
 				 VSPEC1_SGMII_CTRL_ANRS)
 
+/* Packet Manager Control */
+#define VSPEC1_PM_CTRL		0x0c
+#define VSPEC1_PM_CTRL_MDIO_VOL	BIT(14)
+
 /* Temperature sensor */
 #define VSPEC1_TEMP_STA	0x0E
 #define VSPEC1_TEMP_STA_DATA	GENMASK(9, 0)
@@ -390,6 +396,72 @@ static int gpy_probe(struct phy_device *phydev)
 	return 0;
 }
 
+static int mxl86211c_mdio_reg_set_voltage_sel(struct regulator_dev *rdev,
+					      unsigned int selector)
+{
+	struct phy_device *phydev = rdev_get_drvdata(rdev);
+
+	return phy_modify_mmd(phydev, MDIO_MMD_VEND1, VSPEC1_PM_CTRL,
+			      VSPEC1_PM_CTRL_MDIO_VOL,
+			      selector ? 0 : VSPEC1_PM_CTRL_MDIO_VOL);
+}
+
+static int mxl86211c_mdio_reg_get_voltage_sel(struct regulator_dev *rdev)
+{
+	struct phy_device *phydev = rdev_get_drvdata(rdev);
+	int val;
+
+	val = phy_read_mmd(phydev, MDIO_MMD_VEND1, VSPEC1_PM_CTRL);
+	if (val < 0)
+		return val;
+
+	return (val & VSPEC1_PM_CTRL_MDIO_VOL) ? 0 : 1;
+}
+
+static const struct regulator_ops mxl86211c_mdio_regulator_ops = {
+	.list_voltage = regulator_list_voltage_table,
+	.set_voltage_sel = mxl86211c_mdio_reg_set_voltage_sel,
+	.get_voltage_sel = mxl86211c_mdio_reg_get_voltage_sel,
+};
+
+static const unsigned int mxl86211c_mdio_voltage_table[] = {
+	1800000,
+	3300000,
+};
+
+static const struct regulator_desc mxl86211c_mdio_desc = {
+	.name = "mdio",
+	.of_match = of_match_ptr("mdio-regulator"),
+	.n_voltages = ARRAY_SIZE(mxl86211c_mdio_voltage_table),
+	.volt_table = mxl86211c_mdio_voltage_table,
+	.ops = &mxl86211c_mdio_regulator_ops,
+	.type = REGULATOR_VOLTAGE,
+	.owner = THIS_MODULE,
+};
+
+static int mxl86211c_probe(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	struct regulator_config config = { };
+	struct regulator_dev *rdev;
+	int ret;
+
+	ret = gpy_probe(phydev);
+	if (ret)
+		return ret;
+
+	config.dev = dev;
+	config.driver_data = phydev;
+
+	rdev = devm_regulator_register(dev, &mxl86211c_mdio_desc, &config);
+	if (IS_ERR(rdev)) {
+		phydev_err(phydev, "failed to register MDIO regulator\n");
+		return PTR_ERR(rdev);
+	}
+
+	return 0;
+}
+
 static bool gpy_sgmii_need_reaneg(struct phy_device *phydev)
 {
 	struct gpy_priv *priv = phydev->priv;
@@ -1406,7 +1478,7 @@ static struct phy_driver gpy_drivers[] = {
 		.name		= "Maxlinear Ethernet MxL86211C",
 		.get_features	= genphy_c45_pma_read_abilities,
 		.config_init	= gpy21x_config_init,
-		.probe		= gpy_probe,
+		.probe		= mxl86211c_probe,
 		.inband_caps	= gpy_inband_caps,
 		.config_inband	= gpy_config_inband,
 		.suspend	= genphy_suspend,
-- 
2.55.0

