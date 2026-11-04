Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825285;
	b=tO68tc3ajNlinKHMzTSD0eWxOT0a7B6mnJNWBC3Fl0p+mBHjFk6aN1/k9XtajJzHoy3e
	 yQ29oBz6HYrtCAreK5VtvxBBEqeBU/Hlrawfs/dR21LO7xBmBdbPu78/GAsPI33QhGx9q
	 0c6wbmryeQ70jXYpwIkkABjT35pigbLXdWnwebEDmaGwSGR9p/TMRIoJ0F7spZajefegQ
	 aPL+GisxYtfM1iy3/2Ax04SxTs/63Mx0Y4/QaXm2k4Pd1oSjYYQEby1lS3ErQrUs44xYG
	 ZSPF2yN5UBh+6A1W0EYzh0U2wm/2Edr6a/NYvOf7+SV+PvYOk7ox0BZDC/mMHo7mqXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825285;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=p0RXmawfasrTX5jMs9+VRHea8GI7D/GAkKgJQ1fq4BU=;
	b=xwggC/RzhAVSruKIxR3u6+c39HU7U3hMS+0sRkAUePkLAxz44TOESEv62+vDV3xaiP2V
	 C/s+AwFvELPhw6YbyieMrhnXvlQeVTCe+RUqUOblB4hXPr1/Ypr2YdV2JViVRJYxksN5Z
	 d6MUB3PIFg6XkuXVnmMNufCX9HpQpdfFQLT17Dv2Ou27Xyuwz5BugJN7I6VwGY3C6KGAW
	 IWEeIZ5hXnVPHXYS6Xw7MI1LDdZWYa28+ktFUR95/v1WUouCo8RCXpj02D3xcLvmPddX4
	 zI+olXANKs3+NKl3LmC1EWVrM34ObE6ZVfsEfBmw0EAR4W+6aZI9C9n/ZZlNfz9iB4Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Gd0JG0KC;
	arc=none smtp.remote-ip=209.85.219.44
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02D7A60A6F69
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 20:48:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 02D7A60A6F69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Gd0JG0KC
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-917a707f37eso12697346d6.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 12:48:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793825284; x=1794430084; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p0RXmawfasrTX5jMs9+VRHea8GI7D/GAkKgJQ1fq4BU=;
        b=Gd0JG0KCotJGo3WH35B6orxcA51ZKU9EWkbtMtrY+MEARE9Zvj95DQU37FkDf7nb3j
         v6iSzzSn5B+qZ3y/7h0Ls160dmXaWwWKdz4kWxPwQgHBd1IvM1ZzCv7zmFhq9WBnNk7B
         BT7ab0RhbmBhQSaA0IsGWBcZF+HACjduH3DIHgNWVpOYLAPoFKcC2OlxRf4MstJkHsOI
         jDa857iUvVeB0Qd6+Zcj+rq1wkQPqgoxa4PughTYFPuRzokJa4C+SK78eWWFWiowtw2c
         Kfp4t+LkWZfBmgUEEv01hnSu2sJRWN6opptN+I/AuNYKXbNNVmfg6VFGzU2Ay70aiHY5
         ZBkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793825284; x=1794430084;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=p0RXmawfasrTX5jMs9+VRHea8GI7D/GAkKgJQ1fq4BU=;
        b=eytz+w5hlOayOa4DlmHkhNYGcnowPOkL7JaJKHJR+ABvzxL0pBko7TDpaBk6QRYKF8
         QopwxKeRwzlMx6ohPYYjIttVVjkRd5cM/nfwiz0XTjyfEXTMAEPV0QOUEXXjHmtWHvY0
         2qSPzGLvQImwli93zgYoxUmDnM/YDvunMKVORdhaXVtZ1pOoLu9S6fKS1YWbZ7UG1ORF
         yp1p7JtOzSsKOVGIFdGm7D6v2cEND/22jEIat68gxQUx5C18GJZu5oVmX3J8qJqmitVJ
         pWziDeTidsYbNgctgnJxEeX5xD8XMBDyeNZ8mFaa6k6+7hPvcGwarral5D9OOwlS0uVt
         nEEw==
X-Forwarded-Encrypted: i=1; AKwUvByY992k8+n5C4xET88pEJ0olnxaW3dzou6woddc7nFsAlUgjyh8+3LQHs9tz/n+7PD9/cewSk4=@vger.kernel.org
X-Gm-Message-State: APuU4Z9/hVOKT4RrS9ZLhhbrndleRhRrzs0kKEfPyAmQMMo+md9XwZzd
	mPxD3TUdVd+6dtTWgct9I/LkQmVe1qZBUOwEKA1BfnlOOYaEIfe/nQFWLnYNow0/C3c=
