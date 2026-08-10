Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D04183C1974
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 11:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786361761; cv=none; b=f7DJXj4Bu4myco41C8W3Yx2mniMBay5eOuDdPy2CHnftoE3fTdI+DKM7LjmIqsQMCmq+isfrK/MGhrPCLddiZSWT/Jl8R/gXAXG/kJQsXa6pF8+M1dCFL7McI9CRjJ46k1hOB/GOJNiBMfkgmD/dfL2fF/qNOWFb0RK/Jb+3yRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786361761; c=relaxed/simple;
	bh=Za7XUGIBrDMufcV0XC4PXfmcqtB8Mjn0HouJg58CGOY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CB6hCjuWheG+v2OPAH0NsWOqdGZTRd7mXrsGBE7Q2b6RyFl3qXCdtjCAtznlKqidww/gxFTFMy0HnjHkp4kjqeeRoE7PFYvgq3gsdN5UXJ+ZR+VMSjILzVYknIdjS4Y5rTvJ4IR8VSnQTJyxRLHK54Yz+kxgvrpWhkJjtABUG0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zpi281f6; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zpi281f6"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cf6d65d8a7so25357105ad.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 04:35:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786361759; x=1786966559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wFJbz/bMMl0zlR9CL+aL3jmzM2HCn9dNxoYO9TVpRtY=;
        b=Zpi281f6emfxhKQquMCqtpLa4wFak0DWRJo4lOnnt1vMr2DfyKzcACyzbrLV+OTqKB
         2KhJO1c9WOK+iE8TxD/ULHmAiYpegvTCb1jnc265hI2tuGr2R4DrkKs13fY9Xx0yOt6f
         +04I1a5ZOHXZJaQlfOcLrg0pvS8CMDMLgWPQnh5kXr2F6VRZ4XR4AbfjzTWAQ8z+7xx4
         mXxNmDmJnwXZ2TpYVqHXNsv1Zr35Cg9tCL+RPDiOiBUfgM726l5cE8r4bbnZO0/V2j3t
         Qa/efEOf/xZfrguCbrlP5lwXAgKootjNCSl0XPLg531sYkgdD8+RdGDmnDdT8x3esfAX
         v6Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786361759; x=1786966559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wFJbz/bMMl0zlR9CL+aL3jmzM2HCn9dNxoYO9TVpRtY=;
        b=FXwnd/w9vV92gE8xomvdi32uXpWGs0DmDVtKhLmWPgrNjbGPEEfuc9YS14MFNJMaeS
         ZuqY4fVKN3bmg9p6BLUkb39ax0+t3K6OQRBzDUgXNRfaqQjdwuSXigBLwngz+bPfsELr
         aQz4XehUaOhu+r0uRSPnrUzhU/z+8Mwml38UVAiJwHDp6BeQhxS8ziov/CtZDrWl0oEC
         v/Ndk85UMw9UpH3V0hnk398eax1UC642gNVHccl0Jju95omnhHnC6AMHTYTFFcRJCgG2
         FoBQ5ycn+NK5Drj17500gdr6Pt3ay/kJqsbcJrPQujl0s4LA2+IgSlfqfmomwpv3wHxI
         s4Uw==
X-Forwarded-Encrypted: i=1; AHgh+Rr3cdERtttpeXEUXoAxOCkJMWlKUMvncmNIJuqjPiEB2f2paLqghXlAAlMyB5CznHW9ml6blSs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrd1X6qRdhCYr/YLkaLyKLaKC1i3wnqCyxK8gL4x0cRGCheG9p
	y7oWIAfRq8xanIkUawZk6NjLEHL2Jpp9MC1tvj44sPQz6RLc6tvXfYhk
X-Gm-Gg: AR+sD13RZwXEgy/oYOiFZgW11wA2AM4c0OoMIhVqV7UvVbFc06eSsAs+6Nul3pFZEdA
	Veu7Ef5YM/mcRc85ftmNivPcIzclzto/wQtPcaoP8JES+9/1WyxnNCTPXuK5M8GZCP0jUQbdJgi
	ijC+anmdlLLrA8+LkVfC7NffQ0yzr/dAuM1dKRehamvPIJvVCECgw93pbPP0uUn1CIjtqRjYrYR
	s5ULUKZDN5s9vitq562mCzfvWpbwBIcvKeDFOgiZU3cd55culqgOcs4p+Cz0Hs6MKA/s2pWXXfs
	l5ft+ckjL2wM4IKyPnK0MYjNMJz2JdDPmWN541O2LOFqXjAszsNcDjOKkCSO1E11wXL8T4swf5C
	9MF4X00RPe/H7kXNqmkgoERYNqPN1dYUrFUfiYjoF2xcnGPUrH4fYEXGzwnF9I1zAsXm2gjpeRG
	/hjuimsG/6rf3c0kNQbqi5C5tepKHqXBXzpGs2F1W0OY6DOJgKjC4BG40r3riivZAuIw==
