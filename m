Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0245B52FE32
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 15:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792077046; cv=none; b=Rx1XscxkRbuRvICrtHX+chlMhw2STRyOVMxH52r4yIo8Y8yMWVJs5QCdoMentFpYYOwNbFfdB0iISW52NMwee77kBarUrqmUDHGJkQa3Hz5bPkk4ADmZ4dUQjh/RD4KhNWdcwQDCzf2B0ecpzzLQqBu9DhHYIy6pzSyoNPe1a6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792077046; c=relaxed/simple;
	bh=YUGkMRRLoFR+SDfi3cGKyMX+1Nmyj0pjsg1jyvGNh/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g6K3cYzZs0LsQmYRkj7Td+ZWlVNLgRX6QUcCA8FMj0x4BThRFbDmEUimpUxFk5xlFJwFlRh3LAjujYHjv1Q0VSPQcsqpn0nrasyJ+3yCXa/UA2lshM1b+c+KgRyROuExpkkJMv9hooIkyZ1j6U0SoE/GX+ig8iNVsXmHpVsgBME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=TZL/S/mO; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="TZL/S/mO"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References;
	bh=5ocSH3JR6RFgpblcfu+Tm5E8x0KLvOez9gD1FnoiVco=; b=TZL/S/mOj7z1TXKX7hkIHEgPWL
	sSnlzLUoq8cwVFE9C62cbrH6eLCvfjYCzBfmzMPFkJ+hzLC2Pbw7RoSBgeT67173utCaWALVytsIx
	5DhOUWuqmboVg/RMLCki8YyqLsbBVRDiUY7u9VZxhcYGUrBSoTeFC0lnMVJA03rvBrRu+m8hI0bia
	r58bzSwybLwBy8fqvFnrzvhzM7Z0Pxr7Vzt5XEdDsMdWb7JbakdmrseXaJJl8VtfHJdzVkwivMyij
	kV/+06KFuVMYLGYIvl9kuzwiJujOBijRz80SOFKBbn/tmdMoIQu4GcEG+fzjC/0L7IX39fkyHkr3L
	d6DdkhqA==;
Received: from localhost ([127.0.0.1])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1xHN6I-0002NM-0J;
	Thu, 15 Oct 2026 17:10:34 +0200
From: Daniel Borkmann <daniel@iogearbox.net>
To: netdev@vger.kernel.org
Cc: memxor@gmail.com,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next] net: Port skb_segment tests of the test_bpf module to KUnit
Date: Thu, 15 Oct 2026 17:10:33 +0200
Message-ID: <20261015151033.591439-1-daniel@iogearbox.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: Clear (ClamAV 1.4.3/28154/Thu Oct 15 08:24:22 2026)

