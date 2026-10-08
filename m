Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20BD844E045
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 08:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791448206; cv=none; b=DOE2EdLf7enmNlnwU/D7xUbGqlif8KLrsnZN0/17T71u5+m4V0s6OO+krofvNGLwhJuXJZjhow8jSbLwyNbal1cYsJif1zme0BAiQ9xUWGjBMeBTAdKowJQLvZb9QUsm/Mgb8VBOXrlGdmkKAlr8W2cLjGF5tn6/69a5DYcUynw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791448206; c=relaxed/simple;
	bh=CvyAdXyi6xGDl736hpXlyaXN7OAQj1NiCSx0Yb1chNk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=shSJ/fdB6VX4YbTLSBHpsAlrGcuPlT4Hx0pX6XxJsAz/jCLmvD25E0NHEgI7Kddd+huMHcgncKfKPZsIXBBQT8xgaaUz/CKzCIiklY6nE8lAvZJdEROHBNvizXD2yOaUPHQR2tqj6LzDRLOxXoDevEhB4Rbm2hSFY6XULjv3rVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZuDzrxFz; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZuDzrxFz"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-8198a3a54d7so418399a34.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 01:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791448204; x=1792053004; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=x4YRBpZsbtDLH5v5QWzQXmBnOWEn6u15OsNxyb3RC5M=;
        b=ZuDzrxFzjtufOZL/Ul2k0Ae/mFbPQEw0yRBz2OtbMrghZOC5yvaY9Q4ViCBeqw6M3W
         aYS3LwWkC8YJerhdGqqMQzv4PakHOfeSjnWyso+2iNm/nzRWHmr/KK5YvuQzvTbmEU0E
         gixS7UB8B1uROnJjvkI6T5xywvcYjF8JAplM6LmcLsQvJEP8bAzA8jOeTwJK255LegLQ
         sJRXZ/9uutWw8ZF2k0mIEzSHwqqgaBymc59to3b5Gbw/qKTyEVgh2I2yosBEuIe4lRBO
         ZMhb6ronOCgqrCedTUAEFUUNdwUhZRk8/Ggq5wwxWQJGBWcbRmRJamG0oSJyssBZUvVH
         eD5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791448204; x=1792053004;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x4YRBpZsbtDLH5v5QWzQXmBnOWEn6u15OsNxyb3RC5M=;
        b=NCK1UvN6CWanq/AnAStUVnT8LKd863OrQ7mzYamREKVJ3bPKDvqF1N/rEA7BsTtvg8
         0mdkJGxwNPMS5PThteSXZP8Gf1gPADohD7hDgfxmtMQ4ayoTAgAfVy0+YikHCwZUHYAz
         AsS1QABxuq3z7UV+A1cx08xsn5SRSuwSmXlvq9UD7YQ5Mw8bWi7ivY24WrsJWZEClXid
         meoF9zVYw7vfsajC0av6I796oTTEoubWXcgunlCMGCAiNEq6jvQBhxoUMCGenUtkMnqZ
         j4jaqYsoY2HaAxEqlSxKCp9bM+ShPqRBuKFkyx7JPH424HMuuCPeDeVT2i/uzBwaI0F1
         R++w==
X-Forwarded-Encrypted: i=1; AKwUvByIOOqUQcf/TX+v8FsdKUtOq7+Oze7oeSYJjsKZ9gStJM5lJOdFvXU/9s90Cnh7uBa3Z83WH8E=@vger.kernel.org
X-Gm-Message-State: AFuF++lFBRcZLkdVoUPoGkYOqINzNzMVmCVTfWH3wwJjyx1157GnUdRx
	WzN5WsLLaaGsk8t0L7JrJh5ghZrmnzFFrr7k/jC+KkR4QSU1b2/MZAJV
