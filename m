Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8062D39B942;
	Tue, 26 May 2026 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779811194; cv=none; b=LHo4VyR/edt9zus+zvTh0KYrf0MGaPP6rIAXlUY9gEPxhgAkZmTgYsJ0yGkrnJejdnHwXSzBEd7NZ+gPjdYw+A6ABqdJaxWk4gAM5f42jFAOv4uEOfjgz9JOpvYpxgXpQqmCi4c2L1aRfZ/uKIeCpJ5Ri4Lx+zVahdG5aJHAGHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779811194; c=relaxed/simple;
	bh=hg8iabcFIbap/ynQls0mcJx6AM2EhUOOGizDrln07Wg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oa+MWBTQNPqj5DfNbyVulEYQdLvdl2ei9keGY+P7b4OdIMxTYnU1eLFSNO3NGTiW2ZV5CZtEDZ8mw/pnkMATyu/IzyYJ4d+1WajCpFMgXzVRKj2XLNw06QXsFq0C01Hy29tPtGM1+wnAAsWyj2VDcvJYqcgnYGPqqe+LmucPF8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WvjuIzFo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WvjuIzFo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F581F000E9;
	Tue, 26 May 2026 15:59:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779811193;
	bh=Zx7rvW5ZY9Px9CVnzO/KcJSO7h1jSduZQlE1l8PfwWY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WvjuIzFoGdrzkFt/8fbw3HZqaEU6vpehDJBtQBzqsWYMEKIkjk4vDT6S8AyKNrK8J
	 XE0NRKCxinJDRspNfYENG9p9OygvfbkAYhb+nvX2MZ1KSxva6hSUT7su7HqUe0olNX
	 7PjGfiKfSIy8D2eXYhOTNeXRgcFBXiUdTmCi/44OolndbwqBFn+7d3hud75q9t5buN
	 cnSB7rjJCgPggh2VKADsCNZu7hY9Rn+vSJjsorKUQ6N7W9qfh1GGnifQSaNlxi0h0X
	 uiZYbqmnGqXwwkud9y3D2BbjhfKhzTZDsGyL/zZ17ApBLiZgdYFFfLzppCR0kRCcEo
	 5+7yZF2MYSUrA==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 26 May 2026 17:59:32 +0200
Subject: [PATCH net-next v3 2/5] dt-bindings: net: dsa: microchip: Add
 KSZ8995XA
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260526-ks8995-to-ksz8-v3-2-c530f651989f@kernel.org>
References: <20260526-ks8995-to-ksz8-v3-0-c530f651989f@kernel.org>
In-Reply-To: <20260526-ks8995-to-ksz8-v3-0-c530f651989f@kernel.org>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Woojung Huh <Woojung.Huh@microchip.com>, 
 devicetree@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.15.2

The KSZ8995XA is just like the KSZ8795 and KSZ8864 a Micrel
product. It was renamed from KS8995XA to KSZ8995XA at some point,
but it has the same properties as the KS8995XA.

Be careful to use the full product name in this new compatible:
there is also KSZ8995MA and KSZ8995E which are not compatible
with the KS8995XA.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index 8d4a3a9a33fc..4ed13870ed3a 100644
--- a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
@@ -23,6 +23,7 @@ properties:
       - microchip,ksz8864  # 4-port version of KSZ8895 family switch
       - microchip,ksz8873
       - microchip,ksz8895  # 5-port version of KSZ8895 family switch
+      - microchip,ksz8995xa
       - microchip,ksz9477
       - microchip,ksz9897
       - microchip,ksz9896

-- 
2.54.0

