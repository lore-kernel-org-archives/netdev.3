Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D14446C01;
	Wed, 29 Jul 2026 10:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785319396; cv=none; b=d59t/g4eNRRm6gkXi5aJ2cq4DuL7pze9r4XeurH3ydnaju9hGwy9oWd32VnbTjGL+iF1dsxYjchcoBIg1wrTn/wtDfQFYySZfhGcwMYy32+qq1mjjcazHXMllyHhFf4jlcqestDtKVg3pWNPk+1UNxdx5ioNryxw1M7/IqXaO8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785319396; c=relaxed/simple;
	bh=m2yiWy5le2r+frQc8DgaYIgBdSKa3Pdp/bb9fJVyV0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U+wfBFJ+fNZF8I5w/NQtHANSu4SZSRfrqBQeXD5GF5LlN13/sJn1Y/M/Q36MAn0gpW7YO4+7G75uxvITZVK+rpxn1udGYTAePqNwbGDpsZ0VgJLECsdfULu6tvxIvKiwQ7Pu1UBDZQlZf/akDp0wtaH+IGHxDyxjlja72Q+bYAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=VY0l8tyn; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="VY0l8tyn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1785319392;
	bh=m2yiWy5le2r+frQc8DgaYIgBdSKa3Pdp/bb9fJVyV0E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=VY0l8tynlr8jEvsom93vAtzMs91Pp3GcClyFC6i56yG9BDhrcsGG21m1KqU+jott3
	 J8zDqQiKI4Uu9vJ/qdaM7EDQ7cs6pt+qnb/+Sas3drk1V/X5SA3Qg5PmceZPvguVMG
	 p/3vPD5X386ploer8ByoTJAwaR06Sb2DjRzteg74epbUj7qV5XjhuSkvHBNK7MNnMd
	 DlLlEUxGYRqHKuxZucKn7K3cj5ENgArzsY2cY39CNVIqRyg+naEVbPc1dqrAl3LkqE
	 t2o8UL6WjJTFasUug8Z2al7OBuUtOMh5PEs7FdBgdw+GvdsuLS/1AicLk+dm2C/c1c
	 gxF69LBMKixUA==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DE49B17E08A1;
	Wed, 29 Jul 2026 12:03:11 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Wed, 29 Jul 2026 12:02:47 +0200
Subject: [PATCH v4 03/24] dt-bindings: clock: mediatek: Make '#clock-cells'
 required for MT8195
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-mt8189-clocks-system-base-v4-3-e356b813a64c@collabora.com>
References: <20260729-mt8189-clocks-system-base-v4-0-e356b813a64c@collabora.com>
In-Reply-To: <20260729-mt8189-clocks-system-base-v4-0-e356b813a64c@collabora.com>
To: Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chun-Jie Chen <chun-jie.chen@mediatek.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Edward-JW Yang <edward-jw.yang@mediatek.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Chen-Yu Tsai <wenst@chromium.org>
Cc: kernel@collabora.com, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785319387; l=1753;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=m2yiWy5le2r+frQc8DgaYIgBdSKa3Pdp/bb9fJVyV0E=;
 b=M5BnADea/Tgy6H7gXKU5l45XupEPdKnzuQaCl5Qz7OgKKMkb753adKx2p9qCv3lpqgrVSPunR
 RxKcsoNe1uqBomP4+/awl1kx2X2UYmbxew8XnBQ2JhQASx6il1tkZ4J
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Both MT8195 clock controllers dt-bindings (clock and sys-clock)
document the '#clock-cells' property but do not enforce it as required
property.
As clock provider nodes should define this property in devicetrees, add
it to the required property list in both its dt-bindings files.

Fixes: 34d3ed3b9a00 ("dt-bindings: ARM: Mediatek: Add new document bindings of MT8195 clock")
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 Documentation/devicetree/bindings/clock/mediatek,mt8195-clock.yaml     | 1 +
 Documentation/devicetree/bindings/clock/mediatek,mt8195-sys-clock.yaml | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8195-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8195-clock.yaml
index fcc963aff087..94dd29c2396c 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,mt8195-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8195-clock.yaml
@@ -58,6 +58,7 @@ properties:
 required:
   - compatible
   - reg
+  - '#clock-cells'
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8195-sys-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8195-sys-clock.yaml
index 69f096eb168d..ba1b36fa0169 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,mt8195-sys-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8195-sys-clock.yaml
@@ -43,6 +43,7 @@ properties:
 required:
   - compatible
   - reg
+  - '#clock-cells'
 
 additionalProperties: false
 

-- 
2.55.0