X-Gm-Gg: AYBFou2jCNnIvoIJzDqRo+Tlc1BfO9I0v/6gsZsSZM5b4SVKEwk/fUQN3tshrza+QAN
	6Iijv8Anjp/UJsBDFCQ5985Ni3uvEDYbNzUgd1n5Bnpv2MS+8ZF5Z9UuPcWC4QJZaE3bPtZBzu8
	B99beTKSZd8eYeGP4BBf4/KBjVzRpxRROlO6FX2yJACsW2b3MObhQgS/qM41uup49XIBNPHgtZg
	mYq96nas7yw6t4ZRXUzoxVuhvuFVo09C9JdM1+fynXIq2A+icxDv+L5atgiIucFzEtmWDz88DJu
	NRVzdyRj9W8qkqWNo3NbO1Bd638t5kpWUXqRbldU7P61YKKbkdbm4rIeAKlh6piMyeCLDOOxj+q
	Qr+LnZJTIshuRqI2CR4xvXSZFebjvwM9aOv3hGUBcJrLloDDw3dxF2V5yRxo5moth10g5MHWt7n
	Ih57ZRAdSQdhvQ82DG3kKdLKyNO/uorsf6VgNoAlkpn4388NTJyf8RkYPpQ4xCLh885JwZlSWaY
	JdfQ5vMbC95HadxKF7BChnCTEb9msrZnt8QETaFHwb51tlyILk6y/qPTYTzM85ytOKwHUpzvYmf
	dnJq6F2ODmd4uslRYTLNpIPx5FxAZ6RWdlsc1SM26FhMrg==
X-Received: by 2002:ad4:5ae6:0:b0:91e:93df:7968 with SMTP id 6a1803df08f44-91e93df8690mr14233906d6.58.1793825283878;
        Wed, 04 Nov 2026 12:48:03 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.244])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e962b4403sm2745066d6.20.2026.11.04.12.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 12:48:03 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 20:47:24 +0000
Subject: [PATCH net-next v4 12/15] net: test the skb layouts skb_segment()
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
Message-Id: <20261104-b4-skbuff-bug-on-followups-v4-12-b7ffeb364f5d@toxicpanda.com>
References: <20261104-b4-skbuff-bug-on-followups-v4-0-b7ffeb364f5d@toxicpanda.com>
In-Reply-To: <20261104-b4-skbuff-bug-on-followups-v4-0-b7ffeb364f5d@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793825269; l=7318;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=7eIKfmXdYFyO4gt39hdEL3I6I1+zpcaXVGaqmsE4mDU=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QER7Iemt/O5h6axALU8K/KXqZQqDuQVWaPwTSf9id6brnuO7euiqtgPfKirDjVhsD76QG+PWs0G
 ladydqEnuSgU=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

The GSO KUnit test only checks layouts skb_segment() can segment.  Add
the ones it has to refuse:

 - The non-uniform frag_list with SG on, which used to hit the
   BUG_ON(i >= nfrags) the existing test steps around.
 - A frag_list member that has its own frag_list.
 - An skb whose len counts bytes it doesn't hold.  The data runs out on
   a segment boundary, in the middle of a segment, after the last
   frag_list member, and with GSO_BY_FRAGS.

Run the last two groups without SG as well.  There the nested frag_list
is segmented.  A len that is too big fails with -EFAULT from
skb_copy_bits(), except with GSO_BY_FRAGS, which still gets -EINVAL.

They warn on CONFIG_DEBUG_NET kernels, so run them with the warning
backtrace suppressed.  Also update the comment on the non-uniform case,
which still says SG would hit that BUG_ON().

Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/net_test.c | 158 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 154 insertions(+), 4 deletions(-)

