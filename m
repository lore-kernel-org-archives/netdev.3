Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D907F3CFF71
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 06:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781245952; cv=none; b=D7gb2wuH3LXYTl028hshNu1M3UBkgYi1/INpFQcnIzGDVw/fXScdTPToX2UMg0OAMdC84gqJnPeuvMshSIIOMoSIu1jPv0hca96SdsHD71rPoiN7hy4UHWONX0SIWMoHg/fF9Adcy1pR/kCp+WTKapEVzABSWocMtW7o1uTar7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781245952; c=relaxed/simple;
	bh=kKYrFu/80BTVxnXpvi4xHdMjekFhhmSRB/MUNd0GfUE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZSOtth10dfaAKTSNBQMocq9oxi7i/+P3HjzN6DFjfi+y55yCQB+1GLusfixAgGWRMkRb2F/PoheKHOccLvminu84O/tR1cKSeYn1eGtE5aegOgUdxNehKzSw+9nwMbCw+zMEa5WCRCjf4CIzt1/xUA6QOglpjVEcAVm1r6vnG6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WUEc5xv0; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WUEc5xv0"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-36bcfce8a33so1453217a91.1
        for <netdev@vger.kernel.org>; Thu, 11 Jun 2026 23:32:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1781245950; x=1781850750; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pG/Ub5FypetWXZtDUnSoEZPXqns4AYiPcVhmhjfpDpE=;
        b=WUEc5xv0DdZqh7a8VsA0jDc68Beq6gNCr2K8eVAwU8ZclqnuYkfj7Zdm2pBuABK5BP
         AExyKbVUiIT+hdy8uhgJX5ekPkQmO5h0MhA/UM9NL8DCA+PLjK4g50UXma0wXhJ+Ge+n
         DXLdWt2zQSZ6IZpOGcLqUVCxUPpcSTjMBauS6FhmQV2N5F77v3P7JK7hmPLj0Ce32KAJ
         ovEnfv0w2fZSIImVDKQUuH17H7ewze5qCmBjpYHBjP6QgyMvXow8mLk36/jf7leorPdK
         JdHwhKzreND9IQ5IBGcBZQdME6l3oRoRyWLGrvjzHFPADhA2FBG00jihh53X5CY7lhaF
         Z8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781245950; x=1781850750;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pG/Ub5FypetWXZtDUnSoEZPXqns4AYiPcVhmhjfpDpE=;
        b=eaybW6RTZQ49XTsrRn3Ka7O3f9A9N5E/a2pmie88+rClhKBmILHcSEYrqqJJgc/tvR
         mJWdjNVDYh2FnGQ5DHNPz7wx+higW4yusEbVVKSk96xYue07HoO5nuWHjfVeMsVbZe+V
         tmhUmMm6vWgtvGGQ14Bvzdtw1tnKChb0qqDlIC3nTG5d7c1cxxKu23b7Vy/tRbNpoE5Y
         gdw414vMoU3BvkSIZ6Xvb2vFxw/cR+gNbPQ/QIUA+50Xcwzf2BOm74Db7wb1jjur0cpK
         nllXncw9AQik2oZLCpKpcXYePTN32qw8mF+jyCE7dfDc75128jCd49+XSxKtS9WqFGV0
         qLyA==
X-Forwarded-Encrypted: i=1; AFNElJ+qd3NUgzHfNjEV8OZ1P2CEdDua3kl2meMXpWEEBvN498faSD+INwmCT3cpiUOyM58yvT4ifvM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyu1IqAGTHnRH+9EvalXMLMOOEjkILvnEIHZ2fpxGZFS9pQyEpt
	n/n2sgJiXEBNzBQQ6tXlKt+16i4NtThMzNuzXGDvcyoeYpA9Cc9EwuSD4Ks4e3T1dv78B8jkdvx
	WQdxH1A==
X-Received: from pjbmh13.prod.google.com ([2002:a17:90b:4acd:b0:377:4a58:fdfb])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:5205:b0:36b:769c:c037
 with SMTP id 98e67ed59e1d1-37a1e0084cdmr914447a91.5.1781245949901; Thu, 11
 Jun 2026 23:32:29 -0700 (PDT)
Date: Fri, 12 Jun 2026 06:32:04 +0000
In-Reply-To: <20260612063225.455191-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260612063225.455191-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
Message-ID: <20260612063225.455191-2-kuniyu@google.com>
Subject: [PATCH v1 net-next 1/5] ipv4: fib: Flush all fib_info in
 fib_table_flush() during netns dismantle.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Even when fib_table_flush() is called with flush_all true, it does
not flush all fib_info due to this condition:

  !(fi->fib_flags & RTNH_F_DEAD) && !fib_props[fa->fa_type].error)

This creates an implicit ordering between default_device_exit_batch()
and fib_net_exit_batch().

fib_table_flush(flush_all=true) must be called after all devices
are NETDEV_UNREGISTERed, which is after nexthop_flush_dev() marks
RTNH_F_DEAD.

This would cause memory leak if the order were reversed.

fib_table_flush() does not skip non-dead error routes when flush_all
is true:

  !flush_all &&
  !(fi->fib_flags & RTNH_F_DEAD) && fib_props[fa->fa_type].error

Let's merge the two conditions not to skip all non-dead fib_info
during netns dismantle.

Note that we could further apply !flush_all to the basic table
id check and the rtmsg_fib() call in the loop.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/fib_trie.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index 1308213791f1..07068207b888 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -2046,18 +2046,12 @@ int fib_table_flush(struct net *net, struct fib_table *tb, bool flush_all)
 		hlist_for_each_entry_safe(fa, tmp, &n->leaf, fa_list) {
 			struct fib_info *fi = fa->fa_info;
 
-			if (!fi || tb->tb_id != fa->tb_id ||
-			    (!(fi->fib_flags & RTNH_F_DEAD) &&
-			     !fib_props[fa->fa_type].error)) {
+			if (!fi || tb->tb_id != fa->tb_id) {
 				slen = fa->fa_slen;
 				continue;
 			}
 
-			/* When not flushing the entire table, skip error
-			 * routes that are not marked for deletion.
-			 */
-			if (!flush_all && fib_props[fa->fa_type].error &&
-			    !(fi->fib_flags & RTNH_F_DEAD)) {
+			if (!flush_all && !(fi->fib_flags & RTNH_F_DEAD)) {
 				slen = fa->fa_slen;
 				continue;
 			}
-- 
2.54.0.1136.gdb2ca164c4-goog

