Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=5.135.140.105
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793299346;
	b=D5EVwwEvrH18EBfJdZr0ZEazc6t5terQkG2h24FCv+eHGceWmz9tKsSuyqbAVdHr/NiF
	 8j+7VP/zOy3BBF/yviSrxxNtvw6jWsHG1vUF93Qf/VTZCEdP8WfcKCgCUSKEiBqA6gycc
	 2rLFTS5Y9emEcGinplELGQGO446IYpJ2uHabKd7ehefOTgGDz3YEzOPBJp4WSwnEVPchk
	 fmG1wKzuMa4O6ohnafVy0h/V2gsva3SS/bEVFblUitAcJvKyDB+RVKPXaCIQL6q3oK+WL
	 xHhyoQlVfBb8DYK37rCi4hQ+5aYATlODVP/5PrjkrXZy8slq7GuPo2eBHwEf1rWUrUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793299346;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-Id:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Last-TLS-Session-Version;
	bh=VY1Y9Wrs674y7GrLGEyeMMqNpydE7jf2tJurMnaK9fI=;
	b=VaU9WQp+XE05Ug+aOnoPnzG0Gp8Vpvpdi/TF+IcVDCIFE1TslqF4VL0B6VJu0NVGqOQQ
	 G0EnwfoXaqOPSYP5e/34iLPPpGh0rQ5ZlHVzyd3Ax2L6bfM6618IYlDZX/zKDZ8Ra24d+
	 Uwck2y5mqpOYYdREQGzvoHvrEBx/Uh1lyGFb34lA7d8S+tkQNSoacRcKFO6zyIxH7E8yk
	 Sb8RzDbetQQnn2vgxn5FEI6sWCHt2V8utONznGwfwmMn0BLXkrRcMII3LYO3l5M+KkRWh
	 9GhwPNB2seWPBl0tPGH7T6u/xZl4Q4qx816zfA6+SVkDPgVeh7IsVqgbnAUXLgEMwEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cjdns.fr;
	spf=pass smtp.mailfrom=cjdns.fr;
	dkim=pass header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=NELsSHRp;
	arc=none smtp.remote-ip=5.135.140.105
Received: from mail.cjdns.fr (mail.cjdns.fr [5.135.140.105])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 185B7606A31F;
	Thu, 29 Oct 2026 18:42:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 185B7606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cjdns.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cjdns.fr header.i=@cjdns.fr header.a=rsa-sha256 header.s=dkim header.b=NELsSHRp
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D73911AA31C;
	Thu, 29 Oct 2026 19:42:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjdns.fr; s=dkim;
	t=1793299343; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=VY1Y9Wrs674y7GrLGEyeMMqNpydE7jf2tJurMnaK9fI=;
	b=NELsSHRpm5LMd7qDM9rSeMlKqQW3jloxpskiGZPcQDDu5LUaXRnYaRO8nRknwkxWRK6GhL
	ssJngc4y5g81ySxtxmdRMic2waS/UCNYnHWv/sacCFj7yCK2YJjvz5ndtxd7YWwXvYVObr
	3EjnNGt17JMV7owm/JsHVaav/Xk5KF3KsBGGyCGDXX0IV+Hp5+NfJlYh7x4dRgplm28qDX
	QGKoqGR1yHNa0hJqqdkpS4VsnkYTSlKk5qZbCkqyKZm+Fow3voVxlBRf+jkwLuPRTNeHan
	pdHq7H+d0Mqd0nJqbFdLzKkzVGoSJpW97XWRGNIxs8GLR0Zci6cYiKZ2kl4ydg==
From: Caleb James DeLisle <cjd@cjdns.fr>
To: netdev@vger.kernel.org
Cc: andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	chester.a.unal@arinc9.com,
	daniel@makrotopia.org,
	linux@armlinux.org.uk,
	arinc.unal@arinc9.com,
	Landen.Chao@mediatek.com,
	dqfext@gmail.com,
	sean.wang@mediatek.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	naseefkm@gmail.com,
	b.larsson@gmx.com,
	Caleb James DeLisle <cjd@cjdns.fr>
Subject: [PATCH v4 2/7] dt-bindings: net: dsa: mediatek,mt7530: describe 'passthrough' hierarchy
Date: Thu, 29 Oct 2026 18:41:57 +0000
Message-Id: <20261029184202.1859843-3-cjd@cjdns.fr>
In-Reply-To: <20261029184202.1859843-1-cjd@cjdns.fr>
References: <20261029184202.1859843-1-cjd@cjdns.fr>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Due to hardware limitations, full switch hierarchies are not supported
with DSA based on the mt7530 DSA tag, however it does support a simplified
hierarchy in which one or more switches act as passthrough conduits with
only one CPU port and one DSA port active. Document this capability.

Signed-off-by: Caleb James DeLisle <cjd@cjdns.fr>
---
 .../devicetree/bindings/net/dsa/mediatek,mt7530.yaml         | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
index 90b3582b7619..f98b9113ad12 100644
--- a/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/mediatek,mt7530.yaml
@@ -73,6 +73,11 @@ description: |
 
       Check out example 7.
 
+  The MT7530 and MT7531 switches offer limited support for switch hierarchies,
+  particularly in the case where one or more switches have only one upstream
+  and one downstream port, and can act as blind pass-throughs to a fully
+  featured switch downstream.
+
 properties:
   compatible:
     oneOf:
-- 
2.39.5

