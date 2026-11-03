Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793746916;
	b=d6kX9y4ldZ0bgnnxn76SuL+qrrytyAjLY87PegehoPlb0SjYAJdMhOcHSZaGoV2P7/ov
	 szdDwsJivfv9nradehhgX930ZrEk1JY6rsfjP8mCRY1uOhiaNYAQmOBvcD06lpVU0cf4l
	 Uqb6T/XUISshixp0A5KAodGUwcuoNEfvjQZQ5R1H4jGFxLgMYQeVhD7LyT8L2ACaEBQor
	 CY5dq2K/pICRZs1MgItRProJVEMTA1TfXGPMYe1vRwTZJ7vvJVgHCeJP0Rrn3ZNn7KQgt
	 de7r6JowMClBhguMP4eQwuFJzrRVB8FB8wBJJIamL9KeokSnFDodF+/h1qYSRc2Y6Pg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793746916;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:Mail-Followup-To:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1y+XljbojQ8RmFRrqF3tIyG5Meo4CmUH1v4mswRS22o=;
	b=gGxeFCMDT2CpHGMQh2i90mYsgYC7/k13vCPnA34asXI603Sw8R4TgDwuaNPWkiToouiE
	 uPvdFHTmUiGqctfl7r39EBEGjCwQidfSDKOK4bvj377r/Oz4t5V9dEhN++ILK1rGxtXIK
	 hnb2Ux6NYgr4yX+ywmXaJNsqTLwiy9lZqfnXh8lW2lKiN+vAwi+4+r1PkkI8QB9TcBRXg
	 0lUM9ztWcuUzGkbu9iiD6a9K6nNf5xhgt36z8omg+GeK0p1feKrHrFkOE6xDbqTF5K5qG
	 50YoEgCkNGJUIlHRQz/WI4LvMN8IBAH+/hMl/w9YeZGbsZ8nQc50i1O4km3YQLXweTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dama.to;
	spf=none smtp.mailfrom=dama.to;
	dkim=pass header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ejRuknpl;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D6EB606A328
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 23:01:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D6EB606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=dama-to.20260707.gappssmtp.com header.i=@dama-to.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=ejRuknpl
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-89f28c3ac7bso59444b3a.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 15:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20260707.gappssmtp.com; s=20260707; t=1793746915; x=1794351715; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1y+XljbojQ8RmFRrqF3tIyG5Meo4CmUH1v4mswRS22o=;
        b=ejRuknplcXcfwh/9Pm+1q3vC/nC31j0L2g1hQblwJK5OkYf5XMNQaLwX98fSc4sKPS
         GlGaL7l6UB1isKdH4qlooC+Q7NTE/7R/+LK7iPuKGYZKvFhIFGKvch7/tJ9JAthzMqQL
         iaLieomJSBX4PqAFcgGvzCkJXF+dreeEghrYzYAGGxv1MsYwsMuDtVSR82SSyBtnpJeG
         8yasj4Bk3K207rozuo4ZDf4DHexrvySyZbWMt2T9enCtAByHAXrniLsAkIwHMYqNx6Jq
         nh98owGBBQTmXS16EiJEm2MuE8QXnSZGqCoqXCdtVja63JIZ+TQsOqu7RBjmdqK4JRkF
         PNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793746915; x=1794351715;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=1y+XljbojQ8RmFRrqF3tIyG5Meo4CmUH1v4mswRS22o=;
        b=P0b7O6pUCelP9Pj983jFsjad7FZID2M5vjwOshZ9nXeYfQtuMatsEoOsNHdwVn+LcI
         xrFduG5wHqrG4/l0mVh2aBBpUgYspiGaWZV3+3B3fgPlVSNSf4KvFrnkmPkhu0Yp8UqU
         xx0BIaTibiHFqgapKZ42g8b++1P+XeMbsK72juKBa02ag4cTaK8WhdVlaqlvE+i+1YbB
         lxXibhD53QWtJzxOWxcvFqDaFjUmbH9pEmjO1MlGFEertR0BXKAeju65Ybx2vUaVA7G0
         SuAowhLRSjvbgQ4JrSop01raDuFzDIAXwhiIZUBBBhhdSIoMTfjg2oZTm9N2rUyqMQEE
         +TyA==
