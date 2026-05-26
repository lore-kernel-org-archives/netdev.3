Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04AA3C13FF
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 21:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779830532; cv=pass; b=KsUf88sBor5axqlWz/1CDExC1i6cViPS5Cm6CeGHYhYu159Kvji5LCA1IQ4GskAYz2h6GPz1NZAPWYsA3Wy+AcuvrssgpaVB/CADJRqkNgJ0s1rAc3FMDVmDRb8KpdUWvT6ethfIp7kqqMG/r7oOzDCCEn4J+nIPFqP37lEdVQM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779830532; c=relaxed/simple;
	bh=h2pRzbCs5OlGfRvvPszd4XwFbSVhfsO5zU3RTXajg64=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eWlVPmJ+oNy5d3Xy/LF2a2U4AuALnSZjup1/w9RKMgqMfKmzvsHDNFcOvuP5UfEZmZQK+t/CEaHxU5drGSrf66vnotQyvfU8zYc2BKTWKp6zwNybj/hTPw1xWjXOH/kh4+6ESYuMdLzsN4qgmLV4oK7u/5WsafJnAPlz8KeCEMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vQhNTL8+; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vQhNTL8+"
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1363e78746eso6538373c88.1
        for <netdev@vger.kernel.org>; Tue, 26 May 2026 14:22:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779830530; cv=none;
        d=google.com; s=arc-20240605;
        b=ckNo+LUc11rJ8myP1gUJpFEVlmJAZ5A9MFTccox2v7kTIEFI96RII2YkwTosrRUUVy
         o8kGAakBuSzothmFNlxAqWi6Nx/3x/yYZqSdZSF9FqYVTWaUPYnbjMCNofoMEF9mdBqB
         +Pnb6DRdj91hQzFOtFMx6O0b6TU6/tqyXNwimIjPuYT4kfVu7folMYMQqjARVgZ6PVAI
         GRNvtSYtXW7hMsJnEuVtKBWeGfJM66WZuroLKQZgUawhZTY8KY3Ld34IRV7G/NqAmJtq
         MvZtD9PK6cFiSngf5/w9RF546WHQCkMNq3ePnz459n7PaMFCptALJ0HYZQNjAkAj9Uk1
         90Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=VP4mbJpM8WH2IyEvSBYTVLRBzgCHnu41ehX3TVFH8Hk=;
        fh=lmpjazLiDPEHelNBNAmEXTrjt2HbRm5bWAtaKZQNkZM=;
        b=clUV7Xwh9MAVa3QiHY9FLtDGdqQsvNWRwXa2PXGAtR2071TIuF7copPGtwfMxZIce/
         gQmLINeEh8l1PDIeyAh00BxwGQJ8g/r5PJBe9uyPQ5HMzgJ97eHCEyO15Qb+EAe7B1Yz
         DHmk6BZtqXw8eTQNqj718bqRr2wWK2/Om/GjtoAOvycqx3h3aaeVi8Z4IL6JgNebQ+WH
         1q+W85H4rfnhwUjKGFvlc5jPFDnhWV66uOIajt0Vl+DXR7PfTJ8wWpop7L9mGwOCTdvC
         twpuZQ/rrDkGRqo40XJkSoH+IU/XWgQN3W50s6FHfUsg4dRWlkTzxMzD0FIEIfULmsMX
         1ecQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779830530; x=1780435330; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VP4mbJpM8WH2IyEvSBYTVLRBzgCHnu41ehX3TVFH8Hk=;
        b=vQhNTL8+e8b5J1mAiDM8tKggXDpSqD8JOqidf7yV9ca6HZZDKcd1o1WjjM1ZQXWKA9
         LItYMBazZHJI+tHwaCjs7XEXNbQS5IkGvDcb4fYZ/KsIBlQrSQIEsmZSZmblRtxJTHuo
         Gw72fhDTFDrNJPYtKjqF+IpYjOEmH8w3tXTqqYd9eadAoEQctuii7r5maoy7A5nQAG/i
         REjmy/kLXNQsIMHLh9Jo23HngDyxGACMkb+fBrU2Mk3hyZ3ji3eHaM20LM2qLgymLe/N
         ZJNq4hPjB3kglGQwK2f5jP0As5OIaYjBrxeFJ6/g5P9bXdAeY7N4fxh5FzGe+yA+lrnv
         AegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779830530; x=1780435330;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VP4mbJpM8WH2IyEvSBYTVLRBzgCHnu41ehX3TVFH8Hk=;
        b=Tcnv5GAs+Risb20xNQ/J/OmFqD9QEhj+vs5jF4QHXm5nzhRsfGHiZhw538QW8YxGmv
         XWMV12kSc6pBBxI3UsAfSr2nmtiwB8zZICs3MJLh7BQn2JcjKp/WXZiXvRHFOh7EZwFS
         xhb8iWS2ur8b4sK4Zww4R/vYzA9sZWjA1detc3EHZFJ64hXiUgasmwB+T/pkGBnf462l
         t8xphmuFQ7SlC7m9zZSRjXqtt4i5wYfF2WQ1k24p5EWpi5HZHp7NiudmVJR6J0VPWAjV
         x/9Ye48kTmn+bX2Tz8XHW01nB8HjfaargMYytqTUviYwKTUr7oNKhBWX71+oMefHvYca
         9LlA==
