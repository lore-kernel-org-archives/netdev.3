Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55B048F008
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 14:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791815986; cv=pass; b=FOCgEGK1XpLxeH9W3zkN7EnhKj/vkcX1CupOkMpTzT8Ut76oEg08fI6mdBIiLab+eQG8BbDafUZpUSdtZY9p8WJ8Aw9dGvvvhMECS1BD9Epyap5RUUWypgTZmnQKhZQiKCeTFdW6d3KxmElsGKVVTTfxmhmLhv7DG0KbERtxk+Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791815986; c=relaxed/simple;
	bh=nngk+BZ+vTXefE0Yqob9PVP82o7UfLMNfOhRUEtBGw4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=fQWQYstRfqx1PoR/IA+z1vQkNNZstCvzOcyzXm4t+96yPT+BZ9Vqy8jSHnJ3W3a1EulTiIadDYDfOh76/WKCsPX/seK8UvhCgZpcbY6HVcqa96C+y2mo9+4U4dcRThu6f0sKVG0xqYCrE+CPHy5hxqmEPIscrxehxFTrnJvIY58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O50DKfK7; arc=pass smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O50DKfK7"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-504db7f7870so1539099b6e.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 07:39:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791815984; cv=none;
        d=google.com; s=arc-20260327;
        b=I5wAs7VVogb2lxgQjJGDivMFdB/mT4sCvOo6nZ3IEEuXtiS2r3/e+u9ieCW/KVNQfP
         d2/yEnddrDLl6dz0iKnC67dP3Gyy5ggaf/9oE1yp3F+3tqCDKDIIhR/dwG9cciexrajP
         9dfu4fs86dqPAjKTdploRs5u/uu/jGZewPSXBd+gIYUal3iF6qvmEehbCtDOrjtxDTLM
         kQ7mkh1+gInI4b4WkhDXatSDcoCr4Fy8Dc/XXYMBWxndJVeHUyW3DegnGUHC3ZKpZ4V0
         WN6o0MSKldlsfTIRXfHpb3YXMgeAFETjVOu9ZbaE6g2QwEZvqhj+LwmxJcuQedWPguC6
         OZkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=N9NrF4HR6dSGtkml8i5MPBuV3FD1qad4rvyy3srm/AU=;
        fh=aDUZZ9N6NPmO6DMPx8G1ADwl9DVnQFUvUJ2oivftvxg=;
        b=r4WP2jrdInRDuKCyISq/K2unyMufhK3RzWjqQQ1g+q6jHN5wuGdAoSnrg5oNOJSbBs
         LktNDkdzG+q4tYFvY8jAGjCyoGHNhU/NYl9kdfY2w59Hn2NZ+pkFabQ4qjkvHR7uAnF7
         UCing0oeGbi97I8nAmx2YZ2ADTzx1XS9o2Fd3sBUzyvjDT3Tic8vqPC8uDWy8XPuQ/J6
         Z6yQepZvf2QZHFtTpga4c+Jf4MxFgMY3ucZg+erPO72TDOApGENjhuwMhifbe3oKL731
         gSPDDWg8qu13Yl86fPcB7mOX+M9pFldtkDlLqAm4+9WY1u28uNx6hWGfF0eKGL8aZEeJ
         qOkg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791815984; x=1792420784; darn=vger.kernel.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=N9NrF4HR6dSGtkml8i5MPBuV3FD1qad4rvyy3srm/AU=;
        b=O50DKfK7uuHFgCLWYL3lAReRK4VwkNE7eZL7o0je/nb14eYRZL9v+Owl/jc0N/qgFM
         dAHb94aUkwqOVNqQFfJkSrX/6tpQnSFI+7Fb7YpGRzYfG7BiBMp/qqh5oqI5XoLpTJu8
         fHwhHAMMddDz1wY7CazhebDR9aIhsJfjPmcwWucq5iFOUJePyv6tnrkSAqXGXbKeq90y
         0HJCH7lGOyqoAxWUV4Ptm/ZJlbTacZRN7Vt/fnuRl+9f3ekIhLKuR8jPM3TC0PzpFkaG
         8OawPCgkfixVVVmiZJW6Xv15ySnMbBvLJisgD3UxQQuth8IALedZCFGwUCHnQrUE4q5+
         a0jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791815984; x=1792420784;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N9NrF4HR6dSGtkml8i5MPBuV3FD1qad4rvyy3srm/AU=;
        b=UcKmF/L0j76rpBgwHSUsc97aT40hsFsliV47ekBTq8rWCzfFb864B9rquwgA8YvE0J
         XYm+LXxePAAIeEEugAypiWhNZeAi7bZa5BS7dW5dzrSEzdLlh8KdZFmWu820aCxHBWqe
         xVtT/N1Tpum2UfWdGaovka4phor35XdpxlF/qkVqeHFJWFIYb+0F9vZKThdDjP2PIJNw
         ilBPJmpdlkLTvnyNeiH5oE/0oJXow+gfLQfbsFjSqr0Fu7pG3jXmoPDlc9aAw4hRtONy
         AsvyVokhwkNFNGjNhkBsnBccRU2Aewsn2Ih2r9Zw3mke+a1cyT676VLOHNrls1JAO53t
         bxnw==
