Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08F534156FE
	for <netdev@vger.kernel.org>; Wed,  5 Aug 2026 09:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923748; cv=none; b=Gz5m/fhaZ2OG2Rz+qEfVVgCMY3UQOePWUFPmYIoRJjXUWm6gFeQoRm2A36SbbpaJTLvLbEfKUujFoxbDwAi0rYAJnNeJ3DAteYT8cdEdbr+nzIfOQAZGpOZG/DnEIDa3WJoct4eUBijIRcyw7CD+GzzIGmpoMFQu2CshTg+boss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923748; c=relaxed/simple;
	bh=S3jAes5Vwu16hn3Ows2pLgWHj4lYq7+xJmgG0qu2avQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XZTvrO/Uonyt14mpX24+r+xyLPOoe5lyoBKxIc4ihkjDJvSXUGHVnscoImH1brzVGuo0ViHaIPQIatAeAdypFALyl1xB9Ns5PrrKUONm+jp5G9aySrqbzU/eZb7J/vC3a9uaf/NWt2btMFauESsfyjs8/Ytv7VCTCpvpO1X/fpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0TER37D; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0TER37D"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38e3617ba36so760950a91.3
        for <netdev@vger.kernel.org>; Wed, 05 Aug 2026 02:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785923746; x=1786528546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/N7OqRJx+Yy9AA2X5acYkU9CpPQnRCTgU5dHMwvshPo=;
        b=D0TER37DT+4gvhv4oLcMQZc1U1sTQEbDJp1aLlZzKnNQ5HN2srKRnWxtd413qAhKH3
         d5+8rdnn2lxTER2Zj6MMTn8uAEOoFdW9AERsZWOals3DWUijdQ8gU3sRBxlnxH+yV+nP
         ZAVDMunxTPZyLY2kzpZwYLsu4YyFjyMTEH5QMOTawu8TzzVxj1sVJ89uUBnmCMQG1vMm
         18Oiq2SmtDZhWuukehi14PebOn8eiQn6WUy++XxMTA1ygdoqNkE3C5SPpKjp7tZtprcS
         tw7PSvoTYr3C6GpprSrx4b8A58CDIX51r/JJlm8aoR2LTiQPPQwaxRCjzgOVSBYE7NBR
         Iyhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785923746; x=1786528546;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/N7OqRJx+Yy9AA2X5acYkU9CpPQnRCTgU5dHMwvshPo=;
        b=PPTaG190K3LEvR/jjEGZBVphw6mZk17ygvNMTSTpfLl1ukoAl//SUuzkKXOBUU8Y+V
         GIq5tiuyM0e159c8pVWytBf9hoxRIMg0Gfzx5zXxDvUVT9zUYu2QozWP6zgqYXM2q8WY
         uVRw1Npa8HE+Z5xOuhRhftXjxRjJvyYrXdRIx0t/3BWWgYFVnXTC+9j9zdmw0l6nwHW5
         2Lr/a5Xhik2cuOllFObst/no3LzZvfdegFaU7hQcnjgoMPF2KtEq3SlFRUvXDvQzQKp9
         15IWtWtMBAHrDHMknfMCPVl3y3pFsAEZCj+Sdkz4MRzaNarNRbJ//s4tiCgRGDwhxWNj
         D5Gw==
X-Forwarded-Encrypted: i=1; AHgh+RpkzFJNfqvKBw7S9bkO9eWmW2Fa/k2NlivhzDRyPyRAbUwtJsZGCGbsjJL+41dcjd8xqNaLAu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUHbhqYqow5Xz830EkL+Gax2LlfY+/IypZfNn3mLE5gr1TdxFg
	qqNqDKU6eUXUse4/zxsdW0Mparso4oYFj6KfEAEVYUjv21J0gxlcbtWl
