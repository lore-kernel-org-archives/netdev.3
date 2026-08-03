Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A22394788
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 05:15:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785734127; cv=none; b=lnl+4fxaDIZeV5MXOqJIvEZj1Edd7ohBIBKz+ckqc+mYYp+caD9TTV24GAxg+ipLPq/Ds5yodBoMlLixhDEKe1O2jAmnmobSV4Yq66plTX4DSljJSDBNATH5hE5WdgYkOK6zR6yuNZNyFu9eBOj3fWiOoM5ek1RTHSkHgSyEt7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785734127; c=relaxed/simple;
	bh=zKmrq4Io78YBlcSoFkA6zgzyWtU0hC2kx2tv6Vt1nvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KNoM80efZesYcxLmB5SdwWrtzvX9lMcb5tLRnb88gCNG7ZxEk2Uu3PvnEgGKgBpnJTAzu48BOfU/YK2ZDkSPtNBq962d+Abzd3UYnAyrTfpZ8yq3iGz0OocHDnRu3w7w0yUG2SBEADjjQxB/3RixhA+4oEq0lnZfF073ptmvPfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OcUyBTb+; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OcUyBTb+"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e9f1f24cbcso2864739a34.0
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 22:15:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785734125; x=1786338925; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=gb4LPnphqc1DtduXOsyl640sXOpfiOxS2LbjD6EtoY4=;
        b=OcUyBTb+IsVTddm4rsemLEj85G6IrBXOL6D10illYE2gPVN2e9VhriVSKAf0Kgm9PK
         A5Wks3/evRitsX/YBXGdlB1Ax5lAVpPLH2ovk+oArWH5ccIsVPp8aIE+pvr/1+SU0ZPd
         NeDg6jocHG0LyQtI5CT4HDvc108ubt7KP+NGUsU5VPg0y8001yibPvbwH72iT3JmUVPp
         GlR5hA99dv/1VUHUUP737b4ZKOuk2ueTvm4PYvJr0S+sqD0FdZhkEVssBMRR2dlI/Vu+
         jUDJxMwr4wJRqftTfElMM4Hy64M2NiLg3J+PYOny18JcEPb+E7lBnaCcTm2Xstljw8kl
         JYRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785734125; x=1786338925;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gb4LPnphqc1DtduXOsyl640sXOpfiOxS2LbjD6EtoY4=;
        b=XTugJsxm4tQ+rKjnJPdXE1c4ZeTW5A5HXTBNMDo9nqtkndjCdDO34zxNmfTEAgt4YA
         +b2bRwU3sU0JiwaDwFVf+c0u7fjIWWR4cySMStZYECEQyD8I9ZiuQ4p9dTJJTdIQm443
         WVmjxUiSYidWSSLubM2QuQCWlCQZE41RkYpPLnAVPdd2Kry42cs7N+HBx+6mrUxVuEJi
         aANlr6U2eJlVsqHGFo4TQ5sHJb8gh8vD2eEAiOvFsTALQDirV60WJ0u9qjoKyigNni2h
         4CY6FRAKcbaC/TV9kkO3rgaLUkQwwxj+AN/8LOJBEAHc+YOLeU+HHeaDJuUW4DlpLVQj
         RKwQ==
X-Gm-Message-State: AOJu0Yw0Xd7N64lLKOBj/pxfcGjJK8fRxtcUn6GpGTiO5STkNSn/PMvL
	b7S7T7lKdyVY/Chb9WQorJtAFmj15ISqUtLu4m/3w5QQ5zT7sj0YN1wc
