Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39435493D3B
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 10:07:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791454070; cv=none; b=iiuBYj4GqW7TtJU8DAGR+B5oJQWz3HIngIJ7aA0F3CwBp1P0qsdDaC4ApjJUa7mVdziWj/5SZppuq5rdQZwX0MnoIo2CFxlOeGVQxzJhDUoqAe48XIGbhMIAS9EkMmVMTZDbN87/18tZiPoFIOIQk2Jtftl983g1rI3l24n5q2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791454070; c=relaxed/simple;
	bh=MUEpsqyFKq/PAd82RUXhfIvzYkyAwJ2Ax1KM5Vv/TOs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k+yqAG0//Z/0kS6BcpT/UHCT/D+dIDSSYdTx44+lFabM+Ivig4W1R8xFvkRbUe3DoqUrepXyqpDfhJDqs2j/4jGYMweNRlsJAMgkh7OifgtCijHs5IwOgp6c3ji6NnA0+s85CAcueTia73K6k63pGuiWvIYbz5N3isbV/9JYkkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com; spf=pass smtp.mailfrom=smartx.com; dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b=IBXzdGyN; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smartx-com.20251104.gappssmtp.com header.i=@smartx-com.20251104.gappssmtp.com header.b="IBXzdGyN"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-14129667240so2961213c88.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 03:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20251104.gappssmtp.com; s=20251104; t=1791454060; x=1792058860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lS1H6hdb3wkDWUYdMnwf/6nr5ACFjMTtIILyc9J0Hi0=;
        b=IBXzdGyNsIIehbCA4H9+Fau48aB7pCidZBNzt9EY4zc9lykjE7UXfOAOIOQC8xdLRM
         Fa24lb3/PLN5Hm5K3RcgEiIXSMkZpSyyTSCkSALNCOJ+/K82GYTTXFVcuXN6HfijTbER
         A2wq9LWlfpOI9JDUtkQv6lqDilJNC0SjObx+ef2ssa3fgqb4OZyiku833xNY1VvOijjO
         Pp/c/yofaGmO/qonXxqZN0FHbt1wg/TNWR21n+Y2lsC8H6sAu0qGJ7zY1JvQk5lqVks8
         5xYWW5x7xqcXa9GHg88CZ9EvBwlibN+xMEKo+vkph934VPOCOdcSpK5EMD0bcFRzrsL7
         1KBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791454060; x=1792058860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lS1H6hdb3wkDWUYdMnwf/6nr5ACFjMTtIILyc9J0Hi0=;
        b=Mer11ux59YY+F5Wp7dExbSDD4zlrZ/g75k0uS/BWwuk1jmtCOWuaiZI9Vrpwj5+ljk
         n2LTQA8elBxpzErW4DqUBzXS/0NBsdHRoUZzsraS7cPP7aB1ava5bLS1b6UDcIIeNOXi
         QZiQceJXtNPHFGPUE/2UxlzAZMBd+IR+8YjRb0v7lrkzFZR/qLCs4Mp4K+KDDbgRZpVe
         fiUH63mG8ihVKGGH1tgqvssRg5YHR1XcHLuGKiQGJVAFxGyecNgF8qak/oi+LwywmFEn
         8DD+lEu7UzUV14yHbA7jZrYjrZhHEnpVBW9TY/edUWBthuHsb6o3iUbyr/cC3m+UCZVN
         rnrA==
X-Gm-Message-State: AFuF++lkVnU6AT/prFpanKJo9+B71oYaJGu8ao7rtsOIp3DtIGDw930N
	seje0JR0WivpCDVTvU7rinixjMxzQvJaQDMnXQsG8/HT0nQlsBndwZJ77yY7SL9p61h//6NIsZ7
	/5rsU3O+/rszzGMgQ0D5Pwe6FkCR0omfXUamHckIut0W0Oy3yMy0PKSsOLaNLWG0ZB98+A0mp
