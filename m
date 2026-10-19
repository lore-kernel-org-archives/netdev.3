Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E021E4F96A5
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 13:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417898; cv=none; b=gOCQWVhSbuT271MscGDyxoMXM3qYVuzczCL5wyOHoU9y8SCvK5QeNudMz+M2k+CvdyzVfsGWSPSQ5LoW1TKcn3+epUTxFItoUCdz67FkYKK7L+jZiq/1bJ6WvqFFjmXjoX8GBraYMq+SuigDB3U0s7lMQyHOgCx6YhWF706F3ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417898; c=relaxed/simple;
	bh=54YuJC4Sa4ftFWTwcdr1JHSPiV0/4B3b8lTqh1NoeIM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GY1zRLDknsmYmohLmwBiq/H3N74LdFL/uXV51PpDEZ08o9v1JiUFdA9TwIVfASb+Xmml7X+a2h4lh8VUI0yTfJw9RSVirDlWDtpc9BVtHattCV2FZM2GQItRjT4bp4pEo6x8TEw7+Ghkq9d25T38PB8OSFzUuqMYoLDC/qxK8vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=KKz8Q3gB; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="KKz8Q3gB"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-53394bffe0fso36182271cf.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 06:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792417896; x=1793022696; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cCcET6n/yfDRwSzhWgNa5UxSYwstO6x0SjXdcG6UWRc=;
        b=KKz8Q3gBwduopcuN1jY3Reg5tOh2puh8ahKwMdaNM86vYl0D8brvpUVoHtn6hUDkOL
         NzwmYkoQ4D5DF62wvT4cUC0rF7oARej8F+lkWplrhnjfhvlV1JoyHUfsk1sGTbj6Q3rL
         NpM5hQXU6ijskXlMdL7/MKOAyoHKuVklQcYmUgRLU/DiQkvEU0ZIj8089vwkFP4Rxftl
         M5a/WD56SIt4dvnIr96Uf2r43O5Zk/vAkj/ecwfIMab+RaVmPmc77i4QC+70JxdjwToJ
         5kyE6ikVTmqZ4aYJqhmHoVCIjuWW2KBHQkKK+RX8ubrVzHvVG1AVnMqW2Ju2f9NNMTm0
         ZO3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792417896; x=1793022696;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cCcET6n/yfDRwSzhWgNa5UxSYwstO6x0SjXdcG6UWRc=;
        b=aPPFHHthOPhBncjrsPumUACXjG13RbrudUXdcP/s9mmrKog1SDs5NU5WpDoZ66VXRr
         B4szLVqZkivdop+rggo5mxdgYT9+KFwKiLc/5MSPVqXnbr55R5E+oFSA2Ryt/isLhZob
         n6JQgzWtxt8iJOdoW3s3xawp9Ot/EhWw9qxNxhlfitpGN5Bw4Eu9YlG81Ij1Ff6af25T
         SX0L36FDXncnnj2gXf/0WC/J5SogjVQ4OynCA+NZ+vJmqjWJEHLepfG14HpCSMTZuA/w
         rQhS1yhXM24kjIqeelC7s7eT3cJHE79awyUN9369jWwRhHgs2eJP9r9LQ4bx2qOtsdFS
         CkCA==
X-Forwarded-Encrypted: i=1; AKwUvByvq/YIbencyEWAxKSJDpK2n4S/LW0UZlhzI6pvOpV70NGYQd4mdCQXE4KAxigzCh4plTRtpaY=@vger.kernel.org
X-Gm-Message-State: AFq9FYIvN1/s7iKwZU3wkJ2wTYNFxLlXDOV7cAxP0EanMGcw4lSI5ALA
	Gnj29KwN/cu9TgOvdXyYTda5hoAnlztYHB5ePxT5A67m2z+w74dCeXySmu7eiHr/esk=
X-Gm-Gg: AYBFou0YRevBMqlY2KYq09bInb1lg/Y/WtVoHWDAZqSzaKSA/mbOzAFELxyXLAt7qEf
	2xZBdSDoUkcNVxcmAGwnrcbslkHYEW/XsOR/PfsLBheKx47z9livSKlR/9Z0MR52DmGnb1CrncJ
	wDMYFB/9ArgNGEqWXJjQIupuSVjuW7/nmGaPlLupWbp3/VyUGfjbnnGX3ADrJeYaLYFVq5gqWzh
	n2DPP/1ahYrLMnJEHP+JxYCEOgwVoQYlEecG0mf0WQ9g4PfHLZ6GmGx3sd0RFqd9E5tUd/DGNSc
	0QfX+lZDrCuIDfhKA5DMEkev5aurtZjT5J45m/+8LNVHNwBFgyKdlQGyVVPF7JnACAodR7CC3fd
	QzfOFu/IJzdsmywbCtkd6GMK5Qx/icedEyubuz7PTyWGXqYiqLcGpDCqhnrwxe2ZPZ5RFJrel4u
	q5cPIsSkrWhRS2BwGk3g+mLTWEscCPSILafYZIoKJLUxmlrJS5XCR5X1bYjthrXNrBxsk5c2+Vk
	uWvkajo4IVFmVU=
X-Received: by 2002:a05:622a:8449:20b0:535:22e8:2fd3 with SMTP id d75a77b69052e-5362725afb9mr117803081cf.10.1792417895776;
        Mon, 19 Oct 2026 06:51:35 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.240])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5362a8e43cfsm99302081cf.5.2026.10.19.06.51.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:51:34 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 19 Oct 2026 13:50:46 +0000
Subject: [PATCH net-next 12/15] net: test the frag_list layouts
 skb_segment() refuses
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-b4-skbuff-bug-on-followups-v1-12-41dbef50b9f7@toxicpanda.com>
References: <20261019-b4-skbuff-bug-on-followups-v1-0-41dbef50b9f7@toxicpanda.com>
In-Reply-To: <20261019-b4-skbuff-bug-on-followups-v1-0-41dbef50b9f7@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1792417849; l=3190;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=54YuJC4Sa4ftFWTwcdr1JHSPiV0/4B3b8lTqh1NoeIM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMl/CfrGUamcaF3Ng1FUVBnBIHC3kZ7QHRED94+HWu2IRKE9xF6ZECYluILceDZSaJN+2T+BFcn
 /RZqmOf7s7Qg=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

The GSO KUnit test only checks layouts skb_segment() can segment.  Add
two it has to refuse with -EINVAL: the non-uniform frag_list with SG
on, which used to hit the BUG_ON(i >= nfrags) the existing test steps
around, and a frag_list member that has its own frag_list.

Both warn on CONFIG_DEBUG_NET kernels, so run them with the warning
backtrace suppressed.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/net_test.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/net/core/net_test.c b/net/core/net_test.c
index bc2ef7612e7d..12a175268a01 100644
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
@@ -283,6 +310,15 @@ static void gso_test_func(struct kunit *test)
 
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
@@ -296,6 +332,18 @@ static void gso_test_func(struct kunit *test)
 		features &= ~NETIF_F_SG;
 
 	SKB_GSO_CB(skb)->max_segs = tcase->max_segs;
+
+	if (tcase->err) {
+		/* the suppression block doesn't run if it can't be set up */
+		segs = NULL;
+		kunit_warning_suppress(test)
+			segs = skb_segment(skb, features);
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

