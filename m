Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13FEA3CC338
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 19:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786909197; cv=none; b=LE3MaK+Z5FRkXwu21HtyKDo6BYRK/Yxph7i220NzbK1ivcpH3LZlzY+enQRsyPZ5zppSdXUs+I1WttJWG1c2WycSxtpHNNdp+x2EtgbBGNSY8xTn3p/nzwi/BjAanQV1sZi/4iTE+JcqIzCSXTJh12dLcvLuvOmi0sPjXpnecwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786909197; c=relaxed/simple;
	bh=p+sNV03OlGGYrUReYHOX7R8PzXHgdO/RXCMs0dYPR+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Su1k6WpWQvvUQTPQSbchWeIJ35A3+ZMSS2VC8PyAc3BaNto+b0/nabjjTmUeor6ukEa0ivGY+IzIsmGkcRezQoGyzG5cEs30JHyzE0eQAqHzFdOz0+pBiGQRbnsBdTsxhlM+RvcyfqKpbgpCQ7npf9oc/ZtDRgitHbkLSyXi3Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KP+k0r6N; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KP+k0r6N"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so2709360a91.0
        for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 12:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786909190; x=1787513990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4r7CVU6P+Php5YYpvBxb/ynZhMEbMhKfdVoPSFU1jjQ=;
        b=KP+k0r6NVsOODmK7Op08a1NwvY2WxyvbI8G8OQrVwUTzPLpZkPjSm5wS+vy0snjEEJ
         CSwCgarAA0Hw3/ndJDAAFiFOsOTI/BwiTs7Telp4Z2mO1sz9tFjV3jL+69jBcUvkCADK
         2RgNF4zwlIXDXhcklJQ8sxTcuUwQQQZj3T77JQ8zialpLGR3LZ73lRZveXP5umI8PTnO
         LOdaZiLKe4KD+5DdZmTvKfggh4ptetzVr76QV1MFn0WzhVnGon4tHNsMpkGWNTKodaVh
         RAG3YoErD8jzUrgAROR9gwwEDYf0zTntUF8/HncljYm0+ozA/mHTQtGZKuk6D2xt8bvd
         Hxxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786909190; x=1787513990;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4r7CVU6P+Php5YYpvBxb/ynZhMEbMhKfdVoPSFU1jjQ=;
        b=YfepkPKOoWOOZLvpiKhzkG9E31aQ8as3cspmfQAHsjMAZT3DvzaO6ejr8MzGCqtqyl
         x/Ji7gJPpxlcvb5HpahbNPHN9PN24Tk4Js3bnbXxM5991Z1tlTp5VHb6PznqbP4iJoGP
         2NXO1zIxcCLQ6AsA8TqXs/gYxG7mKDGTW1zf2XL324AaYSiYclVvwYzv/aLNFiV4cSND
         0dgZv9i8inesFSSdRE5VCySq43HEMeNqlsapat7PSbYcMA8+ky3xaxLSjgfw/hA2lcHo
         jE2jgnbjubewayFvaJ9mr2CZV0fpfeypKU0ZsUNF3lnOPgBYx7p5wfEVWiQxszzwvLVS
         v/WA==
X-Gm-Message-State: AOJu0YyS1R77bmx/KFqsTBuS78OQDNKr7tBUnMahahnK+wlnC2lEJ7SX
	R3sfDUm02Ihitly7ZNun/zplhgd8GIZwThVy8JCnpFZIZCrXH1f9jxtdokj58Q==
X-Gm-Gg: AR+sD12b4dLVnfI+9qWaIDAAQ/vEE90pP/4I8mkhWE0/sF8mDPdF34oTirSNlHR5ymI
	ngnTj+RYcfwREZc+2RzS+d8aRcYNpwBbMRXGO4WWax4y9uNJqEUox87IhosOs6LR/bHhjoynnx0
	xBLGiGz/S8UYT7j8eQWY+ebsG30PF28mxu+tuQEvlvSzc3vO69uRRhZSJDl2D8tdz6hwL+JBgQl
	TYt0QFFf+m3wa9YTS5uXQo8jZX530DBgYSlQ/BiXsAOGcx3dAvk/tVRtB0SLyLVC6sK4A44ZINd
	HCSlZE/aOh/uwRcFbR1YEYW/bIMYGEhgmKfeN5CNvKJMh8b0aR9aToSCznelRXtHRkW0MyTY/UU
	+DMR60BeebemW//XRmOduE+zLj4biSo/PxebVJefSJDva2PhTNwwRzMxDME9DldPGkqE0Hj3wnu
	T97u6ikS63BMLbQ2X5Xiny9prRmgwTbO+Y5ybM9+UqKCsFgFU8FidGPF35c0g+gIjSBttdWibRs
	tPUJ3vIIHZ6hqw=
X-Received: by 2002:a17:90b:57cf:b0:390:8361:a532 with SMTP id 98e67ed59e1d1-3933b8072a0mr22653003a91.7.1786909189720;
        Sun, 16 Aug 2026 12:39:49 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:d30::4cf:1a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39531e10d9fsm2244065a91.3.2026.08.16.12.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2026 12:39:49 -0700 (PDT)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
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
Subject: [PATCH net-next v10 4/4] dt-bindings: net: dsa: yt921x: Add LEDs definition example
Date: Mon, 17 Aug 2026 03:38:59 +0800
Message-ID: <20260816193905.218112-5-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260816193905.218112-1-mmyangfl@gmail.com>
References: <20260816193905.218112-1-mmyangfl@gmail.com>
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

