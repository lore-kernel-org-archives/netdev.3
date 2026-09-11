Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3163D472091;
	Fri, 11 Sep 2026 09:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789117806; cv=none; b=GSpiGzV1RL+JpPBdQ4Sk2tkGFdpJdXgGF/ubWaL0jku4DkjNrJ2crWZfd0wIEY3KmBZ5AgNtuTY+btoIU7M8c8xnXhlO05UPt08a+K3KhWNIn/cHb7jqb6MlPW69Nke3T+Oh4Yovv1H4r9jGsv1jigaJx0tJqEgyNrUo5CSF4bQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789117806; c=relaxed/simple;
	bh=eWrohttsVsoBY8vBn18IrAzkzZNW8VoRwV3LutZFaUc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Qn9aOUm1JB9/K2RnE0djrs3auCpzwQXbSqydQHDd58N31smhJOzW1EuOvIqEsbAZmM5AxJv6AezGvBc8rqRJOsz3BzHaAoP8dXvn+VjjZqkv1QxJ/FS5pK6adIXAtYyB4uW33yCogHMbBTcxQZEHAinyj96vJ0L2gq9vUeXIQeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fpXNAHsv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fpXNAHsv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A200D1F00893;
	Fri, 11 Sep 2026 09:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789117801;
	bh=ww7Ierdf3tovgGPC4LeOovHyTEEBqEkUFLbwEyLd28w=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fpXNAHsvbhSB114pzlP9Ea5SG0FpD8oEVtfgt5NwdDD2/iffYQsCEM5depIweYghm
	 cJieDVHJUOzQKh9j1bThBnrbQhcxC4eGTWBIUOK+J49LVKfw7yj7Tx4P857cY9YcL2
	 rL8P1vVo+0f+y+Pz5pgieS8CghC+ajLAmtI3HeWvY5GzaMHI6cOSnHxWTrS3PjTukr
	 K/EfPyAI+l7tnLgBWJsAooQG3qkTAfLrEBh01kDIjERIZyQy0Xg7yQdwzVtxVy/BPh
	 QPiisqpVmZiD4IiYL2tiRyFsPB6QGhVAYmI6OzJR3eTpS2F7FZUHVajp3TP5ncmylz
	 OGMsk4CZBx4ig==
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 11 Sep 2026 11:09:44 +0200
Subject: [PATCH net-next v12 1/4] dt-bindings: net: dsa: microchip: Add
 KSZ8995XA
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260911-ks8995-to-ksz8-v12-1-5c3422d0d72e@kernel.org>
References: <20260911-ks8995-to-ksz8-v12-0-5c3422d0d72e@kernel.org>
In-Reply-To: <20260911-ks8995-to-ksz8-v12-0-5c3422d0d72e@kernel.org>
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

