Received: from relay.smtp-ext.broadcom.com (lpdvsmtp09.broadcom.com [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543FD37F315;
	Mon, 31 Aug 2026 18:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788202171; cv=none; b=kdoGUzxtw9O5z4C7VTGoPhGwpBwQmWPKEolB5R7oOueUElHT53Sub2u1+sfFNTdbqgmZ59uvI2OtdgU+TA/Xsd7z0JliSEH7RtYYd6t5dvzEwy9YGJEcg4ayh6zUXZPbIaLNJabOJiX8LS50a3WuUj1Z5U2eKKLV+Zf5XcyneBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788202171; c=relaxed/simple;
	bh=pZJ4j05BtL3N67hpQm6LOcq+RJ7zhCJkckb/oHN9/x0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dYb3/Hdqpe3lDHR/ZYxfeKKBY9OhDFpaOflawa2vf83l9Hbw8RPSeaALJIMRP65qKH0HN+1HxkhGOnPTQI3kKVStCQr6pd3qzHk+63/b8qxP84v60oro9hPVpONBuil9ghGoxtHMtbikG2oeuUfV6qlYuevqEci8lEZTVTlFU7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=qQpDm3PU; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="qQpDm3PU"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id D03B9C0000E5;
	Mon, 31 Aug 2026 11:42:39 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com D03B9C0000E5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1788201759;
	bh=pZJ4j05BtL3N67hpQm6LOcq+RJ7zhCJkckb/oHN9/x0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qQpDm3PUYncJDVH71w0j99rZOdg39ieoP/WNvHItxRta7nDT8sF7e805gfpSrxEMH
	 pk3dd7tWXDREXHfCuTTjMxdIzTKUZDJdiS2h6NJTcljcVcuA5Bm9bb4DGsCVP0pw/2
	 pC7NpKcyyxGGsYHxcjFr3Ve4Wj/g+DaqWef8h/Kc=
Received: from bse-build-07.ric.broadcom.net (unknown [10.136.28.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 426E9A9F;
	Mon, 31 Aug 2026 11:42:39 -0700 (PDT)
From: Danesh Petigara <danesh.petigara@broadcom.com>
To: justin.chen@broadcom.com,
	florian.fainelli@broadcom.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	bcm-kernel-feedback-list@broadcom.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danesh Petigara <danesh.petigara@broadcom.com>
Subject: [PATCH net 1/2] net: bcmasp: clear txcb->last before writing each descriptor
Date: Mon, 31 Aug 2026 11:42:34 -0700
Message-ID: <20260831184235.4133351-2-danesh.petigara@broadcom.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260831184235.4133351-1-danesh.petigara@broadcom.com>
References: <20260831184235.4133351-1-danesh.petigara@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Justin Chen <justin.chen@broadcom.com>

bcmasp_xmit() only wrote txcb->last = true for the final fragment
of an SKB; non-final fragments left the field untouched.  If a
descriptor slot was reused while it still held a stale true from
a previous SKB (possible when tx_spb_ring_full() underreported
fullness), bcmasp_tx_reclaim() would see last == true mid-SKB and
call dev_consume_skb_any() prematurely, freeing the sk_buff while
its remaining fragments were still in flight.

Unconditionally clear txcb->last before the conditional set so every
descriptor slot starts from a known false state regardless of what a
prior transmission left behind.

Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
Signed-off-by: Justin Chen <justin.chen@broadcom.com>
Assisted-by: Claude:claude-sonnet-4-6 vscode
Signed-off-by: Danesh Petigara <danesh.petigara@broadcom.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index ed0977832ce4..2bd035f74fa2 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
@@ -301,6 +301,7 @@ static netdev_tx_t bcmasp_xmit(struct sk_buff *skb, struct net_device *dev)
 		txcb->bytes_sent = total_bytes;
 		dma_unmap_addr_set(txcb, dma_addr, mapping);
 		dma_unmap_len_set(txcb, dma_len, size);
+		txcb->last = false;
 		if (!i) {
 			desc->flags |= DESC_SOF;
 			if (csum_hw)
-- 
2.54.0

