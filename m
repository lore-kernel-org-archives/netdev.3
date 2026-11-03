Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672949;
	b=KMHWHzZskqiWCNhj5XHGLSf736bVTTDJz5g1DzSvDXSQB/GrZDWPYs0wcnU3sTPMvH6d
	 8+DP28a7LYv9vFEZUKHOShpa0S3CKp4N/TQ4fdiC78qBk9qdja89U2cy5LQu4N22OMAoj
	 OPtEs+SAXmdz7KDq1VnusUmmoyrWYuz0O2O5vMakfPv9nMsk3ou/IWkpyXJHgYr7l8cO0
	 8x8zCj2DxBAoW/k+fca5LLnaDyC5mZdKv8gpc7gpC3FuiNitpV1ZFHhqiSS/+wJdYbEKG
	 mEbSPrelPNOytbJBGhVJxHfgSpW/ac7h/jAYAKkH2ky6Wcmax+TirRTNEcWF8gAUpnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672949;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=MseyG3+pKKIruXhcv710BgM8fgKq/guu+mQy13emKdo=;
	b=ihu5S8mDyBoY+4nOE3GyMdUvr9vsYgwTP8nsx0QMyT5wkhwIEnk3kWW3FBP7ZvyLusMp
	 8nFtN0fbhyAVrOIxR8ZkhPP1hy1mnxzE6qDS+SVQJn7yQKCIF39tGqL0tAE3rzQOA1qvY
	 9eGl8xOVKZTu7mkktz4hakR0w18OmTVcQHP+oq4LUiy4G89aYy2xiHrbIZlOgTT2ItC9y
	 j6OqLThK/HKdUc65F/GKbQVuOXdaSgFyEy9Q3mHPpHIc6llHtxmD4mRbT2H8m7PodZ7K0
	 fu2+dWJVSporcXsFP+a54kHnvlqzdq1uQEuWxRz3yt7P0+cVWmaOXCFa8+MNeXjyGfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=lkao2XlK;
	arc=none smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523B4606D803
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 02:29:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 523B4606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=lkao2XlK
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-533797e72e8so23442911cf.2
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 18:29:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793672948; x=1794277748; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MseyG3+pKKIruXhcv710BgM8fgKq/guu+mQy13emKdo=;
        b=lkao2XlKv11xaRShXVDtBxt3xuYAOTcca9dNHKDGuN4lBlbldwqU9S6P4Edb2rlRD1
         6ou5DZ4aIzrDDj2RN9aOtpmJZ3vd+RrVOFshHLvEdgEN1RUVzVGn/m0pUbCxzQZIJRaw
         Z0l77Q6KFcqxu6CUo/jughGLnWYCh5QHVxL9RKyYJN9oHOBHZOgISd8qhpPy4QHqiPRY
         37yIhk5cPnRyG3mqIzAxRGVrqJVXhNbtSFMhjCgH+U3v43Ej5hUZtqnhJFSK5NeFJV47
         3foYiRvkGJojxH3UcNRYAwmKpzsIXJh8gey7TKO4TRWlN7J8yAxoDhFTxSDNYNI7TF3p
         QAww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793672948; x=1794277748;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MseyG3+pKKIruXhcv710BgM8fgKq/guu+mQy13emKdo=;
        b=1ZffxE0WfrzD5f+mKrwGX9zmwVDSLR5Sf3D6HkA8aoTGHyh5cHHrXtkLDs30KPuvSz
         Ndk7/2tOBL+nGmS00ZQtOLVadtOW3mCSzTnkKx2bEtsqCiBgSIdhlpi80kvKsGEKZkTY
         ADquhhTEBn8qVbPM4E4foW3RUMIWnwz/IVeByOnFOayHKS9375e0FmDeZVHxKPgxJhrB
         /vEXcArdk5JJVbseNK2QGc/Ga4K0AFUP2qztFM+EggSsezXziyBxmx3zSboRKTATaAXV
         ebr0lB0h9lQ23mmrsDU9YmBUzLxqfA8R4U2dF1WJfZcsN+gpIqydGP1iN5JLZQ26a8ns
         3hpg==
