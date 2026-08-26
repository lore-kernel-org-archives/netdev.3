Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AC937CD29;
	Wed, 26 Aug 2026 12:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787748544; cv=none; b=V3q3+2j68gTtV1w59Pt2c0uHt+XMgX5kz/MqgAgjFlturmBE+zDEu6G0YDaGl16ZMtQwDRO4oLvwoEu0RYsZ2nJ/7tgkftbWnv+ilvlo8DUKYNxwmhFFvHUbZl3Fnuh/ykzVUW5maxJmQZ8G0UAfVySVmLb+KgZc1bS6FPlqbDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787748544; c=relaxed/simple;
	bh=mUrPlJT0hJRrTfA5qoFrn9r4BgqyF0M1XSh9PhhKE4g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SUcJ5t9vjn5PIW5o2JUjGjJgOUARLkb43vVdx0TxKrrsLt6JQ8iM3SA8XOv4UOsNtHnm9CMWs1l4sO8kpJthAdH/ukTJfmJ8f9YyC5c9AmEzbYlcVvl9HSslD0yB8Rkg/rRvOHGDYEro7nfYvaMj7Fn1uRiLXQ0xSFvesKvq1iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id D67D8202101;
	Wed, 26 Aug 2026 14:48:55 +0200 (CEST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1wzD3n-003RRH-2J;
	Wed, 26 Aug 2026 14:48:55 +0200
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Wed, 26 Aug 2026 14:48:39 +0200
Subject: [PATCH v2 1/3] dt-bindings: net: dp83867: make exclusivity
 explicit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260826-v7-2-topic-dp83867-v2-1-a97b4cec6e93@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1475;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=mUrPlJT0hJRrTfA5qoFrn9r4BgqyF0M1XSh9PhhKE4g=;
 b=owGbwMvMwCUmtVehiCsuTInxtFoSQ1bfg20TTXRZou8mcm43YI17X292J+6LiTJjo2umm1/sa
 bHJpbM7SlkYxLgYZMUUWVQWVvCJenzwjJwmwgUzh5UJZAgDF6cATOTTNUaGleuaPFhS+fkYXbx4
 v9/bW6EfyJu6TNxtilWT4B+XwgYehv/Z0TNuxLV2ZSyY3LIyUyG3ubHOKZub49SjPYuOhmlGT2Y
 CAA==
X-Developer-Key: i=s.trumtrar@pengutronix.de; a=openpgp;
 fpr=24A1780E1548F0495996140A1ABD20720A5E5622

The properties nvmem-cells and ti,{min,max}-output-impedance are
mutually exclusive as already noted in the ti,max-output-impedance
description.

As this is only stated in the description and not made explicit in the
schema, the binding checker will not catch if this condition is ignored.

Make it explicit in the schema, that nmvem-cells can not be used with
ti,min-output-impedance or ti,max-output-impedance.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 Documentation/devicetree/bindings/net/ti,dp83867.yaml | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/ti,dp83867.yaml b/Documentation/devicetree/bindings/net/ti,dp83867.yaml
index 4bc1f98fd9fe5..7a6fe516bab27 100644
--- a/Documentation/devicetree/bindings/net/ti,dp83867.yaml
+++ b/Documentation/devicetree/bindings/net/ti,dp83867.yaml
@@ -7,9 +7,6 @@ $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: TI DP83867 ethernet PHY
 
-allOf:
-  - $ref: ethernet-controller.yaml#
-
 maintainers:
   - Andrew Davis <afd@ti.com>
 
@@ -118,6 +115,13 @@ properties:
       Transmitt FIFO depth- see dt-bindings/net/ti-dp83867.h for applicable
       values.
 
+allOf:
+  - $ref: ethernet-controller.yaml#
+  - not:
+      required: [nvmem-cells, "ti,min-output-impedance"]
+  - not:
+      required: [nvmem-cells, "ti,max-output-impedance"]
+
 required:
   - reg
 

-- 
2.54.0

