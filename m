Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793776567;
	b=NUcuohJtzUhvgLJhUtqW43ZIRxUiUBT3pHdCoKJZkhk2cUoFshVZqi1HZ8Eu3Coe0oS+
	 SFRAv33D6Bd1sNdvvimiWlZJF+hu92XzlQai0cNNiFaUur0ATsdzAJ2e/zag46lKtfwrv
	 lbt0QlRdP8WfDtnH5jBcxagbV4NYcbDmAqDChm7lXd0Q6RNY0ihCdKgMwyfaNqpUeK4aB
	 KONPQ++D0oQA9xNhYTdP74SLH6MpAQzOPW8Y9Zdnb4TBP1fTDUrnf2ZiSDjOn9lXUUQPr
	 EyqXR4iZzy9EX+G+37VV+Pp5F0thhgclSSZfpf2PLqYhPWjx0ct7C5N0FF6K8LJKGXA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793776567;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Czov5U9qZ2bigGPiKCWEuiT/74SJfBbTyeasjx6Z4cY=;
	b=3R6KVzpvsKaPYnde6pFwkLoJlUqPOSGmSr1EKjcwpcqP4KMW0HjXHnPi4onboFZupMJd
	 006KZ7tFHnAJn/HwEYP+Dm+ej5hs/rSgcMWCxr3oy/2C1jQKw06Z+WjDl9/LDygazbH0Q
	 +0mm8+1Xp2fI9CV64avk3v2IvmTPqSFQKUpQwuxqlDPeTuYgjttIX5lPsyZ6928gUklgi
	 wonz7CFCZgJRayY8fj4A8acakitwnpFc9nXMS23MwEfF1SpBXmNDepDDL5nkCccTFeR3O
	 iDSa0xwGt79ozx87ZHjs1YJBiMtzd6iUOnd8FYqTVTr+Rk6Qr/m69RosXrEfeHNrD8A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I7mSZ41j;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F49D606D817;
	Wed,  4 Nov 2026 07:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=I7mSZ41j
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793776567;
	b=WhvSQEzFsYVeMcfqHbmNv4AUfR5oANRgjMiMyGlYSxHhuZCmDsmAUzWMlenJpFkFU2z7
	 SV77H9vU8lv4PHrwX5of/nAETszeQ4QXtkdh9+5NuxLAwxbLZJ29lqA3sdbLtO+peTvNT
	 wq3bgVUfqudpA8CVSJRlnwo0r3m+J8ohms+yWHLskL4YB+hNe5y3KF+ev+GjDjnmuHZos
	 X8oKkPFcZJJzvt9Thth43/5GuWpNlBEBUOO53aHGgxN+Uvb06V8E2FI5DCpBmzKC0ki0H
	 QiJ4tdyC538twYIBc7k4kSv6UHOmPZEtHVO9Z1JuyiSRVKfCUfPl22rYkONngFwDwQQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793776567;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Czov5U9qZ2bigGPiKCWEuiT/74SJfBbTyeasjx6Z4cY=;
	b=uvNFdFKHz4xq0ZQKWHB8NZyyQ31wPmP0Egl5Ku64hsnPrZLuUEZbjYA5QHa84gBQp2Ee
	 j7odSz71SUfRHTtKJ8mpldpqpgqgvHd9PKIywvHTlgW9OoWSkr2aXk4qIltYvo6p7t+oe
	 NpPS27VOcUfvI8xD2s+7UrHVZcYsRkGY4LwR6AtXkYtwQ6mXpxtdEF9cTUjHZoXhaj4Dy
	 WCZzqXQqiHu1m1Fh8R8JO+/rgJQmGUoeuij5xiqHYyw/UP8rYHz3ctoP+mmK0F64xlfTY
	 o2CuUMdpA5mLuUHs/qrKag2v93aWrnKZiduuGZiFRQxDUM0+zu0O4shGYdycP232+ag==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 461441F00A02;
	Wed,  4 Nov 2026 07:16:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793776567;
	bh=Czov5U9qZ2bigGPiKCWEuiT/74SJfBbTyeasjx6Z4cY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=I7mSZ41jsOyeQb+hunOIe6fZNIPg8zdARqsxx7oQ0POx13ldqh6T5WRwnWUd28iXa
	 IndtVJBo3GZ2Etosxh8r7Ulcbrs36Upkp/mqsUdWcH1bulI7FGzAs7kVIgGrqfNBGT
	 RW6rZEO50uMb+C5YrUssAw/Q/a7EdD+rs7qeJdkjS1iqeqfdoLIswK2GUKGEphlh4V
	 lRYnyM7bPU0G9OvUxQyF67d7yapicqBXXC1v7SVmP5vmy+dXW/jVjG0A0EGMVe3WGQ
	 jzOIavIH6fjHDcsGP1GDZ1RSdAfCkP7EkFfOMzKv9KYRJboItFKvd5Da/FRLqOFjSq
	 OOWLzgkSn8i6Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 4562F46CCF;
	Wed,  4 Nov 2026 07:16:05 +0000 (UTC)
From: Joseph Telaak via B4 Relay <devnull+joseph.telaak.dev@kernel.org>
Date: Wed, 04 Nov 2026 02:15:47 -0500
Subject: [PATCH net-next 1/2] dt-bindings: net: dsa: lantiq,gswip: add
 reset-gpios
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261104-mxl-gsw1xx-reset-v1-1-53839bf5c88e@telaak.dev>
References: <20261104-mxl-gsw1xx-reset-v1-0-53839bf5c88e@telaak.dev>
In-Reply-To: <20261104-mxl-gsw1xx-reset-v1-0-53839bf5c88e@telaak.dev>
To: Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>, 
 Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joseph Telaak <joseph@telaak.dev>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793776564; l=1120;
 i=joseph@telaak.dev; s=20261104; h=from:subject:message-id;
 bh=vhM/sPd7QRmgpTVspArEnQoT+I2HuhqV0EniWc/LMRE=;
 b=Lc+omdu1USXrwx85IXa8FnCINB8L495JrO9H5ehYsw5L73R4EC9PlCxU5WXjjNgvNNnZ0h8Rk
 QIwWbO4hwMAAbeLswLPtEBeg2N/+LqJwzQH3tfIg83IfmD7CLZOGkoh
X-Developer-Key: i=joseph@telaak.dev; a=ed25519;
 pk=oQI+UfddlZ0wK2ac4WKOGNjUl1ZEN8j9ZVFSqEDoNP0=
X-Endpoint-Received: by B4 Relay for joseph@telaak.dev/20261104 with
 auth_id=1404
X-Original-From: Joseph Telaak <joseph@telaak.dev>
Reply-To: joseph@telaak.dev
Content-Transfer-Encoding: 7bit

From: Joseph Telaak <joseph@telaak.dev>

The standalone GSW1xx switches have a hardware reset input, and boards
wire it to a SoC GPIO. Allow describing it. The SoC-integrated GSWIP
variants have no such pin.

Signed-off-by: Joseph Telaak <joseph@telaak.dev>
---
 Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
index 49af5573e4..9a74ea2a6d 100644
--- a/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
+++ b/Documentation/devicetree/bindings/net/dsa/lantiq,gswip.yaml
@@ -40,6 +40,11 @@ properties:
       - const: mdio
       - const: mii
 
+  reset-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the hardware reset input of a standalone switch.
+
   mdio:
     $ref: /schemas/net/mdio.yaml#
     unevaluatedProperties: false
@@ -173,6 +178,7 @@ allOf:
         mdio:
           required:
             - compatible
+        reset-gpios: false
     else:
       properties:
         reg:

-- 
Git-155)