X-Forwarded-Encrypted: i=1; AFNElJ+8/23CZmcSUPZpigWjHYpVI4koRsPSffiBjKzuGfbDNGbU5/3/mZnqg1RAdmFPQBlvHgeaodI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxPeAZVlX3fk2v1e2L5EmkA6Rfn0h+UFzsKYPDhpLvxSImOMZyw
	WTb/vJB7ApCPb/ZzRKiWhggweSEUml/BnWwzVsnt8BU2Z+LI9C9H91h8TzVWeflbfhOVu/wUWDP
	WtpNxQeM6E9H4800M8ls3yn/97UJamEb2pbLDg+sb
X-Gm-Gg: Acq92OHz7FsFwoUt+LocXOAzIlm2NX3iDtwpBehnAZRu2V8V2TtBU0fCui71PJefDBb
	/jSRICqHoeZKuyYaTpxu6/dC+Guze4C3B7IHjWn2BggIjaNY6PaFbTpDLc9Yru4nmQJh8xu3mWr
	9XAteDjvZ7shpAeqBSOIovkfDwSl++xvG7oeR1/fLfMfY85DwKMHvQZ/8krijutADm5UOW4wOqI
	0hX3MnaR20WiaYxepT0BQXrEVgSOszJffIF4kUR7dN8zh4ozqQy1FtGdyYfegNFrJ33zC1IZoFr
	hqAkctq2veZsZ9Q0TtLlWePTKjDfwTQpPbgVfLLkN16Lj+8WemASylr2sw2NJDwISayiuh+r8cM
	8bAjEFoinXfejQg8YMJ7vWOIv1ReTIdTtljL+X0vYNc9EERwtsT7wdHFpYa7C
X-Received: by 2002:a05:7022:e997:b0:134:feba:40e with SMTP id
 a92af1059eb24-1365f600934mr6305256c88.6.1779830529265; Tue, 26 May 2026
 14:22:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523083001.2911931-1-kuniyu@google.com> <20260523083001.2911931-4-kuniyu@google.com>
 <202652620632.prOx.martin.lau@linux.dev>
