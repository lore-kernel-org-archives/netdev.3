Received: from mail-oa2-f12.google.com (mail-oa2-f12.google.com [74.125.231.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A647A4C4F62
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790357646; cv=pass; b=tqZ0SoSPb1Y3AKAZLAfIAKHW8BnBfig4QthVzW9HlFSCrNsys7KryWQ6hkZsFVNS9E/LXOu+BmPlRH1KmJ/QROWF3Ng6UaT8gvLGOLMZbNFk3dU9Wst+sRR9oElfQe54x85YfFakZU4CaU2+d41Y/LOOzie1PPGJ6yaf57Xhwm0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790357646; c=relaxed/simple;
	bh=mQdnL9HsYodgPW9uFVatJWvbArhVGUHBOsTYFjgu3oc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fN5mcp634eJJavafys0PgHdfbWySH6ndgxoTl544wjRD5ISnw5dx9AZ/xd9D4YZ6UXr+UtnDTvbRa2Lro3CN/xIsrZaEfgjqqSZNwIS/eNTvJTv8o+ARpCYy0lfS5nl/PXSw6w1g7ztk9RFoXJoKjKxFj4Wef0TQPjeGfZarbQw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F/ckpnlW; arc=pass smtp.client-ip=74.125.231.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F/ckpnlW"
Received: by mail-oa2-f12.google.com with SMTP id 586e51a60fabf-4788fe5736eso878568fac.2
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 10:34:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790357643; cv=none;
        d=google.com; s=arc-20260327;
        b=dLVhRQZUEgPhuNbfP4zgKpDB6INdhGTc9Lb9/cC9ZVsjd+482C77iq5vR3qc9TVS8H
         jBKqGMOHApVPDGVz0Gq5RRIaOTE2ry1iy5VxTreoTogvDQbZFcYOyoNU3DqGNBSVYpd+
         z+NvKYbAN7Y9wkGxSYMYUttpqUX1gpqjgLiK0JTlwZKB/EwEVCYQYIcEFyyZgs6HbCNa
         69hyTwk+XJrnYuvdmByAXYPvr/TOKv4xXpLa2tZWwM3qwuKofRCtPUZ7IKPVm/XOM7Un
         FDQGDCqF9xsRrwTyb2696Xt3Xlrztza6NnVKZvuMyaMUa8b36yVruu4dF2WBTuZwWvMD
         2sZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=N7CM5MKPS1617cb6aVjlWe3PLLcimRFckPzGRxTHdUg=;
        fh=1TDvppPzTElCjmNHcvj9UMUzpNBGP18cNr+fQTAh800=;
        b=UEYB/C7bImzlBJaQqAr3jkthfMtUuAV+vW72y5sgW6mzG7KE+eFF0R5dtmNiL345W4
         4xvwMEcRcLu8LMzL+0VgF8HBTbPfoQPzW8HSJCvdZWaSSxH94pk3GNFidV8Yx3c/tw46
         fclZ4mSC/NxrVThTEzCRvLAWxlcpCNwo9aQVIT1+hvrSH/Qlw8cc0EfmxF9hY+zkAEwE
         Z+Dkp7F4U0xlymXoBXXBeRCUxqjoUx336ILggFXPhtWYj/otqR6gmHEuPHntBhs5oKbq
         vYD4QAVRt0Kj9DtXqg+kGgfubaGOiyLyc3iwgfEvJwxP5WB56gXqXfQcevVjRFGmUAkT
         71kw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790357643; x=1790962443; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N7CM5MKPS1617cb6aVjlWe3PLLcimRFckPzGRxTHdUg=;
        b=F/ckpnlWO4XRZZ8EydSk4aCsKkhrRv/F2NqWzYdfma6eJUYprgYyF18WRvBQ1rKBO1
         Lt9j8oVe6ATxh9+/aaM8CHT0PdZ0U9AMP/gsYO4NuyldkflNm0Gnltwx+Jur5lBVNGmP
         9xhBqipd5KoBYWzPDWUR3WeYI2XYQQzdwX24Nq4HRpElmsLd1I0zC6JvLtur0XMtQBUU
         gmGg+qQE54oMOyvvz/1tHxydTSHwFD3VWveWRvXCPbe3Z73YjQREa5WaZmX8CnxC6LVH
         pJKQ+QGxomaY6nNhxzN5KQfEdRFACyns0L5fYkfeK78ykCwIX60+LttXDUFF1dG/f7sf
         oSYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790357643; x=1790962443;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N7CM5MKPS1617cb6aVjlWe3PLLcimRFckPzGRxTHdUg=;
        b=xZOipmS1svZ5RRh1oySrBK3rYrdklJUq7hVwIH9WqfYgigzOPFHjMko4u2LLMwdUDj
         Iq6RAyJZfdeGH7Wbw1E3j+8FQEpafJfAeJXbJQR4F+J+A13+2OhbbDcctYcq0Sjw6AeX
         IBAHltcKE4SVt5HRQ7qEHVnWcVPbFxWbCJ1amt7dncLtkE/4v4davzEdDyHI7D2/97Dn
         5WIJzXWhnVAZd+TBHmq/Gmb+dZ2l6s3gIreXNDfTwaFdmXS4IGRsX0lLqMRPlFrZREB8
         ITGXCva+4VOKYjq5F35V/0tRM21OUQIUKLzb1tdE4WPLIL425pZD2eXzNyCPxpJD+t8X
         HLGA==
X-Forwarded-Encrypted: i=1; AKwUvBzPQvsvPzUayVHKD5sif3UCz0WXorqhsQSzQN8HvYPFBp5P4M3Vy4meRx6bwH4kcsZo+A93gtg=@vger.kernel.org
X-Gm-Message-State: AFuF++lFT0Jgq3am6BZu9gZB9oHVHc7BLg0M7Z+mAd89K1HK0w63NFh3
	A6qZOpQHVSU8TULknvBY64n0tl9rblnojfbiNL1lZHR6W5pPxpoeWbzQADWd7vkOv3fHvl2aZhO
	MI/I66AijIHNyRzEmUJiTgxHaMBFTEXI=
X-Gm-Gg: AYBFou3ZmVlT2QGjo0X+qIx4zkABBkJnkm2Pu+TPZM/jtTPBG5EexFyy/5hApbJBg0W
	HmcyLh9gl+AE/8mHdEG7uRZt8IcXwMT9of3CJy2GZ1ib7YeXPuvPgMW6idbtn4eaNgEX3iXlter
	Efv+uRC/K2VXfSVeKbom59Uf6/mtGYV04Wd84sCtQN3MdYSnYHgcAvlU55QicBoH8AwLf3xwv/G
	4nnL1rP3ENAFnt/lGbb/STQGDTpkdBe8yDpUUpE3duCJ5c33jjKiNzHSN80E4iWjai6JKgC1k9s
	hOXjMejYs/JsxH3LkvSbWUPz5hKjdrvk4N4qO0xxHrC7a06flxtF04DWy3MF06MH3g==
X-Received: by 2002:a05:6808:30aa:b0:4c6:eddf:ca6f with SMTP id
 5614622812f47-4d728922debmr8500114b6e.12.1790357643082; Fri, 25 Sep 2026
 10:34:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260923213719.224838-1-kuniyu@google.com> <20260923213719.224838-4-kuniyu@google.com>
 <DLNYI40PF2Q3.1KYC8MHZU2VJ@gmail.com> <CAAVpQUBGSahLGEqGQCD2_0Ro2e-=59W7mhVyxOnoFU==LAK9tw@mail.gmail.com>
 <DLO0KBIOE5JY.3DY4JTZOWT5IU@gmail.com>
In-Reply-To: <DLO0KBIOE5JY.3DY4JTZOWT5IU@gmail.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Fri, 25 Sep 2026 10:33:50 -0700
X-Gm-Features: AclHuK-sff44s794tgsAcngyJnbbpblhhK2X94GJjlaw8Y4g9ipYLVjR2x_AJcU
Message-ID: <CAMB2axN93iJnrZAk6hWraSnz32FtRDdpz_UbzsVB4YU7gRK_3Q@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 3/8] bpf: tcp: Introduce bpf_tcp_ops.{enqueue,dequeue}_rcvq().
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 6:41=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Sep 24, 2026 at 05:39 PM Kuniyuki Iwashima <kuniyu@google.com> wr=
ote:
> >> can we drop the flag ?
> >> hdr_opt_len() is called for every tx skb without per-socket opt-in.
> >
> > Oh, I assumed bpf_tcp_ops keeps the same behaviour.
>
> bpf_tcp_ops were moved out of BPF_SOCK_OPS_TEST_FLAG() guards on
> purpose. None of the existing members has per-socket opt-in.
> hdr_opt_len() runs for every tx skb, rtt() for every rtt sample.
> See the log of commit 3bb54768fe3e
> ("bpf: tcp: Support parse/len/write header option hooks in bpf_tcp_ops"):
> "A per-member/per-cgroup gate could be added later if the extra
> fast-path work proves measurable."
>
> > We have a bpf prog to turn the hook on (from cgroup_skb/ingress),
> > only when ingress rate exceeds the allocated capacity, to signal that
> > via a custom TCP option and turn the hook off from the hook itself.
> > (and I planned to post another patch for that)
>
> That should work today without another patch and without the flag.
> cgroup_skb/ingress prog does
>   bpf_sk_storage_get(&map, sk, 0, BPF_SK_STORAGE_GET_F_CREATE);
> when the rate is exceeded. hdr_opt_len() and write_hdr_opt() do
>   bpf_sk_storage_get(&map, sk, 0, 0);
> and return when it's NULL. write_hdr_opt() calls
> bpf_sk_storage_delete() after the option went out.
> cg_skb_func_proto() has both helpers and get_func_proto() in
> bpf_tcp_ops.c allows them in every member.
> egress_read_sock_fields() in test_sock_fields.c does the cgroup_skb
> part.
>
> > Anyway, is it because calling bpf prog is not very expensive
> > or per-prog switch is preferable to per-socket flag ?
>
> The switch is still per socket. It's sk_storage instead of a bit in
> tcp_sock, so every prog has its own.
>
> While such new flag is per socket, but it's one for all progs.
>
> And you want to take the last bit of u8 bpf_sock_ops_cb_flags...
>
> As far as the cost. A socket that didn't opt in pays for an indirect
> call into the prog and for bpf_sk_storage_get() that finds nothing,
> but only in cgroups where bpf_tcp_ops with enqueue_rcvq is attached.
> The members that are not set are NULL and bpf_tcp_ops_call() skips
> them. That's what hdr_opt_len() costs on tx.
>
> I don't remember what Amery measured, but worth benchmarking
> for your case.

I did not benchmark the initial bpf_tcp_ops patch set, so per-socket
gating was deferred. Before deciding whether to add such a gate for
AutoLOWAT, could we compare:

1. No bpf_tcp_ops attached.
2. No-op enqueue_rcvq() and dequeue_rcvq() callbacks attached.
3. The same callbacks performing an sk-local-storage lookup (or maybe
rhashtable).

>
> >> The prog in patch 8 already returns when the socket has no
> >> sk_storage.
> >
> > Yes, but this is only for bpf verifier.
>
> tcp_init_autolowat_cb() can be the only place that passes
> BPF_SK_STORAGE_GET_F_CREATE.
> So for a socket that didn't do setsockopt(BPF_TCP_AUTOLOWAT)
> other cbs will return NULL on lookup.
>
> tcp_disable_autolowat() will do:
>   bpf_sk_storage_delete(&tcp_autolowat_map, sk);
>   bpf_tcp_ops_set_rcvlowat(sk, 1);
>
> > Just an idea, would it make sense to add a kfunc to move bpf_tcp_ops
> > callback to a shadow pointer by allocating sizeof(bpf_tcp_ops) * 2 ?

A bpf_tcp_ops instance is shared by all sockets, so this would not
provide per-socket gating. Making it per-socket would require copying
the callback table for every tcp_sock, which seems more complex than
adding a gate directly to tcp_sock.

Am I understanding your idea correctly?

>
> Doesn't look right to me.
>
> Amery,
> please share your thoughts here.
>
