Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A063CF690
	for <netdev@vger.kernel.org>; Thu, 26 Mar 2026 09:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774519061; cv=none; b=LiAyWL5R3T3IHgyQCAJSdIlHVopAx1XAfSETQ2FasiPzORw3iX6Ixy5t8u08Hcrx3ypwmM5TB28GpbusOvV9dI0FlXfrleo+pkHsir5DYsccg+JbaKVsFf1oSgaB7a9x+6mZQ1MOJ0TFNIT/0Nn9/Sr93qxTvXbqudUEH5fVEBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774519061; c=relaxed/simple;
	bh=7oPBKguAKyH7WnMj3zdgXhOmQH1jfpd6i6zeMQM7eGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pzht1LAa3zRCu0t+R68dE09F9IEhgWOxI3oajgJ7vdXKzj8cqEHxsoJLFdZTtPyJEjWOr+FoRFMVQhHncdl1ScWx1MYtKeLngtfBz0uS7FI7cV7MvaFgAwV2YCh21KFaruV1LNNDCZXYDX9t8nSYVkPp5U6escT+uR5JdwAmVcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sQ+zf+vG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sQ+zf+vG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66FA3C2BC87;
	Thu, 26 Mar 2026 09:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774519061;
	bh=7oPBKguAKyH7WnMj3zdgXhOmQH1jfpd6i6zeMQM7eGk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=sQ+zf+vGSNbsdnG9JiZB6mzO1J5lHY8IilTS177wLcn5dTz6TxFiEdujSPC5f8ItB
	 kzY/l194rO5g9yhUZjH5rMc7wxk2Y0UnB7rGqIHujsYMAhGK40AwbFFzTsCIRk9nDU
	 rOBj5/040blZG50CK8JoIIOWi9xLhWHRYDxa97GrIQVAmp2/ApKOpFVnvuLgMa0pzH
	 LIw549tdqr/Ygw6rDGTdTcPlpN8WsN/jdFqpkXmSNk4Ryd7bPWZlfa0d4v637VNtll
	 A6XE+Jhufy+7Fs4jVPQ9FjLhPRJlgySaQUbjtjDKmxz4BLf73HUA+WG07GcrQUv5mY
	 aUJORSGJmV9FQ==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 26 Mar 2026 10:57:33 +0100
Subject: [PATCH net v4 2/4] net: dsa: microchip: Add fallback Micrel
 compatibles
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-ks8995-fixups-v4-2-989abba8f077@kernel.org>
References: <20260326-ks8995-fixups-v4-0-989abba8f077@kernel.org>
In-Reply-To: <20260326-ks8995-fixups-v4-0-989abba8f077@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Woojung Huh <woojung.huh@microchip.com>
Cc: UNGLinuxDriver@microchip.com, netdev@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

Because of forking paths when Micrel was acquire by Microchip,
two devices also exist with the micrel,* prefix bindings.
Ass these to the KSZ SPI driver so users can use the more capable
driver.

Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/dsa/microchip/ksz_spi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz_spi.c b/drivers/net/dsa/microchip/ksz_spi.c
index d8001734b057..e3bb1ccf2331 100644
--- a/drivers/net/dsa/microchip/ksz_spi.c
+++ b/drivers/net/dsa/microchip/ksz_spi.c
@@ -312,6 +312,21 @@ static const struct of_device_id ksz_dt_ids[] = {
 		.compatible = "microchip,lan9646",
 		.data = &ksz_switch_chips[LAN9646]
 	},
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
 	{},
 };
 MODULE_DEVICE_TABLE(of, ksz_dt_ids);

-- 
2.53.0

