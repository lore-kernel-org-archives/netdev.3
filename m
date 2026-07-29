Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 640CC43F4A6
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 22:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785364067; cv=none; b=VaFa1pdMcl2dhDyMbMG/bONiQAnnuq3Upvq0n6ucanbk3iuwwIFVv1gY5rCzpMSQ8wHSmG2jJRonSgcns2HzNYJL3LLA7PBZE/dpPbsIIXtkbXHM6cg9oV32b4QrFDfTdnWeU+FwS7yjVVWo0wZ73PmbgCW1M4OS8itHW/cXDaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785364067; c=relaxed/simple;
	bh=BwjhxXRtEXMEJU2pXUu+xiTLRc56h3F1k0B5TE13fAE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WwAjatORABTLBKjBHccZMwnPyKnhT4slQh3lPBpoV1/InB+xO+SuEd1S1cs/KkrWYeDkwGnWZRiR44A3tcgwh5xD60BOsFJkDkNPTmYWPaB72us+DW9415+pqp60/HSYjbltT4UVIsx7cGq+iHWL1JsZVfjOJzLOlE4UfW60hPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oPxHBFsx; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oPxHBFsx"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so1486355a91.0
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 15:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785364064; x=1785968864; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=vp9X1J0psxfoXorUVmriwIdPJGbyvMXmMLZ5dc0hUus=;
        b=oPxHBFsxWmP86oRAR1//Mw33Sw1cdML23rF4T5hD7nx7hdiA4q1AAV4jqID/auV1eT
         5HLIhiVRO9MK2jYCmCRr8qn/VsgR06WyT9jpH+I1YXTamWB63EDFxAezuyBTmF7i1fJY
         P2w/8dNEEVcQef+9ihygdRsFns+NbRg3M590Nca21L2kCu7220XAZ+5Y+aQc31MBUuxo
         vHkQDI1QOOQ97LE+ik6gKGMUPXJLNdg/+D6PSmX/6zlD54DEIFsVcHbGSNm4CxArMJGT
         d4Dr7tB8TN3iRcOOzJ6iSTxSB1XU7vrhOpsD8vIf26dCU7bFoebfoO7zXP3tOedvqnX6
         /hAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785364064; x=1785968864;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vp9X1J0psxfoXorUVmriwIdPJGbyvMXmMLZ5dc0hUus=;
        b=icgb3P2Kw6CTGn3KHZUGn5WlAVqOE1zyKaF4710flrM2vnCeS2WxQHm0lPHG84sT7+
         7Kc5A7IEKOu5bbVTxb74O4NDtVuv8nx6wehVsUNd1odXCw0m7vHnkdHc52nr2Up3WYkF
         V3R1e05ie/YJeyBUXrsMGmMfQUoDky23bQmKE/hGfYKRPQdA5Fop9FhRED8viyNs1fhY
         Ap4eObw6abgX+c0ZfikbxuZXPurvQEONVw09beP9VP4ZNQaFG/MahT690r3IqfsYqgCR
         oUlD+kdxPcN0YPbtl9Jid1IBgrU0mj4KOgBqtrOprSPSC7g6134KXpcdgpZNLUk8Zonr
         h4cQ==
X-Gm-Message-State: AOJu0Yx94s6qTZGZN/v3In9DPyGhvvaBMzxbG7NhJBk8XJYjVHK2YId1
	GpjjJ7SdWp/WHwilOuUC9GBYA4Uz3XuIlwnBQ/Z14bkeMsXNpSYM6txT
