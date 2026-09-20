Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4CB3C9EFC
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 21:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789938788; cv=pass; b=W2Ag4Ttfa7Q/kndSVGCJYoTJwEV2WhGyXdOUVHvpt2vwMAQnhuLR2HYekweUmZdUrs1d7NF0CO3uC37OiSE754psxN0aAOGoQmTmiDU10o4QEh6IEfci+4+kNIhOhpRs3DT+ZuZcchUonVEtL3KI64eqFfB6uyWyVGhGaVEW3IA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789938788; c=relaxed/simple;
	bh=1mjK4bzoIfjfpA05yhN5AbaKrxIyn0c+nGmaQXfpgRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nrxhuRG5Y9Rj8t+46Lh17UqcHdpvDv6s7jePCZS1K045i7zcvgrN4Wox1zcI560hJFPVLs9DCKNcQpdoP560F2CaDIjIFiGkyDQ5QcJPBSKrJ+KpfkGcHpVWeU9V9cYFbTld5ofAislAH3dWrdugBs7tOYVWHSaV1lZphzhUIJQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hmKmTgXj; arc=pass smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hmKmTgXj"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39d654f02baso1989774a91.3
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 14:13:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789938787; cv=none;
        d=google.com; s=arc-20260327;
        b=jNVWmgG3X+bDC/egZVzTeNkbkpzji/iQHGdeS5SCtXn9WQsMxCOPNDDjC/y9f8gwSp
         OBymoHmQx+bJOvzpIjV/LZdMhQa8TznZAzkMA2onB0vDWM/tFSd8U8TM70/aLSQv4saV
         PtHudTDuXkPPSCVwQ+h5SR1R1sGWmFPcGp+9/GQi7JIGN09w44K1EaDZoURcVTCahhig
         Ql7u/87F5unThRnDA0VELidlr6Gmk6JMwefCbXL5n6cpY8xvuexbi9vjMrk0nwa/Hscv
         ng1PwTTg/cd/fuHDwj+krg3rB2Alzre5pS+y0JtNHHxhqzC9xwm4PRcNk38cjQ036Y8b
         02XA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2TbkS5vrvn8yW8ujxuvZ93y2O9e7zUBaytbnHS0C3Ho=;
        fh=FnlAqgLU4yHJl2Wm6Hl62A+p6i06JF7ZsV8qRA7y5b4=;
        b=GBbYQSTtgJpSuPTvi62ItQvyBg6AGGeT4uMxf/4QtfkReo/tkr5/CQd+cGPsjDMUWN
         I44UkUbLEks6LDWxqazpIpSrkR5HJ2b0ZFsCfiONqRGkj/qFTWurIh6dC/VCW2VbyKIg
         q/Bx+s2C2CD/PlUauNLFnqoygBj4ii9sPJJkta9KJzr/gAxJVOJduBHWPfxvGUwgoc/W
         hfmd7wRAP1Hdet2NEY9iVoPliM+2E+Sy3uEe7Enj7tdvQ2aftehpUP6UH+p8lY6cJQNm
         Iowm/8sfAZsWqf+0e+F0skeJMWi7/woknEyu/hdEc8ZUZhoZEYmOXakAVt4ZHAVLSCA2
         kRLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789938787; x=1790543587; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2TbkS5vrvn8yW8ujxuvZ93y2O9e7zUBaytbnHS0C3Ho=;
        b=hmKmTgXjNMoSPm3i7o6gtuCNIqQ8wG/qGnEjtnVGOk42t05iXwv1ttiaxZsTz9qDJD
         CjmcjWMxxukCjVE+y8gaD0pEDQOou/7regI4sZqvW6fn0oE8TN0G8pQFyK+4v8gCPAiM
         wuuj2Hr9EfOleGC1zkAldkdqK5ASgnA4ufXKhvwdj9db7Nv5xQt9I3dh5U1h6mhftsLy
         biKZJfs5e9hGa1GtuswO+g4nZJ6t1s2U995RlAhiMeqOkdF3KvyxixWfjJR+Jidw7e0y
         /LU5PAcP1ELQ37aZNjE8CeSZHWkN4OMphrR9BrJBnduqqY1ADIglqoq9OjLeCAGqlZFO
         +YPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789938787; x=1790543587;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2TbkS5vrvn8yW8ujxuvZ93y2O9e7zUBaytbnHS0C3Ho=;
        b=ZcENeOTkNSm5sjas/q8maHMDYPNnJgvyZCJ11Dg3XtWATsX+/L2VX+O6PZDiAtCGRl
         CUoEsklnnJHLQluvbTWcF19wCm5UdrVMrWrBDXOknau18wBjK9BqTBcmIl5tYxMq07XC
         edsxN6eNlg/HQwVv+IBV6tgsUXqoSxeJt8oOI7/05isYSAleuYjqZS7ctC2ddF0x3bIN
         i478SxIUgJiVy6KQ4HLtkKY+XG7Pn2NlZyCH7CvzqWAOgO+4d1NdLNWvTcYQQO08Fap4
         t8ko6BoCp8oxzHY0mh9buUMxO1NSSRdMsGyKWYc0cKdRdohsaoJlR7fXG8XnFlF2wFdM
         bkSA==
