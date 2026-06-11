Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5C238239D;
	Thu, 11 Jun 2026 21:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781214953; cv=none; b=sUEGt7nqHVQnhfJKO4ULIitRsdc1DlxCQgK3SLrWKNJmeiohif7vtKfssDEoAZuV6uWXTDCPzbrSfcJVuLK88o71V983Cnm6cDmgs9ksUpiyxfeXXA4LPzCPhAiQUH4ZS4ikwqk3vOtoIY6JpOHqTeugL9plZRMN3VbopUUN4Q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781214953; c=relaxed/simple;
	bh=J4zi4tXjUZtUGAVBSR73fRqvzi6ztjy0FqBNM5dOqX4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pUaEEEteiXuRBTUQ4MoNClCnnxzEb3rLtnWNiAOzo21oUrLPQoab/uTTWzvPUkUwLt6AFqwRc7UNpSwrhcHg4KLYRzbTd8ZlCQTwBoiRl/VFinXiK6D0E9T4fteMuQ3CB8mIuPcCtyM2rbjLxeQZbZbwYAQD2Vow5mNGKQl5PZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jcWMQbxT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jcWMQbxT"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 353C6C4AF15;
	Thu, 11 Jun 2026 21:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781214953;
	bh=J4zi4tXjUZtUGAVBSR73fRqvzi6ztjy0FqBNM5dOqX4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=jcWMQbxTLJBgLhk6SIT3B4zOjwNyuqglBi1jO10+Dl5G9umgX4OmQCffkJCpK0YOk
	 Rc1YhzIRQVQcPr24JtrCrC+64qIznZXczfRZ+qIxgCdUCXq44THItag6IILKSBgZ1+
	 53GoTLhB7adENC9PWv8OdfFGtOHDl2bPH3sOI/AhlxOaevIdSYfyh2/o8wKQ4KRhyJ
	 pEYryoy3mtG+ZFGCG+LX6Fzs/oCB5X4wGoto4m5jBJdEwdlHNdeDSJ3j6h8nTZIKhv
	 DlhLQ7hOL3dEZoxicFlBOyW7bbtSUrmW1lJz4IY/Bb9Ji1xemL0gjbNTPUUVoDCFjp
	 t1umiymQ8E5sw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C109CD98CC;
	Thu, 11 Jun 2026 21:55:53 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Thu, 11 Jun 2026 14:55:41 -0700
Subject: [PATCH net v5 4/4] dt-bindings: net: updated interrupt type to be
 active low, level triggered
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260611-level-trigger-v5-4-4533a9e85ce2@onsemi.com>
References: <20260611-level-trigger-v5-0-4533a9e85ce2@onsemi.com>
In-Reply-To: <20260611-level-trigger-v5-0-4533a9e85ce2@onsemi.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Piergiorgio Beruto <pier.beruto@onsemi.com>
Cc: Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>, 
 devicetree@vger.kernel.org, 
 Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>, 
 Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781214947; l=1648;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=5m7Zn2IB4XfdT3/7b+9FZgcVrhjA695d6nE+ghg/fkM=;
 b=DlhK1Ndf40Cd6zkXYQ59FA6gg0g6OXNGMlAKRSka+sCuQWUoP4QnExeAkjHibxRa4TovKMg4w
 ilT57mFnE5oAtFREgF6RrGNjjh2VHAPx3OOXreE8oYAOJ12xuMgHzrx
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

According to OPEN Alliance 10BASE-T1x MACPHY Serial Interface (TC6)
specification, interrupt type is active low, level triggered interrupt.

Specification calls for when interrupt level will be asserted and what
condition it is de-asserted. By using edge triggered interrupt, there is a
potential chance to miss it, particularly if it is asserted when interrupt
is disabled.

Level triggered interrupt can't be missed as it gets de-asserted only on
interrupt handler taking actions on interrupting conditions.

Fixes: ac49b950bea9 ("dt-bindings: net: add Microchip's LAN865X 10BASE-T1S MACPHY")
Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v5
  Added better, descriptive commit message
changes in v4
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


