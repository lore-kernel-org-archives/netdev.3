Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794504351;
	b=3Wtsixswxl+j6UiqWKvs4i1wfJwO8sqVYwKhl6Kmz7aIKbOMgxNMNAT97a0VkVvKP015
	 UYYJ+CYvblho0sP/hvem7VoHv/PusN94VgwoXm++2bh26cw+vxK+JPL65h2esmMk6gyTc
	 QERLGx5WcObovCOJPNkpYRx36hZpCoHIiV/aq7RMCcjjkOzv2qgA5jn7ujvGMKIS+jMIt
	 x8x/D4GBzcxXOeue9VIXSedZL033TjGsxb0F06+NH/jU+7xCLLnL3w30r+vQBeJBa98Bi
	 jQTrH544nI++5BrXXqyTwi+wfVRgp4mLbLQCU2tV6F0zVHLkLuXKvE7FMfweTQ+M4QA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794504351;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=bJHVQy5huoI+taeLYsi+HT7KEQiclPfYD5HjpFT1cIk=;
	b=HrVGvNFagWjLBX7Kwo1IR/pCdoecrbry9yHAP6vh6WjpR+4b0o299vBHgNq2U2zMQu4m
	 CG6XMALP76ZLh4Llh6p6W4MS4VQ03WfGhyPwVQoB1OtEktSaE6qBA6nX4nKq0L+1mHX30
	 QB84a9/EI9aYkR3TKasnfm7esNEHN5kOgttCWa1452BIKj5IoPfvr3uvkvxlkJ92bY6Tx
	 n1axEil68IUwhHormiK1XfMfjQP89P8LvbSCX/w5XQ0bYFtm0jCFI2jaUXKFW0Lo0IEq2
	 3FRSm9b+DMJKJUBrVdwLVDGP9qfoTVhsOIDtmp4FLawbD2ry0a+tFfQ455QhKp2SyyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cjHolHDu;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 709E9606A321;
	Thu, 12 Nov 2026 17:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cjHolHDu
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794504351;
	b=xdJhglQq3LW44sWVSFdtKIcf1fsuZYhME0BV1fBflVf+J+cAKhqIntCY77n+XEQ4khU0
	 OXpqpkVJBqJihUM0fXq9wLIgG090W5uclhx3OQ3/3VOm+eDCOed+9Rm+8Gh6Rjbrgtsuq
	 7WQqaAxdycouDFFyZ+ujtNMi7sQO3n4netU8O+QXDoKvzkzS3iKHl2xV8pgEJz3CT6VbE
	 VJvwbvVeVvUmo49dwf7gYcu9pqbhHz5czgTb7e6C3mp45QuSOdoqOjivtRHyfxwhLp1UI
	 TZsdydD+DnuZPIp/xuDquMc9CHvdjdDQOp72YDtiFAPxIenTbbh5gtCzv6gGOswVDFQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794504351;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=bJHVQy5huoI+taeLYsi+HT7KEQiclPfYD5HjpFT1cIk=;
	b=eHIPagVbtZ3EJ9vscyv/TP9AOpKtNwTmojeEZcqRCK8UYUF5sLIe8j5BbZG10KxtGwh6
	 Gm3chv0fqILmAdE53DReohsLvSq112zNMLclH7kMe3E1qeO/XK8c+tHxkX+H2H3Hyk3rN
	 jz6CkJgbSq2g33OOB4UdHW9Y3J1IAx+MZCtaA0NbhLtSbyVZg+sf55gVgwSJ3w/tvqMD8
	 PUWoH818eXhQLuNCwayRMoy1VNiggY1i1EjrJr4mOjWMjFHAny0zAgszqIdDJdLJ8hOPS
	 cn7FALPOjn0k2B5ZDqAkJ7BfTdBUW66+nMatACt8LELbf+pxCtBm64CkRfR/JTlURhg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 246161F000C6;
	Thu, 12 Nov 2026 17:25:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794504351;
	bh=bJHVQy5huoI+taeLYsi+HT7KEQiclPfYD5HjpFT1cIk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=cjHolHDuh/R0dMWTn8TO5cGtPZasvWVl0zlX/GXxLwcIFXi/ok0THdVhepCEKynQw
	 wyzU/IoM9yCr6uG6+0SiPfVAwdPmRzJEGmXDYGj9IXS80xCxJQGVaw+wwK9v/yo2eb
	 t605LvRHBWRg7WO2IUVH1s/G4OsEDbLG8GbdNGrBuBRDaVqwwldQzkXSZ1ZIT7QSGN
	 sP5e/2iONeiIsSUlfsGol9dwO3MmDnGUh/WdaNrwmJDIH+qzJN1Aaq5QFn7hg0PAzQ
	 rXe4a/0HxRDlfg7A8A/aU14Df2jeEJ6h2CcPb3Bzvoufpl/fkpCPqz/RHBQ3LR8r9U
	 op5SwrIuQSlOw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8E14B45A77;
	Thu, 12 Nov 2026 17:25:49 +0000 (UTC)
