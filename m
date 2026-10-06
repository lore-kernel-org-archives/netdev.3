Received: from mail-pj2-f9.google.com (mail-pj2-f9.google.com [74.125.227.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83AC37F010
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 22:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791324433; cv=none; b=dymVL0OyWfR2xt2N1msDPTZwWA8TOkO9eqjqmt+THDStVg9AmHiH36dki4/RQeY0BYaUpwy857f15/3PDt8NWbFdeZyP7GPsGdm4SyWREP30E1hl28+JHTuyCPqNU0dgA+p3kN/Y23zB8IThsDneI3rCa0WER27R5LTQoManJSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791324433; c=relaxed/simple;
	bh=St1pov/zO72pZVPMTwmGDh1KZ6yCH2bMT6rRjrkhycw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=haogW2wyQcQLDdJEGk2KtL+Bd6sFlZ206ozOjeQjx7Ir934SLCeDL6RFWMhVIPeDaZ2HyUkec9yuli1LttFB9I6FqUbbtgzZ2COR1t2phl8ZcT9UVwgemnPSGkBlVcjAINTHuietgRJ5Io61UAcqPijkdqiVv7HqAcKCA6yHHiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pnLfzmxt; arc=none smtp.client-ip=74.125.227.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pnLfzmxt"
Received: by mail-pj2-f9.google.com with SMTP id d9443c01a7336-2e4a61a2ff9so14913385ad.0
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 15:07:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791324428; x=1791929228; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jAq9XlswImcUY3VmzzuQYBjeBCXyaGsgZxIoIOD7uhI=;
        b=pnLfzmxt6cDj9EVzXSIL+qHA64jHVp/7NcXyE3xbsijyGOeTJcby94nw1kkPqzGETu
         O46JJUeQwfii6QlFkobmb9RaGKDyVFTyoCOzvsgOP1oaTfMJHXQ+SgQqfSzwFKUFyX5n
         D5s35/H8JAfhTSnORHeKv+fp1FL8pkLZBw30r8+B1/DNEE2AcC/KGDpNEJRM7/b7kmmB
         sNT9fOKXQ1Jn4GxARxg8ZhAQv0BnytqDJ2oDW93o0OC6bcGTR2mBc2GecjUNFalLundH
         W7HxFSbVlL2dd5OgUhle2ztKr1jdgVh4wT/cLn8luP0QUGM+MMnip88AodqXPaQbsePP
         m70w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791324428; x=1791929228;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jAq9XlswImcUY3VmzzuQYBjeBCXyaGsgZxIoIOD7uhI=;
        b=0+Hpo315xSjyQ3sqYyM3xNNtt6pVlA+E/qI3BqCy5nO9CVmzyqWLVZ5rS1f0nYqy0+
         w+T5jtT2W7e5m6kGydsMiXOX2BUKw7QzNjr9i0Fl13KrPGrwkCenP0SFPY/Toj+CHJSf
         N+k6bgguSu+IcMuAJ9w9O6/gfimKd32icpFy42bfVf9G2zjLjsvnDX+0LCH0ay8NERf3
         7FoExWISuIhP6g3X6UT6vB+B1X86+2FoptO0qI88NwFhR06QTtW1hRL9lPp1l/0u6gzH
         vCjL4wIEhg8wzvuVvGyfwM4/Du94KKysJKy60Uhm6OTwQs0xjC6LjUqx/ER1UXDfukcT
         JLIg==
X-Forwarded-Encrypted: i=1; AKwUvBxaQidiWiIuDYkItizOAYx97BySmu1iX6BfGwyTF9be47isowCri4zXgFNa/y1WgROSu2LFOtI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKrU1TsWkVEvdGLeJcp5N1L/oEgj+ApaXXW/7/jvH7MZQQp2fRh
	qHKtuvKsQeQeWpZRozBaa7SJQRSm8JsiXmqbpdoW4YGdRTOf5MN7/snd
X-Gm-Gg: AYBFou1L/I+A2gpG8uIkbb2Wztf23goIaT/2k7QN/izj5vOcKG49nNGHXIcz8Nr72ga
	CTgZgV/pOY2lH6XJGvP9Bs1Wst3UU5MHvQLcgOa0SCqipGOK/Fygp7M6/divKD4C5b71cZHAxGd
	JEU0BhSjNyivNmXjCE4EFu4t9baPEBR4XPSboU32XNQBumZq3RxXyke/+YY+CXIGWe7I26LC4+L
	X+LKaQPvm1Fd1Zd5muQyGIEEI2wGSJksXuPBtBFQ9EHBn9YOru839PZNlzk4MkSH++dPJZQLED3
	poTQlSHLydBLWYLLaqCp9MtBHA6Q9I+ptoBvzJZH5utR66GBjLer0MufNacP8lf16f8GWPIZwJ9
	mqZ/b+LEi7AgPLwo4mS2YWVhELBxBmHJ7R/nbuxiTgq+LIxfnjH6Z3Y4Brrb8cr7HLOvs62Yp5h
	AYxg2378pfORr4eOxrs32yX6l4RCfUmRymUUYkLWR4Y2TEWAAsoT1nt3Lwi5W3K5o=
X-Received: by 2002:a17:903:3c45:b0:2e5:d6b8:ad1a with SMTP id d9443c01a7336-2e6003b2732mr4635835ad.35.1791324428329;
        Tue, 06 Oct 2026 15:07:08 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e604720106sm1564685ad.31.2026.10.06.15.07.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 15:07:07 -0700 (PDT)
Date: Tue, 6 Oct 2026 15:05:47 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>, Amery Hung <ameryhung@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?utf-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v4 bpf-next 05/10] bpf: tcp: Check
 BPF_SOCK_OPS_TEST_FLAG() after cgroup_bpf_enabled(CGROUP_SOCK_OPS).
Message-ID: <asVwtYlgiKUlQSSg@devvm7509.cco0.facebook.com>
References: <20261006192601.1875100-1-kuniyu@google.com>
 <20261006192601.1875100-6-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261006192601.1875100-6-kuniyu@google.com>

On 10/06, Kuniyuki Iwashima wrote:
> BPF_CGROUP_RUN_PROG_XXX() macros guard __cgroup_bpf_run_filter_XXX()
> with cgroup_bpf_enabled().
> 
> However, even when no SOCK_OPS prog is attached, callers still
> initialise struct bpf_sock_ops_kern (memset(), etc.) or evaluate
> BPF_SOCK_OPS_TEST_FLAG(), which loads tp->bpf_sock_ops_cb_flags
> from a cold cacheline near the end of struct tcp_sock.
> 
> Similar to bpf_tcp_ops, let's check cgroup_bpf_enabled() before
> BPF_SOCK_OPS_TEST_FLAG() and struct bpf_sock_ops_kern setup, and
> rename BPF_CGROUP_RUN_PROG_SOCK_OPS{,_SK}() with __ prefix.
> 
> Since all direct callers of tcp_call_bpf() pass 0 and NULL for
> nargs and args, they can be folded into the new tcp_call_bpf()
> macro.
> 
> All callers of tcp_call_bpf_{2,3}arg() check BPF_SOCK_OPS_TEST_FLAG()
> and do not need the return value.  These are replaced with the new
> tcp_call_bpf_flag() macro.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
