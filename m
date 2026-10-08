Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8588E47255E
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 22:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791497616; cv=none; b=REP0TE3xkoAE/yRbxlMGnMJqNFHnMdSYft/8NUP1Echi/+O83o5oVRSEBMhtN4UjFFTvIbEmNmcCho8qEeG3Dk/ptFvoPwzUE60iVtd86w0VhDh9Rq+5sVcrSu/Vqqac0z0FCCkLERkLzLPfXfR1np6/z8Ll58lW+2MFaN8Tdos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791497616; c=relaxed/simple;
	bh=XjYDGK6HjNLwEE9cDyH2fc69s4zSLCXy5ifqkE4WBvE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qvqCdYnMHWG6q5O1MZdU8i/NXyQOIB4IwiAU9wK5QsXO3hDjpacJhJDUE+m+a/+HYpkAFSprZdC5ClBZYcT9Tb4XdBnmwa9+XGN6b7MO/qOr9fjPtYwpp4HKWL1phnpQ/c/qdNzrX4mdba1PxqQQE//Kzfpq7L0nFe/zm9ePLA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LU3v9Y1s; arc=none smtp.client-ip=74.125.227.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LU3v9Y1s"
Received: by mail-pj2-f5.google.com with SMTP id 98e67ed59e1d1-3ab00060990so407752a91.1
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 15:13:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791497615; x=1792102415; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xYUkTZ2E/cQovSHZnIL45VAnvbrCQ4bqpYzguwLnWtg=;
        b=LU3v9Y1sBFAWi14azj+hZ8+uKUGHK+iHXT9E5DabT59rhOMrKRYi4ByVn9p9czzMvK
         s+H1n9B0N7lfHAebeEJUw0BVe2mdfMmAyep4day+N6/kBXwf8y4TnPe3jpN+adEB1f7l
         qokHOGwU6LpmF/hyd4UxUTq5tvG2zgZFIy6LkRRytqaoNVYbZF87qCN9e0mlXWKS3YBR
         oantabML9eyhpdCfv3X8QLvGTNHcQFdsMZrXCsVhLG0cY3ftllWhJxqd4wb0e9y9CTDP
         MLv3sTFFmN+7JJ3SMrkAdJ1z3+AnFxguUvmCJkreFm602lTV43fT46TQ8j18BqPqo+4i
         iBgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791497615; x=1792102415;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xYUkTZ2E/cQovSHZnIL45VAnvbrCQ4bqpYzguwLnWtg=;
        b=zhV/06uoBrAA4K2OUD2fJv3YLLDDq9LJKsIDWmegUDwuVMx8oHM5fnJ8KCfwIIFAq1
         XqK/yZuirYqJTG/4GLNDqLXu8+7AwRKjoy13aGtJIvCmHpPpVkpy96VtDUIhd1lIel0s
         3zE2csvmoRH5tFozbvqZtx9H1Hr1X4SNIFXaTLKSb2L8juQ1uqCKe0G2fwOBVkyPrv9E
         mMsTOdcaoyQg0P6YZtjHoGRPWCaAjMXJegGwN/lQcZe5RgbN5644Vi5oHLXlex5yEL0Y
         R4ba4bSGVxtENyoFOQQ+Ez73WsOKit2amwRe4hiEEfU3xOOjLsCET9I8su7ibleMpZ3k
         APoQ==
X-Forwarded-Encrypted: i=1; AKwUvBzu06Z1ksJ/WZNvmNJjLtjzvIVLUvCqIZS/wVdtRGmsUGSqErDG8M4SkhvfZtZdji31He+Ok2U=@vger.kernel.org
X-Gm-Message-State: AFq9FYKcos9YPu99kXkEUKzYJFuEsgCq2F6EUx4ETncFS6SGUijhAAf9
	mXPxmCh7UsBNcD5G0idSuP5/xv7VpoLcm9ldtAWTGZPoNAiaMHmAALk7
