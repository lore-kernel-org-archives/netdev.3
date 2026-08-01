Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2402D8DA8;
	Sat,  1 Aug 2026 11:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785583273; cv=none; b=mq3ZN9raVOAVMNOHc7pG22ngObplQ7U8pyNFvfTrSuc9BzxuepNbP4liDCSse6S1x1RbooiRJ0Ka3urdVOQhjm7c5QDRhXhDY07I/35EnBqHW0B/ra6myaAECVPe6DZJjXQ7g18LBdHyDTHdtc52Mu/cv9NJI7vtx7+ZNm02siA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785583273; c=relaxed/simple;
	bh=rp96vQvpmzcYQQQawuTsiCW9FJPQfixEXB6+OjlKWjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cB8Gklfv1GJ8KAAGDuhruc4pdZzKERykpnCTzxkv9wQEtx+gUg8SIiklHg0YWs2GQvEJLGYwAdEBr4W3OYQZUpU2Z8ovuPDkRfbq+9JmgJrKN+1h6zd/3fh4svluqh8t0JEl4pdXTVXjVgqbiFsOlJU7G4aratsG7peGrIyAlOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=i8ffjY5D; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="i8ffjY5D"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1785583263;
	bh=rp96vQvpmzcYQQQawuTsiCW9FJPQfixEXB6+OjlKWjQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=i8ffjY5DWRkkmupXxqRGCknEk/2TnQQ77qKzSgMo8T6w47mNh1jeyYQdPw+E4iwfx
	 bQKOmP+kVpqiGoxCCbK1sGMHwWpOm17u7P5F/dAh20JzRmViXtWmX9XoOa3Aljoi0m
	 IcobsWHbqxrk4D8/I79LJD8rOCGCc3YAcdYYjMp2vp7Z6pgK8Q03kPjB5v/ihdYK2U
	 6jntvZcf8CgsOjeRQrN9Pyzw0KC+x4gxLcIywNecec3d81YVtn4y1bUrthsA9AASfb
	 2kf2PxQHzTwy43WaRw8sIT4Dsf7HuEsXHruzloBeIRuJDIQI0Raij1sn08tkg/4n1z
	 TU5bEfmAtnFMw==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 713E817E063E;
	Sat, 01 Aug 2026 13:21:02 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Sat, 01 Aug 2026 13:20:47 +0200
Subject: [PATCH v5 01/25] dt-bindings: clock: mediatek: Make '#clock-cells'
 required for MT8186
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-mt8189-clocks-system-base-v5-1-ac4410697cc2@collabora.com>
References: <20260801-mt8189-clocks-system-base-v5-0-ac4410697cc2@collabora.com>
In-Reply-To: <20260801-mt8189-clocks-system-base-v5-0-ac4410697cc2@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785583260; l=1753;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=rp96vQvpmzcYQQQawuTsiCW9FJPQfixEXB6+OjlKWjQ=;
 b=RYQQ0zNUI8yvhT6Ml/ea4uXiw9Sx0Ms/rSOy6qA+AAipgNG9WkeTySDx+raScDFicH0rIY4Hu
 selo5OO5OcEDxmPYKotvp79dt0x/COOGzCIXK05ZDfd3o0E3z5jYFTd
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Both MT8186 clock controllers dt-bindings (clock and sys-clock)
document the '#clock-cells' property but do not enforce it as required
property.
As clock provider nodes should define this property in devicetrees, add
it to the required property list in both its dt-bindings files.

Fixes: f113a51aa2cf ("dt-bindings: ARM: MediaTek: Add new document bindings of MT8186 clock")
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 Documentation/devicetree/bindings/clock/mediatek,mt8186-clock.yaml     | 1 +
 Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml | 1 +
 2 files changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8186-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8186-clock.yaml
index f4e58bfa504f..539149c945d0 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,mt8186-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8186-clock.yaml
@@ -44,6 +44,7 @@ properties:
 required:
   - compatible
   - reg
+  - '#clock-cells'
 
 additionalProperties: false
 
diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml
index 1c446fbc5108..f8acc02cafee 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml
@@ -45,6 +45,7 @@ properties:
 required:
   - compatible
   - reg
+  - '#clock-cells'
 
 additionalProperties: false
 

-- 
2.55.0

