Received: from mta1.migadu.com (out-218.mta1.migadu.com [95.215.58.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7766367B77
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 06:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788588996; cv=none; b=bVgbMeyipFWlxoL9Cj8noAXd2W16/EeSdVARpLVki21S4nu1kYD1iD8zkjxVZrd00F31wwipa8F9hMNnA4VBWp3PbEh31yXAMTuSgWtUtFtZ2jUf17SvccwdzTekC0ZkHVN8reKrTsKHSsz1fwsJ+oS3GFKw6WEjWrVNRW4+UKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788588996; c=relaxed/simple;
	bh=wVvQY6FcjQcbsN6NidnWh4uveTQRJ0Nlbs9VKkQ617g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=P3ABNMCc9qqIfCzw4A4j5tp9tdMsga2UV/rWVzYzCx7mVLa57IsQiXXRCCf4XOW5lJZgSLAMT4kCItXj0kAavxlFU+aBlGipi82AyWGrNwg0q+etUdVBq+iu/u4CE/eiORAD4pY36PQUm9WJb9KwNZGEbTZbZnzqysZjA6YLqxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=BVN/b/rt; arc=none smtp.client-ip=95.215.58.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="BVN/b/rt"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=wVvQY6FcjQcbsN6NidnWh4uveTQRJ0Nlbs9VKkQ617g=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788588991; v=1; x=1789193791;
 b=BVN/b/rtUMmz7m4UUzMzVNbEwlZOoDbrdpLs8SFyl7d/wgVtjYnV71Ay5b/AaRUU2FVXTd1+
 dw57e1R60WxCSzTezi/EtjyazskPuKSWnAKRzQ7+LzfjYxY9QiENTq7Vum+9b5UrP2pQ7JYPQyp
 rhXmxfxrBOmODNR28QZeNT9s=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a0fbfabdf52cb018;
	Sat, 05 Sep 2026 06:16:21 +0000
X-Mizu-Trace-ID: a0fbfabdf52cb018
X-Migadu-Flow: FLOW_OUT
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: linux-wpan@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	alex.aring@gmail.com,
	stefan@datenfreihafen.org,
	miquel.raynal@bootlin.com,
	david.girault@qorvo.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH net v1] mac802154: avoid extra skb references in RX queues
Date: Sat,  5 Sep 2026 14:15:23 +0800
Message-ID: <20260905061524.91223-1-xuanqiang.luo@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

__ieee802154_rx_handle_packet() passes each cloned skb to
ieee802154_subif_frame() and does not release it after the call. The
callee consumes the skb on every path: it either frees it, hands it to
the networking stack, or stores it in a queued RX descriptor.

The beacon and MAC command paths nevertheless call skb_get() before
storing the skb. The worker drops only that additional reference, leaving
the original clone reference without an owner and leaking every queued
skb.

kmemleak report:

unreferenced object 0xffff0000c1fcd480 (size 232):
  comm "softirq", pid 0, jiffies 4295683396
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 60 fd d4 00 00 ff ff 00 00 00 00 00 00 00 00  .`..............
  backtrace (crc ee03f6a1):
    kmemleak_alloc+0xcc/0xf8
    kmem_cache_alloc_noprof+0x240/0x418
    skb_clone+0x60/0xe0
    ieee802154_rx+0x19c/0x280 [mac802154]
    ieee802154_tasklet_handler+0xa8/0xb8 [mac802154]
    tasklet_action_common+0x148/0x528
    tasklet_action+0x38/0x50
    handle_softirqs+0x10c/0x450
    __do_softirq+0x1c/0x28

Transfer the existing skb reference to the descriptor instead of taking
another one.

Fixes: 57588c71177f ("mac802154: Handle passive scanning")
Fixes: d021d218f6d9 ("mac802154: Handle received BEACON_REQ")
Cc: stable@vger.kernel.org
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
---
 net/mac802154/rx.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/mac802154/rx.c b/net/mac802154/rx.c
index 19b5382e85a84..ad602d222e861 100644
--- a/net/mac802154/rx.c
+++ b/net/mac802154/rx.c
@@ -287,7 +287,7 @@ ieee802154_subif_frame(struct ieee802154_sub_if_data *sdata,
 		if (!mac_pkt)
 			goto fail;
 
-		mac_pkt->skb = skb_get(skb);
+		mac_pkt->skb = skb;
 		mac_pkt->sdata = sdata;
 		mac_pkt->page = sdata->local->scan_page;
 		mac_pkt->channel = sdata->local->scan_channel;
@@ -304,7 +304,7 @@ ieee802154_subif_frame(struct ieee802154_sub_if_data *sdata,
 		if (!mac_pkt)
 			goto fail;
 
-		mac_pkt->skb = skb_get(skb);
+		mac_pkt->skb = skb;
 		mac_pkt->sdata = sdata;
 		netdev_hold(sdata->dev, &mac_pkt->dev_tracker, GFP_ATOMIC);
 		spin_lock(&sdata->local->rx_lock);
-- 
2.43.0

