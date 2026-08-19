Received: from Chamillionaire.breakpoint.cc (Chamillionaire.breakpoint.cc [91.216.245.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA242DF12F
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 20:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.216.245.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787172162; cv=none; b=jfZBb+OD/Pek0oKJ80uWJdlsXwzbBuvSY/DGkojMx0nqxOQV584+wPRERTQbJlVoKjk9FU7wFT34ZCRFZYu/wQrcOWiVfqrt6xtOTAjsMNNnbzYa3M9lEAAIFhpgUNCTF/xmxwzoakUjDq7mxfoIyRj2eNZgybXOJDBNIgoOLzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787172162; c=relaxed/simple;
	bh=W4K1c6dT4RlbOt/hww1HsIJd7oDBfd8xE1z5F9Yy7qE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q6LixU2FwXkHH59kj4pj+7rDn50+HIaYtM3BpOzblcaVkPpAxJpUNNGRvgAqmzUFom+AHJsmif2sMzmduEj3M7rADm0uMkAEmDxPaySkknWGe0GtjYvWCnhXVwig0VadXsH5vuP8qzFOuvxcuMUyuU4eRtHB8GZkUpNsoT9x2e8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc; arc=none smtp.client-ip=91.216.245.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strlen.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=Chamillionaire.breakpoint.cc
Received: by Chamillionaire.breakpoint.cc (Postfix, from userid 1003)
	id EE1826035B; Wed, 19 Aug 2026 22:42:38 +0200 (CEST)
From: Florian Westphal <fw@strlen.de>
To: <netdev@vger.kernel.org>
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	victor@mojatatu.com,
	Florian Westphal <fw@strlen.de>,
	Kyle Zeng <kylebot@openai.com>
Subject: [PATCH net 2/4] net/sched: act_pedit: drop conntrack on network/transport header changes
Date: Wed, 19 Aug 2026 22:42:08 +0200
Message-ID: <20260819204210.23722-3-fw@strlen.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260819204210.23722-1-fw@strlen.de>
References: <20260819204210.23722-1-fw@strlen.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

PEDIT can rewrite packet headers after act_ct attached a conntrack entry.
conntrack (and conntrack helpers) rely on validation done by conntrack or
network stack, i.e. ip header lengths, th->doff and the like are assumed
to be valid.

One common gadget to cause OOB access or worse is "action ct", followed
by "action pedit munge ip protocol set 1"

... and then waiting for netfilter to trip because it trusts packet and
conntrack entry refer to the same protocols.

Reset the skb conntrack state if one was attached and we might have updated
relevant header fields.

This patch is a simpler version of related commits:

968cc2c96390 ("netfilter: disable payload mangling in userns")
df07998dfd40 ("netfilter: nftables: restrict linklayer and network header writes")
54f34607d184 ("netfilter: nfnetlink_queue: restrict writes to network header")

that restricted post-conntrack-pickup mangling in netfilter.

The opposite approach -- revalidation at every turn -- is hardly
feasible, even examples like:

        if (nf_ct_protonum(ct) == IPPROTO_TCP) {
                th = (struct tcphdr *)(skb->data + protoff);
                baseoff = protoff + th->doff * 4;

or
        if (ip_hdr(skb)->protocol == IPPROTO_TCP) {
                if (!nf_nat_mangle_tcp_packet(skb, ct, ctinfo, ..

... would be buggy: nf_ct_protonum(ct) and ip_hdr->protocol could be
off-sync and th->doff could point past skb writeable area.

Fixes tag points to 'action ct'.  Packet rewrites are still possible with
BPF. However, unlike pedit, that needs privileges in the initial namespace.

Fixes: b57dc7c13ea9 ("net/sched: Introduce action ct")
Assisted-by: Claude:claude-sonnet-5
Reported-by: Kyle Zeng <kylebot@openai.com>
Closes: https://lore.kernel.org/netfilter-devel/20260810221744.35007-1-kylebot@openai.com/
Signed-off-by: Florian Westphal <fw@strlen.de>
---
 passes tc tests, old POC for originally reported issue
 no longer causes a splat.

 net/sched/act_pedit.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/net/sched/act_pedit.c b/net/sched/act_pedit.c
index d4d47a9921f4..b079257c2b7b 100644
--- a/net/sched/act_pedit.c
+++ b/net/sched/act_pedit.c
@@ -386,6 +386,7 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
 	struct tcf_pedit *p = to_pedit(a);
 	struct tcf_pedit_key_ex *tkey_ex;
 	struct tcf_pedit_parms *parms;
+	bool l3_l4_changed = false;
 	struct tc_pedit_key *tkey;
 	int i;
 
@@ -398,7 +399,7 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
 	tkey_ex = parms->tcfp_keys_ex;
 
 	for (i = parms->tcfp_nkeys; i > 0; i--, tkey++) {
-		int write_offset, write_len;
+		int write_offset, write_len, nw_offset;
 		int offset = tkey->off;
 		int hoffset = 0;
 		u32 cur_val, val;
@@ -418,6 +419,8 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
 			goto bad;
 		}
 
+		nw_offset = skb_network_offset(skb);
+
 		if (tkey->offmask) {
 			u8 *d, _d;
 			int at_offset;
@@ -485,6 +488,19 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
 		}
 
 		put_unaligned((cur_val & tkey->mask) ^ val, ptr);
+
+		/* Track if L3 or L4 headers were modified:
+		 * - Direct L3/L4 header types
+		 * - ETH header type with offset/length reaching into L3/L4
+		 */
+		if (htype == TCA_PEDIT_KEY_EX_HDR_TYPE_NETWORK ||
+		    htype == TCA_PEDIT_KEY_EX_HDR_TYPE_IP4 ||
+		    htype == TCA_PEDIT_KEY_EX_HDR_TYPE_IP6 ||
+		    htype == TCA_PEDIT_KEY_EX_HDR_TYPE_TCP ||
+		    htype == TCA_PEDIT_KEY_EX_HDR_TYPE_UDP ||
+		    (htype == TCA_PEDIT_KEY_EX_HDR_TYPE_ETH &&
+		     write_offset + (int)sizeof(*ptr) > nw_offset))
+			l3_l4_changed = true;
 	}
 
 	goto done;
@@ -492,6 +508,9 @@ TC_INDIRECT_SCOPE int tcf_pedit_act(struct sk_buff *skb,
 bad:
 	tcf_action_inc_overlimit_qstats(&p->common);
 done:
+	if (l3_l4_changed)
+		nf_reset_ct(skb);
+
 	return parms->action;
 }
 
-- 
2.54.0

