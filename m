Received: from mail-43101.protonmail.ch (mail-43101.protonmail.ch [185.70.43.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D534252B7;
	Wed,  2 Sep 2026 21:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788384161; cv=none; b=YMO+8NYr/BPFGxIOJl9rGquWFZKKcQdcdC40D44KVOIwSfxJUI/UfmzN7wKR8MftZS6Fx7ajr+39khO26d58LHPp0rOWXm6Ehgm2d8aE7Iv83Im2bG6HwYo7u8wR44xbmEkNnIIUa+p9XZ6mGt+VNpIY2Hr0SO+9s15yWtq+alU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788384161; c=relaxed/simple;
	bh=3gj0kSLsPkp7d/bNS6rXLOSD9pvnNEbtOz7WcVsgHI8=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U+qqguvsxbNZG9nu+zDiDTVDNEAzyTZB8ewox0bozjUYupR59F09l2EPX3p1w7/8hrl65hTr5GS1bb1kbvP/VPK7ChmetX4F1KK0twmK8IkATIXyaqJiVD2m6uiZuqaJBFGWTS6AWYz7j5rGxhvUW3vnNoRIfIQaVcG4Cg33IMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=J6LERhRX; arc=none smtp.client-ip=185.70.43.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="J6LERhRX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=bttjsimnxnbpbgimf4fwcpgurq.protonmail; t=1788384142; x=1788643342;
	bh=dS3+A9eI+tmeoJ5w1r4TVLIeNSpcjB+BfvEJnyPVnDw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=J6LERhRXAhtAdBq025g77m/FcORrkbEZrIkkiRettxL+koUt2nbznZ/1nxENk3Duh
	 9DAvo/1YMs0DOccL+hWx4wJWUnT7ljGWX0zrYM13r5MO/mHaZAOxiQFJ+PNMW21j2E
	 wXJVj3VwnmLqXIGS9HwgmR8cWCJFHcU9pdmOVMz36kM1hpVUlm4mRWfL8dpWCaQo6q
	 Os0QPk2EvatNXGtY8gIUO7LgUmf/oQ+yyAK+tZT3FBBumIaUA51gxnpouhE7vkThe3
	 MfwYAPgWjo+dogqeCCAee1kbkZEFmYNOUid/bGgucGGLXqlsDrzJ/yNDUzqi2Zpvl7
	 IP6Wpx4Fs8iPQ==
Date: Wed, 02 Sep 2026 21:22:18 +0000
To: David Heidelberg <david@ixit.cz>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
From: Kristian Brox <isyourbrainfoss@proton.me>
Cc: Krzysztof Kozlowski <krzk@kernel.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, Luca Weiss <luca.weiss@fairphone.com>, Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, Kristian Brox <isyourbrainfoss@proton.me>
Subject: [PATCH v4 1/3] dt-bindings: net: nfc: add st,st21nfcd
Message-ID: <20260902-fp5-st21nfcd-v4-v4-1-ded2f1c501be@proton.me>
In-Reply-To: <20260902-fp5-st21nfcd-v4-v4-0-ded2f1c501be@proton.me>
References: <20260902-fp5-st21nfcd-v4-v4-0-ded2f1c501be@proton.me>
Feedback-ID: 203906395:user:proton
X-Pm-Message-ID: 60a34411ed117ddd54a64cbbc892ca3c69075bec
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
---
 .../devicetree/bindings/net/nfc/st,st-nci.yaml     | 49 +++++++++++++++---=
----
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/nfc/st,st-nci.yaml b/Doc=
umentation/devicetree/bindings/net/nfc/st,st-nci.yaml
index 1dcbddbc5a74..8abafb3d8994 100644
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


