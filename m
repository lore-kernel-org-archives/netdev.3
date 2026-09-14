Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DEB543D4EC
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 10:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.205
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789381834; cv=pass; b=nrQXP6XbqNAlPbrODdBdQoLb8Y5Zg6p+osrzGbRqRlz3MyOuBbtruoHJhw3tYRiA8+fCKhXjLvbUdfJowRJ1hCyuf3RYX6Rom4iOGpS+7Q8S3zMzuTTrISp3dWanqpkHlHZUrLV2xBxqr21Dl/AxHppwHgwGXkaDDV+LKR8T1rI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789381834; c=relaxed/simple;
	bh=jwvakLDDSwoNLrIZ0mvP4p+RHcrvzJDGa+W1ai7cKZs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E2ibmmOllhpwwJPiiPfOs+o+4jeba9BYpHMzWJZoArg4dNMp4CmC/H3z3Une7UEcpfrc/FRp8mhtZaESmhqQxzDOSGcaKdKcOuRhPiW7IJvX5FifxLUV5aI0PpDBbPkvab+hJXClUfL+CpCb+pbET0ta1tzWumDKrmRAc+i8MQE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VjL8xlv0; arc=pass smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VjL8xlv0"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-530e28a62abso31124191cf.1
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 03:30:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789381831; cv=none;
        d=google.com; s=arc-20260327;
        b=QgOLNXAqRGKV4MmPY1D7iroydIK5rmL3xdkCbkqtfLq3LsjR0tm1SchNhfNdLb6stQ
         UEA62g3EERX4p9c8Vo3oFYVx09pwtpUuwRZnAtpUQsWwITwI0z7YShC3Sl3bcWwDztGC
         nTGoNyOTiUmLo/BJQahNzdZ3mecr8iem2czoN8Qqyn+P+Azoo6v/3ZzASl+UeTDdT+Y7
         Yzk1DLBxbuxq9nSwkySbLlljubHPDmJuEAH4J7x4to823tW4lES/QxeM4gxfwPCAJ5vo
         TbRVmGKYM9wAaAKfihNq2BmI22Asr15qmdyQQFlSZTKdW9QFatKIzZ/OFSZzDjyIiFGz
         yRng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LsBSDW/EDoVUPI/PUBcMJVDS2BanOK3xyeLG4LZyk3Q=;
        fh=1PbeNKIR1nibD5gGNqcz+5E086+T87Th2wCVUeBqd/U=;
        b=BBFTi8LYlKYnn305MT7Y6FtoyBBoawzZPFmEq9fUiWhf7jV8rtdwcacjHbTbdVXM7j
         v3ziC1+6y8Ck9WAcbQbDp9yJ36fNSkkiBTPSaBlKf6xbuexNgr1kB60W+Bqv55cINppm
         zaFP+By47/4o/RTCNyXsiXCVTjl2U2uhb5k080kn8y6qIHk+7AfTTUHQ2cYuIFVDgPsD
         mHhS0o868BsiDFt3+oUQrmgyXec5Q0LJ8NmU+jO5nx05Okfr2YCaCl1/vgU9xc+HbrnW
         Dy8dXOgFAvDz6A9ToSdrAfvEZkTTdgotICJEisCkVfeDLcCLo41e380CuuJ4Xyezk4aX
         ymSg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789381831; x=1789986631; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LsBSDW/EDoVUPI/PUBcMJVDS2BanOK3xyeLG4LZyk3Q=;
        b=VjL8xlv0K+y7NMD6HCbQXcoaS//8aO55lPmrY/2FQnfK+wj6/aIMiztDrBBqKLKGZG
         4AZu3qc0+sL5bN4+FkJ6iWWIUtBDYuUPE4qecyK82ijY9KoN8EayVB9ig0YuuJqDAC9C
         mh3emU2PpKGyZzVhVLg5m3SSMnwb9TWIVAG2RMO4Wp96EP/KI+u44VhGKtOmTKISG6Eq
         ACHed01uJit+g+cg/GarvdPu2QUvcgAhwKfpbJa7mogVePFTCzb2LscmjSQ1eGxuah/f
         4+7iFyCrrqd/cd00JciDBJL0muOQyBg95s8LPZSe4VjMjjn7/TWvL24123L+Tv0DuiNX
         ioFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789381831; x=1789986631;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LsBSDW/EDoVUPI/PUBcMJVDS2BanOK3xyeLG4LZyk3Q=;
        b=pfLbVyu/OObGKGKra4MrhfOgiw2+0V6b+/uHQ4t5chg8iKGSJINqJJSKIM/VSP48+K
         wjRDYVLLgjq1dylw7aq5OFL/DkyCF28LcNFdZmmepVVMCoJHLmoJQTkU+rN/WlmGXiOI
         O69JNp5nPuv93KdXIJwipqOqGnFRfieftAWdCQW4XRB+jLfNFUTzepSZsnMN0Tl0Yghn
         EHspg+SMTQnTKzdAE0XHDqtpy1FkwDxMLI+Av2tcAZhX0KoKVL7mehBJueNZ4IDviVih
         a19KIpHalpuKUFl0V4tg8R5ElpAgf0S8Dd5X4ucAyU9ELOrfmgkG383+bIbLYB0WiQPI
         nzng==
