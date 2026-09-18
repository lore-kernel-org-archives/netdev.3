Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B7B397928
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 22:29:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789770595; cv=none; b=EIlCDNESl0gIeNvPTBrkDz2l6BZcHEXgx5yZUVUQBdKHX0lX2I+6yq+CKd0JbEzX5AF2D4Q6GcPZMZnVzMmNkZHpnYfnRW86siXS8ZbU3nnWUX910LfKtncz67a2xWboz8qWWp8Un3hJ0HrpCE02dJFefMMW1eXmUFTJxQeCFgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789770595; c=relaxed/simple;
	bh=dJqjqt8xq7eWjcwBJiAeMSvAX8L7HTjNthfU/hda/Kc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LmZYAbDGbngdS3L40+UZ+7IVXxYf2dE6OFBQWFAD5WW/GL8sJcRMHecSd/UAErlac13Hvq0+V9UVHj6+rc7WAzOdRjicVNld88fD3rzCQu0s7v5ufw+/2+Jg/mWu2FfsIMvDmBF5yOCkQhyu+qCCNKuW30ePCHV/Me6j3JrvpUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S+wFmM5i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S+wFmM5i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3FEF1F000FF;
	Fri, 18 Sep 2026 22:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789770591;
	bh=Du2Y1WRMuj6HRiuhuOJdZ3e7lv1yZMaOrtExWFTJZws=;
	h=From:To:Cc:Subject:Date;
	b=S+wFmM5is/fbUy4QOcFexSqfIDmFFj7/BvHZPM0wO+VLkqcRnKfiuLyFS9Pbp/ZOZ
	 8fgXBS5crhQUe6/IXM43jizhULNicVILLCObQL/S50O/GXi6j+IhaEAHD37MlSOCku
	 vfMIMt/k1lSgueaRKrSbCR6uKenYY3uYKndIycbUN1RwsfYpuQlvtr1FJw0d0YNQtQ
	 XZ8HZKiznp0vulOMikIOEO2sOBEzIwb8m1YzOgHOH7qsj3XqdqV0PNYl0KDVfqz+nr
	 iT3ya6/7SKVoOqSrcc5UwreB538MG6cVXXVyWAPmbkQHZSF6aLfqeuxcUss7u49+hE
	 HmB6+AkaszgdA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 1/2] genetlink: report the real command id for dump-only ops in policy dumps
Date: Fri, 18 Sep 2026 15:29:48 -0700
Message-ID: <20260918222949.4190284-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The op-to-policy map a CTRL_CMD_GETPOLICY dump returns is the only way
for userspace to find out which policy index belongs to which command.
ctrl_dumppolicy_put_op() tags the nest with doit->cmd, but an op which
only has a dumpit has no doit and every path which fills the split ops
in zeroes it out, so those entries all claim to be command 0.  nlctrl's
own CTRL_CMD_GETPOLICY and NETDEV_CMD_QSTATS_GET are both in that group:

  [{'family-id': 16, 'op-policy': {'do': 0, 'dump': 0, 'op-id': 3}},
   {'family-id': 16, 'op-policy': {'dump': 1, 'op-id': 0}},

ctrl_fill_info() gets this right - it uses the iterator's cmd for
CTRL_ATTR_OP_ID - so the two introspection interfaces of the same family
contradict each other today.

Pass the command in rather than reconstructing it from
doit->cmd | dumpit->cmd inside the helper, both callers already have it.

Fixes: 26588edbef60 ("genetlink: support split policies in ctrl_dumppolicy_put_op()")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 net/netlink/genetlink.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 41d37442f186..5cc1037d4917 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1656,7 +1656,7 @@ static void *ctrl_dumppolicy_prep(struct sk_buff *skb,
 }
 
 static int ctrl_dumppolicy_put_op(struct sk_buff *skb,
-				  struct netlink_callback *cb,
+				  struct netlink_callback *cb, u32 cmd,
 				  struct genl_split_ops *doit,
 				  struct genl_split_ops *dumpit)
 {
@@ -1677,7 +1677,7 @@ static int ctrl_dumppolicy_put_op(struct sk_buff *skb,
 	if (!nest_pol)
 		goto err;
 
-	nest_op = nla_nest_start(skb, doit->cmd);
+	nest_op = nla_nest_start(skb, cmd);
 	if (!nest_op)
 		goto err;
 
@@ -1721,7 +1721,8 @@ static int ctrl_dumppolicy(struct sk_buff *skb, struct netlink_callback *cb)
 						      &doit, &dumpit)))
 				return -ENOENT;
 
-			if (ctrl_dumppolicy_put_op(skb, cb, &doit, &dumpit))
+			if (ctrl_dumppolicy_put_op(skb, cb, ctx->op,
+						   &doit, &dumpit))
 				return skb->len;
 
 			/* done with the per-op policy index list */
@@ -1730,6 +1731,7 @@ static int ctrl_dumppolicy(struct sk_buff *skb, struct netlink_callback *cb)
 
 		while (ctx->dump_map) {
 			if (ctrl_dumppolicy_put_op(skb, cb,
+						   ctx->op_iter->cmd,
 						   &ctx->op_iter->doit,
 						   &ctx->op_iter->dumpit))
 				return skb->len;
-- 
2.55.0