In-Reply-To: <202652620632.prOx.martin.lau@linux.dev>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 26 May 2026 14:21:56 -0700
X-Gm-Features: AVHnY4IrxL6GuXy1gEDVGjcRdn1esdgGUIAOzsUq5l9tkNCP9wmrwYPRcO3ehEA
Message-ID: <CAAVpQUA0UNhR8AWfd0WC-krYJeXb0ebNs-V4u9kgweyNw_XHtg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 03/11] bpf: tcp: Support bpf_skb_load_bytes()
 for BPF_SOCK_OPS_RCVQ_CB.
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Jason Xing <kerneljasonxing@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 1:34=E2=80=AFPM Martin KaFai Lau <martin.lau@linux.=
dev> wrote:
>
> On Sat, May 23, 2026 at 08:29:32AM +0000, Kuniyuki Iwashima wrote:
> > When a TCP skb is queued to sk->sk_receive_queue, BPF SOCK_OPS
> > prog can be called with BPF_SOCK_OPS_RCVQ_CB.
> >
> > In this hook, we want to parse the RPC descriptor in the skb
> > and adjust sk->sk_rcvlowat based on the RPC frame size.
> >
> > However, we cannot access payload via bpf_sock_ops.data on
> > modern NICs with TCP header/data split on as the payload is
> > not placed in the linear area.
> >
> > Let's support bpf_skb_load_bytes() for BPF_SOCK_OPS_RCVQ_CB.
> >
> > Three notes:
> >
> >   1) bpf_sock_ops_kern.skb will be NULL when the BPF prog is
> >       invoked from recvmsg().
> >
> >   2) Access to bpf_sock_ops.data will be disabled by passing
> >       0 end_offset to bpf_skops_init_skb().
> >
> >   3) ____bpf_skb_load_bytes() is called directly instead of
> >      __bpf_skb_load_bytes() to allow compilers to inline it
> >      instead of generating a tail-call.
>
> Some observations below.
>
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> > v2: Explain why using ____ version instead of __
> > ---
> >  net/core/filter.c | 34 ++++++++++++++++++++++++++++++++++
> >  1 file changed, 34 insertions(+)
> >
> > diff --git a/net/core/filter.c b/net/core/filter.c
> > index 4a50fe2cd863..fa8a7c7d86eb 100644
> > --- a/net/core/filter.c
> > +++ b/net/core/filter.c
> > @@ -7760,6 +7760,38 @@ static const struct bpf_func_proto bpf_sk_assign=
_proto =3D {
> >       .arg3_type      =3D ARG_ANYTHING,
> >  };
> >
> > +BPF_CALL_4(bpf_sock_ops_skb_load_bytes, struct bpf_sock_ops_kern *, bp=
f_sock,
> > +        u32, offset, void *, to, u32, len)
> > +{
> > +     int err;
> > +
> > +     if (bpf_sock->op !=3D BPF_SOCK_OPS_RCVQ_CB) {
>
> bpf_dynptr_from_skb() and bpf_dynptr_slice() kfunc could also be consider=
ed.
> One less bpf_sock->op check in filter.c to maintain and could also avoid
> a data copy. There is a bpf_cast_to_kern_ctx() to get to a trusted
> skops_kern pointer but this will need changes in verifier.c to get to
> skops_kern->skb (e.g. in type_is_trusted_or_null) and this is the tradeof=
f.

Maybe a dumb question, but does it add extra cost (extra dynptr
function call?) if data overlaps two frags, or can dynptr handle it
seamlessly with a single bpf_dynptr_slice() ?

In our case, the data copy is ~16 bytes, so the cost will not be
a big problem I think.


>
> If this new rcvq callback is added to the 'bpf_tcp_ops' proposal [1],
> all this will go away. 'struct sk_buff *skb' can be directly passed to an
> ops of the 'bpf_tcp_ops'. Supporting '*skb' in a struct_ops has already
> been done in the bpf_qdisc.
>
> [1]: https://lore.kernel.org/bpf/20260519215841.2984970-11-martin.lau@lin=
ux.dev/

Oh I missed the series, the struct_ops conversion looks nice !
Since this work isn't urgent, I can wait for your series if mine
churns it.

Jason's series is adding a new op, and I guess this can be
integrated too ?
https://lore.kernel.org/bpf/20260521135244.40869-5-kerneljasonxing@gmail.co=
m/
