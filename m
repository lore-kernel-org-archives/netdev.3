Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED794B0E32
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 16:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577036; cv=none; b=u5NIm9V4y4DcavBc/e5JFnMRrSnAHJuY1vaCqf+F3TvWQ5r6QfftSzBBRGN4/pxB/C3n0PUeacwwHPXY8Z0gmO1lSBnQVFI8KObhPxyWDIg05BouSsdJzUsYQjhQBdvHhSMIH2Isp45+elTie7g7FMPAYHp3u3DNNj1OfOj6/RA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577036; c=relaxed/simple;
	bh=YuVnVbkxesHUrvTiDDRRP7qicf2K8BySrtV+L0OtK/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ojv3ar2UIV4VN4PEiCrxZUvXasv49W0znp5c+SjUXqk6kafBFu9stAmwQREdrY3N3BamaJN5IowCFKLAh312D4UCp+dXGGcma1o7+3pNGXVbxFJ0OAn6SJjhk/TufhmKB+wRXIv2YxHQSlYVBxZLx4v0QCdAlopWYI0xpeCh7YQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hhN0a1Hh; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hhN0a1Hh"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cea4ae2cso997863a12.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 09:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789577015; x=1790181815; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nUdkePa1f6mE21SLiU0MIHgY8wUKKU9ZP9pTIcp6WpA=;
        b=hhN0a1HhHOvtP/in0VooKFYuw15/0BMdFcO5nuDobVqnaET8L9Z3HSIuOTtTJxKtPe
         Y1vJR53kCQIdEYnXT1sNaRhjAygsEDX85ol2Y6iGl2ypsx7Qpq+VdNyPlIVI8CKs32pW
         wmjM/MljKrDx6mPlaG2yc+tEfsBhXlXvOTdwF84SQbgCOCmIjyJP6RQWoBOQfdWidFu2
         bvF5RmQweATBXVencG+hzlp1vSKRwPJAlQ15jphsJsXmSzjKqoy40VZMc4QXHeqv/mJE
         jfHocyxG+4zt6uJBeTB0HTzwvPi4B8XOQuyrFkd56SAMP0W2apbablmrcgbhj5nEjjN8
         wT1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789577015; x=1790181815;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nUdkePa1f6mE21SLiU0MIHgY8wUKKU9ZP9pTIcp6WpA=;
        b=L2S5SI4EgCJHJSDuWLD+zepN8Gcc6vyfdEepC6kiV0nHwxSMAIdxaufbEbAIKtr75E
         3WoBhQhgVyON6fbYEMJv0OLufHzYSvfKjQ9qCLJKiQiWbs61Ma6K2yQscdQXgUuV6OOt
         rkXuS5U4QiAYOOzyxzZDU5o4/FUpV3XntWH6VO9tj5khgImKE2A7Djzso7OIEzfwEIG2
         RY2U0eencWO+TRmaITZu7PlIR9y10PaLnTctZK66UYuYRfDqAKrg/EPA4yiQoB+6BiBj
         +4zsfye3WHaVaryKFFAbGDFh3hTQ5/EekoPIaWbyDvVVfjdoZmd9CZv7vYGq+pFdiXnv
         ClpA==
X-Gm-Message-State: AFuF++nOHOxx+onujln6Wlwho/Z1HYEOf8tyR0Cjzt1FCstkBy3aSaf8
	lSPyco3XezI8z/1GkRnAeG0e7AQwqLDBs0HTc+LZ+M3Kn1enW645EWSE4SgC6cx7LXQ=
X-Gm-Gg: AYBFou3jIBbOS7+8ULH6zsOTulBXg5Bg9kHofkGiEbb8LL5zzxLFD5T5musONLirlHD
	yi6WXBBZD1+6a9gvMbtFaI2y2rF43h9pJpUylJRH+DCIdnRg2ssT/PQHYcsxbpzA8dJ9DFp480u
	u8qo+NriOUq0MX0jyDv3JjWR3+iVp4sndTdOzXh3qolWrF+8wSZmllDAF34Th9vdceG2y1kiJht
	Hbd71YPWHK0xRg+Q9jBdGXnKhwCzY1YcV9cYnbo4bZSr5HBiC+3IiyAvWEQhKhE3KX1ikChdvxF
	lXQo2ttbrkHVhNcnwJa+v1A/Hk0c5dadBlASncz6pee0EUxgkEu3BMEFVVmM+ygkWxecD/gcdOK
	hanvldHqkgV+KD2p80MTdALiZwG6CgBgfCGMGBxlljJS39DYYg2sTwSSqDB6jUoO59SGxnLVg3l
	oF+uECZHwiKrsayhu88LDRnB24EYpS2oLF3Ve38aUCUrA3aSxq4qsX4eF3u8bO7o+9aKGe+h5MN
	DP5W6+Mk0sOXHFwvGe+aaAZUiZf0WMmlP8x
X-Received: by 2002:a05:6a20:72a6:b0:3c3:7179:a640 with SMTP id adf61e73a8af0-3dd5f3c0a6cmr8204589637.3.1789577015271;
        Wed, 16 Sep 2026 09:43:35 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661a:1232::1d0:c5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc50acc757csm1902278a12.32.2026.09.16.09.43.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 09:43:34 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/8] net: dsa: motorcomm: Split xMII and SERDES port masks
Date: Thu, 17 Sep 2026 00:43:02 +0800
Message-ID: <20260916164310.3168269-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916164310.3168269-1-mmyangfl@gmail.com>
References: <20260916164310.3168269-1-mmyangfl@gmail.com>
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
---
 drivers/net/dsa/motorcomm/chip.c | 39 ++++++++++++--------------------
 drivers/net/dsa/motorcomm/chip.h | 13 +++++++++++
 2 files changed, 27 insertions(+), 25 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 5acd7d27ff40..b527a9cfd3e8 100644
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

