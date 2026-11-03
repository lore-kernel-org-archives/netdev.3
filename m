Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793747009;
	b=PeyLdf23vtpWuB4j0oti4ULUMTuRFyKOtw0+x19FBMKZTSUZvofvUw+qD87nDD/NB2Q/
	 ZTL/TTGNJQ27W2RvZQnv19BD2qyco1vEq4nvLbGTfgN/u2Sz0Y90oGShizm6apKiejsQ1
	 CFPlnR8XZ5+2bzeDur4q0HhiuGIFoz+9+asNohmA88TSMnEO+zoXtmV0uMeMLpJ+vrE4o
	 uf/i/BxntlKCvfZr+VuIw5pMSQKjmv969iYQFi81ZPHJHxfd9DiA31tgy52PAwokOx01r
	 zbgWMkWLMauWm/gQG+ClgcJqt8FkfAGHQjpiYZc1z8ITr2shyCLlqAxX8G7WrAj3Keg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793747009;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=Bc3q5OMwODprZ3tRrHE2dAObJscCTN7oqVxqSs9CQE0=;
	b=4T0Od5zI1VWaZnush8wX3l6OzPOhdu9FjcadvxWX+bdMKhFR60JrLXZWYBXDs38Yn8Ds
	 csKXkrTn930gWo0UMIoX/aaImAirT1CwYSDPt7ZeJmpPsfJMZO9+DQvLWbXGjmMnGuXa7
	 cl+qT08dVWXpCdr8PuoFBeAwsFaRWbV2NL8e+x7kD+iLgKkhf4ZskRZ+je+Lak/+QDoJk
	 G701tFB+sQZL8fYKXlb7uM0nQ5XPnLQhp226iC8HCukze9VJciWGYf0xw7YzgF8IfaMVH
	 BimGHtr581fvAAWwtwKoDdOjuyhEQRL5x7Pa9FILqjLuKAU5nendhnvp8yDgHgyE9eA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dama.to;
	spf=none smtp.mailfrom=dama.to;
	dkim=pass header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=kpwSVOrl;
	arc=none smtp.remote-ip=209.85.214.178
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D686606A32F
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 23:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D686606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=kpwSVOrl
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2e987a2ba0cso271915ad.3
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 15:03:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20260707.gappssmtp.com; s=20260707; t=1793747008; x=1794351808; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Bc3q5OMwODprZ3tRrHE2dAObJscCTN7oqVxqSs9CQE0=;
        b=kpwSVOrlE5nr+/Gbvw2ZwoGd5KDAngbKsPFGSFjG5uZDqDrVI+gLbg5Ff495N25ok1
         /MWhAAh4jBKMFUNyKUGu2YzW9+2b0TL8VX03ypiXw4ssVIJKJ8NdQIdG9nN2L86viunP
         0GQeIke56pCMcajWzsKXoEzb3qyZLHuNRs26ySYLuk5afWNHqc2hxHe5Kj87hslle2R9
         0HqfFeDQeQaCcAimFol3FR5VaxoRVhOlwEu6ZJ0LDsrXDvONJ+G5lXTb5IuudPJXXsHu
         iX2D7vhnsn0beYOgAG84IpsrPPkPEpqzt74z1aG7nR8CPk+sBemoQJWqRSQwhJAJ/2x4
         soxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793747008; x=1794351808;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=Bc3q5OMwODprZ3tRrHE2dAObJscCTN7oqVxqSs9CQE0=;
        b=pVgoLu8WAdermZMTnQAdaQjygWCqA5UP+KsybE/rtx/JGjhQxLfpkOV+zmlSAtd/Io
         kEf0bUiDLJ3AKeAlA8rRRX8ZeI0cxRIPQGFpqneN8Qv2HByLBrGlAL2mkRor5K1GIW/b
         287Z2odBS4yQe61AD6dhmwsl2q82AUVua36zB7htK90zvlWaXGIAhdEg1T7wt6fA556o
         qaOt6h+Nafz9s5AKWe0+p0faoL3t13/LG9Zr4PX7eNmjzn+zaMvXAYUIaCgm2/3LRqBe
         uW3BNL9y0X7RQpmOf3IhcNCF4pvCtxzl9yBUwzIvcKGDLFsqA9y6XvzXpZfj3EZZz5Vo
         Latg==
X-Forwarded-Encrypted: i=1; AKwUvBw+PIg0bTDEIru1BYYmr+Sto30zCEGz5ZFqNv9YWWUv5Sl0fXuvdOgtVs1NUEGh5K9mJqHPgjE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+LJsv8g2T4nWTxE5FCFbVYitykarrzSiwSUaFcsG3isstgdw9D
	ddzJU8mHdNgdqSnYNgbOpvl2f6Fp318KQpxzNV3c8sBRZkyLe/G61Lg4T++yIhrRJK0=
