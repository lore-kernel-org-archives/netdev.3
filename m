Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76E847DD72
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 16:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787070393; cv=none; b=GOHr0FF1rKVe80CXut+EEVtqU04sRXY3NxEmvReL9GJY5J31kUBxxzxxxySpRwFZWPsTeiVN0pIEfYOkMq3+/Zjr4rfXpCBX6e4gPj6u37+/r0RCfBrKEtSzKAxMKc+TZqFNSI5FpKSTrAhKl/v8WFCDuxbqob8vGwOPIPzzN9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787070393; c=relaxed/simple;
	bh=yhdaY1J8MnA6tqKv+lhtMDGyOOK8eRl17Sq8s/nGCTQ=;
	h=From:To:Cc:Subject:Content-Type:MIME-Version; b=BQvXp3eQw5l2byb89qas7NAm60Vp62cLCIUZnws0LGK2rwL0Pj3hH0knToECle9cFuRqHKh74lwnuFicex4hauQPJeuaWreKJwgsjSSXykBclthrSR39xLee582Y0J0NeNndfAL98/EfCgeowbdimJLWbP9qP5GiyXaXLB9z/Uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=WaaSv3Vf; arc=none smtp.client-ip=115.124.30.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="WaaSv3Vf"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1787070387; h=From:To:Subject:Content-Type:MIME-Version;
	bh=7n59TE4S7uOS57daBEA3cdY7B10K7KeM9O2QJahfbNE=;
	b=WaaSv3Vf8up/ZQcSsmyu1LNfJZ53Tg+WQFnNY1EgKSfwTnI9EZMvbXrUC5Zs64gzNw3udGuWi4bYIKvIxB2Hjwdiusw2rEgYygSaCMY7HyvBSTEoIjKAKd3IBa6MhB/FB7aeIf0bEudOWwgRAJXw4r7OJ0C5efGN23C3GAWKlis=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=chuyf26@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0X9E1v7Y_1787070386;
Received: from x31j07255.sqa.na131(mailfrom:Chuyf26@linux.alibaba.com fp:SMTPD_---0X9E1v7Y_1787070386 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 19 Aug 2026 00:26:27 +0800
From: Chuyf26 <Chuyf26@linux.alibaba.com>
To: Jon Maloy <jmaloy@redhat.com>
Cc: Ying Xue <ying.xue@windriver.com>, netdev@vger.kernel.org
Subject: [PATCH] tipc: limit the memory pinned by incomplete fragment chains
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <20260818162631.BkZArZv-Xe3-m6YWgH4d-yyQty3HogfTBj93Zh1Q9Wo@z>

Fragment chains are reassembled per link and kept in memory until the
last fragment arrives.  There is no limit on how much memory one
in-flight chain may pin: a peer can send first and middle fragments
without ever sending the last one, and every received packet resets
the link silence counter, so the link never times out and the chains
are never freed.  Repeated with many chains this grows kernel memory
unboundedly.

The path is: fragments arriving on a bearer are delivered by tipc_rcv()
to the link, tipc_link_input() recognizes MSG_FRAGMENTER messages and
appends them to the per-link reassembly queue through tipc_buf_append(),
which charges the accumulated size against the head buffer.  The only
symptom is kernel memory growing until the system runs out of it.

A legitimate reassembled message can never exceed MAX_MSG_SIZE, so
drop a chain once its accumulated size exceeds twice that value.

Fixes: 13e9b9972fa0 ("tipc: make tipc_buf_append() more robust")
Reported-by: Abaci <abaci@linux.alibaba.com>
Assisted-by: abaci:qwen3.8-max
Signed-off-by: Chuyf26 <Chuyf26@linux.alibaba.com>
---
 net/tipc/link.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/net/tipc/link.c b/net/tipc/link.c
index 6c6d8546c578..adbfdc5058cb 100644
--- a/net/tipc/link.c
+++ b/net/tipc/link.c
@@ -1340,7 +1340,22 @@ static int tipc_link_input(struct tipc_link *l, struct=
 sk_buff *skb,
 		if (tipc_buf_append(reasm_skb, &skb)) {
 			l->stats.recv_fragmented++;
 			tipc_data_input(l, skb, inputq);
-		} else if (!*reasm_skb && !link_is_bc_rcvlink(l)) {
+		} else if (*reasm_skb) {
+			/* A legitimate reassembled message can never exceed
+			 * MAX_MSG_SIZE. Limit the memory one incomplete
+			 * fragment chain can pin, otherwise a peer can grow
+			 * kernel memory unboundedly by streaming fragment
+			 * chains that never complete: received traffic also
+			 * resets the link silence counter, so the link never
+			 * times out and the chains are never freed.
+			 */
+			if ((*reasm_skb)->truesize > 2 * MAX_MSG_SIZE) {
+				pr_warn_ratelimited("Fragment chain larger than %u bytes, dropping\n",
+						    2 * MAX_MSG_SIZE);
+				kfree_skb(*reasm_skb);
+				*reasm_skb =3D NULL;
+			}
+		} else if (!link_is_bc_rcvlink(l)) {
 			pr_warn_ratelimited("Unable to build fragment list\n");
 			return tipc_link_fsm_evt(l, LINK_FAILURE_EVT);
 		}
--=20
2.43.5
