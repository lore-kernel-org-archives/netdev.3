Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3023D37A848
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 02:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790130009; cv=none; b=uHhlc2NfcexN4MbVcU+ilLe9uYqjWg5w8+hiHeA+7H4OAH1ChBvtYsK/4XIQrbnhy0i3uSjKQ3ug3liKye3FekuwqUEJkxIHv+JYjOQEpPW+V5iy5n4sPRPBJ5qMjJdxXMQvh3jH0Avt2+DBwtz8kNHYdt57hsZTM/J+A/9VjnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790130009; c=relaxed/simple;
	bh=fHT9kFUml1egySFJHRb80oN/JQKRCyXbPlu5X7ql9xo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qg7LivMBB4T7yUK+9v/jbhQqjJbfi/7NPAM6IgYeLCJr96M0a4oDfBzLyprgkIh/SrEEa9aH4Zvu1+EyoW1aXEZnqTJ+xbvTW21hngOuUrP4q9TvRqrUVnMfofeWBzsP/Rl/pQb18IjTu/Xnkgyau4CdybmxTRDUYvsKCY5/qEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oHvJHDo5; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oHvJHDo5"
Received: by mail-pz2-f41.google.com with SMTP id d2e1a72fcca58-85469b35611so246057b3a.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 19:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790130006; x=1790734806; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XVqUem5OVBG5DkuvgHi/WRrI10vrvDI5gxlD5SrAEXc=;
        b=oHvJHDo5nSjVHy90cni0+QmaEHizqL8oYg7lfikFh9lX1Un2EMQgM1MEMU8j8Rp5WJ
         60QJ7lytCxu1SZ4lx9Uoy7t9ssa8CjSvEE/DnTtOM3sY7/0K4U2Eyr472kdAFwfEiSgV
         RwQZVHIcRjOsfUzPkg3kB7F/gI99Pw4GHZvDnEIHKTQO16biOEdG+nml1woeYzguJe5s
         h39X2BehdJ4uyOka/3QPz7QWT9GqGENHZHqNsIsF8AGP+dubg6Uj7eKNLdVabRcNmiid
         mbfx9yrPPvtIUW9cBjRNsIXw6dkckkv5bTfXqWQ/3cE36Ohd6JEsudSil7tKE2GJcmf7
         dVrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790130006; x=1790734806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XVqUem5OVBG5DkuvgHi/WRrI10vrvDI5gxlD5SrAEXc=;
        b=FOtSIlL8d9ycHTvxs6e1p3pk8pFrgMBTIaEtfGfnkSeobCM0YwfZgpM5q2B3ZYG7Or
         YG6DiWLvB4rnGmK5ifXQsUSLuskVp0aC1qCrpYJhXqy0PG3a8679wXPqjecSkX2L1Ucx
         Vdiupvc++sOKOJ3hZL2KDH7Wb3qEV00HWst+RqzDoRSe0zGIO2I+ID62qyxzdIOVPLqq
         NpVcmEGfuAXFjPQB8GBYCV8UBaVV8nSkjv6l9aEnlXpPZWRMa0MIKhuIoSSJ14rUwGic
         OH8VFQhRbbIKxRtiJVGcWb/1kW/zB2sXpmkDbgFVouPulLPaeM0/vxyu461X9B5aSl58
         K/vQ==
X-Gm-Message-State: AFuF++mwDIwLOgJmTcbPMHDfdYQEJ5ffcrzc5o9RxQ6vqK+pSHrB0w/W
	Bm0oDcLnq9DRtxEYIlanJig1jNUVj/bs9f/ugfRtS+P4CyopobGqrnAluvGlTw==
X-Gm-Gg: AYBFou3bnZPUHpgfGgmVbCKtF3mBKPPE5yOFe/CudNAlnxU7BRD7SKXIgIZYMxl5ogG
	vlBMscJmW1uZEKtV3YSFOMANxD72aApbnXxbzj8PSx9IRBb1D8Lz6BXKRWioxGKfowShDLh4THx
	UTlOiPeKgW/bFSImY8BYyZVZusrwm6Jad6YwDCcMBFR7OdAX4h+t7V4nd1knX5QeNcpyKWKqUv1
	GCWvoYZW7i3j9R/GIhzzgW/FOq8uPocygqfnL2M8BLfbja7ol9H+QGfrhuMALyEYjs3CCpISLUg
	sb6o0/xoo4as2ofuYNIT5UmD/I8fKAEGeMgFeRYrpDguFHsfQtd8YLS/DVwtq0Li6oQ1PLyzqPr
	EqHme5eXs1vY2WCr4pmSL+KEzR0jSsehf5POR24ROpJywyewwtmW6Po0XbsO2dYn5MWaKSDrdMD
	iRmqIAIgp0rS84txPMl6dVUcLspRSued5oykhU2IwirAC10tbfvlaYCje8w+SMFgOTVBYNIJdLz
	+Gr2WInFYzKVP/NrxWipriFQrTWBmw8VrI=
