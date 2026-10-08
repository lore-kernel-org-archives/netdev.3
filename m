Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8552DA768
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 19:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791488428; cv=none; b=ts3gH4mZ8j2kDsw7dawU/Xswa5t8Gr4KegaOM6Q3CPE1rZbLv6T4OZhBN3nnYb5jXHMKjMCArZB8aHJ+pLQi5byZxsg4tDQaTRSOXaix7G3P9nNAOG/rit5+jJBFKponiBaFbe6PY8iccPwFQPX1zBppM++OimkSZaPVmVpFqyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791488428; c=relaxed/simple;
	bh=igs2tqHF/e5m1TR4ZJ1BI1cUnIOjq3NYwvi9hVUtQZM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ry+vfqZ3ig5Z0hQitLYVb1/FDfT9EODVzb5nScxc1DAobR8imxgyThNRKOBfyTlrdg59MK03xvrqXhXDZlzEwa+Y6w8o+NKOyaFPAtldMlSZYVZelu0UO5SDpqS9y9vs9CbjvCD6WQ061fb4m6Qa7NUEul49mDbPwCS6u9S8Dkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Elsfa47l; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Elsfa47l"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49ff680331aso62241895e9.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 12:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791488422; x=1792093222; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aUKnHWhbwjMVr4mKYh743dRcYI9pzvORcI6HHWVVZSU=;
        b=Elsfa47lVla7MnQgVv75UOBcFni1CLI3II73VKfl3GO3AorOPznCySjgjUJVkAtpI8
         kkKAREzqVCaIn6ql/p3YXyhCP4R1K9o5B93pW9jYp5fx8BpjeJn1SlSz82EJIFPk6Tqb
         f9B7EfbntFnwRWkdPLfZ4Bq49zvwY3/bttkWsFQKaeF36ince10sVwIJZHxFebH/CrO/
         a/u1vdWGTnrx0OnRj9g7y1mqetnj/CfhrhiH6W1CVUBHcFzP6C0B0opw0y3OV1Xq0oGR
         M9M3gQzd+oqjXo9hzlp0+Xq4hDlrb0nC2XqJ2/QOVtfduLDkOTwU/vjHdhsld+SPPGWm
         CgKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791488422; x=1792093222;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aUKnHWhbwjMVr4mKYh743dRcYI9pzvORcI6HHWVVZSU=;
        b=rJKOFww5VV69ai3XANNbiDvIZQdfGNJQdhy2jkM9zhsa8wIUKt8UfRGxaInw7lA8iY
         m77N+bNPqGjOkj1SYIN1FSMj2zjBjHgct+V4y1eo6YuP4cAjyU6y+VC03kkzYxonMH4p
         MNMx5yhZ9rxRjW6FbRlTYv242H9MEnl7QL1UqLfvuP/UHVnft5iGG/Nes1DWwQCwLr5a
         zB2bdsdoit4aSimoxl7TjYEAVmFQYX+sQTj9bxnJA99erAehI5+oUgJoUd2lERVyvn3x
         MXHn3LmBxIkTXn4wTrtCVO7kOcwRNWck1mAXCLa6KEv79Z2sGMu6ScHygYWlxpapgNkV
         fVIA==
X-Forwarded-Encrypted: i=1; AKwUvBx1jsf5UwgjK77XwjuDllUbVUkjVEa5JkzPH9kPyXFfs9RuTxp0vHuOqCSvVQtY83yXoIwdxok=@vger.kernel.org
X-Gm-Message-State: AFuF++lhecA6El7fURWqkEEeojqwjoyMN/QaJHcQo8/fDOJXEUZyjEvD
	ITeG9vmgqZ9Tumza0/Z9h63oS5T6aIbuqU4cf/IFrAPscSjoKX63Ulmx
