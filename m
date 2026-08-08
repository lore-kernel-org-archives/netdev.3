Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B922D314A73
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 19:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786218004; cv=none; b=h0VSIgQiI2sbIfllet2GFep3CfPcBCIFp8CWdoTN+VJ+Z5uR9Jjejs5BV2WW3DPiCB74IoOuZcEj0vTLEwl2DLKxTsaos2uc3oDLvumUnrmN9BmUpNBYjyB3wS1wfyh9qA9OysPMypChKDbDS5qg8fnCyCnUsElOYtpPsnohkqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786218004; c=relaxed/simple;
	bh=H5TMl5rNJ1IibifCOGtsMwmW/S7e8fp8V0L/BxCHanE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=I2YOYVfGzJJTpeyuGGH5aNXrhlIVIblOHHmxCAlXXqBu5a9ZEfqwoj/oeXxWrpGs1Ii/wq0Nx1EME9sQPqFyo5Ua1Z7+kucVmxFILzD89lVT5uSEzvqe56sJrRQyro7tu6fx8rvyGsYOXLrn9KSkxR6cxdJ4RMKI2GYSuve/igQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rW7CzWiM; arc=none smtp.client-ip=209.85.214.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rW7CzWiM"
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2cc5faecf01so14969515ad.1
        for <netdev@vger.kernel.org>; Sat, 08 Aug 2026 12:40:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786218002; x=1786822802; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XIStZjJg1C75vvBayYABRbCAeMqKZ7aNtHgRfMull94=;
        b=rW7CzWiMqtf4rxvwHiA7ggiluCQND5uagh0k/0MJLxWFjcxfN5bI1tX/vTjawEc8Ow
         IEGR/DJENihemF9FGPGoQJ55zwaIouQlvKFkJ0cyzn5LCXhnJ5XZ7EwZWrART7MDv8EL
         cBxQlPzBZiieLIwPWxGHwpnqYHeuRupZ+J8g1AJnInU3F97Hee8lEq+qHAlADKaofwC6
         iQgIx9tpFyZryvd7MJCmil8onWyotHlcty9VLU8e+g0xvm27ZL5nrjN4v6EV1pN1gnKK
         hpGRXPK4pr1A/KwsBDpQIoC/d6glVKzAN2JZwXlTy+BeyElNNN9N3DV8FCsTv5bKl2zD
         xFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786218002; x=1786822802;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XIStZjJg1C75vvBayYABRbCAeMqKZ7aNtHgRfMull94=;
        b=Kk5hQ7AZkcEbAJ1gSVdJfF0V1pZDBYzWFy/YSRACq5HLOmFa7I4Cc7XsRrMSE210+a
         G+Dy/hfqu4C5vu6lJ1EBVIrRYjGNPAanFUJPyzt2uJZxDg7hc0uebP96f6IJ0rX+2hss
         f3C8YTVBgv15GmSNUwyMyEPGQVVBiDDoki6nLzR4bMNpeexW/JVwswQW6JiuSalhprvY
         1DEQrUPW1vAUIIqbsu7WX+0VdF3FYb4jKdbp1RyxCoPteCxzFZ6bbO9LXxTXDE8ZofaH
         4uYbYIdvomM9fBGrcEBQlm6fI7J3lu1aMwq2hkjfJK3ZF4MhRLmsH9FxybOJod4VzKKF
         VEkw==
X-Forwarded-Encrypted: i=1; AHgh+RqO6mRYzIvOktECk/AdfQBJKQ4BUwEFv0kgmlaA1mXXlJ1+ao8kdati+bCJhaTypVbZVMYkvAQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw94/ETdy9stOt9uyozc+HxkiP3Fr5AxdW3P4irTQEyO1GbJ5cr
	ptrjJy33Zc8/LXAWD7uUYKtuwf0jEHGkHexImKq990rCB4Xr2M8uWBd4z2jalM/Jnz8PIXMvFNk
	otVqV1w==
X-Received: from plbkw14.prod.google.com ([2002:a17:902:f90e:b0:2cc:da2c:808b])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:ea12:b0:2ca:6eca:492f
 with SMTP id d9443c01a7336-2d0ca7fc8f3mr374679925ad.14.1786218001810; Sat, 08
 Aug 2026 12:40:01 -0700 (PDT)
Date: Sat,  8 Aug 2026 19:38:52 +0000
In-Reply-To: <b58876297f7d45de008f2e94b6ecab8b2ed84d21.1786088695.git.petalzu987@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <b58876297f7d45de008f2e94b6ecab8b2ed84d21.1786088695.git.petalzu987@gmail.com>
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260808194001.853434-1-kuniyu@google.com>
Subject: Re: [PATCH net v2 1/1] ip6_tunnel: snapshot encap in xmit
From: Kuniyuki Iwashima <kuniyu@google.com>
To: weir@nebusec.ai
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, idosch@nvidia.com, kuba@kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, petalzu987@gmail.com, tom@herbertland.com, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"

From: Ren Wei <weir@nebusec.ai>
Date: Sat,  8 Aug 2026 16:40:49 +0800
> From: Zixuan Chai <petalzu987@gmail.com>
> 
> ip6_tnl_changelink() can update encapsulation parameters while the
> netdevice is transmitting packets. ip6_tnl_xmit() can calculate packet
> headroom with t->encap_hlen and later build an encapsulation header from
> the live t->encap. A concurrent update can change the encapsulation
> header between these accesses and make skb_push() underflow the skb head.
> 
> Take a local snapshot of t->encap before calculating the encapsulation
> header length.