X-Gm-Gg: AR+sD10aBPNvXcALiY186hYErP1h8RHqhwk8eyBv2lAHjmvUaKM72TcvEvs1a5O9YMU
	xkY12Ypjd3uXrcw6luOqW9muT+PgK2M2EpRClQpyy+1gaG3k27+fagFiEc03BgYWxBSQGe44i72
	qqbaQ03BYVMuzjj7tRMSa1/4Stf2NnLTw8tgLszCcwqRUErueuVWGrh+y9CFo/MyAcBXX0AmUIS
	+ypv2nXjdMjDlgn2tMuSQ+Yu6eENXq1/k8wCT/WuZonIuqi6LRN0auafnaFpUr+3ozR2xukqrcA
	v5llo0/eNUHN+IP2Ane/UvD0pmxnJWcFBTW5fSOp52VH0an1idWZZR7zJKCq/2J1sUGLy4w4X/S
	0PbMvamgKj6NyDs0ekSO6nqKQZeEOiGqwuQRxzAvfNpd2Mp5Q+XAdlhi4qnao/fwpHXAT32Ku+R
	szDnTQqx0EwVGyjMLxplNQJeRRLOcq80J1BYNfo2Cmwu1YHiy0sEKNRwTb70r8qnUQxCnfxABmg
	pT8pmFz809+3UgRDAqGPdha7I7lKHOAJVpJuahmUzp2fr1NDBXUn47dOH+/IZcaVXZQ7y7GiL7F
	yaKBjoL/6HlX7g==
X-Received: by 2002:a17:90b:4f89:b0:37f:ed7e:7e42 with SMTP id 98e67ed59e1d1-38f9bdd3b5cmr89460a91.14.1785364064398;
        Wed, 29 Jul 2026 15:27:44 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.33.182])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f814cba32sm1061121a91.2.2026.07.29.15.27.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 15:27:43 -0700 (PDT)
Subject: [net-next PATCH v4 4/4] net: pcs: xpcs: Add handling for 4 channel
 rsfec device
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: mike.marciniszyn@gmail.com, alexanderduyck@fb.com, andrew+netdev@lunn.ch,
 andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
 hkallweit1@gmail.com, jiawenwu@trustnetic.com, kees@kernel.org,
 kernel-team@meta.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux@armlinux.org.uk, mengyuanlou@net-swift.com, mohsin.bashr@gmail.com,
 pabeni@redhat.com
Date: Wed, 29 Jul 2026 15:25:34 -0700
Message-ID: 
 <178536393447.250758.12698568086617343381.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <178536329631.250758.9931617589255894843.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <178536329631.250758.9931617589255894843.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>

This patch introduces the configuration of vendor specific registers for
alignment encoding, PCS Mode, and VL_INTVL over the one or two instances as
required.

The DW PCS IP specification calls out the need to configure both lanes
identically when using 2 lane modes such as 50-R2 and 100-R2, so the
programming is repeated for each channel.

The encoding tables are derived from the IEEE 8023-2022 spec sections
82.2.7 and tables 82-2 and 82-3 for the alignment markers and their
insertion.

Note that there is a conflict between VRs DW_VR_XS_PCS_DIG_STS and the
DW_PCS_IP DW_VR_MII_PCS_PCS_MODE.  The bit mask for
DW_VR_XS_PCS_DIG_STS/RX_FIFO_ERR fits within the reserved bits for the DW
PCS IP DW_VR_MII_PCS_PCS_MODE register so there is no issue.

There is also a conflict between DW_VR_MII_PCS_VL_INTVL and
DW_VR_MII_AN_INTR_STS but an_mode differs, so again there is no issue.

Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/pcs/pcs-xpcs.c |   96 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/pcs/pcs-xpcs.h |   25 +++++++++++
 2 files changed, 120 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index c252f8ba6517..d9c444528f55 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1412,11 +1412,67 @@ static int xpcs_read_ids(struct dw_xpcs *xpcs)
 	return 0;
 }
 
