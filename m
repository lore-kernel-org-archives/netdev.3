Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCA6F507;
	Tue, 10 Mar 2026 16:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773161442; cv=none; b=jeD0SdVYo0Bu+NMMgsxAjxNSAwK99+qp6D2L5ASd6oK4BAsr6oAD5B7bPiqwNz/sV4PjxtOYhN1vH9Q6Nvp9ILV9W0b4VdpVMWO0vUyBKWuU8hGWQiLPg46Z+2JBTlbsXR+RVS/szUUk3AeQqJeYT7SM0XeESqB0kc7Py4X1bOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773161442; c=relaxed/simple;
	bh=bQ7522YAjfcokDg565/B1onBtKzhJnol+L61sKpUeHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UMg2PJgUvYhALwF43E/KQ9DIHmWReiC6E4e0Duy4wJpCvcC3b9I1a1+2T5itbYJMHWiReKs8t9EZGOJErvv6jijBtHRDld502EkSfVZoar/0x+3SW4AtA1MSO6UmwFCZu2bedpuSwucaxqVYoa0QLrlDYyjIMFGhSBoF1lp/VN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GkeOLw54; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GkeOLw54"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0465DC19423;
	Tue, 10 Mar 2026 16:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773161442;
	bh=bQ7522YAjfcokDg565/B1onBtKzhJnol+L61sKpUeHE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=GkeOLw54ydgodijZWQyBdWuQsu3FzcHlI5YpskizEOFVYYkZKVnpvgu8SgFXohAZh
	 9fOY6hrLV3IJ8dzcSpNio9nHMvQEZotbcDJ4p6DewMcYGDpTU3jc6VzERg6i6QUdWQ
	 hqs1dS3jCx8ZusCZCenTrNVYyF7i43J2vsEBaM9Z7GYbLREOwKtJ7e8+/KIcAcOqQg
	 EXTpiLX80/NjqvA/LsdhEf0TZqAK4Av6+u0hHAU2Zk+rbOZwUm1FGmE+nYY080lN2I
	 KH4AguRhRlnYP7I1a7/M8+KDfX4QnhJqsIcYvU3f2+f1c/g+STmlb7aBhCfXtx8mDz
	 RtPmmyEQmdEoA==
Message-ID: <04a9571f-55d7-466a-bfcc-161f8347ef92@kernel.org>
Date: Tue, 10 Mar 2026 10:50:41 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/10 net-next v2] ipv6: prepare headers for ipv6_stub
 removal
Content-Language: en-US
To: Fernando Fernandez Mancera <fmancera@suse.de>, netdev@vger.kernel.org
Cc: rbm@suse.com, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260310153506.5181-1-fmancera@suse.de>
 <20260310153506.5181-5-fmancera@suse.de>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20260310153506.5181-5-fmancera@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/10/26 9:34 AM, Fernando Fernandez Mancera wrote:
> diff --git a/include/net/ip6_fib.h b/include/net/ip6_fib.h
> index 39c98c3d8ac5..62a1e96bbdd4 100644
> --- a/include/net/ip6_fib.h
> +++ b/include/net/ip6_fib.h
> @@ -486,11 +486,29 @@ void rt6_get_prefsrc(const struct rt6_info *rt, struct in6_addr *addr)
>  	rcu_read_unlock();
>  }
>  
> +#if IS_ENABLED(CONFIG_IPV6)
>  int fib6_nh_init(struct net *net, struct fib6_nh *fib6_nh,
>  		 struct fib6_config *cfg, gfp_t gfp_flags,
>  		 struct netlink_ext_ack *extack);
>  void fib6_nh_release(struct fib6_nh *fib6_nh);
>  void fib6_nh_release_dsts(struct fib6_nh *fib6_nh);
> +#else
> +static inline int fib6_nh_init(struct net *net, struct fib6_nh *fib6_nh,
> +			       struct fib6_config *cfg, gfp_t gfp_flags,
> +			       struct netlink_ext_ack *extack)
> +{

NL_SET_ERR_MSG(extack, "IPv6 support not enabled in kernel");

let's keep the helpful, user facing message

> +	return -EAFNOSUPPORT;
> +}
> +
> +static inline void fib6_nh_release(struct fib6_nh *fib6_nh)
> +{
> +}
> +
> +static inline void fib6_nh_release_dsts(struct fib6_nh *fib6_nh)
> +{
> +}
> +#endif
> +
>  
>  int call_fib6_entry_notifiers(struct net *net,
>  			      enum fib_event_type event_type,

