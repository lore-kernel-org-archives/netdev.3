Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E723D88EB;
	Mon, 20 Jul 2026 10:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784541910; cv=none; b=tzkuYg6ZYY48JXK1qCXdqIO50cOTXuXUpr4tbBJbO6a0GKznNmBEdteiJ3JgCAeBPoZ8j304CKp9bYSoI1v6elqYweIw5ofzH7OuaGDcYi6e2wPeHLxMzOk8Noa/z46lRpNVdu4MsYiFx8wGyA8k47/h7uhvcOenucHo/RPNI08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784541910; c=relaxed/simple;
	bh=3HvR2i0TeyW7ntE6wt26ah4Fl34lpJceNTjjoyWnRHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EFXjozjTulStTrb2/Xx1h7PhGJY+UgB9TBr5vZ/UvheSh+jSYCLO0AGZ/5iCiiu+9MxhySJg/63jJZZgYDLgTUtPYQ+I1RM4rUBsk2ZN896SBTNrlrdY3sg2lbVYtGXx84M9NkZM7xCz4A1F0jAxt8MAG7W8O9THDBKubJXpHrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=i3kLBBxM; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="i3kLBBxM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1784541900;
	bh=3HvR2i0TeyW7ntE6wt26ah4Fl34lpJceNTjjoyWnRHM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=i3kLBBxM8nEknmw9ziEgmNXeCQbtE1QvJyHG+8j+einEHIw+PVAFjc7r0fswZU9/1
	 epSq/jTdl7Y9MrLUHlNvLSWHRBobyPfuWHreg2iK7PchdzUUlo7PaZajf43ovIwGyL
	 kKsSWJSWK/iK7O21NKAaIVOdQ9wVvPN05Vlu2jtlJqjbT++mGOtWunhDZtUqLj38rO
	 KgaV5aRdr1E/4HZjGDPdSu4Rxp/d0irFnZEJ3650Nqzm/s08nzC77786AGYsAylgeJ
	 oCJVawQUMSF7tmA5gye+yWl+yInvUnh8o5YaiEUE0yov7rmm1/C1QP6Ahzoew/AF9D
	 eK8i85I9bXa0w==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 5AFC417E0DFF;
	Mon, 20 Jul 2026 12:04:59 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Mon, 20 Jul 2026 12:04:14 +0200
Subject: [PATCH v3 04/18] dt-bindings: clock: mediatek: reorder MT8186
 compatibles
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-mt8189-clocks-system-base-v3-4-8e6d99ab3ad2@collabora.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784541894; l=2561;
 i=louisalexis.eyraud@collabora.com; s=20250113; h=from:subject:message-id;
 bh=3HvR2i0TeyW7ntE6wt26ah4Fl34lpJceNTjjoyWnRHM=;
 b=pltJpyjy9yfKcCA9AmyTLCcktlj1zJP9Jr82dNEHv3T9VzzOyvmxKU0xz1B3cbU7p79Bip550
 M0+Pqot62+DAQESzDEZA+jSjSrirOAkludokjkOvaRT/oHcX/Qu8tYw
X-Developer-Key: i=louisalexis.eyraud@collabora.com; a=ed25519;
 pk=CHFBDB2Kqh4EHc6JIqFn69GhxJJAzc0Zr4e8QxtumuM=

In order to prepare regrouping several Mediatek SoC clock controller
dt-bindings files into the MT8186 ones, reorder the MT8186 clock
controller compatibles so they are sorted alphanumerically.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
---
 .../bindings/clock/mediatek,mt8186-clock.yaml           | 17 +++++++++--------
 .../bindings/clock/mediatek,mt8186-sys-clock.yaml       |  4 ++--
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8186-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8186-clock.yaml
index 539149c945d0..756b937bb7c4 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,mt8186-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8186-clock.yaml
@@ -23,18 +23,19 @@ properties:
   compatible:
     items:
       - enum:
-          - mediatek,mt8186-imp_iic_wrap
-          - mediatek,mt8186-mfgsys
-          - mediatek,mt8186-wpesys
-          - mediatek,mt8186-imgsys1
-          - mediatek,mt8186-imgsys2
-          - mediatek,mt8186-vdecsys
-          - mediatek,mt8186-vencsys
           - mediatek,mt8186-camsys
           - mediatek,mt8186-camsys_rawa
           - mediatek,mt8186-camsys_rawb
-          - mediatek,mt8186-mdpsys
+          - mediatek,mt8186-imgsys1
+          - mediatek,mt8186-imgsys2
+          - mediatek,mt8186-imp_iic_wrap
           - mediatek,mt8186-ipesys
+          - mediatek,mt8186-mdpsys
+          - mediatek,mt8186-mfgsys
+          - mediatek,mt8186-vdecsys
+          - mediatek,mt8186-vencsys
+          - mediatek,mt8186-wpesys
+
   reg:
     maxItems: 1
 
diff --git a/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml b/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml
index f8acc02cafee..6733dafbde16 100644
--- a/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml
+++ b/Documentation/devicetree/bindings/clock/mediatek,mt8186-sys-clock.yaml
@@ -27,10 +27,10 @@ properties:
   compatible:
     items:
       - enum:
+          - mediatek,mt8186-apmixedsys
+          - mediatek,mt8186-infracfg_ao
           - mediatek,mt8186-mcusys
           - mediatek,mt8186-topckgen
-          - mediatek,mt8186-infracfg_ao
-          - mediatek,mt8186-apmixedsys
       - const: syscon
 
   reg:

-- 
2.55.0

