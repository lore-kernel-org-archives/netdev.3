Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D3F43F085
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 21:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788818349; cv=none; b=pwUnKo6UO79ksQNqL8H/E15BcKiFFenzgkW5Rsa12Xgpn+5vuLsp8/5j7HLdqC1Rw1vOn5Avu6SUOj5yHKCekXrfPGBm1tfnNU9TZfGVntvmwPpVGXupsF/HztNA5wETnoIQa03dT0zpM+ED9fC7E1Z6hA7yOU2uH5WJb6rmJao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788818349; c=relaxed/simple;
	bh=w9s+vHN1FXjB5iCqYhrGKQ88ZZz+PO+yUdeKxICuMRQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YWTYFeR+MniNcxHjMXJh56Q/R2BBhTXRVzQ3fb5HORkCT6lmKWJpd/qFh2haER4jtvb1mf+gQEYadjDUQNcfAyLWjDuXHAZyF7AuoqkH6/IZuyyDV1fBzbOjKGjIBExRiNFJSiuQ4AOfZrvj197XOfwwWhPUvkDZGArS3YxAwhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=L5RO5g6g; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="L5RO5g6g"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cc44d708055so6831107a12.0
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 14:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788818339; x=1789423139; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jP3srBJi0U2aAGHMFnbOVO4DS+SOu4/3e3TxeET0oBg=;
        b=L5RO5g6gp/BTamXLdJgWHa9xtevlKlafknkYNjU3yEj6UYqHopEucGduds7FJ8Wz/x
         GciUFuCYzr4ETEan5blpRQp2+Oc3DLk7gWU8rvJhEBxgXsh4J4Ocf2wVORMhU31TdUVV
         6E4fJBCyUesN99se2D5Wyxjmi0THB+Mlp2upM8U413H89MktFXvtXCqtemAy2dIuMHNk
         qUKclhLnp9vrDYJoG8SmQVadUWYjVqe/2Gss9rp/tJwRNOMWdhEV3ESDOPZihMZ9HwlI
         IQSFMpsC8AMrTKAzE5oGW+mn1dz4UqHGtN3xvka6nig+KTafjMSSGn4eaRyWdOyfVzPj
         9vPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788818339; x=1789423139;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jP3srBJi0U2aAGHMFnbOVO4DS+SOu4/3e3TxeET0oBg=;
        b=XHYbmlNGxf7a0QLGKsI02gOGCwLUz4fEZOnvM3NU1kDOzNnCLGacok4R2ICjrcVKei
         SkrT36WjZe3Udi+hbocIR1PIdAMBvpqqmawblTly0BMmiI+kqOez9KahP7xDMlKyflb/
         MaDM+X+NZIK+4pLdna8waVvk22GZ7Z5ExvlZz4sZqIkEl1NjzwUd6ojUw23Vzz176MX2
         f0XTgdSbBjyVlJTPAAihS0QHaHF+gpJnjGXuiFK0RsBAt7ALOjvVaucRdAk67Xjn2ZDk
         eigbkh26BK6rHNKSus2O6fPiq4fZZKUFyq1L6aTMr9ZQRAdLbgDNYmcNq4dkzEar0nmd
         DHYg==
X-Forwarded-Encrypted: i=1; AKwUvBxcLhj/iYBw5OkEd/vbeBUaT5ezc+lUfCgiQEJn5L++okUm3dPs80au6eOjjVkyXND63g+78b0=@vger.kernel.org
X-Gm-Message-State: AFuF++l9Lbczc4oeZufJUpEXuDYOAJnBbTqNZatv3Ziv1Y1wYLd8DK22
	MeHZI1/xMAFADQ3a+7whARYHkLp1hdTJR1EoF+d4dWHCPGGW9ACJ5HU3kt4OZ8kyBnoRWZAGCVm
	xqn4iNQ==
X-Received: from pgbdn3.prod.google.com ([2002:a05:6a02:e03:b0:cc1:fd7a:5316])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:3ca2:b0:3d1:7238:33d9
 with SMTP id adf61e73a8af0-3da39d18ce3mr39135944637.3.1788818339092; Mon, 07
 Sep 2026 14:58:59 -0700 (PDT)
Date: Mon,  7 Sep 2026 21:57:55 +0000
In-Reply-To: <20260907215853.3709987-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260907215853.3709987-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
Message-ID: <20260907215853.3709987-5-kuniyu@google.com>
Subject: [PATCH v1 net 4/4] neighbour: Skip default parms when resumed in neightbl_dump_info().
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

Fixes: c7fb64db001f ("[NETLINK]: Neighbour table configuration and statistics via rtnetlink")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
Cc: Thomas Graf <tgraf@suug.ch>
---
 net/core/neighbour.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/core/neighbour.c b/net/core/neighbour.c
index b90957b630ce..15eedaef6578 100644
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
 
 		p = list_first_entry(&tbl->parms_list, struct neigh_parms, list);
 		list_for_each_entry_continue_rcu(p, &tbl->parms_list, list) {
@@ -2642,12 +2644,15 @@ static int neightbl_dump_info(struct sk_buff *skb, struct netlink_callback *cb)
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

