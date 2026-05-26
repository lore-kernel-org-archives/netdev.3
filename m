Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B3E3793D0
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 20:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779827670; cv=none; b=Y8NP//gLNawQrfxHUpbXr5aO3xfQEBaGdQFM1LI5bpfAZ1/ePqBEkHuz7iJb/8CejWY+lIBus+sYVtFFWIzCdy06bgPz/vKMgLkoyg8L2vOxIQjDJYde2gR//kHBNwAUyC+1f+6riHV3S9pwwm9OuKuvhS/ewEOGugakHnOHiLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779827670; c=relaxed/simple;
	bh=Y0TLE5vyioo9ORxMSFI20AhbAuxtB3qc0xDKIzny9is=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OQ90IMYwHPuG1Fx0xnwGRsvbXJsLEj6Tee8S4kESdF9m9kC3+SEa3aX6sNgJbUoP02mS+Fj3hrzwXzYsr9N/WNh57ist8cQecJgh6e5jnpkf9Eus0YLtUb0Dwlm9YGQS9XKhvCLnvwFx7hYPkP0ZSBxKKTjuB9nMEaO7VTQXfY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EzE+zBO+; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EzE+zBO+"
Date: Tue, 26 May 2026 13:34:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779827656;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=hKdLjxJGEaWT+ICVEtOCVjko2QKqcUVhU/K+x17GHJ4=;
	b=EzE+zBO+RQaCiyCubfY5G7iUmOT/ISfKpNB9B0Vl7R30ppexfbRSnkKHcIA1xeP/eY/cD/
	2ZO7PWuG7QBBrhlpZCtb7fZ56XQRLy7VVUFXbZ2ruXa9eYSoZg5lZG4Y+c8c/LyJv+6sVX
	awHSKbf+43APGOt+CPvbR832QaHZZQE=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Subject: Re: [PATCH v3 bpf-next 03/11] bpf: tcp: Support bpf_skb_load_bytes()
 for BPF_SOCK_OPS_RCVQ_CB.
Message-ID: <202652620632.prOx.martin.lau@linux.dev>
References: <20260523083001.2911931-1-kuniyu@google.com>
 <20260523083001.2911931-4-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260523083001.2911931-4-kuniyu@google.com>
X-Migadu-Flow: FLOW_OUT

On Sat, May 23, 2026 at 08:29:32AM +0000, Kuniyuki Iwashima wrote:
> When a TCP skb is queued to sk->sk_receive_queue, BPF SOCK_OPS
> prog can be called with BPF_SOCK_OPS_RCVQ_CB.
> 
> In this hook, we want to parse the RPC descriptor in the skb
> and adjust sk->sk_rcvlowat based on the RPC frame size.
> 
> However, we cannot access payload via bpf_sock_ops.data on
> modern NICs with TCP header/data split on as the payload is
> not placed in the linear area.
> 
> Let's support bpf_skb_load_bytes() for BPF_SOCK_OPS_RCVQ_CB.
> 
> Three notes:
> 
>   1) bpf_sock_ops_kern.skb will be NULL when the BPF prog is
>       invoked from recvmsg().
> 
>   2) Access to bpf_sock_ops.data will be disabled by passing
>       0 end_offset to bpf_skops_init_skb().
> 
>   3) ____bpf_skb_load_bytes() is called directly instead of
>      __bpf_skb_load_bytes() to allow compilers to inline it
>      instead of generating a tail-call.

Some observations below.

> 
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
> v2: Explain why using ____ version instead of __
> ---
>  net/core/filter.c | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 
> diff --git a/net/core/filter.c b/net/core/filter.c
> index 4a50fe2cd863..fa8a7c7d86eb 100644
> --- a/net/core/filter.c
> +++ b/net/core/filter.c
> @@ -7760,6 +7760,38 @@ static const struct bpf_func_proto bpf_sk_assign_proto = {
>  	.arg3_type	= ARG_ANYTHING,
>  };
>  
> +BPF_CALL_4(bpf_sock_ops_skb_load_bytes, struct bpf_sock_ops_kern *, bpf_sock,
> +	   u32, offset, void *, to, u32, len)
> +{
> +	int err;
> +
> +	if (bpf_sock->op != BPF_SOCK_OPS_RCVQ_CB) {

bpf_dynptr_from_skb() and bpf_dynptr_slice() kfunc could also be considered.
One less bpf_sock->op check in filter.c to maintain and could also avoid
a data copy. There is a bpf_cast_to_kern_ctx() to get to a trusted
skops_kern pointer but this will need changes in verifier.c to get to
skops_kern->skb (e.g. in type_is_trusted_or_null) and this is the tradeoff.

If this new rcvq callback is added to the 'bpf_tcp_ops' proposal [1],
all this will go away. 'struct sk_buff *skb' can be directly passed to an
ops of the 'bpf_tcp_ops'. Supporting '*skb' in a struct_ops has already
been done in the bpf_qdisc.

[1]: https://lore.kernel.org/bpf/20260519215841.2984970-11-martin.lau@linux.dev/
