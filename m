Received: from relay.smtp-ext.broadcom.com (lpdvsmtp09.broadcom.com [192.19.166.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 544C037F745;
	Mon, 31 Aug 2026 18:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.166.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788202171; cv=none; b=HKtlANWKWHeVFBP/OU1ZPtXu//Pj8qDPhhtj/0gq2Jc4PrP7Mh2RLeuqIf9D7A6zm5gMDVjVu5IXggf0neEbMetK+P1IEs8sWiVOgpmcoUSvSqLHvuvnQj8FB+dnqg3UrIHOAcOmgdS22PAPQ0r7OZN6N9bz6wil9tAqtOvFdm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788202171; c=relaxed/simple;
	bh=UiqPHa6i5QGNaQBqyNFlB/f7h/ASTwTPIfmKVFlO2iE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i+byWHpAzcuwXKFFWrMcGxZgJUYop6ovAjelP5odlLYnAAX/qrHOIcX3+9z+wB4I4D7Mba4iLSz01aael7Y6MLZXoOpFsIWt0iVJxEqk5Cd35J6/y+JCJjSbgQDBTki6BB5h5sf4LjR4B/Ip3w+Q6POaWHT/lY8oSWB1ua/zvN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ES/p3xFG; arc=none smtp.client-ip=192.19.166.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ES/p3xFG"
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 74137C0000E6;
	Mon, 31 Aug 2026 11:42:40 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 74137C0000E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1788201760;
	bh=UiqPHa6i5QGNaQBqyNFlB/f7h/ASTwTPIfmKVFlO2iE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ES/p3xFGy0tfOI5Rws+lqDeuCtErS9LmJE4SMUKuDUq/UKPp2C88ICHLqD4BO11f4
	 e3RBd88F99WDQ2B83r1Npw7Nj9ODxQdFUtPOhj5SwH0I6a8EN92koJFGw1BoLevH4h
	 BtzL4MIC42YKkrc07hOd7x1r7fZjzwerOiiZQudw=
Received: from bse-build-07.ric.broadcom.net (unknown [10.136.28.187])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id E00D3A9A;
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
Subject: [PATCH net 2/2] net: bcmasp: fix tx_spb_ring_full() checking same slot cnt times
Date: Mon, 31 Aug 2026 11:42:35 -0700
Message-ID: <20260831184235.4133351-3-danesh.petigara@broadcom.com>
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

The loop initialised next_index from intf->tx_spb_index on every
iteration, so incr_ring() always produced the same result and only
one slot was ever tested.  Move the initialisation before the loop
so each iteration advances next_index and the function correctly
checks that cnt consecutive descriptor slots are available before
allowing a new transmission.

Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
Signed-off-by: Justin Chen <justin.chen@broadcom.com>
Assisted-by: Claude:claude-sonnet-4-6 vscode
Signed-off-by: Danesh Petigara <danesh.petigara@broadcom.com>
---
 drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
index 2bd035f74fa2..f2176ef3a127 100644
--- a/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
+++ b/drivers/net/ethernet/broadcom/asp2/bcmasp_intf.c
@@ -148,8 +148,9 @@ static int tx_spb_ring_full(struct bcmasp_intf *intf, int cnt)
 	int next_index, i;
 
 	/* Check if we have enough room for cnt descriptors */
+	next_index = intf->tx_spb_index;
 	for (i = 0; i < cnt; i++) {
-		next_index = incr_ring(intf->tx_spb_index, DESC_RING_COUNT);
+		next_index = incr_ring(next_index, DESC_RING_COUNT);
 		if (next_index == intf->tx_spb_clean_index)
 			return 1;
 	}
-- 
2.54.0