X-Gm-Gg: AR+sD13Q0rAtZ4OifblRX4X+Lp9ARESRAJUi/RiEs7Cwhb9iQEvUJvRGuNQnugmvJWw
	D/eqq1PUAEpnKfRwUpXppFQUwUW2G/zCHV/p1ADNGl18MBr1b/rCngKO8j/BKvdDxxe0h+on+FS
	Twk3nJIF0T0i72oLASYFUzs1b74iAYjtjRIWTaKts/UQrRPV/rWfRsF+GNnr0hK0YIKkgzZvdTM
	E/hzQO9cVmvIRqMhowV6bOOKrg47xhOaatC49hEOsYLs5HGxYbgs368RZXaLNENlxGUud+uZdRw
	pXAY60R5w2i/pp4wT9iC+qb+6/FgvfO62obdn3Z4PCAPYUQqRteELoTMXP0FRXxwRuafDfRTWo0
	wVCjSWsh3vAj/UhVHOGuX3RJGaNp+ImQAUEX8ilWzaJ4wunM3cw/xuoozC1X0w6dKTYHg3nBT8M
	3b0rF/C7jY4NJ4ws2iyFGhrA2s53RVW32/WmhBEQVrnuURGjLmqeTMvpJuV6YxxqF1RKKv7auaW
	M33Nmh+IScqg+4w5nm4tKUN3EZF03auX0qtIFg=
X-Received: by 2002:a17:90b:5203:b0:37d:f206:a2ac with SMTP id 98e67ed59e1d1-3903c598ce5mr6015939a91.7.1785923746041;
        Wed, 05 Aug 2026 02:55:46 -0700 (PDT)
Received: from BOOK-P74QMIQ7E8.localdomain ([163.239.22.31])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3903927dddbsm2672970a91.9.2026.08.05.02.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 02:55:45 -0700 (PDT)
From: hyunjungg <hj351016@gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Tao Liu <taoliu828@163.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net] net/sched: act_ct: fix sk_buff leak when the header checks reject a packet
Date: Wed,  5 Aug 2026 18:55:39 +0900
Message-Id: <20260805095539.204356-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hyunjung Ko <hj351016@gmail.com>

tcf_ct_handle_fragments() runs its header sanity checks before handing
anything to the defragmentation engine:

	if (family == NFPROTO_IPV4)
		err = tcf_ct_ipv4_is_fragment(skb, &frag);
	else
		err = tcf_ct_ipv6_is_fragment(skb, &frag);
	if (err || !frag)
		return err;

tcf_ct_ipv4_is_fragment() returns -EINVAL or -ENOMEM;
tcf_ct_ipv6_is_fragment() adds -EPROTO when ipv6_find_hdr() fails. None of
them frees or queues the skb, so on that path the caller still owns it.

tcf_ct_act() however funnels every non-zero return into the
ownership-transfer exit:

	err = tcf_ct_handle_fragments(net, skb, family, p->zone, &defrag);
	if (err)
		goto out_frag;
	...
out_frag:
	if (err != -EINPROGRESS)
		tcf_action_inc_drop_qstats(&c->common);
	return TC_ACT_CONSUMED;

TC_ACT_CONSUMED means the action took ownership of the skb, so no caller
frees it - sch_handle_ingress(), sch_handle_egress() and
tcf_qevent_handle() all deliberately skip the free for that verdict. The
skb is therefore orphaned: one sk_buff plus its data buffer is leaked per
malformed packet, unbounded. Note the drop counter is already incremented
for these errors, so the statistics claim a drop that never happens.

Three different ownership states reach out_frag: today - the skb may be
queued by the defrag engine (-EINPROGRESS), already freed by
nf_ct_handle_fragments(), or still owned by us. Tell the caller which of
those it is, and free the packet ourselves in the last case, which
restores the TC_ACT_SHOT behaviour that predated the Fixes: commit.

Reproduced on v7.2-rc6 with a 54-byte frame carrying a 40-byte IPv6
header with nexthdr = 0 (hop-by-hop) and nothing after it, on a
clsact ingress chain with "action ct". kmemleak reports one leaked
232-byte skbuff_head_cache object plus its 704-byte data buffer per
packet; with this patch it reports none.

Fixes: 3f14b377d01d ("net/sched: act_ct: fix skb leak and crash on ooo frags")
Cc: stable@vger.kernel.org # v6.8+
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 net/sched/act_ct.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

Reproducer needs CONFIG_NET_ACT_CT, plus CONFIG_DEBUG_KMEMLEAK and
kmemleak=on to observe it:

  ip link add veth0 type veth peer name veth1
  ip link set veth0 up; ip link set veth1 up
  tc qdisc add dev veth0 clsact
  tc filter add dev veth0 ingress matchall action ct