This intorduce per-skb cost in the fast path for unlikely changelink.

Right approach is to convert it to RCU pointer (and remove
synchronize_net() there).

0ba269933f73 geneve: convert config to RCU-protected pointer
777434f53e77 geneve: pass geneve_config pointer to helper functions


> Use that same snapshot for headroom accounting, metadata
> validation, and build_header(). This keeps all encapsulation decisions
> for an skb consistent even if changelink updates the live configuration.
> 
> Fixes: b3a27b519b22 ("ip6_tunnel: Add support for fou/gue encapsulation")
> Cc: stable@vger.kernel.org
> Reported-by: Vega <vega@nebusec.ai>
> Assisted-by: Codex:gpt-5.4
> Signed-off-by: Zixuan Chai <petalzu987@gmail.com>
> Signed-off-by: Ren Wei <weir@nebusec.ai>
> ---
>  include/net/ip6_tunnel.h | 10 +++++-----
>  net/ipv6/ip6_tunnel.c    | 21 ++++++++++++++++-----
>  2 files changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/include/net/ip6_tunnel.h b/include/net/ip6_tunnel.h
> index b99805ee2fd1..6e76e50a4406 100644
> --- a/include/net/ip6_tunnel.h
> +++ b/include/net/ip6_tunnel.h
> @@ -106,22 +106,22 @@ static inline int ip6_encap_hlen(struct ip_tunnel_encap *e)
>  	return hlen;
>  }
>  
> -static inline int ip6_tnl_encap(struct sk_buff *skb, struct ip6_tnl *t,
> +static inline int ip6_tnl_encap(struct sk_buff *skb, struct ip_tunnel_encap *e,
>  				u8 *protocol, struct flowi6 *fl6)
>  {
>  	const struct ip6_tnl_encap_ops *ops;
>  	int ret = -EINVAL;
>  
> -	if (t->encap.type == TUNNEL_ENCAP_NONE)
> +	if (e->type == TUNNEL_ENCAP_NONE)
>  		return 0;
>  
> -	if (t->encap.type >= MAX_IPTUN_ENCAP_OPS)
> +	if (e->type >= MAX_IPTUN_ENCAP_OPS)
>  		return -EINVAL;
>  
>  	rcu_read_lock();
> -	ops = rcu_dereference(ip6tun_encaps[t->encap.type]);
> +	ops = rcu_dereference(ip6tun_encaps[e->type]);
>  	if (likely(ops && ops->build_header))
> -		ret = ops->build_header(skb, &t->encap, protocol, fl6);
> +		ret = ops->build_header(skb, e, protocol, fl6);
>  	rcu_read_unlock();
>  
>  	return ret;
> diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
> index ebf83f090376..d47757e8a388 100644
> --- a/net/ipv6/ip6_tunnel.c
> +++ b/net/ipv6/ip6_tunnel.c
> @@ -1102,6 +1102,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
>  		 __u8 proto)
>  {
>  	struct ip6_tnl *t = netdev_priv(dev);
> +	struct ip_tunnel_encap ipencap;
>  	struct net *net = t->net;
>  	struct ipv6hdr *ipv6h;
>  	struct ipv6_tel_txoption opt;
> @@ -1109,10 +1110,11 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
>  	struct net_device *tdev;
>  	int err_count, mtu;
>  	unsigned int eth_hlen = t->dev->type == ARPHRD_ETHER ? ETH_HLEN : 0;
> -	unsigned int psh_hlen = sizeof(struct ipv6hdr) + t->encap_hlen;
> -	unsigned int max_headroom = psh_hlen;
> +	unsigned int max_headroom;
>  	__be16 payload_protocol;
>  	bool use_cache = false;
> +	unsigned int psh_hlen;
> +	int encap_hlen;
>  	u8 hop_limit;
>  	int err = -1;
>  
> @@ -1202,6 +1204,15 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
>  				     t->parms.name);
>  		goto tx_err_dst_release;
>  	}
> +
> +	/* Can tear, but hlen and build_header() use the same snapshot. */
> +	ipencap = data_race(t->encap);
> +	encap_hlen = ip6_encap_hlen(&ipencap);
> +	if (unlikely(encap_hlen < 0))
> +		goto tx_err_dst_release;
> +	psh_hlen = sizeof(struct ipv6hdr) + encap_hlen;
> +	max_headroom = psh_hlen;
> +
>  	mtu = dst6_mtu(dst) - eth_hlen - psh_hlen - t->tun_hlen;
>  	if (encap_limit >= 0) {
>  		max_headroom += 8;
> @@ -1251,7 +1262,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
>  	}
>  
>  	if (t->parms.collect_md) {
> -		if (t->encap.type != TUNNEL_ENCAP_NONE)
> +		if (ipencap.type != TUNNEL_ENCAP_NONE)
>  			goto tx_err_dst_release;
>  	} else {
>  		if (use_cache && ndst)
> @@ -1272,10 +1283,10 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
>  	 * needed_headroom if necessary.
>  	 */
>  	max_headroom = LL_RESERVED_SPACE(tdev) + sizeof(struct ipv6hdr)
> -			+ dst->header_len + t->hlen;
> +			+ dst->header_len + t->tun_hlen + encap_hlen;
>  	ip_tunnel_adj_headroom(dev, max_headroom);
>  
> -	err = ip6_tnl_encap(skb, t, &proto, fl6);
> +	err = ip6_tnl_encap(skb, &ipencap, &proto, fl6);
>  	if (err)
>  		return err;
>  
> -- 
> 2.34.1
