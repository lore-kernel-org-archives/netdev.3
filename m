Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794436159;
	b=ZvfLevZ6r2W8fvnSsMfovBlQGsF7dRAogN+egNRBqC2bmz8RR6T9zdO4YobBv5XRJqYT
	 WsXsrcWf/aivwnvMjzkz8tHMTT6hPzIZ/JnFhVaL0CnxtvwmbnxRjg4g2KljYSKz5bcIb
	 EPeGRhU6/mlxPG49IXEbnUffiMFWDoA6minpgZ3C0Oc/whmnhd7ZDGlzPrhQLIxFAEwk/
	 vv3LA5viBFb+kJ9/+mH0deISX9F1uAzoIGn49k1t+iSaFcpHZe6qtaKX/Z1kgOEcajOnh
	 g7IhAFqMRkMIJZXiw0S65l20fg1fA/AzRLfb2qshWqCK9QtSLp7NP4nfepsaq081hSw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436159;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=swr3Ra0uYYHhVDT8SV7YWQm5snOjPZHE4+u1z3uEAP4=;
	b=DseKC7N7Agw3+eYv7Giouy97e2DVW5MhAx4ejqghL3PmfurbgXHcnTsXSn88wy87ZCeM
	 sm3z/2rWjz7bC7fap0AFmSzLcUvXlAShqa+36jiw8iQdpSYmYkPB0E4/105PXuvSqXN4E
	 QUF4m677d+sqXHJx2C8BOZQKNget+sX8+4NVTKnIU3fytq8Pv3hZpnh/7PPERb2sBEhcJ
	 2NODYais6UfkzZeQAd8Uo63qwjbWKmP3eJcGDyj/eDttKQ7hKP8YteHOXTUYPcksKDQbo
	 aMwuy3f0V4dhEH74v4/2vCfZFowwObZ+5vRXz3pnoMIahnlepqjgJsD0hfG+QIqe3fQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FHFW1jQ8;
	arc=none smtp.remote-ip=95.215.58.174
Received: from mta1.migadu.com (out-174.mta1.migadu.com [95.215.58.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249FD606A33B
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 22:29:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 249FD606A33B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=FHFW1jQ8
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=WNeWuH485eW6BnGDu5zKsDsVjpVFn1cXQI2ek2Qhepw=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794436154; v=1; x=1795040954;
 b=FHFW1jQ8gZeq62AyqIat/bVk9+oZJPH+mKkgGwHYatFqvqUcb0jqme3Ckd8RXghvxmEFuymv
 EXnKFgmZpzeJhVQnrdCTsXC8aJbNJvY38EQA7hJs/li1XdYxFrbyl6lBTQG5l25sJHs0Bzfkdgu
 +aqETu4zmziTnVUrlolNq95Y=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id a971d7137a0d0f9f;
	Wed, 11 Nov 2026 22:29:14 +0000
X-Mizu-Trace-ID: a971d7137a0d0f9f
X-Migadu-Flow: FLOW_OUT
Message-ID: <9ccfc1f1-1214-4374-bac4-f4d91103d149@linux.dev>
Date: Wed, 11 Nov 2026 14:29:11 -0800
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
Cc: ast@kernel.org, bpf@vger.kernel.org, kuba@kernel.org, tj@kernel.org
References: <au27Y9m78_3EH2v1@gmail.com>
Content-Language: en-GB
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <au27Y9m78_3EH2v1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 11/6/26 3:38 AM, Breno Leitao wrote:
> My arm64 KCSAN builds of linux-next fail since next-20261015, because
> bpf_tcp_ops_set_rcvlowat() is missing from the vmlinux BTF:
>
>    WARN: resolve_btfids: no BTF func for kfunc bpf_tcp_ops_set_rcvlowat in bpf_tcp_ops_set_rcvlowat_kfunc_set
>    WARN: resolve_btfids: unresolved symbol bpf_tcp_ops_set_rcvlowat
>    Failed to generate BTF for vmlinux
>    Try to disable CONFIG_DEBUG_INFO_BTF
>    make[4]: *** [scripts/Makefile.vmlinux:72: vmlinux.unstripped] Error 1
>
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
>    initcall __bpf_tcp_ops_init+0x0/0x70 returned -22 after 302 usecs
>
> This seems similar to pahole behaviour sched_ext hit with a bool
> argument, discussed in [2] and worked around in f2f095c87603
> ("sched_ext: Work around pahole 1.32 dropping
> scx_bpf_task_set_lazy_resched() from BTF").
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
>   	if (moff == offsetof(struct bpf_tcp_ops, dequeue_rcvq))
>   		wakeup = true;
>
> -	if (rcvlowat < 0)
> -		rcvlowat = INT_MAX;
> -
> -	return __tcp_set_rcvlowat(sk, rcvlowat, wakeup);
> +	/* Reassigning @rcvlowat can make pahole drop this kfunc from BTF. */
> +	return __tcp_set_rcvlowat(sk, rcvlowat < 0 ? INT_MAX : rcvlowat,
> +				  wakeup);
>   }
>
>   __bpf_kfunc_end_defs();
>
> Would this be acceptable?

I tried and this change should be okay. The below pahole patch
    https://lore.kernel.org/bpf/20261111222447.322978-1-yonghong.song@linux.dev/
is to ensure that all kfuncs will have their source BTF. So once
the patch patch is merged, you can use pahole master branch to build.

>
> [1] https://lore.kernel.org/all/DLRKT5MG6W2P.2V1P0QD4GQEKY@gmail.com/
> [2] https://lore.kernel.org/all/7c139810be5ffc9764ed4236efc28794@kernel.org/

