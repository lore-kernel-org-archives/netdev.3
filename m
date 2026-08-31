Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963043A785C
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 06:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788157673; cv=none; b=j8j9DgLq14aN2Z3P0tFCoREwUlnW40Y9kHk0BGSnKBqyERpBWZrFTDzpjxYgGBdLQ8fRs4htlyfqu08wfUt6FcIskEu/2XvQCDtfQKAKqdUqQQaTamM5lK/n5aIyq8nCiy5Xnq3e/5q0xpSyAnhWhZIchIiXzf637ObO2ZyXNxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788157673; c=relaxed/simple;
	bh=BVKzJmDOHWXqnK1KWCSiejwK6ubQnkmSh6PpBiqhigI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=atPmLnk7rVv9ofNSKwsbp36yEF0OsvF7V2QAuLbe592YIOPhwF+ah+j6qsuH5WpEELkH0JZzErF9ovsKZrBu67agg/1r3B7/pVjWhFjfET8sfgTHV0hBzTAVjsei16XtFnK33Nj1JmqMvv2tKKtIy1mg4fqX+UChRgimIckdR2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=CtY3FrVS; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="CtY3FrVS"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-69f7fa1c548so4725613a12.2
        for <netdev@vger.kernel.org>; Sun, 30 Aug 2026 23:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1788157670; x=1788762470; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CbXcNrC9LsHQoj/JWtGUvNKuhQts0DTTYsFf8eexyzg=;
        b=CtY3FrVSgtCcbZRWmZGHPdXjnvveqnXwEAlME21Q7WXNYkbGdp0wB+V0l+A2lim7QT
         8UPZhrB9rtIGcs71hnlIN+pRCtTeScyv7acN30kuG6cJPjAb8QPjtHv7+1H8er7b8FNT
         cJYkFM7dTV/dsDNS0hUvGiahj0laxXj9+AlViUuKrrso5XFbMOC+l5NPL20d02h7u/jv
         RYl22vncfBBozIpdNR5UBZLMTEhZ3QoIn0GDIePrgZQlEq3xKZURWTsHu3KuFXgRL1i7
         qz3HtmS540O4n6We1e5OZFLrymO+x/ZsI+j6Bd+rC2Az6OTFWV+Oz6bnRiXxP3XEyUzE
         4yTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788157670; x=1788762470;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CbXcNrC9LsHQoj/JWtGUvNKuhQts0DTTYsFf8eexyzg=;
        b=qcIZHcsZUtLD95oVQ9d1toY2X6uCHfZyCzMFfOs0F3y4RBABSs9z50VecWK+pz0Llq
         jB09F2WCuqiuLJfjqmaJB5f23u/1qQSK5uRAz/rFpa7AYItJ6gFJRQzx2q2J1nqppej1
         KOSosfTIaXkHxTQ3mjD6nbHl/wYz9kjKgmkHIMGOvm0Bsjz379A5WbNrdcRauSjcTKG5
         1loIP98qTa0O5YH/PR0eaJr0z+Xj67D9XgqN9WkjVBneFXI8zJ8kKcOPpctD3q738H9k
         qIZ9SZ+VEKM9V5x31EJ0Z+NaVV1w8H33hiWHn5eFoth2fPtOSJ3X0hH6e/wKU8f0dC86
         gkxQ==
X-Gm-Message-State: AFuF++nnzllXUk39O58dsNAAffTX87Zu2GC6VY3IVKP3tA1yhXbwc/7B
	okrOLwFp+UNuEWJ3K035HxcYFCt8OhmtQnzNqNsrhLXeP61+DsNaYhllR3L8KN7wfEk=
