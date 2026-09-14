Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BE2A38734A;
	Mon, 14 Sep 2026 20:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789418118; cv=none; b=hmb3NivIbJNVhI0hM8Tr8N8h0j2vfx19lG094tlVeB2yTYQ6vAy8UF45Mzn4o1qYSZ5TA5jRIbUY5zMalQ6YzzZQDnhm2gUMcruQ2IU+b5lipC6TWb8MpmzH0w+juRD4DA9k68QyPXCAF52Q0TtocSOSdpNNS9ZXH1XbLAR6Hvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789418118; c=relaxed/simple;
	bh=5XwBct9t7lA64BfT2tR+4emBWwOsTER46e6rD6j9heU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S6QSix2xZ+1Ndh8HKqpSHBcUmmJte9Dj7Io84iRTLlnJj4HTyntQdvkHExpRkAberir+ZlgtHhW5EGf1r/ErxPSiuN9n1HauuLipFcmpHtVPGcaq46eOzOM8lE0S3gLSYpSChNUdzdRSUUzUu4j+sGQUxD4GMRBs/9GPPOTnXRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bL084/4q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bL084/4q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 561C11F00893;
	Mon, 14 Sep 2026 20:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789418116;
	bh=HQi/Lgt2NrCe/b5gcmSvaVqhdHu8N26BpYbwwYiN12I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bL084/4q8/qaoXtOBV2FRJzDqwVHfS8ryRyYTQzCUvj724AGgnlxBtNd6TQKbT6j8
	 xjQzotVN9CY2FWbsa3hezUqoitEX4Dryoy/h/W31inX61sdYA1PcmN6XKKi/IxRHyk
	 GjohvxGkvfFyGdRZhN2vLokQRBmvt9ZQyLVysmghNWhp8EtQGyn3AIK81gTeInx9Ae
	 9S9boHdcVMBamlEK8NpVC86CbUQLJdhE1/jVyP3DNjmOZSeWmoNRxthEwiyInhCrVJ
	 NkSnWmVY79FlVMAltvKLwIFnUW4KzQ1hjhqgbrFVjsg5QKsvWWBQBBEd/kWVJuPDbr
	 9WhRtbg3B1Efw==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 14 Sep 2026 22:35:03 +0200
Subject: [PATCH net-next v14 1/4] dt-bindings: net: dsa: microchip: Add
 KSZ8995XA
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-ks8995-to-ksz8-v14-1-3d72692b3c97@kernel.org>
References: <20260914-ks8995-to-ksz8-v14-0-3d72692b3c97@kernel.org>
In-Reply-To: <20260914-ks8995-to-ksz8-v14-0-3d72692b3c97@kernel.org>
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

