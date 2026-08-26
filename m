Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 658D33EDAC9;
	Wed, 26 Aug 2026 12:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787748544; cv=none; b=ch8hep0Y8imnnxoQ0vEjafh34MRbxf54X/IRN+Mc2xrX+2xmUQQR142kzrSsJTv5KVm67kjgrMGVy54hwQBfi3q6mAymyNM2bsPBf+dE5B2t9zluJ36gS0f+YXxZunKLrnRxSttSoLHSNGl6RxMVaaNSw/qWPq3acCl3j98wNXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787748544; c=relaxed/simple;
	bh=FwO7NRScNjPZPZNztHILGrfKLuGU+02hnMNDWWbRBEI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=h4K1WPyNsoY+aSLvyhgXdNdqZI5w7X6TxO3EL9+TMJOucKiri8mEAHG28uEtLQXHeTaP/hPDnD0K/Tm++xU/t3JY3+v/FxSk3Z8ONOlP0Me9kVYlM5BKsXCJnK8v2Lb6xCeaaJlfjQ06RlZg1DLJLz/ZV66ijDIrJNBfWizH+hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 3C3272021C8;
	Wed, 26 Aug 2026 14:48:56 +0200 (CEST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1wzD3o-003RRH-0P;
	Wed, 26 Aug 2026 14:48:56 +0200
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Wed, 26 Aug 2026 14:48:40 +0200
Subject: [PATCH v2 2/3] dt-bindings: dp83867: add binding for
 output-impedance
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-v7-2-topic-dp83867-v2-2-a97b4cec6e93@pengutronix.de>
References: <20260826-v7-2-topic-dp83867-v2-0-a97b4cec6e93@pengutronix.de>
In-Reply-To: <20260826-v7-2-topic-dp83867-v2-0-a97b4cec6e93@pengutronix.de>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrew Davis <afd@ti.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Steffen Trumtrar <s.trumtrar@pengutronix.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1795;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=FwO7NRScNjPZPZNztHILGrfKLuGU+02hnMNDWWbRBEI=;
 b=owGbwMvMwCUmtVehiCsuTInxtFoSQ1bfg20/l07cJNjMUcgY+ojbUVn8/p5JD2tlToTc2ev0j
 69rFffkjlIWBjEuBlkxRRaVhRV8oh4fPCOniXDBzGFlAhnCwMUpABNJKWT47+F7WNr+cfSqRZPM
 zytqh7yZwfljqujpz/e/MreZbT1dL8Pwv/ab8LoZLOVTlxdmBi3p0ze4kL9mQT2Lk2RDifHS8sP
 X+QA=
X-Developer-Key: i=s.trumtrar@pengutronix.de; a=openpgp;
 fpr=24A1780E1548F0495996140A1ABD20720A5E5622

Currently, the output-impedance can only be set to default, minimum or
maximum or via a nvmem cell.
In cases where there is no backend for a nvmem cell, a value can not be
set.

Add a DT binding, 'ti,output-impedance-ohms', for specifying the
output-impedance via a fixed value. The existing boolean values for
minimum and maximum still take precedence over the new value.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 Documentation/devicetree/bindings/net/ti,dp83867.yaml | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/ti,dp83867.yaml b/Documentation/devicetree/bindings/net/ti,dp83867.yaml
index 7a6fe516bab27..49fafe3ce6f47 100644
--- a/Documentation/devicetree/bindings/net/ti,dp83867.yaml
+++ b/Documentation/devicetree/bindings/net/ti,dp83867.yaml
@@ -38,6 +38,16 @@ properties:
     items:
       - const: io_impedance_ctrl
 
+  ti,output-impedance-ohms:
+    description: |
+      MAC Interface Impedance control to set the programmable output impedance.
+      Valid range is 0x00 to 0x1f (32 steps).
+      - 0x1f = 35 ohms (minimum impedance)
+      - 0x00 = 70 ohms (maximum impedance)
+      - Step size varies with process.
+    minimum: 0
+    maximum: 31
+
   ti,min-output-impedance:
     type: boolean
     description: |
@@ -121,6 +131,12 @@ allOf:
       required: [nvmem-cells, "ti,min-output-impedance"]
   - not:
       required: [nvmem-cells, "ti,max-output-impedance"]
+  - not:
+      required: [nvmem-cells, "ti,output-impedance-ohms"]
+  - not:
+      required: ["ti,output-impedance-ohms", "ti,min-output-impedance"]
+  - not:
+      required: ["ti,output-impedance-ohms", "ti,max-output-impedance"]
 
 required:
   - reg

-- 
2.54.0