X-Gm-Gg: AYBFou1M/a2+91STOlfR7K19yHAa0xHl13HB5u9VaK+YTLxc6NBBVcpWcna6XpRjQcg
	HlxWHHj8e5AnIYfW4zZXo8qNjrIn+lXQHJSZKmeDcB6XIUVs79VAYuJgu4x8fbSrFnoZ8f4ZlVx
	CUJrLUa4yn01oYG86nHYdKcG6hjwkEq3mY8pdk2g3J0f64SqyjsqQ/77/k8J2/8Ym+5/T3ZwxR/
	6r/PyYQBwExx5lgtfOgpje8GLVyIIUa8KJZ3pQlv/0IYnsHzEdfPFigUehFbkI586ZnWVlVp730
	/2RCvq/DI7AlIVhhyWWSdk8Smc+ox0IMacFgytPpiMtKtmDnrEpcEa84BDFe6DD8+1uu7jbL3MG
	GPeaaRPdd8V7rLN6AKrJ34e2oGzOkQYP6BvxSqjbVJ4ylps84V+YDXtxi+f+PNMBY5RY6UfDpB0
	ledpVSLFuBEHjO33BwxN+qQUFu6tg+PKjn8ik06DvUB0pWBr15ICBocFPLGVFTQcIY5eeaD1Boi
	RBlmkxNdX6IVouc7CC0
X-Received: by 2002:a05:6808:f93:b0:4b8:46e3:e223 with SMTP id 5614622812f47-504ab40d32cmr1090276b6e.15.1791448203704;
        Thu, 08 Oct 2026 01:30:03 -0700 (PDT)
