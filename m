Received: from mail-oa2-f20.google.com (mail-oa2-f20.google.com [74.125.231.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4366F48C402
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 19:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789933550; cv=none; b=awWVybcvTi9KOgRC1uNDVVq47h9hCYDfAOxVT25h/LO7fUhQZTZTxq0s4ScFxRbA2k4Qgj1WnV35KBMVF6GNjGkrxSpGDzRdt9KR4QeSMnt/w6x54/mf8ORtZat7aIPDx1LYkmEiZbaMKlVvfUP/ssuRba+iWwApJ9qCbMJOydo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789933550; c=relaxed/simple;
	bh=Gj+LzOejuhn4QUWRd2BeQZ06xMLgJHxeiRX4lCDRZzE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aJv7F8BGXLNI7AZumACvW2uNz61yBPnpOAEi4aXqFZKogEeWNPRu/JfrXuRaVhnZzx6w0iymOrr5HeqK4w91B2GywFhblyMSOKwqa5su2pGKJUDHms3FRcJbX630ZbkhI/Wfc8YHvcXgsLcuH5rPKqpOmwhY/NROz/P0KDUzvl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l6CCX2Qa; arc=none smtp.client-ip=74.125.231.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l6CCX2Qa"
Received: by mail-oa2-f20.google.com with SMTP id 586e51a60fabf-4788fe5736eso1425416fac.2
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 12:45:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789933548; x=1790538348; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oLXSL+1npHD8gI1D6ujrAzi7XeKmrbhfqQT3WXutYPk=;
        b=l6CCX2QaYTWF0xmANFskLvprELdoCxBGDgPcQY3MP0X/1K3BAiXENuPTSpZxLGDKKp
         H5dABEwxYOaQJkrUcfbcpMwPFyHMVI0i6FJiPE50g/QE1uYDec1aEGhaRZ1op/8AuY3H
         9J2zH30CSgxzehNkNcdDL/BD0lOqfQcXrBgi6MgGDqh63iUmZSuobG80jjJ8NGc+U7KC
         KQbgjJ1jNVwSXFw6V1Fl7CXvJFnZeLx+GsS8S3fVqS17e0X0JEQA8Hg71K1bSGK6UVMm
         ZzaLGUiWbWFg93hkK77LgAtfyLOmoAfBLrKJEwlaj02N5/iVuF9Pf71401KRwfqiI6sO
         Scwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789933548; x=1790538348;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oLXSL+1npHD8gI1D6ujrAzi7XeKmrbhfqQT3WXutYPk=;
        b=IlIcF3SQ/BKP/MrpZw583xJVz9hx1n+y9p87Qkl4hKBkw4J1blGv7emnXse6FD0NRF
         jN7/8jKt2MQO/ghtuRg5WU6jYWCUDVHbQU1CJCugek2TjBG7jujvfQ0Ly/XB7smcrT2z
         KsNjIt+w8/bIaSjKd4McYhE9O0eFAwGX9ukMRCEsEvKUbXUKWB33Hzj9Zc7TzXHqYbRQ
         UDLqLw83H/0BLcuIhAxPZhA4W8DcUk1wiIizwDBgc4cgs0hAByQCxY/BCdCiF/Xt0J+n
         x1Z9VrYskGqhYscpx/46ovAh36sQPppgnWXpIg8FQarPq6+11sDD4HhT62Qfre3IvvDe
         zRKQ==
X-Forwarded-Encrypted: i=1; AKwUvBy28WG69r+b7gipsQHgmfEu2fA19R4aVB6cwsYPG+R3KR4mbo4T4z1fS2393zrbeN7n5vS/Wb8=@vger.kernel.org
X-Gm-Message-State: AFuF++kIBpgXUA55sGpSGq9ors/wt4Y2kE+3l2b8QRUOEmG6d8UkyQzx
	XnPMD6/uZa0cnu+ykljp8Q0P7a2w0Pj8L38IvfX7513QMPgI0dATqNjH
X-Gm-Gg: AYBFou10K5dwBkfksMsyNA4JYXFIjKtaXWwXXXLnbOQRfyqVD3cWr406m5w7q/aFg+d
	cTfmaCDbsp58aOmvATXrNoG0xTKF6OnsKYJnC0GaskS7B3LqMtZdKFZdIJT7ZN5pcSw2iAEJag8
	S6KGgTAz97fsOP3QJDustFyDPpLoVsFI5JQmOL7TKFwVg1F/9gOwDkQsd8lTYsJQfoP0sL63Np+
	qbOoHSutBj8ZXT8FPXgQLDnFireIbe9hjorEtqtZC6UC2NuGImt9oNirtw7lNII0mD+Id2h8136
	5eAsUCkn2w1VDLI1YeLrH2yjmC7ME9LBYp5D76tPTj+Zd1fh6WkBeNjD1EY5YJDBZFOKu2ydWfc
	APLOl2gnYaJ1fj5gohMDbk4uGPO68ooGnEoEVQtEzw+LNEx4SAxvJnf/btj2cB9EfsAk/zuOWlY
	pvQVV9Trz8ofL//49H+ccEW/Cv/SCjAg3zc92cuLVIecjn5mJYjByDmOPryUGE/q+0QW1AAD5j4
	+2ABIybtFD94JkIHKENEB/bcBfycwJ4ExXOKkI6KbiEzfIlltRKKqrl5c6IopkHfLD2bR/e/q1n
	ulH5DrGWGxj4HfKd/OTITns6QyB4+bSw/Q0JhbA9nOVzdOOIgvdwdHRuw4BKe1LUurgA+LwSdAk
	d8mO0XuzZC/rLn+1V5Dwj
X-Received: by 2002:a05:6870:140b:b0:448:cf96:25c7 with SMTP id 586e51a60fabf-486e5a6680cmr8538751fac.17.1789933548079;
        Sun, 20 Sep 2026 12:45:48 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4881f4d7861sm6103834fac.1.2026.09.20.12.45.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 12:45:47 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 20 Sep 2026 13:45:31 -0600
Subject: [PATCH net-next v4 5/6] dt-bindings: net: allwinner: add H616
 EMAC1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260920-submit-h616-emac1-v1-v4-5-8347dfe2eb7d@gmail.com>
References: <20260920-submit-h616-emac1-v1-v4-0-8347dfe2eb7d@gmail.com>
In-Reply-To: <20260920-submit-h616-emac1-v1-v4-0-8347dfe2eb7d@gmail.com>
To: Richard Genoud <richard.genoud@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 Christian Marangi <ansuelsmth@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
 Heiner Kallweit <hkallweit1@gmail.com>, 
 Tiezhu Yang <yangtiezhu@loongson.cn>, Huacai Chen <chenhuacai@kernel.org>
Cc: Maxime Ripard <mripard@kernel.org>, 
 Alastair D'Silva <alastair@d-silva.org>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

The H616 secondary EMAC uses a separate system-control clock register
and supports only RMII at 10/100 Mbps. Add its distinct compatible
without an older fallback, since using the primary EMAC clock register
would not work.

Constrain the PHY interface mode to RMII, matching the hardware.

Reviewed-by: Alastair D'Silva <alastair@d-silva.org>
Tested-by: Alastair D'Silva <alastair@d-silva.org>
Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 .../devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml  | 13 +++++++++++++
 Documentation/devicetree/bindings/net/snps,dwmac.yaml       |  2 ++
 2 files changed, 15 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml b/Documentation/devicetree/bindings/net/allwinner,sun8i-a83t-emac.yaml
index 323a669fa982..2cae0133b3cd 100644
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
diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 0ff9e3284a06..3fa6e17c3d12 100644
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
@@ -623,6 +624,7 @@ allOf:
                 - allwinner,sun8i-r40-gmac
                 - allwinner,sun8i-v3s-emac
                 - allwinner,sun50i-a64-emac
+                - allwinner,sun50i-h616-emac1
                 - loongson,ls2k-dwmac
                 - loongson,ls7a-dwmac
                 - ingenic,jz4775-mac

-- 
2.53.0

