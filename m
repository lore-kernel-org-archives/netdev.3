Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E26B4E66AD;
	Wed, 16 Sep 2026 10:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789554089; cv=none; b=KQa043gOh1i7S36g3acth7vTpTEntMaFhqbUpgFgKSGlwKkib1mFH8FMprmidouYGZH7ydpi6dxMnJNlcHO0MUXapsTMDiKfQK/+GJS7YEqBvK9StJUykxov+i5bOCDb+0Ba8xlHB04HZ1ZmDbOVDdRqkz8nrmUL6GrmLgmt1Lg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789554089; c=relaxed/simple;
	bh=5XwBct9t7lA64BfT2tR+4emBWwOsTER46e6rD6j9heU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dm41STWAlEnzgQcZTQBC9rBlq7g0HxFZgIUnf0dudjzfzZ/u+H4uNW6FV/Fz3nrWlBMZTv4RPUzCnvaNK63sCsuQVF15eqa9aGrN6PBeq2If/kB4ac9uITQagVVHO5xAxkwC5GrvXHa6gL3b5dqPABNetLIWCEi0pK/dvJ9T+xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PIBND970; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PIBND970"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33631F000FF;
	Wed, 16 Sep 2026 10:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789554069;
	bh=HQi/Lgt2NrCe/b5gcmSvaVqhdHu8N26BpYbwwYiN12I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=PIBND970uOvc2QsZfXFuD1ksV2hlaAw+9VDwbxEmOFvHilRuy4xol1xkz68AUKAza
	 Da+vr2McItNf1v8tKOZdZJRIlFjwCDMI8LOcQZxorf0EkIehXLPOkCjibgormoO9ed
	 Pl3LZKn4nx9BNqhCA68Bz9iLmVGM3OEHx3Tj5cZJB9b+aJjf68RlxhMUZC5qz5uzI2
	 xMjM1zuDpACSvir5xNwy35Meg6By/RCcmzor0AMBFhpziKsNjlDI0/ngi8DG+tigZK
	 egoqBaXkrxLc9Id6hH1SEAvFekt18GILY1/xqHJV0z5QlptzqhsqbmkBRGE3V9Bj13
	 w8pvzA17SSMdA==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 12:20:58 +0200
Subject: [PATCH net-next v15 1/4] dt-bindings: net: dsa: microchip: Add
 KSZ8995XA
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-ks8995-to-ksz8-v15-1-8825ff5fd4be@kernel.org>
References: <20260916-ks8995-to-ksz8-v15-0-8825ff5fd4be@kernel.org>
In-Reply-To: <20260916-ks8995-to-ksz8-v15-0-8825ff5fd4be@kernel.org>
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

