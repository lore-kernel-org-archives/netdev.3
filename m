Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4785F327BEC;
	Sun,  7 Jun 2026 22:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780872111; cv=none; b=UZeJh6GaX8Y+nVVLZr+2sFMRCGNETnYrAVR4AvKiwfO/ob3clQQIaBcuvAU0T2uvJ075JySbn7rv+iFnx3XBY2jT+kvIkj83LmfiK9g8npXmajdQAtQyh8hnrMpMseKg89q5EhCnJ2QkAIRRsq5wWP/qqn2DOOfB+N4EN19Ru20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780872111; c=relaxed/simple;
	bh=hg8iabcFIbap/ynQls0mcJx6AM2EhUOOGizDrln07Wg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lrOtshktWF2zCBORViuqqTd1obWLVaxbGhitMnQzys4V/oOqgviJ28Nw4GiIvRahPtZPtLm4kHOGhGgGdYw4KmB3kb53pyKlxPuLwQQvjxtxl888F7wydQHKXsQN6A/Ff+o7ZKr/YE9x4V/hLoEcp13ocWPBYHcpl7D5rbNIOOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfVFfcCt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfVFfcCt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FCBD1F00899;
	Sun,  7 Jun 2026 22:41:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780872109;
	bh=Zx7rvW5ZY9Px9CVnzO/KcJSO7h1jSduZQlE1l8PfwWY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GfVFfcCttUe5JsCNtR6wOcUJD9qnVbCnrSjUiLufjnoGx9HPxKszb2qUqt9euhsFQ
	 C5f+5anaQKHDbcAda6LHQF0O7+SyfaE722YyrszjRXvwl1EgcBffzN8IYXX17/WUG5
	 xs97bNKFc5IL+pVF0lM/pHsCWJ8a6bxZoDVIKeKlHADD9yu3Bt2/SAERbnaVXprMda
	 ASWWTP3utJxsWoVStere/eeUxFrsmAtZILTnJat61CMwZSe+V30HJWVNFty4BdWX7B
	 r7kT+0jvwxIqlRaJccxtWEAPpekqeroArIC3Tgtq1R5lFE53yZwF63uJeAXqXuxKSZ
	 PswRLfIQ1mtTA==
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 08 Jun 2026 00:41:30 +0200
Subject: [PATCH net-next v6 2/5] dt-bindings: net: dsa: microchip: Add
 KSZ8995XA
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260608-ks8995-to-ksz8-v6-2-d91eb43edcc5@kernel.org>
References: <20260608-ks8995-to-ksz8-v6-0-d91eb43edcc5@kernel.org>
In-Reply-To: <20260608-ks8995-to-ksz8-v6-0-d91eb43edcc5@kernel.org>
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

