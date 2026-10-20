Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489034;
	b=qCfhSfnimd+y0TbrosCZXCA67kfwPxLuFNYy6QIWXF6/pvVsPDC6PtIQea9OKfqKkYGO
	 aCUYKQ1zrotKkZzKqadaM4XCWUo+uR5YRRwZgkXRRUKxu+axIDkd8wR8sw6IOX50ZaL3o
	 GM5EKmy6YFc2CI7UxMGQ1hxFTi8OCk+fLIWZeuxP0BeeuKlVJXQxWtoW+tYIcT3G5v2y5
	 Ca5scbdyBRoOKVlM1LhF8yoQw13YaggXv+plQtqBLhqV3yxJ+jjFDoaJiCWGfCjac9aWz
	 Jdqrt3yRxqUQ9Oy6Cq0uLKLgj1ZYOkc04A0se5SpWVyge1c0zLwsDdFzFv4REh2lm1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489034;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=N2Et6FhOSAKo3DWy4+Ueo5mIubBKDT9//pePGJ0VN7g=;
	b=Lm/umg///ad+3fJeLZwaXCpUIw9qrkNnqlTA2pfvxlL9Iqwc1cWue0fy/nOBHjZ4KU4U
	 LEUKMZDXvNL+LTH/i3mUFVVCuriLIGJ5ZR29K6Cckpn5fqbpoDG3yxP20fYqxpsHwsYQD
	 J3zdjcYNh4rG60N4Wzg5eQ2HwmLmlIRg7mu53pQfEGIrxAgLXPUvzaGZg3KFsxLcdFe4J
	 DpMn/Th/nCYhTgjqw7H7BCjouxDWdziCgRv25llNPiHUB2/Rkq6BvcSAcCgyp1FaNj7t0
	 wJOBFMR+RoRS/iWt7LQ9AIX89M6CraVXLei/YaJxiqr7i9AM7ljU2EFljno10Dbj6iA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sartura.hr;
	spf=pass smtp.mailfrom=sartura.hr;
	dkim=pass header.d=sartura.hr header.i=@sartura.hr header.a=rsa-sha256 header.s=sartura header.b=TW+HT7R+;
	arc=none smtp.remote-ip=209.85.218.50
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6480F60A3815
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 09:37:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6480F60A3815
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sartura.hr header.i=@sartura.hr header.a=rsa-sha256 header.s=sartura header.b=TW+HT7R+
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c445c95d553so229312766b.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 02:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1792489032; x=1793093832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N2Et6FhOSAKo3DWy4+Ueo5mIubBKDT9//pePGJ0VN7g=;
        b=TW+HT7R+qM7cFRyny5S8cDwqPmlT4Uy/idOozwPOQ2+ChYoRRRlkqnKvkC+3jJDtf0
         SpNuTxuDQRdJx3PSMTmdYVbYW8zisypHmjYUAtoUthNA84NcBfJUISbj/XUlwQswaQ1L
         TF768m67jp8robOaElgrMeX8XnxgW+c6sDB4+fVXGnDCW+GtjQpLS26tT5Oa2xhushng
         L8trduE8/3ajP5I5daEPkpXz7iwqbU/5MF+Gza8mUquT8S/lG2RIxWWUNxzCLh9+U5fc
         USj+fZB6LlgsHTJWHG5p+b+sJExP3gYMbCT0UwNGodc1pDXijic02nPPADgF1L8HU4hJ
         qrSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792489032; x=1793093832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N2Et6FhOSAKo3DWy4+Ueo5mIubBKDT9//pePGJ0VN7g=;
        b=qbsC7aDHkyWYYr2T67chHJSXR9mqEWJcUKLO6pRb9xfXqjUc/nJ4xpjKV4+n8/Z22Z
         x75BD3BEfq1SYDoJkpisxs4v+Yv1wsHk1Bt07JgReBoELvrhHlE8blb7IN21QMWIULQi
         mA4mv9R7wo3l8lL56h/T7nSN6/0BCXlf82zQMnVWKhnAVGaPyU7zKmACTtDeJxDFECsE
         kWJ0QlCi8oEkAbQ5zWCUo6qsFlO6OJE8aQcc044NJGRRZioR6jTc7ZKR2qRRzKHGKYLK
         uYz1E3mRSeeh1nL4xxHNEqX7gj9ECxRPbfIqpkFajIJKh0fuOKwB8xgtkqGCupPa5edY
         3geQ==
X-Forwarded-Encrypted: i=1; AKwUvBzSjMVi+GVlHBUBz/KUIoM6eEUMQwbjdbOcCablW3ZAdDezMBC5XnA4mnzfrIRBxpaYwvLymLY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJyrIIALf9ZvVduKHAPl2jnQytSr4rfXFZXiZjAMFiCGM3Cx9cR
	9eb2IARwd1XhOIQOeM5L6FxO9Z7lrvEiBzKxTpTIx0+FSC1vFF800JZgIsUie3Y5qv0=
X-Gm-Gg: AYBFou15I9S4VxdzbadQkAwIjttMIXCUdLc8rbFtvCfP0k+1Gcng2mB9d1/93f4Xa++
	ai9Nn1ksOSBGmBvO3HeZHlc/9TWQ9TCrVz7q+ImebeU75ltYKood2P4Su02fw4J3r0qoYk0seXd
	4/RyQoUQnmZUS8NK/XA1sMJCuG/osdURWpwaoljcJVf7gaFwpYb/WA2UbZa4avJ5SLPDmzugne1
	L30O03bZUBNqQRsv/lvvg7+thRf18gchih14+wmHXZwL16se+L+GHVIB6HGtMXcxyq9l5+WJxdl
	aRjyE6vcFcSMoVHwHsgIaqRwME46QB9qmTyS6ISvoSN4Vg4Y/jZ5svK6QeabX3OHWBVmvHf3Ek5
	qEkyFYHRXcbQHHomdcr9PT2/q+pX8ywNtSnaW9Bf8AUrPtewK27CbEqeAFNkmTpAY6xkE4Gdju8
	I7e738yPtUwZ9aYoLPT0eRNNPmhqSFYnuVKfDPr2lbzV8n8kPbfIlXMegjPYaT72s4L4Ouok99J
	SohK9suJxmeVL4XYzO6F2lAYTsazSUQTGtWJQ3VJ7wLjbHJugVuFTnH7FLG+qWtzL8+S755GUZg
	tFfV//Ntbwle9nPBgVjgIiNs4c1AWPpPnyH5FTgpwaNI9Q==
