Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794529320;
	b=pIAGn6LpSO+QDIeSeIhxun7g8xD+arEIUSenUvkvSxkEDwVPZcq+62YAbcAlOy3jjOQn
	 x0Wv9WS7cjKtK3cfoMtAzIW7xB62GUOhl4o6tzjIIrx54xmSp1XrdBaNw+QjkjpcDCugM
	 qQ317mrBuqDl1v+TJPgW8C6KxtMbG+vs22imt5HktdfJ+s6elwNMy4ICKnt/MIEZ+o2XR
	 9wt63/I5fQpjfWMRn/6LMmkwjKY7Tzc6FtCPtLFWac72zsBKinzYKMUgUD8XQ7IEo5p/T
	 bhUJf4yyVOB1BemuX39e1Rbg7ir6/z7cPEy+yl6qrCNFW4AgqhKM6arcfSrzSGPtfqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794529320;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=Hh3AiM4JMbQc/Rx8K3OAFBZ9qfGIYX00CL0MGMjf07Y=;
	b=cEvtEfjVrlxtMROn57jncR4xu2gjcdK320xgwc8QB7eIml62fGw3EnweJpGdeu/9SYQD
	 64kcx3yCDox21bbn/stH06DRv8JaIRSZGVpQKp0Qp/GLc3zT2+J5SIN08CBCQKBAvN//R
	 ZgTGyjMF5V5MUKZ3YST/xAHdpcrgc5X073JdQ5Jn8ssT4mbwr99xp12P4VVjmwvL0lDsK
	 TyzYYfJ3PvSsqj8MDTL/tx4Jv0123M9zmmo3WT/HY0Jh5VWNoM5GW7xip14Md7f7g4nKK
	 /m1EjqaXcSk6J++koySD0bChf7c/pjdckZj+o0r/NKiqXFVkP4tmZDS4FMRIVmFD+tA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=CoKH7bZx;
	arc=none smtp.remote-ip=209.85.219.46
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0E2F606A890
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 00:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F0E2F606A890
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=CoKH7bZx
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-91ea5600c9cso9512816d6.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 16:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1794529319; x=1795134119; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hh3AiM4JMbQc/Rx8K3OAFBZ9qfGIYX00CL0MGMjf07Y=;
        b=CoKH7bZxMqBdlejB81iUG2jTC4rRkDe8T3fyRPsnlsqO/CjkbXTXHKyGXW3r9QDIy/
         SKMsLNwgAk9L8FgvAWCRoLknrB9f0ArrpEF+z0hB3bqH9MdlqGRhkxrjKLXUb04G3BYp
         cfzmrY/USKYmymhu44Ur/Ae3P1eCCykIAPZ1a8g/bftuhpW0oOvEYTnS6ldUVGKToL0y
         aqs+ewuyJ2IWCSZZ14uFM8ZLBmL4iIFdNqwp0JvoTz2zkj2A0OTp7183FSfAAj9ZHS1u
         OzzNRtHRTnUtgeHIe+4K8tDwhCkyaNNeCgM8NgCQvNFCTU9eSrB//EkR7hnfypwI9PNg
         75RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794529319; x=1795134119;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hh3AiM4JMbQc/Rx8K3OAFBZ9qfGIYX00CL0MGMjf07Y=;
        b=A9c4Z0aNx7th3cbN0PJHyY0y4shAVu8M5LNb9qJPGTJ6v1INejR2nRC0abmpfQ+Qnq
         OOD/Zp6FSey9Y55x5doNJSfzRRujMnsjruYtSkx7O9iXxksz9rfajqPhSQmiCRguMnCU
         6HEnDTgbAeHhX6a3eDdtRVygUzyn4YnbKkxIxwOT5AbEH4ZZiEzZxkyp2XeNGh+4wkjY
         6kuF6Lh/P544V62Uffw9z/ivcfGBrPjJJCGf0R6uA7RMODHtuxh7WU9IFXn+sMcMI8nT
         SfViPopMKo9e1IEwdXGdXUHa1SFL9xFF2+Y2hrR1AAWE+TwG0nXZQqezvNmXQ8G5knZI
         Vwqw==
X-Forwarded-Encrypted: i=1; AL+hErGrnHaIkGQoIQzDX3H2JnrHnmWRP0wBga5n70VWH4+iAjVHo4ZZS1JqLtHzi7OZH4GwYhnSZEI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/o2MmvQ+U7/x33bk/NCbdDI6hacX92Z+WIkJ4cI9Qim6Ph/DJf
	oVVgVu/EOM+OYz+MMJSePiiMT37k8vgMoXWteJCghmU1e5VXBN9h8TXiQ/PNxVDE3K8=