X-Gm-Gg: AYBFou16y5LaypdQmHGq3t0ZoWTl9zPB6ePGRklyAe8dXfQRsrSE44Iv8r8wnnI6j0I
	rNj95FfBwfjN0Z0Bn6qty2G4TebZTOfgByNcUARc9PntwQUQ40LFU1UGkAGDM45J65zjB0hrWrL
	KornoPNBYYyZUMQAFttAhZanjZrZd5XoBgaG7yOQnpKmX9iMAod+CgKZPVSfpFfzw/01g1ob0qS
	8aj/y8ExPuy+cmnG/9BXnHFZW+h7/2RJv14NKLyg0HaxV6kw269BVeahvQePiTQWSdPF2UiD77L
	aWsvy1UR2dsu78cbJjLUSdbI4trSHtNlllxIkpDWBiS9xeW7XIm2XI3D4/aikblMCADeZrD4Tu5
	oxttVnlzSfLehBODAIWO9n6dlUcYejvpKm/QWYGB7anVG6kg3YpoUxg5jZ8TCsrNMJhWQAh3ZZt
	kOXtDWkuydGQ7rUsab33dnB3j+042XKnisjUjxWAy13ZzelGH7uEDjeqW82Yo2Lt4YDfxv9Sbmy
	p8FeeNgDYAKyDc99JmryJnLzUVTOEf3ZngJfopBTfPejwXDmij2wlLiQIS7vn9HULVucVJP6GcR
	vB46kcum3SeTmsluzgb3fS45hgBkkuNR+eIWc0DCKw==
X-Received: by 2002:a17:903:1cc:b0:2e5:6158:b9c1 with SMTP id d9443c01a7336-2eb364e0730mr142081315ad.47.1793747008425;
        Tue, 03 Nov 2026 15:03:28 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed091207dbsm301785ad.49.2026.11.03.15.03.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:03:26 -0800 (PST)
Date: Tue, 3 Nov 2026 15:03:25 -0800
From: Joe Damato <joe@dama.to>
To: Breno Leitao <leitao@debian.org>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, david.laight.linux@gmail.com,
	kernel-team@meta.com
Subject: Re: [PATCH net-next v4 4/7] ipv4: igmp: convert ip_mc_gsfget() to
 sockopt_t
Message-ID: <aupoPbQlx899hNir@devvm20253.cco0.facebook.com>
Mail-Followup-To: Joe Damato <joe@dama.to>,
	Breno Leitao <leitao@debian.org>, David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>, Shuah Khan <shuah@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, david.laight.linux@gmail.com,
	kernel-team@meta.com
References: <20261103-sockopt_expand_out_v2-v4-0-2d36da923578@debian.org>
 <20261103-sockopt_expand_out_v2-v4-4-2d36da923578@debian.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261103-sockopt_expand_out_v2-v4-4-2d36da923578@debian.org>

On Tue, Nov 03, 2026 at 03:01:03AM -0800, Breno Leitao wrote:
> MCAST_MSFILTER reads its reply through ip_mc_gsfget(), reached from
> do_ip_getsockopt() and from nowhere else. Convert it the same way as
> the ipv6 side, and build the sockopt_t at the call site for as long as
> the caller still carries a sockptr_t pair.
> 
> optlen here only has to cover the fixed part, and the real reply size
> comes from the gf_numsrc field inside it. This is nasty, but userspace
> relies on it, so sockopt_expand_out() preserves the same mechanism: it
> grows optval only for a user address, and only far enough for the
> sources the socket has.
> 
> ip_mc_gsfget() writes the source list, and its two callers write the
> fixed part afterwards, at the head of optval. iter_out only moves
> forward, so the callee advances over the fixed part rather than
> addressing each source by offset.
> 
> The callers then rewind. The reply length they already compute is
> exactly what the callee consumed, ss_offset plus the sources it wrote,
> so both land back where they used to write: offset 0 for the native
> reply, gf_fmode for the compat one. The bytes are the same.
> 
> ip_get_mcast_msfilter() and compat_ip_get_mcast_msfilter() only store
> *optlen after their own copy succeeds, so a copy failure can't report
> a changed length: -EINVAL, -EADDRNOTAVAIL and -EFAULT all leave the
> caller's optlen word unchanged.
> 
> The old code stored *optlen before writing the fixed part, so an
> unwritable optlen word stopped the fixed part from being written. Now
> the fixed part is written first.
> 
> Acked-by: Stanislav Fomichev <sdf@fomichev.me>
> Acked-by: Ido Schimmel <idosch@nvidia.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  include/linux/igmp.h   |  2 +-
>  net/ipv4/igmp.c        | 20 +++++++++++++-----
>  net/ipv4/ip_sockglue.c | 57 +++++++++++++++++++++++++++++++-------------------
>  3 files changed, 52 insertions(+), 27 deletions(-)

Reviewed-by: Joe Damato <joe@dama.to>