+/* m0 - m2 from Table 82-2/82-3
+ * m4 - m6 are skipped since they are inversions of m0 - m2.
+ * Inverted parity fields (IEEE 82.2.8) bip3 and bip7 are omitted.
+ */
+struct lane_markers {
+	u8 m0, m1, m2;
+};
+
+/* Alignment marker encodings, see table 82-2 in IEEE 802.3-2022 */
+static const struct lane_markers xpcs_100gbaser_markers[] = {
+	{0xc1, 0x68, 0x21},
+	{0x9d, 0x71, 0x8e},
+	{0x59, 0x4b, 0xe8},
+	{0x4d, 0x95, 0x7b},
+};
+
+/* Alignment marker encodings, see table 82-3 in IEEE 802.3-2022
+ * The content of the 50G markers is identical to 40G values (IEEE 133.2.2).
+ */
+static const struct lane_markers xpcs_50gbaser_markers[] = {
+	{0x90, 0x76, 0x47},
+	{0xf0, 0xc4, 0xe6},
+	{0xc5, 0x65, 0x9b},
+	{0xa2, 0x79, 0x3d},
+};
+
 struct pma_pcs_values {
+	const struct lane_markers *vl0_markers;
+	const struct lane_markers *vl123_markers;
 	int channels;
 	u16 rsfec_ctrl;
+	u16 pcs_mode;
+	u16 vl_intvl;
 };
 
