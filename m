Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2DCC4DD3AF
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 23:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791329224; cv=pass; b=Zf8SjlAlV2Z+XXMKu6xNbjlcDY4XO8x5xjFMxml41lRMHwQvbDQCi86Hs7bNY4NpE163RaiJua7hSZIxqDFwwVS4KXwUclPa+9qS36+qtSssbmErmAM3zRD5DheH5K0U5DmsBvT3V2yOtohOkyKzVJ6wojo0JKKOp+eyKmrxGLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791329224; c=relaxed/simple;
	bh=WunslqB5YKhLVotec1PHOF5KiS7M7/wTxG6M6nwGcbc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QoyEZJZT4Os2xpyOYB4iifqKRTk+dengpUN4ERUDWS5M9qqb+M1GyAT0BWT8xYFV4PBeVRwHxBRKQ5YEBMnwevTrLW6+GUgPgbClLSZ3nmZyx+849DfLW5FQ+NYmjpq+5i1tYvByAPsTFrsuHDCDKU6sgYrcYA+KFGwj66BfAXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxiZU+b9; arc=pass smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxiZU+b9"
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-4c382ece86fso619832b6e.1
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 16:26:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791329215; cv=none;
        d=google.com; s=arc-20260327;
        b=JBLXyKyQE39v+QzxFRtYl3V2Zgh0Ke0qE3OkDAinj0QyMLLPDRTXhhLDjfXB4tIwcp
         k1gHZeo803OO3c9LBN1Fhq/wiLaIpQp7oJdUupC6KBSnkiDfEG5VYYqqM/vy4PPsKqdM
         KEJuFQrxikC/ruVeHcn4yBcgWl3DiEiC9GEjckCav+6mrNto/XkTJUU0U3bMC6XbJNiy
         mrXMLEnT7QuRDpq1LEl7CF60O/umFhFXXE6ryjTFxDCVk0NVphKb7w5q5Y2ic26DzlhH
         TZcPJVsjflAaVyWQXimsANFDmfz7yieMyHnCs3uFvcooCuiYhu2WuzcbDSCxAA/nUbPz
         0GJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0Muryz2ncQWQVUJUZhNlaoj5Q8piKTLbGEkI4J771Vo=;
        fh=JhvRvxEvK/xdQhe1QkNPGpjvPRUhMRthfft58aYORH8=;
        b=YmuUXVdkh5kDBlu78NWmXCZHJVQHGsS0dJnirxSEKa8bwb08eHNIi3CWUdyUS7Mlzd
         69zbp8JnGiJxQhgM6zDral3AZ318IHg7DMNOf6AS1yiLgVOYFTxDQsqTBrLVPZ0YUjmx
         8vWJ4l5rA939m/dmGrktk1W9Bv6o77IbjkHS6CGgC9YPRwz+Y9+blpWOKg0knwkJ0Aol
         mWGd5fz5jJ/QYFBX82gqPaMy/tIN06tt53qivaSUNKrLA86U1dNroZ4ygiTJyxpu/wSQ
         Ozp2cmpdwaSX77eHc8oxnZPVzx0Lr96K55vnznmXdqVHUZpaOYr1EWEoTHF7CunSh6ch
         5Fhw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791329215; x=1791934015; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0Muryz2ncQWQVUJUZhNlaoj5Q8piKTLbGEkI4J771Vo=;
        b=cxiZU+b9XkIGt1ns2RoixoojLzs4BIVaJMFdBdjxDAVP18d+ouDvQCde9ALw9CRvvz
         ka/WwzjLP5sNRYv4aym/ifqnNHRm3qRLVOpq3is+hKvMywYzGPaRao/tmnNOw7x8wAR3
         9YuDXj8LJPge68rxI7brfRcpzyW7GM4MUN+F+99Y2ijjRyx/hP+cn/ZBEu5pT9hSz7mR
         AjAdfWq21gK8Vbj0d6fXZf0boJioQFd85Alsjv7K9VVzA5fmmBUtAFnM5/VKaeGny8jL
         JdCNH5KfglwSjVcGxuQ458HJ/+S+RVRiVLD5RZz4fEFRWKVqBqF7a0Kg14JJRDYeCf5X
         kDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791329215; x=1791934015;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0Muryz2ncQWQVUJUZhNlaoj5Q8piKTLbGEkI4J771Vo=;
        b=B9ieUTV3AkEnv6d65mxh5nF2cUP07Kl+R0XqUloShiSF3jwadQ3YdPuad4b00waayB
         SbfSBHHXWdlkpVqy7hOELDjjALBQ9egQH0qWTA8+7ORF3SivcO955dbKcFaRtb4V86ot
         KiCqOebmEJ1OGnlgRhpF9C0R9n986ptCi3vvQne3E3MTrXJv1M2kyR9zd7zTKmusvxRR
         WIU7O4Y41qrbpqM8o9TLNgkrPRRmSlpfMb+xDHqP0eFlaadcTTo/fYZj7p5df4WAg47T
         Ot9WYYAYxnCzgRkhV5BwgLq1Ec/gJaOmESPUDP6TKHD6DnB3r6qjh3vi6zouM9rkNQLC
         6i4g==
