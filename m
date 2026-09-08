Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02DE4EE878;
	Tue,  8 Sep 2026 09:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788860343; cv=none; b=NbHQTnUfl7U4vzpDlF/re3ppnEgZMirS7vxBldBvpuRZHob3PQN2H6jiQfpFpJ7eLVYtVAsGd+TaXLnkJI2na++0P3HHFU7EKamxA/Pl9vKGAHzigDPRzL7ymQbwP8dR9MzH7ykrTnLXu+H8lLWfAeesh2JIlsanKX0mtsYrQwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788860343; c=relaxed/simple;
	bh=F2yU0bsUECbFAURsRzDLKjOxvQ6HAy6ZTsw7ucYtyjk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uhO7FTZfbU04TU8IsgOx3O320/In3h9tVaWkfhDlIWo7UEfwamyc0lLXvoQqMlegRgL/x2PcQXG7gGchfIfwkhis5Np12rNd0PB7MaoSHfObcqBiMGwkhkUKhSX/fDLDcPQ2IYNukx3srOilhEPeZV/ukTChoaqMdzFqXHiEmcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WePXsuOV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WePXsuOV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2331D1F00A3D;
	Tue,  8 Sep 2026 09:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788860341;
	bh=mGGmlU/0qmP2j07rZeEbTYmAIqgUpAD9uAE6/Qj8Wic=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WePXsuOVJJdQBT4fEXbZwXOWbNAIlY/H0bDd3dVVnhsfNtYs/QrMqkVkcQRSnvjlm
	 SXd5R4qw/1M/yNAGwbf7FW2ssBGUSpStXEJ6LGpNy+LolOuLsceOKr/VPAkgtbZA9O
	 /Y8Cxopfna8RQy+sROc9C4n/8JRQYMkMjK0jFjPisoN0KsJweCWMw+MjvdL7E1TgF2
	 GsRWjfpEWFX2gHW+6hzqYcOpLQPc47xX4GD0or1nGlwy2Ht3vnSyO9NSKgLdLpX4VJ
	 eKLCZ+QLGHR8m8M/3vH8hj6iKiD4xOT2y53Y9M8JjZcTGAOpAdfg8bCoqEzxmeGwv+
	 wTIY4/T54K7pg==
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 08 Sep 2026 11:38:48 +0200
Subject: [PATCH net-next v10 1/4] dt-bindings: net: dsa: microchip: Add
 KSZ8995XA
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260908-ks8995-to-ksz8-v10-1-7379239eb65f@kernel.org>
References: <20260908-ks8995-to-ksz8-v10-0-7379239eb65f@kernel.org>
In-Reply-To: <20260908-ks8995-to-ksz8-v10-0-7379239eb65f@kernel.org>
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
 Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml b/Documentation/devicetree/bindings/net/dsa/microchip,ksz.yaml
index 8d4a3a9a33fc..ed39530b6cbb 100644
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
@@ -122,6 +123,7 @@ allOf:
             enum:
               - microchip,ksz8863
               - microchip,ksz8873
+              - microchip,ksz8995xa
     then:
       $ref: dsa.yaml#/$defs/ethernet-ports
     else:

-- 
2.55.0