X-Forwarded-Encrypted: i=1; AKwUvBxL2RwBW+CRBfmzi51c0T2pXCceLYTPjc8wZUk8MWhJL8DhzR6Vr4SBSUur2smdE94CrOSZpcw=@vger.kernel.org
X-Gm-Message-State: APuU4Z8vXLieCoUwES+k4HVAAuCiWkV3tqz9LLUYCH1GPyPnTlGKGZpq
	hh7z78MyW4Tssu7XT/rhDK6Nc7SfDhyDzQmpEK1aXrAUtJUu5aB3LGH9YKz7qev6ttI=
X-Gm-Gg: AYBFou3BrpCEp73CwU1u+UO1bZ2vO5mmYSuy7nW083jQJSFfKKbwHKhQyucxGv1aJ5p
	TO+hH02JsTtYadhz9GhJ3mGfZPyaJoyBksQjOokV+FtEGheNsI8Dn4isIm0YCwE+7tu8Twu/ssb
	BRwqvRBqV8VnCCznekkFr/oWzkMTJzKPKYA/tzUtvFKO+w0+slKaFg3JrbQoGj7Rxgop0aT9CYO
	9mCLUjitRoTWhIyIl5u/AHJjHIs2hdgZu7pe+2FRvruQjzvNlHplzKSKlY0aEqpkQzUZn50WC27
	iC+gwub710XwuXPFo0ghRcZEyp1OqRNd6Jw/6fxzHa/Bo21c+sxO/4eF71p8pJ8S0hRL2I0dgXH
	Q/iaOP7KO9KaQHAU+SuFx2Fyxb0XBe7sW5fgEX/p85t711Md/9/6UOJ2m5HxGQf+hESfuFKbYtC
	p2nVdRxuBi4wk+WpXCYyazLrv6Jmh1p229KUzIyHmhlF+jTEZNDD56eR9uAqDHt+hDJF+TeQWuc
	es+uBdHmfHUeoW5bsnnT9Gllprj6e9kuCBtZYhqE2z3LieCukdf1pOVZWtqYW9MqPPsz65m1D+z
	z3HWKropZlvm+3/eMqk9z5y4H/Fc4CpdYGaGuhvC
X-Received: by 2002:a05:6a00:28cd:b0:8a0:4032:af85 with SMTP id d2e1a72fcca58-8a9b7916fcdmr12491838b3a.0.1793746914675;
        Tue, 03 Nov 2026 15:01:54 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8b097fe108dsm161105b3a.6.2026.11.03.15.01.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 15:01:52 -0800 (PST)
Date: Tue, 3 Nov 2026 15:01:50 -0800
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
Subject: Re: [PATCH net-next v4 3/7] ipv6: mcast: convert ip6_mc_msfget() to
 sockopt_t
Message-ID: <aupn3m8q2oAKeQ59@devvm20253.cco0.facebook.com>
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
 <20261103-sockopt_expand_out_v2-v4-3-2d36da923578@debian.org>
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
In-Reply-To: <20261103-sockopt_expand_out_v2-v4-3-2d36da923578@debian.org>

On Tue, Nov 03, 2026 at 03:01:02AM -0800, Breno Leitao wrote:
> MCAST_MSFILTER reads its reply through ip6_mc_msfget(), reached from
> do_ipv6_getsockopt() and from nowhere else. Convert it, and build the
> sockopt_t at the call site for as long as the caller still carries a
> sockptr_t pair.
> 
> optlen only has to cover the fixed part, and the real reply size comes
> from the gf_numsrc field inside it. Userspace relies on that, so
> sockopt_expand_out() grows optval past optlen, for a user address only
> and only far enough for the sources the socket has.
> 
> ip6_mc_msfget() now advances over the fixed part and writes the source
> list through iter_out. Its callers rewind by the reply length they
> already compute, which is exactly what the callee consumed, and land
> back where they used to write: offset 0 for the native reply, gf_fmode
> for the compat one.
> 
> ipv6_get_msfilter() and compat_ipv6_get_msfilter() only store *optlen
> after their own copy succeeds, so a copy failure can't report a
> changed length: -EINVAL, -EADDRNOTAVAIL and -EFAULT all leave the
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
>  include/net/ipv6.h       |  2 +-
>  net/ipv6/ipv6_sockglue.c | 64 ++++++++++++++++++++++++++++++++----------------
>  net/ipv6/mcast.c         | 19 +++++++++++---
>  3 files changed, 59 insertions(+), 26 deletions(-)
>

Reviewed-by: Joe Damato <joe@dama.to>
