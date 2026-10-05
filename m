Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFCB490BF8
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 19:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791227611; cv=pass; b=MyBTPUPq6u3SbRrFRxSvict8YLCdz+7jPtnVwGfflp8qSxaVgN4xmd32hT2pfZL3hSFDlhKu33YDa/G7nUvFR6SBwho66uTmFB7dFzg00Z5AjpHZOVcU73303TUKaUjOneqyUVqoVSF2KAZ6842xpNF2IBLdzCRRpODyyKJbg9s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791227611; c=relaxed/simple;
	bh=cf3Wz/E9ru8iJy0m3FqCXyB0QpVmE6CICJ63f9iirrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LMqlNPfNnNry95PtKFFO126P1upvSav4vcMxxPIEyb8cPxs7DnxugKrvrW7Hu2OUgvzebhxy0NIQQjpET89sGPK3Zo3lvjpAUgBWAnThWYHbWmsIWSqNH337uDoREMa2U0gjNxX/rb9mElaFWEf1rNfoHqmr9KdPw8kXRXDSxm0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PA63iehk; arc=pass smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PA63iehk"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-1560523a927so169179c88.2
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 12:13:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791227608; cv=none;
        d=google.com; s=arc-20260327;
        b=CV7jjm75N7o9Ile4yU/cgqvTwQI4+b2Y1icpDeqicUTIcaof4bEW5XNz/q2ZWbzBn8
         XV9VZz4LN6EZ1ASyzeVSMKz0sCMpR49KsZuGg/vl3eY1NZg//MQY/h9i1sp8hDzDDqHW
         pyzczpxN8C1RKTJLAamrrlCNu7A1ZbtSkah0O4M5aHjCMUlX9kjdQG6w8tfq7g25Yv/9
         c3ebDw2DpDoaAf/En6i4wA0A7v+IzUeLPzmoV9bg5MVHnAjanGAvvsRLdb3IDWr0UQ2f
         AP2l/KaoMukl4r+OKHGjq/UPApGQ/kLGI6u5Z/ZQt6/Ls3VYRMQcOltFL4VdIrAFIIv7
         lFGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4Jb/wYrDSyqwwKuUWfY9kUnNka8L6Lv74gF1eaUvm4I=;
        fh=VryNQAkzTdnhZBr6TA6jZRV2aIh3jQ+OhNQNoOfkfQw=;
        b=f73iAKRX961PuhmEaVUGI4hZtVbDf+2vT1b++9Ww/1jaNdEJAMchFS2tr13UvoUuqV
         YDDbQqzTBRCQ7ME8jSfl2JKeLtGgo+45phl+QTp5rSf9UQhBpy76jbqrNgdy41n3tj+Z
         HN6ad6F5QGXxx66DakBEcKfg0SnL+bS7Bh43jGVeIEERhx4EPuNvamCSD8Ey++ZGZJ/k
         6naJnOwjJjYwui/lsulVMny+c2aJFwsxeFqGIn7L21XHokjl7bzQqhcbpRQsZ8TL5Xmw
         aLwVfOWlzxVIvRTvr1cluAmh/Ny7DnpiYHi1t7L6gDhId96rOAHGCunN/nEHyQs/t94o
         p94Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791227608; x=1791832408; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4Jb/wYrDSyqwwKuUWfY9kUnNka8L6Lv74gF1eaUvm4I=;
        b=PA63iehkdi7K5C4mR8Y4mV00TSB17PNTdO+bAGkG50qmFXVguhtpb+lhtfpmUTyV/O
         V4bR/uEHcwQxGCQ4/WgJOXusH9lXoCayMed0KyGIJW4JSV39UoazqPNy6in7bk1iw0s/
         +kuC0ShUg44lExNWvMn1IWF0swCYS2nH3K4tQf4nFPmTS1eZuD9VYknj2Suwy3IKqrG6
         SWA/0J198rbZeLi2wMc7n9PfbZViVkPdIIZvJr0X9U0CDD5V4Sg64YSVp9xHFpJjArX8
         XIzzRQov0eLndMDKVM6VYYNAGsmTMbFfXM6fW1KfG3j0pgj6qGxduA6HgDcZS/htzjQQ
         GMKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791227608; x=1791832408;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4Jb/wYrDSyqwwKuUWfY9kUnNka8L6Lv74gF1eaUvm4I=;
        b=lj2K0+Kqbznuy/NNKd0WL+hBxz6G98GnDehVTwpCwdqgJr0Xxmijasn8yugAchM5Gg
         +SKQLZ+kP8Hs0mqUQUyooLZ66OabsPVBjs7r5U5VdG1hVFA00KpNqzkICxFK+gStrPLv
         aNqr2OrNZwIicfFHiefo9EMEAWhI9cC0sRcCBiusFs0RZjWNpl4B2RxMdbgUwggMSyze
         VOGD+SYCExYQNxJxlOyz/1xUx4+V/OcOOk4fUc3md1GR/DhioiGUoEuBqAlY1VEk5yHL
         Tjdwc4VybjRbw+YUEX2BF+YKbKgmZ9jcOn0/H39+eVYxJXMAfgiZkjusIuOKqh6KTNGH
         h5pw==