X-Forwarded-Encrypted: i=1; AKwUvBxPmmZ8o6sZsNZxeAoS3glYPf+EEIiAmcPMT4ORnhrNHsdZHMdD1kD0kXLpOCOLHhWtHSx0ysE=@vger.kernel.org
X-Gm-Message-State: AFuF++l+KeBL0Ntee6+FYJE0PcLvKhWIqnAPSwiEOhBndstaGsO9T1xE
	86CEwoPc8dhT1+nKzPE4Df9pIN2acnDEosk799Xu0mGqGNSgRpTWyCZMX03bqPMgDORZeMA0x69
	ieSGauS5VjqKxVmJShqxR8i41LqYDiTAjfd0mGtkXfdIW3a4R+PFFSJZGK9s=
X-Gm-Gg: AYBFou1DdVVvIAAtULb5/f5XonueLl6CRXHngr9F7KB9VHny4kquswDpwcAJuNeXY5C
	FI7//Sitrb6YIb+6D82d+VNTZy8hMrIsXYdSAYoJVVyQzRXgJJCPjCmFRyvcT59zl4r14pBcFQl
	UnnyOeCzih2kZiTZQ6hLV9tNm4Vc7BbmdN4D3Dt22ZZPBXxIKqFvFagI/OmPxX33rLtNIgJQXGD
	MaUbKFAAi5VFrSGXoxgpuxsG3vloSVW+8eWsO8vEK0KAuJ9RMPy8FvMNeRmpeRxydyCi6dPNGcK
	sOGII5xRRdIq4V1oXdegdDTIPsacQ9+IMfuYBihQX/IcEB2rFBBB+h9WMQrEZL9bHMkankOBLhx
	raSCNZAcLZx2sWHI+1+nySNY9ukk+iLi6+MV81zb8MXaaJoS6Z1o38a4uomytkEQsQtQ=
X-Received: by 2002:a05:622a:4c8:b0:530:8853:1be5 with SMTP id
 d75a77b69052e-5310cf0d3fbmr27459531cf.10.1789381830429; Mon, 14 Sep 2026
 03:30:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914011420.115556-1-kuniyu@google.com> <afba7d6a-a1b9-4c55-b3b0-3f034e92a4c3@linux.dev>
In-Reply-To: <afba7d6a-a1b9-4c55-b3b0-3f034e92a4c3@linux.dev>
From: Eric Dumazet <edumazet@google.com>
Date: Mon, 14 Sep 2026 03:30:19 -0700
X-Gm-Features: AcwNN1W4kyndAyEp8yqHamXkXyVfqZPpee5f_TidOyVDOcu7xO-xQEkBFTupvbY
Message-ID: <CANn89iJBNviGsL8ncf8raR63jMxRDYJReRs9mxYxV5mOCj2aQg@mail.gmail.com>
Subject: Re: [PATCH v1 net] tcp: Don't call skb_clone_and_charge_r() for
 close()d listener in tcp_v6_do_rcv().
