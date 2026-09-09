Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0BA652ED3A
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 23:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788996710; cv=none; b=AC917Aix5zx8CCxbQN6ygDAUZLzfuKIQLFb6+rLisFZPK9FT/UpdTzV18fhINcrkWmi1uD7Rkrzr8u8xkxVxEiVyCkYti1xqdnRCu8HUL4Uiubuc7ILGFcdof7SxmCDL1epcFMMiQGzciqcSLNkWj3anLDRfAhrOIu93qVKfK0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788996710; c=relaxed/simple;
	bh=ogpnjg9EHuwttW4EeRT9ztT5+TsFUrKo76LIWUwzq6U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bdbdG4FlyZkONbNvsjHhqukiGVQNx2sAXIOtgFO1LxeRyOS1iqWTjsiRWcaWeBjP2RhOkB1ZoYb7ti1w4997lkscnmv+LfAkVKmJMMj6gD0r7xG8usFxhMRuz3Dz/b9svP5KOrlmwZGzyNiT4Si81pARPhW05mHBoLcpFLYq5yU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=F0YGWFng; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="F0YGWFng"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc11b5dd54dso11423381a12.3
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 16:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788996708; x=1789601508; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ataNvfkWB/NN6CojkzVq4CWg0cWNV5/PZgWeyeWCXBc=;
        b=F0YGWFngcAlyCvWyi+RTLfEPLMbtVDPksAqeOfkDTFIVcWqY/bPOHtbV4B7Y4GKz4+
         /pi2EuU1ZY/oZ5s6rHqNNikA0CrOA+1Mu8tauqo597yq3ul2rCmgGkTCBj+A/T7W2vi9
         ESf7BBGJAm8JghsTlAaOS7ZcWYRAsljhwMsqYx/uLdageQLSv2GvVcVBCB9t4W9A8tAv
         Z1HYRyKiWZlS68g89Xhq3uaAZ2jIiONMNFd8Yfa8XINV4aZc52jeZsPXyKj1sHruzQdG
         dsepogtxfPjl+4eBo35BSr5GErRf4A1ZEbY6Yw0PM1Isf5t3E/3+q+JhBOurudikqAHH
         dEFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788996708; x=1789601508;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ataNvfkWB/NN6CojkzVq4CWg0cWNV5/PZgWeyeWCXBc=;
        b=mwvxitOaNjnYmZeGmyGPPlbseVaMyaKOWBAwCTbXqJBSnhKsk/rVr7lhws+xLg2z2t
         9ZWbc9mCE9m1oV5WT6IjCJ14f4gY4iaQjJGBV++65BVA0cifIt2B+hd+6Ed+2zvnFKi6
         Xp3l++gzr0sBTLRAlhvzER6bnRHRHD0Pht2PRXs3hYB0TdbYcoVxDhDg2QhdYM6eCQyA
         o6cRvuakObJv3U0vLV6kxskgpj5ZNFYHnqGENsps4UvO25sF3xqubp6vZ7/lPNQyNBAV
         mVhtnUui33i1v/phmJuQLCWwY77OfsvnfemKIib9NT9crL470OQKfkdAvCcSkhLXnIoK
         aAeA==
X-Forwarded-Encrypted: i=1; AKwUvBzBtV8PS2Gz9gljLB/S49VQOOL55xL3+CdrnRCD6GlcUxvlOdQy+lKeSTasqNAvez6vbhO7mho=@vger.kernel.org
X-Gm-Message-State: AFuF++ktJHIu2J807yHMts8xTneTHp8IBX+XN2mHKGjkuBMb6fhgtpdm
	mduo3qINlG8FjlRbfvEj8rPCkZU5PXvZ7c04JGW2UpSUJbazwA+rfXQfc+zXlyFMXTycMMsxMWk
	FSI1a0A==
