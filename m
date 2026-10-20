Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792489033;
	b=fcISAZ5i2ZYnjYtj2RMPNRR8KiZt9fDXQgKleBg99gIFBHFZa2w6cYr/Lt88qIbygu2t
	 +DY/6pFa7PyzbXBDrQFmBxHRK+mko4DpSES6VRZkPQEfQfeR4cyH8q4opkEGLpFE/cw3K
	 ZW0chXJZllJDALDdXe2ChgRD3WuaH3fA/G8uGZFJHpP8gOfkpboNdZeL2jg3O4ar30JrY
	 mYVLyRMEwWX6LyMRELybE2sQdv+v7dxFmCRj8BQr9q+E3p8xvaFYMih/t8EY19ARUsTAQ
	 62qOQ/sb9e66mYA85i3sYLTfQ8W8B/M/IWyCaMggZfnBCgWQbKO3qYKhGzeynmQdBdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792489033;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=hB8pffq+inNrwJYLPOGvC+P452XnrT72yy2Y6Woy5mE=;
	b=b+u8eQXJbPtdwF3yKYECMVwjZEykvlCulzTBAhEkC8LA91oZyUdkr8s1hH2Sns6Zv1/X
	 4UI56uY1T2KwcesmuhKPHv3wSBIrdt7v+ax4WdoBBJO3hJOga8j7RBTBDGduyxKEvxh0G
	 d6E0FyGh4fleffm0+oF/I0w2nkMwn/+d27b0qIWHzH1t8DVDT1DF3fjrCIkEChCfdpDBb
	 mNjQ4JuN+HRH9FEJ7cQIyRaMkSpmLWUbWHpa1S9W566nwAzbeMMc8s2L0QCFmmFhLNjrc
	 VlA1qoJykXjvTtSLB7oiQwAhafP/p9fzMRmp6VthnRfN971juh8cS7TeXY4ECAAZbrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=sartura.hr;
	spf=pass smtp.mailfrom=sartura.hr;
	dkim=pass header.d=sartura.hr header.i=@sartura.hr header.a=rsa-sha256 header.s=sartura header.b=v9e42P2A;
	arc=none smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F33606A33E
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 09:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C2F33606A33E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=sartura.hr header.i=@sartura.hr header.a=rsa-sha256 header.s=sartura header.b=v9e42P2A
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c34bff61551so424551566b.2
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 02:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1792489026; x=1793093826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=hB8pffq+inNrwJYLPOGvC+P452XnrT72yy2Y6Woy5mE=;
        b=v9e42P2ASSkihNC4YkrSR/E/sDVt0s2qV/m+O0r7dcErfSBASUbr8PPAvzNF8sIi8W
         tPcYDtC6my00/uciLmWKAehRS+R0yx8WtjBUIT6HmafA4G86s7RbbCNaeNqq/N/sUg/6
         4efkr9P/9ImAyEl+vDVR6JQIQy4Pe0Si6zs9TsnVsCnhbO4Pvvj+TNqtVU3OfElnx7ap
         xIEx0m0OEYj/7QqqFHrx7TWq/6ez1y7NOiu1HF9diNhOQficqQG3/r6ySMMCY+3Te8k8
         TZhj1ZT8OCglQyBklN7DIv5+TmvxgftBXRo8WJHQxb0V+31jn9q3RrWH2sNx5oh9lo79
         9e+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792489026; x=1793093826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hB8pffq+inNrwJYLPOGvC+P452XnrT72yy2Y6Woy5mE=;
        b=nYEjqfUHCz8IwTyCZaePLapj18A+Nw0my7/hkZvfMRPjuhz2y0UqNNLpYnO4F9cBOO
         ZFAy19xjj5jbLZry6BhIdnT+CJB804puuZ/4BULAFuq49BiB7V485FXV7V6Mpf8ccvmL
         cDJpjOOaNDX7hXPkwrJSIj/FZ0zjw5MY6XbFwn3kGL9JouOzbUjYfCqG7IvR/SI/pYZp
         1EG5gW5wg9rkps9tyRnQIaP+K3Juvx8TxYqbmjf0PMf5dlPQ2YeCwduHqhN3xd+6xEkT
         IclOWqd4L5Ug6geU4R/kPQ3DOg/voAk5z1ClAKl3dX5xQEzDCY6RTxU3Exx6lyIqObSg
         CU4Q==
X-Forwarded-Encrypted: i=1; AKwUvByqFQX7/KgopDXHnl8FXL3fhuniHxH5EkctULkQPi1Ju4qFCj2cCtmzulZsz/XKmS/FsadCZfo=@vger.kernel.org
X-Gm-Message-State: AFq9FYKxGnx/cyntSCvz7T5EvJ7u3bFLfdoby/oVDA9saWuFE8rkxSkc
	pUtVLNgehqiyhOaOLtf+kqFi5yUsibnVrPZvEWI/Kd/OfowxAhSSEU9fjShc9cvdq4E=
