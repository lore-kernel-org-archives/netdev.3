Received: from mail-ed2-f23.google.com (mail-ed2-f23.google.com [74.125.228.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B7234C33FE
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 12:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790771002; cv=none; b=O0CFiiUZFhljeceTM/3vZFOIYfEAka39MljvBTxTDTEIOsl92ppYzU9wmxvXEYAAjg7OJoLJQbrs/+n4cJElx1Hkv1xvZ8GDJp0qB61WKSvoTEN5gI1S5RjEpdZYw2VUxEcEuZ8o42g1BFd8pg49S6vsCYy0AlNFk4H0ayp0REQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790771002; c=relaxed/simple;
	bh=h2pc95njxmsYby06YpERNka41uwl7Jil47IjfwsFRfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahQ9YinSeGDo4Uo8otXPFoCM2KlhLJGz+kwWWzjJJgGBHxtgT9VGoedZCmcjLnAQi6/8Zx5haRKccCrQLAolzBHzFhHI3umeKLfjkTOvjd6GgvI0VZalbYpGLs5p8B0wFN/4uJkZtmFiYhPNz/L4w7jE/Usgk72l6WGd3ZbmS90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=Ew7gGX2v; arc=none smtp.client-ip=74.125.228.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="Ew7gGX2v"
Received: by mail-ed2-f23.google.com with SMTP id 4fb4d7f45d1cf-6aaf8415866so7038450a12.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 05:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1790770998; x=1791375798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6xR7yUYPX+7seinAiFgxnQeT3HBczjiKMTueBlqUkDE=;
        b=Ew7gGX2vVJQrvTyv5J+H0O2GYW04FGDpo56KVcjUVe4E/Akj2mkaqubRUD9LxrZnI3
         M8EWNIXQzIFeg/R6h3zBpJY7Ag0WbvCzLybDT5SOVWFyeFMgA76/l4BpeGK+pVEQDB5L
         jKDjQFjHq/h/PNPVIX5Zb4i3IOkffXJF/gMAwJBnxVDNQCLzZ25dzMnT3E2gLGIOReqh
         oLIlu83eC/ZB52Q3J1W5k935qHvszFcHSIyABPaz6MLgoD1vdKl6TXg0jECgwyf2sUPa
         JZXjI6POG12BkpbkTk7dg/uAhZXF0QxaOfuFBap4qoRy6H2nA8WEshOqcik/y2XiHz7t
         X8wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790770998; x=1791375798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6xR7yUYPX+7seinAiFgxnQeT3HBczjiKMTueBlqUkDE=;
        b=cnbRBvRsd5jEzm3xCEoGQLX2T5kjlppgk+oxzQHRkmGhopCPkgBQs6B7pzz3zeJdDP
         bBeeKAB4ugHHzg1R3WBrDaNg7dICkadsHYKPxeLHdN/ThRlfUsX3DaKxUqUkIcTEafri
         od3+p+5q01EQobOtSdxm5w/7joRFZh0FwkA1UrEWU9BZbRsy4sbrudG3wITdK4GALUiQ
         HW37a2XlAfj+xMcXHGaj85kerDGO0OfOuHZ/euKk4A/+jRjJKX98iPkPoiTsrC3qXE6e
         6JYRKcDekUgV4YH41OxQ20Krj6chzQKn2X8/nTD/W1jZuvbHZpPiV/LbDzF/rrHtXHHL
         hwOA==
X-Forwarded-Encrypted: i=1; AKwUvBxkvvaKoQAMzJqnYnSoc3IfHdcRpc4mgE/1e98qZTIDCSHYtLA83drpNfFY2wB4xdYYKm/wEp0=@vger.kernel.org
X-Gm-Message-State: AFq9FYIhULBrdFBsOTvlMYMJdqfrNMVb3hu179Whncnp0MO3CSa5ll4P
	8GN+V4g9CMT1jorxc4kaiRMYXn/iYkgBqtBxgEsnnxzf+SrypTf07nfUB/R+GOg5Rh0=
X-Gm-Gg: AYBFou3kPVw0hIKu4RNteFsDgVAx2g7jahRqSnTf5U2zyUbIljtnZr13oHuUQzzig+q
	EezrCFmcLR/mEEai5nLzRZTTSP2In0Wo2o0O6P9JHJ5P4CXFR4+fu76RbBa6tXGYH0uNzI0WrWh
	MAVZU5STe8UH/Tclaat99rvJlvd4PMg8DCS4/d+udG3pU+E9XcTBknpi2TZew3h9KJHX0tuJtvf
	TB9Rbr2dsGwsIa4GofxEQnqHJKIb3CCJrl1kreHMjehoUk2REvqgZ9Qg1suqNy2mN49V9HutbJ7
	T62SxiG8+u/+moVvLfA7PTAOnt1JS1zHXNDc5Pi/Bn0kgV5Ky/93wsOfEuDTfLG2SD5/FjmYLP0
	18koGdwrqAtFzimhh/WNo2WF+YNyjSStsACVYTEuqGzZsH3vg+RICmFeEnck6yN07+UqJAuZ5sv
	ZDun880ZfNB7cQnI/m3WBP3bqA0moROsJ/iLjzPvhAKxiQVqw67mBzGl3jiSNuYwS/rTKj99ZdU
	I+WJAg1x+QSGhjsA7YDSfOlB9TPu7PQc6CzeOrzWOqVW8Maa8Y7LCPOqDrRHdGQf4lFPZfaMWcC
	UsCruE7E62HGkQ4brRVXh+tvL6GqtpLpVsA08V4=
X-Received: by 2002:a05:6402:401e:b0:6ac:86e8:315c with SMTP id 4fb4d7f45d1cf-6ae1992a14dmr1016775a12.7.1790770998038;
        Wed, 30 Sep 2026 05:23:18 -0700 (PDT)
Received: from threadripper-fedora-workstation (dh207-15-187.xnet.hr. [88.207.15.187])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ae1568e5a3sm744042a12.20.2026.09.30.05.23.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 05:23:17 -0700 (PDT)
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
Subject: [PATCH 5/5] net: phy: mxl-gpy: support MxL86211C lane mapping
Date: Wed, 30 Sep 2026 14:22:17 +0200
Message-ID: <20260930122305.293686-5-robert.marko@sartura.hr>
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

Configure the MxL86211C physical TPI lane to ASP mapping when it is
described in DTS.

MxL86211C supports per lane configuration.

Leave the hardware reset configuration untouched when the optional
property is absent.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 drivers/net/phy/mxl-gpy.c | 53 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
index 790075632fc3f..f716da0ffe890 100644
--- a/drivers/net/phy/mxl-gpy.c
+++ b/drivers/net/phy/mxl-gpy.c
@@ -117,6 +117,13 @@
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
@@ -440,6 +447,50 @@ static const struct regulator_desc mxl86211c_mdio_desc = {
 	.owner = THIS_MODULE,
 };
 
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
+	return phy_write_mmd(phydev, MDIO_MMD_VEND1, VSPEC1_LANE_ASP_MAP,
+			     val);
+}
+
+static int mxl86211c_config_init(struct phy_device *phydev)
+{
+	int ret;
+
+	ret = mxl86211c_configure_lane_asp_map(phydev);
+	if (ret)
+		return ret;
+
+	return gpy21x_config_init(phydev);
+}
+
 static int mxl86211c_probe(struct phy_device *phydev)
 {
 	struct device *dev = &phydev->mdio.dev;
@@ -1482,7 +1533,7 @@ static struct phy_driver gpy_drivers[] = {
 		PHY_ID_MATCH_MODEL(PHY_ID_MXL86211C),
 		.name		= "Maxlinear Ethernet MxL86211C",
 		.get_features	= genphy_c45_pma_read_abilities,
-		.config_init	= gpy21x_config_init,
+		.config_init	= mxl86211c_config_init,
 		.probe		= mxl86211c_probe,
 		.inband_caps	= gpy_inband_caps,
 		.config_inband	= gpy_config_inband,
-- 
2.55.0

