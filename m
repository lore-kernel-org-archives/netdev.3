Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F00922D837C;
	Wed,  9 Sep 2026 17:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788973253; cv=none; b=o4fU/geO3Dt4/9rkPlwIigvHL9k+pnlkwflfCAH+EENA6dUPcoYlLvh3RBFgy5KTGisa60yMxOFM0a9vHPCfqiLpcWfPv//tMgS/Fk7PaRV8lHm4HUQKDk6FJYMEe67NNn6yUMSbZWCJdiZXfdGF4uPj84QforetYU/A7vboP4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788973253; c=relaxed/simple;
	bh=eWrohttsVsoBY8vBn18IrAzkzZNW8VoRwV3LutZFaUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=el0pur+y/vYcQK5eYLr43YxFcBqYXvf0jhT+KbOrJ8zPudfoXUwVcZSbGlgRpgr9U9G9BfFE/cyGEoYF0frtU8XVW0VLhEHcSB6tH7A67vKcHgL6TlMHDl4tVuG4C+b9VKKH8ILycxVam3wpTGr+pmsRp0J/ovN+bBgAg7EnpKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCgZFaXf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCgZFaXf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DA121F00893;
	Wed,  9 Sep 2026 17:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788973251;
	bh=ww7Ierdf3tovgGPC4LeOovHyTEEBqEkUFLbwEyLd28w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gCgZFaXf5SAUMeMH31J/GojCB6LMr1VZZjQpTYouYY7yjy5MIZrmHww+tohg4yrbe
	 FpSaN+TvhCujzgduR2rHU4WM8MOCYQkvAsPGDc8+N0JBm7dY1fTjMwvpD4HivPuxKn
	 6jnEjzCKN5w/HMeMbIP4vi7W11a2Owj7Yv2O8IuczCkXs0I0Yn0vcc2gPjpDrUuCmC
	 K+DoOI1quXcz0W+nNNAGUmeeisvSvHP2XdQCPJ/ICdEO9gXSBdH3NSVK/um+jbsOAq
	 MV/p3lJfZ2fnWon8U0v41HWAtnR5slwrkyKRmeGcx0SKpynyIpwwgNIMWZkge5DIIg
	 EaL5h5YSen86A==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 09 Sep 2026 19:00:30 +0200
Subject: [PATCH net-next v11 1/4] dt-bindings: net: dsa: microchip: Add
 KSZ8995XA
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-ks8995-to-ksz8-v11-1-0e04411a559d@kernel.org>
References: <20260909-ks8995-to-ksz8-v11-0-0e04411a559d@kernel.org>
In-Reply-To: <20260909-ks8995-to-ksz8-v11-0-0e04411a559d@kernel.org>
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

