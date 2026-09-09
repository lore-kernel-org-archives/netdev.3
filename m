Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F5D056853B;
	Wed,  9 Sep 2026 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966111; cv=none; b=EcifNRb1YSJMTjcVaNNwtLwTQy7EuKRSiOspeB/VV/FhlBfKjTNwEG/8SWd3ciY+NZMxUZhKYlutVqW/jJgXhYGrLEXL9lajkk943O+NQXxuibo4wdYW0+E2SDwxjnZgfyORev+P276DSUek0HQnBxwCymz3m51i9YI3AD+DKu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966111; c=relaxed/simple;
	bh=Txj2abbcynpukxZktzp0YnfflnoRpFkDmiMfYkEGToo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cbPc0fGs2gSiDcKUyTk0hvARoglXhjKwsQESCcZ8IyoeSLOPkHVHm4jYVo8fbXAE9ynZzVr2c/45SrWn5BvkF7wTCAAzcoW7ZSSWh44+cG8DWJKrHw/XTRtm98/M2U4zWQoET9FGjEhn1hlgSuHIvLpkwMAvx/QM6yQzAyJDWAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b=M5gOq8t5; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=markus.stockhausen@gmx.de header.b="M5gOq8t5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1788966088; x=1789570888;
	i=markus.stockhausen@gmx.de;
	bh=WeXWtQyEmsPmscc7bURmJBpgSw5sLRMDTh/MX7pZiDM=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=M5gOq8t5t4cKVVFwAU2+toQzQLk+Gjd5Yd/HWSjp34iVtl6RxHP4rW8rgCEqrvCw
	 8wZyQfCWuiDpeqd2vSkwZ4tvxiTimDo3OENc0VLiIaMU0E3Rx0EGlWSpTM6SmlEW7
	 260fzJ8nxck+UNLRRlI2hJ6WpAs1TczrZ1bOO3lweu/4/N3L9le1VPo0WB1YWY8VE
	 0XMw1ZACKcFWFF/GuJPgk1jTpW6Wwe3EHVEE6VPXT1Eits+u4SWkP8ZXr0kcac10U
	 2KF/GZpX0ScY6pGifXRCRj69gWsaCkiFbWtt9z8YE8Hkh3LWd4IVkzEAh6eY3eXL7
	 +AlGz7+TBb1khH6iEg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MDywo-1wwa2m1TqW-00CDJN; Wed, 09
 Sep 2026 17:01:28 +0200
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
Cc: Markus Stockhausen <markus.stockhausen@gmx.de>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH net-next v3 1/4] dt-bindings: net: realtek,rtl9301-mdio: Add clock-frequency
Date: Wed,  9 Sep 2026 17:01:04 +0200
Message-ID: <20260909150107.3602067-2-markus.stockhausen@gmx.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260909150107.3602067-1-markus.stockhausen@gmx.de>
References: <20260909150107.3602067-1-markus.stockhausen@gmx.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:grhZ2FAdO2c3N367e/+SqoR5M2XigLoMrnnIcMCjnmd4aOAoJdM
 dFS+P8p85UquSQmAX6qnfsdP83qPnZFACXd7kZW1LxKQgZ/HKu1p/xt4wBDeiWW7AgbEMX5
 rZacVniaKoESMpNm3HsCm9svfI3J2QElHQjHvSLplwhpY/rU0ZAvsEXFGqtIVN+WZ6LrfNe
 92KtbdeMNGTpunEIB7/bw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:h07auaLkflc=;TJZsulaI4FxGxEl4+qLizy34V2E
 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

The Realtek Otto Switch ethernet MDIO controller supports different MDC
speeds ranging from 1.25MHz to 10MHz. Document the clock-frequency
attribute for the device tree.

There is neither an official documentation nor any obvious registers that
indicate a dependency to one of the hardware clocks. The usable setup bits
are more like hardcoded values than dividers. Without further details do
not add a clock reference.

Signed-off-by: Markus Stockhausen <markus.stockhausen@gmx.de>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
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

