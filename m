Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C99164EA38C
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 13:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792417887; cv=none; b=LZJjfyjqSVl2+wvUuV3r3WpXnJjz2v4lITNN4tuEMc5jeY3b7nrjCTDY2ZhxYLTO7poNAOF53stqiGuwN9Hk1APKIpxg9DylrbmB9TlPjZmUh5LdTDEZWpQlNXM0ysZmAkCVq8KqezIvdX5wdFk1Kzg0E4jyYwf1xATnGnd/nl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792417887; c=relaxed/simple;
	bh=GLGsUKpELPU6q+dQsnPVRh/KHoYno5QlglXwcqwsDWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kDHwEw88iwSGwEqj7heixnG7kq3WR5vE0vq5459v+kkGKZGXMQpaxN0mBmuNFT/ZH6G0lXS0VaZmk7neGa7wo9oA/3fHWp72LkD7DLDA/KGZLE9Jf+QVOs5U5YOr2+59BmoRkQ07c6nl+qpUlz256ebzvJ3S6RXIZLmfBxzO93U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=ZGs49jgm; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="ZGs49jgm"
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91b63bd2030so16671156d6.3
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 06:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792417884; x=1793022684; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8wxt1Epm3k3rT9QE881oEaKsrBbXJoueUEmgjTPk70U=;
        b=ZGs49jgm5Qbxt+M1AB7DkHd+iybjtw8Zz9YyGxeesQTX1w2b1OefQRkShT8Oh/vziW
         MQNCAR7B2+pFGnilnPvILlCYQukDRGBZXU8/GW8tDFPOXIJbwitlo/y1GZRmQvHpZsXW
         LWJqsNFI+HYWbaNBiQKmX4gqy1LjI+bRlUSSROwoA/h3cy0nOIWYNMWNu5Huq72nBEmX
         DGW4H3Oz6sLkjpxuqtcemLQaSVDCjAIpxpgA+dXO3SNK3DEhbBy6lyjMpDaWRszBH0Bd
         /TgadkuPOH3ICo86dARU2grxE6Iz63TpvJewITZPsC7BOtMv/TytAacitA9UKbIiO5ze
         wSGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792417884; x=1793022684;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8wxt1Epm3k3rT9QE881oEaKsrBbXJoueUEmgjTPk70U=;
        b=vW6zYnqinQgB74dOslHYc9ZGAojFbX2oY5poMA4xA5ZrWr+ZAAI21NvVbhRtS0GjyB
         rq341XWeE7gwlaxC8zuLIsTIdHs1Ofkye/RtoxSdpra78byhMI9HA2noh3mMKTcRzibx
         3AqLakNhWPw/8+rkNAEqZFnZCp3BvxJV3KKeEdKpjbrkCJlVzWwNVyCAnjGzAPKS5F1o
         D3VssqTXPgfDEMppTCxDqd771Qffc3cvS5M81QxGXIP7rTzKHHG96weJgx5f3bmcL0hs
         rzGl7ScQhz5j/2sFwsMDShz1ektOAhVunRg4YBEGunuTtIaLIyBJKwYC8WbDsrjUNPbZ
         52Tw==
X-Forwarded-Encrypted: i=1; AKwUvBzP/utllhpqY4SK52HPsDTMqyhS8ABCVLiguOYbKUCYQhrBchmtYp6LulEOw28UJhzVOR7G94I=@vger.kernel.org
X-Gm-Message-State: AFq9FYJKrhPCmyH3GZDI9eXlK9aiFFRmlSdfD1fnmvZ7wc7IycZdifI1
	rwPG+WnTldpO/9fpgM9gvt0UmR4kG1GhnQARcHfIRr30QLYTXeaT+Stz610TQL/wRb8=
