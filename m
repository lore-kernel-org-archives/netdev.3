Received: from polaris.svanheule.net (polaris.svanheule.net [84.16.241.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 400A24CE688
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 16:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.16.241.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792340553; cv=none; b=d/4cC4m1LxPpC952+dvwmx7vl9r9tNFV+45Z+Zkg8a/g3s/fjYuzC8tPX88uW+fK5YF6T7PFpq884TUb1FhCBiMqeuQH3IYuit9A4LBRvFrAct6vV8FKeS3bISK1C1UOhxSZymQcVnlt4gfSc03ow6rEGL9xLMZYdvj2rNtKmpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792340553; c=relaxed/simple;
	bh=nTcwQzVmYTm1AM1FCgaobdw7AEwpJ5PD2dkwIfWaH2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DPuLu0Pdrq5WqUPR6FztLRqWxMovAqtpp2h0IwP6Tu4qxcuy+WK3IuTmfV226aSzsXMJMe9b/ZguZQvx1arW3IsMhgQibgNZKwh49KZ1bOwHS19crhl81cqBw8FrALqVbShz8A+k6YcNYd3uG4lSPFuaMjLLgyNqjMu+nezeYRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net; spf=pass smtp.mailfrom=svanheule.net; dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b=zWLdnRC8; arc=none smtp.client-ip=84.16.241.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=svanheule.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=svanheule.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=svanheule.net header.i=@svanheule.net header.b="zWLdnRC8"
Received: from terra.vega.svanheule.net (2a02-1812-1620-5d00-3535-4149-dfc3-da80.ip6.access.telenet.be [IPv6:2a02:1812:1620:5d00:3535:4149:dfc3:da80])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sander@svanheule.net)
	by polaris.svanheule.net (Postfix) with ESMTPSA id DB333955CA0;
	Sun, 18 Oct 2026 18:13:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svanheule.net;
	s=mail1707; t=1792339987;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rAAuUDUvjZiBRrJikF39Y3eo8LqEoa2iyoxYHrM3k/Q=;
	b=zWLdnRC8rdCeciXmrZoT+8p0cDvfPZRfUl5+4T9uTbIgKQAE8CfEBVW+db/48xpv8o+8Lf
	fEtDowq0ug+fi4rJM2B+AoIGxpZQcHyRFy5YEEXCsdkze6/wwmMyTuQjhCVPMrZxQVibal
	awK/VHrb8unG9I4KHRcmKWCAthT3JaaVfH5tHSavF1uJ87Hua9arrRuuXQ5c92dSd1sNMv
	zi9FeLnv2UjBYzT3oPgl+gO3MGc4d8R2NEOk/dHPDytvpttOmpuHz/hEZNouRW+JER1ZHJ
	V5auXFPbW5brd2NKgaBLf92JsPto591XPHH9+7XDvMn6T5+9Vjk5O/Fss+14SA==
From: Sander Vanheule <sander@svanheule.net>
To: Jonas Jelonek <jelonek.jonas@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sander Vanheule <sander@svanheule.net>
Subject: [PATCH net-next 2/2] net: pse-pd: realtek-pse-mcu: add gen1 I2C transport
Date: Sun, 18 Oct 2026 18:12:48 +0200
Message-ID: <20261018161248.376205-3-sander@svanheule.net>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261018161248.376205-1-sander@svanheule.net>
References: <20261018161248.376205-1-sander@svanheule.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Provide the required data for the gen1 raw I2C binding, which like for
gen2 is simply the gen1 protocol data with the native_i2c flag set.

Signed-off-by: Sander Vanheule <sander@svanheule.net>
---
 drivers/net/pse-pd/realtek-pse-mcu-core.c | 8 +++++++-
 drivers/net/pse-pd/realtek-pse-mcu-i2c.c  | 1 +
 drivers/net/pse-pd/realtek-pse-mcu.h      | 1 +
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/pse-pd/realtek-pse-mcu-core.c b/drivers/net/pse-pd/realtek-pse-mcu-core.c
index e64f13ea6e4e..c70b09ca2012 100644
--- a/drivers/net/pse-pd/realtek-pse-mcu-core.c
+++ b/drivers/net/pse-pd/realtek-pse-mcu-core.c
@@ -986,7 +986,13 @@ const struct rtpse_mcu_match_data rtpse_mcu_gen2_data = {
 };
 EXPORT_SYMBOL_GPL(rtpse_mcu_gen2_data);
 
-/* Same dialect as gen2, but the MCU expects raw-I2C framing. */
+/* Same dialects as above, but the MCU expects raw-I2C framing. */
+const struct rtpse_mcu_match_data rtpse_mcu_gen1_i2c_data = {
+	.dialect = &rtpse_mcu_dialect_gen1,
+	.native_i2c = true,
+};
+EXPORT_SYMBOL_GPL(rtpse_mcu_gen1_i2c_data);
+
 const struct rtpse_mcu_match_data rtpse_mcu_gen2_i2c_data = {
 	.dialect = &rtpse_mcu_dialect_gen2,
 	.native_i2c = true,
diff --git a/drivers/net/pse-pd/realtek-pse-mcu-i2c.c b/drivers/net/pse-pd/realtek-pse-mcu-i2c.c
index b6769ac1d470..bbded772eddf 100644
--- a/drivers/net/pse-pd/realtek-pse-mcu-i2c.c
+++ b/drivers/net/pse-pd/realtek-pse-mcu-i2c.c
@@ -128,6 +128,7 @@ static int rtpse_mcu_i2c_probe(struct i2c_client *client)
 
 static const struct of_device_id rtpse_mcu_i2c_of_match[] = {
 	{ .compatible = "realtek,pse-mcu-gen1-smbus", .data = &rtpse_mcu_gen1_data },
+	{ .compatible = "realtek,pse-mcu-gen1-i2c", .data = &rtpse_mcu_gen1_i2c_data },
 	{ .compatible = "realtek,pse-mcu-gen2-smbus", .data = &rtpse_mcu_gen2_data },
 	{ .compatible = "realtek,pse-mcu-gen2-i2c", .data = &rtpse_mcu_gen2_i2c_data },
 	{ /* sentinel */ }
diff --git a/drivers/net/pse-pd/realtek-pse-mcu.h b/drivers/net/pse-pd/realtek-pse-mcu.h
index d75e91669b8f..5e31dd0993dd 100644
--- a/drivers/net/pse-pd/realtek-pse-mcu.h
+++ b/drivers/net/pse-pd/realtek-pse-mcu.h
@@ -88,6 +88,7 @@ struct rtpse_mcu_ctrl {
 int rtpse_mcu_register(struct rtpse_mcu_ctrl *pse);
 
 extern const struct rtpse_mcu_match_data rtpse_mcu_gen1_data;
+extern const struct rtpse_mcu_match_data rtpse_mcu_gen1_i2c_data;
 extern const struct rtpse_mcu_match_data rtpse_mcu_gen2_data;
 extern const struct rtpse_mcu_match_data rtpse_mcu_gen2_i2c_data;
 
-- 
2.56.0

