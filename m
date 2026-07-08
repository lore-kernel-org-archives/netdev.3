Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF89B27FD43
	for <netdev@vger.kernel.org>; Wed,  8 Jul 2026 05:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783490157; cv=none; b=LhIpt+iKNYrixU1racxS/PAewA1QhrSHM4GIXzoQ5vY6HJaPY6PkuH8FzJ35WpC+S+wVQbNQwoOSgB4YcfepkZCk8lGuUADjJ3QywMABzS/Trj4DyEAGYYVef9Q/GHEyn1Vh1uNLANv5c2Xg1+0bg1PnyWYIgLiMmn2oJdGINd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783490157; c=relaxed/simple;
	bh=NePtVzLnArKSRcN8Gf6OSj3+5Rep0SzN4OhdZEPaB+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sJQsga0/Ap9m/nxwSJRjhSxPU3eDHqqPz49O7elGSY59uWp/EGIrxHhZEqq2tLVZfpQqT/v6qwvwPWpS3n0Mb4FuFDZoCP3LEHFKHZdtFLUi8nr52F8rW3Tdf/8XgbN+14cW8tOsliRUVj+hST9RhG9dOKfBgetxJ5xKFpQua/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bp5w6NPH; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bp5w6NPH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=rp
	zoZi//IrMahRPFYPFTT4Lm6Ci1z5s4FtwdfcpBJg4=; b=bp5w6NPHynOhWKsgk8
	lC+FWrjKDhv8uR7ZSOGzHlGSrVXbnMeRl6UDPE1psfuG9fVpgxDKAF8+TJjz2JBJ
	zF5xh0pvhHIgbpe2EYR+ZSR+8xvEvzIB4WvFKuLL9uHsjgPOND5AsYcGwDIyBGqt
	NepqOzIaexlFhJH1BAG3It/QE=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCgvCgA3ixsu5k1q96u5GA--.57642S2;
	Wed, 08 Jul 2026 13:54:54 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kerneljasonxing@gmail.com,
	kuniyu@google.com,
	willemdebruijn.kernel@gmail.com
Cc: mhal@rbox.co,
	bjorn@kernel.org,
	jiayuan.chen@linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH net-next v2] net: skbuff: optimization of net_zcopy_get() call in pskb_carve helpers
Date: Wed,  8 Jul 2026 13:54:54 +0800
Message-ID: <20260708055454.9167-1-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:QCgvCgA3ixsu5k1q96u5GA--.57642S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ur45urW7Cr4UAFWDuFW8Xrb_yoW8Zw1Upr
	4YkryUAFs8Ar43Ar1kZr48Xr15tFsxtasIgF1F9ay3Arn8ZFy0gayrKr4SyFW7KFWxuws7
	XF1Iva4rXr13XaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U6SoAUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbC7BCzgmpN5jBRSgAA3n

From: Yun Lu <luyun@kylinos.cn>

Commit 98d0912e9f84 ("net: skbuff: fix missing zerocopy reference in
pskb_carve helpers") introduced two calls of net_zcopy_get(skb_zcopy(skb)).
In fact, skb_zcopy() has already been executed once before. When calling
net_zcopy_get(), skb_zcopy() always returns skb_uarg(skb), which results
in adding some unnecessary instructions in skb_zcopy. So, change these
two calls to directly use skb_uarg(skb) instead of skb_zcopy.

In addition, also use net_zcopy_get() instead of refcount_inc() in
pskb_expand_head() for code consistency.

No functional change intended.

Signed-off-by: Yun Lu <luyun@kylinos.cn>

---
Changes in v2:
- Directly use skb_uarg(skb) instead of skb_zcopy.
  Thanks: Willem de Bruijn
- Links to v1: https://lore.kernel.org/all/20260706100229.13812-1-luyun_611@163.com/
---
 net/core/skbuff.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 18dabb4e9cfa..d798fbdc3da7 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2326,7 +2326,7 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 		if (skb_orphan_frags(skb, gfp_mask))
 			goto nofrags;
 		if (skb_zcopy(skb))
-			refcount_inc(&skb_uarg(skb)->refcnt);
+			net_zcopy_get(skb_uarg(skb));
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)
 			skb_frag_ref(skb, i);
 
@@ -6842,7 +6842,7 @@ static int pskb_carve_inside_header(struct sk_buff *skb, const u32 off,
 			return -ENOMEM;
 		}
 		if (skb_zcopy(skb))
-			net_zcopy_get(skb_zcopy(skb));
+			net_zcopy_get(skb_uarg(skb));
 		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)
 			skb_frag_ref(skb, i);
 		if (skb_has_frag_list(skb))
@@ -6992,7 +6992,7 @@ static int pskb_carve_inside_nonlinear(struct sk_buff *skb, const u32 off,
 		return -ENOMEM;
 	}
 	if (skb_zcopy(skb))
-		net_zcopy_get(skb_zcopy(skb));
+		net_zcopy_get(skb_uarg(skb));
 	skb_release_data(skb, SKB_CONSUMED);
 
 	skb->head = data;
-- 
2.43.0

