Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0842C48987D
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 22:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785363931; cv=none; b=fwiy0/wu+KNZUWKGBkjQiKaM/VlCqiBUVKQD5zD9J5cerZ1s2UnPbxAJUGxZ7k1vGZy4phN+M1hFerPMXmnLDzi90kiFe+QnKkYgU6Wn7aFoAzmoblPiraJLSRFyptOAI3VbhDmOWGYhWIFsKBz1DKmWil6SzpLIgNeRcRels/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785363931; c=relaxed/simple;
	bh=BWznPQNwYRgxoCevgKpsJ1pVSmxIsuCe+64Zcrm4laA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YeRprIodR0ADhKec6/OrQlA00c/nGDU3CnRAekWW8VFHQqg4H17x2mKELEPThQvlN8v2LtYJAA6HIkB7yVyAmyw1SGauZy1fAWjnf5JMSaIMoZ/358fQe+8Xx4Gfd7C3+PbxgBbNbvo5S2VNs2NUzlKN4cyKT7s+W+crwr4zn9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GOvITDSA; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GOvITDSA"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8486672f03cso1623726b3a.0
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 15:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785363929; x=1785968729; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=rBSID6D0KqdII4bLfOt7/aD3X8WSWtRCi9Y2ElDI0xE=;
        b=GOvITDSAF0zqDrq+n2n79ET2kODY8UwK/OABHopHhD3roOJ8ZU1imbffw3xHDURtez
         LTutBF/3p017wr+50rTPt/L4aGLPsfpp6br20yA8n5Eg7wgD0cdRT1gr4qPTpEPRvIhJ
         pnDU+J1+sNiqWi3SZr9jpAJxLG+2lr9bG00j+U4NsT7xZ1ALyqIQeAQjOVmtCYDWCLg6
         /pPZglnnuuMhZzj2Hq7cu4xMVoC4AiAIZNIpcH+S3XL16KS0Ff9JyThQDiKdesm9fITI
         dwl1+807b1Rw8yGDZjjjoBccH8isnyzOd9A9BZ0ifjcrrX8NJX169bYMUXZ65taAizzU
         2m1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785363929; x=1785968729;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rBSID6D0KqdII4bLfOt7/aD3X8WSWtRCi9Y2ElDI0xE=;
        b=CLDBTszGqaEbd3JCcMN8LvCosKewNdjOR9l55d0VkWLDBcchc41Qbo5GFndF6eVVv9
         QPVbr8bUJzLemK9AS/j4Ga/SN0zf4K3XaFK72W9QZMv++zQQyW3oBtnuKODZrkeAbmhv
         Y5HT6g4J0k0+ITE5TndhV62Cvtmak3hQHw80JgrXnfo/rMkeaq0McIDixmfkCwF5hCkG
         c0J3ENphEsnbMKRobamT8agQEOhQjp0hs7w56OKO6kku+is9TY6ujq3iZ9c0BPZJrn0Q
         jjNA0C3aAq9LAXntgeVPzirpDUzFzwctCL4hTGVKdKtTwVKcrEA0TCq3nKhKMcG/1bW/
         eDng==
X-Gm-Message-State: AOJu0YwFOEEr0BKoCdNkT9eVB2GvtkwKbCdFRIxlH7GxCIlRzIdlf+dD
	hOyh0tjoouVkbh5rsmVWTaDir3GYY5vh0iaUmY5ucRmE/8Zgoy46hXIK
