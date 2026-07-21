Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD5942EEB8
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 07:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784620799; cv=none; b=rg+M/hTgcSQS/Oi5tf4vOStqx/87Ydy6cLipZ5ecKUjiFEt7iNpFxmjAC8EbcCRveZ6xJMsXHJ/lFtBBhfngW+W2fyWy8LyB54qTB67uuc0YcqgFTXuAmwznZxWTBHDSdlQTKcN596+XLV8FN5/go0STNZQOp3x5y5asJlzcQ7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784620799; c=relaxed/simple;
	bh=nY4hiOLt9M2lA5xfsOzJOgTPXJLqJN9H1zlI03Dllj0=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=bKS1Z3sJts6nZhOGsfOmdHPGRxSO1JWEcnumlmBSej4EuOSvsqyqqPS+Be2MsZAUjuZTYSiNYkftcYdoUqchrPba4owLilVjlW3ZqhG3Q6bbcj293EbWAieXZq2QvLRg9vX2f8iJa0tDWDG+h/D4xi8ORkkcrckTDPPniH8tcxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T9TZuft7; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T9TZuft7"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-81ed2a06b9eso55643747b3.3
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 00:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784620796; x=1785225596; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=1pLcxRafIac0ct5C2xDEJsh+olMLWEs24eBrgjm69R4=;
        b=T9TZuft7DOvwdDfiEeApr3VoX8p9dn1iiG3RRRE0uTuv6ehb/KzoO+FGoc6y2lamqf
         mA3F0nloeW1ePBv8CkpSmEizmcafFoZWknil0wiMbaGQWaSwYybTW9ENUBNWG3LouJkh
         koG/GzcHOGsfguMkbXD7Efu6OAhMPL9aFeTDiCqpSf5opJFZt+Uss668VYOFGtl7p3D6
         bIj87xmgzyXMfEj6gLuC+2u3Qp7HapYIwpIGaAOHjoikFIA3eOB1/GNGes3+ccoW88Oz
         YmNx9KQ4+Fl9y/zCVRv1aQDyzy8s6Hn+KfFbct/8Cp3hfMegZUKDd7wR6U+d5O1GALUj
         AlvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784620796; x=1785225596;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1pLcxRafIac0ct5C2xDEJsh+olMLWEs24eBrgjm69R4=;
        b=e2T1dRu30nelecj/S0RghSVD4s2basWkqeL2ovieYa9lq9ZM6E//NVg2soZlfn82t/
         64bGosBJ6pUS6KWkEXydVcNWlbuM07jM3NZ2VPJj6C9b8J8ZIX1lT+2SOsMHT3QzbkKM
         VdQ2IkrYbg1e0i8zo2SWlrUqJFDaoYHLPKS+BI2btgqe0WX/UC4vnR2yzc2fdgkIbBvL
         ntzfNwTiD1ACRbB3Y/N28hOrfKvDlZGqEqFPYpYDtO2loY4gemrazF041tw/dGko74lt
         S+Lc8d5EYvWLFwPL/FPmUTgTHk5bo7f8FiphxwHriyNNt6jVV3UzPptLHA8o0Wgfh8/Y
         Ozlg==
X-Forwarded-Encrypted: i=1; AHgh+Rp7c7Y83VTA56NnWmywgqtb4ByC2H7vo2aKkpgmE2V0AeD0iwBTULGTdrQvKlYagzBVkn928dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyG8s453L+XVO65j/JCZdXS0yVYoAH2dVG6lv5LRRYNnyQOfjmX
	8dCcgMw3E/mYTubriTGKY0knW8vYzNoQun4FVeeFOcRnMr/8Vaj/enGA
X-Gm-Gg: AR+sD13nyb4eqlbHAzCN0XHRs6SaAYWsshxuuGTIQfVpSwaw0WWYleS8FNqA7tSjmTb
	MaC2hs3W2Prz9t4Mx2/29z0fj3nYH6Pw3T068Naw0Vf//2VvSKioBFOepBKLbSpZtJUDxmkvkXH
	cY55ZAdmOzKlZKmD5z0EAjlL5O/i84Qy4UODlS8W0DZt0kAbLctXkjc2G+o5grMjl4KVMsVJaDF
	+CF15D5tbrleWNNWmku4ryphYjPj3xCm5ksoG1vvFi9/JTaOvsTt/dAApP1Yfr/B11JsmBU5RR7
	ix6Ue0WQJ2WP1t3XnSsmjfnj2K4GTT8M1kYCYA2RxPIHUb9MxEVVmyti7WR7/hUwMhR58XT+tOi
	0Eon7yUPAnS6RcfvyNJaCdTvbtMFTKyru8PUfzrwH2K2lyNr+ZracIM+xD9qveTlKtRxtfoyX9d
	BeWh6ihmLjopKrPlC7TCgIM4QN4rAZg1WShRK8bn5pI8Ox97/duY+k8ZQ=
X-Received: by 2002:a05:690c:6a0c:b0:80b:bc16:8a2a with SMTP id 00721157ae682-81ef25bc642mr47914447b3.36.1784620796626;
        Tue, 21 Jul 2026 00:59:56 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81ef42be12csm59727467b3.36.2026.07.21.00.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 00:59:55 -0700 (PDT)
Date: Tue, 21 Jul 2026 03:59:55 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Asim Viladi Oglu Manizada <manizada@pm.me>, 
 netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 daniel@iogearbox.net
Message-ID: <willemdebruijn.kernel.1f0c43b9fce2d@gmail.com>
In-Reply-To: <20260721014117.2234892-1-manizada@pm.me>
References: <20260721014117.2234892-1-manizada@pm.me>
Subject: Re: [PATCH net] tun: prevent underflow in rx headroom calculation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Asim Viladi Oglu Manizada wrote:
> tun_get_user() calculates good_linear with SKB_MAX_HEAD(align). The align
> value comes from ndo_set_rx_headroom() and can be larger than the linear
> space available in a one-page skb head.
> 
> OVS can reach this case by carrying headroom from a netkit/VXLAN port to a
> TUN port. SKB_MAX_HEAD() then underflows, leaving good_linear negative.

Separate from protecting tun from such huge headroom, which is good:

Is cooking paths with such huge headroom itself incorrect? Should
netkit have some reasonable upper bound on configurable headroom?
Netkit is not the only path that can reach this, right?

> Assigning that value to the size_t linear variable in tun_get_user()
> converts it to a large positive value. The wrapped value is passed to
> tun_alloc_skb(), where prepad + linear and len - linear wrap. skb->data can
> then end up past the allocated head, and later packet processing can access
> memory outside the skb.
> 
> Clamp good_linear to zero when SKB_MAX_HEAD() returns a negative value.
> This lets tun_alloc_skb() allocate the requested headroom and place the
> packet data linearly or in fragments without wrapping.
> 
> Fixes: eaea34b23c46 ("net/tun: implement ndo_set_rx_headroom")
> Cc: stable@vger.kernel.org
> Assisted-by: avom-custom-harness:gpt-5.5-qwen3.6-mod-mix
> Signed-off-by: Asim Viladi Oglu Manizada <manizada@pm.me>

Reviewed-by: Willem de Bruijn <willemb@google.com>
