Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794391210;
	b=SrOxov4lF0Wg8GB+SJjzkxO1UTkqvuSgkcickG5gzHlpadolmU4Z02AYMEnvlLKHo8J3
	 pXXrZT8oH4eNm0r5xn/Ae8OXdF4u5k+9Br3vsCOmzwTUQjgFE7RZWzPEmULrMZX8yeoSh
	 iHTq0K0laBqbeZ8REEFHRdFKR55DquaYkOs99e3G+WaSmetGyA247es7mdEws1zboaCIs
	 ncADLe80F7w/ZeVgWruf/oQvFdOVHq76q2iflbjfuTkYBXpFTgAmMqvliD78Z6tYa/JXr
	 DEgq9cDh27p53m6WgDC1ld2fULK0rE1AGyIDDsPgkhN0rLNDAjzq0quVidjZ3KezDKg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794391210;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Hm1SJBv9PRkAkfvr27EUes418WVIEQBi/LGbqVaUBrQ=;
	b=b1zQhFOKsFYZpUw/V6u1a1sc5/QJtqoawgQYvfZ1Kv1rNEBHV8/TNvKsN4Kw8866OSP+
	 Ijd5gbzkBPvlVSp8TE7nGpfc1HatlBXXM9rmXCy+6CkLsRFG3+xK6iqFGvQ1ndJab9jQ9
	 ABiIJdfVpFSsoym2OpSoF/h7kLyZ7Pcs5ndJw8Yq+piunYQhNMU+lZVvyWU5mJj/pdXPo
	 FPuy2eNrSMG5pDWnVVg7svfGbtF6nvIH3dUdZK4EfrSxqu1hxb8kdc5sWnU6Njtcp/LmZ
	 LRGpy/vMwFRD8T7FkHtp1MuexxnZMwFMnT4xX17sBvyY0aH51xlv4bCIwvcryKJstdQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WJEKJMRj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F241960A2601;
	Wed, 11 Nov 2026 10:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WJEKJMRj
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794391209;
	b=VHXnsClc4H9Zi8x/M/WNiORlyOthLf193QRs7/69q3MacHKtKLd9cU1X8elZjDHgROln
	 afV4mrJsiekdzKlwWHAwGcbb8kRDwVvGl2F29xYpIIBvRMspgUiI7v20AksVgUiZoU5cC
	 yjqbkTovXEL//ZEzrrZU1EMREzUwz20FUclur2l9fqgGuQxRomJ/4AS+eZqLgcspulkSy
	 PDKozO/KWDnOPn/GRu/tUELHnKUu8lEB2Rrf8gHi6MbUC1Xn47pzUuJDaqmz4dzehJSuv
	 l7nVkdEtuuuOhFBDmAKWsxW65/OrCrkIgCuHxnTifb2b7QNGOG1lCrVSGtmNRt0fOfQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794391209;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Hm1SJBv9PRkAkfvr27EUes418WVIEQBi/LGbqVaUBrQ=;
	b=ilqHOYxWn6WOmbVaNBECsNjti6UNUeQIEIpyAEaoyCIHAbX/PCMOr39dmY/WHJdnTEnV
	 KNtVOiyvcrNEnYNXEzNIuFSsfzsPvJjtaAqXZ1Wa/BiskAxRDlR3mdnFdrW5xhwOqKNbI
	 pFWmhJxwawsjhZA7z4jwjy24SaUSFKDscVbBBXkmCkOOHjb0b1QiK2+2PPGuueuZPTurQ
	 r+MgZhtC71lDQ7CtOKpDulBcwVxV+jwmtQIo0kWDMTOoMGqjA0dQFXfAsTQ75u/l2wBhR
	 yjn3Ry220rEQnJ6DA23mf3DqRpxgudsOUZgfKLjKQqhjMuz5JUwxfYN0De2k3CTm9nQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 7BFFE1F00A06;
	Wed, 11 Nov 2026 10:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794391209;
	bh=Hm1SJBv9PRkAkfvr27EUes418WVIEQBi/LGbqVaUBrQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=WJEKJMRjog55o/d0vtpkv6m09chbopvnkMLCKxCKs1wmHBSBW41tSloUp/Q+P3DUG
	 IGnSeDwaPBi3UluSzIl8ynWKMtifpv4so6SIh/2cQoIBL/C1UlNzghTOVtTMENwshS
	 mvruTIej5D3paO5XlrotRm3lt+JlIwLyEZCJl484PYzBg2VK+F1NN4SXrguuqwX1qa
	 EGWCxFTBqz8IZnSMoUjRF3OnqgHI/fAEV0Ah/Xot/TdcV33UukgwY4Ju8l9dZZCsP2
	 AltVtzdLxuVqViaMMXOuEgvGIp4lVEs3u4g0en/y+j8VseUNeEsD9+oLFcV/qTnbKA
	 mmTWPCpEs1fQA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id EC02748F1A;
	Wed, 11 Nov 2026 10:00:07 +0000 (UTC)
