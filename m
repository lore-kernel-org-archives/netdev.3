Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D83C3AC0D9
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 04:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788151771; cv=none; b=Jk5juXfjjEbgM6riMmqXr+wU7Fu3CJluZ/sI4dIUh1wTPG3EpY28nQ2VMaf9uvWo2d4TgBMmepRZa+3jwyybzeMh9n+yY5Sfvh6Y61j4NRF4bor4vf7CNBBmVr2lpG/Kgq63ArttGvXz/n6Ch2lQ4mLHhpnxItOyNwYmGrNvSI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788151771; c=relaxed/simple;
	bh=xfLwN1G+HlsExvrUNsOEe+WbN3dPn7HjsbyOumjvMds=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=grwLFcufdH952Nf/z8KeTQqfsDtV2WBMmK23w2iNgMwveB9MuIlHTSZSi+nSUv2yfoP2ZualOdtRlviXqrI6rK4TIkmdwnaFgTVz4lPPUWhmG/F0aq/yOwrRQaIYQDzDV9V5jjyBweqyLQ2spTfXL84v4metgQfRJyCisjjhd1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i8wRv7Le; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i8wRv7Le"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2d72ae08fa1so24312575ad.2
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 21:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788151770; x=1788756570; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2YOr/QpJoSwvrQj9qbBH1jCsIxrm/W8lOOhFj883C40=;
        b=i8wRv7LeHbFBTZEnjcyt7BJ2gvU6Pza9FrQN6TnwXXEqgfHLoPAyS2RZ1oNOs6gtsu
         hNTf7WQ2AfbvTczbi1LIiPoxU46wM3Asz3CeUlQmACHVEA45KKIfnrphwsNJHpfa9ZRO
         xsIs4g/a5UYRqcdpity6u+qd4i2kS8HWFYK3M0MwJHg8oWPfacuVf9CaEZ+rAvomtpTK
         shMLs4sW+fc0Fcs05eE7Ny0UTUBUbZMdF10QpmmMuwsGUqoq4VWDZvHBXuKEp8Rt+f2F
         ebswOyAhCq2/VT50TX3+H4uxomEHXi3UThJYJn3xZpWA2g6Ak8WMY8pkCfB/j6OdoNKv
         HmGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788151770; x=1788756570;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2YOr/QpJoSwvrQj9qbBH1jCsIxrm/W8lOOhFj883C40=;
        b=SebS+yAyKyLskDbrAlGDBJ16h7evR2aPLHx/9L0ddQugsXLfhQTibX9v6irvsDsLdE
         HMSpdefM8TLTorQTHGJdkR9Cq8Dp1Hw0WHFIqbLrpg8Ghc2Iyw/yXv7UgOASOMyifW6+
         N4MG/PsQ9ue0YO7t4vJTsmpWPJ2WI9EZZQiyogTejXEik1VcFMm8gicb1pg/BO2fjcIG
         dojYEaBZSooac+PDCl9hmFmVE/aFxyP0bpxxsGHhFs0lJ+DLpSCZVID6ZnP7NoKSUBAE
         +Rpz6tCSz1kwhFqrqRkqWfljDUTbcsOCT0fGRyyuwutQhMQLzFRKfO9gngj7pd7VmGmo
         ZHxQ==
X-Gm-Message-State: AFuF++nh4FT+vriSdANTkmjcD++/xis6LyIhv2BNx1iQt9mEtjZHf0vG
	74EH9q3hEJGiCrRga5AkPn8R63TzmVXA64SLMW5WglMDhtBob3tMjTjeKCQcXV/E3ho=
X-Gm-Gg: AYBFou3290+p0xdNrfZ0tFa9m4LxfekirqZC9VGj6Y20LhqT/P8CjjY41U7FN8OsdOH
	AFbKdEADoJUTK63kzddQ3vWpiIqXln6HOvNbLxI1lOANeGUl9ZSWHr2u6YTvj4W41ohe29hK4nD
	DRlEhtZF55eTpoMYin+tHu+Li6vW3KXC+2Fxz4q2rrpLPhCWkTk6cggBthQjL+Dic6j2hOJAUIF
	adbY/A3VKpnbvfo2eLrMaf3Qy8lJ/QWjrZ22nh4zbRnFuynJUg0UeMcHSD/vB3Djw7yVbXrqfxi
	904bXI0U2iut/zcYqpmawwBsYVBtibfifW7gDGaJkaNp9B8jOJpvALL14mFoffYEIgMJoTCqiiX
	EbOeaMmpf7J06+rDsOyagNDsHYbEyOdmgVN4LUiKhePlMYJdC//az/U9ZA4yNXf848O/00pgpWp
	qFc4pCXdV48P30c4AP5T6BXY8D5Hg8flyGA7kDQXdYAbTu+9OqKLONTYqG01HpC1fTlRuQx3vLQ
	05a4Mwq/ARarw==
X-Received: by 2002:a17:90b:524c:b0:366:3517:1aa2 with SMTP id 98e67ed59e1d1-398f7eeed6amr1371508a91.0.1788151769702;
        Sun, 30 Aug 2026 21:49:29 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:d30::4cf:2e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b0fd5c34sm19345763a91.8.2026.08.30.21.49.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 21:49:29 -0700 (PDT)
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
Subject: [PATCH net-next v11 5/5] dt-bindings: net: dsa: yt921x: Add LEDs definition example
Date: Mon, 31 Aug 2026 12:38:58 +0800
Message-ID: <20260831044818.4103477-6-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831044818.4103477-1-mmyangfl@gmail.com>
References: <20260831044818.4103477-1-mmyangfl@gmail.com>
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

