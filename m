Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951C3374190
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 21:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787173780; cv=none; b=G9GVH+VJYsI89w9lKwuj3YFmbeEEM6w7XqQoIeFV38sXbrs6TFZ3KGmmyMinKg+bYi8Juqyed0Fak+JXnW3j9wNnH33NE8Sy8r/AKS9Ym5sXd6gbHaECQh6MyK3SJIFDiOotsS9SlkO5ly/ZNvzkKS9hU0HrMLhX58WrN0fu7rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787173780; c=relaxed/simple;
	bh=HFDjAeI1SlPSqSFJRHxxd9HmnMr4li6oEcHHGxNMi3g=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rnF/y9+hVl1rhkMFsSCD6HE5H0VIxdlSahV7kpwm7iC+CGY8RMZbOMzej9kk1O2j5Z4FywRXp0LsEhUR3iEp05akXGqaWRgkIPa5Spoa+iBeBAFM7n7zI3+4/FJi03mBjLH1LJ4KM7TYA0CJUeGD4S1cHMsCSpI333gHit6IduA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=LjfMJ0eC; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="LjfMJ0eC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1787173769; x=1787432969;
	bh=psaydAglEa987Ndncl1FJjbuOqgMOJX4W/AhcRb6IQM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=LjfMJ0eCt+XlEpwNbkP0jmwpcu6SbnZabUj8gHrDT7oRoKC8ORSLdHTIV9bpDtQr7
	 54QQAnxIRsEgjkskQ6DlZenmr39jq99SKO5BYPm0U9Db59n+/nJRbBA8xwN+d9gzAa
	 2ClXilZVerhKcpv4uFG6ZnZaWlrh26lv0GDvRGga6Ay2P+86Izv82bV+/F6DUy5tnP
	 qp+6XBpUyt2eGp0srK0cvPIu5QVUD47GGZ8ZW7a8KONpFCr4ItmwcReIECbVfNjx70
	 q07IFzZnM4PmfelgbYm7/gavARg21sx365vcwXO3PUtLXzep1zVAGEwrKpQU8Jw0UO
	 yrJ8+aMHOb9Yw==
Date: Wed, 19 Aug 2026 21:09:26 +0000
To: oe-linux-nfc@lists.linux.dev
From: Kristian Brox <isyourbrainfoss@proton.me>
Cc: david@ixit.cz, krzk+dt@kernel.org, devicetree@vger.kernel.org, dmitry.baryshkov@oss.qualcomm.com, luca.weiss@fairphone.com, linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: net: nfc: add st,st21nfcd
Message-ID: <20260819210906.2500789-2-isyourbrainfoss@proton.me>
In-Reply-To: <20260819210906.2500789-1-isyourbrainfoss@proton.me>
References: <20260818205940.1973944-1-isyourbrainfoss@proton.me> <20260819210906.2500789-1-isyourbrainfoss@proton.me>
Feedback-ID: 203906395:user:proton
X-Pm-Message-ID: 56e2fb79c5845bdefa25f9a8661359ce9d430825
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

The ST21NFCD (e.g. Fairphone 5) speaks raw NCI on I2C. Existing
st,st21nfcb-* and st,st21nfcc-i2c compatibles stay NDLC. Add a
separate compatible so those boards are not switched to the wrong
framing.

Also document the optional SYS_CLK (clocks) and VPS_IO (vdd-io-supply)
used on Fairphone 5, and add an I2C example.

Signed-off-by: Kristian Brox <isyourbrainfoss@proton.me>
---
diff --git a/Documentation/devicetree/bindings/net/nfc/st,st-nci.yaml b/Doc=
umentation/devicetree/bindings/net/nfc/st,st-nci.yaml
index 1dcbddb..4bdbb36 100644
--- a/Documentation/devicetree/bindings/net/nfc/st,st-nci.yaml
+++ b/Documentation/devicetree/bindings/net/nfc/st,st-nci.yaml
@@ -11,10 +11,14 @@ maintainers:
=20
 properties:
   compatible:
+    description: |
+      st,st21nfcb-* and st,st21nfcc-i2c use NDLC on the wire.
+      st,st21nfcd is ST21NFCD with raw NCI (no NDLC PCB).
     enum:
       - st,st21nfcb-i2c
       - st,st21nfcb-spi
       - st,st21nfcc-i2c
+      - st,st21nfcd
=20
   reset-gpios:
     description: Output GPIO pin used for resetting the controller
@@ -36,6 +40,15 @@ properties:
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
@@ -49,6 +62,7 @@ if:
         enum:
           - st,st21nfcb-i2c
           - st,st21nfcc-i2c
+          - st,st21nfcd
 then:
   properties:
     spi-max-frequency: false
@@ -81,6 +95,27 @@ examples:
         };
     };
=20
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells =3D <1>;
+        #size-cells =3D <0>;
+
+        nfc@8 {
+            compatible =3D "st,st21nfcd";
+            reg =3D <0x08>;
+
+            interrupt-parent =3D <&gpio5>;
+            interrupts =3D <2 IRQ_TYPE_LEVEL_HIGH>;
+            reset-gpios =3D <&gpio5 29 GPIO_ACTIVE_HIGH>;
+
+            clocks =3D <&clk>;
+            vdd-io-supply =3D <&vdd_io>;
+        };
+    };
+
   - |
     #include <dt-bindings/gpio/gpio.h>
     #include <dt-bindings/interrupt-controller/irq.h>

