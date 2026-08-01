Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B43B43637C;
	Sat,  1 Aug 2026 11:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785583274; cv=none; b=cLSwklQ08fLUzHWiQj7tM3Kc7LdJILVvTm6SnqUSbvMiX8mhQWEICpz+vSUbVqTB4SE9RGcCZmiTXaMDRj6xPLg9PzA47ueKTZAJ/FNmXcshfQuXKJTSPB8jEdBrquLqLeW5fpUNdIXIXG4LfSih+cfHaP0gNi4CvZjjhPqcGRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785583274; c=relaxed/simple;
	bh=fUUtXLDjBk6CCgOqNBHxohDsqafdXykxd3de6nmxpT8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K8ct17czGkrtbD9rA7zcj7Jn/UoJjFucFE+IXAlywMJ3Ag26xSDu4/DghoOFcS9fU0x/fPghW5lTtSvIV5Jnq6AezGBcqUx3qxFOB0dQe20hLUEnlhNFPASF4GFBEgHkR0L8OfUi+z51NPiBJPnt3QpQ2Sq8cmxL9Rc/kYNckIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=O8I/bbzV; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="O8I/bbzV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1785583264;
	bh=fUUtXLDjBk6CCgOqNBHxohDsqafdXykxd3de6nmxpT8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=O8I/bbzVfTDCEqIlRrICbx6bVCsVl3I6lVCKilwWA19nhT8QdcXOwKEVmNMl8og4M
	 kF8a6Pprs9OUeWLtt5pHjymph/cH/C3EAGPclgOz0eDE2lCvVUjdi28KlKvwUd13YM
	 8SFeAZ4bh9VBCy00NSsJhwhyV0haauExFbyonAsCEVD4UHopa77F0q7+SHxMCnxtLt
	 UwOGE1GvSkpNuJ1FYHwpQKnlFtzzPiz77iK+GtziVPTNt+4CBBUL4gK3pb5xY3outn
	 ebhSqqyF0+gl2SnS092kqUP8Fyjew1FUlkX+axpmPHP3M5HQyV6hJfw7Lvqua/4YmX
	 ncjvrLE25q29w==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id AD0C617E0700;
	Sat, 01 Aug 2026 13:21:03 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Sat, 01 Aug 2026 13:20:48 +0200
Subject: [PATCH v5 02/25] dt-bindings: clock: mediatek: Make '#clock-cells'
 required for MT8192
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260801-mt8189-clocks-system-base-v5-2-ac4410697cc2@collabora.com>
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
 bh=fUUtXLDjBk6CCgOqNBHxohDsqafdXykxd3de6nmxpT8=;
 b=+WyJ8p8Fq69fbltxSxVvTayhKruhX4mVD/cnHZSRwnlL7+6GiQI52/MYgxrsIU8F76/sT2p4e
 Q7wQ1LqXmSXAQhMcfe5zc6yIaARPBTiw9qW4I+xm+ptIrlAZY+wHcYx
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

Both MT8192 clock controllers dt-bindings (clock and sys-clock)
document the '#clock-cells' property but do not enforce it as required
property.
As clock provider nodes should define this property in devicetrees, add
it to the required property list in both its dt-bindings files.

Fixes: 4a803990aeb1 ("dt-bindings: ARM: Mediatek: Add new document bindings of MT8192 clock")
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