X-Gm-Gg: AYBFou2lXk1YpGQ4IEX0YLqRxvDKur9zel2c/fSvcVOJzZbgpjJKycpoB1825vWn6TI
	AuiS3LjRk8Tnm+4k2N/7RiHh4V3AYTi6MmSpOEjgvfCfLD4y5IEww5Fasbib9rHX/7y8VM0vRTO
	+fW9xoWh1xiL/4mlx9W388YsVLQYsF78eoqVNXdFviLn3PNt7/b1GZ1er1lkSpAu9JkBmsa1U7g
	XdbfNNqlZeXxgLImJsOSOYwQi8PVHGWlSAfMq9siWOaiz9BvMGESlMS9hJMm9rzZjHliPEmjO/B
	LAG/H5EbxroGr41iZLk9rMvvV+bt9pHFeyTq79qQzk1iPMl3Sh9Sva2q/Mtqb552U5eOKxCgZd8
	kk9VXWHEQ3u9iD2Xij4fynfG2mC4NlRugM5Sx3jFQIUE00QhKun/6GR1q2dzbOT2i7M2VX9XRmU
	fgDhsz0YbnQS4tud+yDfqmryWwe42nNZGer1/Djqrlw+/fcCPiXBoh/SJjxWcwNTcVOrG4947V1
	C7LSyUJY+n9wUEhWvlTGfZparGfPdEVkzwGeTKP1aPhXEmNR7Hxt9cuaQMEAdZnqbnm9uDApCna
	edz9Ve9Q6fIiFncbEMUo5h93egipe/uq/9WpJwtZ5zFuNw==
X-Received: by 2002:a05:6214:4521:b0:917:96b8:de25 with SMTP id 6a1803df08f44-91f24050652mr14586826d6.1.1794529318884;
        Thu, 12 Nov 2026 16:21:58 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.248])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91f23c9ca2esm7986186d6.6.2026.11.12.16.21.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 16:21:58 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Fri, 13 Nov 2026 00:21:31 +0000
Subject: [PATCH net-next 4/4] net: test more frag_list layouts without SG
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261113-b4-skb-segment-clone-fixes-v1-4-f777fb06f3e7@toxicpanda.com>
References: <20261113-b4-skb-segment-clone-fixes-v1-0-f777fb06f3e7@toxicpanda.com>
In-Reply-To: <20261113-b4-skb-segment-clone-fixes-v1-0-f777fb06f3e7@toxicpanda.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Fernando Fernandez Mancera <fmancera@suse.de>, 
 Mina Almasry <almasrymina@google.com>, 
 David Laight <david.laight.linux@gmail.com>, netdev@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1794529294; l=8501;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=q9T8I8OUXiDYR7Yx72apFmZMUM3ac3UgkB8E6iwlgcw=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJNZIyvMpBp1DLezKHBVSYjtEwzH+k2jEFA7VjTgjNY3/m+FjOM1c/H7CmeOMTEWwYBo10CFnQw
 m5u0H0rV+OAQ=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

Add layouts that skb_segment() got wrong without SG, which have to be
segmented now.

For "net: skbuff: don't clone a nested frag_list member":

 - A nested frag_list with one more member after it.
 - The same with a last member that is never cloned, so that the walk
   doesn't run out of members.
 - A nested member that is shorter than a segment.  It was never cloned,
   so this case passes without the fix too.

For "net: skbuff: don't clone a stale frag_list member", three layouts
where a member that has been copied from is as long as a later segment.

That patch leaves GSO_BY_FRAGS alone.  Add a GSO_BY_FRAGS layout with
data pulled into the head, which fails with -EINVAL before and after.
It would be cut in the wrong places if GSO_BY_FRAGS took the new test.

Two fields say which cases nest the second member and which use
GSO_BY_FRAGS, instead of a test for each id.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/net_test.c | 141 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 129 insertions(+), 12 deletions(-)