X-Received: from pfbdl6.prod.google.com ([2002:a05:6a00:4906:b0:847:7765:a4c3])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:4cc1:b0:3d3:ae50:97cc
 with SMTP id adf61e73a8af0-3da3a1f02e7mr57084941637.25.1788996707894; Wed, 09
 Sep 2026 16:31:47 -0700 (PDT)
Date: Wed,  9 Sep 2026 23:31:26 +0000
In-Reply-To: <20260909233143.2401847-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260909233143.2401847-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260909233143.2401847-5-kuniyu@google.com>
Subject: [PATCH v3 net 4/4] neighbour: Skip default parms when resumed in neightbl_dump_info().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Ido Schimmel <idosch@nvidia.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Thomas Graf <tgraf@suug.ch>
Content-Type: text/plain; charset="UTF-8"

neightbl_dump_info() calls neightbl_fill_info() in each loop
to render the default parms.

If there are many devices and neightbl_fill_param_info() failed,
neightbl_fill_info() is called again when the dump resumes:

  # ynl --family rt-neigh --dump getneightbl --output-json |
    jq '.[] | {name: .name, ifindex: .parms.ifindex}'
  ...
  {
    "name": "ndisc_cache",
    "ifindex": null
  }
  ...
  {
    "name": "ndisc_cache",
    "ifindex": 6
  }
  {
    "name": "ndisc_cache",
    "ifindex": null
  }
  {
    "name": "ndisc_cache",
    "ifindex": 5
  }

Let's skip neightbl_fill_info() if it is already called in
neightbl_dump_info().

Note that we cannot use !neigh_skip instead of !default_skip
because default_skip == 1 && neigh_skip == 0 could be true
if the first neightbl_fill_param_info() fails.

Also, nidx must be cleared at the end of each table loop;
otherwise, if neightbl_fill_info() for a subsequent table
fails, the leftover nidx from the previous table would be
saved in cb->args[1], resulting in erroneously skipping parms
of the subsequent table in the next dump.

Fixes: c7fb64db001f ("[NETLINK]: Neighbour table configuration and statistics via rtnetlink")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
Cc: Thomas Graf <tgraf@suug.ch>
---
 net/core/neighbour.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index 02bf940ce00a..7448320f7ad5 100644
--- a/net/core/neighbour.c
+++ b/net/core/neighbour.c
@@ -2587,9 +2587,10 @@ static int neightbl_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	const struct nlmsghdr *nlh = cb->nlh;
 	struct net *net = sock_net(skb->sk);
+	int default_skip = cb->args[2];
+	int neigh_skip = cb->args[1];
 	int family, tidx, nidx = 0;
 	int tbl_skip = cb->args[0];
-	int neigh_skip = cb->args[1];
 	struct neigh_table *tbl;
 
 	if (cb->strict_check) {
@@ -2613,12 +2614,13 @@ static int neightbl_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 		if (tidx < tbl_skip || (family && tbl->family != family))
 			continue;
 
-		if (neightbl_fill_info(skb, tbl, NETLINK_CB(cb->skb).portid,
+		if (!default_skip &&
+		    neightbl_fill_info(skb, tbl, NETLINK_CB(cb->skb).portid,
 				       nlh->nlmsg_seq, RTM_NEWNEIGHTBL,
 				       NLM_F_MULTI) < 0)
 			break;
 
-		nidx = 0;
+		default_skip = 1;
 
 		list_for_each_entry_rcu(p, &tbl->parms_list, list) {
 			if (!net_eq(neigh_parms_net(p), net))
@@ -2641,12 +2643,15 @@ static int neightbl_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
 		}
 
 		neigh_skip = 0;
+		nidx = 0;
+		default_skip = 0;
 	}
 out:
 	rcu_read_unlock();
 
 	cb->args[0] = tidx;
 	cb->args[1] = nidx;
+	cb->args[2] = default_skip;
 
 	return skb->len;
 }
-- 
2.55.0.1003.g10538fe699-goog