X-Received: by 2002:a17:903:4688:b0:2ce:fa3a:45f7 with SMTP id d9443c01a7336-2d294c490d6mr244427775ad.16.1786361758903;
        Mon, 10 Aug 2026 04:35:58 -0700 (PDT)
Received: from TENCENT64.site ([103.7.29.106])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d16c4fc743sm34049575ad.80.2026.08.10.04.35.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 04:35:58 -0700 (PDT)
From: Fourie Zhang <littleddfu@gmail.com>
X-Google-Original-From: Fourie Zhang <fouriezhang@tencent.com>
To: pablo@netfilter.org,
	netfilter-devel@vger.kernel.org
Cc: Fourie Zhang <fouriezhang@tencent.com>,
	stable@kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH nf] netfilter: nf_tables: don't queue packet path object notifications
Date: Mon, 10 Aug 2026 19:35:01 +0800
Message-ID: <20260810113525.2695823-1-fouriezhang@tencent.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All file:line references below are against v7.2-rc4 (ac5b0e5651b1). The
trace was captured on 7.2.0-rc6-kasan72rc6 (075b74841bd0), where the same
lines apply.

nft_obj_notify() is exported and reached from the packet path. Its only
in-tree caller is nft_quota_obj_eval() (net/netfilter/nft_quota.c:68),
which notifies with GFP_ATOMIC while evaluating a rule for a transiting
packet, holding no mutex.

