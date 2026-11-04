Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816486;
	b=uCEZzGPlQ1PWLo8X/tx4y9/LyQi8FdXKEQCCcXrN5j4WVcxw0Cp7ejbvOjhl4Qree9XF
	 //csiCoct5FeHv+TGQlsaFZIPUgrWB8PL3HrAqa/tMxdzSqfk6FQ57mr4yb4keJxGRgXb
	 HVga1KnfZwspg7RoEa3N8n91+j08X9AzOu0TGoGjprxqIX0NZ0twSKsdoA4zihAt+jWga
	 oSub9hJ321JMTLqX2WyJKEhxZ0ZfZ/nXOCY0+Fs13eDzlkGcw4Jh5aM1/hoWmjGKaMdxR
	 a/foa1i2LWlKfaOyuVtp13R7P435bgMCWq38lhb5qZWkw8yJwD4EtcSr8i+4GrmuYKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816486;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=aTDvp/Q0M0o5LAma9UuHl2ioDRXCh/2jQrBcsrQNRLI=;
	b=HzDy9m2wmybZUkDsqw/b7TpRelDyZ1W+21uvXSXVE0/aJOTczquVjAid6/J+wqP03cN6
	 uohnU2gxz6iAO7eBTJqXTVCVNj57zS0NM+t9CRTlUBTCNDyBXBTSvP2rX/e7cAwTRvqAT
	 2vSHGxrgt+TRRHQBUgYsQYcFaA7Js+2fSiHE94sRAzPlvDFuggCnK5SjaAx9La3CJdG1M
	 Rt9+yIn3qw1dTBS2zhzcD7BMHSWSnbk/TfuVdbH/prR8BZzojpEQoLkmHNAToD1IYE3D4
	 FJDeMvQCvWvpXwoQCsxBheAIbBawKhyJT8HB4rcX9MuLy5nhKeT5PIzv0dOyjo/p9BA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aRNKux8j;
	arc=none smtp.remote-ip=209.85.221.45
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9CC60A6F48
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 18:21:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8F9CC60A6F48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aRNKux8j
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48bbb06e746so679631f8f.3
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 10:21:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793816485; x=1794421285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aTDvp/Q0M0o5LAma9UuHl2ioDRXCh/2jQrBcsrQNRLI=;
        b=aRNKux8jXMUGWHWagH10tnaFubvYY/cvfOC258fy0pVp0hcDXzySw/Q6YXq9semX30
         farQ9acn5oTFCbz1nQL+p/mcyFEYgrwgN5EvIVBNM71OgHEeF1zic8TstmtsCVUGPmJt
         svvzBkSOKPQlpOjEA/yBPnevN7N4NF7wBRjNZ1Zp8UNyUZRom8veuAMr/CkVFaneuGp4
         +M0dgse9SXLkSvVQNLQPEmLpXsXnEpd+P1McqG+XoZhCaKxL4P989KsnwcMm8oylWep8
         e32kq2zNveMI520KnbsIi5VuE6ZaIFO8ItsZWsNrPQZSO1WSM24gLV/gsz/cuJyQsZK8
         2L2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793816485; x=1794421285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aTDvp/Q0M0o5LAma9UuHl2ioDRXCh/2jQrBcsrQNRLI=;
        b=SQtiangk2tr1oL8lXf4wYMNqimvy6sAj1opVBDOz/F3wrV78KeVJPcmv8yxJyJeiqs
         rKcisrFFTjU/fdcDNnhnNdliGsgg7vVXaote7hUDeu6i0tdUGUPyLWjuqOlCU9cCN//c
         uHqByaURTlxT1cE9SFPDERAOyl3Csbwn56vf604JvAYAhY6vOj6h0YIBzvZYussz5ZWA
         C2yMssB/5B2NYS4G6hWD0dBj6Chhtmaj+wsy/vQBRgpeXm3ecAWhHnq9z9V4MB+jjKQS
         3pqaJXCUXvFzZemIAcSwd1KYMqJqlX972w4UtbGHgcAHBfnUOWOLoLt82PyJkKWiE7TY
         PM4A==
X-Forwarded-Encrypted: i=1; AKwUvByJhGXzGytolTiamqtwuDWCFMkYO+uCNuoVJzWoAcaf7JNut+og/OiTk3JCzzwZ0m3Yk9+PDZw=@vger.kernel.org
X-Gm-Message-State: APuU4Z+E3aLkB6huXM+tIic/aPS1KESwZogrD8ulyRa8HKayZIvq1unV
	BtrW5x3G7pabrg2MiPAiV6Ah9RjZh0tEnQSgGGmKefyL7bogRJgeVIhj