X-Gm-Gg: AYBFou1ISP3nprm/IJvm0+9Ri/QHsUIiknkbpEBW7dZrW7CbhtT5lLD6YLqCsFfkqiJ
	C+X9Hg0Q2pQTWwOQzUxQe+8WIoLZzaNEkhjcjGwWFLGUDN6BCHmdFYqbt+mc+PMBzqQYZ93td9Y
	PLYF/YKv8EbdjMalA/rTkzhAK3giDUmRgRTcTRZKxuHO3eytN4KYFz6Zn9l4/LqKbsQVNxS3JFB
	nMXwqz3xEuxQe+5/nGRGRJWVg5+bBTDEkSalIbU8wiCon7UQLAgjv+UluTGjDj/cu30KbJbJ1st
	INnZj9IH6brkUhskXQKFrm4jnzatMag4Sn7QlBT0I60N4RJuZAQA7VG/GsFOk6wWp9VmGVNZQIP
	bgH9UNG7ckw2G9n1zpZ4lFJQALF0rLvB53NsbQIHBm92R1qcJ98rZJICB386UU2IExRso4jYWMJ
	z8Awf7gpgHcVV7XfCVizJ90+V0enzAPimtdG1d5tNIG1ilcEQb8A/9xYw9Q3lgiKiFX7xELj/LE
	C0E4qOvZYoOqpqZFagIU8QGt1zjyNsEQPLFsNzhHHhbw5ATd6bxgB3jI3uQNF9VjqB9ZL2w1sIa
	lrV41Rjt7fbJ0C/2xWKhlgkuuEcMWDNFFwy+S+VNef7/6Q==
X-Received: by 2002:a17:907:3e83:b0:c46:6a50:40c2 with SMTP id a640c23a62f3a-c466a504adamr73352366b.39.1792489026177;
        Tue, 20 Oct 2026 02:37:06 -0700 (PDT)
Received: from threadripper-fedora-workstation (cpe-109-60-82-88.zg3.cable.xnet.hr. [109.60.82.88])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40912ceffesm462730966b.47.2026.10.20.02.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 02:37:05 -0700 (PDT)
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
Subject: [PATCH net-next v3 1/5] dt-bindings: net: maxlinear: add MxL86211C VDDP supply
Date: Tue, 20 Oct 2026 11:35:34 +0200
Message-ID: <20261020093655.344585-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.56.0
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

Describe the optional VDDP supply used by the MxL86211C PHY. Its
voltage determines whether the MDIO, MDC, and MDINT pads use 1.8 V or
3.3 V.

Existing device trees do not describe the supply and rely on the hardware
reset default. Keep the property optional to preserve their compatibility.

Select the MxL86211C PHY ID and nodes using the existing MaxLinear
broken-interrupt property, so this binding is checked during normal DT
validation. Restrict the new supply property to the MxL86211C with the
compatible conditional.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v3:
- Make VDDP optional for existing device trees.
- Select MxL86211C nodes and nodes using the legacy MaxLinear property.
- Replace the empty then branch with a negated compatible condition.

Changes in v2:
- Model VDDP as a supply instead of a regulator provider.
- Select the schema for the MxL86211C PHY ID.

 .../bindings/net/maxlinear,gpy2xx.yaml        | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml b/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
index 8a3713abd1ca9..53f430e121510 100644
--- a/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
+++ b/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
@@ -10,10 +10,37 @@ maintainers:
   - Andrew Lunn <andrew@lunn.ch>
   - Michael Walle <michael@walle.cc>
 
+select:
+  anyOf:
+    - properties:
+        compatible:
+          contains:
+            const: ethernet-phy-idc133.5400
+      required:
+        - compatible
+    - required:
+        - maxlinear,use-broken-interrupts
+
 allOf:
   - $ref: ethernet-phy.yaml#
+  - if:
+      not:
+        properties:
+          compatible:
+            contains:
+              const: ethernet-phy-idc133.5400
+        required:
+          - compatible
+    then:
+      properties:
+        vddp-supply: false
 
 properties:
+  vddp-supply:
+    description: |
+      Optional regulator supplying the VDDP pin. Its voltage configures the
+      MDIO, MDC, and MDINT pad voltage and must be either 1.8 V or 3.3 V.
+
   maxlinear,use-broken-interrupts:
     description: |
       Interrupts are broken on some GPY2xx PHYs in that they keep the
@@ -45,4 +72,25 @@ examples:
         };
     };
 
+  - |
+    vddp: regulator-vddp {
+        compatible = "regulator-fixed";
+        regulator-name = "vddp";
+        regulator-min-microvolt = <1800000>;
+        regulator-max-microvolt = <1800000>;
+    };
+
+    ethernet {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy@0 {
+            compatible = "ethernet-phy-idc133.5400",
+                         "ethernet-phy-ieee802.3-c45";
+            reg = <0>;
+            vddp-supply = <&vddp>;
+
+        };
+    };
+
 ...
-- 
2.56.0