X-Received: by 2002:a17:907:94ca:b0:c45:c030:732a with SMTP id a640c23a62f3a-c45c0309ca1mr203260366b.35.1792489031683;
        Tue, 20 Oct 2026 02:37:11 -0700 (PDT)
Received: from threadripper-fedora-workstation (cpe-109-60-82-88.zg3.cable.xnet.hr. [109.60.82.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40912ceffesm462730966b.47.2026.10.20.02.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 02:37:11 -0700 (PDT)
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
	Robert Marko <robert.marko@sartura.hr>,
	Andrew Lunn <andrew@lunn.ch>
Subject: [PATCH net-next v3 5/5] net: phy: mxl-gpy: support MxL86211C lane mapping
Date: Tue, 20 Oct 2026 11:35:38 +0200
Message-ID: <20261020093655.344585-5-robert.marko@sartura.hr>
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

Configure the MxL86211C mapping from physical TPI lanes to analog
front ends (ASPs) when specified in DTS.

Leave the hardware reset mapping untouched when the optional property
is absent.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
Changes in v3:
- Reject an incorrectly sized lane map before reading its values.

Changes in v2:
- Preserve unrelated register bits when updating the lane map.

 drivers/net/phy/mxl-gpy.c | 53 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
index dba0777158b2d..b71ed2bef3e5d 100644
--- a/drivers/net/phy/mxl-gpy.c
+++ b/drivers/net/phy/mxl-gpy.c
@@ -116,6 +116,13 @@
 #define VSPEC1_PM_CTRL_MDIO_VOL	BIT(14)
 #define VSPEC1_PM_CTRL_SI	BIT(12)		/* Super Isolate */
 
+/* TPI lane to ASP map */
+#define VSPEC1_LANE_ASP_MAP	0x14
+#define VSPEC1_LANE_ASP_MAP_A	GENMASK(1, 0)
+#define VSPEC1_LANE_ASP_MAP_B	GENMASK(3, 2)
+#define VSPEC1_LANE_ASP_MAP_C	GENMASK(5, 4)
+#define VSPEC1_LANE_ASP_MAP_D	GENMASK(7, 6)
+
 /* Temperature sensor */
 #define VSPEC1_TEMP_STA	0x0E
 #define VSPEC1_TEMP_STA_DATA	GENMASK(9, 0)
@@ -434,6 +441,48 @@ static int mxl86211c_release_super_isolate(struct phy_device *phydev)
 			      VSPEC1_PM_CTRL_SI, 0);
 }
 
+static int mxl86211c_configure_lane_asp_map(struct phy_device *phydev)
+{
+	struct device *dev = &phydev->mdio.dev;
+	u32 lane_asp_map[4];
+	u16 val;
+	unsigned int seen = 0;
+	int i, ret;
+
+	if (!device_property_present(dev, "maxlinear,lane-asp-map"))
+		return 0;
+
+	ret = device_property_count_u32(dev, "maxlinear,lane-asp-map");
+	if (ret < 0)
+		return ret;
+	if (ret != ARRAY_SIZE(lane_asp_map))
+		return -EINVAL;
+
+	ret = device_property_read_u32_array(dev, "maxlinear,lane-asp-map",
+					     lane_asp_map,
+					     ARRAY_SIZE(lane_asp_map));
+	if (ret)
+		return ret;
+
+	for (i = 0; i < ARRAY_SIZE(lane_asp_map); i++) {
+		if (lane_asp_map[i] > 3 || seen & BIT(lane_asp_map[i]))
+			return -EINVAL;
+
+		seen |= BIT(lane_asp_map[i]);
+	}
+
+	val = FIELD_PREP(VSPEC1_LANE_ASP_MAP_A, lane_asp_map[0]) |
+	      FIELD_PREP(VSPEC1_LANE_ASP_MAP_B, lane_asp_map[1]) |
+	      FIELD_PREP(VSPEC1_LANE_ASP_MAP_C, lane_asp_map[2]) |
+	      FIELD_PREP(VSPEC1_LANE_ASP_MAP_D, lane_asp_map[3]);
+
+	return phy_modify_mmd(phydev, MDIO_MMD_VEND1, VSPEC1_LANE_ASP_MAP,
+			      VSPEC1_LANE_ASP_MAP_A |
+			      VSPEC1_LANE_ASP_MAP_B |
+			      VSPEC1_LANE_ASP_MAP_C |
+			      VSPEC1_LANE_ASP_MAP_D, val);
+}
+
 static int mxl86211c_config_init(struct phy_device *phydev)
 {
 	struct gpy_priv *priv = phydev->priv;
@@ -445,6 +494,10 @@ static int mxl86211c_config_init(struct phy_device *phydev)
 			return ret;
 	}
 
+	ret = mxl86211c_configure_lane_asp_map(phydev);
+	if (ret)
+		return ret;
+
 	ret = mxl86211c_release_super_isolate(phydev);
 	if (ret)
 		return ret;
-- 
2.56.0