X-Gm-Gg: AYBFou22S5iF2ikKhS1pg/ywEWRnKOgkLtrby1lNanKAlxFASElOealQ5rahPBC3BQv
	mA+qaADbQB7VdTvRIRx9UA6pdPdSmz+0KhQCx87dzfLrtav0fJbN5eLbZ7bZQ6XmYNWu2jkEo90
	SpnsKF8MXLmUmvHqA2cQgRZnGOpNuzp3hN2mMWgs8PwDqP2/yk94iwwyUZy5g1/SwhhUMxjZTEW
	hYpxlEdJP5i7tlSF14+QzID6GsC7gun6yI0YsIINuj7akrRhwvRY2qb7hsY7GwM3B2thcjsHeWl
	CTMAvDJDjvwlVDpVPAdEBL4L15eSUgV0cQ4xCbENAtlK87Z3DJ8E5U1vv0X3rY5/N2JFftqkcAJ
	2XpJCrNq0Qn/fgQ8XtIgzenTp98L0TzHPOX/DPVcPJNuD27U79UPXIeSSfw7guXGRkzC8Ntzssn
	RKY20b0wBnfFe50deYRnyiuKE2GkCFjoZ7Po9yKEmffV8h2yqeGg8VhkNCsG3VOo8Te0pRwW8dY
	WwueF+wbBKpdi9Sz349JWcxrY2eTVoX2xNv6MsjOmK0T0cff8VfgJlZmLr8AHSd+fQkLeevSD6f
	tyQgk0EDLdoVGncgqlmqKLErS5XN1GAlrglomUm8flICGoF2xmbwXhp+eeIjP3pRhBC1h9pbCXt
	3oDmKYz0a1z/qCnEhVBojb2/o4N2DXwvdvNKLrg==
X-Received: by 2002:a05:6000:46ca:b0:48d:f541:a6e7 with SMTP id ffacd0b85a97d-48e6e4f4976mr26708137f8f.40.1793816484784;
        Wed, 04 Nov 2026 10:21:24 -0800 (PST)
Received: from iku.lan ([2a00:23c8:254f:fd01:b079:a2f1:caf7:b446])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48fed0844e2sm4073202f8f.28.2026.11.04.10.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:21:24 -0800 (PST)
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
Subject: [PATCH net-next v4 14/14] net: dsa: Kconfig: Enable support for RZ/T2H and RZ/N2H SoCs
Date: Wed,  4 Nov 2026 18:21:02 +0000
Message-ID: <20261104182105.1102555-15-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

Update the Kconfig entry for the Renesas RZ/N1 A5PSW Ethernet switch
driver to depend on ARCH_RENESAS instead of ARCH_RZN1. This allows
the driver to be built for other Renesas SoCs that integrate a similar
Ethernet switch IP, such as RZ/T2H and RZ/N2H.

Also update the help text and prompt to reflect support for the ETHSW
variant used on these SoCs.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
---
v3->v4:
- No change

v2->v3:
- No change

v1->v2:
- Added RB tag
---
 drivers/net/dsa/Kconfig | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
index fe8cd5338fda..f6894495b9ed 100644
--- a/drivers/net/dsa/Kconfig
+++ b/drivers/net/dsa/Kconfig
@@ -101,13 +101,14 @@ source "drivers/net/dsa/xrs700x/Kconfig"
 source "drivers/net/dsa/realtek/Kconfig"
 
 config NET_DSA_RZN1_A5PSW
-	tristate "Renesas RZ/N1 A5PSW Ethernet switch support"
-	depends on OF && (ARCH_RZN1 || COMPILE_TEST)
+	tristate "Renesas RZ/N1 A5PSW and RZ/{T2H,N2H} ETHSW Ethernet switch support"
+	depends on OF && (ARCH_RENESAS || COMPILE_TEST)
 	select NET_DSA_TAG_RZN1_A5PSW
 	select PCS_RZN1_MIIC
 	help
-	  This driver supports the A5PSW switch, which is embedded in Renesas
-	  RZ/N1 SoC.
+	  This driver supports the Advanced 5-Port Switch (A5PSW) found on
+	  Renesas RZ/N1 SoCs, and the Ethernet Switch (ETHSW) found on
+	  Renesas RZ/T2H and RZ/N2H SoCs.
 
 config NET_DSA_KS8995
 	tristate "Micrel KS8995 family 5-ports 10/100 Ethernet switches"
-- 
2.56.0

