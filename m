Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489032;
	b=MSuOMHTwX9jFU+rieqyiTZSA6zIEFml3piByGEH98DBGb5M7LV69sbdjNiKsDPsWJruF
	 zIQzU1S0BANUaESkJ360W/0J0Gj1u9LaO3YBMPjrUJgJ3xZezI7wENRWoeAwI9wLcrQLM
	 pWbAJdDFwLiishhNk+oWIflc10+Fu9v1ZCkG9ig4CGlllqu75GsmTyS1VdOAaXyu+JcwK
	 8tlFG3nXDGLLqU8eNsPHMb9pCnEyEEIb5yRAMyqCZ97k5DzfMXqyeeKNpIspq+S5UH50G
	 dwU17eBBCf3InYMSvbs5CIpgrYxdb7Vzb78jnYuheao8lva7RDUTZPOiCgI7IncPHNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489032;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=26eHFzDuq75BKMwszFnGzYlGwf+oiqj/3YNi48CTJwY=;
	b=V/qq1bTbZ+q+3KzOKUdMrBEOcBtpslBXhHsVaRTeUhXI4H96xcSUYUcX0mDkA+fBlGrA
	 uRVfapk2M4SC6cuo8/20MPYXMmjLRnQfA0wMh+CT0sJag0/lu4xytO9pEM2moNLwxl6Ks
	 aQHEUOsYcaaGB9UGZ5TfPaIsxXdP2QXl4zaM/s3L96/psDWGGoVSeDVr/07VIQX8MWTuk
	 ddkDfxcBpBGZqkqzCH7ToEA9UjSqupBkgKM+V+IbjN6eTRvmbdjtlWEkdFJmjW1+ZadMb
	 4YZBmwG7CRYtDSeb2iZeVJmsxunwUtgwx/Sj1/v9SsIR3knk8wzuxfE9B4niNebSeeA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sartura.hr;
	spf=pass smtp.mailfrom=sartura.hr;
	dkim=pass header.d=sartura.hr header.i=@sartura.hr header.a=rsa-sha256 header.s=sartura header.b=LfG97JUD;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFAD8606A324
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 09:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AFAD8606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sartura.hr header.i=@sartura.hr header.a=rsa-sha256 header.s=sartura header.b=LfG97JUD
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c434376dbebso89788766b.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 02:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1792489030; x=1793093830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=26eHFzDuq75BKMwszFnGzYlGwf+oiqj/3YNi48CTJwY=;
        b=LfG97JUDdY0f5xn16pZkZ0zfGlB14my7j7PRX3fpaoFMYMUGLVmkTTabUGQe6+uuJF
         a7Jj061lJm7UkckA/KSvUewsSv8G1jdgD9Z0uw1Af6dWE09ixRIQPJOMM/t9y1ddsLOP
         9sBEOOdmaNyqZeqiSF9DaSic3o1LcLADe9HDrlMju/Q/3xHz7LGKq9HUXNAQ1aAfVFTh
         W+NPcsCLXzoLaQN3OcJ7YwKPCeJ8vqzOEU+vX7/6RlnRbukjcTTqrpy5vY6lMwH1wccf
         RAHEsze2gwkUhKv6dJHMkkBknioOC9EogPdW8y31iUaMFim3Gdvrq17TZKeSD8JQvT4K
         MB/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792489030; x=1793093830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=26eHFzDuq75BKMwszFnGzYlGwf+oiqj/3YNi48CTJwY=;
        b=Jt0WyWW8QPRczvLn7xvqGZ23XnNqjaVUrsJU8WSxD6mupSnPOoH936GRk0RqHl2k1C
         WT7Bqo3AYRhAjavNlkhXQveNlEI9U5FIoxV2H5pK6QneyaWB8hfaPjbMTelQf2ntph6j
         OqSKw2Ml2lGWFC5CpFypOwSH/F5q0cWnRETHTzVlNqeIY9f1XglPHRY2WDS6DaaAFEQz
         7gtr5Ol5PgSM5iat3H1tw3X2q9nEec+sIRafKCy7nMq/pvRSim3eGQ6V2R0deI7bTXxd
         UyHS8qUP18GA72MM+GTihYIJ3JLz2SU0rFfpvGt3aO44ba2kPTFN0XJ1Pc4FNu3eoII9
         YYkg==
X-Forwarded-Encrypted: i=1; AKwUvBwSHpFdZGjnsZYB6N3tn3f6sgwLiaYXtOkLiKwfoQZhvl1lR7/KM+QSDAOtpPkjsl0OI7tlVoM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKdGjZjdnjN5JrrPD/KOQzjGiBJ2Naq0BoQjkXpxmSFoYH52+2b
	a60IJSx17Mjpgy2bqOGYzL3wpCgRQNmSNwq0CxS+hv0MmJsCkXqS3b3uoMLGkXDbHTA=
