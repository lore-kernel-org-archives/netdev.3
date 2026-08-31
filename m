Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CFC1396B6F;
	Mon, 31 Aug 2026 20:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788209676; cv=none; b=t6wcYrrIy6ypyWUl0pJ11oBFt3on9l+J2kMkCUt9yQP8TCSWNJhMvTb1CVTLrjS2BR3ttVtrmxZUvgfWer7aZgHA8F2i25ufepnDUWNWcWGaxMj0DHpXc1d9tJR4JNW9P1rRSIVmuMrlg6Qygb9y1N1nWR3YVA43SD43SYaQqZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788209676; c=relaxed/simple;
	bh=eWrohttsVsoBY8vBn18IrAzkzZNW8VoRwV3LutZFaUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hBgOdtCO2YhpB0mrKFOsSNyVvqTrJIPcWZ9FWVrSgROHh0sL1vct84rKoiABpvcrkhYoztKh4QjxA/JvdS8RgufhUIRNTLBQX9263oCo6vyiukCl4SfouMAEMoS5YaA4xd1aBVtB4xquMzJ2SEBWe7+pFu1L5Z9UoofR86pihg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RNLXvoqN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RNLXvoqN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D4081F000E9;
	Mon, 31 Aug 2026 20:54:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788209674;
	bh=ww7Ierdf3tovgGPC4LeOovHyTEEBqEkUFLbwEyLd28w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=RNLXvoqNw8RjKBVbC4ZbO28HEmWwTS1GYAo5IHIDCcACMk8uF+Zu5ksLJswxwg8G5
	 QfBCnsXaKtxj8KtGopVuG521hwEatKuD01WQKzxxS5dNx0HJjxHe8mmiEHk7nrIidY
	 vpBx8lFFrzw/qHkX6+L8WHJ2pp2VROb7Ha8BTrYJOASPMG7eF9vCL2JAbWsGdNR1+V
	 6oeuo8LHdE05Xuhn9xCkffg+vh95DnB9NB/eg/mPkW7upXuQ0Inpd2BQ7lJJmFqStO
	 oLroIzsCHASNrqPue/0lWKBaFKN6Jskjk0LMEZjD6I383KWlrzh9EluN53/9xEk6Ou
	 eDdPb3nEX6JVQ==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 31 Aug 2026 22:54:18 +0200
Subject: [PATCH net-next v8 2/5] dt-bindings: net: dsa: microchip: Add
 KSZ8995XA
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-ks8995-to-ksz8-v8-2-fd1dbb2b76e8@kernel.org>
References: <20260831-ks8995-to-ksz8-v8-0-fd1dbb2b76e8@kernel.org>
In-Reply-To: <20260831-ks8995-to-ksz8-v8-0-fd1dbb2b76e8@kernel.org>
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

