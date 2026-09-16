Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864BF3B774B
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 03:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789528108; cv=none; b=uMIG+EeKHJlbAFuXU6u7Xj0+vfRYufxtLnaLu4acfrGUYKpT4d/DOygTS2+q5z8i3Lj2j7ial/eFd5P4GKmHvKqbXVO8Esw2CNSvWi4OydZWaY8wEtz5ozR6j1PlJez1Kv+X8OMEo72RoPT5chUqFIo6zeCSbyhMKQFCdI4A+Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789528108; c=relaxed/simple;
	bh=DpWiD8Cfu4Ku/u5pgdm/NldUMARvs9TawVNZAjHM2lk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vwthzvl8Hxic7TCDgKNuK7c+vk3byI/1o4FlKB6shxrlV/rQsltTFGCcl49cSRh0uBcBzZzPOjbM4x8LcHMo13j2x38ioe7fdHiCMNtjXsJ46wl6bbxg6U2Nti7I3NqSFJdpR7EN0r4t3RRcCqCVtZjilAt26NufTR8h3V7iiR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPx/I4V1; arc=none smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPx/I4V1"
Received: by mail-oo2-f42.google.com with SMTP id 46e09a7af769-80199394f52so273600a34.3
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 20:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789528105; x=1790132905; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=acNZzyf/OWXjg5U+vhwU7dGtHUd/8SQbsA8hrhEspe8=;
        b=BPx/I4V1fOeK0Je5cP9owUZpA5r5+7ckCt3Isx7EELUqIIvyhOgHTyEjaZ/gjxnOyN
         9AZpAV4KvhEJezuEPlDfB8V/nHECUJlZJAQRx2urHbIgFgoJ1TsXh/P3YGBWxxwvF5e0
         gCLVenfD7pu/AL6DXsa9RfWOa2L7yJUYlhrELzU/rE64OO2+tfee6RWqvXjwC4nBFslM
         WbEiejiGw1nukTZClXEzTkNX0uMZoY4Zn6oS0cTVEGiEGIhtZqRpiZxo8eLUMhn7r0Ir
         oG1QWMcOZ3flPrCbWRqWpdF5gsbUfdEPQ64PeA5KdFExNXHRbPE/kWlpMZjQYIVK7aaa
         bpMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789528105; x=1790132905;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=acNZzyf/OWXjg5U+vhwU7dGtHUd/8SQbsA8hrhEspe8=;
        b=NWVWiNpuT5IZkt4+VxpJBNM81h+kXn0nVYLfVMf4IhfIn3Ou+mUSzqoNik6K8hpopw
         R6e13OU69DYWiIKBdae9u5BYmnuAsAJPMVgj9TMFBvfS5yonmjzibD+83NgBEcyJDwhH
         1aHEp5t9R76+kjfO047ZOUv9DMUrxMrIRR3q9R3x+JIagzrOT1jq3VzFoOpFN5m2TYjU
         59JoRxzTyv3znrbIPhoXKTMO6Ilc6FU2zg8TkI50EOxrABlNCcJN2OGxQ5BEeBlxQDVt
         sd1aAofbaeVxFEBfFDss+WwUkmi/cO/XZlq2UHxMSyC4SGhoGNYKdQXieIpvTAp8PoIt
         V2VQ==
X-Forwarded-Encrypted: i=1; AKwUvByeOS/i+PaUY4OgXJr3+84/BS0Hj+7t4Rooq4RD0E1h4smdABw9kYHb1RcyZUpuzCDki+DZ3tc=@vger.kernel.org
X-Gm-Message-State: AFuF++mWKl3YVyR4TjJg6BRHdAAhhvvkke8TPK/wpt7WZqA4aQx6r30v
	SNOoTJOyk1ffEPtekD2cwRP+Fs6lixYKjBjdCKoAH0ycRClC69hf0Yca
X-Gm-Gg: AYBFou2lqNL9048Onzs6/euDY7uDSZDs1EytcRF9EFfJfDZTA8X6ETQd4jGI0wy5/LB
	A78qUaU+A1JjbaTs+JLm3P/4emVqtSCV+BxjpUk82XtQDyWzjwDT9pF3TzD31WzsuBqqyQ/0slB
	zRJazWd0weHYsCYXeEDOSnj8VZ5j14Q/qD7urBSdDTqIub/Txf2Zl+V1q1JpWk/0mejt3QrhsHD
	tVA1+h+CBxwp3ZmZ28J0Yu/qfRx/tk4q8VqBVvq4s88GOACjKXQ8v5no4NC8YOGaAMc5A3T0rYl
	gk1g6NNaWCgRyX3O1wQ3bbI6gtwbrODJdI9F7eIyIpCpXAwxRl7vo2XvQ46dOsvmQkDt1f1pplt
	ErAxdPnPM74h+MTOrHWdjmwdx34tienzU5TAqY3fzTdyjJSSPVo5SdyX7UFKrAvG9ZaaUjD1ioA
	BFLjS5H3ruEqgOC0q9yAS+bGOg7pZhFYw6g+MN4M1fAPkOe1c9dL6pCSMfERyNeGsj8iItkhj+8
	/HtK+tOktB+wyUmeO39cDxyaiEdG6iYwqprb7WjDkeQXnmn7ggv0wwssXOkZUsoOKmlGOHtJpeS
	ZX4yBkh4C7bU5+vZllWpi8ll3sHgQHE55UPE9X+YagcmftLEE7Fvediupf533cwEZY7CmPrW/jd
	9KFQd9zmhFqF73zWUrhd9vaM=
X-Received: by 2002:a05:6820:188e:b0:6b3:f4b8:bb86 with SMTP id 006d021491bc7-6c7d1bc852cmr1139016eaf.22.1789528105201;
        Tue, 15 Sep 2026 20:08:25 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6c7a677b3bdsm1718078eaf.6.2026.09.15.20.08.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 20:08:24 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 15 Sep 2026 21:07:40 -0600
Subject: [PATCH net-next v2 1/2] dt-bindings: net: allwinner: add H616
 EMAC1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260915-submit-h616-emac1-v1-v2-1-322b32e40eb9@gmail.com>
References: <20260915-submit-h616-emac1-v1-v2-0-322b32e40eb9@gmail.com>
In-Reply-To: <20260915-submit-h616-emac1-v1-v2-0-322b32e40eb9@gmail.com>
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
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>, netdev@vger.kernel.org, 
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

Signed-off-by: Richard Genoud <richard.genoud@bootlin.com>
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
index 2ed4564ae99d..b20149c3e850 100644
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

