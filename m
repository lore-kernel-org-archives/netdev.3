Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FEC47ACFD;
	Thu,  6 Aug 2026 15:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786028437; cv=none; b=nZ7/045hwKYTzSHWVmbNob0JG5T0RAOmmu4VfNXrrEXwhfUj9GXPEdZ7HDDyfGKu02j2T2lMn5qs+JaYTAZGY3iS1A78eyxylYhMx9W0eTFFR0HYZLjHtzROSfXEOo/O3GswSS3bKLeZ5obDU2MCrHbXQrTmS5DK4gQpI+fVmG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786028437; c=relaxed/simple;
	bh=uBBYMoJ4BxsVlp5cY1rbRF0sQIE12on96iPK64kgI78=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FCmQ/VjsC1soqmNJ4k8ZXvSep+fkaiNmnCHJlroIqOPtXcroB2P3xsg2F4sfeC4+3bRdQ1Djz/2nlb1mHL8/P8+cAUeQwruECRL0NF8XRptP/+L4QDJsGt/gH1pRBKPkkvbSoY04DeDUgj6DRHnyke792j2UdxP//k2Rg+SEIUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=Laso9TJn; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="Laso9TJn"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0A9A53ECF7;
	Thu,  6 Aug 2026 15:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1786028421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ndgS6gnOTOGCHQ4/bgAHvlK16ze3UjOG4fDbcLDpDNc=;
	b=Laso9TJnBZEN+5uRemAac9bCAh4OB9VK3bxp7e8eGn3leA+ODMorUwcictsHgRlfApNxTa
	feXbskhqr7IRPcsx552Ppp81v4DQq4kUKYu8GGi5VSge1pc3Hzwh+eWZe44eCMetoeRS+l
	4zqUxCbe/mq2TMuJOT5CfyGfbEmu/g9kJmpHbirLtPBMQZD0sDTk6x5EF22O3NVNVSbpHG
	NPyHzQMJlLNtvGcqwiKHDTvT65luCrXeVRm8X6RCbXfhbjlRHQaFQM6oWgwAWBFKbHHFIs
	wuD8693ZgOngfL7jRJ1yni8rEwpJgoJZ0mMVzoxhcVV20Xo1vvHBdKngjwatYw==
From: =?utf-8?q?Arthur_Cr=C3=A9pin_Leblond?= <arthur@marmottus.net>
Date: Thu, 06 Aug 2026 17:00:01 +0200
Subject: [PATCH net-next v3 2/3] dt-bindings: net: wiznet,w5100: add
 link-gpios
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260806-wiznet-link-gpio-v3-2-532d4a143805@marmottus.net>
References: <20260806-wiznet-link-gpio-v3-0-532d4a143805@marmottus.net>
In-Reply-To: <20260806-wiznet-link-gpio-v3-0-532d4a143805@marmottus.net>
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
X-GND-Score: -100
X-GND-Cause: dmFkZTE+WcSggV5zCp8g8eT5E/JolsF24Rl9OX9pXx8yvsvxSceOKMXWcUHCvd4FGfevv8symVzCRbUUPKuWQJrU0JMpZ4BXbtbyj1f/j+clyQ1HGu2c46H5js9LJVJE8KA3BBxdUe9a053FvnuCrnM8aIzoCoaPGF6fkS7JkXplNhcPhSwG3KxHsexsKkHwH9U2A2bYSfs14ahqkakWTVvmMuOCCFFLlhTynsi9SmUPAc4HsxDK8ORsAeHen5Pzi8iDuFMwsE40c16a2c+1FGEvCTezP8A4oNhT1kFysW4RXvpJKfxZdizPrIkk3wC80Bsw8Yr7m4qqwKsIByUhvFuQ1N9PMepZo0ov+3CmmlaEWj9dk/ITyzJZC+3R+fcjN1d/du4fCf+OR1wt6fJceVh3gcJlSumxPz70683FSkrMZ4BeVnAp6RTQoC1URC0MJqPCWfRAsysMqpsz5ds6U/clO9fn7QZIB6z2YpX9MiAFDOAbVJTVPveGbbcbwqDN7F11N5K0DPS34i4oUfgGDeIBOqDa7GxAdf92EBa5u0YnQ4nLOn0BAZkZYMDUlzkDfxGQlUItibMQreQ3I4LzUtBLrmYiAUlYtSlVBIKM+aITVOkCxMbOea9iLxO5It0foVrTqFW8AWju4Rlbx4Hw3WXQ6SLBm9mD2j8EWh7OShdUxdJA6w
X-GND-State: clean

Add the link-gpios property which describes an optional GPIO line that
can be wired to the LINKLED pin of the w5500 as an interrupt to detect
link status changes.

Signed-off-by: Arthur Crépin Leblond <arthur@marmottus.net>
---
 Documentation/devicetree/bindings/net/wiznet,w5100.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
index 641c9ddbde9e..cebf437ad3c4 100644
--- a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
+++ b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
@@ -35,6 +35,12 @@ properties:
       however, board designs may need to limit this value.
     maximum: 80000000
 
+  link-gpios:
+    description:
+      An optional GPIO line that can be wired to the LINKLED pin of the w5500
+      as an interrupt to detect link status changes.
+    maxItems: 1
+
 required:
   - compatible
   - reg
@@ -60,6 +66,7 @@ examples:
             pinctrl-0 = <&eth1_pins>;
             interrupt-parent = <&gpio>;
             interrupts = <25 IRQ_TYPE_EDGE_FALLING>;
+            link-gpios = <&gpio 24 GPIO_ACTIVE_LOW>;
             spi-max-frequency = <30000000>;
             local-mac-address = [ a0 b0 c0 d0 e0 f0 ];
         };

-- 
2.55.0