X-Gm-Gg: AYBFou2z2LT4pfrkfbqxCzwyYsZP7Wg0XOB75eSj3ipD7PB8K2y1pkSsFQlkDL1o3x2
	ecEX8aw17gb4hjzluQGY3/VIlvYB+LYtd9ENzhnCAdUVC5brqL9ZFCMqra82xIeSUeqtQfaoitU
	rxAxh2/KHSG2WRfG085Al77gx2NEZiH8pnSYWdAGITrl/8JVl1PWo9Ge6Mj4vs4eQaEjIx8n7Zq
	Q3Q0aGN8uH/IDk7hnDLin5G+vZ/dCPh9fGslFtDQk4HXeDyKaxqpxOam05iEq3EbVeCXQA2TMtt
	dt2qT0l4XD2lF96f8fGl3BIdTi+pONOVhJZ7QxPwr3rLeZtQz5q1zqehQRN4Ym4JPZbT+7afc5Y
	wTht8CnjVVKTw7IsnF/Myimm4EeETYcZS8LoowXpgbaEbnlTZEt1rZGWkfJBItset+IzPDDO0v8
	xeRPYTVsPbXeUiQacBirxvKDwx2tIlP/FV/srTdZNgHw5Lmc0RHZ7/EuK96l+sR9zrQiXY3w196
	MhnwAS/9ss=
X-Received: by 2002:a05:7022:43a8:b0:15d:f053:18b6 with SMTP id a92af1059eb24-162043c736dmr7946220c88.9.1791454059583;
        Thu, 08 Oct 2026 03:07:39 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.128])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-161684ba3fdsm14200933c88.12.2026.10.08.03.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:07:39 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	keyong.sun@smartx.com,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	dev@openvswitch.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Alice Mikityanska <alice@isovalent.com>,
	David Laight <david.laight.linux@gmail.com>,
	Wang Zhan <wang.zhan@smartx.com>
Subject: [PATCH net-next v5 6/6] net: net_test: add tests for TCP re-segmentation
Date: Thu,  8 Oct 2026 18:06:51 +0800
Message-ID: <20261008100651.2534957-7-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261008100651.2534957-1-wang.zhan@smartx.com>
References: <20261008100651.2534957-1-wang.zhan@smartx.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The GSO engine can now be asked to group several MSS segments into one
output skb, which is what re-segmentation needs.  Add KUnit coverage for
the max_segs parameter.

The parameterized GSO test gains a max_segs input and four cases: a limit
of two MSS applied to a 3003 byte and to a 5003 byte payload, a tail which
holds one MSS and is therefore not a GSO skb, and a max_segs of one MSS
which must leave the output unchanged.  It drives skb_segment() directly,
because the synthetic protocol it uses has no gso_segment callback.

Assisted-by: LLM
Signed-off-by: Wang Zhan <wang.zhan@smartx.com>

---
v5:
- new case: last output not a GSO skb
- free extra outputs instead of leaking them
- drop the TCP path tests, coverage in a later series
v4: https://lore.kernel.org/20260930111526.2183107-6-wang.zhan@smartx.com/
v3: https://lore.kernel.org/20260928044102.1004310-6-wang.zhan@smartx.com/
v2: https://lore.kernel.org/20260918084651.3022878-5-wang.zhan@smartx.com/
v1: https://lore.kernel.org/20260917063854.2011613-5-wang.zhan@smartx.com/
---
 net/core/net_test.c | 87 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/net/core/net_test.c b/net/core/net_test.c
index 9c3a590865d269..bc2ef7612e7dfe 100644
--- a/net/core/net_test.c
+++ b/net/core/net_test.c
@@ -5,6 +5,7 @@
 /* GSO */
 
 #include <linux/skbuff.h>
+#include <net/gso.h>
 
 static const char hdr[] = "abcdefgh";
 #define GSO_TEST_SIZE 1000
