Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816481;
	b=VHdBacYY17r5Es/ifrshtWh6tKr7zqxht2piVQRPsxI86uUG+JM9bC7b/8f/CwCR/Teo
	 AxGuvkRt86/7w+VA1HWxs9L91b1vIDx9SNnsdUmGYZ6CwR766ZjgYd+Iz+KoLPYMSL3cX
	 itH3eM5wG/AwCgG0DscRfx24UwAosEj0mmedfGT0BmwWuPtRS1RLszI2bo7LLh4dnujtC
	 gqsf+OW2PFCUMlloTG+nrWdZwi1MOgKNRFca/hwJZYBzZIh4cPGhRghM/j+7mZh3P51Hd
	 zKBBOzML3OBVK437yw1U2RN7SHEKatbv4Iq6tGU/0ITP6bKcwQugDot/LpNrv/GYEQA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816481;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=A/vQp4Ob6tZK/MQFMF+LZw+BEhdevGHfoc7PehuPwmo=;
	b=oKRziWyrI2WnF407Gxkr51pg10LQBRVyYEggvE/JWeKZx8/WpZp/B/Ee7buERO9L2CwL
	 uGpKZTCUByeT6ZaOwPu8DbVa9ZWd3vL6WchSH0FHMupAgTRtBN/jYeBEifg7C2FTxm48n
	 9AcUUr34Y0tHF64SX0UIF8zs+ULp/ZV51zIpFlsyam3j9eSDy1OocmzpTHXobV88LKcIF
	 rxmE2FFscNBxqsKJUJ4rk+YvSO9g6qV3diEgCHUJqPN3fvtpqgVyP9E1G36AgQW2mpCPS
	 td+ktoTGdUvm+p/JkBNbfwmdE28e1ZTOCN/wnn/i3ALIMkpmXY/J3LNfarz3t1CcKrA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RwbPKIq7;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F6206083612
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 18:21:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F6206083612
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RwbPKIq7
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48e0d885929so840329f8f.3
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 10:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793816480; x=1794421280; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A/vQp4Ob6tZK/MQFMF+LZw+BEhdevGHfoc7PehuPwmo=;
        b=RwbPKIq7zMTbMLWlLYHeKDbhMe+TJSa8Op8YyT7vKpp+3wU4OAdCesEoDRWgVqkKXx
         ldR581ZfsIBClZ33PESVj6+InSbkRoRX0J9zRkxulpzh0xdJlkU2bOBt3NSmPaSLwQR5
         2ddmljiCAQ8rwDjfByTOiH5RxRdr8ghOzfIpJ0UqLWH9atfuAxT0InbkCDtbHTtHAO8e
         OfhQCRXS2m0W41ufCJvtIHRCZzBfffSgtsx9O/fgu6iCkSLBaiSGRo1709m9aLaTi5GN
         Ch8TET5QSaoltqkhw2ma1glWmm3uTQpmY5Z6xZNSM5q79TqtGAxAE0bsPdV4xDYJAvRp
         vvKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793816480; x=1794421280;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A/vQp4Ob6tZK/MQFMF+LZw+BEhdevGHfoc7PehuPwmo=;
        b=HbtO8vilKu2rhRxhU9pGavGPWPg3B075I+AtgCANYJs2BtkNGw3eTZam821cjMhQjb
         LmdNqa3hZE7qfLUdd3L56An1vGzR+FrXjeEPlasY7+8OEoNM8g5B5xu4X4PMLAH7ZiOJ
         5rgyjry56dSBSv++ruqTx9wOepc4ebKaQKlwBcOXPc2rT22ueULTNsOArpI0heOEdz3a
         EzHzX558216VCuKgNxzoHRKL2jO2QILI3GpG01Q7L3jG3vOaT7mEmpjR6u9O9VBjtCXk
         jU4sGQdcqJFh7jUNqq6UAadAm4fpHNK2rWrnkGmBVtQ8bAJr4ZrU/e23DvhfEI6mhltP
         h4UQ==
X-Forwarded-Encrypted: i=1; AKwUvBzcop3PvkPhLq/911E9S5yIysJqtWYECzze2887uy8J86nhwBU6fPT1kPE8Z0tkAuGF6H2n7sk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9btYmzk10vNxz+jm5bAiHpB0zgi85QuLHO+2KYMEqkBmpZB/Cc
	yQzx5LJjjZ0dw2PQqVj0q+CzP7y2SwQdo022xxT4RRivToubhA7z/8DT
