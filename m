Received: from smtpcmd01-g.aruba.it (smtpcmd01-g.aruba.it [62.149.158.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2434BB28B
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 13:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.158.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790949467; cv=none; b=ZkK43icy+aR6H4xzsEdCMuK9EQAAU2FLvvtPEsKvXYvwgXatorvHcBAv0y8jBfkKzRLhIJdXzSNPzNhylSMy5D0PTpvaLZ19deac5lCPFcjVqvH+21HANgz4SPfc2xeAK2Gc/7Arv/HPA4gPvrjgB9bRTMQqfCQ7/ZFGnpLETLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790949467; c=relaxed/simple;
	bh=Tfqex6erqwfS0ioS8ha09i46USaaivXCq2v8B7oNWqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VV7l2ymhgcPKT+H2GbDxe+oudgy2o9S3CFS+unfQJTYgPl7+dh7TTE1yOOQIyafehJcRfdaOFHxcKn2a3iDLnG/22468bcZPwMyakpcb1lGGwP/mjYY0CSQupNQ52CWCGf08xL9LcQABTWI6plURWS08X1wcB6Jb+WO7wm8lddg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com; spf=pass smtp.mailfrom=enneenne.com; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=jKw0qo2I; arc=none smtp.client-ip=62.149.158.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=enneenne.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=enneenne.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="jKw0qo2I"
Received: from polimar.tail4f75e6.ts.net ([101.57.122.26])
	by Aruba SMTP with ESMTPSA
	id CdlZxDen1LUMUCdlbxwrDw; Fri, 02 Oct 2026 15:57:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1790949459; bh=Tfqex6erqwfS0ioS8ha09i46USaaivXCq2v8B7oNWqg=;
	h=From:To:Subject:Date:MIME-Version;
	b=jKw0qo2IPGreWCEnQq1DoN/JFi/+iq93qP7BdJJc1T++RvsYAWibAVqX2RIpLD+MF
	 ieeZyMljSlNIjy4OOf9W8K3NHZH9NkBfDYxVBci5Mkx1ncnCLgaOLfQM6EnP8YpdoY
	 JmZ2hR+DK8jmFrAdtAz/BXpBL3iXFT4xR2JWvMk76Gd5s1X0LfmEuJ9Otd41RVUClf
	 Zrvw2TzF/UhMQIL5mKF351FZk1SRw4VT+d4fKGKFQ7jyClZMcDVH8HUPCWriYreVy9
	 yHDk0lC932TBCMuz0N21Tjm1xcxkYbu3C0HTK5PG24328ocICTEoJNfdhx6G84kU9o
	 ZiLJzfrishxRg==
From: Rodolfo Giometti <giometti@enneenne.com>
To: Woojung Huh <woojung.huh@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Marek Vasut <marex@denx.de>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rodolfo Giometti <giometti@enneenne.com>
Subject: [PATCH net-next 1/2] dt-bindings: net: dsa: microchip: add reset timing properties
Date: Fri,  2 Oct 2026 15:55:41 +0200
Message-ID: <20261002135542.359756-2-giometti@enneenne.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261002135542.359756-1-giometti@enneenne.com>
References: <20261002135542.359756-1-giometti@enneenne.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfEW1Yj8i3zhIjVzqiH5/fOMLH9cxuuPtIsrqzceN+Lma+S/NNovw7sZ/lCUX6xoepm5qAAjwIauvAlYtPtJlp5Lyafpje5W49a5rUlrdIa8LQkLe483K
 e6uqJ6If8ScgsNigVHFG19S6N5PnboyDEECtS4dXsyjgeE0QblHTYdJ65IsOtaYdBi/I47MdDMb9udSwqnOGHyN9pz6xqnuaZY+o/DnG9kGLMGWZK8EOeWka
 HIOBmx2E5/WjBwRqz3KmhS0NYL1P2mmg8nEns6pCC0TEONywr/HCaXgAalzJgLwrT4E+tgu6TCUAk8XsVUfAxKQoi0RD8D3yLfa4LPaHoOuzTORiEZO0Wyst
 hd68Z/2b6QtWbhq7HFmnRJljrVcfCzNYywePMX8+xQjQA2ns+BhUQqQuonYoTWV5K2+WfuzuCPrRBz+D4Y0gVEZ5+k2w6R1mQUuoqKTehbxoPS1bn1xv5gK2
 6EY2+A/BY3OuQtB1sc0a2NfMJJzmaAR5PcQ7cZXbYvCYgn46CcbbjgVWkYTzqdXiw160inXLxhPT7iTGxg2xhvljXueFka/c93us7mXGSCZBYNgMjADUNyhJ
 CQmv6+ELlVkX77e1ou+32T5vdM1+mM5d4mSCRkj6hmRtdXB4fyET29724ysva01N0Y3BuulliFFQohhN+7oo09K+

How long a KSZ switch needs before it answers on its management bus
after the reset line is released depends on the board it sits on, and a
board that needs longer than the driver waits has no way to say so.

Document reset-assert-us and reset-deassert-us with the meaning they
already have for MDIO devices, and record the timings the driver has
been using so far as their defaults.

Assisted-by: LLM
Signed-off-by: Rodolfo Giometti <giometti@enneenne.com>
---
 .../devicetree/bindings/net/dsa/microchip,ksz.yaml   | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index 4ed13870ed3a..5a99d79ea982 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -48,6 +48,18 @@ properties:
       Should be a gpio specifier for a reset line.
     maxItems: 1
 
+  reset-assert-us:
+    description:
+      How long the reset line is held asserted, in microseconds.
+    default: 10000
+
+  reset-deassert-us:
+    description:
+      How long to wait after the reset line is released before the switch is
+      accessed, in microseconds. Boards whose switch needs longer than the
+      default to answer on the management bus state their own value here.
+    default: 100000
+
   wakeup-source: true
 
   microchip,synclko-125:
-- 
2.43.0

