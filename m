Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A58A2DF137;
	Mon, 28 Sep 2026 21:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790630371; cv=none; b=WUR5ByMkhNg1dKrFVfWzyEqnwSqCV4NldrfJjWKECBBg52BrU5UY94Ev1SybE+AOaZZT9nYPng38fD+KyJsmXcorLYdG6hVgNOoVRztwMg44FNe3Y60leYK1FRbPvQOeyCSZFDsOjkxSIwueSsUbfnbQLI+uoGFaWlQFh9baymk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790630371; c=relaxed/simple;
	bh=kfmsQ9/d/zSC1kcaKVB7j/3bdEwiblUM+SnGKNFHH9k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UKAbtjHCA3iT/wu0sU0muHvlQ87JZntu6TSh5RLsdqHmWd9ibkE5OUFO3imWH8VIZJgET8UfaQY9/K8zYmzhZ4IUBYjT7bXOEXFh3AIN6TO/i0O4x5uXBPB8/udErOBgAl3qi8wLARkgZnbLRUCqkDgInCtUwkePFKRWKKU9cFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g26diT/P; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g26diT/P"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B4538C4AF0B;
	Mon, 28 Sep 2026 21:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1790630370;
	bh=kfmsQ9/d/zSC1kcaKVB7j/3bdEwiblUM+SnGKNFHH9k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=g26diT/P6t76B5rrUQrKwIJCIXJMhezkkPTfgslb0W2RxTfbQsCKcrj38SQmhEabm
	 zk3wS0S7TYwT/+kKuqicNid4n2dtGknjJ8/B1gq1sNq+nvAavEoLqde6eGR99ycVwR
	 G4jB6RovSKpARWmXfNuUQBR93++t0i+taXhCAPohdRPjZxoEUjs7EFHMp7XvXpX7H7
	 bT6/wI+0K3OydbkUPSy4RY2zwn6QhJd4U114yeeUSKauRsqdTXW16sX9Y4flJdtaKv
	 UfspCFMI7/QWOfabQVjzGkeIkr0I/8r5JCm7Fp0C7O78AoQ+aDpILImvafHk1NcBj8
	 xIKjwwT3QzVsg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92C79CA5FA1;
	Mon, 28 Sep 2026 21:19:30 +0000 (UTC)
From: Kyle Hendry via B4 Relay <devnull+khendry.reliablecontrols.com@kernel.org>
Date: Mon, 28 Sep 2026 14:19:03 -0700
Subject: [PATCH net-next v2 1/3] net: pcs: rzn1-miic: Fix port numbering on
 RZ/T2H
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260928-miic-validate-dtb-v2-1-1ee3d33748e9@reliablecontrols.com>
References: <20260928-miic-validate-dtb-v2-0-1ee3d33748e9@reliablecontrols.com>
In-Reply-To: <20260928-miic-validate-dtb-v2-0-1ee3d33748e9@reliablecontrols.com>
To: =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <clement.leger@bootlin.com>, 
 Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc: linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Kyle Hendry <khendry@reliablecontrols.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790630370; l=911;
 i=khendry@reliablecontrols.com; s=20260813; h=from:subject:message-id;
 bh=IeosEy2220CsO/HfUbuKH2ER3bJwKIrqImDfBfTHa5c=;
 b=44tZkjaG38VvzANRTfwqSvQcjhG8i9NeLc5hJj4t67SbtutaOTMaTg3wGFqxpuXIsIN4rq+Ub
 rxi7wE1m38uDsL/gIzqojAelmOlDbu2MjCzxB2PyUKD76PE157Ai0NA
X-Developer-Key: i=khendry@reliablecontrols.com; a=ed25519;
 pk=gbK6oghz3qBlBiaGCsEzALLOtj5VklmsuolHQNhDV5M=
X-Endpoint-Received: by B4 Relay for khendry@reliablecontrols.com/20260813
 with auth_id=946
X-Original-From: Kyle Hendry <khendry@reliablecontrols.com>
Reply-To: khendry@reliablecontrols.com

From: Kyle Hendry <khendry@reliablecontrols.com>

The port numbers on the RZ/T2H are documented as 0 to 3. Update the info
structure to reflect this.

Fixes: 08f89e42121d421b ("net: pcs: rzn1-miic: Add RZ/T2H MIIC support")
Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>
---
 drivers/net/pcs/pcs-rzn1-miic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-miic.c
index cb74861e823c..df70309c2d97 100644
--- a/drivers/net/pcs/pcs-rzn1-miic.c
+++ b/drivers/net/pcs/pcs-rzn1-miic.c
@@ -838,7 +838,7 @@ static struct miic_of_data rzt2h_miic_of_data = {
 	.index_to_string = rzt2h_index_to_string,
 	.index_to_string_count = ARRAY_SIZE(rzt2h_index_to_string),
 	.miic_port_start = 0,
-	.miic_port_max = 4,
+	.miic_port_max = 3,
 	.sw_mode_mask = GENMASK(2, 0),
 	.reset_ids = rzt2h_reset_ids,
 	.reset_count = ARRAY_SIZE(rzt2h_reset_ids),

-- 
2.43.0