X-Gm-Gg: AYBFou0Y1DTL9YZHaPdc1smuzZh5Ca+vKMebBY2qI/sW8KVRTWLKqfVTZnQYpcU+kI5
	eFc2g39l2NeI5WJYP4I/LBuVCXcv3u9NpbgoEB5k2qxP90Y5uE3Dsvwl6gWbStWmjUvYWgfqNSs
	lNJNsHNRQi4ylaOMTim+DDIFLgl7D6PRIWGTHQYElOpPaiW64yGfRJIR21jrlAWwEvgD03siJwI
	btEL/yr8z6ivoSL1PSKIgrgRPkpaeJjQvbmcBsMVZBtdkEw6rdEOjqhJXBpEUzGkM7td1G0mkCE
	4y6TrJrpR2FSBVzcIMwTdsaLOIQKHORFwVywR8AkmjnqkVx5ZKZVod4By95TfnfTZ7TqZqapxbv
	d1pIwpxNfeM2ttU+6/xlvdg44XP6cMf93MT4FWOd2gV+34HTPmdWvaxyQYhVypMpk4OpplBoQrU
	+qzw0vwBFg0G8PpL981qlzDWrM836gHzeWTS33mb0SrtxLSOKi+Hnxil6i6DYwZmiaQRRLwgpeq
	EX2pVXjLXbqdYUEkjpouqa9aKPTgmUopB01BQ==
X-Received: by 2002:a05:6402:501e:b0:6a6:15a1:6c38 with SMTP id 4fb4d7f45d1cf-6a615a16d92mr13500965a12.3.1788157669824;
        Sun, 30 Aug 2026 23:27:49 -0700 (PDT)
Received: from cloudflare.com (79.184.131.109.ipv4.supernova.orange.pl. [79.184.131.109])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a61b158ff5sm2417202a12.26.2026.08.30.23.27.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Aug 2026 23:27:49 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Mon, 31 Aug 2026 08:27:38 +0200
Subject: [PATCH net-next 1/2] net: Make skb_ext_put_sp() idempotent
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-skb-ext-prep-work-v1-1-ecc2a8542fd9@cloudflare.com>
References: <20260831-skb-ext-prep-work-v1-0-ecc2a8542fd9@cloudflare.com>
In-Reply-To: <20260831-skb-ext-prep-work-v1-0-ecc2a8542fd9@cloudflare.com>
To: netdev@vger.kernel.org, Florian Westphal <fw@strlen.de>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, Jeremy Kerr <jk@codeconstruct.com.au>, 
 Matt Johnston <matt@codeconstruct.com.au>, 
 Steffen Klassert <steffen.klassert@secunet.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>, kernel-team@cloudflare.com
X-Mailer: b4 0.16.0

The sec_path extension can be released either when it is deleted from an
skb or when the last skb holding the extension block is freed. Make
skb_ext_put_sp() safe to call from both paths by returning when
sec_path->len is zero and clearing it after dropping the XFRM state
references.

This will let __skb_ext_put() release the sec_path without checking whether
the extension is present first, which is needed if we want to reuse skb_ext
chunks area after skb scrubbing.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/skbuff.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 966af3beed94..aa8b42c74f42 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7236,8 +7236,12 @@ static void skb_ext_put_sp(struct sec_path *sp)
 {
 	unsigned int i;
 
+	if (!sp->len)
+		return;
+
 	for (i = 0; i < sp->len; i++)
 		xfrm_state_put(sp->xvec[i]);
+	sp->len = 0;
 }
 #endif
 
@@ -7260,10 +7264,8 @@ void __skb_ext_del(struct sk_buff *skb, enum skb_ext_id id)
 #ifdef CONFIG_XFRM
 	} else if (id == SKB_EXT_SEC_PATH &&
 		   refcount_read(&ext->refcnt) == 1) {
-		struct sec_path *sp = skb_ext_get_ptr(ext, SKB_EXT_SEC_PATH);
 
-		skb_ext_put_sp(sp);
-		sp->len = 0;
+		skb_ext_put_sp(skb_ext_get_ptr(ext, SKB_EXT_SEC_PATH));
 #endif
 	}
 }

-- 
2.43.0