X-Gm-Gg: AYBFou3rMn5Kt099JpRq8Orj+OvHsZQ+fYEFPE8MXAHQdGirzUbj7UvzdnfHFnYv3yi
	ScWvHvUse2j0fWQQQ21XTfkzMzYQImSsAOd3MLDSRA5dxCL9LUybn/CRwtgFy0DGWpy/4GUZItG
	aq93XA8UN6rLAYfP7fVtXA538Mp2QHStx4CjrxZn2e5qav+SrSGcDuaO77XjMPCEl/MgwIz/XCg
	Tuvuhj+dxiMDoEYvPd6YJqRWpDsMS8zHYFmkpH5waEiUQ++X2jQy8giEK+kVHWJWLAGWUq2rMwW
	hvOrK5th15QbmJ5hgwQTlt49Rk5H0WwmDrpv/bRKg7cV+mKRh5gFXS8JUuDoAH/Xy0eujc8T7nb
	jlD3UZ8Ttgo8g3gb2VTi+uHVhqCf3OQqtpNt1/BdOGL+srih2Wi6P2ZMKLzK3+hUAS0okMyhXIb
	u8Alsf1CyrMnnVK3ZRnZbx60jrCFz1UEqQdQifB72/9ubHlTWCR6WywOVD5Oq2ObCEAIsn6N61C
	QfjXUoPFjtyWg42GKPZG/Ehv2b+YZyEiZu5k6FJz6NM0U+ZOIehljujIQT1Bxvx9SrK5XHC1yU1
	v0Qy+VKAOTODuZuF6yn/XDmh6tVzOqGc0XOsMf/jJS+zlt+t8lEYqC5TeA7hBYEzE8yTwD5WMGS
	5oG/h0j5+yRFg+6tx/nwc1w6TRMMJ07yVSQI0IQ==
X-Received: by 2002:a5d:584d:0:b0:488:8525:4979 with SMTP id ffacd0b85a97d-48e6e50b5f4mr35431995f8f.45.1793816479972;
        Wed, 04 Nov 2026 10:21:19 -0800 (PST)
Received: from iku.lan ([2a00:23c8:254f:fd01:b079:a2f1:caf7:b446])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed0844e2sm4073202f8f.28.2026.11.04.10.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:21:19 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@linux.dev>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next v4 08/14] net: dsa: rzn1-a5psw: Add support for optional timestamp clock
Date: Wed,  4 Nov 2026 18:20:56 +0000
Message-ID: <20261104182105.1102555-9-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261104182105.1102555-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261104182105.1102555-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Add support for an optional "ts" (timestamp) clock to the RZN1 A5PSW
driver. Some SoC variants provide a dedicated clock source for
timestamping or time synchronization features within the Ethernet
switch IP.

Request and enable this clock during probe if defined in the device tree.
If the clock is not present, the driver continues to operate normally.

This change prepares the driver for Renesas RZ/T2H and RZ/N2H SoCs, where
the Ethernet switch includes a timestamp clock input.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v3->v4:
- No change

v2->v3:
- No change

v1->v2:
- No change
---
 drivers/net/dsa/rzn1_a5psw.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/dsa/rzn1_a5psw.c b/drivers/net/dsa/rzn1_a5psw.c
index 9daa5d8245df..846216f22bc3 100644
--- a/drivers/net/dsa/rzn1_a5psw.c
+++ b/drivers/net/dsa/rzn1_a5psw.c
@@ -1212,6 +1212,7 @@ static int a5psw_probe(struct platform_device *pdev)
 	struct device_node *mdio;
 	struct dsa_switch *ds;
 	struct a5psw *a5psw;
+	struct clk *ts;
 	int ret;
 
 	a5psw = devm_kzalloc(dev, sizeof(*a5psw), GFP_KERNEL);
@@ -1245,6 +1246,13 @@ static int a5psw_probe(struct platform_device *pdev)
 		goto free_pcs;
 	}
 
+	ts = devm_clk_get_optional_enabled(dev, "ts");
+	if (IS_ERR(ts)) {
+		ret = PTR_ERR(ts);
+		dev_err_probe(dev, ret, "failed get ts clock\n");
+		goto free_pcs;
+	}
+
 	reset = devm_reset_control_get_optional_exclusive_deasserted(dev, NULL);
 	if (IS_ERR(reset)) {
 		ret = PTR_ERR(reset);
-- 
2.56.0

