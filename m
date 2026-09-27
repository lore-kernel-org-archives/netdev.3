Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901883B774F
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 20:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790540681; cv=none; b=bOJDZZbZHvPZu+rSB3sz7dNq5IqdBTCk2+xoEFZRQlJxjRwRGv9IpqbYeo6+gKu3kgTkfPS5pvrIu5w9ZSBz6mT9jUHm0myze97WGdI1RBw9uPJN5zixd9v2bgGDEzP0yMbJmumDHy+7bL8IFyveIOTu9kAOcXAvvmgSvrBhWKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790540681; c=relaxed/simple;
	bh=ETn6hdtVVixVEsoRm7dymaTSNMzsw7TMMqU4RKRq4Bk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=dVlu9qJKWgqeALGB6tNiDuIGvt5G3I0gDQZ9HMX31XqP9j1Vkb3Bdg57lFQJRTedgD2rdF53LlJR0ie26mmwKBNXXVscoWtVwnpp8oESxs71NHeEGyCGieJljT7TlMkPGdC2sjKBkvnIfbBSGhLDD7UMqdrhZ1goCgV0oJZZblo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RlyXYn/u; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RlyXYn/u"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-39e3f521346so2624044a91.0
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 13:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790540679; x=1791145479; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oTTqoC9bGTP6qYkgMrL42hX2TsVoR/7k9QwPzabb34Q=;
        b=RlyXYn/uEjcPrq4IR/FdTCaDO8gAh+4+q7CjUFIzV5DIhaeeWNUf9wA3luD5PGwTNN
         EWXIDUEyw0SSzST3SiIvk61cxl/GmCh0F+jIsy2juG9j98DweepEK9xveOSlQeGmPM1G
         esV5RMhc+9aYSb3Egf+gnK6R6YojcWMBzmhU0LsF2SwHRSxQ9jAQ4Y+cpkT5+zcV3ADS
         qxojcTgq9e9OGxdY6pPRI+qjlR7TY673Ik2fFvwxqgFRFFPg6QHXDXTGABOPP+8SEGRo
         l/RZ5+yDc6EqXjG13m/PwTsfUxTEEbD5shgBnuthiB0tXD3OPtgukNDjR9oBZFyDfL3g
         qE1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790540679; x=1791145479;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oTTqoC9bGTP6qYkgMrL42hX2TsVoR/7k9QwPzabb34Q=;
        b=he3VYot04mafGM+5FuLhOEA7IfLeOrHAsg9dslWxNFflI9eGQ4qDNeRrqCQ+l6om96
         cZFyLKzM1HGSAwObgJm9sys4GmdupfTVYZDgXrpUvXLyhg9ilP/J9qzrrEvdbj0nwZf6
         bUJwJMZEa6Rs9za2KEWePN2p3XgbYFeRtNLgzpt/GbkZw4kMfi7O/Irr2DcVSkDKOTGp
         Tabz0pqYUNwVQ1tPlqm4N+HWrHSxwrzJpuecOtMp1nfKyjQqegObPxuCfFWtmstMegTX
         EWyDI4hUFq+TipuoZXMEjJzkIORytQCjcicxqGqOVlbMK7iM4+zJQX7zA/5TXJ+GRxtc
         e4rQ==
X-Forwarded-Encrypted: i=1; AKwUvBxedA0jrzmLVVfV/30uS6Ty+e+9oDwGN+QoEfZA6SqyzkOlhlVMyPyt3+6qW1d/nlhRbpsf5Wo=@vger.kernel.org
X-Gm-Message-State: AFq9FYK5GIvKzQbhL2cdGG203/MUUQz+WKt5KPMG6gxvlw+Kimz0tkVn
	WMVzZFJ2GSiQhLyH4OZTOYBZB7YCL/VvJMUAiXetiAZjsSHVaBq35H/AoiIH9MYwdEJrig6CTY+
	rggbM0A==
X-Received: from pjqs1.prod.google.com ([2002:a17:90a:ad81:b0:3a0:be00:29af])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:2748:b0:3a0:7dea:6dd4
 with SMTP id 98e67ed59e1d1-3a098570051mr8966170a91.7.1790540678632; Sun, 27
 Sep 2026 13:24:38 -0700 (PDT)
Date: Sun, 27 Sep 2026 20:23:38 +0000
In-Reply-To: <20260927202429.2452589-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260927202429.2452589-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260927202429.2452589-2-kuniyu@google.com>
Subject: [PATCH v1 net-next 1/5] net: Remove net->is_dying.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Chris J Arges <carges@cloudflare.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit 7acee67a6bce ("netns: optimize netns cleaning by batching
unhash_nsid calls") added the is_dying flag in struct net.

It is an alias of !check_net(net), and having two ways to represent
the same state is confusing.

Let's remove the flag.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/net_namespace.h | 1 -
 net/core/net_namespace.c    | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 46b4c67e2966..b4247e767d13 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -125,7 +125,6 @@ struct net {
 	 * it is critical that it is on a read_mostly cache line.
 	 */
 	u32			hash_mix;
-	bool			is_dying;
 
 	struct net_device       *loopback_dev;          /* The loopback */
 
diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index da5f881fbd3b..0e13de0cd36b 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -644,7 +644,7 @@ static void unhash_nsid(struct net *last)
 			int curr_id = id;
 
 			id++;
-			if (!peer->is_dying)
+			if (check_net(peer))
 				continue;
 
 			idr_remove(&tmp->netns_ids, curr_id);
@@ -681,7 +681,6 @@ static void cleanup_net(struct work_struct *work)
 	llist_for_each_entry(net, net_kill_list, cleanup_list) {
 		ns_tree_remove(net);
 		list_del_rcu(&net->list);
-		net->is_dying = true;
 	}
 	/* Cache last net. After we unlock rtnl, no one new net
 	 * added to net_namespace_list can assign nsid pointer
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

