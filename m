Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794178813;
	b=COV8uRpPqt8YQ40nRJi+JP6fV/PBpDvpO/bEx+xRU4yvZR4LoXrL8tOouEJl2V/ZRyKg
	 x5M7foUnp2j45Ij8ABq4KkLfvL3qwGZOT8+TFi0kO8LvVuHgHxUSQlxvk28FSxqvCe8+i
	 /k1FR6k1IRQDQ7FH4+QE9Cu2K6gaCtF6tSkFkFkFUxgb6PyVYAbsVei2QEKFpQPr5BTXI
	 uRKG7ThLQaNwdTeD0ItCbaH46cfqsIlGrmsepPT2REKXSrZbG8DXjR0qlrKqu7eRRffjc
	 Y8zP9uTLV4X9u8fpejs6pKg8F+nFLGL/gjTb0J1aSILNUKme4lbyP8eIvQw/6aUiA4g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794178813;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DsnqgFdLLmzTka5Qh8hdUhtHXTfN+LBLWiqJUvCE/Ko=;
	b=G5hp+CU0oODGx8sQIW6TuZeBAoQhsnfS3VdaQYq9c0CCv6g5evgC9mjH1Gun3VFKfzpi
	 z/GPnSFYp0LtbbxB4FgDzrnRhQlHShBJ5YFHaj9Z1D1YzjPeiiB03EBD37FpolCVJXudt
	 iCEP1TOP6kH61psKRyyTRZdRTxxOUAhbS9ZILGsqjNYS+fCRgoKwUITLx2qPoVOaowgn9
	 ENhDxYgN2tBNIiHJLX0bgmhwtzMy/+jnrKE3gUZlUehtD1+y4Km7TMhdN+e0+CKOzq/tv
	 oBzY3NMny6tdwIhW94P9usV3ZSkmW58/VMJ9A0L00umMGn9lfrp6D5Qm+CjYMtDNCLw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oUauj4SR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4FD606A31C;
	Sun,  8 Nov 2026 23:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oUauj4SR
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794178812;
	b=RxLZTXemPoG1kVl4DdAOK4RdFycaHS+PeFsk01rI2WH9p2HMtdAgX7vlkRV1B+YiP48P
	 GXa+E9ku8HvRc4hh7Q6t3OuTUAdt9bXASWGWWS+HKOlPEqmAqhDB7nOP+5ZU7q9edfpaL
	 /6+VH+9200gUT/wjjqy+gbNkizTOG5AA7hEXLNB8ow4x4IW/k+5SDj9+UxRdVOYtY4W2c
	 G/3EXK8iV6wIB8LPCOWLk3EqgSeVsSJyuHwyK8EyEzWm1rjd3eDqHrTRfP/5hy2+D0aAP
	 J6f8pyz5/AgPnVGiAi6s3j6hgupFnN3ieUrGQDOo3Ct2l1nfjY10wMwnBAtgYCqQwcg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794178812;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=DsnqgFdLLmzTka5Qh8hdUhtHXTfN+LBLWiqJUvCE/Ko=;
	b=RugMHCM9REcd5jc/kaKK51Tttqo/DDBz8lNXJF25n7KbAT+zVuIApXGaiWPiTrN6R2X1
	 8LGKIT3yJtpB50Qghw5nsIfgEJLNU38YiVVYmRG004arjmiAF3aZjGoYRiU7jXYwEh2Sv
	 bueLbpvREKWRPYbvb1zYvbIVAKkVE3D5npkfKZ3cN+yOi3iOBN+qRp8s2FCF9goB9qSmu
	 xxoECuj8capBC2R25syv20fBZmdGJvrjIuA0ZZUPUfziuPcujnvykgOxggzECnB9sMURI
	 MVDYVyAAaYDM912+tZQ9BjJp7dn5pPjoeZVkU6+vJIqkBKOXoAdQFh2QPKC4jokMeSg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 3F4DE1F008A3;
	Sun,  8 Nov 2026 23:00:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794178812;
	bh=DsnqgFdLLmzTka5Qh8hdUhtHXTfN+LBLWiqJUvCE/Ko=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=oUauj4SRE3mCodwA98IiQS8CP1XIi9KgeeLEJV8AaDIcD3tdzdZEO3WYvSE2xK/GL
	 W8NOGPvfIFVs6gVPDpUhmR5u2AMhz0ESp1kYsQl2dlfcm/VA41D3xq+EPo6CnGaXeq
	 gNxgqUWJkL+LklvBDHBv4N351dzV+EjY/YaEXv0vFh/orDMiMUtIFdXuOuYN2qoEVT
	 UUN9L6gKJ2Dz1ss8+Jfg3kkVflpSwC1JYSp2R6IV8dSiXw0O88Uh4xsp7qEY+kM+cF
	 d7g0tA7dZclnSyB3YNjImGpEKj9TF5/jg0ti3zOp+wYyxbXSp+x+jc8YsLbOr42AhZ
	 VfCSYt97fARNg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id BD6E448151;
	Sun,  8 Nov 2026 23:00:11 +0000 (UTC)
From: Joseph Telaak via B4 Relay <devnull+joseph.telaak.dev@kernel.org>
Date: Sun, 08 Nov 2026 17:59:50 -0500
Subject: [PATCH net-next v2 1/2] dt-bindings: net: dsa: lantiq,gswip: add
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
Message-Id: <20261108-mxl-gsw1xx-reset-v2-1-46c1da093893@telaak.dev>
References: <20261108-mxl-gsw1xx-reset-v2-0-46c1da093893@telaak.dev>
In-Reply-To: <20261108-mxl-gsw1xx-reset-v2-0-46c1da093893@telaak.dev>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794178811; l=1167;
 i=joseph@telaak.dev; s=20261104; h=from:subject:message-id;
 bh=MOeFTVQJmsY5ws6zpmzjMuMLHXSYlILvnKcfHNWsxQY=;
 b=osGDcodit8YnTIe+0oCSL5ZBtLGrWLIaOrFzSIWFxkG7qnv2ShbSz72NP0596qN6ZkCXGbzLL
 TVqSLDl7euRDqyBhIKae7YPOdJbw+Mvm9HCkIMWsMSywrge1UVVTZLp
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

Acked-by: Rob Herring (Arm) <robh@kernel.org>
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


