Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622C431B80D;
	Sun, 13 Sep 2026 19:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789329417; cv=none; b=Fog1YPgkU6aqKNiC53wg++/7OlbkH/oLGueHTZgjReOAeWJAUbPJzwr1U3qpiwLQZ55IVBQX6+60S/uqId+rX9hal26eE2lEhwn6ica8uzbbtxXNRYSM8fNjn/Q0yW0W7kq5ETnfxbwM0+F6N73fKizG5n+or2AXpj5aLqwvtWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789329417; c=relaxed/simple;
	bh=5XwBct9t7lA64BfT2tR+4emBWwOsTER46e6rD6j9heU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YsMADzWMq+WH4sMBUNKepRMGfHcnxYQ0LLgaT8Yf5YPUGn/1zBCFFCv0WCczOL5ZtJbq/m4kGX8w4shq8KFFlgzevin+zu1jyydiDYRF80fp0qn5n5TjUYlfL1u+4SQ7VE+Bg20+rGHICgMpLXA7CH+6FJjb0RYmPreQHX2oeX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TdUq5FIl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TdUq5FIl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CFE31F00893;
	Sun, 13 Sep 2026 19:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789329415;
	bh=HQi/Lgt2NrCe/b5gcmSvaVqhdHu8N26BpYbwwYiN12I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=TdUq5FIl2tXvprrq6MzYerOF19pj1vo5fQkrRCXfOaJfIjIi9dc2mN97FtZg1fWAg
	 0Z1GeZU7ZibnajmlHv55YvIA3p6NSGhKIRsr03w6NnqdJ9eTyYhsugGjwncvLQg/uj
	 jgicE5kszhuionJNG47/WEzpyCwoUsgOys+Ep7Qhl5SvH648vKP9K7W5jYTINTrYjw
	 Rfvnabr1iDh02Y99AJ4d8qilpBN3SGFGCudN2KuD1l/jEjLAmG1SnzAwQ4XBbrRGoq
	 AKdpZE1vsH74hGpBfKLpI2IcZrvjhYPpZ6+w5q6VFQ4ks68t6wVcaE94MEEiLUcXtD
	 6+eENRB90/oig==
From: Linus Walleij <linusw@kernel.org>
Date: Sun, 13 Sep 2026 21:56:42 +0200
Subject: [PATCH net-next v13 1/4] dt-bindings: net: dsa: microchip: Add
 KSZ8995XA
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260913-ks8995-to-ksz8-v13-1-327b16d309eb@kernel.org>
References: <20260913-ks8995-to-ksz8-v13-0-327b16d309eb@kernel.org>
In-Reply-To: <20260913-ks8995-to-ksz8-v13-0-327b16d309eb@kernel.org>
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
Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>
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

