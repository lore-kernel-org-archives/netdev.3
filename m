Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2B042DFEC
	for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 07:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784705387; cv=none; b=uhryFTTMv6di8/23BErtnEwozRv9WqTViBGdJLGSFmhiwzwhLnFA9LuzGemfVexuHwBjNtoG0JxzaC23UgvcoWSFFmtp09ctRvMJAqR3MoUCaTKdxcODLv+pGjaPblqYsoa/RQLqrOq/yM9xR5w/vQAW6RUkA4bWptv8bIPDllE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784705387; c=relaxed/simple;
	bh=B/b6NZPXWjZ4ZUBjxDFyKQ2VsdKInaH6taZRJY5DHzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jjYd3D5jxT1orYZkQm3UBitA+HOiGwxKzCxzJgxbf9Y6hMldfU043s3CPjzm8P02jUZoRXLuPbX75PXMj20mx61ue1P/Hy7lUDyPuyqg/jWritwWkC+tHpP/JtCPhbqZwCKS+ru4AVyMxTWc3M/TjUpHm/8x7kxT/IojxhtwdQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nMtTyXBr; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nMtTyXBr"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso8214341a91.3
        for <netdev@vger.kernel.org>; Wed, 22 Jul 2026 00:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784705375; x=1785310175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=12eYBnmRPs6XDaKWNCAEegubsqjIFXOjPNFE7WXNNDU=;
        b=nMtTyXBrEKEHzzHtA5t+dD6kV9TQkaXLEXBREhl9NLfqPjAJoC2ZL8k0R3B9pfvyDX
         6+IGyCJShFMwNDSVC0ykZLNSkUzF7/YY+r9UYexAI1k9L1xW8kDLdZ2Tgf6/7sivarc5
         9u9178LUVbvwFsbovlx815N1DbBoBBnaqQyvjlY8zP8mrPm4v3HHPEIjkpiybrXwhTBB
         vJnocD+eiWUTiZkrHmrdBWJCWHaq7qLfYf6peJXbeBzh8SsCG+kNmxiLGbI77YmVk89/
         /Wnd3yUPdm/2gQK36UleLouexHsSD9kO9cDX2+Nm1aJyIC2D7QcadI52siHTPW9aCTIE
         tcGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784705375; x=1785310175;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=12eYBnmRPs6XDaKWNCAEegubsqjIFXOjPNFE7WXNNDU=;
        b=O2TaU402vT42qbhsGPnZYqqzUgpPEIqZpl1skcG+JGlLAO3SkjZZD+6G7pDiPuzHED
         0OueIlBhyAoBygb2Wy7jdLH0EYzVslRv6WBqBMUe0I4PtsAPqZsTd2v9WYGBxhlYusuZ
         tbtRyhcBfIoH0sDBu5ZuSP0HpCqTNzYV9FYyt0Wy8RoDybM6zHeFMGEuSJXLJm/2Z79O
         Ahd6YJpoCG9u8vw3GWhlWaSdfNfSyeujdLYrmxMqhBrmdCPDzyust3rNPPwXCK3K9Yjy
         7zlAh7MKCSPGv/c9DkrA0PVf2HCGTGwzC3glMEG9KSG5s6nAVS2FsaCosPdAKNonPRA3
         KkTg==
X-Forwarded-Encrypted: i=1; AHgh+RrH7LTs/HFBr9O6tmFrn3vgVvvlYXZvTRi3U5pBM99HsQNk30Q/6KHi6fRFFv2s3YIYoeB0dhY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywm6iUxVkVV0sXvmyVV+nNan+jVZan1r+bMTI6ckFSVfb2Naf1y
	mXQIVy3V0QZhF9CVus4ahtx/1x7DuW+PXf7KzH4r0qvr8lOkWAkGDNth
X-Gm-Gg: AR+sD12AqFV6LBEZY2kHZTdDjCaRgCnWcCHzbh1PZVPVWjIa9CD2GmK/YFZsaPbZ5TL
	Gi8HcMdVJ6hkxTjfiGke6hJ+dOjyZasxN20qPx+K/E3cBOjT1zKNERmcPHH7fcvEsjz6wSMwMTc
	xGPghgwELZYprEf4MSqSW+YL4muen8vwuISWTie59DABunKoBdGxq8jMlxbxdwgBcgXcdAd3K7l
	NvPYFrnb3DDZgfJjQZQwfdsxTpSGcY5759BCmI0mH4YoNa4u6ZR9cMA6qaVG9KGY3x0fo17eo42
	vY+DgzCmKW65E/PR9bbSwUtszB5yEcQcAtQy1CVhFXYl125dvwoonAK9x9zBT/stUGjy6KPViva
	0+lFRMxeYO4NuiFKUO0gX47B0QXHZNdzQV39syZIq0fAa7S10guZP4fofwxDUoyLqQvjdroyW70
	rQ9ol0VX8KD3Xyt1xmIrcZR5DTbKmsLLoDuTBhXZXxuRNOycJ2S8ajgNnRtRYkhw0p2A==
X-Received: by 2002:a17:90b:3ccd:b0:38d:a8be:a597 with SMTP id 98e67ed59e1d1-38e4b5c98afmr23897459a91.37.1784705375435;
        Wed, 22 Jul 2026 00:29:35 -0700 (PDT)
Received: from secrnd-cstp.tailb7f510.ts.net ([125.131.91.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38ea78e296fsm575673a91.8.2026.07.22.00.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 00:29:34 -0700 (PDT)
From: Sanghyun Park <sanghyun.park.cnu@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: Sanghyun Park <sanghyun.park.cnu@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Leon Romanovsky <leon@kernel.org>,
	Alexandre Cassen <acassen@corp.free.fr>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] xfrm: Fix skb double-free in xfrm_dev_direct_output()
Date: Wed, 22 Jul 2026 16:28:38 +0900
Message-ID: <20260722072837.2011916-2-sanghyun.park.cnu@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A return value other than 1 from local_out() means that the skb has been
consumed or its ownership was transferred. xfrm_dev_direct_output()
nevertheless frees the skb on this path, causing a double-free when
netfilter drops the packet and invalidating any other owner.

Return the local_out() result directly, matching the ownership handling
in xfrm_output_resume().

Fixes: 5eddd76ec2fd ("xfrm: fix tunnel mode TX datapath in packet offload mode")
Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
---
 net/xfrm/xfrm_output.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_output.c b/net/xfrm/xfrm_output.c
index cc35c2fcbbe09..e305ba32e356b 100644
--- a/net/xfrm/xfrm_output.c
+++ b/net/xfrm/xfrm_output.c
@@ -636,10 +636,8 @@ static int xfrm_dev_direct_output(struct sock *sk, struct xfrm_state *x,
 	nf_reset_ct(skb);
 
 	err = skb_dst(skb)->ops->local_out(net, sk, skb);
-	if (unlikely(err != 1)) {
-		kfree_skb(skb);
+	if (unlikely(err != 1))
 		return err;
-	}
 
 	/* In transport mode, network destination is
 	 * directly reachable, while in tunnel mode,