From: Asdlerto Korry via B4 Relay <devnull+korryasdlerto.gmail.com@kernel.org>
Date: Thu, 12 Nov 2026 19:25:49 +0200
Subject: [PATCH net-next v3 1/2] dt-bindings: net: nfc: samsung,s3fwrn5:
 Add pvdd-supply
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
Message-Id: <20261112-m52xq-nfc-netdev-v3-1-725a61ce4148@gmail.com>
References: <20261112-m52xq-nfc-netdev-v3-0-725a61ce4148@gmail.com>
In-Reply-To: <20261112-m52xq-nfc-netdev-v3-0-725a61ce4148@gmail.com>
To: Krzysztof Kozlowski <krzk@kernel.org>, David Heidelberg <david@ixit.cz>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Cc: oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Asdlerto Korry <korryasdlerto@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794504348; l=1338;
 i=korryasdlerto@gmail.com; s=20261104; h=from:subject:message-id;
 bh=zH+1as4NCY/dZ65WKSxZl8APKd4N3zG6ELlk34X29Gg=;
 b=vIZTPZ2ceGklPiI/sE2YKq81kKdtCavLG2dRIE+zRC+k6/VMD1hy28l0ND78DrMd0+ePmBBnQ
 1Fs/NGyuOoUC+cHZ0A6YSKgP76v3a0N+2S8psgM+HR99nZo3fAVOukw
X-Developer-Key: i=korryasdlerto@gmail.com; a=ed25519;
 pk=RqttIGkm2XZ8NhLQBzPgpXXawOdVa1uODGsk+sagbxs=
X-Endpoint-Received: by B4 Relay for korryasdlerto@gmail.com/20261104 with
 auth_id=1411
X-Original-From: Asdlerto Korry <korryasdlerto@gmail.com>
Reply-To: korryasdlerto@gmail.com
Content-Transfer-Encoding: 7bit

From: Asdlerto Korry <korryasdlerto@gmail.com>

The PVDD pin of the S3FWRN5 has to be powered before the chip is
enabled. On some boards, like the Samsung Galaxy M52 5G, this supply
is switched by a SoC GPIO. Document it, so that the regulator can be
handed to the driver instead of being kept always on.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Asdlerto Korry <korryasdlerto@gmail.com>
---
 Documentation/devicetree/bindings/net/nfc/samsung,s3fwrn5.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/nfc/samsung,s3fwrn5.yaml b/Documentation/devicetree/bindings/net/nfc/samsung,s3fwrn5.yaml
index 12baee45752c..3c5a579a7108 100644
--- a/Documentation/devicetree/bindings/net/nfc/samsung,s3fwrn5.yaml
+++ b/Documentation/devicetree/bindings/net/nfc/samsung,s3fwrn5.yaml
@@ -34,6 +34,10 @@ properties:
     description:
       Output GPIO pin used to enter firmware mode and sleep/wakeup control
 
+  pvdd-supply:
+    description:
+      Power supply of the PVDD pin
+
   s3fwrn5,en-gpios:
     maxItems: 1
     deprecated: true
@@ -84,6 +88,7 @@ examples:
             wake-gpios = <&gpj0 2 GPIO_ACTIVE_HIGH>;
 
             clocks = <&rpmcc 20>;
+            pvdd-supply = <&nfc_pvdd>;
         };
     };
   # UART example on Raspberry Pi

-- 
2.25.1


