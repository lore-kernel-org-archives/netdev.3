Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6AE38AC65
	for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 10:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776681706; cv=none; b=FvM8n6b16Fm4REKwr+kxpW2yRMh5lxJdLFELcd79Z9d5INpSnEFy7dZRhVXn8gwlCc1ustcTkxF/8HtAlUN6JzoPvfgPmdw1W63J8RFQHpI7ROOI8PvM4xCaMNxXN8rFsGD2PLq7SS0nWSYIV0fSzWZUdFYyV8AG5Gy/PxQZd64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776681706; c=relaxed/simple;
	bh=3G6bw17iVmaMxiyG5cUe/e4Golb4z3XcazQgGRflVq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AdKODp3348g83tLVqqNFmcNB+AiMX+NpQE/tic2VgiUrdhGsPJa6TN7JsrIP1/PSYnwz5OevEVs7p8ow+CWlXYO3IUXAPmdVsKwAThhoVKVWKOhZE33wHoN9ftW8GBF4+sd2pLP20ABNsvIVxsxHiqW4gLOb/F+VB5pkGoVd3Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hDroHc1Y; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hDroHc1Y"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-43eb05b1875so1673099f8f.3
        for <netdev@vger.kernel.org>; Mon, 20 Apr 2026 03:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776681702; x=1777286502; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lzTJdI0y9SLg9oeJT3KSpFO3PA7UsqkKY0x5fwpKbdQ=;
        b=hDroHc1YYMe0y3McRwDieHmGXerCLDc1HUNn4RQGKr6ESqXU1RkoYej2f0g9tUSy50
         QFNlSAiHIdxYcZIKCfdB2mBrsl2vqU23pRJdx8QYR+wOxW7xqakfSHQ6aKAxa/dvQ84Y
         Ip7hw74XmEOAg5CvTRchShD0VcblML9abIq9u9Rf9llPtcAr5cNxPxJX6PbDw+Tz5wHF
         l0pHDFFk4YyhlN+Tq258jP8BSp71vjJ8zhTWMEhP2sb4v4dH12v7Y0Kr6wd0bhtYT8jj
         DTuszIspoUtF9wGcVyUTFyMiYfnXEY75t3NGnE+N7T7ByplDvxptSehoYOe3wC0Rsf4l
         +Izw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776681702; x=1777286502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lzTJdI0y9SLg9oeJT3KSpFO3PA7UsqkKY0x5fwpKbdQ=;
        b=KuEpxAWlVwXY4HNSUbuINrq3mvrHXmKezIDG7XqlvX4VcJkUU0v04vtX+jyVyUT7hf
         52OV6HqZvZO4OoWz+Y0ZQ7hx58Q8QDDfZ3f9ELth0Q+5XfKLgFCYvqo5G0Rje0YsFOj5
         8jZ45HgNRZlZVvNgLkjD2A8WT6QOmRzXGvtWWrsTOcuIwbZBJdcixm9riixomJ4UfOfm
         V9S29viybD9PuAt8/BEwi1CtC5SKza1hfeZev8Ifwmv+2sWbNGriBAgXwkdD8ma9dBqp
         S+2Rrwt7ofJd4/x57HUM836y4RCBJKbpDRzcCHjZgiybL2PCJ0uUnVsqA7gx4F3QcQV4
         dTUQ==
X-Forwarded-Encrypted: i=1; AFNElJ9kh9J0bCZGYDYGmbH0KxFuN5zggpYNCH93BlXVXBKplET9WjYUqmM03n/1ImABscqc/XzFQK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLMF/HT3hdB2aMRsxO5gwpJigEBKYzslI6xbM5NLE4OpCGfkLc
	iM6pFany+Qer3BIu7qA8FZdXGFYKVC47B7O9j23nQfG1tVQyPC1WG5X9