X-Gm-Gg: AYBFou20FZ/ShLcG1Ei8Lo9ykaTK66YCLf6JYRTPL8njdKIoQWbyDi93m6F30BsxTbN
	pJeT4h9MVT2QQABrL073MzT/sSpJwikwmkaxJzyMVAMBiRwSzdKWxkEfoMH4zDiBL5lAQ+h96za
	RTbnbwvz/hO2OUvXMnLKfj39lF9VGusAGxgc8o2QZlVYL29wNP7F7cEweHYTJqolr60JEHwG+1i
	Kd3ryBZn2zFXbmMmGYGUo8SyrT9ACM7G96vnkVpC4lgrPlmOXWL3FoApwTwehQOrghYoGOfdokb
	0eCTiw7bPJs9F0/6aYANsojHvf/uqlOjAQsi/y00TFZitThOsRNOgv9F32Yj568jYeiCeSTiSwR
	1+x0t/xIKKoO3kbZPvOFgGLfa8wKrMoc1MafFL+PkOR40HQshqGQMnc0B3sYdBP2q0uuILQWuJD
	Rlko67RRGQNx4x7U2KGEU7BgIpmFlkZGuU/I0eXbj4gBSI1SlF0vsfd78Q9wX9FUdPOKyHiNw2F
	lIDeRCnz9L8OR0qL2SXq/a/9SeYPFUuJjVZ2wmCXSwkobNCcY18VEM0EnH32fEB9zJXn/XCRmOw
	60OWxQW3osGni9XvkbUUdQ==
X-Received: by 2002:a05:600c:5252:b0:4a0:4a8:d444 with SMTP id 5b1f17b1804b1-4a1806878c3mr107026915e9.33.1791488421519;
        Thu, 08 Oct 2026 12:40:21 -0700 (PDT)
Received: from Lord-Beerus.station ([31.27.155.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18c1e33d2sm1419065e9.0.2026.10.08.12.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 12:40:21 -0700 (PDT)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
X-Google-Original-From: Stefano Radaelli <stefano.r@variscite.com>
To: Frank Li <Frank.Li@nxp.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: pierluigi.p@variscite.com,
	Stefano Radaelli <stefano.r@variscite.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Shawn Guo <shawnguo@kernel.org>,
	Joseph Guo <qijian.guo@nxp.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Josua Mayer <josua@solid-run.com>,
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	Mehmet Fide <mehmet.fide@screeningeagle.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Maud Spierings <maudspierings@gocontroll.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH v5 04/13] net: phy: micrel: Check RMII clock select property presence
Date: Thu,  8 Oct 2026 21:37:44 +0200
Message-ID: <6271eea14eb6ef93031921cedc12d87cf5e25595.1791487179.git.stefano.r@variscite.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1791487179.git.stefano.r@variscite.com>
References: <cover.1791487179.git.stefano.r@variscite.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Radaelli <stefano.r@variscite.com>

The micrel,rmii-reference-clock-select-25-mhz property is tested
for presence, but of_property_read_bool() warns when the property
has a value. Encoding it as <1> to satisfy the DT schema unit check
would therefore produce a warning at PHY probe.

Use of_property_present() for the presence test. It accepts both
existing empty properties and the new numeric form without changing
the RMII clock selection.

Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
---
v4->v5:
 - No changes.

v2->v3:
 - New patch: use of_property_present() for the RMII clock select
   property so its numeric form does not warn during PHY probe.

 drivers/net/phy/micrel.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/micrel.c b/drivers/net/phy/micrel.c
index ae830781824b..acb481a29c25 100644
--- a/drivers/net/phy/micrel.c
+++ b/drivers/net/phy/micrel.c
@@ -2791,7 +2791,7 @@ static int kszphy_probe(struct phy_device *phydev)
 
 		if (type)
 			priv->rmii_ref_clk_sel = type->has_rmii_ref_clk_sel;
-		rmii_ref_clk_sel_25_mhz = of_property_read_bool(np,
+		rmii_ref_clk_sel_25_mhz = of_property_present(np,
 				"micrel,rmii-reference-clock-select-25-mhz");
 
 		if (rate > 24500000 && rate < 25500000) {
-- 
2.47.3

