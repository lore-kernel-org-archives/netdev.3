Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1119948A2DE;
	Tue,  9 Jun 2026 19:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781034640; cv=none; b=Pa4VpYMQFj5w2sj2x6Prl4IdAa1m8xJiWAloOJ1KHjuGwgpKgL1UVZz222/6XhUgmxEsAie6Q1E0tKsa0O74Jj6nNy0SM1yRpV+1wGt2w9VGeq3BSNdt3pZphcybDjkt3/74x4uGS7BEC2R/Orydf2ChS33XXk7Tyfso2xAGDvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781034640; c=relaxed/simple;
	bh=cr/MvAsXEhWjeYtC3UgDZ9svVa04M+bda+dTvROi4DU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CKG1Lakvd227J9mwuGxop/JAQPQGlaMATa2VCTwTIdAopxktSLogXg4cEPhvshL+lIJF+UhAgueEpFjg0Z72V+lKeqRcmRZ5j6DwIItpOE+E8HQsgAbSgImXGnf10OJZPZddfTE2jzw+N5QPP41l1oQtMHasfxErTd5rUEJbkRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/AwDtbx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/AwDtbx"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A7F8C4AF10;
	Tue,  9 Jun 2026 19:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781034639;
	bh=cr/MvAsXEhWjeYtC3UgDZ9svVa04M+bda+dTvROi4DU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=U/AwDtbxGfb9CQ//t6TLqr6Qx3DW0XCi+5WmAM5TDKDbrndPf/o7Z6nFuHdSVx8P0
	 qI1TpKduYgGURbw//NZzS41ayVi0n1oHpdeSTjfeQw8Zi0keCF8Uq35qUj6wJS4ZfN
	 Kvh1eJcG4qeVSSRDz1V7rmE0YB44Fhte7QKG7rNdIHZk1sOhzBwbG8gUPx3cXv1bny
	 h3kvbwMREYLdwF5Q7tPG9za4BzjE/kVE0FsDNYkAjSjJ5Q1xIti2TYBgxtjs1kLp4J
	 yARMg5ltv2V6eEdauDoO1+aWtzGrEgUirN29B7/xmBJeyUflo6BMk8iVSAz3b9A/Da
	 G0vINkPcwBWUw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8078FCD98C6;
	Tue,  9 Jun 2026 19:50:39 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Tue, 09 Jun 2026 12:50:27 -0700
Subject: [PATCH net v4 4/4] dt-bindings: net: updated interrupt type to be
 active low, level triggered
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-level-trigger-v4-4-6f389abdd192@onsemi.com>
References: <20260609-level-trigger-v4-0-6f389abdd192@onsemi.com>
In-Reply-To: <20260609-level-trigger-v4-0-6f389abdd192@onsemi.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>, 
 Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
 devicetree@vger.kernel.org, Piergiorgio Beruto <pier.beruto@onsemi.com>, 
 Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781034634; l=1207;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=bMsW8U5V7GkXjBltoUBoX9kv1yVBsDFF/rrSFoglK5M=;
 b=N8mr1STIqO4eTYBJILLVX/hqFhKUZCTVDRyE5t0HXhobVyJaj/26YlIwDePI8G3Tf8HHLYeuS
 aGh6Zn3e2KUDXQOYz1t3ypYZD/o5FrWTcS1NYrg1YYvWhd1YUfSqcUH
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

changes in v4:
  no change
changes in v3
  interrupts entry changed to level triggered from edge triggered
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


