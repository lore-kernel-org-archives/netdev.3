Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F742D94BA
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 07:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774336845; cv=none; b=qjumEwq4AteNjaGLFi2qs8pvTkDBjqL2JPyPjH5y/C3uT8Ilim+lKreJkjVptvjcZIDNJ91f6Vytrm45V7gRbFNwXpynQxp7XyGZZZMZc+w79zfdPUAUt9BiRH+vdB8XpkJ4ghMdwEiqIJdQevFsAwFWeVZJQPeQLr4KAvL8Bw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774336845; c=relaxed/simple;
	bh=lMXigWjO0ai0aoOB7k/L3T4zoQ+6/7y2lQbXQ9gCuJs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=W6ENBnAbEzRmeKFnYfwPpGI4PvIBts99CZWXiQjIJVnVxQLtxLVoO+R8B4e3FDcIAW/ZJcP4BeOTYl6OzygF+K2+E0l5se4qEJtrgJtEBxGEB5aV2tSPaKVC2A/S7M9qANjr6IcQo5T6fgacGJyUIrqnbdphKhL1ybPoHXhM8ZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=bstVxyui; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="bstVxyui"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1774336830;
	bh=dg2fZ0M5zvHc9mX1R7YBDw4oT9GC0cYkHJOf5wCc6y4=;
	h=From:Date:Subject:To:Cc;
	b=bstVxyuioJRfU5c5oZ3ZCKY/QdI0Tf3++VXKPImCGm7RtQELcAwLDZH5sUTR1MQBu
	 1Jog77L1AM8GepfJkOzDKx4fnhpg8Z3jB9gmkknRz8SCt7lgxqmu3bR5xH4weNdAHO
	 vGV2pVG1NdADkIHJcluJsoJJqYUiKnafXGIDhEQVNY4eg1nH27brNsVlhwOOAeGqZu
	 jH9MA2qpdrjFtJpdOAfJVvk+JPrqqut/NLl/pOeCsPxEpM2JDCru9bXYI6pH08m/Jb
	 Pv++ePjC/aip0CtdXfpfufnk9NsVUtDK+J7NMckqpGXnq0lKxhnUX0uKcS0iBCUH1F
	 jQNOEajNDrYUA==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id B881165989; Tue, 24 Mar 2026 15:20:30 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Tue, 24 Mar 2026 15:19:56 +0800
Subject: [PATCH net-next] net: mctp: avoid copy in fragmentation loop for
 near-MTU messages
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260324-dev-mtu-copy-v1-1-7af6bd7027d3@codeconstruct.com.au>
X-B4-Tracking: v=1; b=H4sIABs7wmkC/x3MQQ5AMBBG4avIrE3SlpK4ilgIP2ahpC0h4u4ay
 2/x3kMBXhCoyR7yOCXI5hJ0ntGw9G4Gy5hMRplKFabkESev8eBh229WVttaa1NYgFKye0xy/bu
 WHCI7XJG69/0AHGcnbWgAAAA=
X-Change-ID: 20260324-dev-mtu-copy-0515711235ee
To: Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, yuanzhaoming <yuanzm2@lenovo.com>
X-Mailer: b4 0.14.2

Currently, we incorrectly send messages that are within 4 bytes (a
struct mctp_hdr) smaller than the MTU through mctp_do_fragment_route().
This has no effect on the actual fragmentation, as we will still send as
one packet, but unnecessarily copies the original skb into a new
single-fragment skb.

Instead of having the MTU comparisons in both mctp_local_output() and
mctp_do_fragment_route(), feed all local messages through the latter,
and add the single-packet optimisation there.

This means we can coalesce the routing path of mctp_local_output, so our
out_release path is now solely for errors, so rename the label
accordingly.

Include a check in the route tests for the single-packet case too.