X-Gm-Gg: AR+sD13UxHiIQP7sxSJYUdo0Jx98SN654nfMMQDaRH/YJWGBoDShDAkw//2gtBkVYXp
	feS5spD4fLYBa01PVAFrsVw2eqwunQgHmHz0emgscJF9Iyy2Wgq4BN5abg6Fh9I+jVukE9rka2i
	depsXbYOSyazLtCO/9eLMTdDAHQDxbhdKQfMOjENi5IvVEsiBIt8PVsdovojjMqHS3wKAziu7wM
	1aPdXw5vqH4drrH6mxOVX4tlu0W1t9mFa8O2AkSTftZCm+rf/Ju/JGVCrI3Y14VlYnzxhUZfv2T
	x4V5KL4VSXXjdtaxyl0r14rEehQukNVog1VZegkbaTw2OECx/UoARc1hTuYiXLA+JucIeBYfWHm
	mP7Och/S53/wHUYWj8NM1/SmjmrsGeEMHjgnxcrQtfwqCch5y09P5QwuFzkGxIc/3jixQLJtb78
	YeJAjXL/OCJShR71CzBqyzYN8QO88Z7NCkjBykILwq/btpJw6mWSXS4Yl68nvL+xFCOtRcSYi3K
	+x5w3mcK6u/4gykAHhmOeppf+4Vo69EzYM1FmBFT3C0czjgBb/Mn9ULysU+Y16Xj3QBda2SrT/h
	2ZelLJMbzfntJQEeqlfvG0ne7BSZOUHigPfqiUGumXzUuIGqQ3apb1oFEYvVTtgmkWGSO3Jw6Ss
	SFfLs4eYLX1gSyRKmpDakd4/HGg==
X-Received: by 2002:a05:6830:7086:10b0:7db:a297:9e62 with SMTP id 46e09a7af769-7f1892c8017mr4283606a34.8.1785734124209;
        Sun, 02 Aug 2026 22:15:24 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18f07a5e3sm6787108a34.15.2026.08.02.22.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 22:15:23 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 02 Aug 2026 23:14:13 -0600
Subject: [PATCH 03/21] arm64: dts: allwinner: h616: add EMAC1 controller
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-submit-acx00-of-dynamic-v1-v1-3-0a53cd9e21cc@gmail.com>
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

The H616 has a secondary EMAC controller that supports only RMII at
10/100 Mbps. It connects through PA0-PA9 to an EPHY in a companion
AC200 or AC300 package.

Add the EMAC1 controller and RMII pin group. Leave the controller
disabled for boards to enable when the companion Ethernet hardware
is present.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi | 30 ++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
index 90fe56a1d3cd..6879f27c2b2b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h616.dtsi
@@ -432,6 +432,14 @@ pwm5_pin: pwm5-pin {
 				function = "pwm5";
 			};
 
+			/omit-if-no-ref/
+			rmii_emac1_pins: rmii-emac1-pins {
+				pins = "PA0", "PA1", "PA2", "PA3", "PA4",
+					"PA5", "PA6", "PA7", "PA8", "PA9";
+				function = "emac1";
+				drive-strength = <40>;
+			};
+
 			/omit-if-no-ref/
 			spi0_pins: spi0-pins {
 				pins = "PC0", "PC2", "PC4";
@@ -789,6 +797,28 @@ mdio0: mdio {
 			};
 		};
 
+		emac1: ethernet@5030000 {
+			compatible = "allwinner,sun50i-h616-emac1";
+			reg = <0x05030000 0x10000>;
+			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-names = "macirq";
+			clocks = <&ccu CLK_BUS_EMAC1>;
+			clock-names = "stmmaceth";
+			resets = <&ccu RST_BUS_EMAC1>;
+			reset-names = "stmmaceth";
+			syscon = <&syscon>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&rmii_emac1_pins>;
+			phy-mode = "rmii";
+			status = "disabled";
+
+			mdio1: mdio {
+				compatible = "snps,dwmac-mdio";
+				#address-cells = <1>;
+				#size-cells = <0>;
+			};
+		};
+
 		gpadc: adc@5070000 {
 			compatible = "allwinner,sun50i-h616-gpadc",
 				     "allwinner,sun20i-d1-gpadc";

-- 
2.53.0

