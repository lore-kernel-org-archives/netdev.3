Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.251.105.195
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793700760;
	b=kD8RZ43Qoz1E86Gmz1zJn6tXA51TPbPN/rhNHxOe6sr1UvAPyoP6Dhn+8pOLS1Ci9xFR
	 Y39tU5/qwzGUZKE6I4Adf9ci2L1bTpsBBepYSbgk87w3Nngl09KNkXBAJIFU+WygoN50y
	 tmN2rEq1H6AAG/tGbszk5bt3rt/886ZsKKNDOVj9mb0uqeun85oX3HCkAGFR/dpba5a76
	 MMhXr98ekxdrT5hGg2DdejqLvRF3N9zQPUhKOHW1xOAArQ4kstOfvRW9LBeVMISfGgLPR
	 U/icRmJ9lTRN5nDv9dm81bCH8m5UyglaqnEMF4NTptpVmxJ38RPZpMXPx2hZcQtLolA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793700760;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=cAJcK6wWXyswA+ys5mhuqkoXL9U9AnrrgIBwujtRqPY=;
	b=K+1s3AYBmpdnAxSYdhTaIwPGwEgv6qAjXMIDpVq6o+00DzsCE4mbq9h0+Dq6toLVMj/+
	 fCAPe0EextEQSApNuevx+8Rwcfi9WTh0NsOd7Cn2y8LUnzhz5UqC3nqWAAT6JUTkWLabr
	 /9Z+R5tC/dlNFPhI4XxIAIBsyWPa0ahK/6VDnL7SF8LuPdRDU+m+M4zWbRdZoJK8D/UDZ
	 JkiSfiRKz4bW4GBKuwD5X4NqU0sY9to1tJhl92IRV26A1U4V/V7oXSWZBLfjRn7amHVkX
	 78qBgJZ7FlNGC6Kcekf+tHv8V5JZKFZ6I6mHgv46aZ5gU2gc8ThyXLbT2knqc6TArLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=collabora.com;
	spf=pass smtp.mailfrom=collabora.com;
	dkim=pass header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=dKEWj3bT;
	arc=none smtp.remote-ip=148.251.105.195
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF436606BFB5;
	Tue,  3 Nov 2026 10:12:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EF436606BFB5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=dKEWj3bT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1793700758;
	bh=9btp8D9CPqLhI6r9B18vL4l7TPjBWaSIYvAxgmvmR6c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dKEWj3bT/58KDBwd/Z8OpjUvDEx6ZjdQ0FbFeEf9w/dF0r94mgic1ld59ib3uO3rd
	 dJpT7qUluCDn+OyjMnCARsqs4v6UVRh09TEV1DuZc7B5Uat692H0xhziqywu1GSeCH
	 5C16AZZi09uOt41nq+DeyL1W7ygCPO9wm9P9gcsGuy53LaZkZZu111yqHvt8Teohl3
	 OXKqPZsFbSxdEZTvrcqKk2PnYkLxNcutv5Fx7hs7KybwRIqMeKPc057ZDZzbXvf8/J
	 4WVvswzqRMWQgpZoglVxj9fvgA15FnOG7kqCyKblGFW34iAiD4DW7LH/B3bmqXG/sf
	 d3f53IewUPPCg==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 81B8C17E096A;
	Tue, 03 Nov 2026 11:12:37 +0100 (CET)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Tue, 03 Nov 2026 11:12:07 +0100
Subject: [PATCH net-next v4 02/10] dt-bindings: net: mediatek-dwmac:
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
Message-Id: <20261103-dwmac-mediatek-mt8189-v4-2-c86c14fc50f4@collabora.com>
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
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793700755; l=2297;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=9btp8D9CPqLhI6r9B18vL4l7TPjBWaSIYvAxgmvmR6c=;
 b=cVxeY2ot/J+KDZxhQ7Pu1JpngY4IuWiFHFH/axsmnfTUmosKScVBrnx6wzkGfUkAfwjhzmyzc
 tx/3J9kpfMYAMUKkYy1r+F75Crm7QnmHHLi5nMNzBSH8VWNs3DbTRrW
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

The mediatek-dwmac bindings provides the 'mediatek,rx-delay-ps' and
'mediatek,tx-delay-ps' vendor properties for describing the internal
RX and TX clock delays.

The generic Ethernet controller bindings also provides standard
properties to describe the same kind of property with the same unit
(picoseconds)

So, ddd deprecated flag to these vendor properties and update their
descriptions to tell to user to prefer standard properties over vendor
ones.

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

