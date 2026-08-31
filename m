Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3979A4CCDC5;
	Mon, 31 Aug 2026 20:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788209671; cv=none; b=o+MOAqLhertBS9YNWtrJaOLdJzscr39oVE+WMqNtX3t6VeWQLj/UHP8UQHxU/r9yGARokh89sZAllUE9bMGkT0HwdqI/ioKeLpAShpOCJRL5Ra5+de1uLf1HcOz9lyXmEdRsLxQ7qhgan2D5tkt0aYpQIc+FwZEkiSq/QX7F8DE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788209671; c=relaxed/simple;
	bh=LvzVPJUgFXlTiWHBSSIvP01vxWxRhB+koWRTg4qQqHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vAJyefEY8od9Jbzw/hKeV3l6dLCGl6Ls0FoL8/TCip1yvLvm2bBZVNeblECqjsG7rDYdmZKbvLPjeD1Ak7Yd8NxYIltnFe+b2OOI03658QZx6dLDWpZpwRTRtjXeWm5tFQ+SzUcRQkDe0bjhIz3+zflgg/WQ6Db936HJX6R4u+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J8KCQpp5; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J8KCQpp5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD34F1F00A3D;
	Mon, 31 Aug 2026 20:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788209669;
	bh=SdwTgFiM0z0cwtmBvDpBQCvE64wHKOMzNqBnWngyDFU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=J8KCQpp5aTplgudrnJ0Flej4AYnUHz+zOOboHFsxbdx0CmHW9bW1XDLfcumA5nxJq
	 L80A5vMzPwfqoOOh+XlO3CdFXRiVqE/BrjkiUuKIfe6vT2jo02FGp7q0Jl4Q8lrmxE
	 XzMoPXAqsIr2HbpwOUCsG0iNOkSjVlFsXBZL0skgWFoksruAt5nh/1pQ+AeZ8I22Na
	 772JX3AjdcX1QIrjc9VDLJwJenMoEgoImCgSSet9kV1Pr9VpBnG8RQEhYLAPMVT8iP
	 vHC9GKBvLUjoTsQHLkjvV14sTFN4R9eozddOylahlGr3CI2i3/w1DTTe2nvXIENox7
	 9XpE1AxgA0zJw==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 31 Aug 2026 22:54:17 +0200
Subject: [PATCH net-next v8 1/5] net: dsa: microchip: Add fallback Micrel
 compatibles
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-ks8995-to-ksz8-v8-1-fd1dbb2b76e8@kernel.org>
References: <20260831-ks8995-to-ksz8-v8-0-fd1dbb2b76e8@kernel.org>
In-Reply-To: <20260831-ks8995-to-ksz8-v8-0-fd1dbb2b76e8@kernel.org>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, Woojung Huh <Woojung.Huh@microchip.com>, 
 devicetree@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

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
index 676fb7dffe14..68fb175cc36a 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -110,6 +110,7 @@ config NET_DSA_RZN1_A5PSW
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
2.55.0