To: Xuanqiang Luo <xuanqiang.luo@linux.dev>
Cc: Kuniyuki Iwashima <kuniyu@google.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	Taras Madan <tarasmadan@google.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Neal Cardwell <ncardwell@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 1:53=E2=80=AFAM Xuanqiang Luo <xuanqiang.luo@linux.=
dev> wrote:
>
> =E5=9C=A8 2026/9/14 09:14, Kuniyuki Iwashima =E5=86=99=E9=81=93:
> > tcp_v6_do_rcv() no longer calls skb_clone_and_charge_r() for
> > TCP_LISTEN since commit 073d89808c06 ("net: fix data-races around
> > sk->sk_forward_alloc").
> >
> > However, there is still a small race window between tcp_v6_rcv()
> > and tcp_v6_do_rcv(), where concurrent close() changes TCP_LISTEN
> > to TCP_CLOSE, causing skb_clone_and_charge_r() to be called
> > locklessly and resulting in the splat below. [0]
> >
> > Let's avoid calling skb_clone_and_charge_r() for TCP_CLOSE as well.
> >
> > This is fine for non-listeners because tcp_rcv_state_process()
> > drops skb for TCP_CLOSE and opt_skb was freed immediately anyway.
> >
> > [0]:
> > sk->sk_forward_alloc
> > WARNING: net/ipv4/af_inet.c:162 at inet_sock_destruct+0x64d/0x810 net/i=
pv4/af_inet.c:162, CPU#1: ksoftirqd/1/28
> > Modules linked in:
> > CPU: 1 UID: 0 PID: 28 Comm: ksoftirqd/1 Not tainted 7.2.0 #17 PREEMPT(f=
ull)
> > Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.17.0-debian-=
1.17.0-1 04/01/2014
> > RIP: 0010:inet_sock_destruct+0x64d/0x810 net/ipv4/af_inet.c:162
> > Code: 3d 49 ff e9 06 fd ff ff e8 d0 5b 83 f8 90 0f 0b 90 e9 35 fe ff ff=
 e8 c2 5b 83 f8 90 0f 0b 90 e9 c5 fe ff ff e8 b4 5b 83 f8 90 <0f> 0b 90 e9 =
04 ff ff ff e8 a6 5b 83 f8 90 0f 0b 90 e9 65 fe ff ff
> > RSP: 0018:ffffc90000677bb8 EFLAGS: 00010246
> > RAX: 0000000000000000 RBX: ffff8880117bde80 RCX: ffffffff8957eb41
> > RDX: ffff88801dad5d00 RSI: ffffffff8957ec3c RDI: 0000000000000005
> > RBP: 00000000fffff000 R08: ffffffff8957eb41 R09: 00000000fffff000
> > R10: 0000000000000005 R11: 0000000000000000 R12: dffffc0000000000
> > R13: ffff8880117bdf10 R14: ffffffff81c08eb7 R15: 0000000000000003
> > FS:  0000000000000000(0000) GS:ffff8880d7ae5000(0000) knlGS:00000000000=
00000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 00007f93a1021138 CR3: 00000000207a9000 CR4: 0000000000350ef0
> > Call Trace:
> >   <TASK>
> >   __sk_destruct+0x82/0xae0 net/core/sock.c:2356
> >   rcu_do_batch kernel/rcu/tree.c:2645 [inline]
> >   rcu_core+0x59c/0x1100 kernel/rcu/tree.c:2897
> >   handle_softirqs+0x1e4/0x9b0 kernel/softirq.c:622
> >   run_ksoftirqd kernel/softirq.c:1076 [inline]
> >   run_ksoftirqd+0x38/0x60 kernel/softirq.c:1068
> >   smpboot_thread_fn+0x458/0xc80 kernel/smpboot.c:160
> >   kthread+0x396/0x4a0 kernel/kthread.c:436
> >   ret_from_fork+0x8e0/0xe40 arch/x86/kernel/process.c:158
> >   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
> >   </TASK>
> >
> > Fixes: e994b2f0fb92 ("tcp: do not lock listener to process SYN packets"=
)
> > Reported-by: Taras Madan <tarasmadan@google.com>
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
>
> Reviewed-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

Reviewed-by: Eric Dumazet <edumazet@google.com>