From: Cunhao Lu via B4 Relay <devnull+1579567540.qq.com@kernel.org>
Date: Wed, 11 Nov 2026 17:56:28 +0800
Subject: [PATCH net-next v2 1/2] dt-bindings: net: rockchip-dwmac: Add
 RK3572
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
Message-Id: <20261111-add-board-ok3572-c-net-v2-1-304466394970@qq.com>
References: <20261111-add-board-ok3572-c-net-v2-0-304466394970@qq.com>
In-Reply-To: <20261111-add-board-ok3572-c-net-v2-0-304466394970@qq.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 David Wu <david.wu@rock-chips.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Giuseppe Cavallaro <peppe.cavallaro@st.com>, 
 Jose Abreu <joabreu@synopsys.com>, 
 Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Cunhao Lu <1579567540@qq.com>, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794391206; l=2086;
 i=1579567540@qq.com; s=20261015; h=from:subject:message-id;
 bh=mU0yKgD5Rx8eSSVpwF/Chy/2gZ0r++kW24f/R5Jo8gA=;
 b=XkGmqoAuv2LzhL7CCpNsDL2kKOuW8q/VkorJlfbO44n/CkQBmI/3FKLoOYe5NmwR/FHXraodY
 W9hcCyaaI/zAro8e6BNxrR1yauBtUvOw3wtESU9U8lPfZLtHCCD35eH
X-Developer-Key: i=1579567540@qq.com; a=ed25519;
 pk=sUTWrzlIwT4C7ctjNfVZAzzg0G7QUn2XxRGpYsw4RtM=
X-Endpoint-Received: by B4 Relay for 1579567540@qq.com/20261015 with
 auth_id=1177
X-Original-From: Cunhao Lu <1579567540@qq.com>
Reply-To: 1579567540@qq.com
Content-Transfer-Encoding: 7bit

From: Cunhao Lu <1579567540@qq.com>

Add the rockchip,rk3572-gmac compatible with the snps,dwmac-4.20a
fallback and require rockchip,php-grf.

Signed-off-by: Cunhao Lu <1579567540@qq.com>
---
Changes in v2:
- Add RK3572 to the shared Synopsys compatible list for consistency.
---
 Documentation/devicetree/bindings/net/rockchip-dwmac.yaml | 3 +++
 Documentation/devicetree/bindings/net/snps,dwmac.yaml     | 1 +
 2 files changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
index e8dda1961ab3..f0596513e031 100644
--- a/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/rockchip-dwmac.yaml
@@ -27,6 +27,7 @@ select:
           - rockchip,rk3506-gmac
           - rockchip,rk3528-gmac
           - rockchip,rk3568-gmac
+          - rockchip,rk3572-gmac
           - rockchip,rk3576-gmac
           - rockchip,rk3588-gmac
           - rockchip,rv1108-gmac
@@ -54,6 +55,7 @@ properties:
               - rockchip,rk3506-gmac
               - rockchip,rk3528-gmac
               - rockchip,rk3568-gmac
+              - rockchip,rk3572-gmac
               - rockchip,rk3576-gmac
               - rockchip,rk3588-gmac
               - rockchip,rv1126-gmac
@@ -146,6 +148,7 @@ allOf:
         compatible:
           contains:
             enum:
+              - rockchip,rk3572-gmac
               - rockchip,rk3576-gmac
               - rockchip,rk3588-gmac
     then:
diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 2c4842404bf6..80d3b43e2889 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -94,6 +94,7 @@ properties:
         - rockchip,rk3506-gmac
         - rockchip,rk3528-gmac
         - rockchip,rk3568-gmac
+        - rockchip,rk3572-gmac
         - rockchip,rk3576-gmac
         - rockchip,rk3588-gmac
         - rockchip,rv1108-gmac

-- 
2.34.1


