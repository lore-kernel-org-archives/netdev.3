Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7461F4AE127
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 23:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791328272; cv=pass; b=P1oNvuyBsY7CopGdVSpxUfDYTZqSX4+0yt+1GuDR6QDSfV/SC9f/SNjsaJn/eye2Gemuy9i8AAOm6c/W2lNx4qjAjIMTHU6AvtCdlk8LAL0D0jACQYl33CtjJDsmrYlnCnOeE3ulv8n2PyC4c9eV7ewMt3yP4bsZ6Z3A8cNLUL0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791328272; c=relaxed/simple;
	bh=CzPyoKkLuN6YdefgiA4a4Y9SQlN8BqOchdi34oZRDM4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mFJorAKiyxdqZiSMwgLcSHUNsDHomzWgW1LzAC3fxQFO/kcbkRTEaBHbk1AoGNRkOHvzOwVGEX5IKzc65tiTEhqlbj/Q1InzRjZYI1neo/RMkpy5bqf97/IZDrAndiJ9trYx5bQ1VlDLkaxfh3meruXO3u/i8P5PwlpLcwhPNsg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pRVDIVqK; arc=pass smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pRVDIVqK"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-4af7283bf83so544597b6e.3
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 16:11:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791328268; cv=none;
        d=google.com; s=arc-20260327;
        b=rtJBvR/IRYJlh0mNfKGxcLSAivf2aBdaVYEzwFiDy8tmmoApHb3E6qlBkNdhUvKUe4
         PcDFtmyuaNnd6M0ysXMqfEvZKUujReV1FS+altANdBEYovdbXIeBEjop6/HBndG4zVDX
         I03QcNiHfD2oElSya56nKrZ75nj1M2ycKc7iKgsZUPvDZkyGRhtvN2JeVXnbINljjDE4
         +TicxaOfvEiyzEjzSD1kxUBoRp6ziKNmAuP6YY61WQR0zJG5poGjoOSlWdkCvvGXvSNq
         hUK9sUQr8sjHoJ7jp5RRWuyLVUXfDW8Hog4TcXhlP0/ZJEad26HB9bc/S8v8v44OmU+k
         gKLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=SVgHFCxZmWjJoybenBY5+/9cQs47rZgohH/Njdib7q0=;
        fh=AGs+i9S/6YdhsX7l0Uy2AeDUeEwY8Su4t2wPWQkv0ro=;
        b=cICrycHElV2CDRhr0grIk34xQc0RaGv4ZDnghc781TvrYpeOJnXYBHNRQt04CPekZU
         Zttw2AfBwYgePT2N/o4zln1RCyD7JNFHGxAD/r0uV7zIo0n4R5Tejk9mdOpAtZ42ZHvr
         CQhem7IIL2dyZMGwLZhA6k7DxE3DBkjXUjaQCxY35BE+aeAiZioNyQpl4IkSDRlz3Rtu
         qzu6UnZ0eEWvdXi76uvC4QJUwO2U1ts8FIWZxWWYVBlCmF2h8dsbKnumQPwJnrvbBO+V
         M6wGw5j/9AMUWodznipoh6ixC9LZL4w7G/vp4I07norqnrROr7Xo0ybbod+yM+LArple
         Djww==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791328268; x=1791933068; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=SVgHFCxZmWjJoybenBY5+/9cQs47rZgohH/Njdib7q0=;
        b=pRVDIVqKqtWtMXWjxjzAlIUtsZodi8wRQAKYbkSZyH166rRx8omdAC4N2rvXE0BtZc
         pVEMLk03XY/MayzCBTKticARmvnpFEBTbXnnrDdlbIv/duZMY4F2Oi0GWVA7MNb3Zg+m
         lee0jZ3u3ygWk7PDFeY5g3XzJwC34C6Np3lJHl8pc51IdyNRsVMXh7O6IY3BqP1ecscH
         5ewj/+taVR0tdr1OSCjTyhYhs2kFFUyFVDT5T77q3HgeFFwn98qmaBLQrsGFZO0qpglb
         M9hw3x9AnIUNTnNEaIoGt+kWoVPxAnkFO33ESqYmwUljYHNVR+DwVCJXIlDPYOcHPxwW
         WIDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791328268; x=1791933068;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SVgHFCxZmWjJoybenBY5+/9cQs47rZgohH/Njdib7q0=;
        b=wkq4/lF4D+E+hdWJfdYIDdbcT0vM0+N4QynNB2aXeVdGzb+zqCBDWOM4AGaqCDV+FZ
         riFUdyCf7JuWOw3ltZSKHzroh2y5dmdsvuOpsivDmG/jvzXRWZQI0c8AgmOSRrdO6wGN
         n7xNTKNl1Yy6Xa6bYAGu+06jM8cDzM4WGl9COiz/4Vz/he+IMnccOg27lN0qU4aigHrJ
         bixcOS6Aw8NXWquoaEbFEL/tQeM8DSIuhP0HfzQq2MzNOfA9R1PzEC/C40hQ5iN2NV4H
         p0JRWn0d/+I/gb0gJY4H4GXP0rp8UoauvLAZaf/YAakH4IfegM7j8bI5MNCQIGtc93LE
         rP8g==
