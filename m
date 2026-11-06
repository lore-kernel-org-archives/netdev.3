Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.242
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793970992;
	b=VbelYHyze/GFecfoyD3tiJQ9OpwzvgNxU976lNUJD4HoWBsdx2QKdl/3aefIkhBg5DNM
	 8fOuSO+qcmYkJlEVL1Ty6XZrwqSec8E+f8HqXt4f/qHVZuFfpdjkDo0svS9Fc37iWGbip
	 oxrUBKcdT134zVVivAhDpPI8sfYtx2XtmKTi29d3Ffah4vjcDIhOQyaF8H7+W2Q1aoJqA
	 xIpqOh2isdlVERZva1woq2ZH0WzSqvqJbWnCHvO+nS4MttfBqhXILzntD59L0idGUWCi3
	 oPH4UbThSg3qeyGh/brkixjhY98OP63TKXvnABztBh1f3sCTjBQB/PVGSPeN/B+1Rtw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793970992;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=xA2j3ADzCoYTFXkm6p5Y+S9TcrGcEwcHd75/49R2NEY=;
	b=oN/eVPQSFjMYoUKaJoALpvWATiyYSgI0LuKb72ZX828p9XtPgKWiEoifsYFzibduxQvD
	 0YAHMzE8vU/aMVq04LDJFMQVNcmDp7p27+NDkblbBl8fmr1LKoSuQVWht/g2fwhI9/N64
	 nliSOHGww6hNbn7tyKaS9zC+yH150tJSLkDMrVpi9tKfcLOjHk8JPfYTq32Pb/A3n1xXG
	 2QVb06sAivFPs39k18EbwfBvyphVCiOmQrxJ7k/T0/ZMxDxoKP6mWNCgHqqTHyWWgjTeA
	 A+jGYS8USkhgzpj2O6MNq2BVftOl51OrmuBPoIppM1egHIvkk9nDWlFd3snl1j9OeAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=aDz0gt7T;
	arc=none smtp.remote-ip=91.218.175.242
Received: from mta0.migadu.com (out-242.mta0.migadu.com [91.218.175.242])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C4B606A32E
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 13:16:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69C4B606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=aDz0gt7T
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=jLNhKHAo8WkYWpOAlEVTpu1rdFumCTRvxuDgeqU41cA=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793970989; v=1; x=1794575789;
 b=aDz0gt7TRM8PKPaqo2K+Us1WojVdhUjTG3hYjxXY/phiMs0mqxV/qCQ8VFHQ7DlYrig+IYd+
 sRH6+JTGHGhkaujVS4ZAeMCwIP5c4vXfcP1Xi1q/GdABm1L2WsJAg09Y5Bcr05TLCeQff+4sY7N
 01zVtSokc9gGwmCYgIXlQX+M=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 2c5374bb68f6f20c;
	Fri, 06 Nov 2026 13:16:29 +0000
X-Mizu-Trace-ID: 2c5374bb68f6f20c
X-Migadu-Flow: FLOW_OUT
Message-ID: <a69dd097-7e71-41f0-9a6b-eda001773236@linux.dev>
Date: Fri, 6 Nov 2026 21:16:24 +0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] bpf: tcp: bpf_tcp_ops_set_rcvlowat() missing from BTF with
 clang KCSAN
To: Breno Leitao <leitao@debian.org>, kuniyu@google.com,
 netdev@vger.kernel.org, llvm@lists.linux.dev
Cc: ast@kernel.org, yonghong.song@linux.dev, bpf@vger.kernel.org,
 kuba@kernel.org, tj@kernel.org
References: <au27Y9m78_3EH2v1@gmail.com>
From: Jiayuan Chen <jiayuan.chen@linux.dev>
In-Reply-To: <au27Y9m78_3EH2v1@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Thanks for the report !


On 11/6/26 7:38 PM, Breno Leitao wrote:
> My arm64 KCSAN builds of linux-next fail since next-20261015, because
> bpf_tcp_ops_set_rcvlowat() is missing from the vmlinux BTF:
>
>   WARN: resolve_btfids: no BTF func for kfunc bpf_tcp_ops_set_rcvlowat in bpf_tcp_ops_set_rcvlowat_kfunc_set
>   WARN: resolve_btfids: unresolved symbol bpf_tcp_ops_set_rcvlowat
>   Failed to generate BTF for vmlinux
>   Try to disable CONFIG_DEBUG_INFO_BTF
>   make[4]: *** [scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 1



Has pahole fixed this issue?


> This is clang 22.1.3 and pahole 1.31 (current pahole master behaves the
> same), with CONFIG_KCSAN=y, CONFIG_DEBUG_INFO_BTF=y and CONFIG_WERROR=y.
> v7.4-rc1 is affected as well. With pahole 1.31, the same config without
> KCSAN builds fine.
>
> The kfunc came with 5f549c1e49f3 ("bpf: tcp: Add kfunc to adjust
> sk->sk_rcvlowat."), and 201a454df948 ("resolve_btfids: Fix the
> --fatal_warnings exit status") made the missing BTF fatal with
> CONFIG_WERROR. Without CONFIG_WERROR the kernel builds, but bpf_tcp_ops
> is never registered:
>
>   initcall __bpf_tcp_ops_init+0x0/0x70 returned -22 after 302 usecs
>
> This seems similar to pahole behaviour sched_ext hit with a bool
> argument, discussed in [2] and worked around in f2f095c87603
> ("sched_ext: Work around pahole 1.32 dropping
> scx_bpf_task_set_lazy_resched() from BTF").


This sets a bad example for future kfuncs, as if kfunc arguments must not be reassigned......


>
> Here the argument is an int that clang reassigns, its location list has
> no DW_OP_entry_value, and pahole 1.31 drops it as well, so staying on
> pahole 1.31 does not help.
>
> Not reassigning the parameter is a workaround for me, with any pahole: clang
> then describes @rcvlowat in w1 from the entry, the kfunc is back in BTF,
> and __bpf_tcp_ops_init() returns 0 (tested in virtme):
>
> diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
> index 2ba73dd6c52cce..1afa6bd7f508ef 100644
> --- a/net/ipv4/bpf_tcp_ops.c
> +++ b/net/ipv4/bpf_tcp_ops.c
> @@ -370,10 +370,9 @@ __bpf_kfunc int bpf_tcp_ops_set_rcvlowat(struct sock *sk, int rcvlowat,
>  	if (moff == offsetof(struct bpf_tcp_ops, dequeue_rcvq))
>  		wakeup = true;
>
> -	if (rcvlowat < 0)
> -		rcvlowat = INT_MAX;
> -
> -	return __tcp_set_rcvlowat(sk, rcvlowat, wakeup);
> +	/* Reassigning @rcvlowat can make pahole drop this kfunc from BTF. */
> +	return __tcp_set_rcvlowat(sk, rcvlowat < 0 ? INT_MAX : rcvlowat,
> +				  wakeup);
>  }
>
>  __bpf_kfunc_end_defs();
>
> Would this be acceptable?
>
> [1] https://lore.kernel.org/all/DLRKT5MG6W2P.2V1P0QD4GQEKY@gmail.com/
> [2] https://lore.kernel.org/all/7c139810be5ffc9764ed4236efc28794@kernel.org/
