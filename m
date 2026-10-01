Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEA252E06C
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 15:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790869423; cv=none; b=Kk7oe/oJHOehqmrhOWJfSb6StFEqemM/h6cj5T7a6psk6Xpf1ec1kwumAD43MbhBMYz5fpYaXtXGxhkVpd27WEQ2m9kKrlldanfq1Pj8H7NrbydkUkWfg4YqhtSpwW0aXBjvQbdHoeFUuvMpSApLkOw6hmA4GstkSu6l/D8hClo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790869423; c=relaxed/simple;
	bh=786heOVYaMb1rFh7lLcVgEf4OauBBj22Zz92FumkfwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GoZjkZ+HXLSGFNJcuiiDPMypNLc4X68IFrg3dGZYz/76sfkVChrJPqa2Ns87srHTJEcOnlkZ8RdHm67rnQKpqnp556g3Yh9WAn0vX1U3Dsg76LeVDPXxQMcVvQRhLE2uoVP8ZNbCArwbzaWy3O96/DsHOhnwG35UbjRYZAuv+kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VL2v9AC4; arc=none smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VL2v9AC4"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48affb828f1so2007104f8f.0
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 08:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790869418; x=1791474218; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V4LmRzbxM3Ic2+TqG4WYb8ERzK3nxO5TL05kC226JXY=;
        b=VL2v9AC4lclZK4hmsSmhHMLNCa2NGWh/xl1+ZCvnDssrvRSqk3mzjU9YlcjByPjBM1
         19VC+VTg9mhklW7jEBtS9O4A1XQs+KecdCr+EmF6F6aQ7EEMarTu6ezJcEyZ2hUXPYRn
         pm7CWDN58p7TM3gIBTFo9p+hTlYRdYTtqXjsdJ93WKjNiyXIEjJ3AVh1DSTsRUBQcjv2
         uO2ZPZWWM4i6DqNrSvSrE2z5ljHu9trUd3XGrTVkEE1EAS4Zy71egpcPro59yeemhYQ7
         4ucv9/G/gWx+/F3qF7pAgqc0VJY+B6BD/klb6meMVoO0i6dG4sg3q5nDc04bt3AqDi3a
         t3kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790869418; x=1791474218;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V4LmRzbxM3Ic2+TqG4WYb8ERzK3nxO5TL05kC226JXY=;
        b=KUDAmRruEU2Kde0jnLh8aVrvj5no16zHy0aAepySNDdY+nperCdve4rNUOvJxeZXjj
         itqK4sG6dGghabEIKXEoLnK9txWvHABwhlDtQvW45+2LiLek9VjmytP6I+CYax/hq/+s
         MBb/qAPYdDLPUIf9LRpkELRg/rZdzvuZVFj7z2ZOIrxJvWgRRIoHw5T8egn6ZW3EqMeI
         Hcyv687NyGeVfGPfNwkgLGH4OnFknekLBUQ3ZhjtzxB6do8Goy/VkWwKomBqZyah6Xqm
         jOJTLmeePX68wzq/fueFjJPjI/Bt93UnsF/Y512tQW+jjc16NpfmLnSlvlf6MdsrjLya
         p7nQ==
X-Forwarded-Encrypted: i=1; AKwUvBz4baTPkfwyaQ9uD/eBwOqPxT4KIWjXw3gMR8pF1sxHIlJCBXy2DO4fijtI2+rshppGkIWTBXw=@vger.kernel.org
X-Gm-Message-State: AFuF++k4BYbwGHsMxSGSCLcnviY/cFSJdbiPNKjASDiY4upq6evg65LY
	3CeDNFqJPuhc0HUbcM3kKITKDh5u8buFiwzGn6nlBt8sNXgS5U4vo0ye
