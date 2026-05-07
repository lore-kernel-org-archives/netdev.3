Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B619D3624A9;
	Thu,  7 May 2026 09:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778145971; cv=none; b=EcZrNBUpiHzJzdQFoMM1QJTPlfRECUgARyT91A3CLVEoUPMCoAb71t61in1TpLAa8yHZJSYFqPsW4pMDVB3ndGZeALBDIDHHNW+tQeylmjVW2vwZhbz5aHl6SAAc0IruA3N0ar3qZAOsg6vT9RlKtsAiZfhHRtAlb7fpy6KAKpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778145971; c=relaxed/simple;
	bh=M8446rQYXm25f4tOwkQac0ktifqMOUyoEgxlb33J5xI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FHL2gXQVxni4zVOwJ3o/8fksBxeB/kYQVN9+BFDcEqXSriorY/gSMun0tPNYz/igbiuVuGQ7FHvhdIuFzVdFFuUE6SYA0MpROkPtNH03q58mEZwlDsRCAl+x055sge8ZM18HWXUUpNK0+naRvvv/GkBeIVFYIdHxNPM4rjNAueE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C8Gt2DPR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C8Gt2DPR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F418C2BCB2;
	Thu,  7 May 2026 09:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778145971;
	bh=M8446rQYXm25f4tOwkQac0ktifqMOUyoEgxlb33J5xI=;
	h=From:Date:Subject:To:Cc:From;
	b=C8Gt2DPR3kPu9HbsqIvVlCRlfeKMKCmKVuEuwoi/496fGmluE36Kc9OSr3bWL636V
	 JdM9bIMMDkrIJ/aQUaw5t5ahLTRYMDzEYqv4v1+oyP/TvKb3zYZO3Mf7Cs6QDHqVbZ
	 rNvxvHOhMiCV9S5D6/08zUbK9OGar6p3EFxeOQHsfacD46D/yEt3IwNWtDBDGXJ88d
	 BRvKU3jRLf7WuFtMvmfpZ3NDPxlmMa+dK8FmfsNmd29irIHoCtIOr5mY57he2L0txs
	 4IiLEakiKMg2SJ0T8T1jn5b60sQxiXE6Lqm4y+uwyOsMjAG4YJPtMcsw0oserHqk0c
	 VKhsS2A+ld/ng==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 07 May 2026 11:26:01 +0200
Subject: [PATCH] dt-bindings: net: lan966x: Accept standard ethernet
 prefixes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260507-lan966-binding-v1-1-e99293d2a4ec@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMQQqDMBBA0avIrBsYA4m1V5Euohl1Shklo1II3
 r2xXb7F/xmUEpPCo8qQ6GDlRQrqWwXDHGQiw7EYLFqPDhvzDtJ6b3qWyDIZjKO3Aeu7wxZKtCY
 a+fMbds+/de9fNGzXBc7zC/aDzgNyAAAA
X-Change-ID: 20260507-lan966-binding-0df62a018509
To: Herve Codina <herve.codina@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Horatiu Vultur <horatiu.vultur@microchip.com>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.15.2

The dsa.yaml and ethernet-switch.yaml bindings recommend
prefixing ethernet switches and ports with "ethernet-" so
make the LAN966x do the same.

Reported-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 .../devicetree/bindings/net/microchip,lan966x-switch.yaml      | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml b/Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml
index 306ef9ecf2b9..0f0f35865ef4 100644
--- a/Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml
+++ b/Documentation/devicetree/bindings/net/microchip,lan966x-switch.yaml
@@ -17,7 +17,7 @@ description: |
 
 properties:
   $nodename:
-    pattern: "^switch@[0-9a-f]+$"
+    pattern: "^(ethernet-)?switch@[0-9a-f]+$"
 
   compatible:
     const: microchip,lan966x-switch
@@ -70,7 +70,7 @@ properties:
     additionalProperties: false
 
     patternProperties:
-      "^port@[0-9a-f]+$":
+      "^(ethernet-)?port@[0-9a-f]+$":
         type: object
 
         $ref: /schemas/net/ethernet-controller.yaml#
@@ -138,7 +138,7 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
-    switch: switch@e0000000 {
+    switch: ethernet-switch@e0000000 {
       compatible = "microchip,lan966x-switch";
       reg =  <0xe0000000 0x0100000>,
              <0xe2000000 0x0800000>;
@@ -151,14 +151,14 @@ examples:
         #address-cells = <1>;
         #size-cells = <0>;
 
-        port0: port@0 {
+        port0: ethernet-port@0 {
           reg = <0>;
           phy-handle = <&phy0>;
           phys = <&serdes 0 0>;
           phy-mode = "gmii";
         };
 
-        port1: port@1 {
+        port1: ethernet-port@1 {
           reg = <1>;
           sfp = <&sfp_eth1>;
           managed = "in-band-status";

---
base-commit: 254f49634ee16a731174d2ae34bc50bd5f45e731
change-id: 20260507-lan966-binding-0df62a018509

Best regards,
--  
Linus Walleij <linusw@kernel.org>