X-Gm-Gg: AYBFou0JOgfM0Ed3OyxXIRWJ6F9oykRf+enEkdOOxbaR5HsY95EFz5xrhpl+g23wz2L
	P50x2NozgqqqEcw4CUJTqVxrcakPyf+4QPnsAKsPqSJQp+5lEeP44h3xqtWHZ1GmZ+nmTZVp4ez
	aBKciQxsO0x8gJMgjO8G2V79dd3Y6yzzAiYJaTsnz7q01+ORk1lxki4r6lG6MobWHnRjkE0qLXH
	zvbGeTUM1qMIHZkjGFr7ZlK/WtKJ2/LP+9LNAL1yBjnzZwwjio85HYkk2IutkM42wykVBWTM/lJ
	zvUavzeigwh8nyaum0BFXTbF36gx4SH5Hvccx2xxC3hSP6gqIRzIETBD42pRzeOtV4oXyC7cbX7
	98sioMeLMqTVqf2i+NgORiw8XZRiDWi5Apqy9nEi93utLKhcSf+5FLXCKp/uEFSV1+7XUvlHX/f
	6uClgFZMwNgdB5LauZ6lHpCcnOMtELe8X32JJ2qaA3+YQdDyAj7KYhX7FizVONGdk=
X-Received: by 2002:a17:90b:224c:b0:3ab:2ad1:f10a with SMTP id 98e67ed59e1d1-3ab3a0ef48emr192835a91.0.1791497614574;
        Thu, 08 Oct 2026 15:13:34 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab32d3b4f7sm375490a91.0.2026.10.08.15.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 15:13:34 -0700 (PDT)
Date: Thu, 8 Oct 2026 15:11:05 -0700
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
Subject: Re: [PATCH v5 bpf-next 04/10] bpf: tcp: Guard fast-path
 bpf_tcp_ops_call() under per-socket flag.
Message-ID: <asgU6X_PcuUf8SSH@devvm7509.cco0.facebook.com>
References: <20261008031604.256498-1-kuniyu@google.com>
 <20261008031604.256498-5-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20261008031604.256498-5-kuniyu@google.com>

On 10/08, Kuniyuki Iwashima wrote:
> bpf_tcp_ops.{parse_hdr,hdr_opt_len} are called for every
> incoming / outgoing skb.
> 
> bpf_tcp_ops.rtt is called once per RTT, which is every
> incoming skb in ping-pong workloads like tcp_rr.
> 
> Even attaching NULL callbacks in the fast path hurts performance.
> 
> Let's guard them (and write_hdr_opt) with the new per-socket flags.
> 
> __bpf_tcp_ops_call() and bpf_tcp_ops_call_flag() are added to check
> cgroup_bpf_enabled(CGROUP_TCP_SOCK_OPS) first and avoid accessing
> tp->bpf_tcp_ops_flags when no bpf_tcp_ops is attached.
> 
> Note that bpf_tcp_ops_hdr_opt_len() has 3 callers and previously
> checked the static key both in tcp_established_options() and inside
> bpf_tcp_ops_call().  Now the static key is checked once at the
> beginning of bpf_tcp_ops_hdr_opt_len(), and the redundant check in
> tcp_established_options() is removed.
> 
> tcp_bpf_hdr_opt_len() must use __always_inline, not just
> inline, otherwise Clang inlines bpf_tcp_ops_hdr_opt_len() to
> tcp_bpf_hdr_opt_len() instead.
> 
>   $ llvm-objdump -S -D --disassemble=tcp_established_options vmlinux
>   ...
>   ; 	if (unlikely(BPF_SOCK_OPS_TEST_FLAG(tp,
>   ffffffff8251270e: 41 f6 87 20 0c 00 00 40      	testb	$0x40, 0xc20(%r15)
>   ffffffff82512716: 75 47                	jne	0xffffffff8251275f <tcp_established_options+0x1ff>
>   ; 	asm goto(ARCH_STATIC_BRANCH_ASM("%c0 + %c1", "%l[l_yes]")
>   ffffffff82512718: 0f 1f 44 00 00       	nopl	(%rax,%rax)
>   ; 	return size;
>   ffffffff8251271d: 44 89 e0             	movl	%r12d, %eax
>   ffffffff82512720: 5b                   	popq	%rbx
>   ffffffff82512721: 41 5c                	popq	%r12
>   ffffffff82512723: 41 5e                	popq	%r14
>   ffffffff82512725: 41 5f                	popq	%r15
>   ffffffff82512727: 5d                   	popq	%rbp
>   ffffffff82512728: 2e e9 42 03 43 00    	jmp	0xffffffff82942a70 <__x86_return_thunk>
> 
> bpf_skops_write_hdr_opt() is still not free, but it can be
> optimised later if needed.
> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
> v5: Always inline static key to tcp_established_options()

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