X-Gm-Message-State: AFq9FYJJ0NoRnexsglaK8zqsSfAn17dmkQrF1ua3qOO93TJFcLIMFe4A
	JAdqgrAqjuxEqpJ4AaJwLgrhipZE9Gt64YQnjHlfIDxWNnec47qlVOUj//TCxtSG92VLji8cBQU
	LI3+ILWdrvGCQiNZXsroPdCKzUzGNJdXXswdmKXBFjdFu
X-Gm-Gg: AYBFou1gAz1qwFYY6Ir7uyrFK+nzfeOT+HkwFYDiLSsNqxkitl6Z7OhroY9QYmerhhe
	J5JDJpLQfwM5E+56LSN18yMWJjyzLCYnygSZxiFC8kPDS06ugvEKVU5UXY+rMGXnuXJO/eYKkGB
	jq0lv4YU7aMkT4pxHna6zvieb8C9Sik/fctn2N5xyHdAE34pTr4uhqMVzulVBp2pLY9xqW3jC/X
	kZhNhyejhhyNwI55oqDO+d2jy19f/h+MopCyPwWaYOh3WwnVg9nS2nrzKF/nNX3JbKs+ngpP6Ql
	TLoQBZSUVOrUZv/zJfmg6M9cWprJzGE2pUcilZmTvu9Bt1h//1Bjq4dVQQ8eyKFthhVqzO8e5HY
	r0vsVGlvv769mK/MuXvDfvlnTvbaAV6/gE0fOZjGJ8I0+OCzgU5+A4AUY
X-Received: by 2002:a05:6808:23c9:b0:4f9:a153:8730 with SMTP id
 5614622812f47-50c33641592mr11310848b6e.0.1791815983753; Mon, 12 Oct 2026
 07:39:43 -0700 (PDT)
Received: from 138594053405 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Oct 2026 10:39:42 -0400
Received: from 138594053405 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Oct 2026 10:39:42 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Adrian Martinez Garcia <adrimg3196@gmail.com>
Date: Mon, 12 Oct 2026 10:39:42 -0400
X-Gm-Features: AclHuK_Hldl3JgTTeifVbBwgCOjth8ddyfiNZlOzqZh4HTxOamWQs2kzpdRKnzo
Message-ID: <CACO1+RQUrGS3VN-hrdKk+BK2uuRP7J_Fyadahz1QpO00JXyw3A@mail.gmail.com>
Subject: [PATCH v2] xfrm: account XFRMA_IF_ID and XFRMA_OFFLOAD_DEV in
 acquire/polexpire/expire size calculations
To: netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From 534cb2b5fb8da81677f2955aac8a98d9aa89694b Mon Sep 17 00:00:00 2001
From: Adrian Martinez <adrimg3196@gmail.com>
Date: Sun, 11 Oct 2026 06:53:31 +0000
Subject: [PATCH] xfrm: account XFRMA_IF_ID and XFRMA_OFFLOAD_DEV in
 acquire/polexpire/expire size calculations

