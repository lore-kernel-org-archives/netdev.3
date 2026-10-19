Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE2674FD291
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 13:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417904; cv=none; b=hMLN57CJISSAPq038DvVA9bvznQWnibS9lexgnVHDBwojgnfASbfnA3A4frBjGahkjd0K/V5QyeXjJ6Q8/opoMQ3xd3tCesea9CAEW1rVK/aovsjpYwjOEihTCLAXdW51pOdqYcfPl35nnhJ1j+wUNG5Ua7Phk71Tk8n/gYzFYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417904; c=relaxed/simple;
	bh=bVkQYPRV5cmZpoQgzwHTIPv/OeC1BGK6SJq4klyY24s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R1MGmrWqHUWXbDtoloxEiz++hXEjv2oa8SaYhknIbMXMFJbS8gnHr1dY0COq6kljwdGECSKJE/NZ6cQKBkYZX/nOe/SYXnbWz6EWNiPn02nKL5u4wjvZIOOkOrEvIn6u9N/4invVpi92bkbZ9WQ69InhQomJ0eMLXdiPyIPG5wQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=GY17h3ow; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="GY17h3ow"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-91791ec1b83so18181256d6.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 06:51:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792417902; x=1793022702; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sz34K0Iw8+vtFq1WnWsYscgmIxwM3BOh5ri5FmDCCys=;
        b=GY17h3owlGEscrFzB2QXAkJ/SZ5CYhTisVpbuvhjY7Tm9c7qwV8Rh2yGrn3+lk4Q1e
         ywqhyNbDHwKGSPyFjE55O3h3IZZ9gytUUncjbbXGNyPSyf5x5OmIkShBB2jQhS/5wZUL
         uZfd6oQQ4wKgiwOTc8SQMMxgp7XX45pLcisXwcgvTE8m2ElV9HNI+oCNUZoQAnJtZjlB
         qzxJyDpvfhbaQ+oQ0YjLMTLQtBtjGtQeLsnpdk6Pr+1qiUc840K6kZTL79rZR173YE/3
         QfG33V/65etehK2xOBaqF04/yTxPdHuyv6UGSS31yCJ83W/7PgUiDrIOHLLXUj5UOPx1
         sWzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792417902; x=1793022702;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Sz34K0Iw8+vtFq1WnWsYscgmIxwM3BOh5ri5FmDCCys=;
        b=RIlR/zutYZRFFec23jSb35QEByUK1drgDhug/QUIB9DkJsFJlBUuwb8oswE4VHvcX/
         hmtP9CZC7O8g8CpDqsBvSolZdMCyJXffLeppJtcVHBCTMq9HXB9hLL2AZs7z3n9vc8Qc
         L8PWkqAePilf+AWVedXYsiGfGdmj4lwRbz6jLGXx0sot3U3hDbxCqh6s/V0aeMWCdiFu
         gP0VAc9bqX2mDcvbOcDJ3gMGecZUFLiIEG4vVwmipkrMJ0TENv1joRq9Rk1E3p67u0iJ
         5GAw/TWPxNMCtfn+KEhkj9LcE2cOG2nFErF4qVEhdvumK85pz52m3MxFm/h68ERq94l+
         eT4g==
X-Forwarded-Encrypted: i=1; AKwUvBwPIgATmQ/Vud7/OLKp09jij1ibXF2CiAtVCIZuPI+SuHJKo3sVXVgyniIq4rH6qVHr+0hRdkA=@vger.kernel.org
X-Gm-Message-State: AFq9FYL3HKOrDsCslAG0GqhZWTF7xqaWglJWvV67fvVOnnp2Np1YZXY8
	OFiE1DLkPcdstB23AwO0XOVZEl0vNz3Viz9DknihTB3tok9upGUMX+xvsCFdG5Sz0+I=
X-Gm-Gg: AYBFou2sxvMpX/kgMPfsKtaiUZ6SEiRVQBtDoS+w0xw2gqM85HoPin1d9wAB851Znrj
	WeF+ZLNocIJjxg8GBHru5Nbpx50JXXxebVY+MgohUiqsBMgZbnxkQ1T1w03HxNwbT8/f9IMl12i
	bfYDtQ93w4/28m52fPUDrR/ZJSffZllUXTesCJUHvTcjpvUrOYcIBMALkCEgdcOF3wxbFruL4V+
	OSOgzT1cN4snqqvfuFd85p873kW34wcI9+lf9gQx0RFROjzOw09r0QJQxA5rZUv78QNi1gHP2Uw
	tWlssUY94s+ifehRq7N+mdQBkAaEId4PBuKEcVbUFwzH2U+QDseHk2JsXg9T7flF6QTkPCSMZ9K
	52OfzAcSm8Eb0EUhkzHiI/BgDK5G6DTyLe4zfafVQOOg6woPh5xfuLdVrsDrJ0Ybm54cVcJAiR4
	pP4joHKcI60OYSfAJCa49+sNUd3uK9LwulDbyn+uD6YpLuDR5dIYkyAwnm18ql1Z3rE+VgjPK8+
	pvAMbjXyMCLOm0=
