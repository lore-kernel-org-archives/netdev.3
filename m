Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED32B3AAF56
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 22:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789771801; cv=none; b=sRh5MTIA8GJyBWd/z9JjbMsMbWFhJhpZP6oe2WvFAWDj7eWto+8Vcw8jeoOcQR7xzbcJ52ysVkcBU9ROtY74nVKxh3tRzjXqK4GoYnSa3xd/v4rW2SKLk05y6BXVOfO/WcwFopa3dlYNMWMf/jFO3LHodN+Mdg3ayiXev9DKdQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789771801; c=relaxed/simple;
	bh=MpmbxsJNCSa1bIW1177VWcB2miYZXDd5MGg73DXlvaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cjtu4u1+16ZXPOqNgXOgu82XtorkvKLbHFXKLlVhjjFXhwaa6rVihVt22JkMq5F2bblfsFzkFLlbv+tpDVTfJFoxXt8B33Og8nwrvFbak0EEm9RTnJtzAHZGW0OC9rYVIwnpwESuRH/ftjQeTiVvxL7uijt6QG66/N+bifMZAXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alessandro.zini@siemens.com header.b=oVjZ8f8R; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alessandro.zini@siemens.com header.b="oVjZ8f8R"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202609182249468f094f6c4f00020713
        for <netdev@vger.kernel.org>;
        Sat, 19 Sep 2026 00:49:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alessandro.zini@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=l4+hujWBTBXmrVqayMZv7Ce0HKF10xEPe2n2/6OG2w0=;
 b=oVjZ8f8R+uJITkU/PLJHtN9pN0wJyNuaxVfXGSkaHWNA7IigMdAQIHcu9z8KsupXgt7gtl
 4eFDpEov990cwwGqjfjcUiTL0P3ZlEYmZTCUFPi0h+zT3NONuet8GIm48a1RRFLO2UP4ugA+
 2NYMWudxgMNgZ52hh+t4oad6mw0jQxpdX1O89N59mLR6mNxYbp5Xx6gF3YruCmaZScJOB1U4
 G3TxaOXfcBvObHVs4aesB0Nlfo547pf78RM9rZjdw2sdi0HRJO1pMSER1iXxOnvS0KzY+jVG
 9FecJEmgTUd5zxAfgTnR3Nu5DfdkyVc3G44eSYPIOKA/8JWW6SpTh5jA==;
From: Alessandro Zini <alessandro.zini@siemens.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Ciprian Regus <ciprian.regus@analog.com>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alessandro Zini <alessandro.zini@siemens.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH net-next v3 1/4] dt-bindings: net: microchip,lan8650: add reset-gpios property
Date: Sat, 19 Sep 2026 00:49:31 +0200
Message-ID: <20260918224934.51998-2-alessandro.zini@siemens.com>
In-Reply-To: <20260918224934.51998-1-alessandro.zini@siemens.com>
References: <20260918224934.51998-1-alessandro.zini@siemens.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1327013:519-21489:flowmailer

Add optional reset-gpios property to describe the connection to the
hardware RESET_N pin of the LAN8650/1 MAC-PHY.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Alessandro Zini <alessandro.zini@siemens.com>
---
Changes in v3:
- Picked up Acked-by tag.

Changes in v2:
- None
 Documentation/devicetree/bindings/net/microchip,lan8650.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/microchip,lan8650.yaml b/Documentation/devicetree/bindings/net/microchip,lan8650.yaml
index 766ff58147ae3..1b543ce307632 100644
--- a/Documentation/devicetree/bindings/net/microchip,lan8650.yaml
+++ b/Documentation/devicetree/bindings/net/microchip,lan8650.yaml
@@ -40,6 +40,11 @@ properties:
       Event.
     maxItems: 1
 
+  reset-gpios:
+    description:
+      GPIO connected to the active-low RESET_N pin of the MAC-PHY.
+    maxItems: 1
+
   spi-max-frequency:
     minimum: 15000000
     maximum: 25000000
-- 
2.55.0

