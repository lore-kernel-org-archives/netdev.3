Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A666C47F3DF
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 14:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791384675; cv=none; b=NZCdkNe2j7d6TwYxzAJtB2d18DjzfVpwHNyFguAAKXC2vIu+TwTl41nllgkeWp31JmjROvm3KIk4XL0F/PUZdxaO1yAV8sCrg/H3AA8cMg0A1BMVemSi4ULZ8vnYb85ZKnmZl7u4/0Br19kfd0zB4Yxryz1TUFZxE+IrzlXc4ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791384675; c=relaxed/simple;
	bh=zg/uWw1C9tuSxeBV3eFBhNDtdmOBp+EfUsAftSVbJTc=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=tiViE7GLuhs4HItp9pat/G+5J0mCVAZ/OGTHUkItyPwbVE+JlTtoLXnYb+4rC47m6MnC0hce1nrAkt0QJGkqnOA9CcLbWVh3qbUDvd9NiUve8k77piPzeaJO95xgsniEJ/a45OH/N7HzKPuzCrbgGPUM8coULuYPbScSNMf4EHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c61zuYBY; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c61zuYBY"
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6768a9fc0e8so4078974d50.2
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 07:51:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791384667; x=1791989467; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YACwyXnL3UskMX5dK960KQ1iZfinHNnmBFhBCvvDh5k=;
        b=c61zuYBYytyJwqC2tJKeP6CGunPFCSNS5tS/mzIXaXxDHHi5/vQ9ceqV/PSyxVYZwI
         Wks4N4Pt5n/kv2/Xhbg7Bdqedo+3vITLvw+1wwnM/mKFKc774lPO7rg6SMEmbQrnrXQa
         GLEo+4AAy9AbGgnAtK8FdZy9NBJD7Xog/zqZCN2hDXdMmjJ/mcA1D8d/ZMW0zK3msV+7
         f9zMHJDp9C2m8Jng6c2DHfWj9BoeAV3QJX9C9xLjZwUQLAixt/7YTld5bP4u0q5tPfgr
         btMR/En/i/NnvvyyCV39B3FCi3GEUKe4nK+XT+YC90xvLPdgb4XH+Q5xZac6ZvCwvqjK
         KNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791384667; x=1791989467;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YACwyXnL3UskMX5dK960KQ1iZfinHNnmBFhBCvvDh5k=;
        b=V8sB6qe2PEDO/ZVcQATrtMZOovA/gP+F+80Ud2nKWIB4XBUE0B0lo/owDIzDsGfsuI
         PSg94eudG2eeXTTf7nvwdyScfOFcXf9Z1mr++OxAizEsg/fnpKaob5Uby+n1HO9X1Dro
         WSvTLrTspEGsf4Dj+NDcMcalHZf7cAdtje6Rn/N5TtcJP7ZsNiR9CeVZPsjJpf97tFkm
         ceaT23gSLS6dbbFREFWC72oozs+N404+w/83TPN6mEdkATlnZmstfxJ2KmPeTA3Odu30
         xV60FK+9ENGwmAc1CA09r2zTlSns6LrRZ9MNfL8BrMNz6FG64tpYqCBs500s+8B4dck3
         nhHg==
X-Gm-Message-State: AFq9FYLNAnnWQPU/NwiPiK/iRTQZDRy8f+FADOOQ35NPLxHjNulwHkap
	PGR2NAWMRo9LXClgpwqRoARbk53mQVqwd/e1kxxvyHrqmfSkKJGifVIV
X-Gm-Gg: AYBFou10sTKk5IAIH/AB0HK2PEVHPHsauhEhRRgjinyc5HxRVpZuYhtheP59+e2crbZ
	oddiymquPJWIVs93XdjDR0NcjoOTVOsb5mfAOua6GnHZBZHt3c0R4SWBM9Xh1X14owp8cEmXKW6
	o+TRgWiRpInVRgZI5v+gGF1MIL0WqxZFUko1JDJfdP3F/6RuATPbFXa6WD3xh0tPfpTCQihspY5
	/IlUoILTjwDpEXEmWXB9CpfqxQlYijeIX43w+OyVI1M7q7qUfTYYtL3cZoYmfWCrtiwszTjHCF9
	itFYPvFRiI88JrKAPQJ4jnm9lepAjn8nAGFrMbB5kwZ9ZNal5GNdJGIS2eGlrcyYAHrfYkDv9d4
	83uB2Db9WESoyFOn+0KJ4D85dGHQQIAvLRMUS/R+Rfu9GjOdSCSdLBvdfH8uyMo4dGR3chE1xtA
	FGlHU+ght07MbI8AXJqEIBHxIUlYyttmaHQ17YsQlBFDcssOtY7qF68qvd+yV8b2OFLgiSsrwRX
	HTWq3DVA3ziswm9ymropRDf9+iGh+YptiskLXwhyjMzoHFf9CZt9zmwb1xGL0kg7fpGFn0KlXKy
	cf4LXUEJm2VOq+jQ4ANKhFs2B3RsgQBgxFQzr9alFfh+m0Zb
X-Received: by 2002:a05:690e:4893:20b0:66e:5e37:2ff2 with SMTP id 956f58d0204a3-6790a0d5b89mr877402d50.4.1791384667246;
        Wed, 07 Oct 2026 07:51:07 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6791afa71ddsm163923d50.4.2026.10.07.07.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 07:51:05 -0700 (PDT)
Date: Wed, 07 Oct 2026 10:51:05 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Josef Bacik <josef@toxicpanda.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Kaiyuan Zhang <kaiyuanz@google.com>, 
 Mina Almasry <almasrymina@google.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, 
 Josef Bacik <josef@toxicpanda.com>
Message-ID: <willemdebruijn.kernel.fde28dd15d34@gmail.com>
In-Reply-To: <20261006-b4-skbuff-bug-on-v1-2-1b4434c5357c@toxicpanda.com>
References: <20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c@toxicpanda.com>
 <20261006-b4-skbuff-bug-on-v1-2-1b4434c5357c@toxicpanda.com>
Subject: Re: [PATCH net-next 2/9] net: skbuff: don't BUG() on bad arguments to
 pskb_expand_head()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Josef Bacik wrote:
> pskb_expand_head() BUG()s if it is handed a negative nhead or a shared
> skb.  Both are bugs in the caller, and both keep getting hit: commit
> 2cbb259ec4f8 ("bpf: Reject negative head_room in __bpf_skb_change_head")
> and commit 64e6a754d33d ("llc: do not use skb_get() before
> dev_queue_xmit()") each fixed a crash here that took down the whole box.
> 
> The function already returns an error that every caller has to handle,
> and at this point it hasn't touched the skb.  Warn once and return
> -EINVAL instead of crashing.  Anybody running with panic_on_warn, which
> includes syzbot, still stops right here.
> 
> Assisted-by: LLM
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> ---
>  net/core/skbuff.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index 512ff9cfa269..5d856948cef9 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -2303,9 +2303,11 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
>  	u8 *data;
>  	int i;
>  
> -	BUG_ON(nhead < 0);
> +	if (WARN_ON_ONCE(nhead < 0))
> +		return -EINVAL;

Another option besides WARN_ON_ONCE or even DEBUG_NET_WARN_ON_ONCE
when returning an error is a net_warn_ratelimited for such cases.

>  
> -	BUG_ON(skb_shared(skb));
> +	if (WARN_ON_ONCE(skb_shared(skb)))
> +		return -EINVAL;
>  
>  	skb_zcopy_downgrade_managed(skb);
>  
> 
> -- 
> 2.55.0
> 


