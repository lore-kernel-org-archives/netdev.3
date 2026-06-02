Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 691743CB2D5;
	Tue,  2 Jun 2026 23:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780441859; cv=none; b=ZoaueslC6OF2eYcNaMrpUmCU38ZqGK2YYuSFLVdZmZFGOIGTIom7MPFLffp678fLrl6GHno2e+f22BzaRiZAL3wxk7gYpp514FkxrF991bmi+zHgo2+xGqxF/TKB/8kdxwaml1rvRMTbtW15f8jRrryBD/7vlY+PQI47FDiH5wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780441859; c=relaxed/simple;
	bh=hg8iabcFIbap/ynQls0mcJx6AM2EhUOOGizDrln07Wg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PX84NatpNCGrpo8Cdl1OZuret15GvTYGa9jYa6Of7yLMpwLKZJlTC89JY+wtYjd3a9HCJltKYdvizfKf9woP2MfbT7i+fhl2XcSKqYCaEBrwpPAI9HezJagMNqiY3CzvYK1X40xKJt3uKzRSWS7TVYZQSnx+DNSS2UFBHGIVO7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ela+Kh6D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ela+Kh6D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A77D1F00893;
	Tue,  2 Jun 2026 23:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780441858;
	bh=Zx7rvW5ZY9Px9CVnzO/KcJSO7h1jSduZQlE1l8PfwWY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ela+Kh6DDQzj0c89GouR5c6lgkKLrjagSlpUH5iWcOjmq5RIVqlnBAX6dtGKH776S
	 7nPUhNSd9t6uJgC2sLXYARoz7GaHk/978+ZDBOriXpgEPWVNRQJ/hBhzweSgwOSOZg
	 PMqIHoRicAuGZ2gPAL+xYHtOGhlvYiaFHlaaEpEeUTDIKgwHes2co73uvELlYMgQBe
	 2TvRIUClwSYLYf2U5740XgY+X69tHq6bb1FvI1nMnjwDOY5fkh4lpyqsVizeWuACut
	 aWpDfLhiA8FUy2cQFiHnyDbTkwn9EoTaXw15lwxqPBr1lQI1FoJ8Gry+gqDH0IZ251
	 pP7UERsmEiGAA==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 03 Jun 2026 01:10:41 +0200
Subject: [PATCH net-next v4 2/5] dt-bindings: net: dsa: microchip: Add
 KSZ8995XA
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260603-ks8995-to-ksz8-v4-2-e15149ef21e7@kernel.org>
References: <20260603-ks8995-to-ksz8-v4-0-e15149ef21e7@kernel.org>
In-Reply-To: <20260603-ks8995-to-ksz8-v4-0-e15149ef21e7@kernel.org>
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