X-Gm-Gg: AYBFou0fD+hY57LNBu18bVZmSIFGvXXIqltKzWB8XN0lSRlytBVfxTUq8RWOr0gWE5r
	ew+1h4OS0cmHytDC+EXhFIn3I+fXBvfpOjZONO8YXM1SiY7i80BB2J5XdU1ZsfWNT5rqk8McSxc
	WAN1CCb2wyV01ntyhpZgpqEYtpBtTFD3pUlFEEnB+RmX5T+RRnE7diz5nfR7MBaRByCM3weI2Yj
	Q87ppqs59R4H5uQhPev1bAEek41W9q8hHTJTnmJ7t9LQc/eHiW9kCPrX9O7OlJJSAReGFObo4Cx
	1n8jVFE1A0Mu0OEa2zO9V4s+GNfHqw80x0DW5kAi9EMtcGgOYfOl6j8oHdZNwuk1fOP0u0I2iY/
	dXm+nDy6livy1UQ2nV2YDL0PCZb8LN3Xbu5s/M8oinKl25s7Rd7ZDNbSZBbNAWNzYvGFm0FDaHL
	0pf4fxisMYaTY5xR1YAIH5oGGvqDmbwpRUNQEwPno6gg0PWLM3+t2F60Q/+Hf/HHNOSSs9ebUx1
	hWAjzbqcAKkjSY=
X-Received: by 2002:a05:6214:2022:b0:917:a5f1:1d45 with SMTP id 6a1803df08f44-91bdf165a4amr140313536d6.32.1792417884537;
        Mon, 19 Oct 2026 06:51:24 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.247])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91be8f89b54sm60221436d6.7.2026.10.19.06.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 06:51:23 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Mon, 19 Oct 2026 13:50:42 +0000
Subject: [PATCH net-next 08/15] net: skbuff: make skb_try_coalesce()'s len
 unsigned
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261019-b4-skbuff-bug-on-followups-v1-8-41dbef50b9f7@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1792417849; l=2184;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=GLGsUKpELPU6q+dQsnPVRh/KHoYno5QlglXwcqwsDWs=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNC9Sgvy7Z40iKvcRhA58lXebwfW6QGNAPE2IPZxOaOYraxtzaaXcB+Os+4BjcCqUxdgTwJlErN
 lVW88RefeTAY=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

skb_try_coalesce() keeps from->len, which is unsigned, in an int.  A
corrupt from->len above INT_MAX turns negative and gets past the
len <= skb_tailroom(to) check.  Commit 279877d86c82 ("net: skbuff:
don't BUG() when skb_copy_bits() fails in copy helpers") moved the copy
into the tailroom ahead of skb_put(), so that check is now the only
thing left in the way: skb_copy_bits() clamps its copy to the negative
length, and memcpy() takes it as an unsigned int, so it becomes a ~2GB
write past the end of @to.  Before that commit skb_put() ran first,
and its overflow check caught such a length before anything was
copied.

Keep len unsigned, like from->len.  skb_tailroom() is never negative,
so the tailroom check then refuses such a length, and every other use
of len already takes an unsigned value.  The truesize sanity check
compares the int delta against len; spell out its delta < 0 case so a
negative delta still warns now that the comparison is unsigned.

Found by the Sashiko AI review of v2 of the series that made the
change.

Fixes: 279877d86c82 ("net: skbuff: don't BUG() when skb_copy_bits() fails in copy helpers")
Link: https://lore.kernel.org/all/20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com/
Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 735dd25213bb..5c89c463f234 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6392,7 +6392,8 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 		      bool *fragstolen, int *delta_truesize)
 {
 	struct skb_shared_info *to_shinfo, *from_shinfo;
-	int i, delta, len = from->len;
+	unsigned int len = from->len;
+	int i, delta;
 
 	*fragstolen = false;
 
@@ -6463,7 +6464,7 @@ bool skb_try_coalesce(struct sk_buff *to, struct sk_buff *from,
 		delta = from->truesize - SKB_TRUESIZE(skb_end_offset(from));
 	}
 
-	WARN_ON_ONCE(delta < len);
+	WARN_ON_ONCE(delta < 0 || delta < len);
 
 	memcpy(to_shinfo->frags + to_shinfo->nr_frags,
 	       from_shinfo->frags,

-- 
2.55.0

