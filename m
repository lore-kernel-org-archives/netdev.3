Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750C5403EA1;
	Mon, 31 Aug 2026 12:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788179807; cv=none; b=PAIIkGvgcAzfIHyYo348di8v2oKMTEV80SYwkD7IY7Zzd3EalbkJ9RxVIgW46A5ZjZaD/yI0XbXL69nuXaQY3MR+33SrquJDlBagvHTIsJFi1U0I2lHuPbbadbEKosDeW/IiqTI78++ovfVrowgDPY4mWeKNP+/34jR5aXqzmwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788179807; c=relaxed/simple;
	bh=Gw+u0LXkGgs1JPZGWf+p8sA03mNxLaNqPD9a+wID4rU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V+nx8ETIsIBUMTpG3UAt9gdRPAXagSaXywxO7dRH660V1x9WyAWY0lIgdecuLwfcMiBbztUtfoy7NxTIdTBXEgLFbcW3cxs4YN4KTWNXOw3tJCf7VTQw0305f5k2MQEMukqV9rsrWZjL53EgL2cdyBMUUhQdC7vZYJ90XTbIpV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 4FA5920247C;
	Mon, 31 Aug 2026 14:36:38 +0200 (CEST)
Received: from dude04.red.stw.pengutronix.de ([2a0a:edc0:0:1101:1d::ac] helo=dude04)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1x11Fe-004G6a-0g;
	Mon, 31 Aug 2026 14:36:38 +0200
Received: from ore by dude04 with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1x11Fe-00000002nOX-0Usp;
	Mon, 31 Aug 2026 14:36:38 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Linus Walleij <linusw@kernel.org>,
	Luiz Angelo Daros de Luca <luizluca@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	=?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin.sipraga@analog.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH net-next v3 3/3] net: dsa: realtek: rtl83xx: use dev_err_cast_probe() for reset GPIO
Date: Mon, 31 Aug 2026 14:36:37 +0200
Message-ID: <20260831123637.666457-4-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831123637.666457-1-o.rempel@pengutronix.de>
References: <20260831123637.666457-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the open-coded dev_err() + ERR_CAST() on the reset GPIO error
path with dev_err_cast_probe(), matching the reset controller above and
staying quiet on -EPROBE_DEFER.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
Changes since v2:
- Added this patch
---
 drivers/net/dsa/realtek/rtl83xx.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index d6d243131fd2..8121ec12fd8b 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -212,10 +212,8 @@ rtl83xx_probe(struct device *dev,
 					  "failed to get reset control\n");
 
 	priv->reset = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
-	if (IS_ERR(priv->reset)) {
-		dev_err(dev, "failed to get RESET GPIO\n");
-		return ERR_CAST(priv->reset);
-	}
+	if (IS_ERR(priv->reset))
+		return dev_err_cast_probe(dev, priv->reset, "failed to get RESET GPIO\n");
 
 	dev_set_drvdata(dev, priv);
 
-- 
2.47.3

