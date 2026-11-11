Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794409668;
	b=GG1zzn659vgv16AwcYzFwZNWvvTOcmUxx3OBNv9JZHOHkIWOrUgf7MFY4lGpHxozKPRS
	 xgdZwVHGDnPSlhBF5CVYb0ttiK1tio8dQVblDcygVGKP2HTN5LQAJV+dD3zatzejJH2LU
	 cyBLolgTRv94q3hX2jDTFGIOYVz3ALXOTom3Oc5d8Jd8MNpq/a3LVcXHCoPxQjH7T5RnA
	 AeD6s6be4RQaxAgObC6LIMKDZ6IqGSjyeo+qc+CPskwP2nrIN1SFPsm4zYpbvNCLRE0u/
	 /e4vC0FwYep+4dU1fP58ofMiiU4+EPasSG5Sy5olAa6+yi5DWdrH2IA0JpAP/i8tfyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794409668;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=0xmcEkNO7u7/9PKNphOLiy7umGDn2shs9wyqvnz7GwY=;
	b=Fj49VSHQkAgFF5qaLWZIcQ8kyjPdldgylX0lzW2TPhtug/R6Dkkf29SyNj/g92neoB77
	 CYjj3VuXn3OJyQay69fBq7lVWZd8f10mmNL6lxefUgci06tU0qAqSeyYifpGPbs2W2cOu
	 gpCw2Sq6As/8MqtcOo3yZ2KDlzDU+lx6BACRRhsyqLB/6Ro8zrPtQxVGUNxQFQ/alvh0Q
	 kWRbaCaPf8OQ9ZdxDZ2iMP91Q3NB1iO/pOyHEaC+/pCUoV7FepdvuwKyD1RYsHRzFkEO0
	 XwiaGdFMGeC6v48/RV17hpwHv7LpvFsNuPFa3uhQaCV8Uldc+AWHvCn3tV6ZOUp+Y3w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PxiUHRu3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62444606A890;
	Wed, 11 Nov 2026 15:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PxiUHRu3
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794409668;
	b=0sjEal9xTXtF6xe1h2HDYymcMbPhjA0sw6Bgy3aM7lWTRN+2ZuXjYw6sU9nnJ/759NuR
	 1inHqOWSfVpUVbi1pzV5YUtbERiHvMmXb68kkFcgeclzRakXPW4ewfW+06BB42iwoge7T
	 /z6aQRiFquBVDxof/XkDpKzFY4AS/+iJHvBVO2aF6SoQSI1HvGJBedDWMVYSyNyCstXFH
	 JheML7+LJndyijXW8Q5wNxy/yOlfpcEfPKn/ZYSbEf4x57Gywt83U2IKRsTvEkLdEvzl9
	 HgbPFxP2OAeoOFS8TtzZPYh8Vy8YQ1LG6EGbM1bcMUtqGoAq75e+x6N7CL+cgZtTFUg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794409668;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=0xmcEkNO7u7/9PKNphOLiy7umGDn2shs9wyqvnz7GwY=;
	b=u3oAsygItwAR6k52IgayZ5qTYG8eInDMMcY6fNtYsvpiSLLTdl113qqpjn4lRkB3a/Df
	 J66kFZAZY6U1eLGepgMHohjxdEeIHttdGHVRLBiYoVL1T9NuLiYAfCdrvW7O/4XLD6SCq
	 MiYOHOOEwKGD7MRoIPcmeqvn3p1FI//D5OsuE5B/bHhDNzfrY4jXdHev0fVJwNNgzxyFV
	 urjAqDYIU1azYDY0bMQ69pl2JtYkCd3PASMCLY3mLO3e9VL09swHLcPCWru6ckeOr33s3
	 sMFVR3uZdKV7zsf9jg+VBGTnvJJ3+ZOX5lKX0JM+y+PfQb81IKD3ioTaN4s8n/HEylg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9743E1F00A06;
	Wed, 11 Nov 2026 15:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794409668;
	bh=0xmcEkNO7u7/9PKNphOLiy7umGDn2shs9wyqvnz7GwY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=PxiUHRu3nHoD4PxZK481j8KWMWRCMNP6DYram3ZVav2m2gNB/HcEyIpZk8Lpp40KL
	 vuMqwQr1eKKZ+wIOf0FKzmhuaEtdcGS1X/taVQT8/Wu6uY7Q3dGMu3r1L7gABb1d2U
	 KEMJKf36+mpajCehfB3xexs90xf1fg7/difjrlX0fARxwy+XqOk0IZ/lv4/XzvqeSx
	 TTa5IMVAVCDBVV+gdZwuQz5rruUaOK/TTrALINNJs5tvRD3snEF/ukIe1SIGaGyUsX
	 V4E4Ugp4nYgY9LWUl600vMQnWaAs28JVVtdqj9liOqGeLjsv3RaLUjLAI+lP3mqQLb
	 ezMUC6TF0vjJQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 1959A48FC7;
	Wed, 11 Nov 2026 15:07:47 +0000 (UTC)
From: Asdlerto Korry via B4 Relay <devnull+korryasdlerto.gmail.com@kernel.org>
Date: Wed, 11 Nov 2026 17:07:45 +0200
Subject: [PATCH v2 1/4] dt-bindings: arm: qcom: Add Samsung Galaxy M52 5G
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
Message-Id: <20261111-m52xq-dts-v2-1-063289405882@gmail.com>
References: <20261111-m52xq-dts-v2-0-063289405882@gmail.com>
In-Reply-To: <20261111-m52xq-dts-v2-0-063289405882@gmail.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>, 
 Tony Luck <tony.luck@intel.com>, 
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, David Heidelberg <david@ixit.cz>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, oe-linux-nfc@lists.linux.dev, 
 netdev@vger.kernel.org, Asdlerto Korry <korryasdlerto@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794409665; l=791;
 i=korryasdlerto@gmail.com; s=20261104; h=from:subject:message-id;
 bh=H56IcYVSNo0wgt3tuO8OiTWa9f7y69coL2KlUgR93oo=;
 b=c5jtXCSZpUzuCZUk/jg1jy0vVp74CDnkop3QLjilgNHGmfRwyu57zFaeEnhqQqkt1keQV8Ogm
 Cdd/8ifLAFfA2IZJAlrrvLDLdojNtOgrAp9mYhgjWf3iNmz/N4NO5+8
X-Developer-Key: i=korryasdlerto@gmail.com; a=ed25519;
 pk=RqttIGkm2XZ8NhLQBzPgpXXawOdVa1uODGsk+sagbxs=
X-Endpoint-Received: by B4 Relay for korryasdlerto@gmail.com/20261104 with
 auth_id=1411
X-Original-From: Asdlerto Korry <korryasdlerto@gmail.com>
Reply-To: korryasdlerto@gmail.com
Content-Transfer-Encoding: 7bit

From: Asdlerto Korry <korryasdlerto@gmail.com>

Document the Samsung Galaxy M52 5G (samsung,m52xq) smartphone, which is
based on the Qualcomm SM7325 SoC.

Signed-off-by: Asdlerto Korry <korryasdlerto@gmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 121ca557ce1e..fff2be0ecb47 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -1124,6 +1124,7 @@ properties:
           - enum:
               - motorola,dubai
               - nothing,spacewar
+              - samsung,m52xq
               - xiaomi,lisa
               - xiaomi,taoyao
           - const: qcom,sm7325

-- 
2.25.1


