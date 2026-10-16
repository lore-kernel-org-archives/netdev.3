Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AEA466B4B
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 09:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792144174; cv=none; b=nKMjh6QOgccSKDJ/haar3AhMb6EKxwKYBgn69TPLOnwFrdOL8/h3316mQETCk9ET4hYndqJI+8OcxNddzsJwI7qPBWr/Ckf++A/F6LKLTi8P4spV0hW5wxWsoqXXt6MpzD2yje/crIm8Z8ETlmAWek8MKgTDQX6Ht0go5e1UfO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792144174; c=relaxed/simple;
	bh=tuaxY8YyL8N/nOYFv8zeh5YjJOwNXuNHOb9HxL4589s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O+bJWoXrINA4e49cEfHEQ+64zQfhVTZQ+BbBZyLhC+Gkrb0LS9v3RCnZNq7RpnLRaN43VeS/hsBmZnq48WaQSOX4mZxlKhMGWv3/FjUHwH/ggK7Lp00B2dr47M0Bgo1dMiRm0BwLTD3CgEK0NTFQvahOdr07gAmZ64ec9JA9uSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RSmE/k66; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RSmE/k66"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E941F000C4;
	Fri, 16 Oct 2026 09:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792144169;
	bh=vSuKCQ2uVQZzvjJ7v2FHOgZRf+L275APlek9m9UTIEM=;
	h=From:To:Cc:Subject:Date;
	b=RSmE/k66nQOxGtbBKfoHB4HQrEUpuNxab67EbpLaj2wCd2reMg/rgfk8CwdjB/vmZ
	 lBKu9IViK7QimRPY828rTbyQ4GajAEu5DkOsYZvylLTsKfUazB8Ww9HkGi3HsWRM/i
	 UWKDd3obEdNYdW70qRlwZN+5b6ONIc7c0RcfjCvU8ehQPv/EmmLELqCVCOc97LMdLb
	 SAW6djQYJM3UVJOreXff3/xEG/Qa09kGQ+VPOgzDzSOcNHRVScC9KZGCleHe0DwNkS
	 FV/H6n/fttMw/bi2NuEphJEm5UYPvp4J2UXnwzkqf21qXrnsWUaDTEXz/h01cooqop
	 +hNYQFXkQSXaA==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH net-next] iavf: use skb_put_padto()
Date: Fri, 16 Oct 2026 11:49:25 +0200
Message-ID: <20261016094925.2762785-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace skb_pad() and the manual skb->len and tail pointer updates
in iavf_xmit_frame() with skb_put_padto().

No functional change.

Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
---
Part of a medium term plan to get rid of skb_pad(), source of many mistakes.

 drivers/net/ethernet/intel/iavf/iavf_txrx.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_txrx.c b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
index c30abf17cf5d3cdc715f5da38474c4d40ab70a05..8982cf75466faa368b84a1f57735e4523490c3f3 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_txrx.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_txrx.c
@@ -2396,12 +2396,8 @@ netdev_tx_t iavf_xmit_frame(struct sk_buff *skb, struct net_device *netdev)
 	/* hardware can't handle really short frames, hardware padding works
 	 * beyond this point
 	 */
-	if (unlikely(skb->len < IAVF_MIN_TX_LEN)) {
-		if (skb_pad(skb, IAVF_MIN_TX_LEN - skb->len))
-			return NETDEV_TX_OK;
-		skb->len = IAVF_MIN_TX_LEN;
-		skb_set_tail_pointer(skb, IAVF_MIN_TX_LEN);
-	}
+	if (skb_put_padto(skb, IAVF_MIN_TX_LEN))
+		return NETDEV_TX_OK;
 
 	return iavf_xmit_frame_ring(skb, tx_ring);
 }
-- 
2.53.0