X-Forwarded-Encrypted: i=1; AKwUvBxlkp2AvaQGOxxTvVDCyTSUxLXZQbJK14pfTZc8bDAB0/vM5sEhScvNlN0WH5MMK3H36ORfk94=@vger.kernel.org
X-Gm-Message-State: AFuF++lvbos5fWLRtj1e+LdwGlu/0UP4YA0S79cAARAAyY7UawM1p/BB
	GhbVB9Rai0aQ7jSvvw+pS+a4SWVIDv9Fi+twKmW378tG5BfVHXFxW6XvPU/T90wFkdYfuFovQzn
	bzjdMEKf+cP0xICzRxA0O2XdL4VuL7nY=
X-Gm-Gg: AYBFou3MUi8VjJygpkB+aTD4cQ0LQDBY/uUT9jRvU8dcmISa18cAho8cBg1SYjqDNht
	i95C2opgWBi6QgwMTW005sJ5iVL53xsupL/Vdndfn4v7m7UuAClHnehAtzbVmzgNJ7f/P2R6xXA
	j6Q5eVaDKqhDfiJFhS0zQKhMWweLoYJsOxlr3BuudjhCO+FWKbBUSvW//AM0To9imjme+hgBF+Q
	Cck9BWjmvWd1hMTX5XP+zvZvkV5y/KF1d1VcPkFl+Cirv4W5QAxceRDcnFY/7DjzWldhswwNRSi
	5xDnPo1g7Lt13j/O/UTvEI0NF4v0vqEtfLfWZs2Hyv113hBvU5ULJlE=
X-Received: by 2002:a05:6808:2387:b0:4e8:3e98:6f61 with SMTP id
 5614622812f47-4fc435f4952mr860001b6e.3.1791329215149; Tue, 06 Oct 2026
 16:26:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261006192601.1875100-1-kuniyu@google.com> <20261006192601.1875100-7-kuniyu@google.com>
In-Reply-To: <20261006192601.1875100-7-kuniyu@google.com>
From: Amery Hung <ameryhung@gmail.com>
Date: Tue, 6 Oct 2026 16:26:43 -0700
X-Gm-Features: AclHuK88uPqLrKz3hOWsZn0eh4oxKR1nBrtIDVon_wLhkhepNPd35m3ItlLEBuM
Message-ID: <CAMB2axMTi71cr7_DR=E4Nqm+46-zADW-YJ346vrR0s-re1p3UQ@mail.gmail.com>
Subject: Re: [PATCH v4 bpf-next 06/10] bpf: tcp: Introduce bpf_tcp_ops.{enqueue,dequeue}_rcvq().
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
> Waking up a thread per packet is expensive when an application
> processes variable-length frames (e.g., RPC) that span multiple
> packets.
>
> SO_RCVLOWAT can defer wakeups, but because the frame size is
> encoded in a fixed-size descriptor at the start of each frame,
> the application has to:
>
>   1. wake up and recv() the descriptor,
>   2. raise SO_RCVLOWAT to the payload size via setsockopt(),
>   3. wake up and recv() the payload, and
>   4. reset SO_RCVLOWAT back to the descriptor size via
>      setsockopt() for the next frame.
>
> This requires an extra wakeup and two setsockopt() syscalls
> for every single RPC frame.
>
> With SOCKMAP, we can parse skb and suppress wakeups in kernel,
> but SOCKMAP adds overhead and also kills zerocopy.
>
> Let's add lighter-weight opt-in callbacks to bpf_tcp_ops to
> replace that.
>
>   .enqueue_rcvq(): invoked when TCP stack enqueues skb to
>                    sk->sk_receive_queue
>
>   .dequeue_rcvq(): invoked in tcp_cleanup_rbuf() after data
>                    is dequeued from sk->sk_receive_queue
>
> Those callbacks can be enabled on a per-socket basis by
> bpf_tcp_ops_set_flags():
>
>   bpf_tcp_ops_set_flags((struct tcp_sock *)sk,
>                         BPF_TCP_OPS_FLAG_RCVQ, 0);
>
> Later, we will add a new kfunc to adjust sk->sk_rcvlowat from
> these callbacks.
>
> This will allow the bpf_tcp_ops prog to parse each skb and
> dynamically adjust sk->sk_rcvlowat to suppress unnecessary EPOLLIN
> wakeups until sufficient data is available in the receive queue.
>
> The placement of bpf_tcp_ops_call() in tcp_ofo_queue() and
> tcp_fastopen_add_skb() is chosen to provide the same snapshot
> as tcp_queue_rcv().
>
> For example, if bpf_tcp_ops_call() were called before updating
> TCP_SKB_CB(skb)->seq in tcp_fastopen_add_skb(), BPF prog would
> need an extra branch for the unlikely TFO case to strip SYN.
>
> In addition, the TCP stack can queue overlapping skbs into recvq.
> Once rcv_nxt is updated with a new skb, BPF prog can no longer
> infer the previous rcv_nxt from skb->len.
>
> Lastly, dequeue_rcvq() is placed in tcp_cleanup_rbuf() rather
> than __tcp_cleanup_rbuf() so that it is not called for sockets
> in SOCKMAP, where calling sk->sk_data_ready() from the new
> kfunc would otherwise trigger infinite recursion.
>
> Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>

Reviewed-by: Amery Hung <ameryhung@gmail.com>
