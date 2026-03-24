Received: from www537.your-server.de (www537.your-server.de [188.40.3.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D2B3F880D;
	Tue, 24 Mar 2026 12:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.3.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774355429; cv=none; b=ulbqQ/9yxaYpnqC6v8nR1GhzhoslwfoAexLrLb5xKbiO815azKDfyo58hLZEnnkYqSiYbEHmv3QGir3cuRkBooY/BHgDJSOqYYOedl6wvQkyrMJJ5/Cek0U5KngPfgkrzRDlaV09415t57ZS20viR6F8HIClLy6rCjbXSzpNRuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774355429; c=relaxed/simple;
	bh=dJcUnfB7AGIUVDj3Wh0tzv/g9vBOcI7tjYvVVa+b9k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KeDzjcfzO9zXePkosJy2Rzk2Vz8R75/RLLl2DLQL+xT3PpqKyyEQVzXwm6RrN27HY5pkv46ATrDUrog/2Y/xAgONLqRPIPSo3+Euj6hjwceD94LgS2ElQ5COwyHb6py6/9E2IT9hrFrd1cKCrbd1a+zWbHQiO+KAJnM5+y41T34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=V9/vtmSy; arc=none smtp.client-ip=188.40.3.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="V9/vtmSy"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=ew.tq-group.com; s=default2602; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=HXjqylECdGDFHUiyugySRrfNFcwy5NMDZ6un9XJQF4g=; b=V9/vtmSyHhRM1BItbFutZ0uo/g
	movhuFkhMQRVN8yfy+ARUH5Zn8PpxxiU96vfqN/kf97X7iqB9ojOU9KiTN1ND0Vxy+1WMruilISqG
	gIzf2Iyybs4XPLABbmdRfx9al+sSxJdDrlTl6uZJfnTW1vPIt1pIyTQyzv9PTRiaDB6YD9eOBjEWV
	E66oCKPhMsOL2L2sd6mfTDWS1ryVhnbxDpyloRGWMVNeg41Gp+Mb/dEm953MxqdtHYBrrjbd8Hl5c
	g1SlaJel8yERvu1FVZl+MKwdTjzJ2qrKV6oFu09QYUs908htDG18zYiEFyMt6sIjM5LUEKC365b4d
	TwyRIV9g==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
	by www537.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1w50tq-0005qE-0a;
	Tue, 24 Mar 2026 13:30:22 +0100
Received: from localhost ([127.0.0.1])
	by sslproxy05.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <nora.schiffer@ew.tq-group.com>)
	id 1w50tq-000Pna-01;
	Tue, 24 Mar 2026 13:30:21 +0100
From: Nora Schiffer <nora.schiffer@ew.tq-group.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Nishanth Menon <nm@ti.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Tero Kristo <kristo@kernel.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux@ew.tq-group.com,
	Nora Schiffer <nora.schiffer@ew.tq-group.com>
Subject: [PATCH v2 1/7] dt-bindings: phy: ti: phy-j721e-wiz: Add ti,j722s-wiz-10g compatible
Date: Tue, 24 Mar 2026 13:29:37 +0100
Message-ID: <55a56bdcbed0e49680e3074d0f1c06f244287f9f.1774354734.git.nora.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1774354734.git.nora.schiffer@ew.tq-group.com>
References: <cover.1774354734.git.nora.schiffer@ew.tq-group.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/27950/Tue Mar 24 07:24:19 2026)

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

