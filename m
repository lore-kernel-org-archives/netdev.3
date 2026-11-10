Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312543;
	b=xscm1MNPJAF+IaX6G+EodCiaBCsPIybidEtizCamF7hdD9+QOVxLJJ5dRwW/vABW/2jZ
	 MUPcSF/0ya2ShmJvpqFScSFZZg15K1IpGRHrtEVNYe1HmL1TiJyN2GAyxQeI4sUL2SwX5
	 MWw/wynfKPj4mpvSn0PPqCbzBSXq1WKABjZeKGFvAKN+fuvE1YjseLlx9vI2fZzQWyR2N
	 PkIF2+eZIVQHcoh06NGLBowDGWzSam9gzz86mvJwdCZ22fjGdFmZi7PpdzJC3tDKrHlbj
	 IvQFw5dhIHz56VpCzc39fu1/nVkd2DHsG9w28SBOKnso9HMiq6rmoINWbT0zpTSpQEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312543;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=IxhCvfJIBJyaA2ATxGs3fIk1vG0uQA62+MwfTqo1X0M=;
	b=yVWtNvGBIaNEOf+7COis7jqSPYSwzDmvXpxMxkAf++ASDGwf6MA91i2xbkQLtc6RnUIa
	 whspnsBhjR/yBHPgKJZPFymnJ2gDEbB/pY4g2N4QSr1/n6z3ataKhcToaSe5VzZYwYhV8
	 wwkorWeWMgbMnY7y5bovuaOTzUuKRlYz9Y7c4qDDcTllrrYIkYO7T7rf5fD44QHg/Rxqj
	 z1wKCEt9dKLEabQZqZqGIvI0ZGedGjmPJbx3LU1E7e+QQX4Q6h3q2KmM3UDvRXnaJIHCJ
	 iI4LYXBAdGbb9L+PZ0Wbxxbf2xWVtPJ8mzOcmVw4q7bCNZowSZQgax3EUk3sbZqGLow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=k0SFM+Gv;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995A560A3820;
	Tue, 10 Nov 2026 12:09:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 995A560A3820
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=k0SFM+Gv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794312541;
	bh=pc0gMmdXl/8SnyaG/cc7eHGzGbww5CJsVOxiPSb3ZG0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=k0SFM+Gv6dQieIs/4KcXVYUw8f0rvjSKjIpzcYwEgQPIMIPRzmCC/PyaUajFj0zzL
	 l08NMrI9z7Rec1YtfQ+G41byOpFHX4G7oUjpBudV6lrNKum5eA91B1UFMxVEimRzsB
	 zFSzDMX/geVAk40K2qekwyqBqhFRrma0DPGu0Nour2SEfQenBMsd+sIY7M8vDyn26Y
	 ndlwjV1lN1I1elUgpQH2P0EMOhV6MomMKbYOnEU6dw4/h16Uw+GdzqasUj2gFfLDQ0
	 sLahN35HOQV4rr3TIMXMLNacFji4NmRIZ9PdnEVBT1vWZwy5K0eE7xtROGQQBfYR9/
	 QPZzt+RuX3bgA==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 136BD17E09AB;
	Tue, 10 Nov 2026 13:09:00 +0100 (CET)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Tue, 10 Nov 2026 13:08:49 +0100
Subject: [PATCH net-next v5 02/10] dt-bindings: net: mediatek-dwmac:
 deprecate rx/tx delay vendor properties
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261110-dwmac-mediatek-mt8189-v5-2-7d99d6292962@collabora.com>
References: <20261110-dwmac-mediatek-mt8189-v5-0-7d99d6292962@collabora.com>
In-Reply-To: <20261110-dwmac-mediatek-mt8189-v5-0-7d99d6292962@collabora.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Biao Huang <biao.huang@mediatek.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Eric Dumazet <edumazet@kernel.org>, Eric Dumazet <edumazet@kernel.org>
Cc: kernel@collabora.com, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794312537; l=2106;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=pc0gMmdXl/8SnyaG/cc7eHGzGbww5CJsVOxiPSb3ZG0=;
 b=4pVR8gdOK+gDzLPVy2w47hx8D9Hlwyz0LnuMLtD+uej6gZaiVAqYTOgBkdrU7ssMlVcvL+ds+
 NH4HcA+2lulDnYd+xO9gaCeeZlfRLrUepAXE25crSv20whyZYjl2VHI
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Deprecate 'mediatek,rx-delay-ps' and 'mediatek,tx-delay-ps' vendor
properties because they duplicate standard properties from generic
Ethernet controller bindings and have the same unit (picoseconds).

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 Documentation/devicetree/bindings/net/mediatek-dwmac.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/mediatek-dwmac.yaml b/Documentation/devicetree/bindings/net/mediatek-dwmac.yaml
index 14f9683f20fe..956240616638 100644
--- a/Documentation/devicetree/bindings/net/mediatek-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/mediatek-dwmac.yaml
@@ -80,6 +80,7 @@ properties:
       interface and timing delay.
 
   mediatek,tx-delay-ps:
+    deprecated: true
     description:
       The internal TX clock delay (provided by this driver) in picoseconds.
       For MT2712 RGMII interface, Allowed value need to be a multiple of 170,
@@ -88,8 +89,11 @@ properties:
       or will round down. Range 0~31*550.
       For MT8188/MT8195 RGMII/RMII/MII interface, Allowed value need to be a multiple of 290,
       or will round down. Range 0~31*290.
+      Deprecated, this property should not used anymore for RGMII TX internal delays,
+      the standard tx-internal-delay-ps property should be used instead.
 
   mediatek,rx-delay-ps:
+    deprecated: true
     description:
       The internal RX clock delay (provided by this driver) in picoseconds.
       For MT2712 RGMII interface, Allowed value need to be a multiple of 170,
@@ -98,6 +102,8 @@ properties:
       or will round down. Range 0~31*550.
       For MT8188/MT8195 RGMII/RMII/MII interface, Allowed value need to be a multiple
       of 290, or will round down. Range 0~31*290.
+      Deprecated, this property should not used anymore for RGMII RX internal delays,
+      the standard rx-internal-delay-ps property should be used instead.
 
   mediatek,rmii-rxc:
     type: boolean

-- 
2.56.0

