Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C082D3EF2;
	Mon,  1 Jun 2026 16:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780330056; cv=none; b=dcN2KGhfECEYHm5Y6FLaGX7PgKOJvTW5DujVjEJM48sy73ruZhwaS5STKELWurL6NMfYeH9QFaHtUlDNaH/epOKy0edR6xOG3QKZuuehdWHMvr49Si1q4m3kpBAFun7Yrb4jZEPlfZkER3DpYVPkjkFuXRyaJ2WAFU+qN1EOfNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780330056; c=relaxed/simple;
	bh=kw2fWl3/kggl+8QoaAiMjksNRBNP+AfA83rL8vln0fk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=rGJbHylIZ98FW23YEpzQiJ0pUF909DGcG+tc0sGELS7eGTlxaLEqv3bky0q5XEKmmxiX3WAvQD3uKOotvyrpkmX/E3xV+fGJyv5P7g0g8sO/gI3TD3mFBsjD+OQJeHpeZXpDQj01hVbg0uCR/Mc6cFD34sNVkSIYJwSYUi9QjfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSdLtCSf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSdLtCSf"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6E977C2BCF4;
	Mon,  1 Jun 2026 16:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780330055;
	bh=kw2fWl3/kggl+8QoaAiMjksNRBNP+AfA83rL8vln0fk=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=iSdLtCSfBr5tFVmC98KsXiPHILpaKlsIUtuNKynwexm+SaQD9jnNN6QpyjlS4mmWL
	 cq/hlwCyLjoE1wxYGNpu0/5hCdBXvUzG4sunuRHyfyJUsWq8AN0gDg/2NI0YlyxP9I
	 GVN9I8ekUTgZEcL+h6dBdPS68QO6TjxmijgGH5dy2yFELB2vS8h7HlGrsj6gfbDQE0
	 +GV59HnocRa2/3EcOiQqdAcAe3j8OrIZK2V1mPolZipp18G3bMPS8cYFcAiEo5kyXe
	 ICI5tzZF21sIUS6kZBYxeYRPcsQJYD2jQFbFBILv0kSG+pZYtCbSsFxdq34XrNAX6K
	 QZDG/a1/MGQ7Q==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AA16CD6E57;
	Mon,  1 Jun 2026 16:07:35 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Subject: [PATCH net v3 0/2] Resubmitting with cover-letter and threaded
 patch series.
Date: Mon, 01 Jun 2026 09:07:17 -0700
Message-Id: <20260601-level-trigger-v3-0-da73e7010532@onsemi.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADWuHWoC/x3MQQqAIBBG4avErBMsK6SrRAurPxsQizEiiO6et
 PwW7z2UIIxEffGQ4OLEe8wwZUHz5qKH4iWbal13ujWVCrgQ1CnsPUTZeaqcNW7VpqHcHIKV7/8
 3UMRJ4/t+M1JklWQAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780330051; l=1287;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=kw2fWl3/kggl+8QoaAiMjksNRBNP+AfA83rL8vln0fk=;
 b=SS/YfqGoPg9wOTPHlmfv/m8D1xooz6roiF1ub99TrzArgzjzL5VxnIisRzP3B7LTiInntQGS4
 2NyLmUlB7iaA3sLOMe7S8Ly4Y0yK93snp81QnuKCJZxIk1bnHf2Ot5i
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com

According to OPEN Alliance 10BASE-T1x MAC-PHY Serial Interface
specification, MAC-PHY interrupt is "active low, level triggered".
The specification mentions about the conditions in which the IRQ
is asserted and deasserted.

Bug is inadvertently introduced by treating the IRQ in the OA TC6
framework driver and in dt-binding YAML file as edge triggered.

Changes are done in two files
 - OA TC6 framework Ethernet driver
 - YAML file for the vendor that already uses OA TC6 framework.

Maintainer for this driver is already informed and aware of these
changes. Testing for these changes was done in onsemi's setup and
found to be working.

Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
---
Selvamani Rajagopal (2):
      net: ethernet: oa_tc6: Interrupt is active low, level triggered.
      dt-bindings: net: updated interrupt type to be active low, level triggered

 Documentation/devicetree/bindings/net/microchip,lan8650.yaml | 2 +-
 drivers/net/ethernet/oa_tc6.c                                | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
---
base-commit: 02896a7fa4cd3ec61d60ba30136841e4f04bdeac
change-id: 20260531-level-trigger-8cb1a83af034

Best regards,
-- 
Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>