X-Forwarded-Encrypted: i=1; AKwUvByEbmbrKmvZjsHT6GYWH6SdQh/13oCKXklkLDgMuuFoNFCzF69HgTrWCL9vIvZ3As7oIn8Sk5c=@vger.kernel.org
X-Gm-Message-State: AFuF++lY8qSi4OVnDc1XMcBgJTvb1CPKMejfZaZQhz6kKzVdScyp7fjC
	MJQzo+EL/s3TAyk3DjbngHNvQwjfMctyGvQpoFoWyMywtFwG3Y5ZhILuyeR71hBGZTY9RQeg6BS
	3XB7ouoV7LmslTZcB+WlMazgbDgXHPhE=
X-Gm-Gg: AYBFou3g9SxXIsdEY2kedi9aB4FsCdLqFBKUsGU5lp0SuUq1t9PxFCuH4jYkd0oNB+U
	kXg/D2gj7AuUH40SRlBTdxVNNRU9Ov3GV85AS418UnNtiAxOsHnAY+azRsIYHJMqf8XapdQz8g3
	8VVWHJk8ulSmNl0kHggRVVmD1SU+ot9jAbMhOgbbps3Vy4LbKGG7563Phtmkfg+SOoUl15aEBk+
	MdRKKfHx9EgMGdpjEB1mA1p9fUIQa2p5bZgVdMgLR6MZJeOXqzUJHB9AJPVDeCQU8Tvgoq6zveH
	YjOkoP9nZOSTCzAQ/Cfp3GUb0uduSxUBSJnp0BuH5iXsAMjDDloHHow=
X-Received: by 2002:a05:6808:11d1:b0:4f7:d324:bc5e with SMTP id
 5614622812f47-4fc481ca2efmr737042b6e.58.1791328268160; Tue, 06 Oct 2026
 16:11:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006192601.1875100-1-kuniyu@google.com> <20261006192601.1875100-3-kuniyu@google.com>
In-Reply-To: <20261006192601.1875100-3-kuniyu@google.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 6 Oct 2026 16:10:56 -0700
X-Gm-Features: AclHuK_mNUq7Eu5hk01x19F_7PxCtz2jLajaGocqAK8srCVAPazrb5T94X-c_gg
Message-ID: <CAMB2axNu70HiFa+DAkia7oKhZ4ykKyV9bu51OwcPwoyo=duz3g@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 02/10] bpf: tcp: Add a new per-socket flag and
 kfunc for bpf_tcp_ops.
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@kernel.org>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@meta.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 6, 2026 at 12:26=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> The legacy SOCK_OPS guards some hooks with a per-socket flag,
> tp->bpf_sock_ops_cb_flags.
>
> In contrast, bpf_tcp_ops was initially designed without per-socket
> flags so that users can simply define only the callbacks they need.
>
> However, it turned out that even attaching a bpf_tcp_ops with a NULL
> callback incurs measurable overhead in the fast path. [0]
>
> We could reuse tp->bpf_sock_ops_cb_flags, but it is u8 and has only
> 1 bit left for a new opt-in callback, while not all of the 7 existing
> opt-in hooks are in the fast path and really need a flag guard.
>
> Moreover, tp->bpf_sock_ops_cb_flags has two bpf helper functions to
> update it, both of which require sock_owned_by_me(sk):
>
>   * bpf_sock_ops_cb_flags_set()
>   * bpf_setsockopt(TCP_BPF_SOCK_OPS_CB_FLAGS)
>
> Both helpers only overwrite the field, which leads to reading and
> modifying the flags in the BPF prog and then writing them back
> via the helper.  This prevents use from the fast path (tc or
> cgroup_skb) hooks where bh_lock_sock() alone cannot prevent races
> with process context.
>
> Let's add a new u32 field, tp->bpf_tcp_ops_flags, at the end of the
> tcp_sock_read_txrx cacheline group, along with a new kfunc,
> bpf_tcp_ops_set_flags().
>
> bpf_tcp_ops_set_flags() takes bitmasks of flags to enable and
> disable and updates tp->bpf_tcp_ops_flags atomically via
> try_cmpxchg() without relying on lock_sock().
>
> The kfunc is exposed to bpf_tcp_ops, BPF_PROG_TYPE_CGROUP_SOCKOPT,
> and BPF_PROG_TYPE_CGROUP_SKB.
>
> The first argument is struct tcp_sock * so that bpf_tcp_sock() etc
> is required for cgroup hooks, but not for bpf_tcp_ops where struct
> sock * is promoted to struct tcp_sock * automatically.
>
> The fast-path callbacks will be guarded by the new flags in a later
> patch after updating the existing selftest to avoid breaking bisection.
>
> Link: https://lore.kernel.org/netdev/CAMB2axMwBuz3X4Uwn5uzZUqm91EbiMnbQX8=
32wUFOQ44fOwDnQ@mail.gmail.com/ #[0]
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Amery Hung <ameryhung@gmail.com>
