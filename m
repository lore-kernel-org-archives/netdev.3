Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02804534B7
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 07:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789545250; cv=none; b=Cw8hZxYIAWB6/gfHOncsNWFuLqiOTTtj6PGICsyTQ7SXHK5vlb7Bd+PFnTX94vWoQdRpuhE85yVUTal/cNmGtuDo3UZ3Wa9Z67reikg9pjbARK8Pp/iHXufw4cQkQPWySc0TFfzNqlHdLJs6qOqHxJdDgqFiRPHPtrfdvA8Bckc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789545250; c=relaxed/simple;
	bh=8Iu+w3POx8l5bGsxQms0pLsAYLUP3fgfI0MMwvUOfpo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dAOPBVp4MD5d/gqezZKRZODHgW853r55r9AbShGSyoUAOdCQUYeBkp57xZEJP4FAVZujlT+hfJAZYglrgad1B1YKoAWrDtjCcFPsOGNbQ6D5yNjnaJjGzbZUQvrE+DyEggi56kvBhBQr2rvKqjo4dl+qnzCXJzw7XMaHYWiY/uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=alessandro.zini@siemens.com header.b=dRYp35G0; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=alessandro.zini@siemens.com header.b="dRYp35G0"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 202609160753562740849b6500020708
        for <netdev@vger.kernel.org>;
        Wed, 16 Sep 2026 09:53:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=alessandro.zini@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=hNdmg/dAJUdb85UsOmrUM+7cNKUbJu5e9UIojnsJsnM=;
 b=dRYp35G09I5SCxuGirWeteIQyaUlz5P6vvcDeyu1nEKGSwflIqMg0ARMmjAewIhK9rMIYU
 IwzGPjsey+fELzg219htyIoe80OQdvt3JmBcJdWvejTiwQ2imOq+fxvPjb9Q4r3s1z0Bb6FG
 EzFi6n70sUDUlvjq+CV7YI6Yyodg+C7PIHLAYVN6BVmqEn4J4t4Ol0LBlEBvGchNWZasYmZ6
 tH69sd0kt+E5bWtOhUCuH90j/Qe+CavM3Heezn5I48Hwb+/pOVrmbU710ugI6d4dfWIplnke
 oDjRComAjK7vjSdyZUadKw34fR+syXMwK5wxUYM7k2FlEOhyLakDvN3g==;
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
Subject: [PATCH net-next v2 1/2] dt-bindings: net: microchip,lan8650: add reset-gpios property
Date: Wed, 16 Sep 2026 09:53:48 +0200
Message-ID: <20260916075349.21822-2-alessandro.zini@siemens.com>
In-Reply-To: <20260916075349.21822-1-alessandro.zini@siemens.com>
References: <20260916075349.21822-1-alessandro.zini@siemens.com>
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