X-Gm-Gg: AeBDies3onVsA/7zb4E1o1yq2OTDew21nBOk2CjOul+WrF/reaWJGb7mhQ86f/OjdCy
	GEOje3Yj16uSLPxCuA5Gy6OYD/NH2ewOvdP1FQH8pIsX/embkp7JKxsV0FFlzRSCigpLNOYpWKq
	J3+K74jN6deAnrgzkpNMH9mbLTsDRswqRQ8bYul4qNxIaRbP8Yedv37RKXee3IfdFu7NpN9g7ee
	+M6JRiNhKshWmKmoKtQMGYrOv3cKEDFsQSu8X2JXi+43IpJu5UHRJrgNvAi7NkxJ/sbWU62PrGd
	K9ubV95d7NKHmhTNmYs+o1JezLfbu5sha665EEw5iIFfa42U0eCNQ0zePrmlVhPhuAuJeUvWxhT
	9BvW/vXszkZNLRa/4fUC/GT9orw+QM9l+n5n5fNIvHpZX3GrVFCTcbqOT1qAOUATJm+caYc1558
	1QylxO1E6Svs/INBEYRMZaVJKJrIqsmdVyw1rftvzg/YNoKZqTKCpoCGBqFJfjGQqmFkElk30xs
	h/SeO6wzqm44ooYElGLyG/YaWnIadxGIksDObCNanHvO0UTD7mJFUExZ9LsjF9wH00SvlHadOwj
	BmSd27Jw0Us9lESZvoBer6SzTU/F42vM4iJn2SRgQu4neiyW8d59TQsW+S+1ToM=
X-Received: by 2002:a05:6000:178b:b0:43d:7946:bae5 with SMTP id ffacd0b85a97d-43fe3e144cbmr20095208f8f.42.1776681701508;
        Mon, 20 Apr 2026 03:41:41 -0700 (PDT)
Received: from mail.gmail.com (2a01cb0889497e0007a7f49aabdf4292.ipv6.abo.wanadoo.fr. [2a01:cb08:8949:7e00:7a7:f49a:abdf:4292])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4dc24cfsm28616669f8f.16.2026.04.20.03.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 03:41:40 -0700 (PDT)
Date: Mon, 20 Apr 2026 12:41:38 +0200
From: Paul Chaignon <paul.chaignon@gmail.com>
To: Weiming Shi <bestswngs@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>, Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>, Simon Horman <horms@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>, bpf@vger.kernel.org,
	netdev@vger.kernel.org, Xiang Mei <xmei5@asu.edu>
Subject: Re: [PATCH bpf] bpf: Fix NULL pointer dereference in
 bpf_skb_fib_lookup()
Message-ID: <aeYC4oLXPyCE7xu1@mail.gmail.com>
References: <20260419170131.3899757-2-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260419170131.3899757-2-bestswngs@gmail.com>

On Sun, Apr 19, 2026 at 10:01:32AM -0700, Weiming Shi wrote:
> When tot_len is not provided by the user, bpf_skb_fib_lookup()
> resolves the FIB result's output device via dev_get_by_index_rcu()
> to check skb forwardability and fill in mtu_result. The returned
> pointer is dereferenced without a NULL check. If the device is
> concurrently unregistered, dev_get_by_index_rcu() returns NULL and
> is_skb_forwardable() crashes at dev->flags:
> 
>  KASAN: null-ptr-deref in range
>   [0x00000000000000b0-0x00000000000000b7]
>  Call Trace:
>   is_skb_forwardable (include/linux/netdevice.h:4365)
>   bpf_skb_fib_lookup (net/core/filter.c:6446)
>   bpf_prog_test_run_skb (net/bpf/test_run.c)
>   __sys_bpf (kernel/bpf/syscall.c)
> 
> Add the missing NULL check, returning -ENODEV to be consistent
> with how bpf_ipv4_fib_lookup() and bpf_ipv6_fib_lookup() handle
> the same condition.
> 
> Fixes: e1850ea9bd9e ("bpf: bpf_fib_lookup return MTU value as output when looked up")
> Reported-by: Xiang Mei <xmei5@asu.edu>
> Signed-off-by: Weiming Shi <bestswngs@gmail.com>
> ---
>  net/core/filter.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 78b548158fb0..3e56b567bd18 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -6450,6 +6450,8 @@ BPF_CALL_4(bpf_skb_fib_lookup, struct sk_buff *, skb,
>  		 * against MTU of FIB lookup resulting net_device
>  		 */
>  		dev = dev_get_by_index_rcu(net, params->ifindex);
> +		if (!dev)
> +			return -ENODEV;

The bug and its fix make sense to me. Given the race, it looks difficult
to write a selftest for this. The condition might be worth an unlikely()
as done in bpf_ipv{4,6}_fib_lookup() above.

Acked-by: Paul Chaignon <paul.chaignon@gmail.com>

>  		if (!is_skb_forwardable(dev, skb))
>  			rc = BPF_FIB_LKUP_RET_FRAG_NEEDED;
>  
> -- 
> 2.43.0
> 
> 
