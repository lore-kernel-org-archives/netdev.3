Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA9238E8A8
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 01:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783560374; cv=none; b=rd1hFfm5XJAQradv4gG+FHKm0l7NB/TPF2/aDmph/3Pex9tC5yvVIkVdgW/a8yUV46YHjeLVwypMIQEUjC7jQf944JtXV2zn6hyR9MR7CPehLRmmlhc8VsOROD8SvE+f3wSPZTvGkaFk+5nXkqamFFq81oSWJYwCS+t5NFKxEzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783560374; c=relaxed/simple;
	bh=slITtFXnN6+kMt8tSJZiRPSCh5zjnxTOEinGA32/tCw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=PtmY95+jzGlDXuy/6iKgqylEw/YCAxjg+ld8LMLMGvyTIfUCE/0Qk/CH7Vlo+3xYrAe2TwtZk/pA/38qJN0mwBYWankuUWE80E76RlbXhdrktS6dtjm2BCYPfFbxYLLs8B8WuoUwacMbhoMhByj32MNUoghQ8TgP5Bnk0fi8GxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpbQpnfS; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpbQpnfS"
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-81e69a2db34so5925827b3.0
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 18:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783560372; x=1784165172; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=l19YY1TytZ0fCTLcFsgh3jtgSiNFwdgT8WcpeGkq0UI=;
        b=cpbQpnfSLfYpwHO+VRpzIRLAsXzpnmbue2W3qVk+opXHttO6RPERytMJEZ+kcdyZ0j
         IKVMGlfNyEsr41mJ0TxdM6UnjCZdar8ghLlJLHC75IKbZZXed+47Kxw2Z889/U1Qc7CU
         VfSAZUCEGO/PTT/SUWM6TcngO1HwtwKPVCvPMpPffxe5JSi93tPzoPoij1f43ovYFVqn
         GIkqYqqO40OOnUe56Ln2IZcs5g6DdkBH9NsAifOazQr8kNAetDslCljJGC/CCUVWb2oN
         e6AhRYMoXddV0++MQIhk1+2VzQ64z0K/8eMmcX2P/+hQ2HzmzxVMSNN4pgVd39xNtH5Z
         AJxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783560372; x=1784165172;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l19YY1TytZ0fCTLcFsgh3jtgSiNFwdgT8WcpeGkq0UI=;
        b=lXLWwIQsES/AS1c+MpOF5qHAjPN/ylkiTTvHbWNJK5f4pXC2cNK4JYfx8zv42dj8Ln
         /8mieltmKV0Fhlesw2Qbh2WAq7B/58zru7AGEEiTcyWmsdGjLMv/ArRszjZXCH7fucgD
         mJPS5tQQh7MQnEKO+22F+T0/wloiopvhdfFJUn68iLdugAO32wsM9w6dq+rKcrpvVQBT
         9ZzJ6BXZM6TyViO5oLx5MttagYPjb5BuJYVhu8426syZK7HN0loLvcobzx/u5azhm6N7
         gbDBy30OST+bkiItQCa6mslJ9NG+88KHw5Gr+YGDkO82aMGFE1odiLyOk1pyNCJaLQFV
         i8UQ==
X-Forwarded-Encrypted: i=1; AHgh+RrNNOrswiVxGCG3c2m34SNuYYj3fXggJnpS7eyRvi4tMxv+LnzR/KMBeTmZs3Qq0EUOVlqrA+s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIDZVhlLUUpMXfK4iZWWhGHvYKf4o1IItev90HlTDG3nPHDXxj
	SmbnN1Dpe68BUxjJWPImZxF+oD1cQP0bTAvhGXmJGsQaK2gtzI9tDKHQ
X-Gm-Gg: AfdE7ckaX6GVfkgmmG/OFnWuKWdo9wd5NxnypebAg5WhiYmcHk/0idphSatVa7XYvKY
	Hc3/yarooMJCjmUhLiSIHneEwaADPnRP/+hB/qv8H8BKQxCoZzkBBgem2lm0tkZ2HuTh5iWvLOp
	72nk1ovwaqRz3uBV5XgtyqBQ8vlsea2MWMX3REzJRe6SSzeZsk+0iz4rheSTNYeg4B+2Go6mBzV
	+EJJ86OWgYDQAkCCTa9dPWYuEiGl5UC1IrIt8URD+iAvkrv5UPJHnckTZgTeM7kMgwpSExEiOsl
	HcQtF8hbDphk2R5xJOFwn0NOKoVFNoQ3Drw9x0r5ukFyl9k+02LIGKFlTunfQctfAkDhNvvCLmc
	OqiMUp7lfEdHlkg2cxbCiO9TnK2/Ckc5VKpx5FY9brhdEr8n6+XdVrCODemkTijG7+pWvd4FRoB
	BoUo1/oMrcHB8nvueyr7zomTIJ1Fj+ybSoSg3bZ1g3s0voIA59TJ4GKKP7rGTrHZTULA==
X-Received: by 2002:a05:690c:9b11:b0:81c:c77b:3546 with SMTP id 00721157ae682-81dbc7217dbmr40365437b3.21.1783560371925;
        Wed, 08 Jul 2026 18:26:11 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6bf80574sm6187707b3.22.2026.07.08.18.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 18:26:11 -0700 (PDT)
Date: Wed, 08 Jul 2026 21:26:11 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Yun Lu <luyun_611@163.com>, 
 davem@davemloft.net, 
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
Message-ID: <willemdebruijn.kernel.685393450077@gmail.com>
In-Reply-To: <20260708055454.9167-1-luyun_611@163.com>
References: <20260708055454.9167-1-luyun_611@163.com>
Subject: Re: [PATCH net-next v2] net: skbuff: optimization of net_zcopy_get()
 call in pskb_carve helpers
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Yun Lu wrote:
> From: Yun Lu <luyun@kylinos.cn>
> 
> Commit 98d0912e9f84 ("net: skbuff: fix missing zerocopy reference in
> pskb_carve helpers") introduced two calls of net_zcopy_get(skb_zcopy(skb)).
> In fact, skb_zcopy() has already been executed once before. When calling
> net_zcopy_get(), skb_zcopy() always returns skb_uarg(skb), which results
> in adding some unnecessary instructions in skb_zcopy. So, change these
> two calls to directly use skb_uarg(skb) instead of skb_zcopy.
> 
> In addition, also use net_zcopy_get() instead of refcount_inc() in
> pskb_expand_head() for code consistency.
> 
> No functional change intended.
> 
> Signed-off-by: Yun Lu <luyun@kylinos.cn>

Reviewed-by: Willem de Bruijn <willemb@google.com>
