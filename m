Received: from mail-ed2-f32.google.com (mail-ed2-f32.google.com [74.125.228.96])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78A33E410D
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 12:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.96
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790770996; cv=none; b=p2+wJPg7LJDo0CLteFSDqhTX/cc/Xe99iNluICShECi+hgkb5lPICmhfyKuIkAwBT5qKBdCV+JAabUVeUFTEQyjRYSB9Z06tJYDAtr2G/EKNifdaOchl1O1WkVPAg1NK3Gw4/v4xHDCVamcqHIgVELaXUoPRp7vyXqKuIW/DmW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790770996; c=relaxed/simple;
	bh=hd66VCJ3K0RoXkl/bUrVexrnvv/K041uRHih0HcPJLA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q9ozv3jjZndW2orgpmNdCbIAFgFhVKOWmM7V+UNyLqS6t2wGb+rLu2bvsUiQ2H2He/peN/YjKEQosl9FYeqCREKYPFmRXDFWBc7cbCl25p8EVyMIzJcK4XqUW9sgJUIjQ7WStwBZxa6UomSvN+JRkDx7ZMtFf/ZoPMt4Dy688s8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=AR7Kjy4h; arc=none smtp.client-ip=74.125.228.96
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="AR7Kjy4h"
Received: by mail-ed2-f32.google.com with SMTP id 4fb4d7f45d1cf-6acb6b726b5so2894187a12.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 05:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1790770993; x=1791375793; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uTmXsnC8RxOPoTRudDkJpI91DV2+W3uFeKU9KvirJ9Q=;
        b=AR7Kjy4hQnaTlj9ensLiGt5clD38S8VlpsFB7IJErtO77C5cjJHEOnMSMSOC9C++d7
         BJpfRYlwt+RcW37w8I7uwQh3EFVCiQiE6hL+oZk5bgL2eAZzprPebRFSTYv1xMX6VH8Y
         zs3do4A4lQf6ij6ZkGnVT6Nwwswg5nF6adcKdiGivpgLXKLb93kCkY7xZS0IsdHSA67C
         yewrMpJJl7BixUSB2Dqkb+QkQxRmYLx5BzRdeXUBocGZF2aD/Lz5BpB1oq8altRT6o7w
         91UnZey9R2nZwBU+HNZBuldEbm2M74l5rfhn46RvBF4AAjGHo7kV5oNEvDhcCQO3zhsA
         3ALQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790770993; x=1791375793;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uTmXsnC8RxOPoTRudDkJpI91DV2+W3uFeKU9KvirJ9Q=;
        b=bdUvrVVM33NO+DO3DF0HK2LWHiBas/6CuGPC+R/SgYCsd1oyi7UTj3gv4HtQ7hV7LC
         YDUEHGmhpwbrj1QiGEUJ/QjezBxVsN5h8IIKfjkMYLzg0t/zFM9wo/qlwt8/daj7HzKD
         lt0179LrUhOZTPBcD+xDBAiQsBErwzhjRv73e7jv8hOlAf4UJmlqAeNY8l1vJ7b4qhDN
         MXeBPDPMhIv1zgZfsJnS99WLF3KZUjM599JNHkWbnAw4/UksYvt5aWWzQYNPW9tbDAam
         qiLqU03hS8CGCJkfLRKSMF3S6nSabI3RUj43oq/q9ztYUmi6XDLMltZv6Iv1QM86n0jA
         uCpA==
X-Forwarded-Encrypted: i=1; AKwUvBxseW3jWeekn4/gSlhAJ7OwR2rfStm/b5+s88Zry844Ef8GKSmzSZ3iF3UqF0gXp2wf3mDjRFE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLjTCxIG/i0DtjQGdWfxxDBuYr3T+Xp+eJ4ZIYkxlnd7a6ch515
	PxmDmVoOxK/a2esk7W1RV9LsR5KytDRz/GpkaZdxOKTefssnbGuicRrxod7NDcq9UBw=
