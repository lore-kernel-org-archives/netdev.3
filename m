Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C22352C35;
	Thu, 30 Jul 2026 01:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785375358; cv=none; b=PeMw/NrC9MOpz/Mi5asLAhHk3HVfyMyjJT4/5hGjfz9oX4iEv5OBR214G4luhFVI1CJv98bHLL4FxdeIebAjzjXnk3uQIX52pSY0S4Y6i4od6sCnpDm0qEMg+ov/11b3+K0E3svrb8hD3Nm2Dphlb9jgKmPSaXizrS1Et3nCy0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785375358; c=relaxed/simple;
	bh=KrA3WgNCI5TOdaefThH0CUcMMXtUVuwevNQYQyIJ+Wc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WsfiAre+W5Bu3dOmMB7wgWIHD4sPsHpMWZZymoaCAXSyc+CFcxAwskakYUWmqVlQ3lXTOlOfUrRpCzYl0+9snQ99uGwGQMNZj8PPPi2xXkKAMXr/6V7R8iJuXgW+1H99I2RHcE0gXDVu8NwCqpvXtrdIhQNkRqcq4x1MUF4I0vA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FPodlZ6z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FPodlZ6z"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 12FB9C2BCFB;
	Thu, 30 Jul 2026 01:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1785375358;
	bh=KrA3WgNCI5TOdaefThH0CUcMMXtUVuwevNQYQyIJ+Wc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=FPodlZ6zdhZzw1tR9xyHulG0isBZP2ggWiIwykPAMSLd0+hzEJw/wo8NABzDsV4mO
	 qYfYhEKV46x51bgJ48N/7p51QhHES5nYo77C6Xsp5/ryPtKaJNa5U3JwU60LO9D9Xm
	 g/vl8k22u/m8lNQX0eMqpBnsb3ITe9H26Ygb7RhTPkhpUbvxfvSnZ2b59hSJYBiaK7
	 SVPIk/MfgLv5qIaVMjpe57BGcMvCH62L7KulCx97koHUltp82DjZxG5J/sVTA9x/eH
	 U+7oCiCeKfXjRhhZG8I/On3ArnvgR77bx22MDidi+kAQfBrV+c80RlCdgAykoLUudp
	 u2NChdpmqgaRA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC712C55165;
	Thu, 30 Jul 2026 01:35:57 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Wed, 29 Jul 2026 18:35:17 -0700
Subject: [PATCH net v5 3/4] net: ethernet: oa_tc6: Disable tx queues on
 fatal error
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260729-fix-race-condition-and-crash-v5-3-3906bc485daf@onsemi.com>
References: <20260729-fix-race-condition-and-crash-v5-0-3906bc485daf@onsemi.com>
In-Reply-To: <20260729-fix-race-condition-and-crash-v5-0-3906bc485daf@onsemi.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785375315; l=1429;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=sCF8vvxErMf2hHtBkFe8CtJck2QFBgMa9qyNAHiHLSY=;
 b=OMqW9xqrChJ96jjx5yEczWGH58L0E0zO4BUS+4R3lT1QAWIHRNYLp9r4Ks9RWs0J+D9xn4qct
 FMQSOIh9cQRDAE4Ayzlq4Og0aaX+wHz0z/pxQ7e3z56MDmUOwFm+7B0
X-Developer-Key: i=Selvamani.Rajagopal@onsemi.com; a=ed25519;
 pk=5QRdM0HS/LGWWcUZZ9hVfZ+qbPQGZCumcTXOiN7Fyug=
X-Endpoint-Received: by B4 Relay for
 Selvamani.Rajagopal@onsemi.com/20260531 with auth_id=803
X-Original-From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>
Reply-To: Selvamani.Rajagopal@onsemi.com

From: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

Previously, TX queue interface was stopped when
disable_traffic flag was set, which would indicate fatal
error. It is more appropriate to disable the queue as,
unless driver is unloaded and reloaded, there is no recovery
after disable_traffic is set.

Fixes: b542d13fab0f ("net: ethernet: oa_tc6: Interrupt is active low, level triggered.")
Signed-off-by: Selvamani Rajagopal <Selvamani.Rajagopal@onsemi.com>

---
changes in v5
  - Changed the commit message to accurately reflect the
    changes
changes in v4
  - Reverted the change that turned carrier off on disable_traffic,
    as it may have side effects
changes in v3
  - New patch. Carrier marked off once disable_traffic is set
---
 drivers/net/ethernet/oa_tc6.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 421f72e6f71e..bb644509c32b 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -730,6 +730,10 @@ static void oa_tc6_disable_traffic(struct oa_tc6 *tc6)
 	skb = oa_tc6_detach_waiting_tx_skb(tc6);
 	spin_unlock_bh(&tc6->tx_skb_lock);
 
+	/* disable_traffic, when set, is a point of no return to working
+	 * state. TX queues are disabled.
+	 */
+	netif_tx_disable(tc6->netdev);
 	oa_tc6_drop_tx_skb(tc6, skb);
 	oa_tc6_free_ongoing_skbs(tc6);
 	oa_tc6_write_register(tc6, OA_TC6_REG_INT_MASK0, regval);

-- 
2.43.0