then inject at veth1 a 54-byte frame: ethertype 0x86DD, a 40-byte IPv6
header with nexthdr = 0 (hop-by-hop) and nothing after it, so
ipv6_find_hdr() fails with -EBADMSG and tcf_ct_ipv6_is_fragment()
returns -EPROTO.

Before, one sk_buff plus its data buffer per packet:

  kmemleak: 50 new suspected memory leaks
  unreferenced object 0xffff888103ed13c0 (size 232):
    kmem_cache_alloc_node_noprof+0x2f1/0x3e0
    __alloc_skb+0xe5/0x860
    alloc_skb_with_frags+0x82/0x750
    sock_alloc_send_pskb+0x658/0x7e0
    packet_sendmsg+0x1833/0x4860
    __x64_sys_sendto+0xe0/0x1c0
    do_syscall_64+0x102/0x5a0

After: kmemleak reports no unreferenced objects.

Note /proc/slabinfo is not a usable check here on a KASAN build -
skbuff_head_cache active_objs still grows because the quarantine holds
the freed objects. kmemleak is the reliable signal.

No selftest accompanies this: tdc drives tc(8) only and cannot inject
the malformed frame. A self-contained C reproducer is available on
request.

diff --git a/net/sched/act_ct.c b/net/sched/act_ct.c
index be535a261fa0..e250969c84ac 100644
--- a/net/sched/act_ct.c
+++ b/net/sched/act_ct.c
@@ -840,8 +840,15 @@ static int tcf_ct_ipv6_is_fragment(struct sk_buff *skb, bool *frag)
 	return 0;
 }
 
+/* On error, tells the caller whether it still owns @skb and must free it
+ * itself.  @skb is ours only when the header checks below reject the packet
+ * before it is handed to the defragmentation engine; once nf_ct_handle_
+ * fragments() has been called the skb is either queued (-EINPROGRESS) or has
+ * already been freed by it.
+ */
 static int tcf_ct_handle_fragments(struct net *net, struct sk_buff *skb,
-				   u8 family, u16 zone, bool *defrag)
+				   u8 family, u16 zone, bool *defrag,
+				   bool *skb_is_ours)
 {
 	enum ip_conntrack_info ctinfo;
 	struct tc_skb_cb cb;
@@ -859,8 +866,12 @@ static int tcf_ct_handle_fragments(struct net *net, struct sk_buff *skb,
 		err = tcf_ct_ipv4_is_fragment(skb, &frag);
 	else
 		err = tcf_ct_ipv6_is_fragment(skb, &frag);
-	if (err || !frag)
+	if (err) {
+		*skb_is_ours = true;
 		return err;
+	}
+	if (!frag)
+		return 0;
 
 	cb = *tc_skb_cb(skb);
 	err = nf_ct_handle_fragments(net, skb, zone, family, &proto, &cb.mru);
@@ -977,6 +988,7 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 	int nh_ofs, err, retval;
 	struct tcf_ct_params *p;
 	bool add_helper = false;
+	bool skb_is_ours = false;
 	bool skip_add = false;
 	bool defrag = false;
 	struct nf_conn *ct;
@@ -1012,9 +1024,18 @@ TC_INDIRECT_SCOPE int tcf_ct_act(struct sk_buff *skb, const struct tc_action *a,
 	 */
 	nh_ofs = skb_network_offset(skb);
 	skb_pull_rcsum(skb, nh_ofs);
-	err = tcf_ct_handle_fragments(net, skb, family, p->zone, &defrag);
-	if (err)
+	err = tcf_ct_handle_fragments(net, skb, family, p->zone, &defrag,
+				      &skb_is_ours);
+	if (err) {
+		/* The skb is still ours only when the header checks rejected
+		 * it; returning TC_ACT_CONSUMED for such a packet would leak
+		 * it, since no caller frees an skb it was told it no longer
+		 * owns.
+		 */
+		if (skb_is_ours)
+			goto drop;
 		goto out_frag;
+	}
 
 	err = nf_ct_skb_network_trim(skb, family);
 	if (err)
--
2.43.0
