Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.127.231.114
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368157;
	b=jeZzyp8osWYP5ewOqP/Xb3D97xS9v6VlSUimX60hGzCQOs487V+t9m4n4K/RzGzcn9Dx
	 1kSzgFEGRuHxs0NJKd37gKZAvAbZ39jFZfcZsf3b5Wq80uSUR7nTW9Fbudf4hEEwRqXru
	 ICIgrKtjjymhvCI0r0FN72qEkUm5sN9AQyHEpzdLn+pIIWbBnmkQnVR4EtiZBAA6Nx8qW
	 RL4Zvl4A1Q/YtnkMyVUfYi49wrPoG74wJ6YWtsQ0Bdkjil3V4uRG8x/wCkNwKhDGfGpQ4
	 2GFEEP6+tO4omZRKafARyWBgdFUVhpKcbSSJo2JnbKhqzU90z3cvi4WhJoTPU143ltw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368157;
	h=DMARC-Filter:DKIM-Signature:From:Content-Type:Cc:Subject:
	 Mime-Version:X-Mailer:X-Original-From:To:Message-Id:X-Lms-Return-Path:
	 Date:Content-Transfer-Encoding;
	bh=kEBFFd8yOCT0rbB3iMwZuBjqlBV1Cjt28vL9qjdrsTE=;
	b=K/B/KKDWKCdKWomUQ2DVQIZo0UAoqzevzodOD8ST7MbipMig89YsWZcos/nWTFj6cbDp
	 BqStobODcp26u/JXq4h/7nDq05X7XWAxDs6PLqMs8vMrGlnpLnIiO7BF4KGiEBAPr2nSk
	 Ela2Ew0uEV3YBwjJwQ/PBvSjA3g6/9eqqKkXXn5NSh3Ag2hQnHimuuHITpV5WrxW3QCNF
	 qfu5jprrn2150TEk3axAiYZRu247XDrEK5Px1Fc4OPXKNF7+x30HQj8eP734AZiZ5bKAb
	 qMwPD1rZBPW46FNMzHV8ueWMx5jGutTQfha5BfPnJykBqtuYpPatk8/PWkbCSfI283g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bytedance.com;
	spf=pass smtp.mailfrom=bytedance.com;
	dkim=pass header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=XgbOw9xW;
	arc=none smtp.remote-ip=209.127.231.114
Received: from va-2-114.ptr.blmpb.com (va-2-114.ptr.blmpb.com [209.127.231.114])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB679606A339
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 03:35:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DB679606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bytedance.com header.i=@bytedance.com header.a=rsa-sha256 header.s=2212171451 header.b=XgbOw9xW
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=2212171451; d=bytedance.com; t=1794368151; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=kEBFFd8yOCT0rbB3iMwZuBjqlBV1Cjt28vL9qjdrsTE=;
 b=XgbOw9xWcHRzNDHTcHV/X01sL1Ra9EVahKncVbg82soOrqxHWifXFfpmC5cnZ+EgduWunp
 8RPvcSo4cj50JkV2LTg6uJPaZ8ZABjaszpvfDd+QiGRa5M9s9/27YL869h/G4MWacB2nRd
 KpmKN4hDRwYdTD1DXTK0ZjWmmKbV8O42d12PCS+MBK1hpjsy5cFuO1rOSdYcezx/ypocQL
 5vdfpN4WKcLSZ8j+kxk4iS95lxY3Mu2NUymUrUNjIk5pVlorlFs+W5fcpUkbBfgBk9A1dK
 zJlWpK+849oOU8vhjxtKm6SJ40UxlfPlm7TJwScGhaB3QILsdFVT5aMfkO7I8A==
From: "Zhao Gongyi" <zhaogongyi@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Cc: <davem@davemloft.net>, <edumazet@kernel.org>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <horms@kernel.org>, <kuniyu@google.com>, 
	<realwujing@gmail.com>, <stable@vger.kernel.org>, 
	"Zhao Gongyi" <zhaogongyi@bytedance.com>
Subject: [PATCH net] net: netns: fix INT_MAX nsid cleanup
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
X-Original-From: Zhao Gongyi <zhaogongyi@bytedance.com>
To: <netdev@vger.kernel.org>
Message-Id: <20261111033525.65828-1-zhaogongyi@bytedance.com>
X-Lms-Return-Path: <lba+26af3e295+5ef86d+vger.kernel.org+zhaogongyi@bytedance.com>
Date: Wed, 11 Nov 2026 11:35:25 +0800
Content-Transfer-Encoding: 7bit

A syzkaller reproducer assigning INT_MAX as a peer nsid triggers an
idr_get_next() warning during netns cleanup. With panic_on_warn, this
panics the kernel.

alloc_netid() also overflows reqid + 1 for this nsid. Use
idr_alloc_u32() for requested IDs and idr_get_next_ul() for cleanup so
the cursor can advance past INT_MAX.

QEMU/KVM reproduced the warning without kernel changes or fault
injection. The same reproducer ran without warnings after this change.
Kernel selftests were not run.

Fixes: 7acee67a6bce ("netns: optimize netns cleaning by batching unhash_nsid calls")
Cc: stable@vger.kernel.org
Signed-off-by: Zhao Gongyi <zhaogongyi@bytedance.com>
---
 net/core/net_namespace.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 52c2bd447..9d530ac41 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -270,14 +270,19 @@ static void ops_undo_single(struct pernet_operations *ops,
 /* should be called with nsid_lock held */
 static int alloc_netid(struct net *net, struct net *peer, int reqid)
 {
-	int min = 0, max = 0;
+	u32 id;
+	int ret;
 
 	if (reqid >= 0) {
-		min = reqid;
-		max = reqid + 1;
+		id = reqid;
+		ret = idr_alloc_u32(&net->netns_ids, peer, &id, id,
+				    GFP_ATOMIC);
+		if (ret)
+			return ret;
+		return id;
 	}
 
-	return idr_alloc(&net->netns_ids, peer, min, max, GFP_ATOMIC);
+	return idr_alloc(&net->netns_ids, peer, 0, 0, GFP_ATOMIC);
 }
 
 /* This function is used by idr_for_each(). If net is equal to peer, the
@@ -639,10 +644,10 @@ static void unhash_nsid(struct net *last)
 	 * use for_each_net_rcu() or net_rwsem.
 	 */
 	for_each_net(tmp) {
-		int id = 0;
+		unsigned long id = 0;
 
 		spin_lock(&tmp->nsid_lock);
-		while ((peer = idr_get_next(&tmp->netns_ids, &id))) {
+		while ((peer = idr_get_next_ul(&tmp->netns_ids, &id))) {
 			int curr_id = id;
 
 			id++;

base-commit: 070411c1590c8172eb4d86f045d99c372f22fe23
-- 
2.39.5 (Apple Git-154)
