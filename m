Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590449;
	b=UjflM8wxqLpqal9+s033LpPmnzbjqkAjJN0WkmLWuMT8CLy0bpSA/ddcF2+PqFqcR6Ie
	 i8iOXYF7BV9bEvRMAJ/iVTSWjqnLt7JQdhKMjH3wpgrMJLekfpMklRaZU4uOh+qZ3ldus
	 QcIbvAX6vzREvnaijB1yei3pEL5eL5CEIQ64ooE+SYu1QKmHMb3FFlCfeurjvZBIJSpRl
	 915aKv2Opz9SIPFSGFZWuc+ZB9ed1dTUODFxS1IqrQAI6mj+ojQCZUVTB+SwJhLmOtv0j
	 7wil96WFghaidg7KWsj0pWY0Ppq35IWkPUFX4thoV5mYwkuIvBwsAcY+jTeCXwHzpIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590449;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=2KWwlh/hCg0SMpmIsRqC2+1Lcm/oFCtvXzTkdFFgQUQ=;
	b=5mgOCSJpZDjToTPCwqcfhEOrT6ONZqDUDtzIOng9i/3m18F0gp/nu6YNXoZkVkoiVMa7
	 3RwXRsf07izDtK7VfE03qJwHY9PUNBoCXRibfc5ZXwSik8yXTyfQ989Ob7IeRlniPSuOv
	 D14O53c3vAw3+Htm2MxYRlnOzOID1CtVyG7ZilGIiB7cG+ziWQP0U1tftfI+MMkviwW0O
	 eXK3R4rBdmZJvFpQxsFLrIc5qwRssyWqj9/iiI9oGGze39OU06hg1SEMHXa7UmpaMcXdi
	 hrA1/Tsk1pZAkU/IB+3E8qS6mGczFp5j19MWj6191WAhaRsDDgE6eEqYYqWGJD4HIVg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=df7ZSllV;
	arc=none smtp.remote-ip=209.85.128.180
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD6F606A331
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 13:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CD6F606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=df7ZSllV
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-8acda240937so6380517b3.3
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 06:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792590448; x=1793195248; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2KWwlh/hCg0SMpmIsRqC2+1Lcm/oFCtvXzTkdFFgQUQ=;
        b=df7ZSllVKPKZ4+IbzN3K1Yl8iDazfV/u465IbjTbJK5/FGyBp9SJCVzP9v/lP777Ud
         JNO7agazSazWiC3aVWUdGIjqRVm/cFU5keeOIYkLcGa0qdGICgT05heuQMsnNdEoQLbO
         2k0YXH+kz5w/tq93a3m8OxuLxYb26HTJu0N+wmqgs9sAMbQdA4M1SkOosGo76vOxxr8C
         MlsWfUfj6LZb2sNW3yEI7Q2jTdxV6I1R1GSL1Fdk23fRyFdKEdimDbsumVBWAcDd4eo8
         c/lSCoaDfwsfCUMJT1su0PwSbo/3h3SWwsiUvquEakVHLEkaKpwj1wxXMlZBXu8ywp7R
         vXEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792590448; x=1793195248;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2KWwlh/hCg0SMpmIsRqC2+1Lcm/oFCtvXzTkdFFgQUQ=;
        b=W/HNyWITDHhnGNCcgz49UaYOZV0sRf2+7pg0Y6UqZWoNqozN8RvaTl+dFrCifr4vQ2
         tnNkjyNp42RlxUBCv8FuOA5UIj2nNfjcKupybGEpv66vXe7udMvOW5CotCGF2z96PQvU
         PJr0QDfJudxVwPXndB+C64rc/4TZq51pxw+FB393UBR1VeCC/c33izWue8a0r88tUJ1O
         QtjCTxxxmObw7rUmFo02fnJLtsmAuX4iTCcZBPPkluLakALjzDf9UE/ZF8COT6QEewk7
         WxgN/wlsbARzL5xJJ2xL9xyM3MudDRmDZHuL670DPBF3UvYLxk3tdSFPosm42pvclGpI
         FXEQ==
X-Forwarded-Encrypted: i=1; AKwUvBzYKiikjMx9vHt1J2/zEv6wVqwtz7QstU2ZII98+vE+BxskBNUWNTysH5d5Cff2aiAPNNaEfM4=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6jp+XSdAWwqXm07vhsxO9isrNOP0G2LgoKKu1rW6yB7YWUurU
	P1N+DXCZEmD5A6g4d6CRugB63F+COwjg6f6Jc4VNE2o0rzui5fHjRIGBSx1Bad18jDs=
