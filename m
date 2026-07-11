Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72425353A61
	for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 11:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783770084; cv=none; b=eWyGromp+Zs7BF5cbFipjBfDNsgWYgfhvuy9Yw/yEVIsMFXb+1x83Kwjm1uA+kLxfmeiVowQzCdeCzL8kiyG5ZhEo3+z93Nmob+JvFUl/XUCCj0wObMYTrrrsMDKgnZK9jwjUpW74blyz5Nor8tqQS4sX1wYQ5/tO2xgEVjJBBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783770084; c=relaxed/simple;
	bh=pY9ue3fWD1k3HH/iHVCcH6RHdxD5QejgwuhGaIH8CcE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o3llRgyKDK1dQBwesLOh6c94S1wVJI84ulPGdKYm1Phs18QcXTKOyRdjSyopFlaBZo5+sBP39oJxjLTHrCnHmtXj8skfZ4XyD2UVj1r3sCgBY3gEcq8m7J/SAZI+GHM7B0hUnjX2RH67sxKbobZerjdoAtHN8Cx9WHdXBjC8k6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QWaFQoFk; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QWaFQoFk"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-381018b9375so2188832a91.0
        for <netdev@vger.kernel.org>; Sat, 11 Jul 2026 04:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783770083; x=1784374883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SF2r+F7aUjvLppp5OlMxLDe4toTwbQve0N2dz3KscQA=;
        b=QWaFQoFk+ApR3MyKfY5i2oNkh9C2BquMdyCsAZo4l+R5qa9hHukohFwUjmoQGpxW3l
         mrLjA35ofFUFd6BNKhOegvnJf2lBl/h8yTsYnPxO01jHacxrF86lCuQWYf4XLnmQwmYT
         QS3FA1fmmZW1vzKcIbukYDLH12KWsyCMbfy+b2jEpBQ2Bp4EYasGutBozco+n1jhS+ty
         TXIAL/UoAbFcXjuT+Ad9IaRam5A4giuawPQLe115MvzvJtO0t30rcmvvtobPst9F+vg4
         k/nyicChrjV4FIcnrcNJl4oDPiUZ40lWnPapr6w3Frbkcg2D+IlhhlhO+J53YHeGoYDh
         2gVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783770083; x=1784374883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SF2r+F7aUjvLppp5OlMxLDe4toTwbQve0N2dz3KscQA=;
        b=Upq/jqQqwjIiQQPiQvtj6dCM3f7REkye21jpH7gDOBwEVSC0IRPh1waqzpNyQkla5P
         f1FogbErLwzNYPtw7u+zcLiHDAAA56amOIuw4PzvQRs9Qxim/4FQYY9PxyZFXdi+Ow9O
         ShkXiBHj/2/DHxAFXXokVPyYGbhYCdwWozN5HP9F9zjDJYhb45Tv6DjBrG9OOuOBL0YZ
         1MaK5mM4LOWWAreeLLgT+2rIlOTNPM4rjuHJIyj/4sWFrzNFtekuvVmOaqufGxLV7G+S
         XK8Z9EtPpW5YObv8QxtkgpuZn6B0CGdEaIcZ2i7YlS++rvUs1S+tQNYVm9bGEOwLDfsG
         WRVw==
X-Gm-Message-State: AOJu0YwPr7AkChLTsIA2MVKPU9oty8k6RDqFImkkaNMUm5/hG83cP5kO
	0hxoAM3EkzS6A9v6XDUdb/uXwdwjpPth+rXghwUEjuHybfiInEXSFR5WHNbJz+39
X-Gm-Gg: AfdE7cnkVjSBfhAyUMARWIOJPw/xBZMCs4AWdy8/IVjX1lNtHDESd7L6njuuEgU9Q03
	/peJHwqg5IcUMjaTtq/NWJsXI4Ebd2pLqTOVOIDQW8LslQgTkEFwhykTGqG2cpdf+g+5YHv6zBY
	ltP7c6nqhVZUpAvw77l2E1XH7teUQWUCcsWu76v/paTXUvKKUyEFIU1dqZAK/A0bX8EQlf6GlYH
	2PAfW7XUYkB7tzjLZo5F52x9UV4Gy0Su/jYElsBiUWW2u9uQ1AmfBux0SwWFeUcHs6cEZ+stRL9
	CuD755HBv20nnmpjjnWe/xGl4U6KWtnh6RzyPCpewzdRtIb7DEvhLyUk/PXrDarHs6NXsSK77M5
	lQ3db0P4LA89r7j054nkU81hHn75idCywG3SR8GoRu6f45p1B67yT+XqUGbJqgVgjVSZVDpiy9r
	/qybwyWAxyZslgzyHrCGdi
X-Received: by 2002:a17:90b:3f0f:b0:36b:b3f4:d578 with SMTP id 98e67ed59e1d1-38dc75e607fmr2500103a91.15.1783770082826;
        Sat, 11 Jul 2026 04:41:22 -0700 (PDT)
Received: from DESKTOP-TIT0J8O.dm.ae ([49.47.198.15])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311935fd091sm32390087eec.24.2026.07.11.04.41.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 04:41:22 -0700 (PDT)
From: Ahmed Naseef <naseefkm@gmail.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Conor Dooley <conor+dt@kernel.org>,
	DENG Qingfang <dqfext@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Sean Wang <sean.wang@mediatek.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	Ahmed Naseef <naseefkm@gmail.com>
Subject: [PATCH net-next v2 1/2] dt-bindings: net: dsa: mediatek,mt7530: add econet,en7528-switch
Date: Sat, 11 Jul 2026 15:41:00 +0400
Message-Id: <2133035bb22eacc8a0e21f86c0c800a45023ee01.1783770059.git.naseefkm@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1783770059.git.naseefkm@gmail.com>
References: <cover.1783770059.git.naseefkm@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The EcoNet EN7528 MIPS SoC integrates an MT7530 Gigabit switch,
memory-mapped in the SoC register space like the built-in switches of
the MediaTek MT7988 and Airoha EN7581/AN7583 SoCs. Its four user ports
are connected to integrated Gigabit PHYs and its CPU port is connected
internally to the SoC Ethernet MAC.

Those three switches are MT7531-based, whereas the EN7528 has a genuine
MT7530 switch core (its chip revision register reads 0x7530). The two
generations differ in their register programming - for example the CPU
port is selected through the MT7530-style MFC register rather than the
MT7531 CFC register - so the EN7528 is not compatible with the existing
switch compatibles and cannot fall back to one of them.

Add the econet,en7528-switch compatible, with the same constraints as
the other built-in switches.

Signed-off-by: Ahmed Naseef <naseefkm@gmail.com>
---
 .../devicetree/bindings/net/dsa/mediatek,mt7530.yaml         | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
index 815a90808901..90b3582b7619 100644
--- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
@@ -100,6 +100,10 @@ properties:
           Built-in switch of the Airoha AN7583 SoC
         const: airoha,an7583-switch
 
+      - description:
+          Built-in switch of the EcoNet EN7528 SoC
+        const: econet,en7528-switch
+
   reg:
     maxItems: 1
 
@@ -318,6 +322,7 @@ allOf:
             - mediatek,mt7988-switch
             - airoha,en7581-switch
             - airoha,an7583-switch
+            - econet,en7528-switch
     then:
       $ref: "#/$defs/builtin-dsa-port"
       properties:
-- 
2.34.1

