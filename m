Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794312542;
	b=Xj2pYC5kEKGyrLn/RZF92XTryEHFp5Ntu0mx2MnB9iFYI0N5i/asCxtUMSweRzGfjxFo
	 gqloYLMHbEeCeJRF0thBPx5LNfP7RaGUws4Bpa8e5iZy+fLMM4Of8Mx2RskrWR73NVdrb
	 ArPFE3zZl9WV+vAw7mPVk9W6wQPhlXb49tGO4aU7NmOLJj2CMdTX2bA0K3OEHD93p5jU5
	 7BMAvyh2Vs3M8fQYU6YTvR93PWLKm7Mzb33KfHqpsW/rSBu2uDaCJI1AKvgWFV5etlE5Q
	 Stj8CgkGzlF6KUJDEftIaoAI1faOFloq7WLjgDCKoDSZLHX+/lPuUq3TaqTww5a/mfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794312542;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=fOFRdn7z24nh5HHdH+lcQ22pYuvFi8+a4KYRKJ+WMTc=;
	b=EUsz+wlOEUTmf+A1k/uX5aEAEy87rBjp05JGmkd6FBJtcEp82J7ZMIVDMOClR40/S1uZ
	 1yqjVTlHHDF5QgKr/6VWGRAOYI6dSdGBiD6QlWnApnuAxN6ZW+mP01XpCwUF6puSvVLgE
	 IEUsmTCD9uECkS+TM5WJ0VuNU4qyroi2uwfdeDxmDYGVtWo92JGryeiU4WdCpCrSfJLH5
	 5s/1nyxL3zfuxMcwfAUuV8gfRjg6/p3P6CF+RUmWAZ2Wk5BwF/LY/hZzyeVUBT64vfBu+
	 1RJKW4Kd3KJldf5BiKcxKViv3YxgcnY1fikcFz6ir4foFVLPk4bDenNsv4M8WERzwEw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=c3GHa2+1;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8CA60A3811;
	Tue, 10 Nov 2026 12:09:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A8CA60A3811
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=c3GHa2+1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1794312539;
	bh=tYsCCetG8oTk0mstJCHvbXche/Jiq/UwGP0ULa31RX4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=c3GHa2+11BmBBOuQ8GIVVV2EdY5LFRNpPEqG+Sd65bh7Vg1dChqzr5bSb+JMBr6Ue
	 DtOgje6DIBkf5gM6Y04AfbSWcGVZ3Mb2/ixb2YI2GmR4Jf28j4Z2Zx1Ob4E92Uvx0V
	 NclsUIp3C4YtCWC+Gou+TLc5uhxmtbOmpoKK1x9w+MiozgZZgFGX9pRAFPO4dxz5Q5
	 qXF2dqfnyYaJ9Ygzlm0+EudAztmq0FHEDl1CUoTcT/q/H86aoQgX3jcCIwfyD8uLfu
	 8o6uHAUMtUbAWxI1iSTL3tRW9W2NvIjD6b2yHeettBNFK3cdTZfYsEE8QrnVKjuo/P
	 K/OFAM9k0PZQA==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id E3AAC17E0311;
	Tue, 10 Nov 2026 13:08:58 +0100 (CET)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Tue, 10 Nov 2026 13:08:48 +0100
Subject: [PATCH net-next v5 01/10] dt-bindings: net: mediatek-dwmac: fix
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
Message-Id: <20261110-dwmac-mediatek-mt8189-v5-1-7d99d6292962@collabora.com>
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
 Andrew Lunn <andrew@lunn.ch>, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794312537; l=1905;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=tYsCCetG8oTk0mstJCHvbXche/Jiq/UwGP0ULa31RX4=;
 b=Vmf531z+jzieeklTIFtqbhu4kmoYXsK84c/9JuEtdGQVrM1zGWCQ6XAL0knA0b0OABWB/cwf3
 3JYdsIkkwVnClRdjZTJrlFUrQHDMp3bdXm8xxNU1BRAiBLZgeQioYwN
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