@@ -34,6 +35,10 @@ enum gso_test_nr {
 	GSO_TEST_FRAG_LIST_PURE,
 	GSO_TEST_FRAG_LIST_NON_UNIFORM,
 	GSO_TEST_GSO_BY_FRAGS,
+	GSO_TEST_RESEGMENT,
+	GSO_TEST_RESEGMENT_MULTI,
+	GSO_TEST_RESEGMENT_TAIL,
+	GSO_TEST_RESEGMENT_ONE_MSS,
 };
 
 struct gso_test_case {
@@ -46,10 +51,12 @@ struct gso_test_case {
 	const unsigned int *frags;
 	unsigned int nr_frag_skbs;
 	const unsigned int *frag_skbs;
+	unsigned int max_segs;
 
 	/* output as expected */
 	unsigned int nr_segs;
 	const unsigned int *segs;
+	const unsigned int *gso_segs;
 };
 
 static struct gso_test_case cases[] = {
@@ -135,6 +142,68 @@ static struct gso_test_case cases[] = {
 		.nr_segs = 4,
 		.segs = (const unsigned int[]) { 100, 200, 300, 400 },
 	},
+	{
+		.id = GSO_TEST_RESEGMENT,
+		.name = "resegment",
+		.linear_len = GSO_TEST_SIZE,
+		.nr_frags = 3,
+		.frags = (const unsigned int[]) {
+			GSO_TEST_SIZE, GSO_TEST_SIZE, 3,
+		},
+		.max_segs = 2,
+		.nr_segs = 2,
+		.segs = (const unsigned int[]) {
+			2 * GSO_TEST_SIZE, GSO_TEST_SIZE + 3,
+		},
+		.gso_segs = (const unsigned int[]) { 2, 2 },
+	},
+	{
+		.id = GSO_TEST_RESEGMENT_MULTI,
+		.name = "resegment_multi",
+		.linear_len = 2 * GSO_TEST_SIZE,
+		.nr_frags = 4,
+		.frags = (const unsigned int[]) {
+			GSO_TEST_SIZE, GSO_TEST_SIZE, GSO_TEST_SIZE, 3,
+		},
+		.max_segs = 2,
+		.nr_segs = 3,
+		.segs = (const unsigned int[]) {
+			2 * GSO_TEST_SIZE, 2 * GSO_TEST_SIZE, GSO_TEST_SIZE + 3,
+		},
+		.gso_segs = (const unsigned int[]) { 2, 2, 2 },
+	},
+	{
+		/* The last output is not a GSO skb. */
+		.id = GSO_TEST_RESEGMENT_TAIL,
+		.name = "resegment_tail",
+		.linear_len = GSO_TEST_SIZE,
+		.nr_frags = 2,
+		.frags = (const unsigned int[]) {
+			GSO_TEST_SIZE, 400,
+		},
+		.max_segs = 2,
+		.nr_segs = 2,
+		.segs = (const unsigned int[]) {
+			2 * GSO_TEST_SIZE, 400,
+		},
+		.gso_segs = (const unsigned int[]) { 2, 0 },
+	},
+	{
+		/* max_segs of 1 is the same as no limit. */
+		.id = GSO_TEST_RESEGMENT_ONE_MSS,
+		.name = "resegment_one_mss",
+		.linear_len = GSO_TEST_SIZE,
+		.nr_frags = 3,
+		.frags = (const unsigned int[]) {
+			GSO_TEST_SIZE, GSO_TEST_SIZE, 3,
+		},
+		.max_segs = 1,
+		.nr_segs = 4,
+		.segs = (const unsigned int[]) {
+			GSO_TEST_SIZE, GSO_TEST_SIZE, GSO_TEST_SIZE, 3,
+		},
+		.gso_segs = (const unsigned int[]) { 0, 0, 0, 0 },
+	},
 };
 
 static void gso_test_case_to_desc(struct gso_test_case *t, char *desc)
@@ -226,6 +295,7 @@ static void gso_test_func(struct kunit *test)
 	if (tcase->id == GSO_TEST_FRAG_LIST_NON_UNIFORM)
 		features &= ~NETIF_F_SG;
 
+	SKB_GSO_CB(skb)->max_segs = tcase->max_segs;
 	segs = skb_segment(skb, features);
 	if (IS_ERR(segs)) {
 		KUNIT_FAIL(test, "segs error %pe", segs);
@@ -239,6 +309,9 @@ static void gso_test_func(struct kunit *test)
 	for (cur = segs, i = 0; cur; cur = next, i++) {
 		next = cur->next;
 
+		if (i >= tcase->nr_segs)
+			goto consume;
+
 		KUNIT_ASSERT_EQ(test, cur->len, sizeof(hdr) + tcase->segs[i]);
 
 		/* segs have skb->data pointing to the mac header */
@@ -247,11 +320,25 @@ static void gso_test_func(struct kunit *test)
 
 		/* header was copied to all segs */
 		KUNIT_ASSERT_EQ(test, memcmp(skb_mac_header(cur), hdr, sizeof(hdr)), 0);
+		if (tcase->gso_segs) {
+			unsigned int gso_segs = tcase->gso_segs[i];
+
+			KUNIT_EXPECT_EQ(test, skb_shinfo(cur)->gso_segs,
+					gso_segs);
+			if (!gso_segs) {
+				KUNIT_EXPECT_FALSE(test, skb_is_gso(cur));
+			} else {
+				KUNIT_EXPECT_TRUE(test, skb_is_gso(cur));
+				KUNIT_EXPECT_EQ(test, skb_shinfo(cur)->gso_size,
+						GSO_TEST_SIZE);
+			}
+		}
 
 		/* last seg can be found through segs->prev pointer */
 		if (!next)
 			KUNIT_ASSERT_PTR_EQ(test, cur, last);
 
+consume:
 		consume_skb(cur);
 	}
 
-- 
2.47.3

