Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A65A3EB801
	for <netdev@vger.kernel.org>; Fri, 15 May 2026 22:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778883208; cv=none; b=RGHVztefMPx6mgtfiSTg1EJmGmYVama4hz93C0ua9MIQbE9tkvnyhAl6OI23D/CLtS2Kict9QtFwnoLwlV+CZAXEoEbeJ3vfK4GZLsh4hnZvvpO9euZallnAlo59nUHMvFPDY3a13EMEcTBp/DbLmdabepqQMXzHvGCJOZfp8Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778883208; c=relaxed/simple;
	bh=tCRN8D9qu43RxoXyuMu8pJMSr/tVdPFiMH4SXvdZbPc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pu51yN3nqmRPkA4FCAXSA2/HFyWOg3N9A+5nIb4vnamrTcXrR4ufaW9kQxGF7d2dyYFUvy1jq9jjOjt0Ip2bktg7bvqcKDhH0ExReSp7N5kwZN+RwaOGkoe8p46EuCifk0jX8Kf1jFvifiv6+1djX4iXLzJq/geSnKtLAfT6Ggs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HVq80v+Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HVq80v+Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4422C2BCB7;
	Fri, 15 May 2026 22:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778883208;
	bh=tCRN8D9qu43RxoXyuMu8pJMSr/tVdPFiMH4SXvdZbPc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HVq80v+YKpTOTJR1RvdbaTgnzjqoBYnoR/rPrlihwCLmI9CGALJmyeF+4fINIePG+
	 vgrFeSWNmaNY9WTbncObB2bgnYBsxUrgF/eyDAkOZ/UTd/nCKOyyzWkdN+NrHAye57
	 XjqIRvSIso2VIgQXQJHL0hGSxwwcKKs9Vk21BoLDcU7rtOjqFn98iLAqfg5pfKWwEk
	 1ztysv7zn1hQJqm55E4u4eo/XtINtoDMqAc9vzRkXbqkUeTS008BSJMIKSqqBcylt5
	 MUQyaM78m6RTOXTK9FgX5ncIiA5DGnJh2YOHJYiB54XyYLs5RveVECMpcOHipVr7Z6
	 pVFO7WwoiZ77w==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	hmohsin@meta.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 1/2] net: shaper: annotate the data races
Date: Fri, 15 May 2026 15:13:24 -0700
Message-ID: <20260515221325.1685455-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515221325.1685455-1-kuba@kernel.org>
References: <20260515221325.1685455-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As previously discussed we don't care about making the shaper
state fully RCU-compliant because the hierarchy itself can't
be dumped in one go over Netlink. Let's annotate the reads
and writes to make that clear.

The field-by-field assignments will also be useful for the
next commit which adds explicit "valid" field (which we don't
want to override with the current full struct assignment).

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/shaper/shaper.c | 53 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 38 insertions(+), 15 deletions(-)

diff --git a/net/shaper/shaper.c b/net/shaper/shaper.c
index b1c65110f04d..520cefdc3d90 100644
--- a/net/shaper/shaper.c
+++ b/net/shaper/shaper.c
@@ -138,35 +138,58 @@ static int net_shaper_fill_handle(struct sk_buff *msg,
 	return -EMSGSIZE;
 }
 
+static void net_shaper_copy(struct net_shaper *dst,
+			    const struct net_shaper *src)
+{
+	WRITE_ONCE(dst->parent.scope, READ_ONCE(src->parent.scope));
+	WRITE_ONCE(dst->parent.id, READ_ONCE(src->parent.id));
+	WRITE_ONCE(dst->handle.scope, READ_ONCE(src->handle.scope));
+	WRITE_ONCE(dst->handle.id, READ_ONCE(src->handle.id));
+
+	WRITE_ONCE(dst->metric, READ_ONCE(src->metric));
+	WRITE_ONCE(dst->bw_min, READ_ONCE(src->bw_min));
+	WRITE_ONCE(dst->bw_max, READ_ONCE(src->bw_max));
+	WRITE_ONCE(dst->burst, READ_ONCE(src->burst));
+	WRITE_ONCE(dst->priority, READ_ONCE(src->priority));
+	WRITE_ONCE(dst->weight, READ_ONCE(src->weight));
+
+	/* private fields are only used on the write path under the lock */
+	data_race(dst->leaves = src->leaves);
+}
+
 static int
 net_shaper_fill_one(struct sk_buff *msg,
 		    const struct net_shaper_binding *binding,
 		    const struct net_shaper *shaper,
 		    const struct genl_info *info)
 {
+	struct net_shaper cur;
 	void *hdr;
 
 	hdr = genlmsg_iput(msg, info);
 	if (!hdr)
 		return -EMSGSIZE;
 
+	/* Make a copy to avoid data races */
+	net_shaper_copy(&cur, shaper);
+
 	if (net_shaper_fill_binding(msg, binding, NET_SHAPER_A_IFINDEX) ||
-	    net_shaper_fill_handle(msg, &shaper->parent,
+	    net_shaper_fill_handle(msg, &cur.parent,
 				   NET_SHAPER_A_PARENT) ||
-	    net_shaper_fill_handle(msg, &shaper->handle,
+	    net_shaper_fill_handle(msg, &cur.handle,
 				   NET_SHAPER_A_HANDLE) ||
-	    ((shaper->bw_min || shaper->bw_max || shaper->burst) &&
-	     nla_put_u32(msg, NET_SHAPER_A_METRIC, shaper->metric)) ||
-	    (shaper->bw_min &&
-	     nla_put_uint(msg, NET_SHAPER_A_BW_MIN, shaper->bw_min)) ||
-	    (shaper->bw_max &&
-	     nla_put_uint(msg, NET_SHAPER_A_BW_MAX, shaper->bw_max)) ||
-	    (shaper->burst &&
-	     nla_put_uint(msg, NET_SHAPER_A_BURST, shaper->burst)) ||
-	    (shaper->priority &&
-	     nla_put_u32(msg, NET_SHAPER_A_PRIORITY, shaper->priority)) ||
-	    (shaper->weight &&
-	     nla_put_u32(msg, NET_SHAPER_A_WEIGHT, shaper->weight)))
+	    ((cur.bw_min || cur.bw_max || cur.burst) &&
+	     nla_put_u32(msg, NET_SHAPER_A_METRIC, cur.metric)) ||
+	    (cur.bw_min &&
+	     nla_put_uint(msg, NET_SHAPER_A_BW_MIN, cur.bw_min)) ||
+	    (cur.bw_max &&
+	     nla_put_uint(msg, NET_SHAPER_A_BW_MAX, cur.bw_max)) ||
+	    (cur.burst &&
+	     nla_put_uint(msg, NET_SHAPER_A_BURST, cur.burst)) ||
+	    (cur.priority &&
+	     nla_put_u32(msg, NET_SHAPER_A_PRIORITY, cur.priority)) ||
+	    (cur.weight &&
+	     nla_put_u32(msg, NET_SHAPER_A_WEIGHT, cur.weight)))
 		goto nla_put_failure;
 
 	genlmsg_end(msg, hdr);
@@ -424,7 +447,7 @@ static void net_shaper_commit(struct net_shaper_binding *binding,
 		/* Successful update: drop the tentative mark
 		 * and update the hierarchy container.
 		 */
-		*cur = shapers[i];
+		net_shaper_copy(cur, &shapers[i]);
 		smp_wmb();
 		__xa_set_mark(&hierarchy->shapers, index, NET_SHAPER_VALID);
 	}
-- 
2.54.0

