Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237CF3998BE;
	Tue, 26 May 2026 15:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811189; cv=none; b=k2wULhP6BiIUUshNmB5cfKQEWuRbGEgSINu49HS4FHZ+rhRmNNUTEQasTzkLGVfjYtKb7SVsu91VCFnk/AYkYBpy1R4u9rosdbx4XlSfTKYOBdiVRaOxmeVbLIUQYhgFEU4IKcxDFMPtr8HKOEG2NSIF1RnVOM2pIyNq8hTxTl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811189; c=relaxed/simple;
	bh=FKoGM7akGIPSw8FowWmiKV+fxW11Il4gu2wmoma8xyo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dz2XINm3YxPHLMqTS+cwIE37tHpv1sjhDTrSkbMPCVZFaPBLazl5mKQA4Jp6FAT3doIn06oCSWh31lMeCYkYaPWFUtGFiyMsq62N6gcKdpvG8jmpTJLUQl4vpOHoKNUcz3ZdCrQU/yOeypTXhyJ5CS+QNp8O+HjACLfxO+Pd47g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdW+So5q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdW+So5q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 739BD1F00A3A;
	Tue, 26 May 2026 15:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779811188;
	bh=ScQLl45j0P8rRslurQ4L/r3fInntU/zRHXJvPmg68NA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AdW+So5qphp+pt/YPaxsqxBks748/cOkDMkUlKQF0iodFiWof4/1u+fVWvZRiaz2C
	 K7YBE0s2e1gXOqqxrbYf305TtygZk9+/1MAP7iO2vL/01uHhoEpMbE9E6EQmX/LzTv
	 Tx13UJgdfChQz4QAMEeqGBJiNDawTr1fZv5FEp2OgF+MlGYTxlJ1vgyKujwNiRMGeO
	 65Au839iBDCHYgOEl/yKhheKc0xiE/ORYgmm26QbgDGemYuQlUXSV8GFi0xLFeF70d
	 z7rvcZbbZ8r3uc2Im2e5KRq2szNOny7HPKEZn3jxum/foTSIvrE/0pgmWfpSuw7iLg
	 8rxAouoxCItcQ==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 26 May 2026 17:59:31 +0200
Subject: [PATCH net-next v3 1/5] net: dsa: microchip: Add fallback Micrel
 compatibles
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-ks8995-to-ksz8-v3-1-c530f651989f@kernel.org>
References: <20260526-ks8995-to-ksz8-v3-0-c530f651989f@kernel.org>
In-Reply-To: <20260526-ks8995-to-ksz8-v3-0-c530f651989f@kernel.org>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Woojung Huh <Woojung.Huh@microchip.com>, 
 devicetree@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.15.2

Because of forking paths when Micrel was acquired by Microchip,
two devices also exist with the micrel,* prefix bindings.
Add these to the KSZ SPI driver so users can use the more capable
driver.

Make the KS8995 driver mutually exclusive with this driver
to avoid probe races.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/Kconfig             |  1 +
 drivers/net/dsa/microchip/ksz_spi.c | 15 +++++++++++++++
 2 files changed, 16 insertions(+)

diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index 4ab567c5bbaf..e704ab702c18 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -100,6 +100,7 @@ config NET_DSA_RZN1_A5PSW
 config NET_DSA_KS8995
 	tristate "Micrel KS8995 family 5-ports 10/100 Ethernet switches"
 	depends on SPI
+	depends on !NET_DSA_MICROCHIP_KSZ_SPI
 	select NET_DSA_TAG_NONE
 	help
 	  This driver supports the Micrel KS8995 family of 10/100 Mbit ethernet
diff --git a/drivers/net/dsa/microchip/ksz_spi.c b/drivers/net/dsa/microchip/ksz_spi.c
index 373e9054947c..77aecac32466 100644
--- a/drivers/net/dsa/microchip/ksz_spi.c
+++ b/drivers/net/dsa/microchip/ksz_spi.c
@@ -224,6 +224,21 @@ static void ksz_spi_shutdown(struct spi_device *spi)
 }
 
 static const struct of_device_id ksz_dt_ids[] = {
+	/*
+	 * Legacy Micrel bindings. In 2015 Microchip acquired
+	 * Micrel which is the originator of the KSZ series, and
+	 * devices branded for Micrel already existed, as well as
+	 * some device tree bindings. These two products are identical
+	 * to the same Microchip products.
+	 */
+	{
+		.compatible = "micrel,ksz8864",
+		.data = &ksz_switch_chips[KSZ8864]
+	},
+	{
+		.compatible = "micrel,ksz8795",
+		.data = &ksz_switch_chips[KSZ8795]
+	},
 	{
 		.compatible = "microchip,ksz8463",
 		.data = &ksz_switch_chips[KSZ8463]

-- 
2.54.0

