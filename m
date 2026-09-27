Received: from mail-oa2-f34.google.com (mail-oa2-f34.google.com [74.125.231.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDAE43990A
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 18:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790535163; cv=none; b=ZbJ3yqfuOkojqtA8vmrlnQPs3N9rKFH1YxE5gbgFlI7zyAsb8LN6kobamvGe7DGHI2P5nwuC/lELfzJUYmidoFVz+6gtDwH4nIKoA4KuI70m29e35rhEef1FJtGIZiAgPXEdDGdgtDHk4oEjT663CeqTbM7TfJAEI/a2R4onyeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790535163; c=relaxed/simple;
	bh=LZU2UEoJoqXa5uqbCSIGcGZQwGpaf5s9d0O/6M07Sus=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lee+ZFTc4QlIs9toraTMRreziHE8fahbgODY5w62Vc1Ta3a0qJV4JuEL0s0MVEI5UjAzva9UZp5vNb+YktqUaRLOPx7t6zXfUezprX//e4bXouCpmIR9+/fuxFk07XnYPNGsJNjMQJfWobN891A0NfpBJcgqiAxeDpytvvZvnsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRQkwFU8; arc=none smtp.client-ip=74.125.231.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRQkwFU8"
Received: by mail-oa2-f34.google.com with SMTP id 586e51a60fabf-494ab4d6128so243378fac.0
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 11:52:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790535156; x=1791139956; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AU4yKGQ6L9A+Mmj7ksqDUcZd7jKkYCDxeCg2XUTgNgQ=;
        b=HRQkwFU8K58eqFs0Van5D14EZYbIU5vdDXCQCpbmSlsXi1ZEXwOLNpg42ZpvkyTMcg
         drRRJ6Y6TfodgFE40aMC+kRj9SkpyH8StouIYqqSHJdPgrAa7IhaT3Z6PzEaX3V29oKZ
         HDGS51lGGkKUecxE/Hqe4ulopFDfMFVmRwdzSBoQE+IHDHwbJG4RgHffj6mJf+bz2GXL
         BZIxSgRvvIkx84BypzXJgp5BewSBv/D7hxMDSgpJzXb8iWOlIRLCeLYLAreZ4WUe/AGm
         dVwCME3tFdQYHOEVCT4geNvd/hTGS/nIn0F7j73CVIGed1fJtPEtvckUB22K8T5I/wfr
         arIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790535156; x=1791139956;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AU4yKGQ6L9A+Mmj7ksqDUcZd7jKkYCDxeCg2XUTgNgQ=;
        b=RGhkIpFWz+D8xuKHg1jO8pj1sqTb5t7UyqV5ZB0VM67GiuDcgQU8ZvIyqqo5EI/w9d
         8Kyls+YmG+Q7iptlgqGDKglFRzDV4zslU+YPrMLQNiHfeyURneSctD7aOdon/tuswYm6
         hpayja8qqsZJ8CePSyzvEJhMo4dsirTQhnckaBW22MF+CUpd/juHGr+s1N8kvHatRUfY
         3NUqsRxA/UH1lonnpnEOfnaNqQvIH3Yqu3oJcW6E6RqVAgO/20QGSkgDsRXWaSyGnb/i
         TSyfLb84V5Oy/IVTVt+6p7GpWvMBhTly3nKTpdyJhzVWJV3S43ePbQCTvH7WSy3+8G4R
         Dd9w==
X-Forwarded-Encrypted: i=1; AKwUvBwjhjYDdqz+Tgt21uowfWkOLfQPjjScBZ3QebIQiFb8CfE6B/DxutdMobBzY1jcTOfCHYYBzWQ=@vger.kernel.org
X-Gm-Message-State: AFuF++n83+mbqGTxXg+3sFzGkTVXlS+1HwRuke1o9yk3RtgbxPkekzPh
	V5y7QZYxDFzPL2KjXqifAc7Cr7XEAzbod3RLnGwedx2BtAMSE2fWOFqj
X-Gm-Gg: AYBFou2h1Y1aN51vDpT0DWAC0lf48dgHFNd7UPmFLJjKohvlqBE2+mwvycgkc+S/FN8
	iYrIsqttOvPlLOMch37j1za6AV4JItxAmf12GPMLE7W0IZvHT7LcQ7PuX+bg06Brq/THKMTq/c1
	iwTQS4/SyO/qHGqwuX2QcAkvM3Nk/lRTI5zTLLCRHtIErSAMe6vp3oC23bTXC5t5pHx/eQOsWVk
	4dhpN+ZEHH6jZ9kiYkFjCxWrFJs/Yz5HR30CwHYjxIcMHq2R1m5oosdvXr1eNxLGNFiG+M1TSV9
	yazWyQyMkfV6OSHy7uqHzURG4OgAaMCAu9iPBDvO6D0pL0jLYrhDf8Kxn8AstOylDGntlnEtwWZ
	yW1F2pkJHY4r06iCe8TJ8zZH3xwt/BcPh0s3n5X0zZC093I10ITY2J6jCF62EqRjz6kt/Ai/Tgf
	bW2DhZOQOODhxpaG1fbHLdAEuPQxwkrrMLl8vug7PzSP3jSjncgcwhPkAyxYFV1BF/nuGCAHAam
	MvodpXuNasNp8bxS2l2d1oF0eex+GvxkWXkCnRixKlLjU2cMh925AKEnUh3Vd/v765WZrh2p7JQ
	8Sk7UUs2TicnmMUuLPoWDrQ2wA/t8tfBDxn9NHgosGQcDsHtxI6DSe8oS9bw6dWz/GJzPCWLEzX
	DVPXfVY9rCm5X8WcmXRd4
X-Received: by 2002:a05:6871:1d2:b0:47b:dbb4:7cbb with SMTP id 586e51a60fabf-491e4f73b4bmr12418319fac.14.1790535156264;
        Sun, 27 Sep 2026 11:52:36 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-494877590e5sm4489452fac.13.2026.09.27.11.52.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 11:52:35 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 27 Sep 2026 12:52:21 -0600
Subject: [PATCH net-next v6 3/3] net: stmmac: sun8i: add support for
 Allwinner H616 EMAC1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-submit-h616-emac1-v1-v6-3-e64971f4e414@gmail.com>
References: <20260927-submit-h616-emac1-v1-v6-0-e64971f4e414@gmail.com>
In-Reply-To: <20260927-submit-h616-emac1-v1-v6-0-e64971f4e414@gmail.com>
To: Richard Genoud <richard.genoud@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 LABBE Corentin <clabbe.montjoie@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>
Cc: Alastair D'Silva <alastair@d-silva.org>, 
 Maxime Ripard <mripard@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>
X-Mailer: b4 0.15.2

The H616 secondary EMAC uses a separate system-control clock register
and supports only RMII at 10/100 Mbps. It connects internally to the
co-packaged AC200 or AC300 EPHY and has no external PHY pins.

Add an EMAC1 variant using the dedicated register and enable only RMII.
Leave PHY initialization to the PHY driver instead of using the H3
internal-PHY controls. No RX or TX clock delays are configured for this
RMII-only variant.

Co-developed-by: Richard Genoud <richard.genoud@bootlin.com>
Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Alastair D'Silva <alastair@d-silva.org>
Tested-by: Alastair D'Silva <alastair@d-silva.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 5691da796454..47954537b29e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -81,6 +81,13 @@ static const struct reg_field sun8i_syscon_reg_field = {
 	.msb = 31,
 };
 
+/* EMAC1 clock register @ 0x34 in the "system control" address range */
+static const struct reg_field sun8i_syscon_reg_field_emac1 = {
+	.reg = 0x34,
+	.lsb = 0,
+	.msb = 31,
+};
+
 /* EMAC clock register @ 0x164 in the CCU address range */
 static const struct reg_field sun8i_ccu_reg_field = {
 	.reg = 0x164,
@@ -143,6 +150,13 @@ static const struct emac_variant emac_variant_h6 = {
 	.tx_delay_max = 7,
 };
 
+static const struct emac_variant emac_variant_h616_emac1 = {
+	.syscon_field = &sun8i_syscon_reg_field_emac1,
+	/* The co-packaged AC200/AC300 PHY does not use the H3 PHY controls. */
+	.soc_has_internal_phy = false,
+	.support_rmii = true,
+};
+
 #define EMAC_BASIC_CTL0 0x00
 #define EMAC_BASIC_CTL1 0x04
 #define EMAC_INT_STA    0x08
@@ -1281,6 +1295,8 @@ static const struct of_device_id sun8i_dwmac_match[] = {
 		.data = &emac_variant_a64 },
 	{ .compatible = "allwinner,sun50i-h6-emac",
 		.data = &emac_variant_h6 },
+	{ .compatible = "allwinner,sun50i-h616-emac1",
+		.data = &emac_variant_h616_emac1 },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, sun8i_dwmac_match);

-- 
2.53.0

