Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671F73F076E
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 17:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791394597; cv=none; b=VTvS35cdN7g3KOpsZUcxGF1AtYb2BAiSM5/jw5Bz9a09BOQxZPdJnwEArrXKj8I1JvQxpM/AtypjtWeSSJOE1/9F9CLGgPvu02OCMBNitishkzfyhWHjYDC+vLU0f7RwlXQURqra79OZi6/jXWwAR4YIrO9qntvldn+6WRagE7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791394597; c=relaxed/simple;
	bh=cOHqmVUhQvoYFpyRXKtzKiBJLjArGS2XQUGFfv+fWvk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WNuCPoD6INKi6m6m57h+d//Et5J9rGTF5AFT1CGY7nFIvlUgkFPFps67TZspwQh67HkRnDGfuc2w53FnP9LvvUPBiN0QnlDEUZwycCiipzPyDClepC9xmNK2KPaNoQFHKufNzIV1KPaSuoYpEIXi67ogNuAJ/jVC6xLtIy9rn+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=YF9MdMYj; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="YF9MdMYj"
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-917a707f37eso22249256d6.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 10:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791394591; x=1791999391; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/VlqFGo0rooEVFXp50d0ZL1DlxYf9r8iYztQPM4wKJk=;
        b=YF9MdMYjpLm3iKfZm6d0lgdj2UmhSpx0CS6j+VW++75LfcaJ6CUr/nO7G4kalUFd4F
         xFVD1vqSMbiqFNNyPnaqGi8J/2NFk5L6OqCxKFnymPiacyEkTI0vbC7PEB7hRscpewME
         hqhgjSpSQQBCM2r1RSe7sZQJFZkd8JkruyCAuik7RjOPglzbWerAJQhqJFwd5qXOeMQP
         PPJdOUKs7H2mwTFoPvCNM3s5LSB/1M8uNJRxDJLlVMxNg9PkmIKOHX9PIe7CO4NnvRi6
         stiY6YDYPj3rFrTxQKADl5B+sszWr71p6H/Lws1vn4OT9y1h609JBy7csQAe4I346k/X
         a16A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791394591; x=1791999391;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/VlqFGo0rooEVFXp50d0ZL1DlxYf9r8iYztQPM4wKJk=;
        b=UgU6liFvOexNMuEHxAcActUmeTTzZca5OGG0IJ3ZAKhxdKJP6wLhKS3HiEmNjKH1Vq
         qqmjnzF2ugLkEFMGr2t7j9p+p9wqRYuVnd31N0K7X38s+66RulCNm6CDu+SvRnskpuZB
         JFxkr0au0NvQtUEMFPFzKg7NLWV2okXfKCQKnf+90L9+srPYGDJKvXUybBMT70HiQZwy
         H1hovkCH3nqi1QsgqvrzurbO+UthCceTAiVNZmFeb1VuL7EMVfsW4cnTS7kbnGsVujBU
         RgEWg9+lXl0W2oIZ5M2V+PnYzZWtD1QEB82zPslx3mlPfaJV+ivx1kdnRGI2uYmYMF/X
         +mCw==
X-Gm-Message-State: AFq9FYIF8hmltFqafj5ycwZZVkF64xn0cqA4oCuoZFO3a5Tb80gyHobd
	T46j3zyav8l24o4Khka+PoTsR8CsQcjBSb68a1nLOztOtVoq7V1BFFo0P2hVsmqoqho=
