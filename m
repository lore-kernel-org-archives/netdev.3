Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3AA4D179C
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 18:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789671130; cv=none; b=GMTr19qcowunU1G9qERsKzUk94YrGfGJyee4ksDdNOPaojSpIt+nYc9xuAJAbBTrtCnGIZJGUiOFliFDzHNtn6txj7fRsa4JjFE7Ok9nW1HmrIRf03d7qsaYorMUGc2giGwLtiR0WnWfuiqajSzuQFRtG6OsCgT+ozdFcZLMQ5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789671130; c=relaxed/simple;
	bh=YuVnVbkxesHUrvTiDDRRP7qicf2K8BySrtV+L0OtK/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tl+jYIBTdkCqoeGjJvH+kOr69OjNQTudev7NMcZ4t9VQiaq9c56Z+TjTvgt5KzizGSBkB3B9LM7iq3zkbx+AJZDwCyi22EFHv2o6l5HyCv4ADwtStqIHNd5GF/ZWeedmRpXBe7MLF4al1sLUNQmAXlSpOYPHGY+w1lSB5lPpW0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q9MirAp1; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q9MirAp1"
Received: by mail-pj2-f43.google.com with SMTP id d9443c01a7336-2d91ede8035so14191815ad.3
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 11:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789671128; x=1790275928; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nUdkePa1f6mE21SLiU0MIHgY8wUKKU9ZP9pTIcp6WpA=;
        b=q9MirAp1+FgH1LS200NF60mel2o+AQU0aUEIdF/X93vlSl0Y+9jWiVdCdBr54oG/7H
         sdMPGY3smdLY10ipk/JPU7DB7L5FGyax6Co9zPtRAh0Fv0vlnDfCfzs/LhrUXuu/+wX1
         8GAMQX4rsQR2IAmM9NYnsKQ3zaa/DqxRDfv/imzHxtRJk2pLhGiFJ55oUBCxNWMhiIJG
         xSCmhcK3KrTMtkPfnQg5omD0S3LukH9YLQk+gQDLUQgDVfBJxFGESiSO9ownK5ixADpb
         HU6xV+AX7gKGZpzoF9uV/jxXLIclqqzzRYCCRCcI7NNMhWCvdDRoWEx+5yZqTgAV3yWa
         biGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789671128; x=1790275928;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nUdkePa1f6mE21SLiU0MIHgY8wUKKU9ZP9pTIcp6WpA=;
        b=VqQqTlc1k/N66Lsu4bYWfonkFwcGndOw5mATG9QdVHrRnkzcFsUlGzr+G8ZiYP3nYZ
         Ags0C0MYyzc17OT93J1R3ND8AsiFQho+0631fdGJ5z0kFuA4yzSDh9oJtRpBuwgAoxpN
         YAAD+wUkVm+9/bQ2r/I4Pbh+eDZCLJwTvDMa/W7webc0YSFrVbUDIa5ynKG92ENQbA1W
         fGHF+YQ0ABKwZ9lQyAuqVUaikA768FqaY6eqV1J2msXMj8K+1NRwrT+sTvhlh0anlipA
         dmpYO0+CyDkZkGXel7GT3ELj7LvBScSX/g9hC3Q8bwQZ1ApzHOyjGHhBjUfaMb8+b8J8
         BAAQ==
X-Gm-Message-State: AFuF++ncP/IYQx1si/3AtH4zqxmq0nBgaH3DH1+RNhvpt8mSV/+09jYF
	ZC9fYIze8NHbMjlSomqx3uKoiYTl3LHrcOOzOEvJUBY0uQMrzOB5rYjsyT9aFca3
X-Gm-Gg: AYBFou1nxF0RlY4xfdEm0FvEr1l4RMMhD6oTBCc0YMUj9IyH69F2qb7YWNjSWVapxLw
	8+cqCLm7cp+s56W6C0r5GQ728f1/kYqNoVm65se+97/u7//2L98KToQDM/LgrbfmD8J6R7wPh3b
	Rq/HGk+g1qk8nN1y3WavgEQlgWOSnkcCipv2aml7uTcDAl8uKEnwjVbslkXLIWJSthIBMajQNsG
	JKXdQxCSB1SsB/IVLvyYItpAaN3Sdr0ZM578c+G4r1GxzZHjXnyII1i3JXPfFdpGnqHTOo8H4eD
	mbwYQSOxSvZR2NkSQItyUy/tldxt0ETLllAQ5NoG2OjABLX/9pd3rAEwCTrgxCJQIL37r+4+7n4
	i2o6IShlPfuX6oTdtrID+3XnGbyhIyRIxLkU+l0i6tMKn1ZsRjIEa3F48Uky/5zFIYTPgvGMliF
	4lPbTWcNN/TAV1Pf8w08rayFJ96fbcaAuXrc1rL515aeh1evLsnmWwAubrHtousEGhbybiCzrvS
	KpLQyD4akdy7UMX14SkE+MAQg==
X-Received: by 2002:a17:903:234d:b0:2d6:e074:9cad with SMTP id d9443c01a7336-2ddb1acad2dmr2893325ad.6.1789671127782;
        Thu, 17 Sep 2026 11:52:07 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661a:1232::1d0:c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd89f331b7sm31032655ad.82.2026.09.17.11.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 11:52:07 -0700 (PDT)
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
Subject: [PATCH net-next v3 2/8] net: dsa: motorcomm: Split xMII and SERDES port masks
Date: Fri, 18 Sep 2026 02:49:49 +0800
Message-ID: <20260917185010.3189199-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260917185010.3189199-1-mmyangfl@gmail.com>
References: <20260917185010.3189199-1-mmyangfl@gmail.com>
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

