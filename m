Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C852D9EFB;
	Mon,  1 Jun 2026 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780330056; cv=none; b=YKO9wKNTh1U4fITkMvsidEI1ObVvbzTm2jmacAJ4ArdDIpEdDjMBI/smpabF18fUpnuvTB03+qC4GnOVB0/LJ8g60btqJa4Cwi3J7x1uitJ5FKSx5oxQnkVS0Pc21KeeePWiw8e2dPqZnVweymGUNuYCf31TLNuRDVHBp2EjkQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780330056; c=relaxed/simple;
	bh=fI0KonDLH+VrFvgyIBw+BoHJ9AZ//Znfe24raY0TjrI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qv1DpbwG/Z/eXvWYZDKOUQY60h8XW+f1dyXGP5i3Ci6s4BPxxgHA1+UFZDcnp8NZlel9wmXPPgSQsckpcALDwTrfvLXgsXDZLMnaFDXVkfptGixUXpyZjJj88IQvljHtdXzPa5sVea9vaBIkcn4PCb8yiPBSKm2/GPj7Pk/ERKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tv3i3PpK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tv3i3PpK"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C9E05C2BCFB;
	Mon,  1 Jun 2026 16:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780330055;
	bh=fI0KonDLH+VrFvgyIBw+BoHJ9AZ//Znfe24raY0TjrI=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=Tv3i3PpK598QVdyBHPOuy81RyhDqQzH/6SI7UXvBRnkU04yu1gBUasrom9wI5X/qE
	 OpkKnCX8iqT/s5YEDXDANWYsOPeyqHwpA6CLM5A+NVZqBEkVntp0rxNT3nIciAcaO/
	 VsLmCebBULhjLW4BmM3UzL6OVUCJZo/Q/urc3Zfu9S3e1r6aQX2+lvWs/wmHhwv5Nz
	 19a2ZXJNqCDGm4cwYdXRO1LKGp5AicRLjSyd9AIXmKBpjjOx+gvpLsDMqxxOvFJoWP
	 5/zooKLKAm4X34IxnDvfvMCIo1BJoUZieR+IaGHJg9uV24uWBwun4jN15IHo01Solu
	 lS1FJm3htsuVQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1583CD6E55;
	Mon,  1 Jun 2026 16:07:35 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Mon, 01 Jun 2026 09:07:19 -0700
Subject: [PATCH net v3 2/2] dt-bindings: net: updated interrupt type to be
 active low, level triggered
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-level-trigger-v3-2-da73e7010532@onsemi.com>
References: <20260601-level-trigger-v3-0-da73e7010532@onsemi.com>
In-Reply-To: <20260601-level-trigger-v3-0-da73e7010532@onsemi.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Piergiorgio Beruto <pier.beruto@onsemi.com>, 
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
 devicetree@vger.kernel.org, 
 Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780330051; l=1094;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=GztGW1jH4UUIPIbBXxAULogoffd23r57arWdgZSVKTk=;
 b=/FVvECJAcKodmarFTdpBNLAQgCzvs6rJj2fMqRMZgMkVEeMtZjcF6d//WUyXmcBOdA5R83fy0
 AIKNJUsMIZ5D2H/ElUSe/K6JLWdD0fYjW6vYvoN3cLjQcUghET9TTE6
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

According to OPEN Alliance 10BASE-T1x MACPHY Serial Interface (TC6)
specification, interrupt type is active low, level triggered interrupt.

Fixes: ac49b950bea9 ("dt-bindings: net: add Microchip's LAN865X 10BASE-T1S MACPHY")
Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
 Documentation/devicetree/bindings/net/microchip,lan8650.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/microchip,lan8650.yaml b/Documentation/devicetree/bindings/net/microchip,lan8650.yaml
index 61e11d4a07c4..766ff58147ae 100644
--- a/Documentation/devicetree/bindings/net/microchip,lan8650.yaml
+++ b/Documentation/devicetree/bindings/net/microchip,lan8650.yaml
@@ -67,7 +67,7 @@ examples:
         pinctrl-names = "default";
         pinctrl-0 = <&eth0_pins>;
         interrupt-parent = <&gpio>;
-        interrupts = <6 IRQ_TYPE_EDGE_FALLING>;
+        interrupts = <6 IRQ_TYPE_LEVEL_LOW>;
         local-mac-address = [04 05 06 01 02 03];
         spi-max-frequency = <15000000>;
       };

-- 
2.43.0