X-Forwarded-Encrypted: i=1; AKwUvBwlJROyf+Y8i+ZsV+CysNu0hlQjMoRlr/VXA8luFAeCtXdA72JlooQ4GrtWcznKpJNlApzPxYY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8vSXJqEW4Xs66gGGy9v8mDLYMMCmi+ZeWeKhBdzJZ4YaQ6tTkB
	cYln5E7zpmjp90P+DDnsutdpvm4UthYraEUWT+TqlrC+2TUgNoZYBt/ATFs4mPHWxPA=
X-Gm-Gg: AYBFou1GVbQOlLNZ0osVWNbrETHHxMvTGNDT+TqGBeio9TuS0VN/GAdSMygmsfJ3npr
	yBLdk5O6CJSEaSVKgsyeF7YqwLHOpTs9LpGttZPAfp/M4g93geLDEtdX/qN6BkA6pMwT7L6Ud0d
	c1JqYAfgNRoo8fdrfbpIHk92VZniVyHAJqIvt5w/Gapv8Cw6TpBTtNb2WguH98hDFgI+UWxRMfS
	I/MMKnt3C8pIlLg0ZT3EJpDFiyJJ5xllMxaPPS/fNHfb/DQOMR9dNNlMrTsXPz5eD+HOpky2kux
	Juy/3iTPUD4ouxrx7zqmABcFtU3ORef1gYhG6jN3nA7iRlZmLWE2p+jBZ4WDSnyN6ZoXhXQuIm3
	XUCKHBYPWsvD9dmEaD1BtHIRd5vyCMN42j+IwuH0d06pOJe6g7Ho6U4AS2uTsB9vFGSaosJvjpS
	Q0Wq/I0PSM4HoQx7TFPl8OSK0d1QA3v7l+vsM+Cv4u27pZ4d9TVfvRu3GNcGrEKszMwumKSf5to
	JQE37/PRRPxkKrtUrMX56DRKY/fe8br6JLDgpyvrLUzSBFUFTcdk985+Q7ZXNt3zImi8OB09jWY
	DPK6AxicW81EgnBi1Gkv+aZNRSp2PaldMCLJyP86fuUIxQ==
X-Received: by 2002:a05:622a:250e:b0:535:a5fa:ee05 with SMTP id d75a77b69052e-542b7ff0369mr187387061cf.69.1793672948244;
        Mon, 02 Nov 2026 18:29:08 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.253])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5498b49ce1dsm13814311cf.5.2026.11.02.18.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 18:29:07 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 03 Nov 2026 02:28:38 +0000
Subject: [PATCH net-next v3 12/15] net: test the skb layouts skb_segment()
 refuses
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
Message-Id: <20261103-b4-skbuff-bug-on-followups-v3-12-54ad0ab57614@toxicpanda.com>
References: <20261103-b4-skbuff-bug-on-followups-v3-0-54ad0ab57614@toxicpanda.com>
In-Reply-To: <20261103-b4-skbuff-bug-on-followups-v3-0-54ad0ab57614@toxicpanda.com>
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
 xen-devel@lists.xenproject.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793672923; l=5235;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=/VgW0oW9T+Tzy+i1BGO6eU3AucNR1Ntg0slpO9Mj98E=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKMmn6TBuIrBkysKogxABEz6HQG1Via38Q+vUl7yCgJi2hIoaEjJWJRzWZW20ii4tSe3afYAeZ4
 ExrUaw3kh8Ao=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

The GSO KUnit test only checks layouts skb_segment() can segment.  Add
the ones it has to refuse with -EINVAL:

 - The non-uniform frag_list with SG on, which used to hit the
   BUG_ON(i >= nfrags) the existing test steps around.
 - A frag_list member that has its own frag_list.
 - An skb whose len counts bytes it doesn't hold.  The data runs out on
   a segment boundary, in the middle of a segment, after the last
   frag_list member, and with GSO_BY_FRAGS.

