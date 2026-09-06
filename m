Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D1BC3515C8;
	Sun,  6 Sep 2026 07:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788680905; cv=none; b=LjWyj2M87DaELKrkuptwBENmKTGIdV0JSFYFHDGcozg/EcEQIOy9dUlwo0eviJlvuL3IfKQkUylE6aOxbKZJaDaKKHpdNjMS77mBuGH/stBKelLCyFpAlE8ExHUD9zrKigm/f3hSr5lRcYTJ/69dBCTvLM833q1qsqWIGIQPfqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788680905; c=relaxed/simple;
	bh=eWrohttsVsoBY8vBn18IrAzkzZNW8VoRwV3LutZFaUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VhSTuBGoiCDUayH6ly+g8OqAFLohFHOr9E8udX59iLXh9nSvHw1QvXP+BiKlS7Jqtfzqyz/kN7d8gczNfC3j4iD7WC7GKxLUHvSAWv4qJIf6ZJ5q2KySRRBZN/wWd9JDbBaMrnR9YoxycFZtvh2uCskP45qsXBkZghhrGnb16Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SSMXW418; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SSMXW418"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DF161F00A3D;
	Sun,  6 Sep 2026 07:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788680903;
	bh=ww7Ierdf3tovgGPC4LeOovHyTEEBqEkUFLbwEyLd28w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=SSMXW418nkWE1AXOzLvXBu/cEq4u9WrkLzI7V22QwtwIi4vvmW9bfvuGwpfprVEgx
	 A4ZIofxVCunKzqv3ATGKkidj87nV71KLUCNbyYMzTvyZyMzZBCElg14QAT8bHUiw+G
	 4uK4L1uzsmlKJkZzBq7BKbj/6pnXqvjrNiUBraAZvqqEEBCkeMw+EX3SqJDsSW0DiM
	 lzOkHb2Ff3GSKnX91kjg7fUV8jlfvuuqqORQnWvFqp85mzgDptf3brFV2j6Cr5v8UX
	 Ez6jwoefmWnaHke2nMcVXhUx/HLt4ApXud0r+NzoWMjjAnoUrlfFW3Td+vdvJv6jVr
	 H7vD4Ez2qEP/A==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 06 Sep 2026 09:48:11 +0200
Subject: [PATCH net-next v9 1/4] dt-bindings: net: dsa: microchip: Add
 KSZ8995XA
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260906-ks8995-to-ksz8-v9-1-8d8815a91bd8@kernel.org>
References: <20260906-ks8995-to-ksz8-v9-0-8d8815a91bd8@kernel.org>
In-Reply-To: <20260906-ks8995-to-ksz8-v9-0-8d8815a91bd8@kernel.org>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>, 
 Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, 
 Nicolai Buchwitz <nb@tipi-net.de>
Cc: netdev@vger.kernel.org, Woojung Huh <Woojung.Huh@microchip.com>, 
 devicetree@vger.kernel.org, Linus Walleij <linusw@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.16.0

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
2.55.0

