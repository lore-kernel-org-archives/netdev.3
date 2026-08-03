Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64569422556
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 17:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785778291; cv=none; b=sU/RERFTYYOIgYqk5GAw7EVaddmLW5BEv3oEW1f4XlmsK/R/3Z60+FIpICNcBFEM67xpVByIWznjlOLgMIvk/ynWA9BFw/KpbMRVtca9Jm2WA7qTNAeuz7cP5xChkq94kG+mhNHNjqEZC9lY5F7wixiepjYFXJz58S8LSnJIZ2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785778291; c=relaxed/simple;
	bh=nOYn7MVrQyEqYQuY3HEiJOL/+6QE4067SYH3qGnMK18=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QaEfFZ6nNG5bJKG31/agb4flCQv4CUxvcmGpzUnagx+2uT+/D4GhTthNxK2YD/EtPnHUx8aM6lT9uk22GWvTVH3HXNUR6dqvhau2A+WbaZw3udlhZ6LQC+UKLN149nJrANMBUaxS6WUJv8aPyCNKO3KW0/22+JIt0Y8Ri7eJiR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HNuG21t6; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HNuG21t6"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3811f512167so3702070a91.3
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 10:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785778289; x=1786383089; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=j9OjV+Lqch3JMwIprxU5IrNouLbRYrePVo35uLIcpPE=;
        b=HNuG21t6a84o/3ztXpD5lmOtQwzPTPDF6mDLZGwUP93Nk2OS5cRQfMF+AX6tDYAoOt
         JiiLv1C3bIv8wFwsHcp9QAJvJBn8QAZ0myL1naeyohsVZyGTcgaG/l+QMIuLziudqunq
         7zM5Er3//eg+bH13KftzPZ2DYEKK6BuTAk2HjhZM/sm/vreez9zxuN7sgvplycop5UnW
         L48NxDArMVrgArQaeNbHKjvtyrJtwbJL0XLLFbnxiWx717JCjpvEKl4B12zH2DDyNo9P
         GWkp21t/WYpNeg9bx13f4FIPhVKRjbEDoPom5h4OtqUTmLKO/eRIzrkgcFzeuLfcbUVs
         fmaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785778289; x=1786383089;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j9OjV+Lqch3JMwIprxU5IrNouLbRYrePVo35uLIcpPE=;
        b=cHE2UsVWzLEsRV8JRsFIZkOYUGjBUKVi+OCPXbWUsJzo4MksXOIucgNagBj80WBqur
         7pKnxt5xb2KvKBh+CzSsQ13mkRWnvUQgkE6FJd29KdtmINzF5cdgZYxsvEjViZTovEor
         WHLBHjPV6v/4k6VRkzRZ4luNS4zA9bXO/Knv3ymU+gZ6xF/XgBfbHFVyjbGfskpPgdDm
         O8XgPR1rF4ymacb3y+0UEFimZIiwnvATRlC10alyfKIXbXy5UgJHI5E7ER+0CdrjNIsX
         qsK52IEilXefXQR+js6IIbcisCczJWrvcLq4l/XsfxRCnyvHQ3hb0RO8PBVm33WooXBX
         Ldkw==
X-Gm-Message-State: AOJu0Yx3uaH+Il7LEmfh07noauOm5r8lUOQWTvgsg4EOkW8fGiNYY9v7
	/ImIjaoU5sTqEdRHaykYcvxJMxJ9L/JOAa7DSv3RsfzPSt76Qi27SE0t
