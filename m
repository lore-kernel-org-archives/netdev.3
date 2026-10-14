Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794021414;
	b=jby9uANC/5oYVJyC5gHRFl4YrtO/BzE3fIX3RgEWV+RkljCpj9q0oy7x5DMOuaxTbygI
	 FMArhJkjnaRMZoTy35fVWzbP58QbZPYNoZvtEjuRJbBC7n7wOV/MA1cqEMIhIW+mkZh0W
	 izjbCHbxnsnNFpbLIkxkIrHmdYREEiqNf8ZQVGgN1oYki2Z6bovoJe0xvMuGJW25hADcF
	 VgrdvIgYlc0KlAorfnWF4eA/0fYscO9L1Xhu2w0InJh2Q3zvSPliKH2+vvt7L/Lx31StD
	 vBOIwI+njCijLp68H1czzGJkRUPaUKGeuwxaEiLN/NhC6reFdArYbq0Zzko8OaKcogw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794021414;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:To:Cc:Message-ID:
	 In-Reply-To:References:From:Date:Subject;
	bh=ni+esugfHha2YCL39AiafB18sWQsNLNY7mLIHezPVsk=;
	b=N0NQJXl2XH7zed9yuBbL796aK5A3Roy3HIz79Kpja9D79TNZOz3vl4d2rCtHA2w3lYWa
	 aBUXWIsJ+qwkKsQllZ6KQGmBUSocgDlZRIarGvqs6dRc8trhoymzVMfG0zYOnH1KVzuOu
	 qbqvrc9tWgyhAc5Mx+MagRqAlifP7grJEI8/aMkbjdqylKujAQ48uLNu3/ZZs027E1E84
	 S8feEsJ77LyUSm5G76aLpyowTdKji7+ytRET9mHGACppVoNSOArNEnEqqblvWa5TTxPJn
	 IcYeANrlsq9IdzE07RZwueV4BRrc9CHU/Vn9pe/KR4SZS4OgddLy8Dn1HCvm9nKdnEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sNUX1u3d;
	arc=none smtp.remote-ip=74.125.82.169
Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325D7606A326
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 03:16:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 325D7606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sNUX1u3d
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-33bb5afa736so198645eec.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 19:16:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794021413; x=1794626213; darn=vger.kernel.org;
        h=subject:date:from:references:in-reply-to:message-id:cc:to:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=ni+esugfHha2YCL39AiafB18sWQsNLNY7mLIHezPVsk=;
        b=sNUX1u3dJPrUcYPIH/DsxbltlZ2UJ+q9LiRWLxI702MvIZQu8PVQQUUdEezCWPwq3e
         ENOqUwLViri7S+tQIdqRAnitIC9hsXeaHKtKXV1Ji6CvA+WarUepAi1BqWzXTID8ABHe
         g79PJ4DbVG19eN+gK/tx6BcU9vDuXQKQGQO4GwAjCyXlNUoVEYllvTCsW7P/yWlJCLdR
         osQX4QDoCRAUV/SJoFjMeaPxSi9PQ3AMnqgQDsLVvhJ53yvqXq36lMOx6WyVLm87oHNO
         aGxngCZgUuNwr7rPc+Uj4q4UGzuh6Nh9PP2xed64SC6aWE7qn3hSSZlj+Gt2dSLRyg3R
         Sjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794021413; x=1794626213;
        h=subject:date:from:references:in-reply-to:message-id:cc:to:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ni+esugfHha2YCL39AiafB18sWQsNLNY7mLIHezPVsk=;
        b=2dIlsNiOPJBt0p+hP2zyD9Q9DA4TKnGNLCmht+ZVqElo+H/WkFiCxPjtUIDvkaKfJn
         VlLKJEo7ctm+c9X7+obrPTeuVSAd5xjCV0NlJ4hOPuC/uxbwgzyVNKeOcy6i2Zc9u7LL
         uvmavb/mWBRbKviTS5O/zu0DwJ32v9oSvDZRcCi5w7zf+UhhgnudOC54hhBv0fzoPysz
         WCdQKYnYKTpMuV77eIOlXJ6b/mAq2PKY9CVHliGN5CabdRax4AeQOPks/VyN4shrisrJ
         y2z37grwAqHIJ5QLeAwo42fWv6fDlCgrn1S2poSfVTUH/5HfTP2oBUHArdjPC70KPyMG
         oYyw==
X-Gm-Message-State: APuU4Z8/SNyYqw5sgaSTR7DtqFo4dw/Q8MovvwNLSN8ZMsjx6zQ5pJd2
	SasEjW8WQKIULZmtAAdSCsSiym9lIb+lyEGM56eKOCmfPycw7b9iMjXNnB9j1Puw