X-Forwarded-Encrypted: i=1; AKwUvBw8DswC6wy9eP0CJARKipp1l1Bnpeec9UzmoerHGYAJq6elME4+a51Bv8IvNtVqkOZqVRDmSPc=@vger.kernel.org
X-Gm-Message-State: AFuF++m1mRlGKgw2F61fFJW2p6TLHeV9bUGXpax3czEHsxw9Fx+b+tYN
	Wgt1XjQMBwTdvjaEok7TWXkwohGmkU9k6V6V24FKHvIy34YzIG/Jk+BINjDL3NOQMvQt9e5qHA5
	xSrqSKamuIP6/JpovaBrQusZK6EZyM3q2ZGH0afmt
X-Gm-Gg: AYBFou0hLztBG1cipg+9am2z6+1EV/AgRQdOo46JVhHaMVng4241HZ4ZkSfYmv1ii7F
	9Ii6mKX+J6CJLAr1NpkuqSxCMM3hBQ1Ry/viPt1gWGXHrtBDA61LHjGrqpKx7CZcQ+y2GTTso1G
	qmJsz1GMvO7kC2Nn7QOX3epNoNQdPvUROtl2qB8097so/T9+IVshWomj/pWbXCHdt34m3Y/BAmm
	u1lKfdFIx3OLf2xb/vDLpgBoxNOVwOtwnDNL/jCPH/XtAkrjuCpVtTB0XCQhygJPrg8HT4fcBhW
	+ahqxaiEL/OC0Leq7SlRlDjfo47YspN9MezRS/ap+kuVyaVw+XcaX4EGgMVzbt4grtOO5NIy6mh
	Ma0Hg61bQyFakv2Q9pUCp9K/Xqs8CHD/nHUWWKkJB4PqAIGLypqrTBzcrV0Md9OyhP/zT1fDlVZ
	kUFQ==
X-Received: by 2002:a17:90b:48c7:b0:3a0:3d1c:2dc1 with SMTP id
 98e67ed59e1d1-3a03d1c3a24mr2589830a91.67.1789938786366; Sun, 20 Sep 2026
 14:13:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260920195633.3033620-5-kuniyu@google.com> <386c023dc4bca44689253b97a3f71c7758d9a320a014cb12e21562cba72a3443@mail.kernel.org>
In-Reply-To: <386c023dc4bca44689253b97a3f71c7758d9a320a014cb12e21562cba72a3443@mail.kernel.org>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sun, 20 Sep 2026 14:12:55 -0700
X-Gm-Features: AcwNN1VOFKzOS0OdgPcvkrdxKWm41uZitVdcprTPwzhwp3cOlmHDu6WtAiYEeTU
Message-ID: <CAAVpQUB9p-ELucWW+Vk8NjCJv4eXr6Ux0f5OmWidFD-F1iTxgA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 4/7] tcp: Split out __tcp_set_rcvlowat().
To: bot+bpf-ci@kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, eddyz87@gmail.com, memxor@gmail.com, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, sdf@fomichev.me, 
	edumazet@google.com, ncardwell@google.com, willemb@google.com, 
	ukyab@berkeley.edu, cleger@meta.com, kuni1840@gmail.com, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, martin.lau@kernel.org, mason@kernel.org, 
	ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 20, 2026 at 2:01=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > In the enqueue path, tcp_data_ready() is always called after
> > the hooks in tcp_queue_rcv() and tcp_ofo_queue().
>
> Does this "always" claim hold for every enqueue-side hook site?
>
> Looking at the callers of tcp_queue_rcv() in net/ipv4/tcp_input.c:
>
>   - tcp_data_queue() -> tcp_data_ready() at line 5709,
>     but only if (!sock_flag(sk, SOCK_DEAD))
>   - tcp_rcv_established() fast path -> tcp_data_ready() at line 6694
>   - tcp_send_rcvq() (line 5565, TCP repair, tp->repair_queue =3D=3D TCP_R=
ECV_QUEUE)
>     calls tcp_queue_rcv(sk, skb, &fragstolen) at line 5601 but never call=
s
>     tcp_data_ready() or sk->sk_data_ready() at all
>
> And there's a third enqueue hook site the message doesn't mention:
> bpf_tcp_ops_enqueue_rcvq() in tcp_fastopen_add_skb()
> (net/ipv4/tcp_fastopen.c:284), which also has no following tcp_data_ready=
().
>
> So wakeup =3D=3D false doesn't always mean "a wakeup happens later" on th=
e repair
> and TFO paths.

This is mentioned in the kfunc patch.  TFO path calls
sk->sk_state_change() later and wakes up the thread anyway.

> There's no functional regression since neither tcp_send_rcvq()
> nor tcp_fastopen_add_skb() signalled the reader before this series either=
, and
> the later commit 0390d95e0979c explains the tcp_fastopen_add_skb() case.
>
> Could the changelog be more precise about which paths it covers? Perhaps =
naming
> tcp_data_queue()/tcp_rcv_established() specifically, and noting that
> tcp_send_rcvq()/tcp_fastopen_add_skb() have no reader to wake?
>
>
> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a =
bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/READM=
E.md
>
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/355350=
82194