X-Gm-Gg: AYBFou2VMiklCrHNRgm+owhhMVGfdgSDcAY2THqK9WFJl7r8b0s7rps0XqKiVhcymXC
	fhysMJRWwRe64la1Dl+hJ+2fPB5a18vjDLGaxJPXVTtxq40/tfBi0uBPN3bLJOgqgiMQyuPRaie
	uKFDrVclMSaOXw/4n1ZfQutDtUBgiwoT7vUEQKT0tt+YLqIV/qvr4VB5xUbKz51SJGMlorz12jX
	XZ6jh9hxzYmJPcqBANKe6loheitUnLWF61jtEvKMvPusUylyS2+wVDtbIyhSYezlFx2dPPSIHX6
	/DUVVgBxvfednY26gDdHqiUJ5itXUkb2ADQJXXfMGTbtmXZOpGNtfVKQaX0gKqJW5fG4xflhS18
	2PmVjqGEb9h1QHlj0U1f9dmF+RtBYFrt527cumLAeHvGHN7CddyEqjDR9AvYZQt/UwaxEkHROgk
	mB1QfZyoHCZ3qEf9t5l/CT6wHS1q5jPcRpquQ0XfDiP66MnQXSfGPRKtDyHUF+5Nxxfirweq/QE
	3n/hNEA8xKAR8jsWBKaBuuSQVh7JxVcrK3eA/J76nUlvl1dQTEqFjcw12ygSeJbX/75JfvjDLlW
	FV3tYQ7Xs3ejGBIzvWx/nywMiB+8IA==
X-Received: by 2002:a05:6402:23cf:b0:6ab:373:54fd with SMTP id 4fb4d7f45d1cf-6ae1993bc30mr808003a12.44.1790770992881;
        Wed, 30 Sep 2026 05:23:12 -0700 (PDT)
Received: from threadripper-fedora-workstation (dh207-15-187.xnet.hr. [88.207.15.187])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ae1568e5a3sm744042a12.20.2026.09.30.05.23.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 05:23:12 -0700 (PDT)
From: Robert Marko <robert.marko@sartura.hr>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	hkallweit1@gmail.com,
	lxu@maxlinear.com,
	michael@walle.cc,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: luka.perkov@sartura.hr,
	Robert Marko <robert.marko@sartura.hr>
Subject: [PATCH 1/5] dt-bindings: net: maxlinear: add MxL86211C MDIO I/O regulator
Date: Wed, 30 Sep 2026 14:22:13 +0200
Message-ID: <20260930122305.293686-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the MDIO I/O voltage regulator exposed by the MxL86211C PHY.

The regulator configures the MDIO, MDC, and MDINT pad voltage
between 1.8 V and 3.3 V.

Restrict the regulator subnode to the MxL86211C PHY ID and document
the board requirement for VDDP to use the selected voltage.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
 .../bindings/net/maxlinear,gpy2xx.yaml        | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml b/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
index 8a3713abd1ca9..0645e885f1747 100644
--- a/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
+++ b/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
@@ -12,6 +12,29 @@ maintainers:
 
 allOf:
   - $ref: ethernet-phy.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: ethernet-phy-idc133.5400
+      required:
+        - compatible
+
+    then:
+      properties:
+        mdio-regulator:
+          type: object
+          description: |
+            Initial data for the MxL86211C MDIO I/O voltage regulator. Set
+            this to 1.8 V or 3.3 V to configure the MDIO, MDC, and MDINT
+            pad voltage. The board must supply the VDDP pin at the selected
+            voltage.
+          $ref: /schemas/regulator/regulator.yaml#
+          unevaluatedProperties: false
+
+    else:
+      properties:
+        mdio-regulator: false
 
 properties:
   maxlinear,use-broken-interrupts:
@@ -45,4 +68,21 @@ examples:
         };
     };
 
+  - |
+    ethernet {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy@0 {
+            compatible = "ethernet-phy-idc133.5400",
+                         "ethernet-phy-ieee802.3-c45";
+            reg = <0>;
+
+            mdio: mdio-regulator {
+                regulator-min-microvolt = <1800000>;
+                regulator-max-microvolt = <1800000>;
+            };
+        };
+    };
+
 ...
-- 
2.55.0

