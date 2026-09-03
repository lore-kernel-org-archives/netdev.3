Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637CF374E6F
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 03:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788405429; cv=none; b=qM9RafjDuEXoqEO4r2tUVtPZLBqtI2oECBT9Z3vh0UvremMnJfIQZZtbcaV6MV6oFFW15JNT3nvXSaUNBtxlsqbqvjFsgLONFA8063arM+Lhe8a3rn6i3Lnd66rwlE5bkIDuJ9e7XVwkH+IaJSmEuUTmhd5imChdoAlU2AbmtSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788405429; c=relaxed/simple;
	bh=xfLwN1G+HlsExvrUNsOEe+WbN3dPn7HjsbyOumjvMds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oFL9iFol9BZX2mqwWJxTGpwFmygoGd4VhRndrJSZcpAXv5QzTFMYz+G7z1M9b+dhtitFo6nIsLSBADRPtkyewaEAEy9YVHT69gJCAkiFyLCsdWuk5J6buCniCyOEiXBGUpG9EI6dPH95twKIzOxDZ4R53zhOJwAdDVvzXOfFXQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i7Jxqm/7; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i7Jxqm/7"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d9201076b3so22941465ad.0
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 20:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788405427; x=1789010227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2YOr/QpJoSwvrQj9qbBH1jCsIxrm/W8lOOhFj883C40=;
        b=i7Jxqm/7WejyZskOpJrAagtpU2wqeTz1tqP3fa3PYs9LEQdZQ1zs4FfkNomU0ik+vn
         +gz27rJdwbWxFQjlAtw0vD9u/E6A5IqSiQuRwM8QAWME+2d74icpgdNOzEsabnMsD2Eg
         NcIJS0I6t7/npRJDkKDiGtF/0I0F3JyDx9LCwwOdMPM7+e8ANV3YnGbZoONfxPYdMO8R
         BPqA24pzoxKIVziMUtzOuRQdw7R57T1KCCT0HbF3WMjShCVyy6K3rV+FRwM76IhDUFKy
         3Ncn5cFMDsDL30utsWGuHzxCPnR5/ZXsUHYm/f1tX0Orny+DPUpK07m2EQ6HSkv+7Rcs
         u/RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788405427; x=1789010227;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2YOr/QpJoSwvrQj9qbBH1jCsIxrm/W8lOOhFj883C40=;
        b=B04tkRBvH6LN5nLGFJFHqoAPVjuia+1rMLhnidORc6TX02+6YUitgExw2JTG79vhMR
         5m0Au58Zavsw9GEB908xnlOcsqXMFamp27sQ8fItkF0/rzZZx5a4gnx7M6ImJ0rU0x4g
         4dUrIG6EfqHttGy4lrojZ8QcWOyNTK6ZPSGqz+2jM1fZCc5BfGWm5N/qfE+aYvGqrBj9
         dcAQaQuF1L3nYFW67Ytl/gdfJVxxtMfxmSgkg3YUlVLNIAYtupz+tnOWBwtiMEpDGKOE
         HLwqxHXqWYdRdcKX7st6bKnqgJCs7POW2Hi2zcAiSVorYXXaEU+IOhOblAVUZI9Gp9HH
         eB1Q==
X-Gm-Message-State: AFuF++mzmyvuJEeua0RcA/bOHpR5wPSNBPJzB7chZBNlui9OSRQpQaKu
	AGVy1LmFNQHxhqIKdvwkpnjLTOdUlvJ6Af0Qbztm81jAKMVCpsnl0boIN4mkDg==
X-Gm-Gg: AYBFou2tFu7bSGXXvd/7waWNKyF71+SDj7+m5C16v8QlDZW350LsGMv7LfxODVKpkOg
	t1TAWnacKGqY7QICUVsXk7/klRFDgIzuU21xQOmXSdOupySBVU7q6E2dnksKyOZJ9qBbyNEKcc8
	W0xN702fCi29BmrRHQkcY/3pQSNHXqGWY6moS2exKz+1EthYvE/sh2YedjkOJgEiovAAdfd+R89
	9N4JJI+cK6hGzoIXcdt+tKwN/G2hWOXIOa8GUmfO0awQRvRDUWMO3EPYKUHoGUvf6jMvjzpcahC
	ko56uH7WM8/wq51s1TfVKdpzVi0hOlpkpy++uYNe0j5Zr/v86ZWlFksA2ZR8RlafDcid/gSjV3K
	62YyuvgNhcnW7I9aDaus++N1VGGpjZrx9JFixaGQbyOpyGx42EdWvaAH7zZtquef2i4OfW4dayf
	dPGZWFDTxJVIaBHf7YASsWCsxY/8/I+cSc4Xf5X0kdWy+KayI+PhQs5Szsx3ROMWKc/P8rmjjFg
	b8IYzRgPNS8dtjMsFf6RDHbtg==
X-Received: by 2002:a17:90a:f94f:b0:398:bacb:1137 with SMTP id 98e67ed59e1d1-39aee21a4demr15444319a91.19.1788405427390;
        Wed, 02 Sep 2026 20:17:07 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac5:661d:3050::4d0:16])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08c397b1sm2244114a91.8.2026.09.02.20.17.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 20:17:07 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v12 5/5] dt-bindings: net: dsa: yt921x: Add LEDs definition example
Date: Thu,  3 Sep 2026 11:16:26 +0800
Message-ID: <20260903031630.356840-6-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903031630.356840-1-mmyangfl@gmail.com>
References: <20260903031630.356840-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add LEDs definition example for yt921x to describe how they should be
defined for a correct usage.

Signed-off-by: David Yang <mmyangfl@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/net/dsa/motorcomm,yt921x.yaml    | 23 +++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml b/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
index 33a6552e46fc..93ba5b181205 100644
--- a/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/motorcomm,yt921x.yaml
@@ -21,6 +21,9 @@ description: |
 
   Any port can be used as the CPU port.
 
+  Each port has at most 3 LEDs connected and can be declared using the standard
+  LEDs structure.
+
 properties:
   compatible:
     const: motorcomm,yt9215
@@ -59,6 +62,7 @@ unevaluatedProperties: false
 examples:
   - |
     #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/leds/common.h>
 
     mdio {
         #address-cells = <1>;
@@ -113,6 +117,25 @@ examples:
                     label = "lan1";
                     phy-mode = "internal";
                     phy-handle = <&sw_phy0>;
+
+                    leds {
+                        #address-cells = <1>;
+                        #size-cells = <0>;
+
+                        led@0 {
+                            reg = <0>;
+                            color = <LED_COLOR_ID_WHITE>;
+                            function = LED_FUNCTION_LAN;
+                            default-state = "keep";
+                        };
+
+                        led@1 {
+                            reg = <1>;
+                            color = <LED_COLOR_ID_AMBER>;
+                            function = LED_FUNCTION_LAN;
+                            default-state = "keep";
+                        };
+                    };
                 };
 
                 ethernet-port@1 {
-- 
2.53.0

