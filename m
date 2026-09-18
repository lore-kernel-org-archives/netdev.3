Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1452D3A5E67
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 23:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789773311; cv=none; b=t3L38l3WT2esVOYozfuDp2EE0+Bbvhn/Gh1EkBuyGqDkSmqVSjeN6QP515athoVQHLf7MsLtxO8vGEEBQ244OJ2yO5I5UDRcqRHHgo1+qWWJHQIIxyadTTD9+YwH4k6bL8RxxdB5NEhTn7XqdRRXaXPttJum03M6E4UJLrQJiBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789773311; c=relaxed/simple;
	bh=hLBY2zf+6VnoPbXCPRBhdJf/OiwfbzirHGuOKsXxhCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B27hhFiKhNFHPxZVaNsSvyJfYP++52WPxAB6rvouEl9c8kSNZjoHUHo4ugi23sm2bNeDT8InpPIDBCW6KwBJC7bsZE0ednE0Rkit3mMR459vD3L+NtfRI6o2pYGD9phEinHmDmonGM7fF27sY6FZhF4GkfsfTHLq5FllhmFJhFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alessandro.zini@siemens.com header.b=fgTXPqyp; arc=none smtp.client-ip=185.136.65.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alessandro.zini@siemens.com header.b="fgTXPqyp"
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 2026091823150352d6b2b4240002079b
        for <netdev@vger.kernel.org>;
        Sat, 19 Sep 2026 01:15:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alessandro.zini@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=nmkoZlnx/BL3ojyVxAH/rD6DTukxyiQe4iQkVt0G2O8=;
 b=fgTXPqyp4GMRJIerp/t/6Wt9WpXBNOOhBHh3rvTGxzTzh02kIcVtaJU8JqRE3oT5LxmoHc
 h43YvkIKUX88RpEYpFRgtyKW/VRQTnb3vo6MEwkvwSCUCtUEhvyaoYH+Qn5dy9/tVTJLqt+N
 AHzz+0gYhoaK8JGBJevr052h9pcYCQSdFBOv7o7h4XfFL+HSj3uW5pghs28aWYT4E91HdIu0
 iYbC29QQi1bZj0H8Ew9BBeM8FTZSd7jsNjv7NCA4NBSyqapKpMUX7KH7OGjpgDR7QxVco6sj
 /QbvQ83K0qSzhUFgF5/ae7IrL9e7h9qdNAquSzEuLHFiId1q3f3ol8Sw==;
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
Subject: [PATCH net-next v4 1/3] dt-bindings: net: microchip,lan8650: add reset-gpios property
Date: Sat, 19 Sep 2026 01:14:48 +0200
Message-ID: <20260918231450.55966-2-alessandro.zini@siemens.com>
In-Reply-To: <20260918231450.55966-1-alessandro.zini@siemens.com>
References: <20260918231450.55966-1-alessandro.zini@siemens.com>
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
Changes in v4:
- None

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