X-Gm-Gg: AYBFou0XbDhLo1STceNvm+jgFvHnJYBRZW6hecH1TZ59fzjcKtXrVz3D0zkuXCyxwtO
	p6EnCkI7uO9vUVfSBZqzO3LFRhypu6PVaeauMlh5i6BvZQhRZbqfLy5r2il4GhL2iiYu6JNUHZk
	Rl8STaZvOjoPu26cxPWC9rsW2GENBQEgBaiijdWo8AeQKFi9qSPIJ3YYqkO+V1dtv0JOLoGxU+r
	cqYlH7bc+9jLyWXZLOuHyNA1s8ha+ySB/f4hdO1VgctX7RTXW9WXOnUekoVSegtFKYsnzX+Itt3
	OgVZ7Sj/nsxaLMSim81JrQpGHtMMp4okjCxtZxGBj8aihVhCIAd7KFVm8qKjhD5p18f9Z6XKN0O
	KH4oebGBLqpVrtX+VzyyVabRLuxZYZcayUlVrV5cHOLhjvQ0QUIhYpK5dlYqXpW0oTC0t4H9Qi/
	yfKSO8cwsQqMLg1K/pI9KHZ7n/v2pG4KicADqKHMYttK3C6kpddrOp8AjSNR1SS+m2x+Js+uh8d
	2nF+hfFfXOqU1edFkyjXZCugauf4fm0UPVGUesz4vdKbNASzAoonRFUK4BSpNq/DYcb1Q1V3bgb
	7SFFaYLboIvhOaBJ43c=
X-Received: by 2002:a05:600c:c494:b0:49c:fe46:7219 with SMTP id 5b1f17b1804b1-4a027564de9mr381585e9.20.1790869417539;
        Thu, 01 Oct 2026 08:43:37 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:1be5:ad57:d5e0:f854])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a01f6db98fsm65195615e9.0.2026.10.01.08.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 08:43:37 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: =?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <clement.leger@bootlin.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Russell King <linux@armlinux.org.uk>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-renesas-soc@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH net-next v2 04/12] dt-bindings: net: dsa: renesas,rzn1-a5psw: Add RZ/T2H and RZ/N2H ETHSW support
Date: Thu,  1 Oct 2026 16:43:17 +0100
Message-ID: <20261001154326.754314-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001154326.754314-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261001154326.754314-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Extend the A5PSW DSA binding to cover the ETHSW variant used on newer
Renesas RZ/T2H and RZ/N2H SoCs. ETHSW is derived from the A5PSW switch
found on RZ/N1 but differs in register layout, clocking and interrupt
topology, and exposes four ports in total (including the CPU/management
port) instead of five.

Update the schema to describe these differences by adding dedicated
compatible strings for RZ/T2H and RZ/N2H.

Use the RZ/T2H compatible string as the fallback for RZ/N2H, reflecting
that both SoCs integrate the same ETHSW IP.

Add myself as a co-maintainer of the binding to support ongoing work on
the ETHSW family across RZ/T2H and RZ/N2H devices.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
- Added full names for SoCs
---
 .../bindings/net/dsa/renesas,rzn1-a5psw.yaml  | 154 +++++++++++++++---
 1 file changed, 130 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml b/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml
index fab6aa6237e9..863633185912 100644
--- a/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/renesas,rzn1-a5psw.yaml
@@ -4,43 +4,108 @@
 $id: http://devicetree.org/schemas/net/dsa/renesas,rzn1-a5psw.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Renesas RZ/N1 Advanced 5 ports ethernet switch
+title: Renesas RZ/N1 A5PSW and RZ/T2H, RZ/N2H ETHSW Ethernet Switch
 
 maintainers:
   - Clément Léger <clement.leger@bootlin.com>
+  - Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
 
-description: |
-  The advanced 5 ports switch is present on the Renesas RZ/N1 SoC family and
-  handles 4 ports + 1 CPU management port.
+description: >
+  This binding describes the Ethernet switch IPs used on Renesas SoCs:
 
-allOf:
-  - $ref: dsa.yaml#/$defs/ethernet-ports
+  - The A5PSW (Advanced 5-Port Switch) found on the RZ/N1 family, which
+    provides 4 external ports and 1 CPU/management port.
+  - The ETHSW (Ethernet Switch) found on the RZ/T2H and RZ/N2H families,
+    which is derived from the A5PSW IP with some register layout
+    differences, additional timestamping support, and a total of 4 ports
+    including the CPU/management port.
 
 properties:
   compatible:
-    items:
-      - enum:
-          - renesas,r9a06g032-a5psw
-      - const: renesas,rzn1-a5psw
+    oneOf:
+      - items:
+          - enum:
+              - renesas,r9a06g032-a5psw
+          - const: renesas,rzn1-a5psw
+
+      - const: renesas,r9a09g077-ethsw
+
+      - items:
+          - const: renesas,r9a09g087-ethsw
+          - const: renesas,r9a09g077-ethsw
 
   reg:
     maxItems: 1
 
   interrupts:
