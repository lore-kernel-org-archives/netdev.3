Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816481;
	b=BEBpoMX7DnQjTgarj8G42cen3y76gYr6vCvb55+NAay5Eku9qkyJnLL8jzkkQy/zBRc2
	 cXMsBVPoFHxFZng8CsK9QA3ij1YMy3bvu9/fkk88bqidJujS7QrvKlSocO9ItASpfJFov
	 O36m6z4QGUb6Ox1O8pMjEKWowsDLOpd9fLcRS6KwmFYWmxqPSLZKo7CMZXbZtTRzLvtI4
	 7TClQssG+3/XApSfioUv9/4ug94plHWm67LTUXtO1RzC6wbPzjM9YyAQOa+XxxrCeo95Q
	 tArL9wb12Lezqh4Q7Y1uiABJg3wqiaM/vIRXw412XADFbT0r6wX+09rvAZ0PA2+XnLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816481;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=OwabDHq3ZuxM1yP800nESKo0UbrLBX3Su4rzj0ky3Xs=;
	b=CvUCbK9I0MuC3xSZdGZKNbdSTsdnA4Ov8D63IGBx7W+58raSaYEWZNdyiM7uPUqFo+6E
	 zsnFDAJJNm2yUfg6tyB6DSeAmyFXIo4kIhe8S+gkMh0e9yogb14yWCVawDlXW5n0x8Lsb
	 nyc3lMhGqJva+vqXdC0EMekVMx7Cf9mAaW6SqsvmjB0vHKk8dUEHV7FdP6AG5J5jfmVhg
	 5WDJukoicADjXfcclJWXKRDqKIMFnMJGM/UsteBfPgPo/balRJm3b2VIr588feQbPMSPU
	 jrCsgfGx4ypCNNnRD4dU/qeoLodYmFXMnCTK+0U8ZHsKkCBEMh99hys6vR9euuw88Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rgYBPg+z;
	arc=none smtp.remote-ip=209.85.221.54
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD8876083607
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 18:21:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CD8876083607
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rgYBPg+z
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-48b042c0759so614899f8f.2
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 10:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793816479; x=1794421279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OwabDHq3ZuxM1yP800nESKo0UbrLBX3Su4rzj0ky3Xs=;
        b=rgYBPg+z8aTcOOqgqb2NigaNQAKH/UEO51ZtpRUUUQlGUwVBl9l7W1aggtunfwT//8
         h045sPyhYjb6sBMTREFpCPj3YMH2FxuBbJS9skFQpqeZeIINduFNJD135vC9sSerjMdh
         FCOoHuGdVfF0NikfDmR1G97i7H4TJKaB028BznSDF10dhnovHyZu0mOQTNhVAvc3woZJ
         gPtbxLjZ+4FyAJarICpUFq22ZSEu2VzoaGfoIGYwQeGB/nB1x5shbEDZQ2WZwrC8zRnb
         1LYLI1piVZYRcIhO/LJ1Q6Am9+tII3CWRI05YX5KRvqdhbjs1Zv5AyOwTkupSYKkdLrS
         2MjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793816479; x=1794421279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OwabDHq3ZuxM1yP800nESKo0UbrLBX3Su4rzj0ky3Xs=;
        b=P71+lZQgzC/T+qcM2j7Gk2K5oGR/QNyVzkP2bk8SERVMMBVExA/fs/nLHPYP/Y7zQ4
         OrGIjre1xSBsIDwJO0qwobYuK5mWpXLbtb5/24yGAv5yTxlM1VGr9OWQsobRXBYece2s
         PCWJoVCgU4gr9icu0w3Hhxf+61x7DfNVzLyEGy6ElFSPcCJLD5KhzoBWcQIPVgzPMQqi
         Nhbia7ruLhgvPTgvYI+vJ6/1dBppFGZ2gC0mV8mn4ANgtKJeVJcDDGYxgyU0A+RZM3X2
         N0Nf4e+/QrsC2v7zT4+kRUz5wTFpuMZDe4mHEODqhTDfBdob3MQtcz7ZpVsXMdpf9aRv
         MJ7Q==
X-Forwarded-Encrypted: i=1; AKwUvBy5XvpxAddaPu8UXmtcRcCNVKG5ERvznT/ECbsSAYi51BWuz3e/Oczl1ZpQva2kQKE4caDX9Fg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8JTbmQKwQt3yPKB1t/1Q16ShBwOVpXbOpZKzW3BV0sG3VG/KVx
	4HnDV547mBF8E3WKKiP4+BGJHKkq99QPLEdgDDRNgp3/iRRlYl0u4ck6