diff --git a/net/core/net_test.c b/net/core/net_test.c
index 2b5080c22663..03203454cd19 100644
--- a/net/core/net_test.c
+++ b/net/core/net_test.c
@@ -41,6 +41,17 @@ enum gso_test_nr {
 	GSO_TEST_RESEGMENT_MULTI,
 	GSO_TEST_RESEGMENT_TAIL,
 	GSO_TEST_RESEGMENT_ONE_MSS,
+	GSO_TEST_FRAG_LIST_NON_UNIFORM_SG,
+	GSO_TEST_FRAG_LIST_NESTED,
+	GSO_TEST_SHORT_LINEAR,
+	GSO_TEST_SHORT_LINEAR_STRADDLE,
+	GSO_TEST_SHORT_FRAG_LIST,
+	GSO_TEST_SHORT_GSO_BY_FRAGS,
+	GSO_TEST_FRAG_LIST_NESTED_NO_SG,
+	GSO_TEST_SHORT_LINEAR_NO_SG,
+	GSO_TEST_SHORT_LINEAR_STRADDLE_NO_SG,
+	GSO_TEST_SHORT_FRAG_LIST_NO_SG,
+	GSO_TEST_SHORT_GSO_BY_FRAGS_NO_SG,
 };
 
 struct gso_test_case {
@@ -58,11 +69,18 @@ struct gso_test_case {
 	unsigned int gso_type;
 	/* skbs from alloc_skb() instead of build_skb(), head_frag clear */
 	bool no_head_frag;
+	/* bytes that skb->len counts but the skb doesn't hold */
+	unsigned int missing_len;
+	/* segment without NETIF_F_SG */
+	bool no_sg;
 
 	/* output as expected */
 	unsigned int nr_segs;
 	const unsigned int *segs;
 	const unsigned int *gso_segs;
+
+	/* skb_segment() is expected to fail with this error */
+	int err;
 };
 
 static struct gso_test_case cases[] = {
@@ -241,6 +259,110 @@ static struct gso_test_case cases[] = {
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
+	{
+		/* without SG the nested data is copied by skb_copy_bits(),
+		 * which does look inside a member's own frag_list
+		 */
+		.id = GSO_TEST_FRAG_LIST_NESTED_NO_SG,
+		.name = "frag_list_nested_no_sg",
+		.linear_len = GSO_TEST_SIZE,
+		.nr_frag_skbs = 2,
+		.frag_skbs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE },
+		.no_sg = true,
+		.nr_segs = 3,
+		.segs = (const unsigned int[]) { GSO_TEST_SIZE, GSO_TEST_SIZE, GSO_TEST_SIZE },
+	},
+	{
+		/* without SG it is skb_copy_bits() that runs out of data */
+		.id = GSO_TEST_SHORT_LINEAR_NO_SG,
+		.name = "short_linear_no_sg",
+		.linear_len = GSO_TEST_SIZE,
+		.missing_len = 50,
+		.no_sg = true,
+		.err = -EFAULT,
+	},
+	{
+		.id = GSO_TEST_SHORT_LINEAR_STRADDLE_NO_SG,
+		.name = "short_linear_straddle_no_sg",
+		.linear_len = GSO_TEST_SIZE + 500,
+		.missing_len = 700,
+		.no_sg = true,
+		.err = -EFAULT,
+	},
+	{
+		.id = GSO_TEST_SHORT_FRAG_LIST_NO_SG,
+		.name = "short_frag_list_no_sg",
+		.linear_len = GSO_TEST_SIZE,
+		.nr_frag_skbs = 1,
+		.frag_skbs = (const unsigned int[]) { GSO_TEST_SIZE },
+		.missing_len = 50,
+		.no_sg = true,
+		.err = -EFAULT,
+	},
+	{
+		.id = GSO_TEST_SHORT_GSO_BY_FRAGS_NO_SG,
+		.name = "short_gso_by_frags_no_sg",
+		.nr_frag_skbs = 2,
+		.frag_skbs = (const unsigned int[]) { 100, 200 },
+		.missing_len = 50,
+		.no_sg = true,
+		.err = -EINVAL,
+	},
 };
 
 static void gso_test_case_to_desc(struct gso_test_case *t, char *desc)
@@ -337,21 +459,49 @@ static void gso_test_func(struct kunit *test)
 		skb->data_len += total_size;
 		skb->truesize += total_true_size;
 
-		if (tcase->id == GSO_TEST_GSO_BY_FRAGS)
+		if (tcase->id == GSO_TEST_GSO_BY_FRAGS ||
+		    tcase->id == GSO_TEST_SHORT_GSO_BY_FRAGS ||
+		    tcase->id == GSO_TEST_SHORT_GSO_BY_FRAGS_NO_SG)
 			skb_shinfo(skb)->gso_size = GSO_BY_FRAGS;
+
+		if (tcase->id == GSO_TEST_FRAG_LIST_NESTED ||
+		    tcase->id == GSO_TEST_FRAG_LIST_NESTED_NO_SG) {
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
-	if (tcase->id == GSO_TEST_FRAG_LIST_NON_UNIFORM)
+	if (tcase->id == GSO_TEST_FRAG_LIST_NON_UNIFORM || tcase->no_sg)
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