X-Gm-Gg: AR+sD12deF8m9kVTSkpFsPhOeagEdr/iDbblXUBsqmbbdVvYgXf+esJn/O98thkAr5r
	ReY8B9kboUAZNe4Ue1KjML6n+Abfq0PKntSs9MzFItrL96womo6Z0lDWlfX7MScrjfxRzI20M+d
	1t3T/aqdE9Nk1JsZNkftR/UV8cRMrqgZvLlbvXh6S3k43STx7MpLj4xqzECGecOlpD3Jznt/T04
	QoVxxdngtbb+38RvfLW5z0sLjQfWWJyzhff+u3NZqVmmwhPOy63Qf6en03fdokX670wX6HzI39U
	wSdC4YOjxCLO8Lmy0tfiNouDayuaqVvGIrh9ZbRnljZqZFLP+eM0QNWIjRNRZ+GuqxdJMhf8Yvu
	lRVVJpDrwDt+AnxK40uK7ghABTvRuHRcHpGKMQDVo7YEIalygLQMwLUUFV/sGdqoYoWCNnSCWgZ
	B8jWPCvCBkktXLtRkv+9UOWsFdjoHlX+552vmybZo+A2elRSkDMOmebZipdnISimtudEtuSuTOA
	4o9YyZVc/MronfFDGrhwE7r9YRSGZfDJn4AQZ//zCxOqjJQwKEOtGITkUG5oFwqFzlvZMVMoCeF
	9o5kKgXjf4nT
X-Received: by 2002:a05:6a00:6ca7:b0:848:8715:c2cd with SMTP id d2e1a72fcca58-84ebc3dc164mr145936b3a.47.1785363929329;
        Wed, 29 Jul 2026 15:25:29 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([98.97.33.182])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84ea0378b18sm1942447b3a.48.2026.07.29.15.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 15:25:28 -0700 (PDT)
Subject: [net-next PATCH v4 3/4] net: pcs: xpcs: Add hooks for xpcs
 configuration of rsfec
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: mike.marciniszyn@gmail.com, alexanderduyck@fb.com, andrew+netdev@lunn.ch,
 andrew@lunn.ch, davem@davemloft.net, edumazet@google.com,
 hkallweit1@gmail.com, jiawenwu@trustnetic.com, kees@kernel.org,
 kernel-team@meta.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux@armlinux.org.uk, mengyuanlou@net-swift.com, mohsin.bashr@gmail.com,
 pabeni@redhat.com
Date: Wed, 29 Jul 2026 15:23:19 -0700
Message-ID: 
 <178536379932.250758.16153445046800294554.stgit@ahduyck-xeon-server.home.arpa>
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

The DW PCS IP data sheet calls out the need to populate these vendor
registers when operating at speeds above 10Gbps.  This change enables the
correct FEC settings to enable RS-FEC encoding on the link which is the
standard used for most links at these higher speeds.

Signed-off-by: Mike Marciniszyn (Meta) <mike.marciniszyn@gmail.com>
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/pcs/pcs-xpcs.c |   67 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/net/pcs/pcs-xpcs.h |    6 ++++
 include/uapi/linux/mdio.h  |    3 ++
 3 files changed, 76 insertions(+)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 2e236ff1ad85..c252f8ba6517 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -1412,6 +1412,69 @@ static int xpcs_read_ids(struct dw_xpcs *xpcs)
 	return 0;
 }
 
