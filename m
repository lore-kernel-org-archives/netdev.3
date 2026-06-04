Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D80D73A3E66;
	Thu,  4 Jun 2026 08:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780560987; cv=none; b=cbbV+PS36v/e2iMOo+Aalv9UNvYxm2FfkuBxwsQj8e2EBcA5I+/6cWGPK8cZqcnxbOq+kxuCx9MaDSDxuJgDFkeBU0FoWU34CwG7E6hhRw1lbyy+28rJ6ZhaI6uJGYEvzW+qcUQf4yqskrHGpuekRt6vD6UosWzKH7PzHR3ROyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780560987; c=relaxed/simple;
	bh=hg8iabcFIbap/ynQls0mcJx6AM2EhUOOGizDrln07Wg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=H4UHQQxNFwqgzslN7w6qFg3iX1pruo1/Bb/svEMWPRlr9ngeJydqjCYYUdlnOLVe6aYes/pCVqpX+HqwT/EPqUUl7w+8Akip9jNhq33oBhaz/ECmDDUY7fYzTvcBzU1dOUiQjbFE3J+SldNKeYOwY0Q37mWTg5hmawaebDNMelo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0M/47tt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0M/47tt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54FFA1F00898;
	Thu,  4 Jun 2026 08:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780560984;
	bh=Zx7rvW5ZY9Px9CVnzO/KcJSO7h1jSduZQlE1l8PfwWY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=R0M/47ttOAsgoFmUiICK8eviaJNbMOYPOLBadThIWZ7i7l1bKFG8iY+l3bIDZp5gL
	 F58Q9g+01JMFtKFrwjN9vdrmNJoQBHAYRcE0iDzUn6Yn33I3CSIeYe3HxbWsl/n3ag
	 B43grAD6Ni4NxsZRvhE2RzAZeEYqbn9snCA+yEQydDmEEFuec94fPLcZKpBElKBR6Q
	 VpELlmSv9uxjfwlk/GxwQ56pwcQ3qBbk7+RIs5l4wPBvLJHIqZ17Ddw932jhNDoDZF
	 WrZiKnisYnpOpJiKJwfWFAvKaC27AZkbcq8WywZKtq0MKFHtBI72zm68F5aWfQ9Z5Z
	 vO+pF+m4EDcpA==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 04 Jun 2026 10:15:51 +0200
Subject: [PATCH net-next v5 2/5] dt-bindings: net: dsa: microchip: Add
 KSZ8995XA
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-ks8995-to-ksz8-v5-2-98baeb45e665@kernel.org>
References: <20260604-ks8995-to-ksz8-v5-0-98baeb45e665@kernel.org>
In-Reply-To: <20260604-ks8995-to-ksz8-v5-0-98baeb45e665@kernel.org>
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

