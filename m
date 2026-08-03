Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C786037E317;
	Mon,  3 Aug 2026 10:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785752116; cv=none; b=FceU9AWCJwwPvMzGcT35fqkOOHGEZtQO1Qrv82wMcHE0Fw4b073ihIlrzo4jn2JVumVqr1AGAUFGZQ+ug6ObxoKijfRlLfJLWhEj6TtdmkTBrlUvJlHrdCsnKDGqPxQwWQkp9y4ACGBJdmw3CDrSO03URBcWVj1uWC6ZQM4bUi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785752116; c=relaxed/simple;
	bh=Ca4WNKwt2jZCjoz4pJbAO6t+h4BpkJ3DGmk2qwJhIwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aP5y2ZlIYDs3M4a5u48Mc+kN6NJpBTBGTtht7bmPuHqW4gxh4EQMpCT+sJmA5+sozva+dxnu54Q1mIyJHicAyNFFetbF/mjc5ME+dyX09nlbSaPoAPMD+E2BP2CMTgrHsefUP8jNKZveP/OmNUe84+TAgV45VdFTHmQsBAvisjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=m3iJUsgL; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="m3iJUsgL"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 260A71596;
	Mon,  3 Aug 2026 03:15:10 -0700 (PDT)
Received: from e142021.fritz.box (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDBA43F632;
	Mon,  3 Aug 2026 03:15:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1785752114; bh=Ca4WNKwt2jZCjoz4pJbAO6t+h4BpkJ3DGmk2qwJhIwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m3iJUsgLVOZMW4Vrp/KBT8ByLEkfSIlzXzbfHzwEEbi57tgaEm8FZCs4HFj5a9j1U
	 vE729Mt8slcrB2SZlaz9wchSpEQCND9D91h+iGk9EoUPTtOVfpP5IrD5Ny10JcWu9M
	 nUY+UQFPL/y5S0x0wGaRUwalsTdOsMgpdxwh0QMU=
From: Andre Przywara <andre.przywara@arm.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>
Cc: Liu Changjie <liucj1228@outlook.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH 3/6] dt-bindings: net: Maxio PHY: add PHY-ID for -Q2C variant
Date: Mon,  3 Aug 2026 12:14:49 +0200
Message-ID: <20260803101452.2993721-4-andre.przywara@arm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803101452.2993721-1-andre.przywara@arm.com>
References: <20260803101452.2993721-1-andre.przywara@arm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Maxio MAE0621A PHY is out there in at least two variants: the
MAE0621A-Q3C chip, with the PHY-ID 0x7b744412, and the -Q2C variant,
identifying as 0x7b744411.

Allow both IDs to be used as the PHY compatible string, to potentially
avoid probing, which might fail due to unavailable resources (clock).

Signed-off-by: Andre Przywara <andre.przywara@arm.com>
---
 Documentation/devicetree/bindings/net/maxio,mae0621a.yaml | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/maxio,mae0621a.yaml b/Documentation/devicetree/bindings/net/maxio,mae0621a.yaml
index f1ea54583225..c4d06c626168 100644
--- a/Documentation/devicetree/bindings/net/maxio,mae0621a.yaml
+++ b/Documentation/devicetree/bindings/net/maxio,mae0621a.yaml
@@ -14,7 +14,9 @@ allOf:
 
 properties:
   compatible:
-    const: ethernet-phy-id7b74.4412
+    enum:
+      - ethernet-phy-id7b74.4411
+      - ethernet-phy-id7b74.4412
 
   maxio,clk-out-frequency-hz:
     description:
-- 
2.43.0

