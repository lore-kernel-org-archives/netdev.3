Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B4292D7817
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 11:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792149647; cv=none; b=miofpb9EWhY2nSyYtC0s4LfwnNx2HwE8ntEX0sSCGHJARRyWNmxrf2o4SAfOit4EkV4STHU0NE3PZPRCM1AJ+zUlALo7KQU12Rlx64jaeJAeaP6LYQpUvnM1hpkpyy1RsAjVZY2Mo/yWBk0Bl9lVA56mlHHLNvgBdmNSuD/fJ98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792149647; c=relaxed/simple;
	bh=+OdSs83QXKRZeXBku3v0tG7jLA8SyVPmuroYMjYCBl0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EndQpQ1DUFdNEbbcD9Mydog7ouTDfOR+ou7IrH1kS3ZUSjtoAhNk3kZfVbq3StTSawuoSPQ7XmDQvsscv2hOpnbYlhx31oVJUiL4oovrX3YcuMX+SBQlSF18cSo8ixb815hd1Pnd54Qk+DZlHNaDpepD1hEiylLrw6yspnUlRdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=eNjmrs5l; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="eNjmrs5l"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c2dc63f8d8aso1099925166b.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 04:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1792149645; x=1792754445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nP6Hen4ha32UaSHEgIpuQsbgsTYGlvUW0UsDEzDl+hQ=;
        b=eNjmrs5lbIqzIJ8J3huCanjBIWaxjFGuEudBBZEpadeBVSF6NNWLmuN/aqs/plPnzq
         34iCDo16j6BEewJz/hEbuZ97OdcddusLkWcrOtqDSeddl3KY4aF8ZsOh+KoNrwNlagQo
         lgofYV7gXr4IqgUChJKZ/YQc7tlvTMOIVhFX6o0psOK9SW+1lKg8hBsX2Vxavf8yUYxc
         fN0m+EjONRqPJtss85P6/fiBsZYVN5xSax3YyqaGMP2EDfArUJ8X/dhV4T/B4SnsFnf9
         Jem6bvuQyUTeag+MRZTagzqnT0sZSMQ4TS8WJ7gzk06sKWYoCrHkLBRyS95TDQBe3UDs
         kx5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792149645; x=1792754445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nP6Hen4ha32UaSHEgIpuQsbgsTYGlvUW0UsDEzDl+hQ=;
        b=Jyc1mFKOG1rnboT0uaOBouvvQrzf57Wu++Jw1qpofjmwC0HvFi7ZyIT5/1AJgFS0E+
         eu45DO/Vd+UfIjfj8omSJhHbiEweLrBVoJmlK+c7GToPXpF0/v5S6v/BQgiCDDWWkApp
         yyLk8shP+JDTVfYTpiiXg7JpARadbzv4sZEwDLSYn+9W2H4Et5AtJyuaAhTKRIPZczpJ
         JB5ucaFiYMyO4CDk8kjFpAHrewlWlCeK+pbtuaYVMbDoRNSV3OJtYyxEOsx3bNYLLGN4
         Ls7W44LjFbaVLI92DZT8B5Tp05wlBcCqpzEm5sZW4DCjxRyvRmfWkSsjFkdfVIEBVEcM
         K7Mw==
X-Forwarded-Encrypted: i=1; AKwUvBzwbTRdKAjGfJlg4UA9JYqaolXgJRsaxsn3iiuDNm+DkDagc8oJyb8IBZ/ySZmmOA+mC9pJykQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYI21LuBdR1OQ1p4ej+FlFUeB4+pjyrCOmfk89DXnrLzSkZP8r1u
	DZPFyd2iaRSRq6GArPah5h2wbxVadkuI/GrogAcKvpsqsVFeBMewEfAODAJ6TMVmFlE=
X-Gm-Gg: AYBFou0VbzFWyiACJ8RERpERmNLFoCpxQIj5RE5n84OnyCBglCTlacAzcokeaGLiFoD
	RX2UhjnVfd3YAU1K7IBStxm0cTPNbSleo+YmAreSxCnGpirwy59NRI+Gv4PSYiKxvtcw42DduFd
	euy1Tu8z09xORcgrjXp4JY/1Dpe2SJdoSQgQTDPZC5r9N9k1Uxa0pvreP3C64M3r4drBLn2oVZ1
	0L5YPjUFnIghryk/igQq+gBPusUr2iBupyUPBcaW1c9vkcRi+cflAA2CVzpsfInCEqj4Jfql+bY
	9AKUnR25DGTjjCGpJYV31CKVE7plQDzMPXal7Zi7ifY0YKCCP3FwQ1YUbq3qlqVdqBtFUp6MkPo
	X3333pbY4nKMwHNxgQjt7lgeSoCnwaeT5j69NjE3NHnOqg4UbghwflDWC9IK78G4GMsPcrvhx9S
	H7y00EBuMWog8ASfhee1dB2054hi8PcCXHK/OnZOFjUiw99fzq4rmWVLDWEpT1OkZYs8iGp31pE
	1zF0Mnyi83Uk5KCIbs/SoeHYVjrtngucXRr7ymsJCokDJPCaodDYzMZM6Vs+YHZNZairuy5TDJ5
	oJ5cAHFqrDOuAryNKFtdoAIfH5bA
X-Received: by 2002:a17:906:478d:b0:c41:4d5:e97c with SMTP id a640c23a62f3a-c4104d5f1abmr63177666b.37.1792149643725;
        Fri, 16 Oct 2026 04:20:43 -0700 (PDT)
Received: from threadripper-fedora-workstation (dh207-15-194.xnet.hr. [88.207.15.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c408e32c075sm63947666b.11.2026.10.16.04.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 04:20:43 -0700 (PDT)
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
Subject: [PATCH net-next v2 1/5] dt-bindings: net: maxlinear: add MxL86211C VDDP supply
Date: Fri, 16 Oct 2026 13:19:32 +0200
Message-ID: <20261016112033.949026-1-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe the VDDP supply used by the MxL86211C PHY. Its voltage
determines whether the MDIO, MDC, and MDINT pads use 1.8 V or 3.3 V.

Select this binding for the MxL86211C PHY ID so the supply requirement
is validated.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
---
Changes in v2:
- Model VDDP as a supply instead of a regulator provider.
- Select the schema for the MxL86211C PHY ID.

 .../bindings/net/maxlinear,gpy2xx.yaml        | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml b/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
index 8a3713abd1ca9..a0dfb6192d81b 100644
--- a/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
+++ b/Documentation/devicetree/bindings/net/maxlinear,gpy2xx.yaml
@@ -10,10 +10,38 @@ maintainers:
   - Andrew Lunn <andrew@lunn.ch>
   - Michael Walle <michael@walle.cc>
 
+select:
+  properties:
+    compatible:
+      contains:
+        const: ethernet-phy-idc133.5400
+  required:
+    - compatible
+
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
+      required:
+        - vddp-supply
+
+    else:
+      properties:
+        vddp-supply: false
 
 properties:
+  vddp-supply:
+    description: |
+      Regulator supplying the VDDP pin. Its voltage configures the MDIO,
+      MDC, and MDINT pad voltage and must be either 1.8 V or 3.3 V.
+
   maxlinear,use-broken-interrupts:
     description: |
       Interrupts are broken on some GPY2xx PHYs in that they keep the
@@ -45,4 +73,25 @@ examples:
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