X-Gm-Gg: AYBFou10/ZeMgGkFonYaFnB/N8U/IAUkZbJ+zyUr8SC0dPDm6/+4x6rr0iMVz1EQbcx
	B5U1G0ze3mqL2jtRwO9J2fw29fANXsHwagjNX3+TzCFsgaqUKh4n1KmijVh5ZKVh7Pl+y/mxsGQ
	by27FG33KyyuYMI8TUE0LkWuJVG7NwagmAitxMKEVN+V5eevZmdzeH6R2rZ7dSmRq5AhwLIYcfh
	OCkILY5sKghNYyMAMYCJ14AqBJuGpE4907LSjLepoFsRHHWuSnBKw+Wxm0nUDUeu+kQzIn4YxN+
	Zl4EP8F6uwYma23Jp0udOQ8bEWthmVXRZiEawQpWT72tuhXdCSur/HNEGVtMcLUB0Yz3wqFmmyM
	4qRv5q+Sg5qxiE3lWuqvngPY1zBIf1FZ1eYSZHkgdvsmNi215kwK+Pb+xIjQdXU0rQBQpN5ZbEo
	Phd/DhX9yoQzRjj5RdQ5EmZcleV9F5uZ6A9ujN3/qD7EYmaSAgf+c9LXxLgKEEPvbzhTvH9jxW7
	HjRSH5RuwpDWDz6jPIlnKMdpYJYRTkQjlnWo5HMTqSxy80bMbIx2HlMLxBWcdnnCGIcG1an1yjX
	dLUtwXDJh8R86lSS4u4Vrnsg4pXuBk3KjXzPbqUPzwcAOb16hn4+MgSubRMxVG/PSwa3sJQ=
X-Received: by 2002:a05:7301:d801:b0:36e:66d8:1424 with SMTP id 5a478bee46e88-36f6f991743mr9113710eec.0.1794021413134;
        Fri, 06 Nov 2026 19:16:53 -0800 (PST)
Received: from msg ([188.253.120.78])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa651c57asm11453914eec.2.2026.11.06.19.16.47
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 19:16:52 -0800 (PST)
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	chopps@labn.net,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	dsahern@kernel.org,
	idosch@nvidia.com,
	linux-kernel@vger.kernel.org
Message-ID: <20261107111617.21347-2-q.h.hack.winter@gmail.com>
In-Reply-To: <20261107111617.21347-1-q.h.hack.winter@gmail.com>
References: <20261107111617.21347-1-q.h.hack.winter@gmail.com>
From: Qihang <q.h.hack.winter@gmail.com>
Date: Wed, 14 Oct 2026 21:17:00 +0800
Subject: [PATCH net v8 1/3] xfrm: use skb->dev before dropping the reference
 held across async
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list

The skb->dev reference that is held across an async resumption is
released before skb->dev is used, on two exits of xfrm_input():

  - the drop path runs the receive callbacks after the reference is
    dropped; xfrmi_rcv_cb() reads skb->dev->ifindex, so it can race a
    concurrent teardown of the device
  - the decaps success exit calls gro_cells_receive() after the
    reference is dropped; gro_cells_receive() reads skb->dev

Use skb->dev first and drop the reference afterwards in both cases,
matching what the transport exit already does.

The early drop for a state that is no longer valid releases the
reference on its own; let the drop label handle that reference too.

Fixes: 1c428b038400 ("xfrm: hold dev ref until after transport_finish NF_HOOK")
Cc: stable@vger.kernel.org
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
 net/xfrm/xfrm_input.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 5ed87d513..cfd5cea03 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -496,7 +496,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 					       LINUX_MIB_XFRMINSTATEINVALID);
 
 			if (encap_type == -1)
-				dev_put(dev);
+				async = 1;
 			goto drop;
 		}
 
@@ -747,9 +747,10 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 			sp->olen = 0;
 		if (skb_valid_dst(skb))
 			skb_dst_drop(skb);
+		/* gro_cells_receive() reads skb->dev. */
+		gro_cells_receive(&gro_cells, skb);
 		if (async)
 			dev_put(dev);
-		gro_cells_receive(&gro_cells, skb);
 		rcu_read_unlock();
 		return 0;
 	} else {
@@ -779,9 +780,9 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 drop_unlock:
 	spin_unlock(&x->lock);
 drop:
+	xfrm_rcv_cb(skb, family, xfrm_proto, -1);
 	if (async)
 		dev_put(dev);
-	xfrm_rcv_cb(skb, family, xfrm_proto, -1);
 	kfree_skb(skb);
 	return 0;
 }
-- 
2.54.0 (Apple Git-157)


