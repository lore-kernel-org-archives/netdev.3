Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7135372C1
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 15:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869435; cv=none; b=jXZNME6p7vZBp6xdwvKa6er5M2I4CQfjUScaj5LbYyl1UxSMScqX7zjknqPTtdJwlrhR9hep3/Z4BfmEW5BUihJsKXBQEPAI4gmtQyrMLZIgC2n2RcduEciX2o5EZH74UqH8cvMVK32X+U3ma4hnlBgh0yG1k42KqLgYWyGNe6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869435; c=relaxed/simple;
	bh=lzQpoBUsaRQAa1oPoh0pnGW00Yslr2vkR5cvQtTaOQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bAhMZPYiMFA5izxuyTZ3bV6ja7mVFnOmXW+6hRbgvzc5xeazSSTJeK5RcXdhP7q0d0JIbN2e0UN8YFAQyiL4T11q+UhSKfIQpU0AfacnjF7a7X6MVdwF4gO8RrRHX5C3YUumYQBL9Tnp+zd21V7WMaWaFR5RI2j04N4IpyBycsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JV23xCHD; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JV23xCHD"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49e6c0fce17so36774715e9.1
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 08:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790869426; x=1791474226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pYYP/VXH6FYzciyKOU1S5cNFWRMzFpBDzi4GGAsoJcA=;
        b=JV23xCHDWadkV+F025eH5bqxog06uDyhU+J84XQ5FIq6Rqx3GDTygTKtSvr9HzSPac
         7RcX+KLmCCV1CfOyCiIq/IRWwQkdTwA2Bl5Ow6aFu+Qd1IT/ANyWc4UcBmojikGSqRex
         QZwRD6fFjje1hzKuPk8J6YkLBinGkFqmEkH4cD0EFUxX+OChxnKyUZ8DAgPVaQbJU5dT
         2AZDOtdaVHHYNaGrP3Vg16PEKJSMI4zxDaGN23Bx08Bfhg7dqPgFQ/ch1+3i7RcxV2wj
         /XcSNxf6OXTSgN9D93KTccxpAyUiWRLI+cWj9oBdzuip4Z5prYLIMqcbfVcJXRAaJ1ux
         h0/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790869426; x=1791474226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pYYP/VXH6FYzciyKOU1S5cNFWRMzFpBDzi4GGAsoJcA=;
        b=DyZ4RNURW/mxOcUWi9eb8OgN/mKrtM0xXILqAdXDJQmNF1l2gSnsCQyOIsUSLTFEZY
         tBKU0vwc1DafVyBFgEBVN3wb1w4FjsWBEdLf/3B0iiB0G2u4up3NVJZgSkUngDdZ91fD
         f6MaraH9LiGGsRDsYWN2z99w0FwQQUfgUvPGaDNtIomJwganJM1y/oRks6UyXpm5GyJG
         hGbFLbW+Jl8d+r/sH26PG4ZhFyh4d8lty/72VK+JbinnO2YgwwRldEPzc0gYU8HQOPqK
         8oTO+jpisoJn6/F8Fsqp0I70Svd1mSb8K0qfBfAj7XAHBsJarBJyyV4ddpSVvc0X6QpI
         glVQ==
X-Forwarded-Encrypted: i=1; AKwUvBx2rjdeadHP5bxgunC1hy23epRZ0uRA4wZd3L1Ko9dx6dHEtRHmMvIvf5DFliVOwSXIm1BDp3M=@vger.kernel.org
X-Gm-Message-State: AFuF++muk3Q3mBposkB2OpYUK5yq+rMcos9Db6r2MkHezbQ/5YKH0Zp+
	St/pbfcVxkb5MNU+kX9c9kRFnabViqYutxNULEPnKR9g5eEWQ00OL4vA
X-Gm-Gg: AYBFou0q3CPEAl9qoiCnAw8TOHWgo/qzh7ZqeCEOQzIkduYep+Y7CIu8pRBUOGm1rK3
	oPwxr28NNA7xzqmKyRHzT9XcQ27/y5p6TnyAi4DexettXATIY0WRDsAI4Cv2S0EEpt5lKn1fbxP
	muODT5YinDLH11JHfTjLbBLb1orX/XgFWkf16YH2+EXESX0UV79UuXqgCGYDyke5F0xLQRNa2ZJ
	3cQ1iwD83DWwOftN0Hn8kjx6/0OUCFBdyIo6lF32pZbe5Akxgo90ZIky3f5oVchnjN6mNXX5OI2
	61sefq9lvrA5bahio9QIDbeRz0cwKwT85E7b5K6OgPhudCeTCGBeUA6qD6ZgSkVbcD+josaxQKx
	SjSlq5Wd8TlFo0eSuDOescFeUymI0mUQE0fXFba1NW+LoDLVnJy9PMsp8pcOyurHIRcGjwoDMjP
	RFT0Acx4NqWma1MU83eWISfPmEKmJzwyRWwkCF+xIWgsjIw6Xm5bbRWo2Yra5EA1OzdMm/ax9a0
	ZyrV4NcmBGBuKf4B8zQ9lzR3BMDByi35WhmZsHGeh+MZ+B9fMH8EHGtZ3ZWXrbdteFoatRUm9WI
	cO1qIR7x
X-Received: by 2002:a05:600c:a45:b0:49d:1df8:156d with SMTP id 5b1f17b1804b1-4a01afe0b36mr79926875e9.18.1790869425906;
        Thu, 01 Oct 2026 08:43:45 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:1be5:ad57:d5e0:f854])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f6db98fsm65195615e9.0.2026.10.01.08.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 08:43:45 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
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
Subject: [PATCH net-next v2 12/12] net: dsa: Kconfig: Enable support for RZ/T2H and RZ/N2H SoCs
Date: Thu,  1 Oct 2026 16:43:25 +0100
Message-ID: <20261001154326.754314-13-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001154326.754314-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261001154326.754314-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
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
2.55.0

