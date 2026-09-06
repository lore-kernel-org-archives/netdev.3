Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464F7422556;
	Sun,  6 Sep 2026 08:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788682827; cv=none; b=oB2/3NaSoU9EyHHXIeqOsYYQDr5PCY0I6LRL6tgqH2tRJXmZD4IBMasOdLJMMMjBQbiB6CGhnTO6Xngl41bzlWiQhQajJYw1ZuEYmJVjpFuXWcowy4P+fvTKbc7kvcM6QCDpVBpYpYaRijtjMPBvu3MmTzg96qaDsA6X2j3lR5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788682827; c=relaxed/simple;
	bh=5wMLiO/m6DP23c5WzhgmTRjNAdIHtwOTtbPd0Usu2Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KBs9B9H9zhMAYExaP0CuOD/fqoB9fvCMdX3S8WCVbwS2OHjnqGO1YLwWfjLdSFi5smnZ9u1hGzHKq/IHusOeIaCjMS4dNO+6+ajgkU32TPynh09+gIA0Lpr6pkHGgfzAAcWUqH2hi4mQFvoPE0zPmdlsnVYRz5nLT5VkMWL+MRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=CjywL2Y2; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="CjywL2Y2"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788682801; x=1789287601;
	i=markus.stockhausen@gmx.de;
	bh=BYl5CqLRjFyOOeXcAdy/BFzSvd4ma8dmSeMvRtlfRAs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=CjywL2Y2ERbEDnH7Bd9ss0PHwEMS2na4rny+32xFUj7EICsrREf8M6HMe/eY12ym
	 w5s9jBkzkUbH6fq6n8GgTmZW72kEiF1ac3P+brgdVlg5da73nm2SaqYverB7/f98F
	 oytN0w4fuYSSBpVUv9b5J2RQXs/337Vq84jBcHCBsLkz3dslHt5pa1jXKoe6NWruC
	 Pd6yHT/QZMr+PbMBBeKTe2K3o5ucMnidubWbQeerNt1VzukCyPsxZpfW9rLb5QORt
	 JS135cl91WwcMhZxoHRhLkwhfc6lmqWjfC9dIu3OSc+JL3K2PWZqmaG5uUZ9GPSty
	 ilVVhreNa3qRGedhDQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MI5Q5-1x6gre1zPz-00HQsk; Sun, 06
 Sep 2026 10:20:01 +0200
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
Subject: [PATCH net-next v2 1/3] dt-bindings: net: realtek,rtl9301-mdio: Add clock-frequency
Date: Sun,  6 Sep 2026 10:19:44 +0200
Message-ID: <20260906081946.3499898-2-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260906081946.3499898-1-markus.stockhausen@gmx.de>
References: <20260906081946.3499898-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:rfUqm8lirOudiT1VD0whI84KaPQzCAoJ0toZuMThUkEZPoIbzNo
 2SVfOSobN6gW6KBnCUFCs8d2HlA9yHziKylf/OpypUT3z5f8kM9xizCB/5DwJytQgZqpnnI
 rssAyulsv67s5+gajhrR1XOrLJEM94pZs3Jk8Bu+FQgjlhBbt5nY99binEerysK1zABlkw4
 nFA37Pbpgn27ixqV42byw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:LrVe2TiRqqc=;2vrGadCYdCGfOHqiLExGMoX/bbs
 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

The Realtek Otto Switch ethernet MDIO controller supports different MDC
speeds ranging from 1.25MHz to 10MHz. Document the clock-frequency
attribute for the device tree.

There is neither an official documentation nor any obvious registers that
indicate a dependency to one of the hardware clocks. The usable setup bits
are more like hardcoded values than dividers. Without further details do
not add a clock reference.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
=2D--
 .../bindings/net/realtek,rtl9301-mdio.yaml    | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.ya=
ml b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
index 67e0b23a8470..88502d017eed 100644
=2D-- a/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/realtek,rtl9301-mdio.yaml
@@ -56,6 +56,9 @@ patternProperties:
       reg:
         maxItems: 1
=20
+      clock-frequency:
+        default: 2500000
+
     required:
       - reg
=20
@@ -71,6 +74,43 @@ required:
   - compatible
   - reg
=20
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - realtek,rtl8380-mdio
+              - realtek,rtl8381-mdio
+              - realtek,rtl8382-mdio
+    then:
+      patternProperties:
+        '^mdio-bus@[0-3]$':
+          properties:
+            clock-frequency:
+              enum: [2500000, 10000000]
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - realtek,rtl8391-mdio
+              - realtek,rtl8392-mdio
+              - realtek,rtl8393-mdio
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
+
 unevaluatedProperties: false
=20
 examples:
=2D-=20
2.55.0