X-Gm-Gg: AR+sD10yqrlvyAjg/kOfhKBtg4Zk1AdWJJufUmsCLlBo2Qh6P6rpYGiqoO0OuHQP2Xy
	myndjitJLPHvb0+AXhmC+gbDD2usV1Tgo8GwbAihjOnacpfUqUzgIPUxu9W555aSF0gsJQljKrJ
	vowXmf6WMg/OhVh7ckcaui9t/eXb0HBTVu/+KCTd5tPVurNkXGTbgahPtqpLIr3Bn/rLFbGA1Y7
	XiesHNWLOx6mTIBlb9YXC9IhqQ1PExwQv15MSnkFui+aPKrmIhdDE0Oj7M6k1vjpv3ddnhuBuDG
	/oH+G2yuBGBUfeyjxs6kk5zhnvVpcqvEPF8yqlyce7DLUpcoS7TNX7+Xj9Nu8c9EzMF1xmmf/BR
	FitC0z5lBRYRyVLE4LGHifcSx7nDHiLlAkti5wwkC3G2J1Xz0mxhVb1miWbV9afiudnoCuoPuSo
	hpKZ4fZJN6LU0EkjEqHCGZdzM84RE0MeVrO1KuO3f+oukZlLvZiKWwSoYKn67PI3I+uEZ1CJGMn
	nAfESAl
X-Received: by 2002:a17:90b:5823:b0:38e:740f:9764 with SMTP id 98e67ed59e1d1-38fbc49eadbmr9764738a91.18.1785778288557;
        Mon, 03 Aug 2026 10:31:28 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:2::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38fec18dc78sm117169a91.16.2026.08.03.10.31.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 10:31:28 -0700 (PDT)
Date: Mon, 3 Aug 2026 10:31:25 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, horms@kernel.org, kerneljasonxing@gmail.com,
	kuniyu@google.com, bjorn@kernel.org, jiayuan.chen@linux.dev,
	kaiyuanz@google.com, willemb@google.com, asml.silence@gmail.com,
	sdf@fomichev.me, fw@strlen.de, Neal Cardwell <ncardwell@google.com>,
	Ralf Lici <ralf@mandelbit.com>, Will Deacon <will@kernel.org>
Subject: Re: [PATCH net v2 1/3] net: core: propagate unreadable flag in
 skb_zerocopy
Message-ID: <anDQbSNYlbzyQwOH@devvm29614.prn0.facebook.com>
References: <20260803171441.408014-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260803171441.408014-1-almasrymina@google.com>

On Mon, Aug 03, 2026 at 05:14:39PM +0000, Mina Almasry wrote:
> When skb_zerocopy() copies devmem payload fragments, it fails to update
> the target skb's unreadable flag. This causes the target to appear as
> readable memory.
> 
> Propagate the unreadable flag if any devmem fragments were copied from
> the source.
> 
> Additionally, to prevent memory corruption, explicitly return -EFAULT
> if standard payload from the head is mixed into the same skb alongside
> unreadable devmem fragments during a head-to-frag extraction.
> 
> Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
> Cc: Pavel Begunkov <asml.silence@gmail.com>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Bobby Eshleman <bobbyeshleman@gmail.com>
> Cc: Florian Westphal <fw@strlen.de>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
> 
> ---
> v2:
> - Return -EFAULT when mixing head-to-frag unreadable/readable frags to prevent memory corruption (Pavel).
> v1: https://lore.kernel.org/r/20260801125308.1342897-1-almasrymina@google.com
> ---
>  net/core/skbuff.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index ba3dbac80fb49..8bacc6c4e16e1 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -3905,6 +3905,9 @@ skb_zerocopy(struct sk_buff *to, struct sk_buff *from, int len, int hlen)
>  		}
>  	}
>  
> +	if (!skb_frags_readable(from) && j > 0 && len)
> +		return -EFAULT;
> +
>  	skb_len_add(to, len + plen);
>  
>  	if (unlikely(skb_orphan_frags(from, GFP_ATOMIC))) {
> @@ -3928,6 +3931,9 @@ skb_zerocopy(struct sk_buff *to, struct sk_buff *from, int len, int hlen)
>  	}
>  	skb_shinfo(to)->nr_frags = j;
>  
> +	if (i > 0 && from->unreadable)
> +		to->unreadable = 1;
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(skb_zerocopy);
> 
> base-commit: af39eb111ce6b5eba9c08513b62c4868eb7e7fd5
> -- 
> 2.55.0.571.g244d577d93-goog
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
