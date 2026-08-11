Received: from mslow3.mail.gandi.net (mslow3.mail.gandi.net [217.70.178.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1B2407590;
	Tue, 11 Aug 2026 12:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.178.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786453005; cv=none; b=XuWf/mO0UFoG8leTPOB4c8z5nlhKTk1tNmrq4RlwEYkmb9+OmJE0ICXIpaht2oZETMy/Au+zVnSXA4TzZt/ykTt/2ST8RDvTuhZhMMfM2XZCbztLAuDYY9cG7yz1TuWGVJoTGYH9ZA4b+uw+h7VZ5y8ac+30k7s3IeooBjlN9ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786453005; c=relaxed/simple;
	bh=pFpkkhczKFM4RbQq1PzMqjXSn5B9HPe6D4CnOAI4CDM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mZKNMYoSI0hX+LEaSZ13EzZtxU9ksPuKDoaJlrgYFdmDGdM52hSgt1lKfjM82fzMAQ1TDStRiZDYENIsORm7pZqwvtMUkAy5wg7g11KFsRZwXlDyxpi99CLHMpdKs0cNbVnTMberbnw3Sq+n8DJVvq8Ur25YZ210SWCqGau+I1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=bT2RHKJG; arc=none smtp.client-ip=217.70.178.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="bT2RHKJG"
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	by mslow3.mail.gandi.net (Postfix) with ESMTP id AA3465822ED;
	Tue, 11 Aug 2026 12:34:54 +0000 (UTC)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 428D83EC6A;
	Tue, 11 Aug 2026 12:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1786451686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4aJRNaiDdOQIaFv139+AH1OKZ3dYZhv5UsL8B74h/l0=;
	b=bT2RHKJGTry4ANt7+KsoLtWqvSBbvOzwjIdnvx2ZPHVXBstIv1I+4gkl0liaCCKBe9iJTk
	8WLyaC1uiFcNEWv+Dr55xmfLGMUKkD7qJ7p3l92DpNzJo74FeHP15bBBfjLIILGCe0Tvqt
	nlqLN4b26txoYGuNWPofaHCto7OIhWzls1leeZIAVGxQeuZubkDcC+NT88sWru/xVOx8p+
	H/2JtGMpmg15gQx6kqb33VnR+fHQ4BTzT6g3CkqNeWKWrckhTJ1AftV6Fy/2wIY94Ya/qo
	hJac67oE7BT76KNgVklpT+FMPIY7lh8vXmDrW95OykUe91wrdAX6sM/NiawRpw==
From: =?utf-8?q?Arthur_Cr=C3=A9pin_Leblond?= <arthur@marmottus.net>
Date: Tue, 11 Aug 2026 14:34:34 +0200
Subject: [PATCH net-next v4 2/3] dt-bindings: net: wiznet,w5100: add link
 status interrupt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260811-wiznet-link-gpio-v4-2-4d5f7da885a8@marmottus.net>
References: <20260811-wiznet-link-gpio-v4-0-4d5f7da885a8@marmottus.net>
In-Reply-To: <20260811-wiznet-link-gpio-v4-0-4d5f7da885a8@marmottus.net>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Arthur_Cr=C3=A9pin_Leblond?= <arthur@marmottus.net>
X-Mailer: b4 0.15.2
X-GND-Sasl: arthur@marmottus.net
X-GND-Cause: dmFkZTED/3HJKTgwxBO9D7jQ7O9WW6mZqKFTS5z9+t/FK1af0VH31e8paPNStgsQpQIYlcYucwL4cCmdHRXR1YYxqw1T8z7REX/fEaawr/SFTAReVmgPSkMSXhelgxXwGWSawVSbcpIQz1ApGSMt7N/EmbPGNzbGZYTYvDxpMYQGP1JlU5jgLN/HEWfQYe9TkhK3By7wmxsf+0M+P/IMA7PoVnge/FKBaYY9CaxM9zl0WOY5mQGtYkeKnvmiXrurdSxxCfaFLe1gD6LLRDm8B+uNjWpnFlfgPuimqtreC5Kqai1m6/hFQg5QKCoi3xpXvCY9c8GMn3Fz6R/dnpQZY+phR/sNRD8UvHDgn4kn61ff2ARw2ehZrhVFiGRgNTXDTEG8K6cQzzp3U+Hve1yc4YgM7SyuiyEiRKfFeUabMDK+Q7MP3y7RPWv2+ifoNdZnek6/Oj7NTPEj+ooEiOFcTwKER6bZjgQUg0bgjOBiodsqt6DL0PhCDqpm8IOa7iCvP34mykZZjdnMeztqbcbZ9vWKaHl/vzsHvMQJ9JQwNriZyl7+424cLB+BHUbCmeF97yALSaNF8hy6m58iJz+ik+zXqMDilFrCKwwtIn2PHHAKKKhyzxdkDO8xq+4WBDX3ENm//5+lL39o8zh+c075LAeWkvs050e6x820q1SpHvAPCzqlZw
X-GND-State: clean
X-GND-Score: -100

Add an optional link status interrupt which can be connected to the
LINKLED pin on the device to detect link status changes.

Signed-off-by: Arthur Crépin Leblond <arthur@marmottus.net>
---
 Documentation/devicetree/bindings/net/wiznet,w5100.yaml | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
index 641c9ddbde9e..30f013f40a77 100644
--- a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
+++ b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
@@ -24,7 +24,11 @@ properties:
       - wiznet,w5500
 
   interrupts:
-    maxItems: 1
+    maxItems: 2
+    items:
+      - description: Main interrupt (INT pin on the device).
+      - description:
+          Optional interrupt for link status changes (LINKLED pin on w5500).
 
   reg:
     maxItems: 1
@@ -59,7 +63,8 @@ examples:
             pinctrl-names = "default";
             pinctrl-0 = <&eth1_pins>;
             interrupt-parent = <&gpio>;
-            interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+            interrupts = <25 IRQ_TYPE_EDGE_FALLING>,
+                         <24 IRQ_TYPE_EDGE_BOTH>;
             spi-max-frequency = <30000000>;
             local-mac-address = [ a0 b0 c0 d0 e0 f0 ];
         };

-- 
2.55.0

