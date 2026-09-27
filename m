Received: from mail-oa2-f34.google.com (mail-oa2-f34.google.com [74.125.231.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E12A438026
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 18:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790535157; cv=none; b=fw2rWH/pj8nNWqMqXYdz7E6QpqMnUENk+fzdx2T6oULf/pkMTXN4kNZt7G1yFYkpd4z1pz3IQt5e6tgDSsTwSCDrXB6cJD0V/VuMBnaefAeKOfGFgi5BCWqDYEkjVj8KZFnMZr6TJCRtBxgEfWyaTyak2y7uCQY/EPwod9496Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790535157; c=relaxed/simple;
	bh=HeUIDZzk449KX7gatFI/4s8CJnL+sVcLapPU5ie+Nfo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YPoXQHgSZzC3RZdFX6psRMDI3D0mNRBSmTog6lrvxybd3OW2cxPWWeQ8OvkkHgmm0uRvIwY/uaq7rHM+2kNcIjWMFr2RRnWYHnxoN1lfgZ0KUSCc1c6SW0aXfWe2eTdJpnXUIq/Y+rCoE6kPQcgUA3zGVMGY9bylOh6LSh9KIi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BA+uakRY; arc=none smtp.client-ip=74.125.231.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BA+uakRY"
Received: by mail-oa2-f34.google.com with SMTP id 586e51a60fabf-494ab4d6128so243353fac.0
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 11:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790535154; x=1791139954; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NbHMYUvXV7KivNO4nzT7c/gFlgP0cqBHWzvGETsZmKc=;
        b=BA+uakRYCHuOS7M2UKbr7sR8lLk8wFi/HeIWrLrYQdimOmP3h8ZHFnVuWqeqVs0Hqe
         S1cE5jpqrVPvKKiuwVzD+axQouKhnWIPMGBTU4r6F+LGBVp6Pb4UxlnZUxRQvII9YR0n
         wfGe53HxqoHyFBVOcZC1X7sEd4EH+OWH0DZjNa+M/TtoZ/q70xEKYGGFO1Uqy3s7AqPU
         KZvXxcZE+JAo9ikshyaY/IosjGr+GVUi02wwlOV8LXsu318u16avsYaYaKfstx+ZjrWo
         8jJcEOT3Hu2/pIM2K2s/kSgVdCg56I6lwPd68ZuYBnbfHLc2h7+649i33i5KLmBLiRco
         wceA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790535154; x=1791139954;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NbHMYUvXV7KivNO4nzT7c/gFlgP0cqBHWzvGETsZmKc=;
        b=PSPUM1SwoHEs1G9j659Q3anBSjAWXNSpf/6JxC+4zprnG+D65nikabJZTLUGeswsDl
         to4yZWCx/RFxKZ7YZyA1QCDGiRwz2LqacWIazCZgBqwmF2SaC6NcHIv79kcKk94WGjpL
         d9S7AShKPEQFgRNHS3VUhzhn2BnkxU+90GpBXGgYsK3ezMiyxnXNzhzVE5/102KNoKsP
         hiVxDh5LbhrAAL/BW+vBcmoKWqbMcnH+ZA1Gtc2RZNT66QG2/q0olj2jIEaPYI/iqQOC
         ++HK+3rxWQra7xjZ8k1QHmMhi97bjoYv3UQBsL2pzioiuR0enzbmzgT7VypfMU6L871T
         isMA==
X-Forwarded-Encrypted: i=1; AKwUvBytt+rUlzmQCwawQdDjmzO3JhoncB+hcr0gwe8iMyO74RqpzFuCb6Bqz+BTAznH2Idpsxw8rOc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKogyy6bcrmAnGr1fFDMkrh6o0XCvdqHKUh4qLpk2NxLo0MZzb6
	fsHDLIX3HrK/bCKSgtoFxCdC2KLusxEMrvnubwAhzTZd2lEexRE4AcVK
X-Gm-Gg: AYBFou3AFjELgMzE4sEMG63L3MO6A3SRwrwEhIO2vWBZMfv4eQR/D2gWkIp1p5A3HFN
	rPY3r+29TmL1qUb22wUIL7QeXbM71eWLOnkOTQoikPRgLHLmcmQueJd2NlYkoj9RnfnkCtRPl0D
	yGXIoKpHbBuBQI70UgK+fpfRTtBUDOfF9wu9PrtZrnopRfRtzmYet4Il/94AkTBycLmui6pHlcK
	8+T2kLGacikoI7H/CCUfjOZyMdapSov8OB/qfTQ/rlIDIzVHpsM9JUD2T1b4KvY180rrjmvxyVU
	75dnNg+Y6keYrFlte8nKg3I10M1ZXvMRCLDEnAgWcI6wjnH+4EfZ3Q/feSOMoQy41jlhTaknjQz
	gaUGmwc0xlcYDMV1EBsqFdMcJJzUbjeQmKJU+QDJM8wdnmQRAaHq/W1GTOmC/58kqcGqlIrXpML
	pgodPFq3PlTYF1JcM/gs5ENymyFDEJqEKHKgJqpEVDeTQZMralhItKin7Fg4vFbW8n2ZVRn1VOa
	BlX7HfwW9esjjuyXNYesUoD4roRewwHw4vJq24pHuyC+Trmt3WFvI55Jg/fKZGcPofOV/10Z9cc
	SVLdudlYZInkM6L1jIVJKMwJr17uGo8JjdTmye2O/nN9t2WvPWZMSBWlv4KCySl5TTqUViydJOX
	Z5ro7Tl2ehIDRm7gKxm4uSZ/ApyoNMa8=
X-Received: by 2002:a05:6870:9a14:b0:485:d31b:775d with SMTP id 586e51a60fabf-491e55b11c7mr11348983fac.27.1790535154236;
        Sun, 27 Sep 2026 11:52:34 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-494877590e5sm4489452fac.13.2026.09.27.11.52.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 11:52:33 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Sun, 27 Sep 2026 12:52:20 -0600
Subject: [PATCH net-next v6 2/3] dt-bindings: net: allwinner: add H616
 EMAC1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260927-submit-h616-emac1-v1-v6-2-e64971f4e414@gmail.com>
References: <20260927-submit-h616-emac1-v1-v6-0-e64971f4e414@gmail.com>
In-Reply-To: <20260927-submit-h616-emac1-v1-v6-0-e64971f4e414@gmail.com>
To: Richard Genoud <richard.genoud@bootlin.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Chen-Yu Tsai <wens@kernel.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 LABBE Corentin <clabbe.montjoie@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>
Cc: Alastair D'Silva <alastair@d-silva.org>, 
 Maxime Ripard <mripard@kernel.org>, 
 James Hilliard <james.hilliard1@gmail.com>, netdev@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Andre Przywara <andre.przywara@arm.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2

The H616 secondary EMAC uses a separate system-control clock register
and supports only RMII at 10/100 Mbps. Add its distinct compatible
without an older fallback, since using the primary EMAC clock register
would not work.

Constrain the PHY interface mode to RMII, matching the hardware.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
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
index d3e591157faf..2218a492817f 100644
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
@@ -573,6 +574,7 @@ allOf:
                 - allwinner,sun8i-r40-gmac
                 - allwinner,sun8i-v3s-emac
                 - allwinner,sun50i-a64-emac
+                - allwinner,sun50i-h616-emac1
                 - loongson,ls2k-dwmac
                 - loongson,ls7a-dwmac
                 - ingenic,jz4775-mac

-- 
2.53.0