X-Received: by 2002:a05:6214:29e2:b0:919:aba4:22e5 with SMTP id 6a1803df08f44-91bdf0aa97dmr130453586d6.18.1792417901621;
        Mon, 19 Oct 2026 06:51:41 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.247])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91bcbb233d2sm98126806d6.32.2026.10.19.06.51.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:51:40 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 19 Oct 2026 13:50:49 +0000
Subject: [PATCH net-next 15/15] net: update comments that still describe
 the skb BUG_ON()s
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-b4-skbuff-bug-on-followups-v1-15-41dbef50b9f7@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1792417849; l=2874;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=bVkQYPRV5cmZpoQgzwHTIPv/OeC1BGK6SJq4klyY24s=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QGRgYXu9jiEH+o+P/X5XgMdqaIYdTCVgqXiXo+r1ZD/WK34+ps+wJnDs8hXR/0Hv/jB0pnLBW9g
 OlRZBGpF96AQ=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

The skbuff BUG_ON() conversions left a few comments behind:

 - bpf_skb_net_grow() says skb_segment() BUG()s on a frag_list with
   head_frag set at the downgraded MSS.  It fails the segmentation and
   the packet is dropped, which is still why the skb gets linearized.
 - The GSO KUnit test says the non-uniform frag_list case would hit
   BUG_ON(i >= nfrags) with SG.  That check now fails with -EINVAL.
 - The skb_to_sgvec() kernel-doc doesn't list the -EINVAL that
   __skb_to_sgvec() returns when @offset and @len run past the end of
   the skb.

No functional change.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/filter.c   | 6 +++---
 net/core/net_test.c | 4 ++--
 net/core/skbuff.c   | 5 +++--
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 3ee1a093337e..f5bce0dc43fe 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -3696,9 +3696,9 @@ static int bpf_skb_net_grow(struct sk_buff *skb, u32 off, u32 len_diff,
 		shinfo->gso_segs = 0;
 
 		/* Due to header growth, MSS needs to be downgraded.
-		 * There is a BUG_ON() when segmenting the frag_list with
-		 * head_frag true, so linearize the skb after downgrading
-		 * the MSS.
+		 * Segmenting a frag_list with head_frag true at the new MSS
+		 * fails and the packet gets dropped, so linearize the skb
+		 * after downgrading the MSS.
 		 */
 		if (!(flags & BPF_F_ADJ_ROOM_FIXED_GSO)) {
 			skb_decrease_gso_size(shinfo, len_diff);
diff --git a/net/core/net_test.c b/net/core/net_test.c
index 12a175268a01..d38dfeed163b 100644
--- a/net/core/net_test.c
+++ b/net/core/net_test.c
@@ -325,8 +325,8 @@ static void gso_test_func(struct kunit *test)
 	if (tcase->id == GSO_TEST_GSO_PARTIAL)
 		features |= NETIF_F_GSO_PARTIAL;
 
-	/* TODO: this should also work with SG,
-	 * rather than hit BUG_ON(i >= nfrags)
+	/* TODO: this should also work with SG, rather than fail the
+	 * i >= nfrags check in skb_segment()
 	 */
 	if (tcase->id == GSO_TEST_FRAG_LIST_NON_UNIFORM)
 		features &= ~NETIF_F_SG;
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index b6ada54ecc57..4822f96fc1c8 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5554,8 +5554,9 @@ __skb_to_sgvec(struct sk_buff *skb, struct scatterlist *sg, int offset, int len,
  *
  *	Fill the specified scatter-gather list with mappings/pointers into a
  *	region of the buffer space attached to a socket buffer. Returns either
- *	the number of scatterlist items used, or -EMSGSIZE if the contents
- *	could not fit.
+ *	the number of scatterlist items used, -EMSGSIZE if the contents
+ *	could not fit, or -EINVAL if @offset and @len run past the end of
+ *	the skb.
  */
 int skb_to_sgvec(struct sk_buff *skb, struct scatterlist *sg, int offset, int len)
 {

-- 
2.55.0

