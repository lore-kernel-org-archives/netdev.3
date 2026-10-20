Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489030;
	b=eavb+uFcRG4MXpDt8LXhaVqUSE7DiN8XrPKnnhZOvq53dCjOMXDRy2B+5dXdyiDPf/a9
	 3kKe4WtOontRaz8NzMVMcTm10yQSWAsA+4KsAALU8sVRRByDJeo0JjpZygAYBOzqQkHMz
	 3OJq/0y3aBps2pX/uekFerv+6ZSK+9Z9w+V0nVGoFEcmC97ecYPOwPZpI8JyiPQdfFkvr
	 LVguDqrcBYMU+DgjXCdM8Zyp1l8TaX4zzyDh1z5fP9ZuMEfJmC08vtrqJOKsDVIvgORvz
	 0Lj7Xtcx90MYX/+J6l4EdCtxt7hpFwWkAaXaz+VhcmSDRwmXOoHMGuR2UN4G39J+MlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489030;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=c/EvouAW0V5R4zFLy9Lu8wnQKQA3529GT4K1GXLtm4Q=;
	b=pCmnwjniHp4K9j9cC9XaAadztmbY3kKy+cdrcJULeTL7B3pzyQ5EEA0poRX10AcQ/GYi
	 bcR9V2+uBPyTq9QL8j9hyJNi5W7QdQfyeaf/O1jk0DTG7ygXoA9ehcQUMs7cqOElKU+kL
	 NB2VvrZZ/FWRYyDvSBK8jPSUAfCnaAC6H1O3o81pi+aPLkwUYimDIdLznEV7IP81KcyvK
	 k+uLBhht7wopGjAtUj6ohCAherlycgnRfR9s16oXMtmNZvZxrrh5eVgMRhgoQY733p61R
	 JK5C3G5Ajf478WmBYN1AOT01E7JrMRT15bWAfYPctU2apy2L6WG8lEQ8+tLdtbLt3rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sartura.hr;
	spf=pass smtp.mailfrom=sartura.hr;
	dkim=pass header.d=sartura.hr header.i=@sartura.hr header.a=rsa-sha256 header.s=sartura header.b=QSeKkiVn;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894B9606A323
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 09:37:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 894B9606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sartura.hr header.i=@sartura.hr header.a=rsa-sha256 header.s=sartura header.b=QSeKkiVn
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b170129413so4766834a12.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 02:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1792489028; x=1793093828; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c/EvouAW0V5R4zFLy9Lu8wnQKQA3529GT4K1GXLtm4Q=;
        b=QSeKkiVn5Ds8fYK/d7LUyo+2DlSpUAxyxdMRLYSbICXp5vjfBDaU67mD1Bf+XEroiV
         v+G5o46gyUkiE2l4pqD45imP+Hbentk6hnewjx3Agh+gJFp0K/Ce2t95h8Jgn+zrTwLT
         AUU6e51VdhI5OS+fPYjVhsltkS/LH7HphcNT4QEll4OjpfoIcfCu1qb0fO0R1LVsmAuJ
         PxFGnH3Jv0kmj8zUCMnZqkRB8+7A1wZgfb1O9EcyYBdg8S6KKTFGMTc71BBOrV/M29xU
         1USGehKVpBbethJlTTWxn3uozoP0EC1eDcguNlD+X9FcpUeO4NuFLBSCSYFmX9w2hzRn
         ynFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792489028; x=1793093828;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=c/EvouAW0V5R4zFLy9Lu8wnQKQA3529GT4K1GXLtm4Q=;
        b=EVK0473Hiiy3pbBehxZWZHZUppkOe+fgFGkUnyxhGA6JfjoHFvHW333g7yRMU2Q0Dd
         iHca23A6qpUP9UAkanvXHdb4jh0CDTmo1iKtqHpMcrUuCT+uizmjWZKslMuMNagBvcRY
         1iWQ8V/YKFvoP87W2qAfDxTjqFlpU+9owqIElyMZ5Ox6+8asJdBekZXFUmOZaDPp5fZ0
         zAU6Z9WqhACzBmShzPfyeFSAgR1L9JKEmdRtoMFpPYJ6CUq72UXc7B6BEl4nMF7RJWr/
         7Vufd70oztsqCq+9t9ymWQU+kI/DPdjpEpdXw0LzyHJhgX/+MRRzZA/3WUfFllhp6FVc
         3osA==
X-Forwarded-Encrypted: i=1; AKwUvBzBnX3kFXB9AR/Opdz54ENRswoeD37fqdU0HSlAx6LMK/X8L4Cc+abNCfI25LQiWRoCoOXEf7M=@vger.kernel.org
X-Gm-Message-State: AFq9FYJMgYNpuUhwlqn+wSY8fEVZhryNwiDMA4M097cfHGmmGOsJgdxz
	0ockz1ddw+zdmQfTqGKN0drCe4pkRzmj5/sIev23xbhiq8lSPT7JbMpLT3QZImbvnNA=
