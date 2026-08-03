Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7E036D9E9
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 05:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785734125; cv=none; b=FHSnE7MZyqNlhI/3tO5xGV+jRi8rqecHPwphvuybsGdbd280z1bfzjy4c+ACeLgbRGZKhGE6FlDMT2es5121O/NHpZ39kK7Qsjpmf0L+/wPGzuyhqhWBhdmyyMZWVyBhrQysqw/jsyIu0xbGMdpG2bKJYXA0e1Vuj21+K4v/K/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785734125; c=relaxed/simple;
	bh=LuLd1Fgsqz/EvyuQmaammKLeRagaqJ0vM3tIyUpmvMk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZC2ReVB3BkppNfdQ51LMGGkkOwkW3vhPCNFBj6uZvt7oTJ3uu4kfwOAW2Xu5+EWVMUmo8mUbaa9Tn+2VGofhhwDjeSnn5Dqy5jay4UteILBMKzlmX0VQ/BWSwlRtDhE+UdYNmji+QiwXvz7Yhxe+zg6VMt25DHaHNjzPD4ki310=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THNU5m/D; arc=none smtp.client-ip=209.85.210.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THNU5m/D"
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-7e6b554044fso2627190a34.0
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 22:15:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785734123; x=1786338923; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SlcJviNfe1A7bPODjwx5akEOsNAeWr5kscTUhAqnE8U=;
        b=THNU5m/DbyL2C5YgFvkOystoO7+9oc8243fKg4VTDyzaaplIAInaDjMIupW0W7XQm2
         KLR5mVBSOJo7u1cDjbsNCjURaxLPQFs6/2+zyndJFu5cizi9ZYtt2sw6UPRkhfFFK7U3
         opt6JkWw+Ik+Diz7nq0z6cY/I4y8KT6jk3e5+184SC50jZOI4mmOO3vSh+pzGYGdyr+u
         DosNFliKkVhFv261bnNQ8mVANAO7N7Y7rZUofKPZYaiTyMmIk9vHJKljH/QmpofgQsxy
         nSwattgzzKpMrX7ZWvJRsDOY39ueLD8fO+3jKxABPZuQeuhZdxq+cK3mK8h9Oq5m0dRr
         Pilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785734123; x=1786338923;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SlcJviNfe1A7bPODjwx5akEOsNAeWr5kscTUhAqnE8U=;
        b=tW52ES2xvS8bx4T2C6SUGxnn+J67h8Oiry9t60egG+8IjcdKW5lnNaJy1u1wmpPws4
         hSuy1aBN4PDdl77iyqO4Njs85757+vSkxdSgahpwLicAaNuzshzX8jEXkUOvdErjjaZL
         ymjJLG2kEiIILsN8aWCLPWeuoYLBAt8fTbDmkuGa5icCjFnV++viUgO0ivzuN2pp5XcK
         CVmRw1xYna5k6vp/9eOGDzGxNvu31Q2mdFtDTW70vri/ndeGEt03SwmDCNEddhGzvO3P
         1Q+YqsLsGsgkHMK+nkqJG2qevJlzTPRX+/42Bl0qRHR6jXq4SXyGpSsGa/HkbJ0scI4T
         vRMg==
X-Gm-Message-State: AOJu0Yz+Ab3eu99SXJB5ugdA4oUnd3am9yvw6r1pSNoF+0d2HFEus1L1
	VsPxBbk9fq+8x1IejBrD40gFn7j3zbSYKv9T6XJlUynLxpiUb1SqfsRh
X-Gm-Gg: AR+sD12+zC9QxNr15sYCUGyo97GHh24retKmyI5fipehQAZqBumAPnKrUoNUzaPnqGk
	jHFm7cz7wKj5Q2uMxYgaynXPvRCWEDRrIpPdxrPl6/kRRld0iEYk3DCcJYjITqQ8yF6CwtE2bYJ
	dd6c4kHjuenM+fHMR8xwgWmmCz/OR+5tEC2vDv68YHq5lwnRVTu/UvpjQmRWFWBtbmc0M6idQEq
	6hymjIP+xmtgFxH2oVpq/3r4VhllXTklknv5RJNQ4GGeSx1eZqHjMPKkzviQl5FGVClPWQeURUa
	RqQaHWhcCQy5LLHWG8VNo0YsVaYolkCFDEEGWbkohxw8mDxTCk4wkEWdHXpSg5NNLXbWIBNgww7
	yGc949gOlu8lsNgp4ILhtyiMKkd5vXFbRO1NUmoNYy46B7+JR4JlEnVSSTbFkOBCWvYfv0sFLPw
	GWwxoej2txCA5CpjDp3rFPsO6tghT0jHnSVGhOXADp2ntnDsQCIzPVkLXgReJTnp+YTPInboXLG
	kfd6ef4PeL10Q0NzldLccNC8dpbnS/pMrM0/IAFYlSPt1YEvtCaIu6BRBsT2x48RlFJ1y4nNy/X
	3ypODoQgfax/2fibLGRMMXK20V03XEuv6V1LZfkjrR2G0cBtBU46QqRS21OhX6VwS5MfCieiQon
	935tq1tmFdRKaYa8H
X-Received: by 2002:a05:6830:211b:b0:7e9:c102:333d with SMTP id 46e09a7af769-7f196f8ad8cmr14493591a34.9.1785734122667;
        Sun, 02 Aug 2026 22:15:22 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18f07a5e3sm6787108a34.15.2026.08.02.22.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 22:15:22 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 02 Aug 2026 23:14:12 -0600
Subject: [PATCH 02/21] net: stmmac: sun8i: add support for Allwinner H616
 EMAC1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-submit-acx00-of-dynamic-v1-v1-2-0a53cd9e21cc@gmail.com>
References: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
In-Reply-To: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Saravana Kannan <saravanak@kernel.org>, Lee Jones <lee@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 mfd@lists.linux.dev, linux-rockchip@lists.infradead.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

From: Richard Genoud <richard.genoud@bootlin.com>

The H616 secondary EMAC uses a separate system-control clock register
and supports only RMII at 10/100 Mbps. Its EPHY is provided by a
companion AC200 or AC300 package rather than an internal PHY block.

Add an EMAC1 variant using the dedicated register and mark the PHY as
external. The register retains the standard five-bit RX and three-bit TX
clock delay chains, so expose their supported ranges to the shared
syscon setup.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 48c52eb96233..fdc0c3384af8 100644
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
@@ -143,6 +150,18 @@ static const struct emac_variant emac_variant_h6 = {
 	.tx_delay_max = 7,
 };
 
+static const struct emac_variant emac_variant_h616_emac1 = {
+	.syscon_field = &sun8i_syscon_reg_field_emac1,
+	/*
+	 * The "internal PHY" is in a companion AC200 or AC300 package,
+	 * rather than on the H616 die.
+	 */
+	.soc_has_internal_phy = false,
+	.support_rmii = true,
+	.rx_delay_max = 31,
+	.tx_delay_max = 7,
+};
+
 #define EMAC_BASIC_CTL0 0x00
 #define EMAC_BASIC_CTL1 0x04
 #define EMAC_INT_STA    0x08
@@ -1278,6 +1297,8 @@ static const struct of_device_id sun8i_dwmac_match[] = {
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

