Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384672FE042;
	Fri, 16 Oct 2026 10:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146721; cv=none; b=eu/f8Z5zZUVVl0zAN7aPOdNyu2nRKsxyIqMik8wXrXRDI+0mrvvYuH6k1IxjHzw5/65PjsBVbSAuFrBwe7Ti+oxMAV32uWhxlITbRNTFU/GH3KGmg8j3so2jsvxmpfcXzqNjD1RY8ve/EyIyjXoeIC2EZ/K6PL1F08ZOpzD/uW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146721; c=relaxed/simple;
	bh=lG2vCtPPSlLu5VxC3eKEiovpnrWmPRAG9ZOmwU3KX0M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Fbw/4zeVMximztcahC69lth1qR3dpXfNSDhg6j36YV0ONn4iH6Rc7wkLoJiCreXGw1ADxvBxZZ97J6uMj5Z+zypTxjYMTXBFc/6z1nDnyhBguagOHedUqx57IqnK64YghA9qzH3/J9B+VFTTP8+SXkVDI61eiPd/O3XuS6B2F0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Bf10P6VS; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Bf10P6VS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1792146718;
	bh=lG2vCtPPSlLu5VxC3eKEiovpnrWmPRAG9ZOmwU3KX0M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Bf10P6VSvCyVQI2C23JB4Kj7sQJOR0U/XZX1rkbq32k/bvv+2PQ5EnuWqazqzkOwR
	 D2tyjx+xPvRI16Fn0MPbMLQW7/89A9c3TzDTsPnfHLM66ms4O6J5/ow5XVG39Ptebl
	 1NIZACHGuDBlMq2GeC1aPfpSqMCghzShFj4e4HFAOz+3u4ikAJG9LiM1FTfx5imWMP
	 2rtSLYoW4pUnzYk6ZNvVYWv+FjdMeCTWr8O7001qmJdihLTo0enqxM1ZTXikHfPDl0
	 HbHUdwHgZ53akwKX7GJXWZ+zayHwjPrMuL8kxhmu/Dd1QcRUELe1amJ0m/pAZO0CTP
	 IxAdFbi/4+OaA==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 802F817E0539;
	Fri, 16 Oct 2026 12:31:57 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Fri, 16 Oct 2026 12:31:05 +0200
Subject: [PATCH net-next v3 1/9] dt-bindings: net: mediatek-dwmac: fix unit
 in rx/tx delay property description
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-dwmac-mediatek-mt8189-v3-1-25daf2bbcf35@collabora.com>
References: <20261016-dwmac-mediatek-mt8189-v3-0-25daf2bbcf35@collabora.com>
In-Reply-To: <20261016-dwmac-mediatek-mt8189-v3-0-25daf2bbcf35@collabora.com>
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
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792146716; l=1792;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=lG2vCtPPSlLu5VxC3eKEiovpnrWmPRAG9ZOmwU3KX0M=;
 b=SG+788vjuS63RFrLd9GgC2y/0FfuOkhVfyjINYRg3QxrqqOAuqHtT0amj9yIe3qo8SOHuRUDj
 gbGX7vNkgUjC1ASioPRjr6ivxx/r9FjGIm/cgvx1ECZ72dLfdJykVdB
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

The "mediatek,rx-delay-ps" and "mediatek,tx-delay-ps" descriptions say
their values are in nanoseconds but their names with the "ps" suffix
suggest it is picoseconds.
They are in fact used in both driver and devicetree as picosecond.
So, modify the two properties unit description to fix their unit.

Fixes: 150b6adda6b1 ("net: dt-bindings: dwmac: Convert mediatek-dwmac to DT schema")
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

