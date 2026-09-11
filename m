Received: from mta0.migadu.com (out-29.mta0.migadu.com [91.218.175.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0377542C513
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 10:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789121984; cv=none; b=EfbJlRoWqCEswFx1E5ydajV5G6Lad55b7/lA+nTqTvlhgDzrtI5TqSPPNKTUehSooaki1GrV3KwXm7V5DojFsjbc5brZwwWejHwY2+fLW9LBact8ZV0ux0b/QMy063J/XVf6ETwhQn83X3D7F8nML672uvMW112boXPMXuAxX8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789121984; c=relaxed/simple;
	bh=KsROwYNjEq1HSbXeZo4M0Jw+ikml7L0+xYgSbjmQXvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qXo7AxHoc4b9CiPuvq+eRF59mhEjZea2HH2dIFmxI1Mdao9wnmvhycKqpmICeY24asoU+w2LfU4g4wgkON5UpvR7x/KBgEZdlQMRgYDCTpaJakbbq+5Nrf2355J0uNQOgQKEbSBnDFn+MeZ3n1OudmMq6kNCbDuOHofxdsyRPr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=S78oWLY1; arc=none smtp.client-ip=91.218.175.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="S78oWLY1"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=KsROwYNjEq1HSbXeZo4M0Jw+ikml7L0+xYgSbjmQXvE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789121979; v=1; x=1789726779;
 b=S78oWLY1wdFL/I0/XfmRU9S+Inovnil781RSx6jOq1cbilL3Lee2odt6kroq4dGcmSbVxAAf
 h2AQSbLE18MiEBVMEvBmzG3u4j8XuT/MpcRvTuuZgSMnJIQDVHyNEL6p6nRwmrfSJegYNTY2g+j
 PtRb/GUllqE2hEEbVUFVzMRU=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a98d2990b29644a7;
	Fri, 11 Sep 2026 10:19:39 +0000
X-Mizu-Trace-ID: a98d2990b29644a7
X-Migadu-Flow: FLOW_OUT
Message-ID: <d50caa88-ea1b-4e01-ae29-7f6007575ee8@linux.dev>
Date: Fri, 11 Sep 2026 18:19:25 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 01/14] bpf: Introduce per-packet metadata
 storage for BPF programs
To: Jakub Sitnicki <jakub@cloudflare.com>, netdev@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Stanislav Fomichev <sdf@fomichev.me>
Cc: bpf@vger.kernel.org, kernel-team@cloudflare.com,
 Daniel Borkmann <daniel@iogearbox.net>,
 John Fastabend <john.fastabend@gmail.com>,
 Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>,
 Kumar Kartikeya Dwivedi <memxor@gmail.com>,
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>,
 Emil Tsalapatis <emil@etsalapatis.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Simon Horman <horms@kernel.org>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 Florian Westphal <fw@strlen.de>, Jack Wang <163wangjack@gmail.com>
References: <20260910-bpf-meta-inside-skb-ext-v2-0-0b21e42180b0@cloudflare.com>
 <20260910-bpf-meta-inside-skb-ext-v2-1-0b21e42180b0@cloudflare.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <20260910-bpf-meta-inside-skb-ext-v2-1-0b21e42180b0@cloudflare.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


> diff --git a/net/Kconfig b/net/Kconfig
> index e38477393551..6d57320dfea3 100644
> --- a/net/Kconfig
> +++ b/net/Kconfig
> @@ -540,4 +540,24 @@ config NET_TEST
>   
>   	  If unsure, say N.
>   
> +config BPF_SKB_EXT
> +	bool "skb extension for BPF metadata"
> +	depends on BPF_SYSCALL
> +	select SKB_EXTENSIONS
> +	help
> +	  Enable an sk_buff extension for storing BPF metadata. This allows BPF
> +	  programs to associate arbitrary data with individual packets as they
> +	  traverse the network stack. The storage is automatically freed when
> +	  the sk_buff is freed.
> +
> +config BPF_SKB_EXT_SIZE
> +	int "Size of the BPF skb extension metadata buffer"
> +	depends on BPF_SKB_EXT
> +	range 1 256
> +	default 64
> +	help
> +	  Configures the size of the inline metadata buffer in struct
> +	  bpf_skb_ext, which is the maximum amount of data a BPF program can
> +	  store or retrieve with bpf_dynptr_from_skb_ext().
> +
>   endif   # if NET



Can we do it like this? So that enabling BPF_SKB_EXT_SIZE only is enough 
and make it easier.


config BPF_SKB_EXT_SIZE
     int "Per-packet BPF metadata in skb, in bytes (0 to disable)"
     depends on BPF_SYSCALL
     range 0 256
     default 0
     help
       Configures the size of the inline metadata buffer in struct
       ....
       The skb extension chunk is sized in units of 8 bytes, so values
       that are not a multiple of 8 just waste the remainder.

config BPF_SKB_EXT
     def_bool BPF_SKB_EXT_SIZE != 0
     select SKB_EXTENSIONS
     help
       xxx