The old test_bpf module is going away, therefore port the two test
cases which were added in 76db8087c4c9 ("net: bpf: add a test for
skb_segment in test_bpf module") as well as cf204a718357 ("bpf,
testing: Introduce 'gso_linear_no_head_frag' skb_segment test")
into the net_test.c to retain coverage. With it in place:

  # Subtest: gso_test_func
  ok 1 no_gso
  ok 2 linear
  ok 3 frags
  ok 4 frags_pure
  ok 5 gso_partial
  ok 6 frag_list
  ok 7 frag_list_pure
  ok 8 frag_list_non_uniform
  ok 9 frag_list_head_frag
  ok 10 frag_list_no_head_frag
  ok 11 gso_by_frags
  ok 12 resegment
  ok 13 resegment_multi
  ok 14 resegment_tail
  ok 15 resegment_one_mss
  # gso_test_func: pass:15 fail:0 skip:0 total:15

Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Cc: Willem de Bruijn <willemb@google.com>
---
 net/core/net_test.c | 76 +++++++++++++++++++++++++++++++++++++++------
 1 file changed, 66 insertions(+), 10 deletions(-)

diff --git a/net/core/net_test.c b/net/core/net_test.c
index bc2ef7612e7d..8954458e1c8c 100644
--- a/net/core/net_test.c
+++ b/net/core/net_test.c
@@ -34,6 +34,8 @@ enum gso_test_nr {
 	GSO_TEST_FRAG_LIST,
 	GSO_TEST_FRAG_LIST_PURE,
 	GSO_TEST_FRAG_LIST_NON_UNIFORM,
+	GSO_TEST_FRAG_LIST_HEAD_FRAG,
+	GSO_TEST_FRAG_LIST_NO_HEAD_FRAG,
 	GSO_TEST_GSO_BY_FRAGS,
 	GSO_TEST_RESEGMENT,
 	GSO_TEST_RESEGMENT_MULTI,
@@ -52,6 +54,10 @@ struct gso_test_case {
 	unsigned int nr_frag_skbs;
 	const unsigned int *frag_skbs;
 	unsigned int max_segs;
+	const unsigned int *frag_skb_frags;
+	unsigned int gso_type;
+	/* skbs from alloc_skb() instead of build_skb(), head_frag clear */
+	bool no_head_frag;
 
 	/* output as expected */
 	unsigned int nr_segs;
@@ -128,6 +134,37 @@ static struct gso_test_case cases[] = {
 		.nr_segs = 4,
 		.segs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE, GSO_TEST_SIZE, 3 },
 	},
+	{
+		/* commit 13acc94eff12: frag_list members with linear data in a
+		 * page fragment, shared as a page frag of the segment
+		 */
+		.id = GSO_TEST_FRAG_LIST_HEAD_FRAG,
+		.name = "frag_list_head_frag",
+		.linear_len = 8,
+		.nr_frags = 1,
+		.frags = (const unsigned int[]) { 64 },
+		.nr_frag_skbs = 1,
+		.frag_skbs = (const unsigned int[]) { 8 },
+		.frag_skb_frags = (const unsigned int[]) { 64 },
+		.gso_type = SKB_GSO_DODGY,
+		.nr_segs = 1,
+		.segs = (const unsigned int[]) { 144 },
+	},
+	{
+		/* commit 3dcbdb134f32: gso_size smaller than the linear data,
+		 * as after bpf_skb_change_proto() grew the header, with
+		 * frag_list members whose linear data is not in a page fragment
+		 */
+		.id = GSO_TEST_FRAG_LIST_NO_HEAD_FRAG,
+		.name = "frag_list_no_head_frag",
+		.linear_len = GSO_TEST_SIZE + 20,
+		.nr_frag_skbs = 1,
+		.frag_skbs = (const unsigned int[]) { GSO_TEST_SIZE + 20 },
+		.gso_type = SKB_GSO_DODGY,
+		.no_head_frag = true,
+		.nr_segs = 3,
+		.segs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE, 40 },
+	},
 	{
 		/* commit 3953c46c3ac7 ("sk_buff: allow segmenting based on frag sizes") and
 		 * commit 90017accff61 ("sctp: Add GSO support")
@@ -224,13 +261,18 @@ static void gso_test_func(struct kunit *test)
 
 	tcase = test->param_value;
 
-	page = alloc_page(GFP_KERNEL);
-	KUNIT_ASSERT_NOT_NULL(test, page);
-	skb = build_skb(page_address(page), sizeof(hdr) + tcase->linear_len + shinfo_size);
+	if (tcase->no_head_frag) {
+		skb = alloc_skb(sizeof(hdr) + tcase->linear_len, GFP_KERNEL);
+	} else {
+		page = alloc_page(GFP_KERNEL);
+		KUNIT_ASSERT_NOT_NULL(test, page);
+		skb = build_skb(page_address(page), sizeof(hdr) + tcase->linear_len + shinfo_size);
+	}
 	KUNIT_ASSERT_NOT_NULL(test, skb);
 	__skb_put(skb, sizeof(hdr) + tcase->linear_len);
 
 	__init_skb(skb);
+	skb_shinfo(skb)->gso_type = tcase->gso_type;
 
 	if (tcase->nr_frags) {
 		unsigned int pg_off = 0;
@@ -256,24 +298,38 @@ static void gso_test_func(struct kunit *test)
 		struct sk_buff *frag_skb, *prev = NULL;
 
 		for (i = 0; i < tcase->nr_frag_skbs; i++) {
-			unsigned int frag_size;
-
-			page = alloc_page(GFP_KERNEL);
-			KUNIT_ASSERT_NOT_NULL(test, page);
+			unsigned int frag_size, frag_len;
 
 			frag_size = tcase->frag_skbs[i];
-			frag_skb = build_skb(page_address(page),
-					     frag_size + shinfo_size);
+			if (tcase->no_head_frag) {
+				frag_skb = alloc_skb(frag_size, GFP_KERNEL);
+			} else {
+				page = alloc_page(GFP_KERNEL);
+				KUNIT_ASSERT_NOT_NULL(test, page);
+				frag_skb = build_skb(page_address(page),
+						     frag_size + shinfo_size);
+			}
 			KUNIT_ASSERT_NOT_NULL(test, frag_skb);
 			__skb_put(frag_skb, frag_size);
 
+			frag_len = tcase->frag_skb_frags ? tcase->frag_skb_frags[i] : 0;
+			if (frag_len) {
+				page = alloc_page(GFP_KERNEL);
+				KUNIT_ASSERT_NOT_NULL(test, page);
+				skb_fill_page_desc(frag_skb, 0, page, 0, frag_len);
+
+				frag_skb->data_len = frag_len;
+				frag_skb->len += frag_len;
+				frag_skb->truesize += frag_len;
+			}
+
 			if (prev)
 				prev->next = frag_skb;
 			else
 				skb_shinfo(skb)->frag_list = frag_skb;
 			prev = frag_skb;
 
-			total_size += frag_size;
+			total_size += frag_skb->len;
 			total_true_size += frag_skb->truesize;
 		}
 
-- 
2.43.0