Reported-by: yuanzhaoming <yuanzm2@lenovo.com>
Closes: https://github.com/openbmc/linux/commit/269936db5eb3962fe290b1dc4dbf1859cd5a04dd#r175836230
Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 net/mctp/route.c           | 26 +++++++++++---------------
 net/mctp/test/route-test.c |  4 ++++
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/net/mctp/route.c b/net/mctp/route.c
index 59ad60b885631c4de4f859284bc8c0f71201f8f8..021e04f1ea7c950af4c4e21d7afbc8c98d093186 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -1037,6 +1037,13 @@ static int mctp_do_fragment_route(struct mctp_dst *dst, struct sk_buff *skb,
 		return -EMSGSIZE;
 	}
 
+	/* within MTU? avoid the copy, send original skb */
+	if (skb->len <= mtu) {
+		hdr->flags_seq_tag = MCTP_HDR_FLAG_SOM |
+			MCTP_HDR_FLAG_EOM | tag;
+		return dst->output(dst, skb);
+	}
+
 	/* keep same headroom as the original skb */
 	headroom = skb_headroom(skb);
 
@@ -1111,7 +1118,6 @@ int mctp_local_output(struct sock *sk, struct mctp_dst *dst,
 	struct mctp_hdr *hdr;
 	unsigned long flags;
 	unsigned int netid;
-	unsigned int mtu;
 	mctp_eid_t saddr;
 	int rc;
 	u8 tag;
@@ -1133,7 +1139,7 @@ int mctp_local_output(struct sock *sk, struct mctp_dst *dst,
 	netid = READ_ONCE(dst->dev->net);
 
 	if (rc)
-		goto out_release;
+		goto err_free;
 
 	if (req_tag & MCTP_TAG_OWNER) {
 		if (req_tag & MCTP_TAG_PREALLOC)
@@ -1145,7 +1151,7 @@ int mctp_local_output(struct sock *sk, struct mctp_dst *dst,
 
 		if (IS_ERR(key)) {
 			rc = PTR_ERR(key);
-			goto out_release;
+			goto err_free;
 		}
 		mctp_skb_set_flow(skb, key);
 		/* done with the key in this scope */
@@ -1170,20 +1176,10 @@ int mctp_local_output(struct sock *sk, struct mctp_dst *dst,
 	hdr->dest = daddr;
 	hdr->src = saddr;
 
-	mtu = dst->mtu;
-
-	if (skb->len + sizeof(struct mctp_hdr) <= mtu) {
-		hdr->flags_seq_tag = MCTP_HDR_FLAG_SOM |
-			MCTP_HDR_FLAG_EOM | tag;
-		rc = dst->output(dst, skb);
-	} else {
-		rc = mctp_do_fragment_route(dst, skb, mtu, tag);
-	}
-
 	/* route output functions consume the skb, even on error */
-	skb = NULL;
+	return mctp_do_fragment_route(dst, skb, dst->mtu, tag);
 
-out_release:
+err_free:
 	kfree_skb(skb);
 	return rc;
 }
diff --git a/net/mctp/test/route-test.c b/net/mctp/test/route-test.c
index 75ea96c10e497e73b55e20a30934679b7e24fdeb..61c989c43ec09c9e105de4e51b295d07bb93d6da 100644
--- a/net/mctp/test/route-test.c
+++ b/net/mctp/test/route-test.c
@@ -63,6 +63,10 @@ static void mctp_test_fragment(struct kunit *test)
 		if (!skb2)
 			break;
 
+		/* avoid copying single-skb messages */
+		if (first && last)
+			KUNIT_EXPECT_PTR_EQ(test, skb, skb2);
+
 		hdr2 = mctp_hdr(skb2);
 
 		tag_mask = MCTP_HDR_TAG_MASK | MCTP_HDR_FLAG_TO;

---
base-commit: 2d1373e4246da3b58e1df058374ed6b101804e07
change-id: 20260324-dev-mtu-copy-0515711235ee

Best regards,
-- 
Jeremy Kerr <jk@codeconstruct.com.au>