+struct pma_pcs_values {
+	int channels;
+	u16 rsfec_ctrl;
+};
+
+static int
+xpcs_config_rsfec_pma(struct dw_xpcs *xpcs, const struct pma_pcs_values *v)
+{
+	/* fbnic's DW IP exposes the RS-FEC PMA at SEP_PMA1, so use it
+	 * directly. Scanning DEVS1 for the correct PMA MMD is left as future
+	 * work for enabling a non-fbnic device on this PCS.
+	 */
+	int pma_mmd = MDIO_MMD_SEP_PMA1;
+	int ret = 0, i;
+
+	for (i = 0; ret >= 0 && i < v->channels; i++) {
+		ret = xpcs_mdev_write_ch(xpcs, i, pma_mmd,
+					 MDIO_PMA_RSFEC_CTRL, v->rsfec_ctrl);
+	}
+
+	return ret;
+}
+
+static int xpcs_25gbaser_pma_config(struct dw_xpcs *xpcs)
+{
+	const struct pma_pcs_values v = {
+		.rsfec_ctrl = 0,
+		.channels = 1,
+	};
+
+	return xpcs_config_rsfec_pma(xpcs, &v);
+}
+
+static int xpcs_50gbaser_pma_config(struct dw_xpcs *xpcs)
+{
+	const struct pma_pcs_values v = {
+		.rsfec_ctrl = DW_VR_RSFEC_CTRL_TC_PAD_ALTER,
+		.channels = 1,
+	};
+
+	return xpcs_config_rsfec_pma(xpcs, &v);
+}
+
+static int xpcs_50gbaser2_pma_config(struct dw_xpcs *xpcs)
+{
+	const struct pma_pcs_values v = {
+		.rsfec_ctrl = DW_VR_RSFEC_CTRL_TC_PAD_ALTER,
+		.channels = 2,
+	};
+
+	return xpcs_config_rsfec_pma(xpcs, &v);
+}
+
+static int xpcs_100gbasep_pma_config(struct dw_xpcs *xpcs)
+{
+	const struct pma_pcs_values v = {
+		.rsfec_ctrl = MDIO_PMA_RSFEC_CTRL_4LANE_PMD,
+		.channels = 2,
+	};
+
+	return xpcs_config_rsfec_pma(xpcs, &v);
+}
+
 static const struct dw_xpcs_compat synopsys_xpcs_compat[] = {
 	{
 		.interface = PHY_INTERFACE_MODE_USXGMII,
@@ -1425,6 +1488,7 @@ static const struct dw_xpcs_compat synopsys_xpcs_compat[] = {
 		.interface = PHY_INTERFACE_MODE_25GBASER,
 		.supported = xpcs_25gbaser_features,
 		.an_mode = DW_AN_C73,
+		.pma_config = xpcs_25gbaser_pma_config,
 	}, {
 		.interface = PHY_INTERFACE_MODE_XLGMII,
 		.supported = xpcs_xlgmii_features,
@@ -1433,14 +1497,17 @@ static const struct dw_xpcs_compat synopsys_xpcs_compat[] = {
 		.interface = PHY_INTERFACE_MODE_50GBASER,
 		.supported = xpcs_50gbaser_features,
 		.an_mode = DW_AN_C73,
+		.pma_config = xpcs_50gbaser_pma_config,
 	}, {
 		.interface = PHY_INTERFACE_MODE_LAUI,
 		.supported = xpcs_50gbaser2_features,
 		.an_mode = DW_AN_C73,
+		.pma_config = xpcs_50gbaser2_pma_config,
 	}, {
 		.interface = PHY_INTERFACE_MODE_100GBASEP,
 		.supported = xpcs_100gbasep_features,
 		.an_mode = DW_AN_C73,
+		.pma_config = xpcs_100gbasep_pma_config,
 	}, {
 		.interface = PHY_INTERFACE_MODE_10GBASER,
 		.supported = xpcs_10gbaser_features,
diff --git a/drivers/net/pcs/pcs-xpcs.h b/drivers/net/pcs/pcs-xpcs.h
index 36f4906e689a..ab47d6dd050c 100644
--- a/drivers/net/pcs/pcs-xpcs.h
+++ b/drivers/net/pcs/pcs-xpcs.h
@@ -94,6 +94,12 @@
 #define DW_VR_MII_DIG_CTRL2_TX_POL_INV		BIT(4)
 #define DW_VR_MII_DIG_CTRL2_RX_POL_INV		BIT(0)
 
+/* Clause 133 defines */
+/* RSFEC transcode pad alter
+ * DW vendor extension in RS-FEC control
+ */
+#define DW_VR_RSFEC_CTRL_TC_PAD_ALTER	BIT(10)
+
 #define DW_XPCS_INFO_DECLARE(_name, _pcs, _pma)				\
 	static const struct dw_xpcs_info _name = { .pcs = _pcs, .pma = _pma }
 
diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
index b2541c948fc1..5219c877b2cf 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -317,6 +317,9 @@
 #define MDIO_PMA_10GBR_FECABLE_ABLE	0x0001	/* FEC ability */
 #define MDIO_PMA_10GBR_FECABLE_ERRABLE	0x0002	/* FEC error indic. ability */
 
+/* RSFEC PMA Control register */
+#define MDIO_PMA_RSFEC_CTRL_4LANE_PMD	BIT(3)
+
 /* PMA 10GBASE-R Fast Retrain status and control register. */
 #define MDIO_PMA_10GBR_FSRT_ENABLE	0x0001	/* Fast retrain enable */
 


