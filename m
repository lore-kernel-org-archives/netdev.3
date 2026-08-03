Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1B71A5B9D
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 05:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785734125; cv=none; b=rW9xZ/6cWU9S3NVAQHXjVVlUogA2wH/wmdftxyws6lFDd/0U0v88YiN5FR12fdMCjbS9NjZNOkAewAk5T0suHn+f1771vqc7pb5O0rUD0E49c4k/aJwkYeTYHmxyeYnWK4WkKP+70PW7y6OZ+Bscf6CXcmOnM3ZjQN0PCXeRrtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785734125; c=relaxed/simple;
	bh=n3evcqugoeKkN8mct7F9d78wCyor72fP/A5f+80l5jE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I3iRojXKrhG/i9tC+ESmmKw1g0qTeFFTazIGAiqPN2nt3zTTfmRlZk/AIItiZyKedPT1rUCf3Z4Z5FZPGPDTIS2+Y3dSK1ZGqiKCp4O3UYFr0ABKBLdxlX/W6pQrD6XQTGiNvHPzqMxjIGwQOCzMB2OIbHW0XsHGU7O19RchxMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FaR+wWi6; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FaR+wWi6"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7e9d7464b71so1367417a34.0
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 22:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785734122; x=1786338922; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LDt8py0RwqfKJ99qa00T7ayi3DardBnaCg62Nlf4UJY=;
        b=FaR+wWi6UhUqKEIX53WQXfc/1eP4OYnxbayHoUgSKSjkQjvp8ZxHwQSDe3zsLXHBBG
         62wxSOPS+x0uCk3zz1RUg4OMugJK18WcDarGsdN8hqp6LKs1gQ9bxtYB5kiV+X/W45o4
         QIZsqVkh+lyOVjOcO+FuXkLcwjaek92zjlFAqtDaNP0z0wydU0yt8TUMvxiXzwgr8MYk
         17IALm0/6PvkbDYl4EbVQjOU0PJw+lFCat6uqhZbYv78umvW6g0P0Gc9zIJTiP4W+dW2
         T2/qXCJl1G/bnG1ql1QFKDw0JBJKzgJ5+TMfMWdbM3jVabI0IhqAmxiMRrdC3QuT/Mi1
         Raow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785734122; x=1786338922;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LDt8py0RwqfKJ99qa00T7ayi3DardBnaCg62Nlf4UJY=;
        b=D6t4zAcF/YnNWxH4fKjpG0Pizug17hdTJUuMF7r9lc08kNVJNlODhBXrBqhyckUYyo
         WjGWHOQo6hHpDbi/ZgYzXX3mxG/971vt9Xn8JyGdgdEAJ4Yg/aMYS2ShI97Uoz+bxc/p
         Unh6Z3GPHlytPB7FzC6ljwgXUAWY68jOEBL9wJK7jKxhek+MrWKLuIw4BgdxuztU0F/a
         O+MIpyr3bDHCEBeRE3Sf77NlE3iAZlnilveIkxVFb/IMO9zX6F9Z1KwB6qZ4KbahVdHE
         IMntK2OCDvRH3tvlyXtt5eV+x03kiwpnxJfIFHtBhITjjOFbEuWRy28UNWLBPvuhhVMf
         +VRw==
X-Gm-Message-State: AOJu0YxPV4B619y+aX/PyKQX82qv5GY/OziJIBwkAlAtD4sitlZdH9uR
	ICTGx6/9wn81rawaiBRN/lhYqGP3NT8BWLqrSVEmnQmc5fSuYIm/4etn
X-Gm-Gg: AR+sD114eCTCaxXVA9U6SQ9XB13Xo/oQFqO7EeOsRWIHP9EVefu4U3vmX8OGyYCYees
	3dN3Qnbwo8G5DYmTqoFsJI83Aut66bUxIa/k65epPk4FaeFqgkvAb4gCw3eMroTj91QH1SUyKMJ
	he/gbAsyiO7D60419GGE27pw1eiVMlm90jc2aojNWBk3Rn1b/ixivvkePh8IJTsePSjVvJEtPN7
	ElvuQmlbSjpXDan0oF+PVC9VK0OHRk+TqEoM9OT/6s1D0Iy7x71qjv39kLoqXqtW3eDh/bGR6Tm
	iLbLZEayAlN9MfSt57S9KDosU2eLBz7CvefkxYZQL1gJz0LPF2LnTvls1/+d2qtdsd9TwZ7JlmF
	gwtjiuNMgzUwKEoAoQKIO7LD5SDaQ89uA4z28+l+PJisHgr/awW9fBkJOk4BwDUpAFdbIYppB2g
	44IHDyeqQ1zQv5Mlqp+lHIWRmB0M/SSyeF3Bik9TYozhkjq/Fhqo7NPwYB3QCwZEj48cpSC+SJQ
	F1kqXxBhTgXjv8LdeUgksGSljR1K2xT5mqilmClgt3+wXaTk25AbNlNU0W5KZSKI1PTOYCE/SVS
	Nffz+ovoqjAngfSXjjhzVWfGVZLdWc9ywjB+7K5KMo7isVjoK9oe+DXbFdlepfSqRGfld9Nsclh
	prevOocXIJH/RtSmZlbptQ7/v2mDIVGn0E9D3
