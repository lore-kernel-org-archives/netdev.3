Received: from mail-oi1-f179.google.com (mail-oi1-f179.google.com [209.85.167.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2ED7314B66
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 19:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791227431; cv=pass; b=CknHVA+AzuKasUpj1xp5EsdFeAzEJTK2nJZdUjcKITbLpEcaurvrWPQJ/vXuHDYgz5aqoVjpNa2KjCydGeJ7K1HivVy92h5ycRty8d/lnNvb2M4kPM6Db8swhVqeeQ1qMDJyR/tuNyfuxKlpMxRapqkIzcDRh8+jEw/0no9LRaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791227431; c=relaxed/simple;
	bh=20WXjzJT+PbMKu2GbgSthOHdONEfZvO9MLXB1Gc08nQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WVrUbkcmaaPyIGdDgJy/utDoDynC/cC7Vt0jmZMlvCAGu7m2kVLSVTLSoD4IuK+CtrwvbukTu3pr5uV3oEWliUovdyNTV6aKLfK0R00rLD2RiLywAJJTf9LtbVxHue1p1LfEVJxQ8wwarKhCeU/P057hPckaZ7jHIZ51ukJ60ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r7MurOY9; arc=pass smtp.client-ip=209.85.167.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r7MurOY9"
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4f6d98ff6c7so1342413b6e.0
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 12:10:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791227428; cv=none;
        d=google.com; s=arc-20260327;
        b=X95j/RIZR6084hfrdwaYHXol+WHsv+DwWXN5L4AlUT4ZeZ3sn6yWbWA1x51qrmFJ00
         BugmyjqYhhksqBy71ZzlqWpBIa6bFGa8K01sbUeMx/Pvqpoj3r5HB9wnqXS6rPu7fELY
         fvg95zKo5dJXCQy+Ck4QUG9AfYQ2M9QdgTdNUwvevxu4uwn+gyeaKl/v4BOFVJsy0Ws0
         j4pBxDqvcNZl3RMviQEVeiJEBzlcByIM1XoKQFl8P6UFvLccurHCvfmmjXfT0CfVjRSm
         4d+DNp5woxaYdeR/ick2vp322cYHZgd4vGi48UK+FYe6wCd8fxXONZI4BKStAQsp6NCr
         c1hA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sZ3adpDGT261XkCW8nTjunmv9uU6/6OcdwlNEH7xpts=;
        fh=p7qTWCJ48BKtqjAXxioD+nCYyHoMPQxro1KGxAfQAhc=;
        b=UgJ8cnNPIrI6+o1viJPa3mY5TpqB6mgj5A/Ja8Ht29MY2SKvk7vGkZB9g3ndUQcDFI
         bkMEGD70PEcDtClGIjMakH/EzhTl9/b89qn71TvNR93mtcwKZfbuRQ0qkdhg/eVeHdZq
         Q237FzW3jTmMCwq9YHD0hKgZrjAw1NjnbFvcx0APVWfvsOOuO5uQYqJ+DvhV737vTJIQ
         iKLA0FJWwLFVZtgBne7WBZgK774EEjGNdLgexLFUYeB+9X/qxFz74pvXtzJ5ohZ1gZMM
         W592d5XNG+Y99TL9xLirlv/Omqla+6PH3EMbtEM/rXu7xU4Vf0Cp/OoaANlIrUS6pqB5
         76fQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791227428; x=1791832228; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=sZ3adpDGT261XkCW8nTjunmv9uU6/6OcdwlNEH7xpts=;
        b=r7MurOY9qaX7Ko3JHJ/rmuMnq4fCSsq3Zs1UVa0JTxvWjMet7V0geG0bl3VUyA3s/O
         poH1F4N/ObmMOftUASLPYU/Q0mJ7HJdxSk0GXhhtdUtcYVpoXPFcSuaXCRVdpCz0U06p
         PebWa817y8IylwjvTEkda7cjHDPpzdx7/uM0S/rF/mDesRuR6I6N/XrUoHqJkGugiFRV
         DC8M1vShRN6sD63jsZ6GZRYIsLHoqT13kh9lkU+CYHreZcu2nLN4RGUTshbqUPfuVGDW
         NWOMuCMoU+pa8LwlChSlTv/qPyxuPshcLv0GMYCUSxsfhXcxY+RVq2dnMYcOYnTaF5Ur
         o9/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791227428; x=1791832228;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sZ3adpDGT261XkCW8nTjunmv9uU6/6OcdwlNEH7xpts=;
        b=TIxppbS8gfOu4FB4NPfz0TMzhZjwX8iLqmdRyfTBz8bIrBs7XUn8IaoagjZVixUtz4
         xfePf+fBkq7BUEZZATBiCeB3nN/d2wwOuEsNymJrRDhH9U3gpjLC1x45NnR1WUe66JIm
         Ytota1LKZj0lzICFsZ+aNQNW1fDVwKjuSjS9Q/GR0tbdx1PpIxaUf5x73RTm5Zd+qaF/
         V4lO4ZYzT/aLKl1jyGhTFQF3lRiTEw3f/lPOyBuPnX5UMXo6HsugBpO3i1mFClKpdkuJ
         xK0iUn1Gy3sWttS19bcHoXK4gZ51dI8aLqZs+jF3Blt6DWmEpxhvJroZ/+yXfiHVgF88
         +mBQ==
X-Forwarded-Encrypted: i=1; AKwUvBzmF9IAOhjJP3TXTNXdF20z+E3hlwAOd7hsoAUgMJTyz/KUD2kPkSWBmEj6FUG8f36Zj14a9S4=@vger.kernel.org
X-Gm-Message-State: AFuF++n3GNQrJXH8WffUC6IZb8sQS3tyrLDtvjOYBejW2yB1+hzbhkVL
	tYyDR7KiyN4Kat0rAzNUP2eJz26yNLl5mcBA30qr/TYxtsiT8MqaG28Iffm7F46/UH0+7U7BHR4
	+Of+eFmeYQWnFIXlLtr8tPK1eOqhUCws=
X-Gm-Gg: AYBFou2VPGtLRaIimi+vLBHRVMwAmGr9CZ3t+7FK0kcpdVS1m5evd6sjMIzhJAewW8M
	/RD23HT4GxVsTAtBHL0LFsoFKpl4pbuLe9pdnGbYCid2bpDtQPSh+9ky+EJeNtCOs8RfurQnG+u
	Dfu0LEumk7+GFfi24MtSufdLQGXhFK0T1q88LdKnyS1l4hTN2BPSalDKeKGZhNxjrJxCROGkzeB
	XB/fwl8xWpB2wUN4ChHAbv/t0xxzxtrTqMQbHplESCXlvA6VE51+BeXcbduvJXCQOtFoJFt9ZPg
	Xu1tbhLb/GtaXip1WEUboR48HFW24lUaKXha5/dQLBhNL9LNT1sXBm6kB10akXjXb/2UrGw=
X-Received: by 2002:a05:6808:10d2:b0:4b9:e6ab:d088 with SMTP id
 5614622812f47-4f67a717bd1mr9488930b6e.40.1791227428596; Mon, 05 Oct 2026
 12:10:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005154533.4147685-1-kuniyu@google.com> <20261005154533.4147685-5-kuniyu@google.com>
In-Reply-To: <20261005154533.4147685-5-kuniyu@google.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Mon, 5 Oct 2026 12:10:17 -0700
X-Gm-Features: AclHuK9xBuDSZmtHYBnaJWw-Pci852n_5XSt7zgTnXSPvmgFC3rvtB2s4zNdbNw
Message-ID: <CAMB2axM9iTXqAGkQ3LDB-BRtqs-dVrkoHX1DkXT72KVYjrHQbA@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 4/9] bpf: tcp: Guard fast-path
 bpf_tcp_ops_call() under per-socket flag.
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

On Mon, Oct 5, 2026 at 8:45=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.com=
> wrote:
>
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
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> ---
>  include/net/tcp.h     |  3 ++-
>  net/ipv4/tcp_input.c  |  7 +++++++
>  net/ipv4/tcp_output.c | 20 +++++++++++---------
>  3 files changed, 20 insertions(+), 10 deletions(-)
>
> diff --git a/include/net/tcp.h b/include/net/tcp.h
> index f69091f5e01f..48487135c076 100644
> --- a/include/net/tcp.h
> +++ b/include/net/tcp.h
> @@ -3142,7 +3142,8 @@ static inline void tcp_bpf_rtt(struct sock *sk, lon=
g mrtt, u32 srtt)
>  {90
>         if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RTT_CB_FLAG))
>                 tcp_call_bpf_2arg(sk, BPF_SOCK_OPS_RTT_CB, mrtt, srtt);
> -       bpf_tcp_ops_call(rtt, sk, mrtt, srtt);
> +       if (BPF_TCP_OPS_TEST_FLAG(tcp_sk(sk), RTT))
> +               bpf_tcp_ops_call(rtt, sk, mrtt, srtt);

The new per-socket flag load happens before the static-key check
inside bpf_tcp_ops_call(). Thus, even when no bpf_tcp_ops is attached
anywhere, every RTT sample (and other similar places) now touches
tp->bpf_tcp_ops_flags, whereas previously the path stopped at the
disabled static branch.

Can we add something like bpf_tcp_ops_call_flag(op, flag, sk, ...),
with the static-key check first and the flag check before the cgroup
lookup/array scan? This would preserve both the no-attachment fast
path and the flag-clear optimization for attached programs.