xfrm_send_acquire() and xfrm_exp_policy_notify() allocate their reply skb
with xfrm_acquire_msgsize() and xfrm_polexpire_msgsize(), then build_acquire()
and build_polexpire() append attributes including XFRMA_IF_ID (when the
policy if_id is set) and XFRMA_OFFLOAD_DEV (when the policy is bound to an
xfrm offload device).  Neither size helper reserves space for these two
conditionally emitted attributes, so for policies carrying if_id, mark,
pcpu and/or an offload device the builders can run out of skb tailroom,
fail with -EMSGSIZE and hit BUG_ON(err < 0), turning a netlink event into
a kernel panic.

build_expire() has the same XFRMA_IF_ID undercount in xfrm_expire_msgsize();
its caller already handles -EMSGSIZE gracefully, so the only effect there
is a dropped EXPIRE notification.

This is the same bug class as CVE-2026-43107, whose fix (7081d46d32)
only covered the aevent pair.

Account XFRMA_IF_ID and XFRMA_OFFLOAD_DEV in the three size calculations
unconditionally, and replace the two BUG_ONs with normal error unwinding,
mirroring the aevent fix.

Fixes: 7e6526404ade ("xfrm: Add a new lookup key to match xfrm interfaces.")
Signed-off-by: Adrian Martinez <adrimg3196@gmail.com>
---
 net/xfrm/xfrm_user.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_user.c b/net/xfrm/xfrm_user.c
index a2587c7e..5eb79b0b 100644
--- a/net/xfrm/xfrm_user.c
+++ b/net/xfrm/xfrm_user.c
@@ -3927,7 +3927,8 @@ static inline unsigned int xfrm_expire_msgsize(void)
 	return NLMSG_ALIGN(sizeof(struct xfrm_user_expire)) +
 	       nla_total_size(sizeof(struct xfrm_mark)) +
 	       nla_total_size(sizeof_field(struct xfrm_state, dir)) +
-	       nla_total_size(4); /* XFRMA_SA_PCPU */
+	       nla_total_size(4) + /* XFRMA_SA_PCPU */
+	       nla_total_size(4); /* XFRMA_IF_ID */
 }

 static int build_expire(struct sk_buff *skb, struct xfrm_state *x,
const struct km_event *c)
@@ -4177,6 +4178,8 @@ static inline unsigned int
xfrm_acquire_msgsize(struct xfrm_state *x,
 	       + nla_total_size(sizeof(struct xfrm_mark))
 	       + nla_total_size(xfrm_user_sec_ctx_size(x->security))
 	       + nla_total_size(4) /* XFRMA_SA_PCPU */
+	       + nla_total_size(sizeof(xp->if_id)) /* XFRMA_IF_ID */
+	       + nla_total_size(sizeof(struct xfrm_user_offload)) /*
XFRMA_OFFLOAD_DEV */
 	       + userpolicy_type_attrsize();
 }

@@ -4236,7 +4239,10 @@ static int xfrm_send_acquire(struct xfrm_state
*x, struct xfrm_tmpl *xt,
 		return -ENOMEM;

 	err = build_acquire(skb, x, xt, xp);
-	BUG_ON(err < 0);
+	if (err < 0) {
+		kfree_skb(skb);
+		return err;
+	}

 	return xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_ACQUIRE);
 }
@@ -4307,6 +4313,8 @@ static inline unsigned int
xfrm_polexpire_msgsize(struct xfrm_policy *xp)
 	       + nla_total_size(sizeof(struct xfrm_user_tmpl) * xp->xfrm_nr)
 	       + nla_total_size(xfrm_user_sec_ctx_size(xp->security))
 	       + nla_total_size(sizeof(struct xfrm_mark))
+	       + nla_total_size(sizeof(xp->if_id)) /* XFRMA_IF_ID */
+	       + nla_total_size(sizeof(struct xfrm_user_offload)) /*
XFRMA_OFFLOAD_DEV */
 	       + userpolicy_type_attrsize();
 }

@@ -4358,7 +4366,10 @@ static int xfrm_exp_policy_notify(struct
xfrm_policy *xp, int dir, const struct
 		return -ENOMEM;

 	err = build_polexpire(skb, xp, dir, c);
-	BUG_ON(err < 0);
+	if (err < 0) {
+		kfree_skb(skb);
+		return err;
+	}

 	return xfrm_nlmsg_multicast(net, skb, 0, XFRMNLGRP_EXPIRE);
 }
-- 
2.43.0
