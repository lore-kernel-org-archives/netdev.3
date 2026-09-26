Received: from mail.qrator.net (mx12.qrator.net [185.104.210.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1202D73A0
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 19:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.104.210.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790451607; cv=none; b=evjRAiU3c3Qfos0zBSyNYkc5I0EZnR8zTMLstrDEW+21s7yENYeyl+5y3/nCDnGisqycl93XZDMtOFTAynvnAagBXB/uoRGMCAS7jJJSD5mfW9T7bN3VmCs3agEcRe9s8U7XR+f7keIXM6AsqFonOeNsZ1haJAWEaCK7VnszoVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790451607; c=relaxed/simple;
	bh=ZxZPeQDLRnacIazTlCRPLi02a7Ooy+hGvMosv00K1pk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UCwsa24EeYr+YikEEFSSRdxroe/s9JUjroJ8qMzXOLm6mKcKFSQrMzosdixJWjaSwI8tP/G+dpp7BwrtvlOnpqlwh3pW0RfPbeDlr+NDFCYDVAFCcWjA9fyQWYURRPFBOOGd3EqLqhUcu5rp/wobN4hopZqQVi66+U8zFmQoH0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qrator.net; spf=pass smtp.mailfrom=qrator.net; dkim=pass (2048-bit key) header.d=qrator.net header.i=@qrator.net header.b=AIVhIpgZ; arc=none smtp.client-ip=185.104.210.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qrator.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qrator.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qrator.net header.i=@qrator.net header.b="AIVhIpgZ"
Received: from mail.router (mail-postfixrouter-1.mail_default [10.0.5.10])
	by mail.qrator.net (Postfix) with ESMTP id 545A96B28A71;
	Sat, 26 Sep 2026 19:32:05 +0000 (UTC)
Received: from enterprise.localdomain (unknown [10.0.5.1])
	by mail.router (Postfix) with ESMTP id 269746B28A6A;
	Sat, 26 Sep 2026 19:32:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=qrator.net; s=mx12;
	t=1790451125; bh=ZxZPeQDLRnacIazTlCRPLi02a7Ooy+hGvMosv00K1pk=;
	h=From:To:Cc:Subject:Date;
	b=AIVhIpgZszQKAZWKSMU0snOfVo71f2vrXskZw8mMacbqoW/ZP5XIfrFa0OXQBVjAw
	 mEhBGYRTf3iSrxswKwTz62NjSb8AkOvVppGvvMb4whL8AoTD2jt9X+Cj5+xaMwEL6v
	 hWiepPNmwnYILlDJuaW12YkM2vRy0CDsBTJNbrwGyA/4W4w2jKAd2zsOVhxa/eaadu
	 uPA0+zC+WHJrLW8CwlwiHBTcgeZm5+frkbQfuXdWUAy88QjjuAtttd84NPL9HwgLFT
	 HFq+XEoKQ7xb1r7w+RJDn6UmyHl1jCsfTJ3aF0ZaxMkZJwidFsapgz5E8MpzpFI2sd
	 z0JQ0Y6CP/2HQ==
Received: from localhost.localdomain (localhost [127.0.0.1])
	by enterprise.localdomain (Postfix) with ESMTP id E5CA7B4885E7;
	Sat, 26 Sep 2026 19:32:04 +0000 (UTC)
From: Alexander Zubkov <green@qrator.net>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Petr Machata <me@pmachata.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Alexander Zubkov <green@qrator.net>
Subject: [PATCH iproute2 v4] ip: ipstats: Merge statistics split across several netlink messages
Date: Sat, 26 Sep 2026 21:31:36 +0200
Message-ID: <20260926193136.9715-1-green@qrator.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel can split the statistics of one interface across several
netlink messages. ipstats_dump_one() formats every message on its
own, so the interface is shown twice and the attributes of the second
message are dropped:

    109: vlan859: group offload subgroup l3_stats on used on

    109: vlan859: group offload subgroup l3_stats

Buffer the message instead, merge into it the following messages with
the same ifindex, and format it once another ifindex shows up or the
dump ends.

Fixes: 54d82b0699a0 ("ip: Add a new family of commands, "stats"")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Alexander Zubkov <green@qrator.net>
---

v4:
 - Fix the truncated message guard, NLMSG_PAYLOAD() is unsigned so
   the test never fired.
 - Return -ENOMEM, not an errno the fprintf() may have clobbered.
 - Drop patch 2, unreachable once this one is applied.
v3: https://lore.kernel.org/netdev/20260910092057.3980-1-green@qrator.net/
 - Merge rewritten along the lines Stephen suggested: no attribute
   counting, no classifier, no refusal. Only the top-level nest and,
   for bridge xstats, the one inside it can be reopened.
 - The invariants moved from the cover letter into the comment above
   ipstats_merge_attrs().
 - Mask rta_type with NLA_TYPE_MASK, drop the dead addattr_nest() NULL
   checks, malloc instead of calloc, no err out-parameter and no
   separate ipstats_msg_merge().
 - One deviation from suggested version: the depth == 2 test is moved
   above the two scans. At that depth there might be no nested
   attributes.
v2: https://lore.kernel.org/netdev/20260908181225.31712-1-green@qrator.net/
 - Trimmed the comments and the commit message.
 - Dropped IPSTATS_MERGE_MAX_DEPTH.
 - Only the boundary attributes are merged.
 - All of the merging decision is in ipstats_merge_classify().
 - Do not index ipstats_stat_ifla_max[] with attribute type 0 (padding).
 - Use addraw_l() to copy attributes.
v1: https://lore.kernel.org/netdev/20260830181949.1096-1-green@qrator.net/

Notes:
 - Reproduced on Linux 7.1.5 / iproute2-7.0.0, Mellanox MSN4600C with 121
   netdevices, 31 with l3_stats; the split is visible in strace sa two
   RTM_NEWSTATS messages with the same ifindex.
 - The merge was also exercised by Claude out of tree against offload
   xstats cut between HW_S_INFO and L3_STATS, bridge per-VLAN xstats cut
   between two BRIDGE_XSTATS_VLAN entries, and a leaf attribute in both
   messages.

 ip/ipstats.c | 140 ++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 133 insertions(+), 7 deletions(-)

diff --git a/ip/ipstats.c b/ip/ipstats.c
index 8a2ac85e..47fdce2e 100644
--- a/ip/ipstats.c
+++ b/ip/ipstats.c
@@ -850,12 +850,68 @@ ipstats_show_one(int ifindex, struct ipstats_stat_enabled *enabled)
 	return err;
 }
 
-static int ipstats_dump_one(struct nlmsghdr *n, void *arg)
+/* The kernel resumes a split dump by reopening the top-level nest it stopped
+ * in and, for bridge xstats, the nest inside that. Everything below is whole
+ * and nothing at those two levels repeats, so join the two halves at the
+ * boundary and copy the rest.
+ */
+static int ipstats_merge_attrs(struct nlmsghdr *n, int maxlen,
+			       struct rtattr *a, int alen,
+			       struct rtattr *b, int blen, int depth)
+{
+	struct rtattr *last = NULL, *rta, *nest;
+	unsigned short type;
+	int rem;
+
+	if (depth == 2)
+		goto copy;
+
+	/* type 0 is 64-bit padding, possibly on either side of the split */
+	for (rta = a, rem = alen; RTA_OK(rta, rem); rta = RTA_NEXT(rta, rem))
+		if (rta->rta_type)
+			last = rta;
+	while (RTA_OK(b, blen) && !b->rta_type)
+		b = RTA_NEXT(b, blen);
+	if (!last || !RTA_OK(b, blen))
+		goto copy;
+
+	type = last->rta_type & NLA_TYPE_MASK;
+	if (type != (b->rta_type & NLA_TYPE_MASK) ||
+	    (!depth && (type > IFLA_STATS_MAX || !ipstats_stat_ifla_max[type])))
+		goto copy;
+
+	if (addraw_l(n, maxlen, a, (char *)last - (char *)a))
+		return -EMSGSIZE;
+
+	nest = addattr_nest(n, maxlen, last->rta_type);
+	if (ipstats_merge_attrs(n, maxlen, RTA_DATA(last), RTA_PAYLOAD(last),
+				RTA_DATA(b), RTA_PAYLOAD(b), depth + 1))
+		return -EMSGSIZE;
+	addattr_nest_end(n, nest);
+
+	b = RTA_NEXT(b, blen);
+	return addraw_l(n, maxlen, b, blen) ? -EMSGSIZE : 0;
+copy:
+	if (addraw_l(n, maxlen, a, alen) || addraw_l(n, maxlen, b, blen))
+		return -EMSGSIZE;
+	return 0;
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
 	int rc;
 
-	rc = ipstats_process_ifsm(stdout, n, enabled);
+	if (ctx->pending == NULL)
+		return 0;
+
+	rc = ipstats_process_ifsm(stdout, ctx->pending, ctx->enabled);
+	free(ctx->pending);
+	ctx->pending = NULL;
 	if (rc)
 		return rc;
 
@@ -863,9 +919,78 @@ static int ipstats_dump_one(struct nlmsghdr *n, void *arg)
 	return 0;
 }
 
+#define IFSM_PAYLOAD(n) NLMSG_PAYLOAD(n, sizeof(struct if_stats_msg))
+
+static int ipstats_dump_merge(struct ipstats_dump_ctx *ctx, struct nlmsghdr *n)
+{
+	int hdrlen = NLMSG_LENGTH(sizeof(struct if_stats_msg));
+	int maxlen = ctx->pending->nlmsg_len + n->nlmsg_len;
+	struct nlmsghdr *merged;
+	int rc;
+
+	merged = malloc(maxlen);
+	if (merged == NULL) {
+		fprintf(stderr, "Error merging netlink answer: %s\n",
+			strerror(errno));
+		return -ENOMEM;
+	}
+
+	memcpy(merged, ctx->pending, hdrlen);
+	merged->nlmsg_len = hdrlen;
+
+	rc = ipstats_merge_attrs(merged, maxlen,
+				 IFLA_STATS_RTA(NLMSG_DATA(ctx->pending)),
+				 IFSM_PAYLOAD(ctx->pending),
+				 IFLA_STATS_RTA(NLMSG_DATA(n)),
+				 IFSM_PAYLOAD(n), 0);
+	if (rc) {
+		free(merged);
+		return rc;
+	}
+
+	free(ctx->pending);
+	ctx->pending = merged;
+	return 0;
+}
+
+static int ipstats_dump_one(struct nlmsghdr *n, void *arg)
+{
+	struct ipstats_dump_ctx *ctx = arg;
+	int rc;
+
+	if (n->nlmsg_len < NLMSG_LENGTH(sizeof(struct if_stats_msg))) {
+		fprintf(stderr, "BUG: wrong nlmsg len %d\n", n->nlmsg_len);
+		return -EINVAL;
+	}
+
+	if (ctx->pending != NULL) {
+		const struct if_stats_msg *pending = NLMSG_DATA(ctx->pending);
+		const struct if_stats_msg *ifsm = NLMSG_DATA(n);
+
+		if (pending->ifindex == ifsm->ifindex)
+			return ipstats_dump_merge(ctx, n);
+
+		rc = ipstats_dump_pending(ctx);
+		if (rc)
+			return rc;
+	}
+
+	ctx->pending = malloc(n->nlmsg_len);
+	if (ctx->pending == NULL) {
+		fprintf(stderr, "Error saving netlink answer: %s\n",
+			strerror(errno));
+		return -ENOMEM;
+	}
+
+	memcpy(ctx->pending, n, n->nlmsg_len);
+	return 0;
+}
+
 static int ipstats_dump(struct ipstats_stat_enabled *enabled)
 {
-	int rc = 0;
+	struct ipstats_dump_ctx ctx = {
+		.enabled = enabled,
+	};
 
 	if (rtnl_statsdump_req_filter(&rth, PF_UNSPEC, 0,
 				      ipstats_req_add_filters,
@@ -874,12 +999,13 @@ static int ipstats_dump(struct ipstats_stat_enabled *enabled)
 		return -2;
 	}
 
-	if (rtnl_dump_filter(&rth, ipstats_dump_one, enabled) < 0) {
+	if (rtnl_dump_filter(&rth, ipstats_dump_one, &ctx) < 0) {
 		fprintf(stderr, "Dump terminated\n");
-		rc = -2;
+		free(ctx.pending);
+		return -2;
 	}
 
-	return rc;
+	return ipstats_dump_pending(&ctx);
 }
 
 static int

base-commit: ac0b672924c8993a2da2cb9b6f97908967095a97
-- 
2.55.0