X-Gm-Gg: AYBFou1FjOX6E9m17kumw0B8YbsKpG63vIajGB5Dd2Sj8DeH+vqJoBgbfmrOFWlNUw/
	Vnl56vKGBV9+PC+5FBH3YMQoMIjyq9V70Wqs2I0zvP09PRoVTyiQmT6s1XRx9DHFcVnt2czzJ7X
	tjYAKmUmnfJjh6LAAbxjcXSMGhBXRpIqqJc0TsIf7n+39qfwl89KYfGv8YVcGz/rXY1+JZdifFw
	Td26K7ZGiw8Y0TMHhYJ9kWudSOiy/Tv41SQ0KNUMWhNTmX11oRD8/5Q1BpIr7keBr3lBfiFamGH
	0h2KlfpjAESAgCiIcLTMyCKjyEHozK/NqvWl4AHr2u2OCXG4gBXcGAfrf1zlsx1EhECUly75sCO
	/C5Zu75sMVtAJcV8SF+ulh6uCfGoh0tY7jMNAmZhRpF0Lya7KnyrWcdc5NvpFOWYlkX9w97UZRa
	AHPCtrv+WkdnaXujM2JyQ8Xt4RN8gd1F1DX8Jirm4nq5tnJsqAWMFiPkp8+hT3U6uWKaIu2nVYL
	1FfS9LuZdDq/mK4CBYFYbP9KKt86CfYv1um6wD1JfmX0YYL0do3bzwx6j5PIPnBl8lrNumo90FI
	uic0FtVnS0KN3LBqJwjXzhR0FCUcvmo9Irf5hlgR+0CpKw==
X-Received: by 2002:a17:907:9347:b0:c29:63f2:99bb with SMTP id a640c23a62f3a-c41a10c2ddemr757773066b.47.1792489027595;
        Tue, 20 Oct 2026 02:37:07 -0700 (PDT)
Received: from threadripper-fedora-workstation (cpe-109-60-82-88.zg3.cable.xnet.hr. [109.60.82.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40912ceffesm462730966b.47.2026.10.20.02.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 02:37:07 -0700 (PDT)
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
	lgirdwood@gmail.com,
	broonie@kernel.org,
	michael@walle.cc,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: lrosu@maxlinear.com,
	luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH net-next v3 2/5] net: phy: mxl-gpy: add MxL86211C VDDP supply
Date: Tue, 20 Oct 2026 11:35:35 +0200
Message-ID: <20261020093655.344585-2-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020093655.344585-1-robert.marko@sartura.hr>
References: <20261020093655.344585-1-robert.marko@sartura.hr>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Optionally read the VDDP supply voltage and configure the MxL86211C
MDIO, MDC, and MDINT pads for the matching 1.8 V or 3.3 V level.

Enable an explicitly provided VDDP regulator for the PHY lifetime. Existing
device trees do not describe the supply, so preserve the hardware reset
default when it is absent.

Keep the shared GPY driver buildable without regulator support.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v3:
- Make the VDDP supply optional for existing device trees.
- Enable an explicitly provided regulator for the PHY lifetime.
- Keep the hardware reset default when no supply is described.

Changes in v2:
- Replace the MDIO regulator provider with a VDDP supply consumer.
- Set the pad voltage from the supply's reported voltage.
- Keep the shared driver buildable with CONFIG_REGULATOR=n.

 drivers/net/phy/mxl-gpy.c | 78 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 77 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
index 089a1a9e5bc61..952272faac1e8 100644
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
@@ -390,6 +396,76 @@ static int gpy_probe(struct phy_device *phydev)
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
+static void mxl86211c_disable_vddp(void *data)
+{
+	regulator_disable(data);
+}
+
+static int mxl86211c_probe(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	struct gpy_priv *priv;
+	struct regulator *vddp;
+	int ret;
+
+	vddp = devm_regulator_get_optional(dev, "vddp");
+	if (PTR_ERR_OR_ZERO(vddp) == -ENODEV)
+		vddp = NULL;
+	else if (IS_ERR(vddp))
+		return dev_err_probe(dev, PTR_ERR(vddp),
+				     "failed to get VDDP supply\n");
+
+	if (vddp) {
+		ret = regulator_enable(vddp);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to enable VDDP supply\n");
+
+		ret = devm_add_action_or_reset(dev, mxl86211c_disable_vddp, vddp);
+		if (ret)
+			return ret;
+
+		ret = mxl86211c_configure_mdio_voltage(phydev, vddp);
+		if (ret)
+			return ret;
+	}
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
@@ -1406,7 +1482,7 @@ static struct phy_driver gpy_drivers[] = {
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

