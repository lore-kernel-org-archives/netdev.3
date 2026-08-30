Received: from mail.qrator.net (mx12.qrator.net [185.104.210.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 443283B7769
	for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 18:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.104.210.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788114055; cv=none; b=GDQHWOKGParNgh83HVum8P/7UXcw9uAGjjSe9H2LEBxzTW9C/0O9Lu+oUAONeVNicXBBsLcCmdf2MCu+AptTwFoEb4+tfzGGX7qmHK+g4KFofA0IQo7ERSzUT6+3UuYOuTiCdbsp2nj8ZOFRS8KsjfKQfKYYmdO6uYW/P9fYI9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788114055; c=relaxed/simple;
	bh=BEEWmr/DeynyvOJBGv108UxF9anDqruSLzOZVx6TQ0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qFfWc5JrwrJ3ivKiAijaOuFMTmxnylF3BOCWSrWJx1JXew2lxkw6FCR1FkQRnAeTfI+pLAmf23RV6wkWyEnCN6Fs+70KppKhoBfVgYcPERbYXjYkiBM2HY+RgX4kHGo3t2SslpTQ0AtWdEJiIdNqyEw8APEh93hVimo0j2pwulE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qrator.net; spf=pass smtp.mailfrom=qrator.net; dkim=pass (2048-bit key) header.d=qrator.net header.i=@qrator.net header.b=I/D2oMMj; arc=none smtp.client-ip=185.104.210.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qrator.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qrator.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qrator.net header.i=@qrator.net header.b="I/D2oMMj"
Received: from mail.router (mail-postfixrouter-1.mail_default [10.0.5.10])
	by mail.qrator.net (Postfix) with ESMTP id 518456B28A7E;
	Sun, 30 Aug 2026 18:20:51 +0000 (UTC)
Received: from enterprise.localdomain (unknown [10.0.5.1])
	by mail.router (Postfix) with ESMTP id 229E76B28A7D;
	Sun, 30 Aug 2026 18:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=qrator.net; s=mx12;
	t=1788114051; bh=BEEWmr/DeynyvOJBGv108UxF9anDqruSLzOZVx6TQ0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I/D2oMMj3mSG2EQO9Gykl/aaHQVOJ7sSHqn/SQhvNfCwumoXyZmtBmkTKPSqPoy6t
	 w72ATYLZ3Uy/roHa3x7SP5U9LveA9cgYLrY1cfDX4/HyfVqgponNMCK0yikKZTDCwJ
	 kbN7fVHBvbsJdNAB/3dXewvgA+EW4L1RwKx9RyqSO8dxSHsLbfJW3b+gd0NruI6yj1
	 rgL7xtCQzTVdCR8On2i8w6g5WoYOOvXRGO5NUDNIYsUPeFmBJ8lnAEROXG0fp9EeLF
	 KaxuLIxXeTOqTQj+4KfcWQF1jArjni66rXlW+kLNHR86+PWiKLvz4magjzwxrzed5q
	 PMS8QtE1oba6g==
Received: from localhost.localdomain (localhost [127.0.0.1])
	by enterprise.localdomain (Postfix) with ESMTP id C9438B3A8ADB;
	Sun, 30 Aug 2026 18:20:50 +0000 (UTC)
From: Alexander Zubkov <green@qrator.net>
To: netdev@vger.kernel.org,
	Stephen Hemminger <stephen@networkplumber.org>
Cc: Petr Machata <me@pmachata.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Alexander Zubkov <green@qrator.net>
Subject: [PATCH 1/2] ip: ipstats: Merge statistics split across several netlink messages
Date: Sun, 30 Aug 2026 20:19:48 +0200
Message-ID: <20260830181949.1096-2-green@qrator.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260830181949.1096-1-green@qrator.net>
References: <20260830181949.1096-1-green@qrator.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A netlink dump can split the statistics of a single interface across
several messages. When an attribute does not fit into the current skb,
rtnl_fill_statsinfo() keeps the partial message, records how far it got
in idxattr/prividx, and the dump is resumed at the same ifindex, with
the remaining attributes emitted in the next message.

"ip stats show group offload subgroup l3_stats" requests both
IFLA_OFFLOAD_XSTATS_HW_S_INFO and IFLA_OFFLOAD_XSTATS_L3_STATS, and
rtnl_offload_xstats_fill() emits them one by one, so a dump over a
sufficient number of netdevices regularly ends up cut in between the
two. Each message is currently formatted on its own, which yields two
bogus records instead of one, and, because ipstats_show_hw_stats() bails
out when the HW_S_INFO attribute is missing, the counters carried by the
second message are dropped:

    109: vlan859: group offload subgroup l3_stats on used on

    109: vlan859: group offload subgroup l3_stats

Postpone formatting until the whole object has been received: keep the
message around, merge into it any immediately following message that
carries the same ifindex, and format the result once a message for
another ifindex arrives or the dump ends. At most one interface worth of
statistics is buffered at a time.

Merging the two messages means merging the nests that were open when the
first one was cut short and that got reopened in the second one. Netlink
does not mark nests reliably here -- nla_nest_start_noflag() is used --
so they are recognized by the message layout instead: a reopened nest
appears exactly once in either message, and at the outer level is known
to be a nest by ipstats_stat_ifla_max[]. That knowledge only reaches as
deep as ipstats.c parses the message, so merging stops at the group
nests and their contents are appended in the order they arrived, which
is correct both for a deeper nest reopened between two of its children
and for an array of same-type attributes, as bridge per-VLAN xstats are.

A layout that does not fit the above cannot be told apart from an array
of same-type attributes, and reassembling it would corrupt the result.
Such a message pair is refused with -EOPNOTSUPP and the two halves are
formatted separately, as before this patch. Failures to allocate or to
build the merged message are not papered over that way and terminate the
dump.

Fixes: 54d82b0699a0 ("ip: Add a new family of commands, "stats"")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Alexander Zubkov <green@qrator.net>
---
 ip/ipstats.c | 280 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 276 insertions(+), 4 deletions(-)

diff --git a/ip/ipstats.c b/ip/ipstats.c
index 8a2ac85e..c531885f 100644
--- a/ip/ipstats.c
+++ b/ip/ipstats.c
@@ -850,12 +850,225 @@ ipstats_show_one(int ifindex, struct ipstats_stat_enabled *enabled)
 	return err;
 }
 
-static int ipstats_dump_one(struct nlmsghdr *n, void *arg)
+/* A netlink dump can split the statistics of one interface across several
+ * messages: when an attribute does not fit into the current skb, the kernel
+ * ends the message and resumes the dump at the same ifindex, emitting the
+ * remaining attributes in the next message. See rtnl_fill_statsinfo() and
+ * rtnl_offload_xstats_fill() in the kernel.
+ *
+ * Reassembling the two messages means merging the nests that were open when
+ * the first message was cut short and got reopened in the second one. Netlink
+ * does not mark nests reliably -- nla_nest_start_noflag() is used here -- so
+ * they are recognized by the message layout instead: a nest that was reopened
+ * appears exactly once in either message, and, at the outer level, is known to
+ * be a nest by ipstats_stat_ifla_max[].
+ *
+ * That knowledge only reaches as deep as ipstats.c parses the message, so
+ * merging stops at the group nests, and their contents are appended in the
+ * order they arrived. Appending is the right thing to do whether a deeper nest
+ * was reopened between two of its children or the children are just an array
+ * of same-type attributes, as bridge per-VLAN xstats are. It does the wrong
+ * thing only if a kernel splits a nest that ipstats.c does not know how to
+ * show either, in which case the merge is not the first thing that needs
+ * updating.
+ */
+
+enum {
+	/* Merge the outer level and the group nests, append below that. */
+	IPSTATS_MERGE_MAX_DEPTH = 1,
+};
+
+static struct rtattr *ipstats_rta_find(struct rtattr *rtas, int len,
+				       unsigned short type, unsigned int *count)
+{
+	struct rtattr *found = NULL;
+	struct rtattr *rta;
+
+	*count = 0;
+	for (rta = rtas; RTA_OK(rta, len); rta = RTA_NEXT(rta, len)) {
+		if (rta->rta_type != type)
+			continue;
+		if (found == NULL)
+			found = rta;
+		(*count)++;
+	}
+
+	return found;
+}
+
+/* Whether the two messages can be reassembled at this attribute, and how.
+ * MERGE means RTA and OTHER are the two halves of one nest that the first
+ * message left open. APPEND means the attribute belongs to one message only
+ * and is copied over as it is. REFUSE means the type is present in both
+ * messages in a layout that cannot be told apart from an array of same-type
+ * attributes, so reassembling it would corrupt the result.
+ */
+enum ipstats_merge_action {
+	IPSTATS_MERGE_APPEND,
+	IPSTATS_MERGE_MERGE,
+	IPSTATS_MERGE_REFUSE,
+};
+
+static enum ipstats_merge_action
+ipstats_merge_action(const struct rtattr *rta, unsigned int nrta,
+		     const struct rtattr *other, unsigned int nother, int depth)
+{
+	if (rta == NULL || other == NULL)
+		return IPSTATS_MERGE_APPEND;
+
+	if (nrta != 1 || nother != 1)
+		return IPSTATS_MERGE_REFUSE;
+
+	if (depth == 0) {
+		unsigned int type = rta->rta_type;
+
+		if (type >= ARRAY_SIZE(ipstats_stat_ifla_max) ||
+		    ipstats_stat_ifla_max[type] == 0)
+			return IPSTATS_MERGE_REFUSE;
+	}
+
+	return IPSTATS_MERGE_MERGE;
+}
+
+static int ipstats_copy_rtas(struct nlmsghdr *n, int maxlen,
+			     struct rtattr *rtas, int len)
+{
+	struct rtattr *rta;
+
+	for (rta = rtas; RTA_OK(rta, len); rta = RTA_NEXT(rta, len)) {
+		if (addattr_l(n, maxlen, rta->rta_type,
+			      RTA_DATA(rta), RTA_PAYLOAD(rta)))
+			return -EMSGSIZE;
+	}
+
+	return 0;
+}
+
+static int ipstats_merge_rtas(struct nlmsghdr *n, int maxlen,
+			      struct rtattr *a, int alen,
+			      struct rtattr *b, int blen, int depth)
+{
+	struct rtattr *rta;
+	int rem;
+	int err;
+
+	for (rta = a, rem = alen; RTA_OK(rta, rem); rta = RTA_NEXT(rta, rem)) {
+		unsigned int nrta, nother;
+		struct rtattr *other;
+		struct rtattr *nest;
+
+		other = ipstats_rta_find(b, blen, rta->rta_type, &nother);
+		ipstats_rta_find(a, alen, rta->rta_type, &nrta);
+
+		switch (ipstats_merge_action(rta, nrta, other, nother, depth)) {
+		case IPSTATS_MERGE_REFUSE:
+			return -EOPNOTSUPP;
+		case IPSTATS_MERGE_APPEND:
+			if (addattr_l(n, maxlen, rta->rta_type,
+				      RTA_DATA(rta), RTA_PAYLOAD(rta)))
+				return -EMSGSIZE;
+			continue;
+		case IPSTATS_MERGE_MERGE:
+			break;
+		}
+
+		nest = addattr_nest(n, maxlen, rta->rta_type);
+		if (nest == NULL)
+			return -EMSGSIZE;
+
+		if (depth < IPSTATS_MERGE_MAX_DEPTH) {
+			err = ipstats_merge_rtas(n, maxlen,
+						 RTA_DATA(rta), RTA_PAYLOAD(rta),
+						 RTA_DATA(other),
+						 RTA_PAYLOAD(other), depth + 1);
+		} else {
+			err = ipstats_copy_rtas(n, maxlen, RTA_DATA(rta),
+						RTA_PAYLOAD(rta));
+			if (!err)
+				err = ipstats_copy_rtas(n, maxlen,
+							RTA_DATA(other),
+							RTA_PAYLOAD(other));
+		}
+		if (err)
+			return err;
+
+		addattr_nest_end(n, nest);
+	}
+
+	for (rta = b, rem = blen; RTA_OK(rta, rem); rta = RTA_NEXT(rta, rem)) {
+		unsigned int nrta, nother;
+		struct rtattr *other;
+
+		other = ipstats_rta_find(a, alen, rta->rta_type, &nother);
+		ipstats_rta_find(b, blen, rta->rta_type, &nrta);
+
+		/* Whatever is present in both messages has been dealt with
+		 * in the loop above.
+		 */
+		if (ipstats_merge_action(rta, nrta, other, nother,
+					 depth) != IPSTATS_MERGE_APPEND)
+			continue;
+
+		if (addattr_l(n, maxlen, rta->rta_type,
+			      RTA_DATA(rta), RTA_PAYLOAD(rta)))
+			return -EMSGSIZE;
+	}
+
+	return 0;
+}
+
+static int ipstats_ifsm_len(const struct nlmsghdr *n)
+{
+	return n->nlmsg_len - NLMSG_LENGTH(sizeof(struct if_stats_msg));
+}
+
+static struct nlmsghdr *ipstats_msg_merge(const struct nlmsghdr *a,
+					  const struct nlmsghdr *b, int *err)
+{
+	int hdrlen = NLMSG_LENGTH(sizeof(struct if_stats_msg));
+	int maxlen = a->nlmsg_len + b->nlmsg_len;
+	struct nlmsghdr *n;
+
+	n = calloc(1, maxlen);
+	if (n == NULL) {
+		fprintf(stderr, "Error merging netlink answer: %s\n",
+			strerror(errno));
+		*err = -errno;
+		return NULL;
+	}
+
+	memcpy(n, a, hdrlen);
+	n->nlmsg_len = hdrlen;
+
+	*err = ipstats_merge_rtas(n, maxlen,
+				  IFLA_STATS_RTA(NLMSG_DATA(a)),
+				  ipstats_ifsm_len(a),
+				  IFLA_STATS_RTA(NLMSG_DATA(b)),
+				  ipstats_ifsm_len(b), 0);
+	if (*err) {
+		free(n);
+		return NULL;
+	}
+
+	return n;
+}
+
+struct ipstats_dump_ctx {
+	struct ipstats_stat_enabled *enabled;
+	struct nlmsghdr *pending;
+};
+
+static int ipstats_dump_pending(struct ipstats_dump_ctx *ctx)
 {
-	struct ipstats_stat_enabled *enabled = arg;
+	struct nlmsghdr *n = ctx->pending;
 	int rc;
 
-	rc = ipstats_process_ifsm(stdout, n, enabled);
+	if (n == NULL)
+		return 0;
+
+	ctx->pending = NULL;
+	rc = ipstats_process_ifsm(stdout, n, ctx->enabled);
+	free(n);
 	if (rc)
 		return rc;
 
@@ -863,8 +1076,63 @@ static int ipstats_dump_one(struct nlmsghdr *n, void *arg)
 	return 0;
 }
 
+static int ipstats_dump_one(struct nlmsghdr *n, void *arg)
+{
+	struct ipstats_dump_ctx *ctx = arg;
+	struct nlmsghdr *merged;
+	struct nlmsghdr *copy;
+	int rc;
+
+	if (ipstats_ifsm_len(n) < 0) {
+		fprintf(stderr, "BUG: wrong nlmsg len %d\n", n->nlmsg_len);
+		return -EINVAL;
+	}
+
+	if (ctx->pending != NULL) {
+		const struct if_stats_msg *pending = NLMSG_DATA(ctx->pending);
+		const struct if_stats_msg *ifsm = NLMSG_DATA(n);
+
+		if (pending->ifindex == ifsm->ifindex) {
+			merged = ipstats_msg_merge(ctx->pending, n, &rc);
+			if (merged != NULL) {
+				free(ctx->pending);
+				ctx->pending = merged;
+				return 0;
+			}
+			if (rc != -EOPNOTSUPP)
+				return rc;
+
+			/* An attribute layout that cannot be reassembled:
+			 * show the two halves separately, like older
+			 * versions did, rather than dropping either.
+			 */
+			fprintf(stderr,
+				"Cannot merge statistics of ifindex %d split across messages\n",
+				ifsm->ifindex);
+		}
+
+		rc = ipstats_dump_pending(ctx);
+		if (rc)
+			return rc;
+	}
+
+	copy = malloc(n->nlmsg_len);
+	if (copy == NULL) {
+		fprintf(stderr, "Error saving netlink answer: %s\n",
+			strerror(errno));
+		return -ENOMEM;
+	}
+
+	memcpy(copy, n, n->nlmsg_len);
+	ctx->pending = copy;
+	return 0;
+}
+
 static int ipstats_dump(struct ipstats_stat_enabled *enabled)
 {
+	struct ipstats_dump_ctx ctx = {
+		.enabled = enabled,
+	};
 	int rc = 0;
 
 	if (rtnl_statsdump_req_filter(&rth, PF_UNSPEC, 0,
@@ -874,11 +1142,15 @@ static int ipstats_dump(struct ipstats_stat_enabled *enabled)
 		return -2;
 	}
 
-	if (rtnl_dump_filter(&rth, ipstats_dump_one, enabled) < 0) {
+	if (rtnl_dump_filter(&rth, ipstats_dump_one, &ctx) < 0) {
 		fprintf(stderr, "Dump terminated\n");
 		rc = -2;
 	}
 
+	if (rc == 0)
+		rc = ipstats_dump_pending(&ctx);
+
+	free(ctx.pending);
 	return rc;
 }
 
-- 
2.55.0

