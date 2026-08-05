Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267893C1406
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 02:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785896918; cv=none; b=S+kCPVfAOTi1ybx6bubXQN018OhLXq1Bjla3VTSl12hPFmLiLFtlgyXELO4n20IfAoWyOlU4TrLyGLNvlfpcMaURsSNBqyyaxwBWvJGq+U8OZ/lfLZpRh7iMdlAeCqDmRu3yBJsFtN4v7zPCRpA2F1c1hdjn1bmJd6SM1QWmsaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785896918; c=relaxed/simple;
	bh=q+8gVOKLd88te1BW659igZ2T20EfQQD8SX4NxV6IpGw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZQ/hxFb0dh2PsEhamAW7l7x0QhNYAb/Vc76J2fzt9MW05IwgY2RFvzOb6KsoNqevNC2hVc2nbrJkCcjtcXy+FcF3vJ+gYLyfHf2pNCYQLbLr9h3oTTBp/4W4aQfNFLJfbR1NjrHuvqhZCtBAinp0EzL27do80ES/nXMyrqz/7Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qQKm/yBU; arc=none smtp.client-ip=209.85.210.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qQKm/yBU"
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-7ebd88be784so359875a34.2
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 19:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785896915; x=1786501715; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AGkeXkcQmVAMhKi4BRouTjNasW9FdK69cwCP5dyljV8=;
        b=qQKm/yBU/QbdfoS19ZxFuTtJGVJAWb4k6kv/YCq97GLSnQ+WgpvAyAK7BadSw+mqjl
         WfQRrHuw4nZpOsx/d9/O44cJ/UHoXhRexZQW4fWK2GXZiWqvUWVUKLy1GLapg5bXtFT0
         oHAR9gSiesCBx2iIUB8LN3GB6WY59Cq3L9AZg16fXGEH4U5SAzD9N3WWgEngfHqskk3H
         BrBWXBBXDcctuQHTxsqPXSK91YE8F4qf0ITlS1GSiFLZo8VXQFwZ5UewvLynFLsamfsV
         wlSqqrC0wSuACLWRCNjGFRi1+qkJSo839vrJCYNrmiM88iNR8KNFlSq9nikSIri8gx3j
         BiIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785896915; x=1786501715;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AGkeXkcQmVAMhKi4BRouTjNasW9FdK69cwCP5dyljV8=;
        b=hN6osXRegOymKfAq7mSHfn0cVp6tP0fJZ3L0bOVJmqbghH8hex7ODbAXckw5BNDK6x
         lfUnCBZAnAh88NCuxDYrKLQ24TEATFaT8s73ZLLsJTgEo+AqmxBdsVgY/FMsuo5S0py1
         FPh8ke/kynJ2XnctY55Pm6368QsNdPz6yZdCsNtzJ17WOKRv+97k4Oe8O0P73i7WfU+m
         CM/kGQlhxlkXJsO+84ajCCOzPh9r8XAkt2zzUnesNohM12DykNVoyYVHAsBXC/GR52nv
         VvWNjLkMirwLSdK5F9w9mvqOu+wxGgUsS+1wmhhWGCEYHgm1Em1jj/3K/0fHQkC6jfxp
         NPZg==
X-Gm-Message-State: AOJu0YzK3eblVe6ysvXca2Nws+9uCQJYedHdpUh2NncmiGEPqcD6UI8I
	R3DiZDt4W2QsUExd92a7Dh5HrTl4QyGtzYs2q+oFCu+VZuu47QAi2+jq
X-Gm-Gg: AR+sD13x5/McL0pmhyLRD8T/G4L2g30J0xMNf6O5eTgG9n7G8MfDjiBzSOD3tHEDyzk
	TiFY1QAICM76Sm1T10xwWq/bEVRx2sm1jDlvLbuJbW3IqqvJ6pLvqubxVegQCu1wHaipNnzXsSs
	4PcsZzNA5ZooL7BxqyOZenhpjtmnZ4CJZnceY8hyvFLjKgieMIPULMa37RlYAOnOsxYoUA1D2Hb
	OBSIMB6WscVXsCFhpsPLe3NxkwHSBt++ZGKKIFigg9rkOwfHsoQff6BqvCe4p6koz4jtGxJH/UF
	oaDXqDcxMKS0DarzeAVtkQqFw8h55wjPce6pkv9YwYo+lPLjiE6YpftLrD7bxMRV8S6Gemz1nMF
	7PJQEH2N3HOJZX8BFpp3HVJxtJnU98yIJEcjWuRs+wtj7tmbeac9rNYYk00LPMxd/iA8unlUUUP
	Mr/NTjTINyT+k+L4gTKpLTq8rTNKd6qDoBuwMAyy+8FtHp6wESMx4OFH4e7NbKb32OvJoW4KFuq
	N7959R6DAG3Bb+d3tD+58c4fIQafSGOIooTKm5aPmuaSUZOU+AdUQyhLkshkCtU4XvpEdMFyuC1
	ldAzWyVclG8UVD9NJabx1Dkp3Fz/DwgZOFVDGa0MevQkCMnPo3KmdXqBbHxcH3HAvVt5y9KDW9a
	dO0axn79JVHOtTdaY
