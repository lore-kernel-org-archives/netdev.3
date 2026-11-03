Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700759;
	b=f7du+VYXPzWZSNpOcZJHxPO4jfWsSIc/1UgrUydq1gOf0Gzqunj8fth4K3l/uxICpNgN
	 s47f9G/ZHPhtmdG15kKq0zWC+IlDTj1CPMFZmRUNUU+dwK6HO+X8z1u2BN2XkP8kzFpgb
	 9+CuszdtmkXVg9JNI/faEJIGWyn+fVeRC9zE18P6a8fhNX0HuWKC+GnRvptkna+5nmnis
	 vWlkRGzKAf32GQq8zevgcbY965itAzbsJCiSYTRpe/PN0LhhvFeN4PSH+A6iXfZ1ZDZBo
	 m+GfJIKFHwjRY5+6sTTtKqUj2MqOuNCR2Zo6crMMmXvI9ybDKPfUOVkrZIdramtjmJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700759;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=fOFRdn7z24nh5HHdH+lcQ22pYuvFi8+a4KYRKJ+WMTc=;
	b=ObRYsFNcAAo1pRPd8RzRofmC03A9KwjuRtLhqppdFHzma4gvzzWNzNcNIIyoeCq0ER5D
	 PJABWTqlLuJjbz+EivT8sobTGJ/CBPkK7AGi24uqO3TWiOUcp0V/HdDcv4qHPet9ZyWL1
	 a08ZeNb8tWj7FYIxUVs6TX0iLFhmmkNIPfPDR6Iag4e+Bg0a8HENVQyYiPpUoOrOjVrMR
	 HO4ihGZwI1iKvEhHBtKf7w1+/oOOl82h1p16jlqrc0ZYzXia5BlgxuLq98Hc0DOLcA6xR
	 BXL8YNyqW4Set2yAfQ+9zW2X66d2AZFDvF1GK8ZGJFhAjHhd+Hz6W/jpqPXsoClIonw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=NSSDyWVQ;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4985606A829;
	Tue,  3 Nov 2026 10:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E4985606A829
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=NSSDyWVQ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793700757;
	bh=tYsCCetG8oTk0mstJCHvbXche/Jiq/UwGP0ULa31RX4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=NSSDyWVQ+SboGPOtWWwHr3PRN2S/aTU/eEP+oi/EanOb0Rwe/9xnXYptalEHm06Ky
	 U6l0pEeykQmbsBK6DZv6h7w/c6oCnqMM5OPhvodX6vj6kIPsOkPLZsmZ5EGi4xpDaP
	 MQDesiNPKnUxuK4p5Zph4VwtdDWb9KgI5eevsC+E7X8QwNCy3cL7LeUoH85a2t7pa7
	 HGfogEib23D0P4UVvoyvLQ+6AmwJZxtvrZ8GO1BbKYeN/rSJKkF8LVIqH3FJ0w+kUy
	 HqZ74B0PCP2rRCAMXO6N3inqnPXIQmvH26DICGsgpRZsWVkNOybMVm5qOINp4mvuRs
	 MozeYC363JUKw==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5AA8417E0C0A;
	Tue, 03 Nov 2026 11:12:36 +0100 (CET)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Tue, 03 Nov 2026 11:12:06 +0100
Subject: [PATCH net-next v4 01/10] dt-bindings: net: mediatek-dwmac: fix
 unit in rx/tx delay property description
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
Message-Id: <20261103-dwmac-mediatek-mt8189-v4-1-c86c14fc50f4@collabora.com>
References: <20261103-dwmac-mediatek-mt8189-v4-0-c86c14fc50f4@collabora.com>
In-Reply-To: <20261103-dwmac-mediatek-mt8189-v4-0-c86c14fc50f4@collabora.com>
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
 Andrew Lunn <andrew@lunn.ch>, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793700755; l=1905;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=tYsCCetG8oTk0mstJCHvbXche/Jiq/UwGP0ULa31RX4=;
 b=ePQymgEkZO2DRGZYIf2qdWHWB4kTcaeUKSCw7o8gZIAiRyUoZvlIoTj5ZBYOpvIjwQ6JXLFD8
 4G/DBJCQ7JtAMxLkykdBIedOgP31m2IFdoyamjwgumXL0ugUEMrJzJm
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

The "mediatek,rx-delay-ps" and "mediatek,tx-delay-ps" descriptions say
their values are in nanoseconds but their names with the "ps" suffix
suggest it is picoseconds.
They are in fact used in both driver and devicetree as picosecond.
So, modify the two properties unit description to fix their unit.

Fixes: 150b6adda6b1 ("net: dt-bindings: dwmac: Convert mediatek-dwmac to DT schema")
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 Documentation/devicetree/bindings/net/mediatek-dwmac.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/mediatek-dwmac.yaml b/Documentation/devicetree/bindings/net/mediatek-dwmac.yaml
index 3aab21b8e8de..14f9683f20fe 100644
--- a/Documentation/devicetree/bindings/net/mediatek-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/mediatek-dwmac.yaml
@@ -81,7 +81,7 @@ properties:
 
   mediatek,tx-delay-ps:
     description:
-      The internal TX clock delay (provided by this driver) in nanoseconds.
+      The internal TX clock delay (provided by this driver) in picoseconds.
       For MT2712 RGMII interface, Allowed value need to be a multiple of 170,
       or will round down. Range 0~31*170.
       For MT2712 RMII/MII interface, Allowed value need to be a multiple of 550,
@@ -91,7 +91,7 @@ properties:
 
   mediatek,rx-delay-ps:
     description:
-      The internal RX clock delay (provided by this driver) in nanoseconds.
+      The internal RX clock delay (provided by this driver) in picoseconds.
       For MT2712 RGMII interface, Allowed value need to be a multiple of 170,
       or will round down. Range 0~31*170.
       For MT2712 RMII/MII interface, Allowed value need to be a multiple of 550,

-- 
2.56.0