-    items:
-      - description: Device Level Ring (DLR) interrupt
-      - description: Switch interrupt
-      - description: Parallel Redundancy Protocol (PRP) interrupt
-      - description: Integrated HUB module interrupt
-      - description: Receive Pattern Match interrupt
+    oneOf:
+      - items:
+          - description: Device Level Ring (DLR) interrupt
+          - description: Switch interrupt
+          - description: Parallel Redundancy Protocol (PRP) interrupt
+          - description: Integrated HUB module interrupt
+          - description: Receive Pattern Match interrupt
+
+      - items:
+          - description: Switch interrupt
+          - description: Device Level Ring (DLR) interrupt
+          - description: Parallel Redundancy Protocol (PRP) interrupt
+          - description: Integrated HUB module interrupt
+          - description: Receive Pattern Match interrupt 0
+          - description: Receive Pattern Match interrupt 1
+          - description: Receive Pattern Match interrupt 2
+          - description: Receive Pattern Match interrupt 3
+          - description: Receive Pattern Match interrupt 4
+          - description: Receive Pattern Match interrupt 5
+          - description: Receive Pattern Match interrupt 6
+          - description: Receive Pattern Match interrupt 7
+          - description: Receive Pattern Match interrupt 8
+          - description: Receive Pattern Match interrupt 9
+          - description: Receive Pattern Match interrupt 10
+          - description: Receive Pattern Match interrupt 11
+          - description: Switch timer pulse output interrupt 0
+          - description: Switch timer pulse output interrupt 1
+          - description: Switch timer pulse output interrupt 2
+          - description: Switch timer pulse output interrupt 3
+          - description: Switch TDMA timer output interrupt 0
+          - description: Switch TDMA timer output interrupt 1
+          - description: Switch TDMA timer output interrupt 2
+          - description: Switch TDMA timer output interrupt 3
 
   interrupt-names:
-    items:
-      - const: dlr
-      - const: switch
-      - const: prp
-      - const: hub
-      - const: ptrn
+    oneOf:
+      - items:
+          - const: dlr
+          - const: switch
+          - const: prp
+          - const: hub
+          - const: ptrn
+
+      - items:
+          - const: switch
+          - const: dlr
+          - const: prp
+          - const: hub
+          - const: ptrn0
+          - const: ptrn1
+          - const: ptrn2
+          - const: ptrn3
+          - const: ptrn4
+          - const: ptrn5
+          - const: ptrn6
+          - const: ptrn7
+          - const: ptrn8
+          - const: ptrn9
+          - const: ptrn10
+          - const: ptrn11
+          - const: tp0
+          - const: tp1
+          - const: tp2
+          - const: tp3
+          - const: tdma0
+          - const: tdma1
+          - const: tdma2
+          - const: tdma3
 
   power-domains:
     maxItems: 1
@@ -50,14 +115,21 @@ properties:
     unevaluatedProperties: false
 
   clocks:
+    minItems: 2
     items:
       - description: AHB clock used for the switch register interface
       - description: Switch system clock
+      - description: Timestamp clock
 
   clock-names:
+    minItems: 2
     items:
       - const: hclk
       - const: clk
+      - const: ts
+
+  resets:
+    maxItems: 1
 
   ethernet-ports:
     type: object
@@ -73,14 +145,48 @@ properties:
               phandle pointing to a PCS sub-node compatible with
               renesas,rzn1-miic.yaml#
 
-unevaluatedProperties: false
-
 required:
   - compatible
   - reg
   - clocks
   - clock-names
   - power-domains
+  - interrupts
+  - interrupt-names
+
+allOf:
+  - $ref: dsa.yaml#/$defs/ethernet-ports
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: renesas,r9a09g077-ethsw
+    then:
+      properties:
+        interrupts:
+          minItems: 24
+        interrupt-names:
+          minItems: 24
+        clocks:
+          minItems: 3
+        clock-names:
+          minItems: 3
+      required:
+        - resets
+    else:
+      properties:
+        interrupts:
+          maxItems: 5
+        interrupt-names:
+          maxItems: 5
+        clocks:
+          maxItems: 2
+        clock-names:
+          maxItems: 2
+        resets: false
+
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.55.0

