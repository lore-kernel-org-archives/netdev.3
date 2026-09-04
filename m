Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81683481672;
	Fri,  4 Sep 2026 12:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788525387; cv=none; b=M6I0Ecy0Tcsq5LFy71CdGk3f90n9lSbod0EpPlPBnJwQrO0nsBfc2UjU+LuVx3tnTDMZsYqIlSiBNs06tvrlsTyALIJrqQcS88bw4ocmjKP1OEgtm4qGWp3tHonVpGsKCeO5B6ArtrKDalP+z1BgoTIVasvigrWMH2VJ/Rn+2cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788525387; c=relaxed/simple;
	bh=2ragPpDgcBdUVTJPPum1+45KXksv2e/PXK3BlyWZkyg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=msccIoLMN+Eu7iaV03DLNfpkwXd1Yy0Dr3AZBTUpe9wyOXp0XsFAwa1tOKpL0b1+aTD28P14Kbk9VA1fuL+yXLS055f15kUKkek/h1xZd+COuExGMuD7YjU96n9brAPjhJqmsuJaJIyMqkAYwT9hb3O/HSg+mO6cbqMKbPW4Ios=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=kQ6Nya2n; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="kQ6Nya2n"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 880283EC63;
	Fri,  4 Sep 2026 12:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1788525378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZLyDBMoWcyb1HCkLCE1M8X2dUTVn7IvwOhHT2osi3e4=;
	b=kQ6Nya2nx28TbkPzEEQdSpdfg111LnYuhvo8IcxIbSFgpYRD3F0SSf9qKnpDUk8w0vZDTb
	gMJMzinEsMPKcd0hP4vZBimtCGtwIUDEfPAtJKqdUGJHRgtLU/Y6kesANL1ezSbi1XUb3d
	Q75RU8NK8fh12R/16FMysx5ASnIBX9FJuFXsc/KApcM4nJ0/8ZRCKP5yHYMlljWckygxS7
	Oh14UkLyN5JazY6cbkVIQgByLkhpK+vsbs2aTWCNcTd1ojeuuo1F+VXf8QMJsXXQpVo6VU
	co9JByoE+/Ai4zvXvAlEuCgsPMfl4nMH/W3y1P9Ylj1/q7kG9x51M1yiAJyXSQ==
From: Arthur Crepin Leblond <arthur@marmottus.net>
Date: Fri, 04 Sep 2026 14:35:59 +0200
Subject: [PATCH net-next v7 2/3] dt-bindings: net: wiznet,w5100: add link
 status interrupt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-wiznet-link-gpio-v7-2-69f01b70c96f@marmottus.net>
References: <20260904-wiznet-link-gpio-v7-0-69f01b70c96f@marmottus.net>
In-Reply-To: <20260904-wiznet-link-gpio-v7-0-69f01b70c96f@marmottus.net>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Arthur Crepin Leblond <arthur@marmottus.net>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-GND-Sasl: arthur@marmottus.net
X-GND-Score: -100
X-GND-Cause: dmFkZTG3cKQSdAPBXGVh6GOikZLK4Aas1ywOC0YbiXbtGhbq4f87oWC4nqjUGhyvbQYzqbjm9NzFQSKPLR9o/p9FzXrd53UGWxYyKiguWZrVRn6ttK9GibpIh/93LXTJC5xkVeV+MNEQ3etcQs1RonpGp/xrDk9O8z8UHJNWh/Yuf0QUlQQSq64ZWaaNL4njzkyxlgcgLJEpN6b/tB+3zBZ7HcJR/7dMJutbyDwfCxTry1ilSupgb4VJL79nMYQ04syN2C/i3SssZqwv2ymns8c6V+NPeNIOMpv8jXwN1C28pOdPT0XbMshdPSV+oOQzWsPYqNc8wAHroBhPrFAk8P1xnhArP0FpuvoAfwfjo9VWnfCAYHxE3G2HX7YKOInrFPmqkgHZGhbZKGP+eHf0w9P9abv/rOsS7aNthw1J3QL0raE3uq3hNgHCCEEWhygL8abOzPChgKFThI6po2KShrpC/mKhxcD/V/Ma9QGzfU6wqOvGYFJ21iEuhmA8+JHEh7+m4C5EPFTmYVEN07zeuGZKptPsmRU4V6ktbgMR+OHqzh2qLawuizLGoDyuTXMTplNZ1bBkjf8ZJHzUwjEsloDCF1c8hIYGcM4GWjINHChrEFMw6Laxa0d1MffxNkk1zxZeLk3gmUWRhL65ofZ9ulDEIDv8uIbkMb0c5qE57OMf/0eqVg
X-GND-State: clean

Add an optional link status interrupt which can be connected to the
LINKLED pin on the device to detect link status changes.

Signed-off-by: Arthur Crepin Leblond <arthur@marmottus.net>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

---
v6:
 - Fix DT error: use minItems
 - Remove conditional properties

v5:
 - Make the DT interrupts property dynamic from the compatible one
 - Fix DT bindings errors

v4:
 - Update interrupts in DT bindings

v3:
 - Fix DT binding errors

v2:
 - Convert device tree binding to YAML
---
 Documentation/devicetree/bindings/net/wiznet,w5100.yaml | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
index 601d828bae92..d0717ab45de6 100644
--- a/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
+++ b/Documentation/devicetree/bindings/net/wiznet,w5100.yaml
@@ -24,7 +24,11 @@ properties:
       - wiznet,w5500
 
   interrupts:
-    maxItems: 1
+    minItems: 1
+    items:
+      - description: Main interrupt (INT pin on the device).
+      - description:
+          Optional interrupt for link status changes (LINKLED pin on w5500).
 
   reg:
     maxItems: 1
@@ -58,7 +62,8 @@ examples:
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

