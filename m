Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590451;
	b=2bd8l/mmkVUelfZm3hXkqVw96FFIKDspjSprFqErCdoW3phI99Fj0sWYEnLIuJ+VJmb9
	 bd6H6bt9wCdnP8VLrzNJA/Fk8WNJmH5Bqsvm+fVzmFpn0fY7VQjNIoR55RscKQRDsCUvT
	 Wv55UGAxnjgXhDjCYjbKM5fj4J5PaQyLj8DjE5cX22CGaRhcGKhaK/ocqxBvzmGKkz8jn
	 jl6+LEvvZU6tKgzBkq2HMxEx5MP8Uq/OQJCyDQag/GEWk0Ee4rFQYj0HZTfxJ1kNOw1aw
	 3nFuEHx509/SqcyMo7TpU+ELF48O+mTws1R5wzDizncwTCxjBHF64eJIdQj9oWXzvbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590451;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=k0p9amurCDLU2dmqJDge7ICpn0TqfU4pmUDL+z2zafc=;
	b=S73s5sEJwRXpUrR/TBYdwKa4AtU+Ask2wRhGqPSvLlOUHkWTpsxat6MHWBjslBN5DUjb
	 g2fKBHee5UwpwHrfjOY9bL5vKiV3NMA4nBOJ0YGn+aTOkqkmwEPSEpkadPpUEwmMM3WIu
	 LJTc27kbk5dPwkx2CQLJ/rhlOTv0yhoq7oOl567DWB4SMjOENIRrtxAxjnj+f5p7YXIU+
	 9Xu9DL3L0cnBBValDgbM6IxCC8LpVkSKQdt1MDOAgMI3otOqXBmLPgN89cwkDAy5Mg/zl
	 203h2kpHZO8IsEm9EtY2AKPpYFsINcf6inGP5NAdsB6cWVI0RR+2O8zejXDFs9ic+8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=k2Vw4S+Q;
	arc=none smtp.remote-ip=209.85.128.177
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8B460A262E
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 13:47:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C8B460A262E
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=k2Vw4S+Q
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-8ac4806e210so6882237b3.1
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 06:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792590450; x=1793195250; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=k0p9amurCDLU2dmqJDge7ICpn0TqfU4pmUDL+z2zafc=;
        b=k2Vw4S+QFVzOR6Q/tcwzpJYiynfa7myi27eI5XocLEl7oVDVLrktTra6IOYEcuLulN
         D77uYIZLE/1w0kTD1YjNCp87Vp++kbWSnA38inHu64XQ0z55/Nnucuc+zXgWnHUdEMdW
         FOodgtcFklbw196yLjJcbZFuEfz4OPrArk40wzeoHbltJOUx/t1JCWAB0t5LPckyb91K
         0cKCqe6166B5w8bvOI2LoNI6dXLNN4Gj7QZrDIAYpbtmCDbS/fBdsIJTfrMucqY5nwRD
         selBAIpPiMk1VK4wQTQjUGv1KlTetdJsd4Ws2Vi4FDUzBWAe5Cddxu++yVYDZqfcJIXg
         K1HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792590450; x=1793195250;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k0p9amurCDLU2dmqJDge7ICpn0TqfU4pmUDL+z2zafc=;
        b=OvsQ5K+coigx8zWe3SD/cfoCxoRR6v+pOYKkl13FB+IVQKxS+OP+bkSLvh+n+ET6HX
         hB5rDmDh6uXEfEjwSoAAvmvPbHFAJnu4xmdBma74/+M//gFZI+Z+JIqDgolQK31SKv5H
         fwDTmJHorC0S32ZYSjaxdlUbtOukH+y0e7hiO3DkDmdJsOeH22kj9hMtsMbk4QY261fh
         YWi+/0Mm4jz1Xf+PQZpEirduCZA2rIzlx6tE1cPJcCxol4E5+41zsVDuLapWL1OrWmsb
         oP4V7d2nHwiO7ZxFeP2sj3aTDd/bfud7hM/yr3L0AIFNG4LlAqkBE+lk3l5v193Njnpt
         HaWw==
