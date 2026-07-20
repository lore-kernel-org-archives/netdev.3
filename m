Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9097D3D6CC1;
	Mon, 20 Jul 2026 10:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784541908; cv=none; b=RMXsnPo7nZUBjYgVCF9JukUUHcJgefT75PNmDtR+Bws8JyVTMYmoau958FW0+30lgoByBBeorTFvOy2yDc7YCufnXBYKNO0j8td2jOdKYkXUgze7jZ6LxGzTXQZNN0yzwPKTgkW1cErByH9DbV8ZWx9l2HSvuBUw1cnCdl015Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784541908; c=relaxed/simple;
	bh=m2yiWy5le2r+frQc8DgaYIgBdSKa3Pdp/bb9fJVyV0E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s9WHVcBv9NMPUQJL0MII5tdVoGq7DKvwtUoSjifIhqRChK+hmFUYz0DtglFhgBjkW1i9MGMsFT7Bav4HwsZklSFadznyerSnslF03E7BlU38L3mi/L/nT8wtnJFaj/DeUWi6fmlFbS/tpFwfaygi99w48fLdb6QLY5B9IAxpmUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=bQ7xI1qP; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="bQ7xI1qP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784541899;
	bh=m2yiWy5le2r+frQc8DgaYIgBdSKa3Pdp/bb9fJVyV0E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=bQ7xI1qPk6/UKGGy7qN4+hT5fiJQgE3m/DNeSOh5HjtVSO5chgQzsybeszbHWDoZk
	 wyFdPZHnDaJg7KZZBpVclVloq96aR3udUZy66r7o0bS3iiXQxNJkwjbdDi7S4IIv5M
	 JDt3yIeoeNS01AaUuuEU0eBr0AHfZ9YB3uyL3/VsQKksS+Mdlsk72vonSxOnaJIZNG
	 qrGzB7axiU8IiGuFsAmnRCohN8ys6TW83OyYg1fEeZEUccEV6jCgE26FLNMM9bp0mu
	 ZWL/RzPqKGNgHRkyiCJbXf3+FhSz+Vh2FlvgCIR7kE3/RQ+r8Ie8XDWIZmCCeFmUsT
	 wawvpg8y4TlXA==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 1EB0017E0DFD;
	Mon, 20 Jul 2026 12:04:58 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Mon, 20 Jul 2026 12:04:13 +0200
Subject: [PATCH v3 03/18] dt-bindings: clock: mediatek: Make '#clock-cells'
 required for MT8195
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-mt8189-clocks-system-base-v3-3-8e6d99ab3ad2@collabora.com>
References: <20260720-mt8189-clocks-system-base-v3-0-8e6d99ab3ad2@collabora.com>
In-Reply-To: <20260720-mt8189-clocks-system-base-v3-0-8e6d99ab3ad2@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784541894; l=1753;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=m2yiWy5le2r+frQc8DgaYIgBdSKa3Pdp/bb9fJVyV0E=;
 b=G8aCCCDpSAggfchH+maw3C3rwwYqsB5wMfUi8CZyMUkpVgo3xUKgUNm/Io45MIZZv3OnTyOcL
 SeP/1mLm7FIDwgjL5W1IE6OxtmlsR8DQ41djoL0S2VS6hzvCtLT+Adt
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

