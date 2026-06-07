Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B3F2F1FFC;
	Sun,  7 Jun 2026 22:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780872105; cv=none; b=d6F/J17fIcINRo7RtiQNhLYzfkmRXbWgGKDF5Q4oM0icRDDKofXmY2GZFe7PpGwI8pcoGwO4KFMYVidN5ZL2+81PNXInd8R2lqNvDpTYGbJB5p+8O+2Caw6/gsuT2pK72hUWAxWu/Ogcm+PQC+nGSNI/psNZGCvHopqgO/ue+bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780872105; c=relaxed/simple;
	bh=BifGpaOg5XZrQzvVB2o5ei3lOIDNjG9z9BVx4H29PYc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RMgq9WrKBUXMS2VtoxiEwYUF5o+P5YRvfnCGfhhTEIbu3MF0Hwl+LllAKOt1jk3y6xKlHyNObpmWXIvimLLzxrli996ieMKCnAAjv389cjYLycnywEWwcS078FtLNaLrGKaZTctiitEiBucZB8nC54PQaSTOb+V0SnDj/hX3/zQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuLSOF15; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuLSOF15"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BFD41F00898;
	Sun,  7 Jun 2026 22:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780872104;
	bh=05ZbWYYW4RjjQ6p3V7sBtDHHa/eUPxq6EJ99nZ/1k5U=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=JuLSOF15OAguzZWl4YM9pJcoZ9HipYRK88QqGoSNlSPDrmmVfFdRKZTdaYbyHaR0r
	 4sYB3kjzoqTW6FM3yl1++urzZyCUjoBh3br9Ud3cHLdknPsWIJuSbvLZc2Pb/Hf74+
	 oRUGG1J3xtIDp2DJZSKc42269rW4dbcxzMjzluvxdfmFEbA/ws8XEh8cVkYUEWdSAL
	 ngOuaZ6rBwD4k4JA6js6CuV1bzfXSG7TU4Cy3X43o5XZ0tMOtLE9BFA9l5UbVFdBs3
	 /rhs81zjZywuvqtqUX7yHpXihgPLdRkuVc0q4GKcisee+MD14tMKSMz3uKHHvCXEjy
	 IpNkipi/cFO5w==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 08 Jun 2026 00:41:29 +0200
Subject: [PATCH net-next v6 1/5] net: dsa: microchip: Add fallback Micrel
 compatibles
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-ks8995-to-ksz8-v6-1-d91eb43edcc5@kernel.org>
References: <20260608-ks8995-to-ksz8-v6-0-d91eb43edcc5@kernel.org>
In-Reply-To: <20260608-ks8995-to-ksz8-v6-0-d91eb43edcc5@kernel.org>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Woojung Huh <Woojung.Huh@microchip.com>, 
 devicetree@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 Nicolai Buchwitz <nb@tipi-net.de>
X-Mailer: b4 0.15.2

Because of forking paths when Micrel was acquired by Microchip,
two devices also exist with the micrel,* prefix bindings.
Add these to the KSZ SPI driver so users can use the more capable
driver.

Make the KS8995 driver mutually exclusive with this driver
to avoid probe races.

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
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