Received: from devvm29614.prn0.facebook.com ([2a03:2880:ff:4b::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4fc4627177esm4877103b6e.1.2026.10.08.01.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 01:30:02 -0700 (PDT)
Date: Thu, 8 Oct 2026 01:29:59 -0700
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Stanislav Fomichev <sdf@fomichev.me>, Paolo Abeni <pabeni@redhat.com>,
	Kaiyuan Zhang <kaiyuanz@google.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Ralf Lici <ralf@mandelbit.com>
Subject: Re: [PATCH net v1] net: devmem: prevent mixing fragments from
 different bindings
Message-ID: <asdUh6wyCmvCJ9uw@devvm29614.prn0.facebook.com>
References: <20261008033952.1399670-1-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008033952.1399670-1-almasrymina@google.com>

On Thu, Oct 08, 2026 at 03:39:26AM +0000, Mina Almasry wrote:
> validate_xmit_unreadable_skb() only inspects shinfo->frags[0] and
> assumes all fragments in an unreadable skb belong to that same devmem
> binding. However, tcp_sendmsg_locked() only checks that readability
> matches the presence of a binding (skb_frags_readable(skb) != !binding),
> allowing consecutive sendmsg() calls with different dmabuf bindings to
> collapse into the same skb and bypass per-device and unbind checks in
> validate_xmit_unreadable_skb().
> 
> Add net_devmem_skb_binding() to query the binding associated with an
> skb, reuse it in validate_xmit_unreadable_skb(), and check in
> zerocopy_fill_skb_from_devmem() that existing fragments match the target
> binding.
> 
> Fixes: bd61848900bff ("net: devmem: Implement TX path")
> Cc: Pavel Begunkov <asml.silence@gmail.com>
> Cc: Stanislav Fomichev <sdf@fomichev.me>
> Cc: Bobby Eshleman <bobbyeshleman@meta.com>
> Signed-off-by: Mina Almasry <almasrymina@google.com>
> ---
>  net/core/datagram.c |  2 +-
>  net/core/dev.c      | 14 ++++----------
>  net/core/devmem.h   | 23 +++++++++++++++++++++++
>  3 files changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/net/core/datagram.c b/net/core/datagram.c
> index 173b5d97bd409..ed8f1045f3cca 100644
> --- a/net/core/datagram.c
> +++ b/net/core/datagram.c
> @@ -712,7 +712,7 @@ zerocopy_fill_skb_from_devmem(struct sk_buff *skb, struct iov_iter *from,
>  	size_t virt_addr, size, off;
>  	struct net_iov *niov;
>  
> -	if (i && skb_frags_readable(skb))
> +	if (i && net_devmem_skb_binding(skb) != binding)
>  		return -EFAULT;
>  
>  	/* Devmem filling works by taking an IOVEC from the user where the
> diff --git a/net/core/dev.c b/net/core/dev.c
> index e76762e29360e..ad2b587dfee27 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4054,8 +4054,7 @@ static struct sk_buff *sk_validate_xmit_skb(struct sk_buff *skb,
>  static struct sk_buff *validate_xmit_unreadable_skb(struct sk_buff *skb,
>  						    struct net_device *dev)
>  {
> -	struct skb_shared_info *shinfo;
> -	struct net_iov *niov;
> +	struct net_devmem_dmabuf_binding *binding;
>  
>  	if (likely(skb_frags_readable(skb) ||
>  		   dev->netmem_tx == NETMEM_TX_NO_DMA))
> @@ -4064,14 +4063,9 @@ static struct sk_buff *validate_xmit_unreadable_skb(struct sk_buff *skb,
>  	if (dev->netmem_tx == NETMEM_TX_NONE)
>  		goto out_free;
>  
> -	shinfo = skb_shinfo(skb);
> -
> -	if (shinfo->nr_frags > 0) {
> -		niov = netmem_to_net_iov(skb_frag_netmem(&shinfo->frags[0]));
> -		if (net_is_devmem_iov(niov) &&
> -		    READ_ONCE(net_devmem_iov_binding(niov)->dev) != dev)
> -			goto out_free;
> -	}
> +	binding = net_devmem_skb_binding(skb);
> +	if (binding && READ_ONCE(binding->dev) != dev)
> +		goto out_free;
>  
>  out:
>  	return skb;
> diff --git a/net/core/devmem.h b/net/core/devmem.h
> index 4a293a7d1149c..8c74037633ae8 100644
> --- a/net/core/devmem.h
> +++ b/net/core/devmem.h
> @@ -10,6 +10,7 @@
>  #ifndef _NET_DEVMEM_H
>  #define _NET_DEVMEM_H
>  
> +#include <linux/skbuff.h>
>  #include <net/netmem.h>
>  #include <net/netdev_netlink.h>
>  
> @@ -118,6 +119,22 @@ net_devmem_iov_binding(const struct net_iov *niov)
>  	return net_devmem_iov_to_chunk_owner(niov)->binding;
>  }
>  
> +static inline struct net_devmem_dmabuf_binding *
> +net_devmem_skb_binding(const struct sk_buff *skb)
> +{
> +	const struct skb_shared_info *shinfo = skb_shinfo(skb);
> +	const struct net_iov *niov;
> +
> +	if (skb_frags_readable(skb) || !shinfo->nr_frags)
> +		return NULL;
> +
> +	niov = skb_frag_net_iov(&shinfo->frags[0]);
> +	if (!niov || !net_is_devmem_iov(niov))
> +		return NULL;
> +
> +	return net_devmem_iov_binding(niov);
> +}
> +
>  static inline u32 net_devmem_iov_binding_id(const struct net_iov *niov)
>  {
>  	return net_devmem_iov_binding(niov)->id;
> @@ -243,6 +260,12 @@ net_devmem_iov_binding(const struct net_iov *niov)
>  {
>  	return NULL;
>  }
> +
> +static inline struct net_devmem_dmabuf_binding *
> +net_devmem_skb_binding(const struct sk_buff *skb)
> +{
> +	return NULL;
> +}
>  #endif
>  
>  #endif /* _NET_DEVMEM_H */
> 
> base-commit: 6d25ffca055a77787c21a36b66c253f76239411b
> -- 
> 2.56.0.385.gd3acb90ef8-goog
> 

Makes sense to me. Thanks.

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
