Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F3B8382290;
	Thu,  9 Jul 2026 13:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783604581; cv=none; b=SW3vv13Xk7TY3Eaq+El6KRMcAlwZv/8L9oVlzDt+aqkcsVQX2A0TQxEa7CTx0L+lnTgZeywMgrCX3nGeP7cF3J7vKzS6YcFvo1TvB+tTIPJy3eYmrwejX1QPD47Gso4HYa3Wrexy5wR9MsFBTQAz01kV9rWtiUdTXLAXDjlBWc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783604581; c=relaxed/simple;
	bh=EmivhbHKuxI1EhBj4UtsXL6Rlu02NGAsahKJ5u1px5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g5OO9aSpi8yjlSNTyi5qRBo1ezx0HDWP28ETFoCgYm8m2+RZd0bVR06OG26riF5dFQY/YuPDKQPKVoDSQXJYJ9I4IUjsgn3xs0o3SEIlS2wJDumZ/lqEafgz3RtCBqg0R1Vx6TwzUXNjIohMjWEs4yDMnh1GzTZftPNDrM9Fdbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=Tic36G9a; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="Tic36G9a"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1783604578;
	bh=EmivhbHKuxI1EhBj4UtsXL6Rlu02NGAsahKJ5u1px5k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Tic36G9a2eOtoQA+0H3D0A7TWHAml8yb0UZT1NydRiIl5wFSoZterG6Vi5bhKT/qy
	 kMdj1mRBJzPBhEUCVnXyvpLs0vLv/w6IW67GRawhl7z3Z8WaKZHycxXtrq+xV81xID
	 63BjWbx026UZXnB3gyq85Jbew2E2CltPH9+DnaSj9G32ib0924WsVbGk4udxkZorrO
	 OAgLOIUFR7j7fOhcYQW83Dk2JEYK9IgcCC48SSiet7pk0IaGiLAlpuPL3t4/XgzU1S
	 2Q16Xsg/e/4ExFVzhiIams3bUjQkzhQSgjdBg/qyEiA4R0BA5JI+tvwsSdsmJDPX2H
	 nq/dogY1yIhFg==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8632A17E0D56;
	Thu, 09 Jul 2026 15:42:57 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Thu, 09 Jul 2026 15:42:42 +0200
Subject: [PATCH v2 02/18] dt-bindings: clock: mediatek: Make '#clock-cells'
 required for MT8192
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260709-mt8189-clocks-system-base-v2-2-2926da3db6cf@collabora.com>
References: <20260709-mt8189-clocks-system-base-v2-0-2926da3db6cf@collabora.com>
In-Reply-To: <20260709-mt8189-clocks-system-base-v2-0-2926da3db6cf@collabora.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chun-Jie Chen <chun-jie.chen@mediatek.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Edward-JW Yang <edward-jw.yang@mediatek.com>, 
 Richard Cochran <richardcochran@gmail.com>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783604575; l=1522;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=EmivhbHKuxI1EhBj4UtsXL6Rlu02NGAsahKJ5u1px5k=;
 b=mzQEoIeUQnQNGfk2ogYzX2QA2pkubCyg23uf0RJcpQ9g45eyJxyhNjBv+BbY4EvGZGTkCo/Yq
 tZJ9fsGHfOxC7bATqTTc0Yn4M1Bs09/tOHi3xr9Ce3P30zFIwSLUoZK
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Both MT8192 clock controllers dt-bindings (clock and sys-clock)
document the '#clock-cells' property but do not enforce it as required
property.
As clock provider nodes should define this property in devicetrees, add
it to the required property list in both its dt-bindings files.

Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 Documentation/devicetree/bindings/clock/mediatek,mt8192-clock.yaml     | 1 +
 Documentation/devicetree/bindings/clock/mediatek,mt8192-sys-clock.yaml | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8192-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8192-clock.yaml
index b8d690e28bdc..65e4c2fddf5b 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,mt8192-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8192-clock.yaml
@@ -46,6 +46,7 @@ properties:
 required:
   - compatible
   - reg
+  - '#clock-cells'
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8192-sys-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8192-sys-clock.yaml
index bf8c9aacdf1e..0ebd0d60e2f6 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,mt8192-sys-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8192-sys-clock.yaml
@@ -35,6 +35,7 @@ properties:
 required:
   - compatible
   - reg
+  - '#clock-cells'
 
 additionalProperties: false
 

-- 
2.55.0