+#define XPCS_VL_TO_REG(vl, lh) \
+	(((vl) * 2) + DW_VR_MII_PCS_VL0_##lh)
+
+static int
+xpcs_write_pcs_ch(struct dw_xpcs *xpcs, int ch, int reg, u16 val)
+{
+	return xpcs_mdev_write_ch(xpcs, ch, MDIO_MMD_PCS, reg, val);
+}
+
+static int xpcs_config_ch_vl_markers(struct dw_xpcs *xpcs, int ch, int vl,
+				     const struct lane_markers *m)
+{
+	int ret;
+
+	/* m0, m1, m2 written to _L and _H registers
+	 *
+	 * _L = (m1 << 8) | m0
+	 * _H = m2
+	 */
+	ret = xpcs_write_pcs_ch(xpcs, ch, XPCS_VL_TO_REG(vl, L),
+				((u16)m->m1 << 8) | m->m0);
+	if (ret < 0)
+		return ret;
+	return xpcs_write_pcs_ch(xpcs, ch, XPCS_VL_TO_REG(vl, H), m->m2);
+}
+
 static int
 xpcs_config_rsfec_pma(struct dw_xpcs *xpcs, const struct pma_pcs_values *v)
 {
@@ -1425,9 +1481,28 @@ xpcs_config_rsfec_pma(struct dw_xpcs *xpcs, const struct pma_pcs_values *v)
 	 * work for enabling a non-fbnic device on this PCS.
 	 */
 	int pma_mmd = MDIO_MMD_SEP_PMA1;
-	int ret = 0, i;
+	int ret = 0, i, vl;
 
 	for (i = 0; ret >= 0 && i < v->channels; i++) {
+		/* code word markings */
+		for (vl = 0; ret >= 0 && vl < 4; vl++) {
+			const struct lane_markers *m;
+
+			m = vl ? v->vl123_markers + vl - 1 : v->vl0_markers;
+			ret = xpcs_config_ch_vl_markers(xpcs, i, vl, m);
+		}
+		if (ret < 0)
+			break;
+		/* vendor registers */
+		ret = xpcs_write_pcs_ch(xpcs, i,
+					DW_VR_MII_PCS_VL_INTVL, v->vl_intvl);
+		if (ret < 0)
+			break;
+		ret = xpcs_write_pcs_ch(xpcs, i,
+					DW_VR_MII_PCS_PCS_MODE, v->pcs_mode);
+		if (ret < 0)
+			break;
+		/* rsfec register */
 		ret = xpcs_mdev_write_ch(xpcs, i, pma_mmd,
 					 MDIO_PMA_RSFEC_CTRL, v->rsfec_ctrl);
 	}
@@ -1440,6 +1515,13 @@ static int xpcs_25gbaser_pma_config(struct dw_xpcs *xpcs)
 	const struct pma_pcs_values v = {
 		.rsfec_ctrl = 0,
 		.channels = 1,
+		/* 25g markers from 100g and 50g tables per 802.3-2022
+		 * 108.5.2.4
+		 */
+		.vl0_markers = &xpcs_100gbaser_markers[0],
+		.vl123_markers = &xpcs_50gbaser_markers[1],
+		.vl_intvl = 20479,
+		.pcs_mode = DW_VR_MII_PCS_MODE_CLAUSE107,
 	};
 
 	return xpcs_config_rsfec_pma(xpcs, &v);
@@ -1450,6 +1532,10 @@ static int xpcs_50gbaser_pma_config(struct dw_xpcs *xpcs)
 	const struct pma_pcs_values v = {
 		.rsfec_ctrl = DW_VR_RSFEC_CTRL_TC_PAD_ALTER,
 		.channels = 1,
+		.vl0_markers = &xpcs_50gbaser_markers[0],
+		.vl123_markers = &xpcs_50gbaser_markers[1],
+		.pcs_mode = 0,
+		.vl_intvl = 20479,
 	};
 
 	return xpcs_config_rsfec_pma(xpcs, &v);
@@ -1460,6 +1546,10 @@ static int xpcs_50gbaser2_pma_config(struct dw_xpcs *xpcs)
 	const struct pma_pcs_values v = {
 		.rsfec_ctrl = DW_VR_RSFEC_CTRL_TC_PAD_ALTER,
 		.channels = 2,
+		.vl0_markers = &xpcs_50gbaser_markers[0],
+		.vl123_markers = &xpcs_50gbaser_markers[1],
+		.pcs_mode = 0,
+		.vl_intvl = 20479,
 	};
 
 	return xpcs_config_rsfec_pma(xpcs, &v);
@@ -1470,6 +1560,10 @@ static int xpcs_100gbasep_pma_config(struct dw_xpcs *xpcs)
 	const struct pma_pcs_values v = {
 		.rsfec_ctrl = MDIO_PMA_RSFEC_CTRL_4LANE_PMD,
 		.channels = 2,
+		.vl0_markers = &xpcs_100gbaser_markers[0],
+		.vl123_markers = &xpcs_100gbaser_markers[1],
+		.pcs_mode = DW_VR_MII_PCS_MODE_DISABLE_MLD,
+		.vl_intvl = 16383,
 	};
 
 	return xpcs_config_rsfec_pma(xpcs, &v);
diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
index ab47d6dd050c..adb7b1c13c2d 100644
--- a/drivers/net/pcs/pcs-xpcs.h
+++ b/drivers/net/pcs/pcs-xpcs.h
@@ -100,6 +100,31 @@
  */
 #define DW_VR_RSFEC_CTRL_TC_PAD_ALTER	BIT(10)
 
+/* Vendor specific 4 channel PCS registers */
+
+/* DW_VR_MII_PCS_VL_INTVL and DW_VR_MII_AN_INTR_STS conflict
+ * but code paths are different
+ */
+#define DW_VR_MII_PCS_VL_INTVL		0x8002
+/* 0x8008 - 0x800f */
+#define DW_VR_MII_PCS_VL0_L		0x8008
+#define DW_VR_MII_PCS_VL0_H		0x8009
+#define DW_VR_MII_PCS_PCS_MODE		0x8010
+
+/* DW_VR_MII_PCS_PCS_MODE bits */
+#define DW_VR_MII_PCS_MODE_HI_BER25		BIT(2)
+#define DW_VR_MII_PCS_MODE_DISABLE_MLD		BIT(1)
+#define DW_VR_MII_PCS_MODE_CLAUSE49		BIT(0)
+
+/* 25G requires these two bits are set.
+ *
+ * The CLAUSE49 bit changes the interface with the MAC
+ * to 64 bit and the BER25 bit changes the measurement
+ * interval to 2ms.
+ */
+#define DW_VR_MII_PCS_MODE_CLAUSE107 \
+	(DW_VR_MII_PCS_MODE_HI_BER25 | DW_VR_MII_PCS_MODE_CLAUSE49)
+
 #define DW_XPCS_INFO_DECLARE(_name, _pcs, _pma)				\
 	static const struct dw_xpcs_info _name = { .pcs = _pcs, .pma = _pma }
 


