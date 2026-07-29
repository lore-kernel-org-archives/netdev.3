Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 522113B71A7;
	Wed, 29 Jul 2026 10:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785319393; cv=none; b=V7SfVi2SXRKHgzrhSo/aj3Y98Wh8K5bAD6CciCm8JVDpNPDfTwx31u+bbzgFbSzuvK6DWZj4E5xmyO9Xt4/EQTBL8TgHcjRXT0rkIQd3VH5760Kw3IaQ/ETV89APjcd3IoWvvORhfuiuqCFYGBURK1jXceM2TsgO0naNxG0aMW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785319393; c=relaxed/simple;
	bh=rp96vQvpmzcYQQQawuTsiCW9FJPQfixEXB6+OjlKWjQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fmPRdZOJOpYyi8/X2y1vyCte33BBbEMutkOm8xuUleuUDKsD4q33bSh4GCJ+vtgypDIABjOi3hua+C4CsVZ5aXug/EEOqk6lv5XxPunasOMEKds7RuzeD8CiG4yAezxovmtEgGl9PeoK7WYwmXXlBL2Ap0HHcVzvPlAKWJonrIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=dJpssQCm; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="dJpssQCm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1785319390;
	bh=rp96vQvpmzcYQQQawuTsiCW9FJPQfixEXB6+OjlKWjQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=dJpssQCms3xVQEqtcjrzv4aO9NtDz6jVPpEipc3cT0siQ4Q9X3R7hu+v08yaIZ+td
	 wjUvQcMw2H2VRUT/KN4+8Ws8qRAzzM6FmDpU7WadmycP7lDWrqAtB1ZBRksecIOaDO
	 jz70t+ziXuvLZEsyrOdHu3umRvVsV1SBVZp44DRuR5qCtoGGcEXSpBt29dSQ8JL2ua
	 WGr3aQR6Yx0ZPU6AHbT+zOoghtH41VDAQGC81tSGaBU9+vFY5ZWTbtsZk+cgSw3RV/
	 Y5O1CdevqT1c/bONvHkq5byC9AiS+9vd43Rpgq4wVp5pqma0bDzcvU9BNLAMNAtatG
	 zxiHZE9NUPdFw==
Received: from yukiji.home (unknown [100.64.0.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laeyraud)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 66E8517E015B;
	Wed, 29 Jul 2026 12:03:09 +0200 (CEST)
From: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Date: Wed, 29 Jul 2026 12:02:45 +0200
Subject: [PATCH v4 01/24] dt-bindings: clock: mediatek: Make '#clock-cells'
 required for MT8186
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-mt8189-clocks-system-base-v4-1-e356b813a64c@collabora.com>
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
 bh=rp96vQvpmzcYQQQawuTsiCW9FJPQfixEXB6+OjlKWjQ=;
 b=oGoz2thF/hMkeO1Ij0QOOYKyoGd0Lpc3rhzGMAZpk5q6cRjj0daWz86KTwFLNIJ4cQ2uPqats
 LJYMAb6IedYCLYOAERaw532eSb52ZjYVcaqsWT52VJJwFG2p1Do3kBH
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

