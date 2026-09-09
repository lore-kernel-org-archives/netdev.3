Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688CC5592FD
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 12:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788958470; cv=none; b=pU8ph9at7KrAv4E0CCpjmFSpNvUbmlGM35Y8oiDZoKl689vP0EdsDbe4FDJTI4j68CoXEA+GmGk25hV/+aP+1TbDogyedNkwGnDrkvRkIJU8r+8Pm4r3QzAovqVtqqIqLdbgiscpS4g5w54OakqpaTwcd+/R1YoBlF9Sl+xaQIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788958470; c=relaxed/simple;
	bh=maP6p9XlFsf5L+vQv425mi2fMpKe7K7btTFfPcwcVBA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fJe53E8ts+zL//wjGyNEvMmB7qOhSdXXtxK81Tbv1cfN7ZasLp+xjuQi0If/NY4FguNvR2aWKZofhR5F6I2Q0NVy1bFFTQmuonMPRZUmfVkg8uNDCcqG0EeraKN3CoE4N/Lr5rtm3rO1vt31kgBG/Xmec7dYCANCBQzjz+ewRec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alessandro.zini@siemens.com header.b=qv7j+Ohn; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alessandro.zini@siemens.com header.b="qv7j+Ohn"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260909125415234e960a28000207d7
        for <netdev@vger.kernel.org>;
        Wed, 09 Sep 2026 14:54:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alessandro.zini@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=LciXuYSqhTVCiOY+WMRThV65Q+FKd8QICsZRn1HZ84Q=;
 b=qv7j+OhnDTqlWRw/rKISl3MIJc/5L5oxIZjizGxIx3FEkxxTTDUYrAm29mKroIG5BCAIq4
 KRC/9ByD2/HQf9ij1HpCrReZMj+2/Uh69jJ9OlAyc9Zlka45dMPPT/XvCWlV3RtI5caQTyn6
 Z56oywtYqxsHz9kk27dMYGMMspdu67zvfaHyugPlGApnRcu5kJyn1EsArgNZgC7oLRXPeB5x
 TEgWCwxHRLrph+kOA9VHMFLNgzKvZgBKcz2wYmFNLcSr3YjfliZFkJLZBscAZmtWxllwbdyO
 0sSC1uRTDjJdBk1DMA7fIIWFyoVMABzTd0tjrbioLs5FyngJOTnXyuHA==;
From: Alessandro Zini <alessandro.zini@siemens.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alessandro Zini <alessandro.zini@siemens.com>
Subject: [PATCH net-next 1/2] dt-bindings: net: microchip,lan8650: add reset-gpios property
Date: Wed,  9 Sep 2026 14:53:57 +0200
Message-ID: <20260909125358.23003-1-alessandro.zini@siemens.com>
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

Signed-off-by: Alessandro Zini <alessandro.zini@siemens.com>
---
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

