Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CD636DA0B;
	Fri, 15 May 2026 23:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778887001; cv=none; b=XpoOxucJlbmQ7fcCy5//3O6PsIBBC00/U+/n2ONaYlgR7zzZ3TOEtlUo8J0SepVjK6QfD8I/U4JxjJKaYZM9Y7qRdit+Gzz7FHsDch6q7bvKxDac0ovJi31Ke1rHkrj64p+LesYCQc08rfdVxkuijFcv7EIkkDn1lFhsTPWE8VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778887001; c=relaxed/simple;
	bh=6sZq2IJKNUrXM4hv2VWy7/L4s6ZDgiOimXZMV4PL8Bo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=J7da5ArdB104jOrURrIAlXU+JqcaPGPFMVGV3qGG98itsesbyiasImLdX0FaBxdWSi8Yc/dc+ApLHTzOUpg5s4kA0/tyFpHIhu0Af26Y53Exak419dqRWegC4VFwEjoE7WbETJbJEZwZ6LlHAg1h9feqggACY9yBeQH8toObqnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=on9AFBSS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="on9AFBSS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BBA3C2BCB0;
	Fri, 15 May 2026 23:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778887001;
	bh=6sZq2IJKNUrXM4hv2VWy7/L4s6ZDgiOimXZMV4PL8Bo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=on9AFBSSGXMy+LiIzx47iZwQfpdFF5qzUR23Hn3cRZP2ZWrqo3774SqL6ZUSnjOfv
	 dvTGSX3TLwuPhbf6IkKHCEIv6UUTbbERMc8xlFXTRA405UDZJcpwafpLX+PQ7xLZSv
	 UzsTkyYlNoTJ9CMcQzJsNNY6/jWT5P95pS/jq9W42ewIV+1vlfZM6u823WxVOK1VmN
	 QrGWcN/ckvgaRbdQc46Xe2lLG4BYYBjxAKzBW2Jy/hwQ1sJyFev7D6p8eijKlz3ucq
	 duHjQV/aWnxRSzt8uuvmcKGiWb99hOgl5hJVLjGuIU7yfdtQ6uYCPCAxF0/NGE2xQ2
	 W0LyTmHe+MtfA==
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 16 May 2026 01:16:13 +0200
Subject: [PATCH 1/5] net: dsa: microchip: Add fallback Micrel compatibles
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260516-ks8995-to-ksz8-v1-1-70d0ef4aa5f4@kernel.org>
References: <20260516-ks8995-to-ksz8-v1-0-70d0ef4aa5f4@kernel.org>
In-Reply-To: <20260516-ks8995-to-ksz8-v1-0-70d0ef4aa5f4@kernel.org>
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

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/microchip/ksz_spi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz_spi.c b/drivers/net/dsa/microchip/ksz_spi.c
index d8001734b057..c38eda65aaf2 100644
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

