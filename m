Received: from mail-244121.protonmail.ch (mail-244121.protonmail.ch [109.224.244.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156EB385D6B
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 20:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.121
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791233524; cv=none; b=E3M0KBnoZW0iRI/cDIjuQNL/eypdStHZQPsuADteUjKSBRRvayOXzI4JIcsioZ+oKvQFIdolBMqtNNLoqRZ9p106CVEdUyGI8fHLJ7QBMhMQ76cyfN9c8FnNJ6S4IzprFPRgs7TKZF5zlR+9JLXCv5fhKbbbC6SLP6Jauex3U4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791233524; c=relaxed/simple;
	bh=uawxJTYUpagfB2bEzjS87yn3PM8pVynT2Bo7e717srU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q1O+rSE7S3hGXU02SuG1b5QqbAC3zZFDlaOUYGiJoif05QxP1WqcgoIFCJ5v+QB/kK48IA0ctGW5j7SNCKH5M5CWtj5n9Rer4h8UDFuriZ6WPj/l3cH6xvTlpzZ2EEsvan1/vhdUhB4IkyK+hFepNPT1PTl27jmrSZj8lwfkibE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=QoQClmGA; arc=none smtp.client-ip=109.224.244.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="QoQClmGA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail2; t=1791233512; x=1791492712;
	bh=/IkGLQOyLVOs4REBwahO0mLaLZQ3lLafg8HHnR9ztYU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=QoQClmGAqla4ojd3IEzjeeWbgk857Dd9KxtyTfdW6B1GAcCy5O7W+T8j7mJKpRkcx
	 e3ZBJc/dwdxrdiBHCRL9NUuMPj61tCCyRcfvrqOat0zij3VU4tlXspXZSpkmGKV+E7
	 fJQE8KbcFColIGx8V1FrxBkW6RephxVPzpioDvDr0jZakVYXGDbU2FIl4OIr2JNOoP
	 HRZP5Jc+b374xmPwBy/NE6/R7vCgHSzaprFSvs2ylPwxO7e34MXpEcOqILNAUft67f
	 uECi4UUtAKirNFHdaYR3kJ1iSu/w/jUQjopiZO8aJl2OO1X3j3BGfxEwa7OwPAc+Pv
	 P6qTWrv/gAO5Q==
Date: Mon, 05 Oct 2026 20:51:46 +0000
To: David Heidelberg <david@ixit.cz>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
From: Kristian Brox <isyourbrainfoss@proton.me>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Luca Weiss <luca.weiss@fairphone.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Kristian Brox <isyourbrainfoss@proton.me>, Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v5 1/4] dt-bindings: net: nfc: add st,st21nfcd
Message-ID: <20261005-fp5-st21nfcd-v5-v5-1-7be15a86c61c@proton.me>
In-Reply-To: <20261005-fp5-st21nfcd-v5-v5-0-7be15a86c61c@proton.me>
References: <20261005-fp5-st21nfcd-v5-v5-0-7be15a86c61c@proton.me>
Feedback-ID: 203906395:user:proton
X-Pm-Message-ID: 6e23999622433f70f7fb6821a49cd73a8ef60c23
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Add a compatible for the ST ST21NFCD NFC controller. Document optional
SYS_CLK (clocks) and VPS_IO (vdd-io-supply).

ST21NFCD is not I2C-only; the ST data brief lists I2C and SPI.
Split the spi-max-frequency if/else: forbid it for
st,st21nfcb-i2c and st,st21nfcc-i2c, require it for st,st21nfcb-spi,
and leave it optional for st,st21nfcd. Add clocks and vdd-io-supply to
the existing st,st21nfcb-i2c example instead of a second I2C example.

Signed-off-by: Kristian Brox <isyourbrainfoss@proton.me>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/net/nfc/st,st-nci.yaml     | 49 +++++++++++++++---=
----
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/nfc/st,st-nci.yaml b/Doc=
umentation/devicetree/bindings/net/nfc/st,st-nci.yaml
index 1dcbddbc5..8abafb3d8 100644
--- a/Documentation/devicetree/bindings/net/nfc/st,st-nci.yaml
+++ b/Documentation/devicetree/bindings/net/nfc/st,st-nci.yaml
@@ -15,6 +15,7 @@ properties:
       - st,st21nfcb-i2c
       - st,st21nfcb-spi
       - st,st21nfcc-i2c
+      - st,st21nfcd
=20
   reset-gpios:
     description: Output GPIO pin used for resetting the controller
@@ -36,26 +37,43 @@ properties:
       Specifies that the uicc swp signal can be physically connected to th=
e
       controller
=20
+  clocks:
+    maxItems: 1
+    description:
+      External reference clock connected to SYS_CLK.
+
+  vdd-io-supply:
+    description:
+      Digital I/O supply (VPS_IO).
+
 required:
   - compatible
   - interrupts
   - reg
   - reset-gpios
=20
-if:
-  properties:
-    compatible:
-      contains:
-        enum:
-          - st,st21nfcb-i2c
-          - st,st21nfcc-i2c
-then:
-  properties:
-    spi-max-frequency: false
-else:
-  $ref: /schemas/spi/spi-peripheral-props.yaml#
-  required:
-    - spi-max-frequency
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - st,st21nfcb-i2c
+              - st,st21nfcc-i2c
+    then:
+      properties:
+        spi-max-frequency: false
+    else:
+      $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: st,st21nfcb-spi
+    then:
+      required:
+        - spi-max-frequency
=20
 unevaluatedProperties: false
=20
@@ -76,6 +94,9 @@ examples:
             interrupts =3D <2 IRQ_TYPE_LEVEL_HIGH>;
             reset-gpios =3D <&gpio5 29 GPIO_ACTIVE_HIGH>;
=20
+            clocks =3D <&clk>;
+            vdd-io-supply =3D <&vdd_io>;
+
             ese-present;
             uicc-present;
         };

--=20
2.55.0


