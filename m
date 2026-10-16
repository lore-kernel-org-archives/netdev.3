Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A22DF47DF97
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 11:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792149656; cv=none; b=lD4TGM0InVp1I56tnR/NZ0AcJPG22EqtYbH0zsH/QXMyURcwBg6Ohya6lydVEAU+JoL0Wp2xmFmrza/oFaadoylDNNMx5mZNBkFpAxlMHtFne1IcHWL75wlvz1dV1NwQ5FhQqVFyBjHs81Lv1GHD5RAVT8IDuic54efJ/odSwTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792149656; c=relaxed/simple;
	bh=K3HFfRXhY985XKq73bUHsf8IzVEDhqNJgoVBj3Mi1vk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bfe/UX9t/yfEoVHXVHw5YNaaYkAqmy6Ei1qesWzlwocbHgj/a8DLIOjIore4eNnRDAnIp5ARfQX5j+q6vi/vwqL6CHHY/+HsKxGMn4wY0OYP8G1Y2nEIxrfmIF3+MqPWHxuYH4+hvWHL1w4A9H5K2JpNE/OJBf+ECM/VQH0GrfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=FC+OWePP; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="FC+OWePP"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c350db5a761so72525966b.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 04:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1792149648; x=1792754448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RP6t59lytBlT9EpuEl094ip5/Z9ytw4aKa//LaCI6yc=;
        b=FC+OWePPP9UlnSw6nwfJIstHxvVUaOAgxrOH+GxV07P4pOfcNWd/FpojR6NP5Djgew
         fnevroSh+3r4d8lwpxOPSqbe3gHflKi04HGBukfqpm1HvPh22cAJxc4gNMfpvHpWfMXU
         jbQM4zUEGDnQnsx/QX62K+BeMRwfcAQk0JMwnx6ygV80eZndNIcy8b/omcQvAI5wBGpL
         SaD1TeHN/41H5cW18B3+6+H9LvsW59lPhMdlVAQKWiWLXZAyTwoCEbhm883f8K/0U3HJ
         dX21USz6OzZX/U/AqEYmIzRFPTVkZcnfadis1jAhVbXKGFxYm39iVJ/UKl/h7mVpB5Qi
         tH1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792149648; x=1792754448;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RP6t59lytBlT9EpuEl094ip5/Z9ytw4aKa//LaCI6yc=;
        b=hw0/L/ELfHzQokeIlN1lJnlOAV6ggCFJGLYIU0STd9bJszLlb8PVlWFtIXwSjhaeMH
         9Rb3M6SDgHIZ31TcjuTfe41mZDbV5GwuysvhuNPkUKezxihKyb5ngzr2eluCkpRJZPPp
         GCXgeDxYHhMsWSwiXSMzv7rE3EtY/NgYpXMQUKFAf0Yn/n3BS710hIwZiIzdmdCiQBqa
         u5i0Yzif4+a93EzkXxURaqQK7y6TDV0Dlt3UuoxGuK8+ZeNdcbYN63dKBIvxJ3Vx5/oT
         PYdS0k2gbi/z4e2y+2oq5wl2745GM9Jm9C+JiWvyEdaQP7ux3B9MH/3Uy0WCXsraGPY4
         VHmg==
X-Forwarded-Encrypted: i=1; AKwUvBxgdtQRf58Znk5iK2Bd8e4bgxKTbGJoGysiKsW0BFZOLRa+0IndJBEhV8YgKmGqHmlf3BjAudU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLEMqJim0BXUdRv4LJWUcEjFUl+HNzsEE3Y+ZEARjl1Y6XoACXs
	KLCLVUbr5dRf5bLZ/AB/tQ3Wan+7gSULQsFlWFQuPtZioCtQ1UJtCsLi5gPLm9W4bng=
X-Gm-Gg: AYBFou054JIm39vCPfHQr75mYwttHo/80g19DJ3Y2PhR1hO2jKlSK+RZfITsYBQaeOC
	39WMJiZY/evzhPef3rfjpkrcJpvR9pvfs5H9FRSVo792TzlY4qkb+wbc0Lih66NDP8FELw7Tlbz
	le3bNCy9NKh2BusHh4vf3PIAqqEAPpShpJV4krbxmjf1/1fsq+t6un5G6LMmv6ed8eG+3cA6eql
	ZlL8Mf9YrZTTzs9UXQTxPE7eXngdij5xhP7dDhcQdOY6lsSRuK5AJmMQz0wdECITWhdqB0zD3oV
	f4L0Qsn6/ixuFwceIlhbbKU+uPqL4qolHmixMx6S+QHT3IncN544VWbaKOz5jmBfzFSjwU77yaB
	gQOqVpLwx3CbDb6fR3Bl+tfYz+swM8MZxJtbfIDfHBIlQpYTlieYjFaQOO6apDXo1pf0fYefVph
	lamH2Y5MtA6S/UuDgWbh89SJEbb5hgTk32gnQ5NhvyqdMeSZUxdPFDheXwbz9Ab31LA9EzmVvjw
	KbyPB2GkxizF/GUr6A352T1MRfn10NZNr7Pw++FplpyrzwDbv++4lRK1QmxOOMIdANfSAAorFuN
	r9YbcoOERZ0e9VFqkyVyu0n/GeQq
X-Received: by 2002:a17:907:7212:b0:c2d:bd95:874a with SMTP id a640c23a62f3a-c31a9fd3559mr1982434066b.17.1792149648629;
        Fri, 16 Oct 2026 04:20:48 -0700 (PDT)
Received: from threadripper-fedora-workstation (dh207-15-194.xnet.hr. [88.207.15.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c408e32c075sm63947666b.11.2026.10.16.04.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 04:20:48 -0700 (PDT)
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
	michael@walle.cc,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: lrosu@maxlinear.com,
	luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH net-next v2 4/5] dt-bindings: net: maxlinear: add MxL86211C lane mapping support
Date: Fri, 16 Oct 2026 13:19:35 +0200
Message-ID: <20261016112033.949026-4-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016112033.949026-1-robert.marko@sartura.hr>
References: <20261016112033.949026-1-robert.marko@sartura.hr>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the optional board-level mapping from physical TPI lanes to the
MxL86211C analog front ends (ASPs). This allows DTS to describe wiring
that differs from the hardware reset mapping.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v2:
- Define the lane-map property at the top level for type checking.
- Describe ASPs as analog front ends.

 .../bindings/net/maxlinear,gpy2xx.yaml        | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml b/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
index a0dfb6192d81b..4323be300c721 100644
--- a/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
+++ b/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
@@ -35,6 +35,7 @@ allOf:
     else:
       properties:
         vddp-supply: false
+        maxlinear,lane-asp-map: false
 
 properties:
   vddp-supply:
@@ -42,6 +43,21 @@ properties:
       Regulator supplying the VDDP pin. Its voltage configures the MDIO,
       MDC, and MDINT pad voltage and must be either 1.8 V or 3.3 V.
 
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
@@ -91,6 +107,9 @@ examples:
             reg = <0>;
             vddp-supply = <&vddp>;
 
+            /* Swap physical TPI lanes C and D. */
+            maxlinear,lane-asp-map = <0 1 3 2>;
+
         };
     };
 
-- 
2.56.0