X-Gm-Gg: AYBFou1AcOqrX99ZXxz3PzwksIa5ZtvRkYhy5mOhe5odkmFR8bsQCRO/WhzDgEzfyEF
	r5eqoL0lr8xZith+dFGeJvxcBzCQ62o6Nhc0/aH3H75YrfSALFIoQejklAwumsvNo+fu6T9W1jO
	vSGqcCEyobR+Nt6+IokZWZvApmzBxYCS4UqqWm6w7N8XbKhxlj8O4KRWm0Tf+h4xC9jbHXWJ731
	TGv7BB6Q1OtFDmbUQHGDGZ30EjfKbajy4Zg8bxsWIZZSlWDOZSdhQUj5kxDGbfcWmqFzDPrLSeo
	B0ZROIAco4YfDs1oRzqUv4ibsJyBqumdyYhsCjYYtNQE3sfNeefl52V4YBbLUPJRlomahaLqzof
	d+3qb7/KHwprlSGbmqoX0JWKp34rVRWttP04FPKIWlUSfuig8XVPpeZsZzyXlMnU2KAIIjDB3p4
	QEW/BwjJorfmgt/tiuQPiPDcorBTKr+DENm+2xhvBhpUWOoiNM+PtOxWrCH6duT21kObJz7eCS7
	I4uceznLbSnvtOr0IX6wWtIQlZXnGSxmb7U5Wr+ycvJNR3Rg3mW/ZlSOcfPov9e5LMWyAeN/CJq
	KKJ4+qG9fJGSbQ16Koa8H6s+otGTFyYXDIeEcvNzc1EWSc/EANExOfQ5Y535KQrCHHWTpeFz0OP
	f+U2EnQp5qZ5dEsgsDF8ZT5/aoLWgc+oC/yCJ4w==
X-Received: by 2002:a05:6000:24c4:b0:48d:f9dd:e3de with SMTP id ffacd0b85a97d-48e6e511219mr37783890f8f.45.1793816478980;
        Wed, 04 Nov 2026 10:21:18 -0800 (PST)
Received: from iku.lan ([2a00:23c8:254f:fd01:b079:a2f1:caf7:b446])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed0844e2sm4073202f8f.28.2026.11.04.10.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:21:18 -0800 (PST)
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
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH net-next v4 07/14] net: dsa: rzn1-a5psw: Add support for optional reset control
Date: Wed,  4 Nov 2026 18:20:55 +0000
Message-ID: <20261104182105.1102555-8-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Add support for an optional reset control to the RZN1 A5PSW driver.
Obtain the reset line using
devm_reset_control_get_optional_exclusive_deasserted() during probe
to ensure that the Ethernet switch (ETHSW) block is properly released
from reset before initialization.

This change prepares the driver for use on Renesas RZ/T2H and RZ/N2H
SoCs, where the ETHSW IP block is connected to a dedicated reset line
that must be controlled by software.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
v3->v4:
- No change

v2->v3:
- No change

v1->v2:
- Added RB tags
---
 drivers/net/dsa/rzn1_a5psw.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/dsa/rzn1_a5psw.c b/drivers/net/dsa/rzn1_a5psw.c
index 85ff1fd2bbfb..9daa5d8245df 100644
--- a/drivers/net/dsa/rzn1_a5psw.c
+++ b/drivers/net/dsa/rzn1_a5psw.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/of_mdio.h>
+#include <linux/reset.h>
 #include <net/dsa.h>
 
 #include "rzn1_a5psw.h"
@@ -1207,6 +1208,7 @@ static int a5psw_pcs_get(struct a5psw *a5psw)
 static int a5psw_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct reset_control *reset;
 	struct device_node *mdio;
 	struct dsa_switch *ds;
 	struct a5psw *a5psw;
@@ -1243,6 +1245,12 @@ static int a5psw_probe(struct platform_device *pdev)
 		goto free_pcs;
 	}
 
+	reset = devm_reset_control_get_optional_exclusive_deasserted(dev, NULL);
+	if (IS_ERR(reset)) {
+		ret = PTR_ERR(reset);
+		goto free_pcs;
+	}
+
 	mdio = of_get_available_child_by_name(dev->of_node, "mdio");
 	if (mdio) {
 		ret = a5psw_probe_mdio(a5psw, mdio);
-- 
2.56.0

