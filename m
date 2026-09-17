Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C67D50B401
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 17:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789667727; cv=none; b=iMZ5hA9LQe2kgT7zfhfyWemI4B/yhD3KEqDqgsaj59ydfdOyLsLNMSydqEIX5ewi98l+wb6Yj6CizmhlhgsMjwjI2mT3dP/Kq1pYDdzcqU8xVQuXSgNZH7V1hZ7rFKt1QToV5+flnqfNR12eychIrdLimJI8opgBpvNDCZaLVRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789667727; c=relaxed/simple;
	bh=PRVkggVtJ5MI/earZSiaP3lIhXMmPnjDvErncSUEbaQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rWd/SSnDbvtLeEWLmoDGcWtqZskzALvOErToNHHeRqBeWB0NYOc+Xgt02+oXqS03jCqxS+bT3Za6BXKQCW7qcKDCcORWc03vvroDu1DhQNxv8ONZj4yh9JG7sSI5jgm236QZ21SdOLSqjs9La8yACDQIz9tmHSOqZegHEcwpxow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZuHnOlHy; arc=none smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuHnOlHy"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-466ccab774cso761557fac.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 10:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789667723; x=1790272523; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XpJyi3gexBtR9fGEP/jcxswIyqDdKggXh7TtgBulLqY=;
        b=ZuHnOlHy/P2Kzfc9GcbIRBhxH5x14XWCtrVa91Qmb6pCRPZ/adlX3yEZrUSJp1jalY
         bfU4LPtXcMnxXEWmZFC6x9PZlz4O2V0cW1nG4PmRR5hNvdbu6lSe1G3+Ov907eU30X9X
         YtQRW3pxefT83oaGxgTRgwliKgUM7NRREYAKME0XtIU+zcHMJBboCss0SQgwc8idn/19
         zyq/yUsGvnPtB+CHGy6hgBLsJT2dZ+NjFO5qfbqUb+kv3zY0oFKX/864K8UVlxtdJJ7N
         t+TWQ91kstvpJsVxc37D4mDA0+HxkJn3mqpT0i4trphsYAomhSiS63XOfX+MedmRkJxO
         LeYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789667723; x=1790272523;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XpJyi3gexBtR9fGEP/jcxswIyqDdKggXh7TtgBulLqY=;
        b=teY9nAdqMK+AXb7of7TcB72AjMkPlXQitzuoWIrcjlVhzTbfRp0Ug3CsbJT6Wy0fyV
         5mjRJXxinwE52BapIkwHpipvRSyAp75ex1tE2sVgDBiJkQME7JZG1agHnZhpj3eP71Hb
         3pzFCsNSwXR1Lzr3qLxb6wrGUUcevzWWTjX68KO8Dd4+k3sPcdh1ldao0wXH2YvvKNE4
         bYVrWapkyTLK2plt/CqH1MZ9koKDXUhNyHLJ3wohQYKpky7KRLdVx8nNiSx1E6J3+80Y
         S3ciR8dYkyf4zvd6XM1v4pULzERVRw77DJWufTPuakSzEtPwagxvXSq73HAQ8Lvk7nYv
         lctg==
X-Forwarded-Encrypted: i=1; AKwUvBx6KxBWfyHVFWzLiRbOGAwBgMebQNIEaiVnW24fCOHGnIL0sOJ8jx+BeoRvX+KfwNRN00dzR4Q=@vger.kernel.org
X-Gm-Message-State: AFuF++mPnepjrc6HugSdup9pai43QF9c2ZCyNnb6ACa36GUiROrZlG9u
	fWqO4gXI72slMNAEbwxzFYH/M2oQ76g2PFnKSIfnBDl+n6v7wqATwwXb
X-Gm-Gg: AYBFou0Q9n7o/sQ1HiGDFpcbtmZSgVTydTMgohJJx/gneRr+2Qj78XPFUAoUHF5A/8Y
	vzHqcT+g8fJRcOML3JJSDg07UZuBF9Bk184I3Nf6O4QTYKl3RuA/yRg1jXkCP+rZJojdPuWSXp4
	CtEwyjcNs9dyZV9PIj4bYEwDf/t3SFB6Yxq4ZamO+22/gWKd6KPxhl7VeCEMOKX/i1K9jxq/CQR
	M+Pvwl4qfJof1yBB9NLgsnTUnUmIKrNZRgRdH6fSLnkF9ypRbW4wAdKwG01bZI1BA0ZKvvcIbAV
	s3sBUaLh8jgNKB9KgSggSEwzLpARw/bppCNJm6fKXaX58gf5WMUGSkQglc+U8SvS70wQ0NUbw/l
	3rEDJbR2VXnJD/HwGF1a16Y9boTLszv5spped7F5pR8R6e8s9b8Q9A+0PXmPb2XZGIj4XrW/VFU
	7IeDhRQCGESreVhCx4b5acOQIiHgVYkUMiNtu/idXr7S2q1RBoHtH1PTZsWBUHBCOAnkcJnTyAI
	I69PtO69K3UHXGFXFINZRWKPcPZGcLX3InGwKBPQUL2UNWqHZSEk//+RxtRurxJfpt/jRk6EaYf
	t4vbsHcj04fP56KyvtR7jidonACRe5Up4BEQjNoPspXedMrlUJsxIXjGro7h37xwUXZMu+JrpMS
	O6Cfk/1It2tKRt9/4ae3t
X-Received: by 2002:a05:6820:83c5:10b0:6ca:b5f:e6cb with SMTP id 006d021491bc7-6ca0b5fe74amr1221351eaf.42.1789667723400;
        Thu, 17 Sep 2026 10:55:23 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-486ab6c1f31sm578446fac.10.2026.09.17.10.55.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 10:55:23 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Thu, 17 Sep 2026 11:55:13 -0600
Subject: [PATCH net-next v3 2/3] dt-bindings: net: allwinner: add H616
 EMAC1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-submit-h616-emac1-v1-v3-2-62cb8316e19b@gmail.com>
References: <20260917-submit-h616-emac1-v1-v3-0-62cb8316e19b@gmail.com>
In-Reply-To: <20260917-submit-h616-emac1-v1-v3-0-62cb8316e19b@gmail.com>
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