Since commit 67cc570edaa0 ("netfilter: nf_tables: coalesce multiple
notifications into one skbuff") that notification is no longer sent
immediately. __nft_obj_notify() queues it onto nft_net->notify_list via
nft_notify_enqueue() (net/netfilter/nf_tables_api.c:1211), which is a bare
list_add_tail(). notify_list has no lock of its own
(include/net/netfilter/nf_tables.h:1951), it is serialised by commit_mutex:
the six other enqueue sites all run inside a netlink transaction, and the
drain in nft_commit_notify() (net/netfilter/nf_tables_api.c:10746) does
list_del() + kfree_skb() from nf_tables_commit() with commit_mutex held.

Sending packets through a chain that references a depleted quota object
therefore races an unlocked list_add_tail() against list_del() +
kfree_skb() on another CPU. The WRITE_ONCE(prev->next, new) in __list_add()
then stores through an sk_buff that has already been freed:

  BUG: KASAN: slab-use-after-free in __nft_obj_notify+0x2c5/0x2d0
  Write of size 8 at addr ff110001047183c0 by task poc/76
  CPU: 0 UID: 1000 PID: 76 Comm: poc Tainted: G  W  7.2.0-rc6-kasan72rc6 #4
  Call Trace:
   <IRQ>
   __nft_obj_notify (include/linux/list.h:164 include/linux/list.h:191
                     net/netfilter/nf_tables_api.c:1211
                     net/netfilter/nf_tables_api.c:8743)
   nft_quota_obj_eval (net/netfilter/nft_quota.c:68)
   nft_do_chain_inet
   nf_hook_slow
   __ip_local_out
   ip_push_pending_frames
   udp_send_skb
   udp_sendmsg
   __x64_sys_sendto

  Allocated by task 77:
   __alloc_skb (net/core/skbuff.c:704)
   __nft_obj_notify (include/net/netlink.h:1055
                     net/netfilter/nf_tables_api.c:8731)
   nft_quota_obj_eval (net/netfilter/nft_quota.c:68)
   nft_do_chain

  Freed by task 79:
   nf_tables_commit (include/linux/skbuff.h:1332
                     net/netfilter/nf_tables_api.c:10759
                     net/netfilter/nf_tables_api.c:11185)
   nfnetlink_rcv_batch (net/netfilter/nfnetlink.c:574)
   netlink_unicast
   netlink_sendmsg

  The buggy address belongs to the cache skbuff_head_cache of size 232

Queueing from the packet path is wrong even leaving the race aside:
notify_list is only drained by nft_commit_notify() from nf_tables_commit()
(:11185), so a notification enqueued outside a transaction is not sent
until some later netlink batch commits, if one ever does.

The gfp argument that nft_obj_notify() still takes is a leftover of the
pre-67cc570edaa0 behaviour, where this path called nfnetlink_send()
directly. Restore that: split the message construction out into
nft_obj_notify_alloc() and let each caller decide what to do with the skb.
nft_obj_notify(), the exported one reached from the packet path, sends it
straight away; nf_tables_obj_notify(), which runs under commit_mutex, keeps
queueing it, so transaction notifications are still coalesced.

Fixes: 67cc570edaa0 ("netfilter: nf_tables: coalesce multiple notifications into one skbuff")
Cc: stable@kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Assisted-by: tencentos-corvus-ai:kimi-k3
Signed-off-by: Fourie Zhang <fouriezhang@tencent.com>
---
A KASAN reproducer for this issue is available if requested.

 net/netfilter/nf_tables_api.c | 36 ++++++++++++++++++++++-------------
 1 file changed, 23 insertions(+), 13 deletions(-)

diff --git a/net/netfilter/nf_tables_api.c b/net/netfilter/nf_tables_api.c
index af357f6c5070..ac0211758790 100644
--- a/net/netfilter/nf_tables_api.c
+++ b/net/netfilter/nf_tables_api.c
@@ -8715,18 +8715,17 @@ static int nf_tables_delobj(struct sk_buff *skb, const struct nfnl_info *info,
 	return nft_delobj(&ctx, obj);
 }
 
-static void
-__nft_obj_notify(struct net *net, const struct nft_table *table,
-		 struct nft_object *obj, u32 portid, u32 seq, int event,
-		 u16 flags, int family, int report, gfp_t gfp)
+static struct sk_buff *
+nft_obj_notify_alloc(struct net *net, const struct nft_table *table,
+		     struct nft_object *obj, u32 portid, u32 seq, int event,
+		     u16 flags, int family, int report, gfp_t gfp)
 {
-	struct nftables_pernet *nft_net = nft_pernet(net);
 	struct sk_buff *skb;
 	int err;
 
 	if (!report &&
 	    !nfnetlink_has_listeners(net, NFNLGRP_NFTABLES))
-		return;
+		return NULL;
 
 	skb = nlmsg_new(NLMSG_GOODSIZE, gfp);
 	if (skb == NULL)
@@ -8740,16 +8739,17 @@ __nft_obj_notify(struct net *net, const struct nft_table *table,
 		goto err;
 	}
 
-	nft_notify_enqueue(skb, report, &nft_net->notify_list);
-	return;
+	return skb;
 err:
 	nfnetlink_set_err(net, portid, NFNLGRP_NFTABLES, -ENOBUFS);
+	return NULL;
 }
 
 void nft_obj_notify(struct net *net, const struct nft_table *table,
 		    struct nft_object *obj, u32 portid, u32 seq, int event,
 		    u16 flags, int family, int report, gfp_t gfp)
 {
+	struct sk_buff *skb;
 	char *buf = kasprintf(gfp, "%s:%u",
 			      table->name, nft_base_seq(net));
 
@@ -8762,17 +8762,27 @@ void nft_obj_notify(struct net *net, const struct nft_table *table,
 			gfp);
 	kfree(buf);
 
-	__nft_obj_notify(net, table, obj, portid, seq, event,
-			 flags, family, report, gfp);
+	/* Called from the packet path, holding no mutex: notify_list is
+	 * serialised by commit_mutex, so send this notification directly.
+	 */
+	skb = nft_obj_notify_alloc(net, table, obj, portid, seq, event,
+				   flags, family, report, gfp);
+	if (skb)
+		nfnetlink_send(skb, net, portid, NFNLGRP_NFTABLES, report, gfp);
 }
 EXPORT_SYMBOL_GPL(nft_obj_notify);
 
 static void nf_tables_obj_notify(const struct nft_ctx *ctx,
 				 struct nft_object *obj, int event)
 {
-	__nft_obj_notify(ctx->net, ctx->table, obj, ctx->portid,
-			 ctx->seq, event, ctx->flags, ctx->family,
-			 ctx->report, GFP_KERNEL);
+	struct nftables_pernet *nft_net = nft_pernet(ctx->net);
+	struct sk_buff *skb;
+
+	skb = nft_obj_notify_alloc(ctx->net, ctx->table, obj, ctx->portid,
+				   ctx->seq, event, ctx->flags, ctx->family,
+				   ctx->report, GFP_KERNEL);
+	if (skb)
+		nft_notify_enqueue(skb, ctx->report, &nft_net->notify_list);
 }
 
 /*
-- 
2.43.7