X-Forwarded-Encrypted: i=1; AKwUvBxpPWBzF4hMlPcjtEZXlmjnVrmaV1CUXlTp0Nrsz5HAMvaZ/TB/kruu8k5dFRkYc3t6Pi6IGkg=@vger.kernel.org
X-Gm-Message-State: AFq9FYKjs9mpyk3jpUROz0vEfwQVSa1cO0ide9LZFKkpcVZ88IY6OyNA
	mLVJDKawY6IkcFuMCrfTzht/QVlkPfbF796GATRB3D//8rUHnQy4RyHatdnQfk1XeLk=
X-Gm-Gg: AYBFou0g9i8CxxqiNjIhEP8jh/6yHh+39QDAZ3P/T0lvVHDCEJx+bvCMFgd5EJ6NXei
	mAL7dCUIHg+HfRTWalZb8wAXduo/DQ0AXjfNncLmh0gDHACh1XWALt0Mz9vHy+uhg1aj9J9SDVE
	a8hlYomw44OHCHLtm0ShCqsiF3T6HKtn9ZqsnGTJ1ih6c75x9SVxDC/jCw0fe+mP2Bkc5WuIIyN
	dz9XP/NOzAXTt8ahWnZhvrCB//kfgYoZCd3px3uLfe7S7WriMKzjigyJetau37VLLMt2JmkIpBx
	RGLzHDsVMd4QaW418Hp3wZQIvm5cgD4qtDa+4HXEyMZsTfkZn5BPxQvxiGlTqUe7pdWHO9AK4uM
	ABl5QNsT1Frl3WmLFPeP+YKry6KNl5r5WxaRbq3TCx//cDNntxQGopdp+EMJqkAr4SPY8LVuAQd
	RXuh9CQozul0aQZB29iO/DT1gZ7rYZWlCkuQVF/Fs61cAcdeOLacd/IaSbO8lE2pMLonhgdejZb
	pYMI+V4Lc+KbI9UT8tLBSsGCOtK+z/HgVTyPHM1nm91pe81XrmtkNinRIJ+xc+HcCkS1swqV4js
	TW+2dC4juecKGuOjow==
X-Received: by 2002:a05:690c:282:b0:8b0:8a9c:fac9 with SMTP id 00721157ae682-8b133fdfa78mr12586347b3.28.1792590450548;
        Wed, 21 Oct 2026 06:47:30 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.248])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b1347fc578sm8595177b3.36.2026.10.21.06.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:47:29 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 21 Oct 2026 13:46:56 +0000
Subject: [PATCH net-next v2 12/15] net: test the frag_list layouts
 skb_segment() refuses
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
Message-Id: <20261021-b4-skbuff-bug-on-followups-v2-12-2aa780a03524@toxicpanda.com>
References: <20261021-b4-skbuff-bug-on-followups-v2-0-2aa780a03524@toxicpanda.com>
In-Reply-To: <20261021-b4-skbuff-bug-on-followups-v2-0-2aa780a03524@toxicpanda.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Fernando Fernandez Mancera <fmancera@suse.de>, 
 Mina Almasry <almasrymina@google.com>, 
 David Laight <david.laight.linux@gmail.com>, netdev@vger.kernel.org, 
 xen-devel@lists.xenproject.org, Willem de Bruijn <willemb@google.com>, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1792590423; l=3631;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=ciolQj524j1USUzaeLZb/LHm0dD/CBvyPNIxBZrRY0k=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QJe3JwejlUG1MTBrcQrYruvC03fnpYN7R/Yfj2aVB3nUZLxD2jgW6l4Sp+Atgj8oyoEvxHlliU3
 gY7jb4nUyNgY=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

The GSO KUnit test only checks layouts skb_segment() can segment.  Add
two it has to refuse with -EINVAL: the non-uniform frag_list with SG
on, which used to hit the BUG_ON(i >= nfrags) the existing test steps
around, and a frag_list member that has its own frag_list.

Both warn on CONFIG_DEBUG_NET kernels, so run them with the warning
backtrace suppressed.  Also update the comment on the non-uniform case,
which still says SG would hit that BUG_ON().

Reviewed-by: Willem de Bruijn <willemb@google.com>
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/net_test.c | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 51 insertions(+), 2 deletions(-)