X-Received: by 2002:a05:6a00:9512:b0:878:6ee:671c with SMTP id d2e1a72fcca58-87d1c9bcb2amr1188716b3a.30.1790130006145;
        Tue, 22 Sep 2026 19:20:06 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76c0:d30::4d0:61])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-87d1e0f4fe8sm502924b3a.51.2026.09.22.19.20.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 19:20:05 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 2/8] net: dsa: motorcomm: Split xMII and SERDES port masks
Date: Wed, 23 Sep 2026 10:19:34 +0800
Message-ID: <20260923021945.2203368-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260923021945.2203368-1-mmyangfl@gmail.com>
References: <20260923021945.2203368-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace external_mask with xmii_mask and serdes_mask, and advertise the
interface modes it actually supports.

Also move struct yt921x_info into chip.h for future use.

Signed-off-by: David Yang <mmyangfl@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/motorcomm/chip.c | 39 ++++++++++++--------------------
 drivers/net/dsa/motorcomm/chip.h | 13 +++++++++++
 2 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 825e0bfcff86..54881856b796 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -96,53 +96,48 @@ static const struct yt921x_mib_desc yt921x_mib_descs[] = {
 	MIB_DESC(1, YT921X_MIB_DATA_TX_OAM, "TxOAM"),
 };
 
-struct yt921x_info {
-	const char *name;
-	u16 major;
-	/* Unknown, seems to be plain enumeration */
-	u8 mode;
-	u8 extmode;
-	/* Ports with integral GbE PHYs, not including MCU Port 10 */
-	u16 internal_mask;
-	/* TODO: see comments in yt921x_dsa_phylink_get_caps() */
-	u16 external_mask;
-};
-
 static const struct yt921x_info yt921x_infos[] = {
 	{
 		"YT9215SC", YT9215_MAJOR, 1, 0,
 		GENMASK(4, 0),
+		BIT(9),
 		BIT(8) | BIT(9),
 	},
 	{
 		"YT9215S", YT9215_MAJOR, 2, 0,
 		GENMASK(4, 0),
-		BIT(8) | BIT(9),
+		BIT(9),
+		BIT(8),
 	},
 	{
 		"YT9215RB", YT9215_MAJOR, 3, 0,
 		GENMASK(4, 0),
 		BIT(8) | BIT(9),
+		0,
 	},
 	{
 		"YT9214NB", YT9215_MAJOR, 3, 2,
 		BIT(1) | BIT(3),
-		BIT(8) | BIT(9),
+		BIT(9),
+		BIT(8),
 	},
 	{
 		"YT9213NB", YT9215_MAJOR, 3, 3,
 		BIT(1) | BIT(3),
 		BIT(9),
+		BIT(9),
 	},
 	{
 		"YT9218N", YT9218_MAJOR, 0, 0,
 		GENMASK(7, 0),
 		0,
+		0,
 	},
 	{
 		"YT9218MB", YT9218_MAJOR, 1, 0,
 		GENMASK(7, 0),
 		BIT(8) | BIT(9),
+		BIT(8) | BIT(9),
 	},
 	{}
 };
@@ -4021,15 +4016,10 @@ yt921x_dsa_phylink_get_caps(struct dsa_switch *ds, int port,
 		 */
 		__set_bit(PHY_INTERFACE_MODE_INTERNAL,
 			  config->supported_interfaces);
-	} else if (info->external_mask & BIT(port)) {
-		/* TODO: external ports may support SERDES only, XMII only, or
-		 * SERDES + XMII depending on the chip. However, we can't get
-		 * the accurate config table due to lack of document, thus
-		 * we simply declare SERDES + XMII and rely on the correctness
-		 * of devicetree for now.
-		 */
+		return;
+	}
 
-		/* SERDES */
+	if (BIT(port) & info->serdes_mask) {
 		__set_bit(PHY_INTERFACE_MODE_SGMII,
 			  config->supported_interfaces);
 		/* REVSGMII (SGMII in PHY role) should go here, once
@@ -4042,9 +4032,8 @@ yt921x_dsa_phylink_get_caps(struct dsa_switch *ds, int port,
 		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
 			  config->supported_interfaces);
 		config->mac_capabilities |= MAC_2500FD;
-
-		/* XMII */
-
+	}
+	if (BIT(port) & info->xmii_mask) {
 		/* Not tested. To add support for XMII:
 		 *   - Add proper interface modes below
 		 *   - Handle them in yt921x_port_config()
diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
index 83cd454955dd..83e76cefbccd 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -960,6 +960,19 @@ struct yt921x_reg_ops {
 	int (*write)(void *context, u32 reg, u32 val);
 };
 
+struct yt921x_info {
+	const char *name;
+	u16 major;
+	/* Unknown, seems to be plain enumeration */
+	u8 mode;
+	u8 extmode;
+	/* Ports with integral GbE PHYs, not including MCU Port 10 */
+	u16 internal_mask;
+	/* Note: xmii_mask and serdes_mask may overlap */
+	u16 xmii_mask;
+	u16 serdes_mask;
+};
+
 struct yt921x_priv {
 	struct dsa_switch ds;
 
-- 
2.53.0

