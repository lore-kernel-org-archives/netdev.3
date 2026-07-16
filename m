Received: from mail-pj2-f0.google.com (mail-pj2-f0.google.com [74.125.227.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A552412264
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 12:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784203897; cv=none; b=cIUe5v5425dx9g+apWHv50Ix5pB4F2/+ZFSKd0sK7+YENds9iksosqbSJrAuQz+Nxc0AJHDKH3jnZ5Kz16eYnycl2O72E3TwG8dFTuaiq41F+f3EULHWhAEuxgJ8/AD+bSPXMjzaxk9s6ISknrmOXlRahhKKr/NC9fN/bl6WacA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784203897; c=relaxed/simple;
	bh=f4ymZDRnM/pw2VyZ1qu8vLFhL7O6J9NcYCmD2FxFklc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tcwbSvd31ZavKvk2ZLXIIOuqcpxbvSH/wqas6xKJPY5kL7GsGnTX7ArR930hZKsvZdd2kmv4+crydbw3oYaJrSkBOSSKZrt32ETKQeA6NEBSnTsQqPIynA0Q7SnIBFE8zWubvysOCh0wDgeOFn/RK+xoQNd64mHZ2APzz6FF6Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lUjHL2SR; arc=none smtp.client-ip=74.125.227.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lUjHL2SR"
Received: by mail-pj2-f0.google.com with SMTP id d9443c01a7336-2cc7a345f51so42391565ad.0
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 05:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784203896; x=1784808696; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G03SpxBcPbiMEuaQ6fjP36nhBHuuXkxtx53kuYQhpfE=;
        b=lUjHL2SRpkAruFw6Y6T9UbM63Jp4clqBBo/TSQgT7ZiTye/Q70Om7BleTRY3pk7FCW
         9BGrAp7mO6Qf5rrfxlu1gEx13S9N2TCZMxA4PTPZqI6ritGU8NAjQr+4dFoFs3esaFQy
         oJOMthyh+Mn3cZ7/ZuoYE5IkplCj0pY0/O+wfBiZdh5ZPmrhe80rwB+QyNQ6FU2xJZ5Y
         HR6eFQWSvn1K4EKcY1lI+mxCYGMkj6LbFQjeE/nRnvYOPkjmCt/o1vFRJd9qqyp3q1SN
         GX56nIcQ/+QWxefy591uLeibSxonzgXkfD0pTdlB0hRK5JVFHklG4q1tJJwLYvgH6P2F
         u3LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784203896; x=1784808696;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G03SpxBcPbiMEuaQ6fjP36nhBHuuXkxtx53kuYQhpfE=;
        b=Ft3aYvDkZuNrXTJSb38Mryr7hOV42kkLLwsDZun70vI5+T0pId4FjN3VWwyVbOxqex
         3EFKUCfPV9u7uyFncW4LZ3TJZrW7diL5W4uH3AQ4NkwogOOqN0LT4U+AkkoCoQdUDB0A
         JSM45o5B4YQYQC8NLnHSJcxbiLu7jl32hVj0uMeGjlw7lyov69fnQXkGewZ+BpcNHxvV
         MHKSDOmte4KIigfC0lI7lXN2ejzWhWopOYNlM6MQFrPYgcaQbS7kxld+DKk1kWhiiKz9
         7XBf3lBhmlny6l7tRZ4kLsKDLok5GfLOf2nK/8wEsI7IHeSvOJ3o7UbET9DG/AerB/RR
         LzYQ==
X-Gm-Message-State: AOJu0YxXBA4Rs0FwEztdBI5MR5a/MAUH/vD5cboykvsYau1Ah1iWgFUy
	pjCp9pnGfTp3Li2Nbbxkj32s+0ifg22qjbcMAEanBng4NYtzZUOu3qW8
X-Gm-Gg: AfdE7cnyFbPLAinsCgbcBQzX3XpZQhVgSUb1cSQHoC2eMr39PEzEE4k7voyq3pl2Lho
	b9sooq5ZByXAgUYEIBJtq6fMBr5hXFCaBXQvlz4AdgFYjEj02EaMmXrON+IZJwnSe4RpFutXsOT
	JVt2zhDSe2iULZyQYFNGKXnrnuHcwJf8qdekzfdz3b+JyWnHhySh3QK+WkYv3RlxKDFhxhIR6ds
	BXB+M2kx+oBEKiFnbrtnAtxT7TPE50QGtqOpVeHXhqZ4obxwDcpsij8Ss7YYrLm/0wUnsPo4RnT
	aFqQcmtcwo9sEhb/iINOL0nKoOxKiq/NuTNWTqTET5+ErTgZBOclgc1MlMgWEqly1gg9yFUGD84
	jEqbG44Nxgqv+z3jbt7q5XM44d1ZOnA87ELeaTvLe4RR8ck2W/xvLEcEVDMH2NXVLkbEUoZ8=
X-Received: by 2002:a17:902:da81:b0:2ca:e19c:986 with SMTP id d9443c01a7336-2cf03c7c756mr62714505ad.1.1784203895554;
        Thu, 16 Jul 2026 05:11:35 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:46::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cf106b271asm19005705ad.64.2026.07.16.05.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 05:11:35 -0700 (PDT)
Date: Thu, 16 Jul 2026 05:10:12 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Jakub Sitnicki <jakub@cloudflare.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, 
	kernel-team@cloudflare.com
Subject: Re: [PATCH RFC net-next 1/6] bpf: Introduce per-packet metadata
 storage for BPF programs
Message-ID: <aljJ1u-_1CBBF8Ha@devvm7509.cco0.facebook.com>
References: <20260714-bpf-meta-inside-skb-ext-v1-0-5871c07a8dd6@cloudflare.com>
 <20260714-bpf-meta-inside-skb-ext-v1-1-5871c07a8dd6@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260714-bpf-meta-inside-skb-ext-v1-1-5871c07a8dd6@cloudflare.com>

On 07/14, Jakub Sitnicki wrote:
> BPF programs attached at different points in the network stack have no way
> to pass data between each other on a per-packet basis, other than by
> stashing it into a shared BPF map. xdp/skb->data_meta works for XDP-to-TC
> handoff, but is not available to programs running at later hooks like
> cgroup/skb, sock_ops, socket filters, tracing or LSM.
> 
> Add a new skb extension (struct bpf_skb_ext) that provides up to 256 bytes
> of per-packet storage. Size is configurable at build time though the
> CONFIG_BPF_SKB_EXT_SIZE option. The storage is embedded inside the
> extension chunk itself.
> 
> Expose the storage to BPF programs via bpf_dynptr_from_skb_ext() kfunc.
> The caller passes BPF_SKB_EXT_F_CREATE to allocate or COW (unshare) the
> extension and get a read-write dynptr. Without the flag, it gets a
> read-only dynptr to the existing extension, or -ENOENT if none exists.
> 
> Guard the feature behind a new CONFIG_BPF_SKB_EXT option.
> 
> Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
> ---
>  include/linux/bpf.h      |  10 ++++
>  include/linux/filter.h   |  26 ++++++++++
>  include/linux/skbuff.h   |   3 ++
>  include/uapi/linux/bpf.h |   5 ++
>  kernel/bpf/helpers.c     |   7 +++
>  kernel/bpf/log.c         |   2 +
>  kernel/bpf/verifier.c    |  10 +++-
>  net/Kconfig              |  20 ++++++++
>  net/core/filter.c        | 129 +++++++++++++++++++++++++++++++++++++++++++++++
>  net/core/skbuff.c        |   3 ++
>  10 files changed, 214 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 7719f6528445..6b918a5b61bf 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -1484,6 +1484,8 @@ enum bpf_dynptr_type {
>  	BPF_DYNPTR_TYPE_SKB_META,
>  	/* Underlying data is a file */
>  	BPF_DYNPTR_TYPE_FILE,
> +	/* Underlying data is a bpf_skb_ext chunk */
> +	BPF_DYNPTR_TYPE_SKB_EXT,
>  };
>  
>  int bpf_dynptr_check_size(u64 size);
> @@ -4209,4 +4211,12 @@ static inline int bpf_map_check_op_flags(struct bpf_map *map, u64 flags, u64 all
>  	return 0;
>  }
>  
> +#ifdef CONFIG_BPF_SKB_EXT
> +
> +struct bpf_skb_ext {
> +	u8 buf[CONFIG_BPF_SKB_EXT_SIZE] __aligned(8);
> +};

Can we do a dynamic size from the start? Say, some sysfs knob, 0 by
default. Once written, it's locks in the size and can't be changed.
Then your new 'flags' field can be used to indicate whether the area
actually has been allocated or not?