diff --git a/net/core/net_test.c b/net/core/net_test.c
index bc2ef7612e7d..222d24793591 100644
--- a/net/core/net_test.c
+++ b/net/core/net_test.c
@@ -39,6 +39,8 @@ enum gso_test_nr {
 	GSO_TEST_RESEGMENT_MULTI,
 	GSO_TEST_RESEGMENT_TAIL,
 	GSO_TEST_RESEGMENT_ONE_MSS,
+	GSO_TEST_FRAG_LIST_NON_UNIFORM_SG,
+	GSO_TEST_FRAG_LIST_NESTED,
 };
 
 struct gso_test_case {
@@ -57,6 +59,9 @@ struct gso_test_case {
 	unsigned int nr_segs;
 	const unsigned int *segs;
 	const unsigned int *gso_segs;
+
+	/* skb_segment() is expected to fail with this error */
+	int err;
 };
 
 static struct gso_test_case cases[] = {
@@ -204,6 +209,28 @@ static struct gso_test_case cases[] = {
 		},
 		.gso_segs = (const unsigned int[]) { 0, 0, 0, 0 },
 	},
+	{
+		/* frag_list members that don't end on gso_size boundaries
+		 * can't be segmented with SG
+		 */
+		.id = GSO_TEST_FRAG_LIST_NON_UNIFORM_SG,
+		.name = "frag_list_non_uniform_sg",
+		.linear_len = GSO_TEST_SIZE,
+		.nr_frag_skbs = 4,
+		.frag_skbs = (const unsigned int[]) { GSO_TEST_SIZE, 1, GSO_TEST_SIZE, 2 },
+		.err = -EINVAL,
+	},
+	{
+		/* the second frag_list member hangs off the first one's
+		 * frag_list instead of off the head's
+		 */
+		.id = GSO_TEST_FRAG_LIST_NESTED,
+		.name = "frag_list_nested",
+		.linear_len = GSO_TEST_SIZE,
+		.nr_frag_skbs = 2,
+		.frag_skbs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE },
+		.err = -EINVAL,
+	},
 };
 
 static void gso_test_case_to_desc(struct gso_test_case *t, char *desc)
@@ -283,19 +310,41 @@ static void gso_test_func(struct kunit *test)
 
 		if (tcase->id == GSO_TEST_GSO_BY_FRAGS)
 			skb_shinfo(skb)->gso_size = GSO_BY_FRAGS;
+
+		if (tcase->id == GSO_TEST_FRAG_LIST_NESTED) {
+			struct sk_buff *first = skb_shinfo(skb)->frag_list;
+
+			skb_shinfo(first)->frag_list = first->next;
+			first->next = NULL;
+			first->len += tcase->frag_skbs[1];
+			first->data_len += tcase->frag_skbs[1];
+		}
 	}
 
 	features = NETIF_F_SG | NETIF_F_HW_CSUM;
 	if (tcase->id == GSO_TEST_GSO_PARTIAL)
 		features |= NETIF_F_GSO_PARTIAL;
 
-	/* TODO: this should also work with SG,
-	 * rather than hit BUG_ON(i >= nfrags)
+	/* TODO: this should also work with SG, rather than fail the
+	 * i >= nfrags check in skb_segment()
 	 */
 	if (tcase->id == GSO_TEST_FRAG_LIST_NON_UNIFORM)
 		features &= ~NETIF_F_SG;
 
 	SKB_GSO_CB(skb)->max_segs = tcase->max_segs;
+
+	if (tcase->err) {
+		/* the suppression block doesn't run if it can't be set up */
+		segs = NULL;
+		kunit_warning_suppress(test) {
+			segs = skb_segment(skb, features);
+		}
+		KUNIT_EXPECT_EQ(test, PTR_ERR_OR_ZERO(segs), tcase->err);
+		if (!IS_ERR_OR_NULL(segs))
+			kfree_skb_list(segs);
+		goto free_gso_skb;
+	}
+
 	segs = skb_segment(skb, features);
 	if (IS_ERR(segs)) {
 		KUNIT_FAIL(test, "segs error %pe", segs);

-- 
2.55.0

