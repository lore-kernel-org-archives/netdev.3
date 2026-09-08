Received: from mail.qrator.net (mx12.qrator.net [185.104.210.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D455E37F725
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 18:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.104.210.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788891556; cv=none; b=QHPaH0cJBQaNL4+gEgsakZV5F4bwmJNYLlMfr9IlPV2zlK8RnmHW1ld7JDh1aitY8LkEls0HWAUD3sODdmKFnT8aF+olaWl10qfeEBY5fx9qrsEAP2S30x5NQrNvaoWltvbb5nNFJCfEM5v4JL6ReTSV7DEPeC9HibpfgidvkiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788891556; c=relaxed/simple;
	bh=F/lDvMkuVxQhGUmSjP5lUlrC44Ac4ytZaDrWAec57P4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rNvbF6771gCcB2eYfs2V3m6LWpQBWAKasCxT3jC2bPLrleHPjuIrm9j1swcCVu+R0SWc+Emg5cccI3QM5M7T8L5d/vwBL2Vd0BJsGvRNlrGYGDCGBDh918qhJhSJorPjtbvWS51q9dQU0DPIsqZS2rirsHRfV/ijYuTWfTxdgoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qrator.net; spf=pass smtp.mailfrom=qrator.net; dkim=pass (2048-bit key) header.d=qrator.net header.i=@qrator.net header.b=Pq3SbiyI; arc=none smtp.client-ip=185.104.210.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qrator.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qrator.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qrator.net header.i=@qrator.net header.b="Pq3SbiyI"
Received: from mail.router (mail-postfixrouter-1.mail_default [10.0.5.10])
	by mail.qrator.net (Postfix) with ESMTP id F09226B28B23;
	Tue, 08 Sep 2026 18:13:07 +0000 (UTC)
Received: from enterprise.localdomain (unknown [10.0.5.1])
	by mail.router (Postfix) with ESMTP id C608F6B28B22;
	Tue, 08 Sep 2026 18:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=qrator.net; s=mx12;
	t=1788891187; bh=F/lDvMkuVxQhGUmSjP5lUlrC44Ac4ytZaDrWAec57P4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pq3SbiyI9srQVnBy48fd/JCcwJnlTsyMIN4eoTmTfpKoMtLDHcjmWp1wGv8FQwyhW
	 DNYRuba7CGgDjDV1RvAVKBSVlTR79TUnHarnyqzxhTqx6HVtBrkVeL7h5k+kL/FsDj
	 2p7rWh8f3vJ8Go8r2kW2H38V0gU9JjvsTPMInsZlOsool+d4hS7mRutZ9g9hDPpoz6
	 CDScHuXaVL3aX7qtwFuFnG/uJKQt8+YzOa5ufTvuq1hXjUs92j17tUhRF66S4jFF1J
	 0QTXi2nCduDzN+A+JoTuClAANN0kc/gHxm3HN4RW16tRZ9BJ0nPYY9G1gx/QRSSEXp
	 yiLVenQRfZ5KQ==
Received: from localhost.localdomain (localhost [127.0.0.1])
	by enterprise.localdomain (Postfix) with ESMTP id 702FEB3F3161;
	Tue, 08 Sep 2026 18:13:07 +0000 (UTC)
From: Alexander Zubkov <green@qrator.net>
To: netdev@vger.kernel.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
	Petr Machata <me@pmachata.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Alexander Zubkov <green@qrator.net>
Subject: [PATCH iproute2 v2 1/2] ip: ipstats: Merge statistics split across several netlink messages
Date: Tue,  8 Sep 2026 20:12:24 +0200
Message-ID: <20260908181225.31712-2-green@qrator.net>
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

The kernel can split the statistics of one interface across several
netlink messages: when an attribute does not fit into the current skb,
rtnl_fill_statsinfo() keeps the partial message and the dump is resumed
at the same ifindex. ipstats_dump_one() formats every message on its
own, so the interface is shown twice and the attributes of the second
message are dropped:

    109: vlan859: group offload subgroup l3_stats on used on

    109: vlan859: group offload subgroup l3_stats

Buffer the message instead, merge into it the following messages with
the same ifindex, and format it once another ifindex shows up or the
dump ends.

Whether two attributes are a reopened nest or merely share a type
cannot be told from the message, so it is decided from what ipstats.c
knows: at the outer level ipstats_stat_ifla_max[] says which types are
nests, and below it the children of the two halves are appended.

Fixes: 54d82b0699a0 ("ip: Add a new family of commands, "stats"")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Alexander Zubkov <green@qrator.net>
---
v2:
 - Trimmed the comments and the commit message.
 - Dropped IPSTATS_MERGE_MAX_DEPTH.
 - Only the boundary attributes are merged.
 - All of the merging decision is in ipstats_merge_classify().
 - Do not index ipstats_stat_ifla_max[] with attribute type 0 (padding).
 - Use addraw_l() to copy attributes.

Notes:
 - Reproduced on Linux 7.1.5 / iproute2-7.0.0, Mellanox MSN4600C with 121
   netdevices, 31 with l3_stats; the split is visible in strace sa two
   RTM_NEWSTATS messages with the same ifindex.
 - The merge was also exercised by Claude out of tree against offload
   xstats cut between HW_S_INFO and L3_STATS, bridge per-VLAN xstats cut
   between two BRIDGE_XSTATS_VLAN entries, and a leaf attribute in both
   messages.

 ip/ipstats.c | 261 +++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 254 insertions(+), 7 deletions(-)

diff --git a/ip/ipstats.c b/ip/ipstats.c
index 8a2ac85e..f7a5619f 100644
--- a/ip/ipstats.c
+++ b/ip/ipstats.c
@@ -850,12 +850,208 @@ ipstats_show_one(int ifindex, struct ipstats_stat_enabled *enabled)
 	return err;
 }
 
-static int ipstats_dump_one(struct nlmsghdr *n, void *arg)
+/* A netlink dump can split the statistics of one interface across several
+ * messages, which need to be merged back before they are shown.
+ */
+
+static unsigned int ipstats_rta_count(struct rtattr *rtas, int len,
+				      unsigned short type)
+{
+	unsigned int count = 0;
+	struct rtattr *rta;
+
+	for (rta = rtas; RTA_OK(rta, len); rta = RTA_NEXT(rta, len))
+		if (rta->rta_type == type)
+			count++;
+
+	return count;
+}
+
+enum ipstats_merge_action {
+	IPSTATS_MERGE_COPY,
+	IPSTATS_MERGE_NEST,
+	IPSTATS_MERGE_APPEND,
+	IPSTATS_MERGE_REFUSE,
+};
+
+static enum ipstats_merge_action
+ipstats_merge_classify(const struct rtattr *last_a,
+		       const struct rtattr *first_b,
+		       unsigned int na, unsigned int nb, bool outer)
+{
+	if (last_a == NULL || first_b == NULL ||
+	    last_a->rta_type != first_b->rta_type)
+		return IPSTATS_MERGE_COPY;
+
+	/* Array attributes should only be split on attribute boundaries.
+	 * Otherwise indistinguishable by any reader.
+	 */
+	if (na > 1 || nb > 1)
+		return IPSTATS_MERGE_COPY;
+
+	/* Deeper nesting is useless without knowing the structure.
+	 * But no attributes requires it today, and append is safe.
+	 */
+	if (!outer)
+		return IPSTATS_MERGE_APPEND;
+
+	/* An attribute that ipstats_stat_ifla_max does not describe is a leaf.
+	 * But a leaf should not be split.
+	 */
+	if (last_a->rta_type >= ARRAY_SIZE(ipstats_stat_ifla_max) ||
+	    ipstats_stat_ifla_max[last_a->rta_type] == 0)
+		return IPSTATS_MERGE_REFUSE;
+
+	return IPSTATS_MERGE_NEST;
+}
+
+static int ipstats_merge_rtas(struct nlmsghdr *n, int maxlen,
+			      struct rtattr *a, int alen,
+			      struct rtattr *b, int blen, bool outer)
+{
+	struct rtattr *first_b = NULL;
+	struct rtattr *last_a = NULL;
+	struct rtattr *rest_b = NULL;
+	unsigned int na = 0, nb = 0;
+	struct rtattr *nest;
+	struct rtattr *rta;
+	int rest_blen = 0;
+	int rem;
+	int err;
+
+	/* Type 0 is used in ipstats_stat_ifla_max to represent the top level.
+	 * But it is also a valid type used for padding. So safe to ignore.
+	 */
+	for (rta = a, rem = alen; RTA_OK(rta, rem); rta = RTA_NEXT(rta, rem))
+		if (rta->rta_type != 0)
+			last_a = rta;
+
+	for (rta = b, rem = blen; RTA_OK(rta, rem); rta = RTA_NEXT(rta, rem)) {
+		if (rta->rta_type == 0)
+			continue;
+
+		first_b = rta;
+		rest_b = RTA_NEXT(rta, rem);
+		rest_blen = rem;
+		break;
+	}
+
+	if (last_a != NULL)
+		na = ipstats_rta_count(a, alen, last_a->rta_type);
+	if (first_b != NULL)
+		nb = ipstats_rta_count(b, blen, first_b->rta_type);
+
+	if (last_a != NULL) {
+		if (addraw_l(n, maxlen, a, (char *)last_a - (char *)a))
+			return -EMSGSIZE;
+	}
+
+	switch (ipstats_merge_classify(last_a, first_b, na, nb, outer)) {
+	case IPSTATS_MERGE_REFUSE:
+		return -EOPNOTSUPP;
+
+	case IPSTATS_MERGE_COPY:
+		if (last_a != NULL) {
+			if (addattr_l(n, maxlen, last_a->rta_type,
+				      RTA_DATA(last_a), RTA_PAYLOAD(last_a)))
+				return -EMSGSIZE;
+		}
+
+		if (first_b != NULL) {
+			if (addattr_l(n, maxlen, first_b->rta_type,
+				      RTA_DATA(first_b), RTA_PAYLOAD(first_b)))
+				return -EMSGSIZE;
+		}
+		break;
+
+	case IPSTATS_MERGE_NEST:
+		nest = addattr_nest(n, maxlen, last_a->rta_type);
+		if (nest == NULL)
+			return -EMSGSIZE;
+
+		err = ipstats_merge_rtas(n, maxlen,
+					 RTA_DATA(last_a), RTA_PAYLOAD(last_a),
+					 RTA_DATA(first_b),
+					 RTA_PAYLOAD(first_b), false);
+		if (err)
+			return err;
+
+		addattr_nest_end(n, nest);
+		break;
+
+	case IPSTATS_MERGE_APPEND:
+		nest = addattr_nest(n, maxlen, last_a->rta_type);
+		if (nest == NULL)
+			return -EMSGSIZE;
+		if (addraw_l(n, maxlen, RTA_DATA(last_a),
+			     RTA_PAYLOAD(last_a)))
+			return -EMSGSIZE;
+		if (addraw_l(n, maxlen, RTA_DATA(first_b),
+			     RTA_PAYLOAD(first_b)))
+			return -EMSGSIZE;
+		addattr_nest_end(n, nest);
+		break;
+	}
+
+	if (rest_b != NULL) {
+		if (addraw_l(n, maxlen, rest_b, rest_blen))
+			return -EMSGSIZE;
+	}
+
+	return 0;
+}
+
+static int ipstats_attrs_len(const struct nlmsghdr *n)
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
+				  ipstats_attrs_len(a),
+				  IFLA_STATS_RTA(NLMSG_DATA(b)),
+				  ipstats_attrs_len(b), true);
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
 
@@ -863,9 +1059,59 @@ static int ipstats_dump_one(struct nlmsghdr *n, void *arg)
 	return 0;
 }
 
+static int ipstats_dump_one(struct nlmsghdr *n, void *arg)
+{
+	struct ipstats_dump_ctx *ctx = arg;
+	int rc;
+
+	if (ipstats_attrs_len(n) < 0) {
+		fprintf(stderr, "BUG: wrong nlmsg len %d\n", n->nlmsg_len);
+		return -EINVAL;
+	}
+
+	if (ctx->pending != NULL) {
+		const struct if_stats_msg *pending = NLMSG_DATA(ctx->pending);
+		const struct if_stats_msg *ifsm = NLMSG_DATA(n);
+
+		if (pending->ifindex == ifsm->ifindex) {
+			struct nlmsghdr *merged;
+
+			merged = ipstats_msg_merge(ctx->pending, n, &rc);
+			if (merged != NULL) {
+				free(ctx->pending);
+				ctx->pending = merged;
+				return 0;
+			}
+
+			if (rc != -EOPNOTSUPP)
+				return rc;
+
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
@@ -874,12 +1120,13 @@ static int ipstats_dump(struct ipstats_stat_enabled *enabled)
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
-- 
2.55.0