X-Forwarded-Encrypted: i=1; AKwUvBzRms631427kFH7LUY96lIWXDVUB0va7KaciVNqoCN0EwahoOmG9KLCJ9zUM+5RrJdE6+9SUDQ=@vger.kernel.org
X-Gm-Message-State: AFuF++msD7SnKZC/PTdfUcc5CGcUNkT+K1MyzLzQ9OKirJiIyZG07Bgt
	RgZZ/BUPHyD5CHEnYPfPVVTn6SLlkwPFNeZQMrtvmYRw943m5ewi9FyBiKQj01IguFqJmixb2Kb
	bx0sNojaJyDGQa61qV+ktX8SNXJueNLqwCg0QckNO
X-Gm-Gg: AYBFou0a9WWgpIHdZyh/8LOk/CYXdrUFrr0IfoTqZR4RUJnfZVvnd9iF5n7sja9+Fq7
	bXPKO4nmNkupOsyuw8R3rMKraUT+jviJt/3zqhS2ThZ/ZcIWF0eIU7f1hwjPuWYL39gJm+qBwfu
	SWJ7Q/2vYrf7XskAOehWvoaRH8GmGJDgWDsPTVMzveQkvV2QGbbCUv367qkeV8s6RQ66mXbS4VZ
	RvnSVNGVSTOjnj5EN+Sbukq4UoeN3GhNhvvQA0xtPPFfyLpaJ46cnQROuZkuadRpI0zRugwvCvF
	hp7CRUa6DIrp6UJtjqdpI3KQ4ZF1O20aD9yrckmUujKyu7pAphPYr+pbad/0DgyiSQc0S5xqPsk
	k6CLhmTJ/CBYJKtEMvefb+zB8VcsgI0NdRntsegP3VcgU5LImOaLcLdspX8VHHgFvbhpz+trJ+b
	ooakYWAXXE7RZKNQ5UKbUw
X-Received: by 2002:a05:7022:7e0c:b0:144:f089:b189 with SMTP id
 a92af1059eb24-14f5cfbcb83mr15242930c88.36.1791227607704; Mon, 05 Oct 2026
 12:13:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005154533.4147685-1-kuniyu@google.com> <20261005154533.4147685-5-kuniyu@google.com>
 <CAMB2axM9iTXqAGkQ3LDB-BRtqs-dVrkoHX1DkXT72KVYjrHQbA@mail.gmail.com>
In-Reply-To: <CAMB2axM9iTXqAGkQ3LDB-BRtqs-dVrkoHX1DkXT72KVYjrHQbA@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Mon, 5 Oct 2026 12:13:16 -0700
X-Gm-Features: AclHuK-To4WN7JywD27eGj94zp4mI8c4erhwTAfXHpFD_z2LeT6hzZf1l8OM1-w
Message-ID: <CAAVpQUC0QRn6mTenuct=urshPg4yA5dxWKNGHrU_sOPTS9Q4vg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 4/9] bpf: tcp: Guard fast-path
 bpf_tcp_ops_call() under per-socket flag.
To: Amery Hung <ameryhung@gmail.com>
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

On Mon, Oct 5, 2026 at 12:10=E2=80=AFPM Amery Hung <ameryhung@gmail.com> wr=
ote:
>
> On Mon, Oct 5, 2026 at 8:45=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
> >
> > bpf_tcp_ops.{parse_hdr,hdr_opt_len} are called for every
> > incoming / outgoing skb.
> >
> > bpf_tcp_ops.rtt is called once per RTT, which is every
> > incoming skb in ping-pong workloads like tcp_rr.
> >
> > Even attaching NULL callbacks in the fast path hurts performance.
> >
> > Let's guard them (and write_hdr_opt) with the new per-socket flags.
> >
> > Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
> > ---
> >  include/net/tcp.h     |  3 ++-
> >  net/ipv4/tcp_input.c  |  7 +++++++
> >  net/ipv4/tcp_output.c | 20 +++++++++++---------
> >  3 files changed, 20 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/net/tcp.h b/include/net/tcp.h
> > index f69091f5e01f..48487135c076 100644
> > --- a/include/net/tcp.h
> > +++ b/include/net/tcp.h
> > @@ -3142,7 +3142,8 @@ static inline void tcp_bpf_rtt(struct sock *sk, l=
ong mrtt, u32 srtt)
> >  {90
> >         if (BPF_SOCK_OPS_TEST_FLAG(tcp_sk(sk), BPF_SOCK_OPS_RTT_CB_FLAG=
))
> >                 tcp_call_bpf_2arg(sk, BPF_SOCK_OPS_RTT_CB, mrtt, srtt);
> > -       bpf_tcp_ops_call(rtt, sk, mrtt, srtt);
> > +       if (BPF_TCP_OPS_TEST_FLAG(tcp_sk(sk), RTT))
> > +               bpf_tcp_ops_call(rtt, sk, mrtt, srtt);
>
> The new per-socket flag load happens before the static-key check
> inside bpf_tcp_ops_call(). Thus, even when no bpf_tcp_ops is attached
> anywhere, every RTT sample (and other similar places) now touches
> tp->bpf_tcp_ops_flags, whereas previously the path stopped at the
> disabled static branch.
>
> Can we add something like bpf_tcp_ops_call_flag(op, flag, sk, ...),
> with the static-key check first and the flag check before the cgroup
> lookup/array scan? This would preserve both the no-attachment fast
> path and the flag-clear optimization for attached programs.

Makes sense, I'll add that in v4.
