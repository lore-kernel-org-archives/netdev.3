Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAB1346AF1;
	Sun,  5 Jul 2026 22:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783292390; cv=none; b=rMLPiDDTn98TuyKtkwl3oVEnRJu9b23fLzvk4kFaYpa5Hk1ewUWeojDWLRxb3ChUmUcFpzv7o6qz0Y6zleW6i/SmM9yOqanzLTykLTZ+HTruPuMmWghJvZxB5WgduhqmIWffPp64totkg8wkARlEj5+9VL0mV/ZNPnIJBVWRbHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783292390; c=relaxed/simple;
	bh=JPym60sbHBQASzrFWRvRJOym/0pZRagJ/0UPMEFJQBM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dpzqOaFOcoGk1VtiHBYkZ3of6J75dAAJUX7ltvzN0zq+PNrHsI3VeYJBolUABBRHnRP6EZN8Ij92wssPtFceRNM881FTcIHD0G8xmvhqi/kMmuuSp0LWfGUUx4j+U6Y/YXQGiosPCLl8+WEmHpFyxLmwY93OIYvV9yrxW0EosRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYXpedqj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYXpedqj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6515BC2BCFC;
	Sun,  5 Jul 2026 22:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1783292390;
	bh=JPym60sbHBQASzrFWRvRJOym/0pZRagJ/0UPMEFJQBM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=eYXpedqjUK2ZqjRJnaRa41gu3y0UPHpSW/tFAw8IvaZTQ2fznhqIGVrl/DT4z59b3
	 7OQ2UUBWZmqf4w/fFhdZMwhlTjKTYYt+EnbTqYvJX6L4wkIcklgGenHCkscegZUVg6
	 xQchvD83E7pzckXt1VyXpOIF95dDV3O0IcRAwwSsOXQNARf0wBI9OfBIRoDKIuUhJA
	 dX7zeSCLxDtaFYniSIsb3fO1YZXdHOOw8ziOl3zl3c3ikFqIdSeGjrUFF7kNHzct5F
	 hwx5JAURwveV/g/StWN1qBSr6E9JTjUrrakkZBkwwLae+59IOgmtm2LVsrdL2Gilds
	 RpzS1Ck2kQyqg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53967C44501;
	Sun,  5 Jul 2026 22:59:50 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Sun, 05 Jul 2026 15:59:51 -0700
Subject: [PATCH net v3 3/3] net: ethernet: oa_tc6: Carrier off when
 disable_traffic is set
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260705-fix-race-condition-and-crash-v3-3-3e51841e4d08@onsemi.com>
References: <20260705-fix-race-condition-and-crash-v3-0-3e51841e4d08@onsemi.com>
In-Reply-To: <20260705-fix-race-condition-and-crash-v3-0-3e51841e4d08@onsemi.com>
To: Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Piergiorgio Beruto <pier.beruto@onsemi.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Andrew Lunn <andrew@lunn.ch>, 
 Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>, 
 Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783292390; l=1223;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=fNI1NVyKoYyZnDQNpci4/tI7Q3qwlBNxuPkcCrOJOJM=;
 b=/5hBii1gvF3WT6RANyqjnO7pr3NqB5dvqbpkjNbaaNlUEnJn76BILkd8kC3Y3ZSRk85V8Tm3D
 9F2DYTaCkvXB3EonDB2pYnEQkIMMPr027qcezlO7koit1D4sImWGOku
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Previously, TX queue interface was stopped when
disable_traffic flag was set. It is more appropriate to
disable the queue as there is no recovery, once
disable_traffic is set. Carrier is also marked off

Fixes: b542d13fab0f ("net: ethernet: oa_tc6: Interrupt is active low, level triggered.")
Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

changes in v3
  - New patch. Carrier marked off once disable_traffic is set
---
 drivers/net/ethernet/oa_tc6.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index a6b8762f6052..1f8564779025 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -730,6 +730,12 @@ static void oa_tc6_disable_traffic(struct oa_tc6 *tc6)
 	skb = oa_tc6_detach_waiting_tx_skb(tc6);
 	spin_unlock_bh(&tc6->tx_skb_lock);
 
+	/* disable_traffic, when set, is a point of no
+	 * return to working state. Better to mark
+	 * the carrier off.
+	 */
+	netif_carrier_off(tc6->netdev);
+	netif_tx_disable(tc6->netdev);
 	oa_tc6_drop_tx_skb(tc6, skb);
 	oa_tc6_free_ongoing_skbs(tc6);
 	oa_tc6_write_register(tc6, OA_TC6_REG_INT_MASK0, regval);

-- 
2.43.0


