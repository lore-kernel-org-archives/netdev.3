Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F0D377A98;
	Mon,  5 Oct 2026 07:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791186592; cv=none; b=q9u06lRkaenHhHlynP/hSvbHZ6OAGW60dAaOpDXn1TjnQ8VFSaRJUAinmSnJLJSNpmCfPulDjY47f7APR8jViHPtskTeXoTR3YGEjjVcW/FIj7obT8YxFaClHhudQV9ilNj914HW2dhrTWeIarIfvL9gScfmIq49AkvoPA7gvJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791186592; c=relaxed/simple;
	bh=Lf+q5YC4tTGBsPib9FQxfyPNA4rmyCcmS4moSqCJJvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nqYNtAF5RP8zdUIVGi689GX7tKHkqAf32bL5hZisxsq6pxcXouQklHeUno23ByHlcr+Gq7XMbx9rFYcTSnymR4DZTrho6nTohd9HtFf/RFfOStRaD95mC5K+MmlupTMud/UI5sE8lIic6Zu0V1sDD12+NwFdQ7pRzLgprgZ07xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=ERJJ/XoU; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="ERJJ/XoU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1791186564; x=1791791364;
	i=markus.stockhausen@gmx.de;
	bh=TxMzDRvygFZ9mHurmL71AwLWXB8C821umA+eIt99C/w=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ERJJ/XoU6aLwaX8/GPaDM2jIITg9GSSvwvRPKd2L+xDD9I3nxfKovOc9YuC2E2ip
	 m6gb3Ra5xBp3RrYlDpMOjAbkqIIM8mDVwq6y6mwZD2blbNFpP8lNktVqyLLQh96HA
	 wouRalF4oNOf3+imjrIdUPnc9aN6u4zdkvKiBLcDg+rxz4DX1QHEe6ZjgTXyHHvlE
	 6nGDbAe39+59xtk59Ige9o9TCLNqinp4+Vr+pt8WdqToLGGMHe13b0UgUO5y8XQQp
	 Le66dJ81M7UgmfvtuLSP1n5MaqtTfgPRd6WSVfj3QXNy9J47g3SHHSFsceDSTDTx3
	 c/iDjYUog4EqJq8G2w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M72oH-1xKUoN30DH-006PWu; Mon, 05
 Oct 2026 09:49:24 +0200
From: Markus Stockhausen <markus.stockhausen@gmx.de>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	chris.packham@alliedtelesis.co.nz,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>
Subject: [PATCH net-next v5 2/5] dt-bindings: net: realtek,rtl9301-mdio: add clock-frequency
Date: Mon,  5 Oct 2026 09:49:05 +0200
Message-ID: <20261005074908.1273383-3-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261005074908.1273383-1-markus.stockhausen@gmx.de>
References: <20261005074908.1273383-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:yVb8US0iVhIFZLA6HCqNKtS9P1+Tq6FjRTX4cBS5RVyGw/3K76h
 sTT/sdbpn8JxcLf6bh9geFyp9B4GQsEtro+wG6J5lG1S1XCDlYASoMryS/502ktel4+DHHK
 VM8OM23XHw5ujmA4m3zDuq/3X4uvOpu7qmWDecWByEueTYgvwwjLqIahmqmTMG6cGsYHv3Z
 CZDNxgoc9DWQpGBu/JEYg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:rLMBJsbgmZE=;JxOwEOdXAZ10iT/O/yJMhhwzs3Y
 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
 cE0Xr8uA==

The Ethernet MDIO controllers in Realtek Otto switches support several
MDC frequencies. Document the supported clock-frequency values:

- RTL838x: 2.5 MHz or 10 MHz
- RTL839x, RTL930x and RTL931x: 1.25 MHz, 2.5 MHz or 5 MHz

RTL839x has a single frequency selector shared by both MDIO buses.
Require explicitly specified frequencies to be identical and document
that a bus without clock-frequency inherits the frequency selected by
the other available bus. Use 2.5 MHz if neither bus specifies a
frequency.

There is neither an official documentation nor any obvious registers that
indicate a dependency to one of the hardware clocks. The usable setup bits
are more like hardcoded values than dividers. Without further details do
not add a clock reference.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 .../bindings/net/realtek,rtl9301-mdio.yaml    | 44 +++++++++++++++++--
 1 file changed, 41 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.ya=
ml b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
index 7f5b4897487b..139190e3f900 100644
=2D-- a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
@@ -67,6 +67,10 @@ patternProperties:
=20
     unevaluatedProperties: false
=20
+required:
+  - compatible
+  - reg
+
 allOf:
   - if:
       properties:
@@ -77,8 +81,16 @@ allOf:
               - realtek,rtl8381-mdio
               - realtek,rtl8382-mdio
     then:
+      properties:
+        mdio-bus@0:
+          properties:
+            clock-frequency:
+              enum: [2500000, 10000000]
+              default: 2500000
+
       patternProperties:
         '^mdio-bus@[1-3]$': false
+
   - if:
       properties:
         compatible:
@@ -89,11 +101,37 @@ allOf:
               - realtek,rtl8393-mdio
     then:
       patternProperties:
+        '^mdio-bus@[01]$':
+          properties:
+            clock-frequency:
+              enum: [1250000, 2500000, 5000000]
+              description: |
+                RTL839x has one clock selector shared by both MDIO buses.=
 All explicitly
+                specified clock-frequency values must be identical. A bus=
 without this
+                property inherits the shared frequency selected by anothe=
r available bus.
+                If neither available bus specifies a frequency, 2500000 H=
z is used.
+
         '^mdio-bus@[2-3]$': false
=20
-required:
-  - compatible
-  - reg
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - realtek,rtl9301-mdio
+              - realtek,rtl9302b-mdio
+              - realtek,rtl9302c-mdio
+              - realtek,rtl9303-mdio
+              - realtek,rtl9311-mdio
+              - realtek,rtl9312-mdio
+              - realtek,rtl9313-mdio
+    then:
+      patternProperties:
+        '^mdio-bus@[0-3]$':
+          properties:
+            clock-frequency:
+              enum: [1250000, 2500000, 5000000]
+              default: 2500000
=20
 unevaluatedProperties: false
=20
=2D-=20
2.55.0

