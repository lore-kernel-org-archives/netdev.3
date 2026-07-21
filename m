Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD8D3FE348;
	Tue, 21 Jul 2026 02:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784600492; cv=none; b=lUkNGfBToDtPnJWLDqGWckZEaQmosvFmTvSKoaImHUyubUBwzlVOMSrAnUs8pdvEPEQYKwAgduq77tYHsHMa89hi01c2yOIN1jQ9DEq+ePA7eq0A03vghitUKQvf6ZCmmq87HrAiizxBjjHWyCo5WRx2F21MZq6ToVCpG4koUD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784600492; c=relaxed/simple;
	bh=/0ZxuVF2xdp9CxZy5Tn4QJ2tJtwZOwTJ5tMXtltKE2k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ik+I4guVrlpxAVFt+9qSHt3z5hnxi5oPYlH9c9nIPnrmuqHwM2W66eXiwRY/Ae0ArFb/jwxxcTmdegHmUcz70LkYZ1AIGk1JplirN798AM4ohGKhGsVbsHk/8iSHvwnMDlE90JVoaSkDQK2U6FAe9LPKXFTuPhOSCxSgM1ITXLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vFsIJCBk; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vFsIJCBk"
Received: by smtp.kernel.org (Postfix) with ESMTPS id D5A06C2BCC9;
	Tue, 21 Jul 2026 02:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784600491;
	bh=/0ZxuVF2xdp9CxZy5Tn4QJ2tJtwZOwTJ5tMXtltKE2k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=vFsIJCBkAjWNxFMisza0J1xSPIuWN7EqEl0rTBrVT9s2KHFLdZVFTPAl5Zh7iU3xT
	 K2PLZ+9SmjsnU88GFbBtFCdJ1S0dwN5anU6qjYzcpipwVX3+DZ1HS3aLk0JQPnOcLW
	 hZVZg/189Haqp8nYZ4fueU23dxJ0g9fPn9lq5hJCFCQVmhEX40wqFYCkQilzANL7wh
	 Viq4XsLBlurSK7CqWVjRubeqNHUQnBRRS1HXhPakhO3G2WmsdoVIeYujy+zc8DO5RS
	 o663wr99zorF/dIB/nloDnOvVBRpEALt9L4jsSMIYHzQOjZzP+XfzFYRUJcx9eTLBQ
	 jknfNX+PWtTPg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF581C4452D;
	Tue, 21 Jul 2026 02:21:31 +0000 (UTC)
From: Selvamani Rajagopal via B4 Relay <devnull+Selvamani.Rajagopal.onsemi.com@kernel.org>
Date: Mon, 20 Jul 2026 19:20:37 -0700
Subject: [PATCH net v4 3/3] net: ethernet: oa_tc6: Disabled tx queues when
 disable_traffic is set
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260720-fix-race-condition-and-crash-v4-3-8273e2f38a1f@onsemi.com>
References: <20260720-fix-race-condition-and-crash-v4-0-8273e2f38a1f@onsemi.com>
In-Reply-To: <20260720-fix-race-condition-and-crash-v4-0-8273e2f38a1f@onsemi.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784600442; l=1302;
 i=Selvamani.Rajagopal@onsemi.com; s=20260531; h=from:subject:message-id;
 bh=G5SfllbV/PC7FsuuOcRTYnuvtsbR0nxTKy7i93ghP+4=;
 b=/61oGyRTdppdnWwmvQewbMjpmLAPT1+acCoE67og71xTheZQwqpEWQ/NRgoOCuCAqlG1nChZk
 LMvjluVFg6TAv/+EiIsK09amwYSrTbao1ZeAjtrgVHjOm5AosbpzzZB
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

changes in v4
  - Reverted the the statement that turned carrier off on
    disble_traffic, as it may have side effects
changes in v3
  - New patch. Carrier marked off once disable_traffic is set
---
 drivers/net/ethernet/oa_tc6.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 9e6850ccfe6c..4b8f6280be51 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -730,6 +730,11 @@ static void oa_tc6_disable_traffic(struct oa_tc6 *tc6)
 	skb = oa_tc6_detach_waiting_tx_skb(tc6);
 	spin_unlock_bh(&tc6->tx_skb_lock);
 
+	/* disable_traffic, when set, is a point of no
+	 * return to working state. TX queues are
+	 * disabled.
+	 */
+	netif_tx_disable(tc6->netdev);
 	oa_tc6_drop_tx_skb(tc6, skb);
 	oa_tc6_free_ongoing_skbs(tc6);
 	oa_tc6_write_register(tc6, OA_TC6_REG_INT_MASK0, regval);

-- 
2.43.0


