Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9427410D08;
	Wed,  1 Apr 2026 12:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.3.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775046374; cv=none; b=OGG4uVn2fW5mu2cQXV5kk6pNQIDgdFFcPKMDvcK+xM/TSIYA2svqdBBrhLh+rravzCUU1qGs7KUzx2IizcZWQPnYtIV9l+eXDGr6gXevex3sh6O3ibvoXXo45QaJ8DuYK372GTIDJjX2bpR13hmk+sChquW8KhMe3e4TIbgPuM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775046374; c=relaxed/simple;
	bh=dJcUnfB7AGIUVDj3Wh0tzv/g9vBOcI7tjYvVVa+b9k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TyJ/4qn2aWwPLbzsVCr3NZ9885Q6M/6PLHV19ijHUsvUJU7oOdeDEvFY7s1lNdksnpsgE+NLiWW3Fm8YG0qZHpjQHBvCYTAeuPBnfUz1GkHGCVO7GNKwknEvs4v9L386c2m42pXL6SuV2yDVusc6UJHbYJwi+byFQS1WVP+7qyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=h6kxBhb+; arc=none smtp.client-ip=188.40.3.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="h6kxBhb+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=HXjqylECdGDFHUiyugySRrfNFcwy5NMDZ6un9XJQF4g=; b=h6kxBhb+t/yRyIf9XD0uFBqw0E
	BMmiQpL+SoEgqb6viTrEzrmea6LtF6+wsrfHplUl7my4eWHobKNK/jIrR5M9AxagZASYJwANlnLv0
	5mfuW0Mi12TdkaOJCUg+AUDOS1TWMfknTHj4gcyrCaJKh1YLwvkOyXiIslNUAfSsdYMJjutSDnU5U
	HCjEZGVo13Cj2B2WE7fE/OqfKamb35EsmZYMxkxtSxzJmUTwxkM8NHF02Tw4ufEOvomKvoygjGx32
	n6mjeW6yb9SMb0cWwwAABOvC8hjJzsQbNdrDLbHfJ/Jn5H0bI1O18+58NAu3WdKeOL5gHbvUnLn0H
	XVVG1Lgg==;
Received: from sslproxy07.your-server.de ([78.47.199.104])
	by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1w7ue3-000IQX-0A;
	Wed, 01 Apr 2026 14:26:03 +0200
Received: from localhost ([127.0.0.1])
	by sslproxy07.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1w7ue2-00089b-1p;
	Wed, 01 Apr 2026 14:26:02 +0200
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com,
	Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH v3 1/5] dt-bindings: phy: ti: phy-j721e-wiz: Add ti,j722s-wiz-10g compatible
Date: Wed,  1 Apr 2026 14:25:21 +0200
Message-ID: <b9d6a9322ce4f7dc3363dc00d93ab0256e12a8af.1775045279.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1775045279.git.nora.schiffer@ew.tq-group.com>
References: <cover.1775045279.git.nora.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27958/Wed Apr  1 08:24:34 2026)

The J722S WIZ is mostly identical to the AM64's, but additionally supports
SGMII. The AM64 compatible ti,am64-wiz-10g is used as a fallback.

Signed-off-by: Nora Schiffer <nora.schiffer@ew.tq-group.com>
---
 .../bindings/phy/ti,phy-j721e-wiz.yaml        | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
index 3f16ff14484d2..283e3eedc0f31 100644
--- a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
@@ -12,13 +12,19 @@ maintainers:
 
 properties:
   compatible:
-    enum:
-      - ti,j721e-wiz-16g
-      - ti,j721e-wiz-10g
-      - ti,j721s2-wiz-10g
-      - ti,am64-wiz-10g
-      - ti,j7200-wiz-10g
-      - ti,j784s4-wiz-10g
+    oneOf:
+      - items:
+          - enum:
+              - ti,j721e-wiz-16g
+              - ti,j721e-wiz-10g
+              - ti,j721s2-wiz-10g
+              - ti,am64-wiz-10g
+              - ti,j7200-wiz-10g
+              - ti,j784s4-wiz-10g
+      - items:
+          - enum:
+              - ti,j722s-wiz-10g
+          - const: ti,am64-wiz-10g
 
   power-domains:
     maxItems: 1
-- 
TQ-Systems GmbH | Mühlstraße 2, Gut Delling | 82229 Seefeld, Germany
Amtsgericht München, HRB 105018
Geschäftsführer: Detlef Schneider, Rüdiger Stahl, Stefan Schneider
https://www.tq-group.com/