They warn on CONFIG_DEBUG_NET kernels, so run them with the warning
backtrace suppressed.  Also update the comment on the non-uniform case,
which still says SG would hit that BUG_ON().

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/net_test.c | 98 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 95 insertions(+), 3 deletions(-)

diff --git a/net/core/net_test.c b/net/core/net_test.c
index 2b5080c22663..298ca240104c 100644
--- a/net/core/net_test.c
+++ b/net/core/net_test.c
@@ -41,6 +41,12 @@ enum gso_test_nr {
 	GSO_TEST_RESEGMENT_MULTI,
 	GSO_TEST_RESEGMENT_TAIL,
 	GSO_TEST_RESEGMENT_ONE_MSS,
+	GSO_TEST_FRAG_LIST_NON_UNIFORM_SG,
+	GSO_TEST_FRAG_LIST_NESTED,
+	GSO_TEST_SHORT_LINEAR,
+	GSO_TEST_SHORT_LINEAR_STRADDLE,
+	GSO_TEST_SHORT_FRAG_LIST,
+	GSO_TEST_SHORT_GSO_BY_FRAGS,
 };
 
 struct gso_test_case {
@@ -58,11 +64,16 @@ struct gso_test_case {
 	unsigned int gso_type;
 	/* skbs from alloc_skb() instead of build_skb(), head_frag clear */
 	bool no_head_frag;
+	/* bytes that skb->len counts but the skb doesn't hold */
+	unsigned int missing_len;
 
 	/* output as expected */
 	unsigned int nr_segs;
 	const unsigned int *segs;
 	const unsigned int *gso_segs;
+
+	/* skb_segment() is expected to fail with this error */
+	int err;
 };
 
 static struct gso_test_case cases[] = {
@@ -241,6 +252,61 @@ static struct gso_test_case cases[] = {
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
+	{
+		/* the data runs out on a segment boundary */
+		.id = GSO_TEST_SHORT_LINEAR,
+		.name = "short_linear",
+		.linear_len = GSO_TEST_SIZE,
+		.missing_len = 50,
+		.err = -EINVAL,
+	},
+	{
+		/* the data runs out in the middle of a segment */
+		.id = GSO_TEST_SHORT_LINEAR_STRADDLE,
+		.name = "short_linear_straddle",
+		.linear_len = GSO_TEST_SIZE + 500,
+		.missing_len = 700,
+		.err = -EINVAL,
+	},
+	{
+		.id = GSO_TEST_SHORT_FRAG_LIST,
+		.name = "short_frag_list",
+		.linear_len = GSO_TEST_SIZE,
+		.nr_frag_skbs = 1,
+		.frag_skbs = (const unsigned int[]) { GSO_TEST_SIZE },
+		.missing_len = 50,
+		.err = -EINVAL,
+	},
+	{
+		.id = GSO_TEST_SHORT_GSO_BY_FRAGS,
+		.name = "short_gso_by_frags",
+		.nr_frag_skbs = 2,
+		.frag_skbs = (const unsigned int[]) { 100, 200 },
+		.missing_len = 50,
+		.err = -EINVAL,
+	},
 };
 
 static void gso_test_case_to_desc(struct gso_test_case *t, char *desc)
@@ -337,21 +403,47 @@ static void gso_test_func(struct kunit *test)
 		skb->data_len += total_size;
 		skb->truesize += total_true_size;
 
-		if (tcase->id == GSO_TEST_GSO_BY_FRAGS)
+		if (tcase->id == GSO_TEST_GSO_BY_FRAGS ||
+		    tcase->id == GSO_TEST_SHORT_GSO_BY_FRAGS)
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
 
+	skb->len += tcase->missing_len;
+	skb->data_len += tcase->missing_len;
+
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

