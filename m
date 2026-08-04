Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64813DA5BA;
	Tue,  4 Aug 2026 12:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785847617; cv=none; b=QQkxvF7hhvZKdSE0flNrLjraCAckMVdEwNb3VyLX1vdiaiT1LeASjqE74SW5wSx0vFpjhGJ/LaaOUyQ+b8qak+SpdWAy/f0S3b59dlbYl1bLZT198xzWHtimFKhpXwuG83ppm2Dthk/PZKjZewASQ9zDZ7n0rz6FjJnSTEe9u3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785847617; c=relaxed/simple;
	bh=Yka8y4MuABKUUA4nM4OJm/mqnlrKhA4Bjd70mO4jVXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rLrlOvUpsSqsO5GXS458U6Rvvk3RdEtS+OvVhE1xYwJOg8zzO1iOirT/k3dyIBBG7or2nHXsriOpN7gXKc5LSi8FcVJ4Ix68sxWF9bTr1ghTxm8VrCtj3LiJLOR1ETdcUhMQOLbMwSf7X78C8p0SjMFLQrHDrU2c3sVd4FAnxak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 1A8992004B6;
	Tue, 04 Aug 2026 14:46:46 +0200 (CEST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=ratatoskr.trumtrar.info)
	by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.96)
	(envelope-from <s.trumtrar@pengutronix.de>)
	id 1wrEXe-002s0o-00;
	Tue, 04 Aug 2026 14:46:46 +0200
From: Steffen Trumtrar <s.trumtrar@pengutronix.de>
Date: Tue, 04 Aug 2026 14:46:33 +0200
Subject: [PATCH 1/2] dt-bindings: dp83867: add binding for output-impedance
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-v7-2-topic-dp83867-v1-1-1ca79eb54eef@pengutronix.de>
References: <20260804-v7-2-topic-dp83867-v1-0-1ca79eb54eef@pengutronix.de>
In-Reply-To: <20260804-v7-2-topic-dp83867-v1-0-1ca79eb54eef@pengutronix.de>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2112;
 i=s.trumtrar@pengutronix.de; h=from:subject:message-id;
 bh=Yka8y4MuABKUUA4nM4OJm/mqnlrKhA4Bjd70mO4jVXU=;
 b=owGbwMvMwCUmtVehiCsuTInxtFoSQ1bhfZOZ7/9ea1dZKlX/4H3yjeVLrXTXxCu8zY73VNz0e
 zmLQJhyRykLgxgXg6yYIovKwgo+UY8PnpHTRLhg5rAygQxh4OIUgInkyTL89+SNWuQ9iVPqYTHf
 ofrJdQFHUzx2qDYeOFzOXxnZYdTVzsjwMexRi+sGLrec3L37edQSJsgps31ddk+j8Myn2vir+2r
 4AA==
X-Developer-Key: i=s.trumtrar@pengutronix.de; a=openpgp;
 fpr=24A1780E1548F0495996140A1ABD20720A5E5622

Currently, the output-impedance can only be set to default, minimum or
maximum or via a nvmem cell.
In cases where there is no backend for a nvmem cell, a value can not be
set.

Add a DT binding for specifying the output-impedance via a fixed value.
The existing boolean values for minimum and maximum still take
precendance over the new value.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 Documentation/devicetree/bindings/net/ti,dp83867.yaml | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/ti,dp83867.yaml b/Documentation/devicetree/bindings/net/ti,dp83867.yaml
index 4bc1f98fd9fe5..f43b4e44ef7ab 100644
--- a/Documentation/devicetree/bindings/net/ti,dp83867.yaml
+++ b/Documentation/devicetree/bindings/net/ti,dp83867.yaml
@@ -41,6 +41,12 @@ properties:
     items:
       - const: io_impedance_ctrl
 
+  ti,output-impedance:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      MAC Interface Impedance control to set the programmable output impedance
+      to a value between minimum (35 ohms) and maximum (70 ohms).
+
   ti,min-output-impedance:
     type: boolean
     description: |
@@ -53,10 +59,11 @@ properties:
       MAC Interface Impedance control to set the programmable output impedance
       to a maximum value (70 ohms).
       Note: Specifying an io_impedance_ctrl nvmem cell or one of the
-        ti,min-output-impedance, ti,max-output-impedance properties
-        are mutually exclusive. If more than one is present, an nvmem
+        ti,min-output-impedance, ti,max-output-impedance or ti,output-impedance
+        properties are mutually exclusive. If more than one is present, an nvmem
         cell takes precedence over ti,max-output-impedance, which in
-        turn takes precedence over ti,min-output-impedance.
+        turn takes precedence over ti,min-output-impedance. Both take precedence
+        over ti,output-impedance.
 
   tx-fifo-depth:
     $ref: /schemas/types.yaml#/definitions/uint32

-- 
2.54.0

