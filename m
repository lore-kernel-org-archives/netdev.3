Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B342035201F
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 18:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787510164; cv=none; b=OWA0ffVh/WD8i6kK4Sb3RJkTuo3Q05zZGFpsr5xyXUUKyNHMeirb9mKsenWRqtQxnLNPXYyUL7+vntRYaFM13kv2uTAwpgezoSfyQejRxio0vqlcwuOU1gUP7qnas8djaCD3qi5CFf//QUarpI+FuHC6DxcPpUeSdlzlDRYKsyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787510164; c=relaxed/simple;
	bh=BhPznQ+Ob1glckQETuNATKlL3cpZxbSPU+Z5vfvw6vk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=BNAjBjND8fJ77JO2PL2IIhUpr2hdbQ+pBO6tIjqv4YJmkjjDlQ1Z2hGkwYlHXLuaCe57a4/GRgiK3LlJIA4cOBmIaBgoZJEPwGzksbUtTUZ1ulKvGfi1YZLZMXY42EX4dxnAtVeWtt4hveCHwjSvTD9AJpTLuMUhNJ3Ynn0LCAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LBdhMhx/; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--almasrymina.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LBdhMhx/"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38f97b3f853so4165536a91.3
        for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 11:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787510163; x=1788114963; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y77FEMam/I5QOXZIpVfbp3+3bLbGABxpssJ/EqST3pg=;
        b=LBdhMhx/RNAeZdnVTc/nKeO9LHDGzk4M65W0Mjaf8jrD2tz14qUM82UoncLbhcD9tC
         yoVhbY4M0V1wGXyghdWppbTPeMQER0I9gg7gr3FnB0FLAJEjKJBMonAAWBdArFVGfi43
         zAEq0C7caakZF0p+4HbR11iKR+kMY9Cd+MYUwmJp6ew3HNwinM+FhQllrGVyuxyKrAsQ
         O0IjR6Mt+DuDzje11o/GwC1zs8d7bLTyw4kID1YRKQJw5WsLW/k2BcwesKi91Qkz3Ww0
         e0Vy/wXVnj/PFVHslX3DWYk9m5jjCZ3efwFfWi4znZQNaOPNzFuHLo2AbZC0PgPQBIXq
         YyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787510163; x=1788114963;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Y77FEMam/I5QOXZIpVfbp3+3bLbGABxpssJ/EqST3pg=;
        b=EXmWlIFyhP2/jgAstZfBQ1PRaKi6DFUXv4EB56KfOcK3Mxn/q4Wg9dLExsOnZqGVqt
         /OgoF3XFKF89kPCcFV5lJX5pfIma6Fr3brlta//hVsvbz6nrjf6uNEghSorrXeReBhZC
         HomsV1gHDhUUBbvqdlSBOnNlOwekXWe/aDV8gTSJD8FaPCNhSBlIrm+ZuEypu9rq8UDM
         vUnK/Q7DWX06kOLIeAdPv2tVw66TIB73UWK1KDcomhaLZSG0yJjqJEE/nluuw91EWz4M
         dtvDFqwkYcU/l7wWCFZPSNZzoNl86u0TBLuqJXcR8Kf/2xA0SaJBbCttDVMG2yOAfnCZ
         5mqg==
X-Forwarded-Encrypted: i=1; AHgh+RppuQ73PVkBJNB+IEZfJbpY0P40qUbPoWdaUO9MdV0o/v+zifY8yD+bl/zZt0HwBb431kZoAn8=@vger.kernel.org
X-Gm-Message-State: AFuF++nQdOzfmOFGQG1V3u2TLUSQYQ7CyJrISruLX7F1xplXV+AeMChV
	Wj/V0aFcdGmod3HVpC3FjtG1hZn1UJaepVfgLi3vbbhCDPiDHikZ9lC2Imz/HKw/aF/yI4nEzMu
	y5PhNa95FVzzgjW9/aANLutiYVg==
X-Received: from dys24.prod.google.com ([2002:a05:693c:8018:b0:324:1657:4d0a])
 (user=almasrymina job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:4b02:b0:36b:bec8:94c5 with SMTP id 98e67ed59e1d1-395df2595femr20809097a91.10.1787510162785;
 Sun, 23 Aug 2026 11:36:02 -0700 (PDT)
Date: Sun, 23 Aug 2026 18:36:01 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.766.g2966f0265a-goog
Message-ID: <20260823183602.1051453-1-almasrymina@google.com>
Subject: [PATCH net v1 1/2] net: core: check skb_frags_readable before
 uncloning in skb_copy_ubufs
From: Mina Almasry <almasrymina@google.com>
To: Jakub Kicinski <kuba@kernel.org>, Kaiyuan Zhang <kaiyuanz@google.com>, 
	Willem de Bruijn <willemb@google.com>, Mina Almasry <almasrymina@google.com>, 
	Eric Dumazet <edumazet@google.com>, Zoltan Kiss <zoltan.kiss@citrix.com>, 
	"David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jason Xing <kerneljasonxing@gmail.com>
Content-Type: text/plain; charset="UTF-8"

skb_copy_ubufs drops clones and modifies the SKB via pskb_expand_head()
before checking for !skb_frags_readable(skb). This alters the SKB
geometry prior to throwing an -EFAULT on an invalid SKB. Check
readability first.

Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")

Signed-off-by: Mina Almasry <almasrymina@google.com>
---
Note to sashiko: if you find pre-existing issues, mark them clearly as pre-existing.
---
 net/core/skbuff.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index d4382b68d56e0..201c9ec1519c7 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2001,12 +2001,12 @@ int skb_copy_ubufs(struct sk_buff *skb, gfp_t gfp_mask)
 	int i, order, psize, new_frags;
 	u32 d_off;
 
-	if (skb_shared(skb) || skb_unclone(skb, gfp_mask))
-		return -EINVAL;
-
 	if (!skb_frags_readable(skb))
 		return -EFAULT;
 
+	if (skb_shared(skb) || skb_unclone(skb, gfp_mask))
+		return -EINVAL;
+
 	if (!num_frags)
 		goto release;
 

base-commit: 7cbfb180945ce529608e4d4e24a6d483699fab1e
-- 
2.55.0.766.g2966f0265a-goog