X-Gm-Gg: AYBFou0LhEnj/c2Ej837/6ddUcq25GhsPajMyEKDAZx3d0MrPuD9lykj+7YbVJi5bWt
	Hnuy+zbGa9ytS5i3ThNrpF23qxw9v5zOZuffBCcdU73lcNqUBRMVcdNyxWcK9DTE5aBAaFFfzpA
	i7RMV4OOvj2ckyABSi8EGy/Ket1VpmqKO/jkXDyxh+Sukl5E4jOkUvMY8g5+BhB2MPG4dw7WUU/
	88rbga//AdSm85hUyIlDeL3CNFwrjvZhQIEYweFv1gzWPscwJ83Pv3zwB021XjHKGjpwIISIDbr
	vEceZ0U83nxLSmzWyptrfHX6igVF0SaM93boRzZ6JVpw9nI3F4VWahw9TjoBtAIyNP35OkChnp2
	XM6XjP7ekyhzeHZgwH9yli5rvvbq+H2VOQ6bQNDCPu/b1luzmrMxjuxi6pz4LNCbe/xh+xACJrh
	GOj/F14NJ3xt509e8OVqTat7FDRE/ys9vRKnXqIjCU7RUC10nJqd2TNoxTCmsk3QzAvbxJmvcFA
	ZJ9v30sL6+z0zo=
X-Received: by 2002:a05:6214:27ef:b0:914:4511:9271 with SMTP id 6a1803df08f44-91997829f28mr49446246d6.22.1791394590326;
        Wed, 07 Oct 2026 10:36:30 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91996cb6108sm25287516d6.13.2026.10.07.10.36.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 10:36:29 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 07 Oct 2026 17:36:07 +0000
Subject: [PATCH net-next v2 8/8] net: skbuff: remove the BUG_ON()s from
 skb_shift()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-b4-skbuff-bug-on-v2-8-b9a5f732895b@toxicpanda.com>
References: <20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com>
In-Reply-To: <20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791394570; l=2315;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=cOHqmVUhQvoYFpyRXKtzKiBJLjArGS2XQUGFfv+fWvk=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QKvo7jLUt/Uh4c6yB2BExknoMr7WR6kKP9E8FPiHlgT7ctnX82eh4pVdQ+xX9F2Xqv/Or77tWZE
 BYH+maOhZ+gY=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

skb_shift() has two BUG_ON()s.  The first fires if the caller asks to
shift more than @skb holds.  Nothing has been touched yet, and returning
0 already means "shifted nothing", which the TCP callers handle by
falling back.  Return 0, with a DEBUG_NET_WARN_ON_ONCE() for debug
kernels.

The second fires if the frags run out before @shiftlen does, but it
only checks after the shift has been committed to both skbs, when
there's nothing left to back out to.  The loop that builds the new frag
layout only writes @tgt's frag slots past its nr_frags, and the one
branch that modifies @skb's frags also finishes the shift.  So if the
loop ends with bytes still left to shift, nothing visible has changed
yet.  That's the same state the MAX_SKB_FRAGS bail-out inside the loop
returns 0 from.  Move the check up to just before the commit and
return 0 there the same way.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 629de22d98e4..7d23c2d10550 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4331,7 +4331,10 @@ int skb_shift(struct sk_buff *tgt, struct sk_buff *skb, int shiftlen)
 	int from, to, merge, todo;
 	skb_frag_t *fragfrom, *fragto;
 
-	BUG_ON(shiftlen > skb->len);
+	if (unlikely(shiftlen > skb->len)) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return 0;
+	}
 
 	if (skb_headlen(skb))
 		return 0;
@@ -4411,6 +4414,14 @@ int skb_shift(struct sk_buff *tgt, struct sk_buff *skb, int shiftlen)
 		}
 	}
 
+	/* The frags ran out before shiftlen did.  Nothing has been committed
+	 * yet, so back out.
+	 */
+	if (unlikely(todo > 0)) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return 0;
+	}
+
 	/* Ready to "commit" this state change to tgt */
 	skb_shinfo(tgt)->nr_frags = to;
 
@@ -4428,8 +4439,6 @@ int skb_shift(struct sk_buff *tgt, struct sk_buff *skb, int shiftlen)
 		skb_shinfo(skb)->frags[to++] = skb_shinfo(skb)->frags[from++];
 	skb_shinfo(skb)->nr_frags = to;
 
-	BUG_ON(todo > 0 && !skb_shinfo(skb)->nr_frags);
-
 onlymerged:
 	/* Most likely the tgt won't ever need its checksum anymore, skb on
 	 * the other hand might need it if it needs to be resent

-- 
2.55.0