X-Gm-Gg: AYBFou0EpC51MsPfVvl0PWggmvzsoJ5np8m97iFXuz3FVX5A12I9zXmWh6Xu3k+EnCx
	2lz1XmO7nkKOsA/C8QhUj4DIgNYp02B/UfUp4J/B4X03qiQcdn71pEK//2Jl1hR6jqv9CtZ7U1i
	6Ow2vueeJSJxabH7mZwNf7UYOVH75w2MR8vxpfbs3IArv+koyqOhAg/5Ci56mVx+q0L1GjPBfJD
	9cTKAOcCLUFsloaBwL+8LiZwwgoX2nFl6UD8FOxTt2ieg8TRAU5Fz/eDcv0YfpjtnKBGjfQqLR/
	aeYQh+rw0qKWu9FZOAfYtajfR6aK1Z2GMiQ7Oy9oGSss6ylVe7uIE6Es7P9KZ4UQHPNjkyg6UBp
	XUcEVvyToBCkFgaBvNJ2h2AGL8DG44pTLCbJUrqFn8037+ojxDQE6hABRRwzhxLmmjh7ziapl7M
	Aor9uSz8du0QNRPI3T9j1omT2VHHUWaL2o3WEFHTP6rzlTZfIB9o4P5dWcn9f5H3GrUV812jxO2
	U9YE5lfmunzLGuGNr4V2Yv5WdjGFF0wf5+nOneG/1XoOTirpTH47f61IzcYXNpaBfjAIFOH
X-Received: by 2002:a05:690c:d87:b0:873:5bd1:98b7 with SMTP id 00721157ae682-8b13403e9b6mr12177067b3.41.1792590448219;
        Wed, 21 Oct 2026 06:47:28 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.246])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b1300715cfsm11333607b3.14.2026.10.21.06.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:47:27 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 21 Oct 2026 13:46:55 +0000
Subject: [PATCH net-next v2 11/15] net: skbuff: refuse to segment a nested
 frag_list
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
Message-Id: <20261021-b4-skbuff-bug-on-followups-v2-11-2aa780a03524@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1792590423; l=2884;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=bYC4uz0w4NZKAYryGVW9UUHYf9kR1dL3ZNzRUgIMFMM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QB/boFORXWtYqGQkg0oKg7TLwyvigi4nOkir+rQFpE7KoN+Aub774BEuZtAZae7bNyllztx+HmX
 8eAIEPekArQE=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

skb_segment() walks head_skb's frag_list, but for each member it only
looks at the linear part and frags[], never at the member's own
frag_list.  head_skb->len still counts those bytes, so with a nested
frag_list the walk runs out of members while it still owes data, sets
list_skb to NULL, and dereferences it on a later pass, before any of
the layout checks get a chance to catch it.  When the member is taken
whole with skb_clone(), the pskb_trim() that follows also drops its
nested data.

Nothing in the tree is known to build such an skb; GRO flushes instead
of chaining an skb that already has a frag_list.  Check each member as
the walk takes it, in the GSO_BY_FRAGS, clone and frag paths, and fail
the segmentation with -EINVAL if there's no member left or it has its
own frag_list, with a DEBUG_NET_WARN_ON_ONCE() for debug kernels, like
the other frag_list layout checks.  Without SG the payload is copied
with helpers that do recurse into nested frag_lists, so that path is
left alone.

Suggested-by: Willem de Bruijn <willemb@google.com>
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 56cec58bccb7..c5e28a52114b 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5087,6 +5087,15 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		int size;
 
 		if (unlikely(gso_by_frags)) {
+			/* The walk only goes one level deep: running out of
+			 * members, or finding one with its own frag_list, means
+			 * a nested frag_list that head_skb->len counts.
+			 */
+			if (unlikely(!list_skb || skb_has_frag_list(list_skb))) {
+				DEBUG_NET_WARN_ON_ONCE(1);
+				err = -EINVAL;
+				goto err;
+			}
 			len = list_skb->len;
 		} else {
 			len = head_skb->len - offset;
@@ -5096,9 +5105,11 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 
 		hsize = skb_headlen(head_skb) - offset;
 
-		if (hsize <= 0 && i >= nfrags && skb_headlen(list_skb) &&
+		if (hsize <= 0 && i >= nfrags && list_skb &&
+		    skb_headlen(list_skb) &&
 		    (skb_headlen(list_skb) == len || sg)) {
-			if (unlikely(skb_headlen(list_skb) > len)) {
+			if (unlikely(skb_headlen(list_skb) > len ||
+				     skb_has_frag_list(list_skb))) {
 				DEBUG_NET_WARN_ON_ONCE(1);
 				err = -EINVAL;
 				goto err;
@@ -5216,6 +5227,13 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 
 		while (pos < offset + len) {
 			if (i >= nfrags) {
+				if (unlikely(!list_skb ||
+					     skb_has_frag_list(list_skb))) {
+					DEBUG_NET_WARN_ON_ONCE(1);
+					err = -EINVAL;
+					goto err;
+				}
+
 				if (skb_orphan_frags(list_skb, GFP_ATOMIC) ||
 				    skb_zerocopy_clone(nskb, list_skb,
 						       GFP_ATOMIC))

-- 
2.55.0