X-Received: by 2002:a05:6830:83b8:b0:7e9:d277:6e2e with SMTP id 46e09a7af769-7f196cae28amr13872954a34.7.1785734121347;
        Sun, 02 Aug 2026 22:15:21 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18f07a5e3sm6787108a34.15.2026.08.02.22.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 22:15:20 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 02 Aug 2026 23:14:11 -0600
Subject: [PATCH 01/21] dt-bindings: net: allwinner: add H616 EMAC1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260802-submit-acx00-of-dynamic-v1-v1-1-0a53cd9e21cc@gmail.com>
References: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
In-Reply-To: <20260802-submit-acx00-of-dynamic-v1-v1-0-0a53cd9e21cc@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Andre Przywara <andre.przywara@arm.com>, 
 Richard Genoud <richard.genoud@bootlin.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Saravana Kannan <saravanak@kernel.org>, Lee Jones <lee@kernel.org>, 
 Heiko Stuebner <heiko@sntech.de>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
 mfd@lists.linux.dev, linux-rockchip@lists.infradead.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

From: Richard Genoud <richard.genoud@bootlin.com>

The H616 secondary EMAC uses a separate system-control clock register
and supports only RMII at 10/100 Mbps. Add its distinct compatible
without an older fallback, since using the primary EMAC clock register
would not work.

Constrain the PHY interface mode to RMII, matching the hardware. The
EMAC1 clock register also retains the three-bit TX and five-bit RX delay
chains, so allow the existing Allwinner delay properties for this
compatible.

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 .../bindings/net/allwinner,sun8i-a83t-emac.yaml        | 18 ++++++++++++++++--
 Documentation/devicetree/bindings/net/snps,dwmac.yaml  |  2 ++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
index 323a669fa982..34def84e6c21 100644
--- a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
+++ b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
@@ -21,6 +21,7 @@ select:
           - allwinner,sun8i-r40-gmac
           - allwinner,sun8i-v3s-emac
           - allwinner,sun50i-a64-emac
+          - allwinner,sun50i-h616-emac1
           - allwinner,sun55i-a523-gmac200
   required:
     - compatible
@@ -33,6 +34,7 @@ properties:
       - const: allwinner,sun8i-r40-gmac
       - const: allwinner,sun8i-v3s-emac
       - const: allwinner,sun50i-a64-emac
+      - const: allwinner,sun50i-h616-emac1
       - items:
           - enum:
               - allwinner,sun20i-d1-emac
@@ -91,6 +93,17 @@ required:
 
 allOf:
   - $ref: snps,dwmac.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: allwinner,sun50i-h616-emac1
+
+    then:
+      properties:
+        phy-mode:
+          const: rmii
+
   - if:
       properties:
         compatible:
@@ -100,6 +113,7 @@ allOf:
               - allwinner,sun8i-h3-emac
               - allwinner,sun8i-v3s-emac
               - allwinner,sun50i-a64-emac
+              - allwinner,sun50i-h616-emac1
 
     then:
       properties:
@@ -109,7 +123,7 @@ allOf:
           maximum: 700
           multipleOf: 100
           description:
-            External RGMII PHY TX clock delay chain value in ps.
+            PHY interface TX clock delay chain value in ps.
 
         allwinner,rx-delay-ps:
           default: 0
@@ -117,7 +131,7 @@ allOf:
           maximum: 3100
           multipleOf: 100
           description:
-            External RGMII PHY TX clock delay chain value in ps.
+            PHY interface RX clock delay chain value in ps.
 
   - if:
       properties:
diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 2449311c6d28..102ec98ac2a0 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -57,6 +57,7 @@ properties:
         - allwinner,sun8i-r40-gmac
         - allwinner,sun8i-v3s-emac
         - allwinner,sun50i-a64-emac
+        - allwinner,sun50i-h616-emac1
         - amlogic,meson6-dwmac
         - amlogic,meson8b-dwmac
         - amlogic,meson8m2-dwmac
@@ -622,6 +623,7 @@ allOf:
                 - allwinner,sun8i-r40-gmac
                 - allwinner,sun8i-v3s-emac
                 - allwinner,sun50i-a64-emac
+                - allwinner,sun50i-h616-emac1
                 - loongson,ls2k-dwmac
                 - loongson,ls7a-dwmac
                 - ingenic,jz4775-mac

-- 
2.53.0