diff --git a/net/core/net_test.c b/net/core/net_test.c
index 6a1aebac5874..19a12e1c048a 100644
--- a/net/core/net_test.c
+++ b/net/core/net_test.c
@@ -48,6 +48,13 @@ enum gso_test_nr {
 	GSO_TEST_SHORT_FRAG_LIST,
 	GSO_TEST_SHORT_GSO_BY_FRAGS,
 	GSO_TEST_FRAG_LIST_NESTED_NO_SG,
+	GSO_TEST_FRAG_LIST_NESTED_NEXT_NO_SG,
+	GSO_TEST_FRAG_LIST_NESTED_TAIL_NO_SG,
+	GSO_TEST_FRAG_LIST_NESTED_COPY_NO_SG,
+	GSO_TEST_FRAG_LIST_STALE_TAIL_NO_SG,
+	GSO_TEST_FRAG_LIST_STALE_HEAD_NO_SG,
+	GSO_TEST_FRAG_LIST_STALE_FRAGS_NO_SG,
+	GSO_TEST_GSO_BY_FRAGS_PULLED_NO_SG,
 	GSO_TEST_SHORT_LINEAR_NO_SG,
 	GSO_TEST_SHORT_LINEAR_STRADDLE_NO_SG,
 	GSO_TEST_SHORT_FRAG_LIST_NO_SG,
@@ -73,6 +80,12 @@ struct gso_test_case {
 	unsigned int missing_len;
 	/* segment without NETIF_F_SG */
 	bool no_sg;
+	/* the second frag_list member hangs off the first one's frag_list
+	 * instead of off the head's
+	 */
+	bool nested;
+	/* gso_size is GSO_BY_FRAGS */
+	bool by_frags;
 
 	/* output as expected */
 	unsigned int nr_segs;
@@ -192,6 +205,7 @@ static struct gso_test_case cases[] = {
 		 */
 		.id = GSO_TEST_GSO_BY_FRAGS,
 		.name = "gso_by_frags",
+		.by_frags = true,
 		.nr_frag_skbs = 4,
 		.frag_skbs = (const unsigned int[]) { 100, 200, 300, 400 },
 		.nr_segs = 4,
@@ -271,11 +285,9 @@ static struct gso_test_case cases[] = {
 		.err = -EINVAL,
 	},
 	{
-		/* the second frag_list member hangs off the first one's
-		 * frag_list instead of off the head's
-		 */
 		.id = GSO_TEST_FRAG_LIST_NESTED,
 		.name = "frag_list_nested",
+		.nested = true,
 		.linear_len = GSO_TEST_SIZE,
 		.nr_frag_skbs = 2,
 		.frag_skbs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE },
@@ -309,6 +321,7 @@ static struct gso_test_case cases[] = {
 	{
 		.id = GSO_TEST_SHORT_GSO_BY_FRAGS,
 		.name = "short_gso_by_frags",
+		.by_frags = true,
 		.nr_frag_skbs = 2,
 		.frag_skbs = (const unsigned int[]) { 100, 200 },
 		.missing_len = 50,
@@ -320,6 +333,7 @@ static struct gso_test_case cases[] = {
 		 */
 		.id = GSO_TEST_FRAG_LIST_NESTED_NO_SG,
 		.name = "frag_list_nested_no_sg",
+		.nested = true,
 		.linear_len = GSO_TEST_SIZE,
 		.nr_frag_skbs = 2,
 		.frag_skbs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE },
@@ -327,6 +341,109 @@ static struct gso_test_case cases[] = {
 		.nr_segs = 3,
 		.segs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE, GSO_TEST_SIZE },
 	},
+	{
+		/* a clone of the first member would lose the nested data, and
+		 * the third member would go out in its place
+		 */
+		.id = GSO_TEST_FRAG_LIST_NESTED_NEXT_NO_SG,
+		.name = "frag_list_nested_next_no_sg",
+		.nested = true,
+		.linear_len = GSO_TEST_SIZE,
+		.nr_frag_skbs = 3,
+		.frag_skbs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE,
+						      GSO_TEST_SIZE },
+		.no_sg = true,
+		.nr_segs = 4,
+		.segs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE,
+						 GSO_TEST_SIZE, GSO_TEST_SIZE },
+	},
+	{
+		/* the same, but the last member is never cloned, so the walk
+		 * doesn't run out of members either
+		 */
+		.id = GSO_TEST_FRAG_LIST_NESTED_TAIL_NO_SG,
+		.name = "frag_list_nested_tail_no_sg",
+		.nested = true,
+		.linear_len = GSO_TEST_SIZE,
+		.nr_frag_skbs = 4,
+		.frag_skbs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE,
+						      GSO_TEST_SIZE, 200 },
+		.frag_skb_frags = (const unsigned int[]) { 0, 0, 0, 100 },
+		.no_sg = true,
+		.nr_segs = 5,
+		.segs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE,
+						 GSO_TEST_SIZE, GSO_TEST_SIZE, 300 },
+	},
+	{
+		/* the nested member is shorter than a segment, so it was never
+		 * cloned
+		 */
+		.id = GSO_TEST_FRAG_LIST_NESTED_COPY_NO_SG,
+		.name = "frag_list_nested_copy_no_sg",
+		.nested = true,
+		.linear_len = GSO_TEST_SIZE,
+		.nr_frag_skbs = 3,
+		.frag_skbs = (const unsigned int[]) { 500, 500, GSO_TEST_SIZE },
+		.no_sg = true,
+		.nr_segs = 3,
+		.segs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE, GSO_TEST_SIZE },
+	},
+	{
+		/* the copy doesn't move the walk past the 3 byte member, which
+		 * then is as long as the last segment
+		 */
+		.id = GSO_TEST_FRAG_LIST_STALE_TAIL_NO_SG,
+		.name = "frag_list_stale_tail_no_sg",
+		.linear_len = GSO_TEST_SIZE,
+		.nr_frag_skbs = 3,
+		.frag_skbs = (const unsigned int[]) { GSO_TEST_SIZE, 3, GSO_TEST_SIZE },
+		.no_sg = true,
+		.nr_segs = 4,
+		.segs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE, GSO_TEST_SIZE, 3 },
+	},
+	{
+		/* half of the first member is copied along with the end of the
+		 * head, and the member is as long as the next segment
+		 */
+		.id = GSO_TEST_FRAG_LIST_STALE_HEAD_NO_SG,
+		.name = "frag_list_stale_head_no_sg",
+		.linear_len = 2 * GSO_TEST_SIZE + 500,
+		.nr_frag_skbs = 2,
+		.frag_skbs = (const unsigned int[]) { GSO_TEST_SIZE, 500 },
+		.no_sg = true,
+		.nr_segs = 4,
+		.segs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE,
+						 GSO_TEST_SIZE, GSO_TEST_SIZE },
+	},
+	{
+		/* the same with a frag on the member, which used to get its
+		 * first bytes sent twice instead of an error
+		 */
+		.id = GSO_TEST_FRAG_LIST_STALE_FRAGS_NO_SG,
+		.name = "frag_list_stale_frags_no_sg",
+		.linear_len = 500,
+		.nr_frag_skbs = 1,
+		.frag_skbs = (const unsigned int[]) { GSO_TEST_SIZE },
+		.frag_skb_frags = (const unsigned int[]) { 700 },
+		.no_sg = true,
+		.nr_segs = 3,
+		.segs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE, 200 },
+	},
+	{
+		/* 16 bytes of the first member were pulled into the head.  The
+		 * lengths come from a stale member too, and the first one
+		 * divides the total, so this must not start to succeed with
+		 * three segments of 1000 bytes.
+		 */
+		.id = GSO_TEST_GSO_BY_FRAGS_PULLED_NO_SG,
+		.name = "gso_by_frags_pulled_no_sg",
+		.by_frags = true,
+		.linear_len = 16,
+		.nr_frag_skbs = 3,
+		.frag_skbs = (const unsigned int[]) { 1000, 1016, 968 },
+		.no_sg = true,
+		.err = -EINVAL,
+	},
 	{
 		/* without SG it is skb_copy_bits() that runs out of data */
 		.id = GSO_TEST_SHORT_LINEAR_NO_SG,
@@ -357,6 +474,7 @@ static struct gso_test_case cases[] = {
 	{
 		.id = GSO_TEST_SHORT_GSO_BY_FRAGS_NO_SG,
 		.name = "short_gso_by_frags_no_sg",
+		.by_frags = true,
 		.nr_frag_skbs = 2,
 		.frag_skbs = (const unsigned int[]) { 100, 200 },
 		.missing_len = 50,
@@ -478,19 +596,18 @@ static void gso_test_func(struct kunit *test)
 		skb->data_len += total_size;
 		skb->truesize += total_true_size;
 
-		if (tcase->id == GSO_TEST_GSO_BY_FRAGS ||
-		    tcase->id == GSO_TEST_SHORT_GSO_BY_FRAGS ||
-		    tcase->id == GSO_TEST_SHORT_GSO_BY_FRAGS_NO_SG)
+		if (tcase->by_frags)
 			skb_shinfo(skb)->gso_size = GSO_BY_FRAGS;
 
-		if (tcase->id == GSO_TEST_FRAG_LIST_NESTED ||
-		    tcase->id == GSO_TEST_FRAG_LIST_NESTED_NO_SG) {
+		if (tcase->nested) {
 			struct sk_buff *first = skb_shinfo(skb)->frag_list;
+			struct sk_buff *second = first->next;
 
-			skb_shinfo(first)->frag_list = first->next;
-			first->next = NULL;
-			first->len += tcase->frag_skbs[1];
-			first->data_len += tcase->frag_skbs[1];
+			first->next = second->next;
+			second->next = NULL;
+			skb_shinfo(first)->frag_list = second;
+			first->len += second->len;
+			first->data_len += second->len;
 		}
 	}
 

-- 
2.55.0