X-Gm-Gg: AYBFou3q6Zc1NMKBVBvMiiMO/PNJDkhWQgb3E3b36VZG9ziH5uhVgR+WGmcGYNt6yN8
	1aMdZwwvFzl/17u3x5kigKLgdonV5877ORNwA6WuvvrWhYA01lz4q4TCR6YTlHI5XnvYAurqyen
	AUotw+00JL5bfWqISz68tbdvtOa8E0Nod2S5DBFMuIm7pO7RgXYr84/2fRnvB7Tirb+NJlMcHEh
	PqREVdqMim2C755FQK8JV53CI04iywmdsH3bBbGGbsa/cwDzogF5ra5aOmpkFuyajOw9uUhYZQO
	oOHVY2nsKGaCOvY5TzrAsS2ZWx2pGQ/8rowHAgpvNZlDu64r6yPR+xBv1ovvcAnZ/5nRfv4BOrq
	vZeBQarVyrRtaG+boVSUqc/J+CXDi25wdqm/R/XH45bK2Fd6/9xRV8oU2h5zxmRZaGo/KqaIGlV
	ACuGlWlmbQIbHhU39gNWo2GIdRHPNieARCqYbErlVFSBfCrkphTvCqA1Y14bBOMaa3wHI3KGEZ/
	VdMYIIhj8nvNa2q1l4DzGgEgs9MIdM6i0A5OKTbP7KLHqkz2JPbKqqd8YslUq1brKYT2/EaLyM8
	W8fIvNEKI9rkFVr0Y/ar1xEmuPtim0nn0nm3L0L0vqlKS5Ojya02td6m
X-Received: by 2002:a17:907:c081:b0:c43:bf29:1509 with SMTP id a640c23a62f3a-c4603c04e5fmr108178866b.12.1792489030235;
        Tue, 20 Oct 2026 02:37:10 -0700 (PDT)
Received: from threadripper-fedora-workstation (cpe-109-60-82-88.zg3.cable.xnet.hr. [109.60.82.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40912ceffesm462730966b.47.2026.10.20.02.37.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 02:37:09 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lxu@maxlinear.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	lgirdwood@gmail.com,
	broonie@kernel.org,
	michael@walle.cc,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: lrosu@maxlinear.com,
	luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH net-next v3 4/5] dt-bindings: net: maxlinear: add MxL86211C lane mapping support
Date: Tue, 20 Oct 2026 11:35:37 +0200
Message-ID: <20261020093655.344585-4-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261020093655.344585-1-robert.marko@sartura.hr>
References: <20261020093655.344585-1-robert.marko@sartura.hr>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the optional board-level mapping from physical TPI lanes to the
MxL86211C analog front ends (ASPs). This allows DTS to describe wiring
that differs from the hardware reset mapping.

Select nodes using the new property so invalid uses are checked even
without the MxL86211C compatible.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v3:
- Select nodes using the lane-map property so misuse is validated.
- Restrict the property through the negated compatible condition.

Changes in v2:
- Define the lane-map property at the top level for type checking.
- Describe ASPs as analog front ends.

 .../bindings/net/maxlinear,gpy2xx.yaml        | 21 +++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml b/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
index 53f430e121510..7b6140baf1757 100644
--- a/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
+++ b/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
@@ -20,6 +20,8 @@ select:
         - compatible
     - required:
         - maxlinear,use-broken-interrupts
+    - required:
+        - maxlinear,lane-asp-map
 
 allOf:
   - $ref: ethernet-phy.yaml#
@@ -34,6 +36,7 @@ allOf:
     then:
       properties:
         vddp-supply: false
+        maxlinear,lane-asp-map: false
 
 properties:
   vddp-supply:
@@ -41,6 +44,21 @@ properties:
       Optional regulator supplying the VDDP pin. Its voltage configures the
       MDIO, MDC, and MDINT pad voltage and must be either 1.8 V or 3.3 V.
 
+  maxlinear,lane-asp-map:
+    description: |
+      Mapping of physical TPI lanes A through D to analog front ends (ASPs)
+      A through D. The array index identifies the physical TPI lane, while
+      its value identifies the analog front end, encoded as 0 through 3.
+      Each analog front end must be mapped exactly once. Omit the property to
+      retain the hardware reset mapping.
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    minItems: 4
+    maxItems: 4
+    uniqueItems: true
+    items:
+      minimum: 0
+      maximum: 3
+
   maxlinear,use-broken-interrupts:
     description: |
       Interrupts are broken on some GPY2xx PHYs in that they keep the
@@ -90,6 +108,9 @@ examples:
             reg = <0>;
             vddp-supply = <&vddp>;
 
+            /* Swap physical TPI lanes C and D. */
+            maxlinear,lane-asp-map = <0 1 3 2>;
+
         };
     };
 
-- 
2.56.0