X-Received: by 2002:a05:6830:7010:b0:7e9:d634:77b8 with SMTP id 46e09a7af769-7f1e5c13e8cmr2629082a34.2.1785896913436;
        Tue, 04 Aug 2026 19:28:33 -0700 (PDT)
Received: from [127.0.1.1] (184-96-154-59.hlrn.qwest.net. [184.96.154.59])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f1df565d37sm2078153a34.16.2026.08.04.19.28.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 19:28:33 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Date: Tue, 04 Aug 2026 20:27:03 -0600
Subject: [PATCH net-next v2 5/8] dt-bindings: net: x-powers: add AC300 EPHY
 control
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-submit-acx00-of-dynamic-v1-v2-5-3eef49ff1d8c@gmail.com>
References: <20260804-submit-acx00-of-dynamic-v1-v2-0-3eef49ff1d8c@gmail.com>
In-Reply-To: <20260804-submit-acx00-of-dynamic-v1-v2-0-3eef49ff1d8c@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, Heiko Stuebner <heiko@sntech.de>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

The AC300 exposes its Fast Ethernet PHY control registers through a
separate non-PHY Clause 22 address. The manual defines that address as
the link PHY address plus 16, giving control addresses 16 through 23 and
link addresses 0 through 7.

Describe the control endpoint, its required VCC1 supply, its 24, 25 or
27 MHz input clock and its SoC SID calibration cell. The actual PHY
remains a separate ethernet-phy node and supplies the MAC-selected
interface mode at runtime.

Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
---
 .../bindings/net/x-powers,ac300-ephy-ctl.yaml      | 70 ++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/x-powers,ac300-ephy-ctl.yaml b/Documentation/devicetree/bindings/net/x-powers,ac300-ephy-ctl.yaml
new file mode 100644
index 000000000000..8a616ff3e89f
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/x-powers,ac300-ephy-ctl.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/x-powers,ac300-ephy-ctl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: X-Powers AC300 Ethernet PHY control interface
+
+maintainers:
+  - James Hilliard <james.hilliard1@gmail.com>
+
+description:
+  The AC300 Fast Ethernet PHY has a separate control interface accessed as a
+  non-PHY Clause 22 device. Its address is 16 plus the address of the link PHY.
+
+properties:
+  compatible:
+    const: x-powers,ac300-ephy-ctl
+
+  reg:
+    minimum: 16
+    maximum: 23
+
+  clocks:
+    maxItems: 1
+    description:
+      AC300 input clock. Its configured rate must be 24, 25, or 27 MHz and
+      determines the corresponding EPHY_CLK_SEL value.
+
+  vcc1-supply:
+    description:
+      3.3 V supply for the AC300 I/O, bandgap, Ethernet PHY analog front end,
+      and internal digital LDO
+
+  nvmem-cells:
+    maxItems: 1
+    description:
+      SoC SID cell containing the Ethernet PHY calibration value written to
+      the AC300 BGS_EFFUSE field after adding 3 modulo 16, as prescribed by
+      the vendor initialization sequence.
+
+  nvmem-cell-names:
+    const: calibration
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - vcc1-supply
+  - nvmem-cells
+  - nvmem-cell-names
+
+additionalProperties: false
+
+examples:
+  - |
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ethernet-phy-control@10 {
+            compatible = "x-powers,ac300-ephy-ctl";
+            reg = <0x10>;
+            clocks = <&pwm 5>;
+            vcc1-supply = <&reg_3v3>;
+            nvmem-cells = <&ephy_calibration>;
+            nvmem-cell-names = "calibration";
+        };
+    };
+...

-- 
2.53.0

