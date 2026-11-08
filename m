Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794108634;
	b=Fd2vXPO1hO2eb8SF28qOD0ktWJWPVxpb46xGeWXHTiqnsuvvgrcp5TupSKqZXsxzLBQu
	 iz1cXdWLhFjK74BNtmq9mEyBW8DUdbGeVGLsGfnnlq+LonoOxvURjAJ94dIjmsrURacRy
	 5IIChH7HMCD9sb/P1yB/GPo4CfA5JmBEGvV028MlbLZGjqy+Y5fOlznSkeGV0hiZtN0y+
	 08B74e35iTowKn3NFXCzklXClR3zJbs5xNV3jH6gfSvKGFL4yMgOEyGlNlmXezJiSv+2p
	 IbpBMSuXQlmHgzBYExEKPmPdEdXRknSsvPUl9zfvw4PmjmtrLl0EHIhjpu2ql/OtE7A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794108634;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=XlXje22OfHacfmQaflQddk4r12F9jnNMFdlswxl/bjM=;
	b=pLHp9AL/R5ekOKvl3CDvsPnt6Fj0US/LPrkBGJ0JOxQtceHLgY9qlRRphrQdbv+4dgqB
	 lBeTmwdOOSbKyxzDX9RkIaM6ULYcyJLU5e3dCSUQtTJdgc5GyJfDgac5JQSwv2ys2vXcR
	 94DYh+QnjS2p2xnwiH8+WjDZV+FfFVOp3/UQy/OTBUiRzZ4+PyS+3F4pvYwrHF0TkMhqT
	 qlcHd0G6pc1hVCqyHjTnWclRvgBSum0uV+ui18qYcxxsx3UNa7CLXdozway9yEJsAWTV1
	 k1dGutnya0pCgnnO4q/038aaaqogPLcOUB/4M6dnLlFUlw5rz4BMOt9kTCBrx2YhLLw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nAlL2bfY;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.47
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E58606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 03:30:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 44E58606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=nAlL2bfY
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1adbf62dd31so122519c88.0
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 19:30:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794108632; cv=none;
        d=google.com; s=arc-20260327;
        b=GuVt85MCmzY8D8dps0RsTipvW4awsutPEeMu9XpMPBLYywRE7+dx3UoYQ7dwUhL2bC
         Ddy5o6KeUqkUd5qQL+b6eKFRL698IEYXoZqQCshSYadrsrbf8+fhrcOxry6EpHaSoUF4
         qryopysCywtJ30dTQXb4Uku7OI+fd+8ftwuqIG0Y8vFfM2NdSfOUHDKL0utFol8Hoe8C
         neK/KvlfXlZ6UXZhiVyp+L8GJg/588uDlpN01xsCrh4otAsLcpElOnjS+8Q6tzN+fmX0
         bXMPp+Po6WW7xBwiK5bjnXsLpGn5mbOUroF9ocyXzDkkM+lVJhokmzoVAEQXrhQSmwGq
         Ci7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XlXje22OfHacfmQaflQddk4r12F9jnNMFdlswxl/bjM=;
        fh=k9iiQcpdUKrp1kM0RgqYDKYb8kAX43m44SVT5G8h3SA=;
        b=Si8XWk1udEtV+1qPF9jmr3Qrn3ASDB9Wqbhqg/5YY9HBvmGfSHrThFSKAMY2VBVdl6
         Cx24sJJVdo+z1NIg9Rko+5vsE5qTsXk3m3kKbFMrJ7e9bEwAun+FTdPGza/w1nlORHPo
         akqDRdxamP0KkikMOH799OtxRMwINJJw9AAeu89DxauaSUt9tYOwXpx01QPZ6nWsWDux
         cm8l7iGsl+29dJq+XYO/uzdT7CAVtHqa+NFK2Wc6mqiAhPkbDMcHTVNCoEA6MOqChSpH
         GAjfuXlDzMbXVZnxV0ThAt+EoBKNNd2dyILaa5FEeLB92N81uA3InoRX9+NyQxLuLNMO
         w0NQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794108632; x=1794713432; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=XlXje22OfHacfmQaflQddk4r12F9jnNMFdlswxl/bjM=;
        b=nAlL2bfYDAEluRcAyIHtC6RZ3qcQD5QKgPxNdcXsO3nxsuhsf24HiDAPFHlxhv+Y4P
         nrgQe/7fYOx3Jk8iMljaI7k1Do4os+tx0bC3o7ZPgfZ77aUqb+jyu0KYWD9PdJVbiQCC
         uOqfGjjEok0nJBwZFEdJTKbUJBEuoLdcgNHtrOmmHLWkWUD7kLrYFKkNk3muwoMmdOnb
         V2q+MOk+rqNJc2fTSs84npH5TRyPjkv+zJcHFLuAfPkUsgSndENAuo/qOthOsgSo4NT0
         jivvapsNTX3d6k9nKrqzePqwcgIQlpq15i1UpoiNW60orBc468S/Wpi1V5AjSFoFqI/d
         Q5Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794108632; x=1794713432;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XlXje22OfHacfmQaflQddk4r12F9jnNMFdlswxl/bjM=;
        b=li2rieIDZLfGpg3RkaBvW+Q31+wuEmVMVUxqzUEjvQQSgQjaoWmRC3inJVsXjNNC1C
         u5AXrEyb21n/P3UNwqhalkvuUk1ihdI4Mt6m9wVWlQXR2Q/K1wYCDaH3x+z8fQLuSk9i
         TUMRAfA83pp64UCo1Y6hPnDmjlg+C3JdmB69jnu3TAjsDXh1OxiJ1K5Lup9YyHiendXl
         6qo2LHI3VCc3ZoEhEws+1BZSsHQSKgG2TJ0W3Hiy7zQ2ClXNwWdncAlvElJOcNAlqZzX
         HWalkEL0Jur+O90v3pDE2Nnj/d/zUrvc2V2bZuRMbh06kJ5RNl7KWPp6WPGkoJTXI0lS
         CiJg==
X-Forwarded-Encrypted: i=1; AKwUvBxz9WYONc+CNrlUkzF2p4AZg0wNlzxWj6DFCg3CqL7L2CiiPDgqGGkBzdiRwqlF5zoeEgpBkEQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z8i1NG0gSNEsKPU+sx6PtfZgt8kOPw38g/JmQUtluJ+s4TeTHXW
	8wx2RzhDzp0yc3U1MaIRZFct9sKId8MMs1OCtIUrwpVJzzFcbBi4ws22+zoXmdrpFuM67Eu9kNU
	XC9fDf3Q/uEWiShhS6Dka9csiA5iUr2agfJGGQCwbzTaWwJPQD7w7NeeyoBw=
X-Gm-Gg: AYBFou1oXK1w7rXA///Sl7GnQge5yP3i5vEhHhb9s1IhfJO+Lup35ofgfCO1ps9RPTq
	eqftmbMZUpVmTjoCwS9zWr9I3yXgSLCnDmFybO9Y69SdRUWqUo7GJOU/Y9M1Lvtb40SOQdFyEN/
	N1sZevEh0YafAk9DzhSGje0URpwjf/IseKLHJKO2mJoB/1Lttl6D0RZpDZw/u8+xnCoHSsKxWIT
	BP8nIKg4fKImdu4Dwxn+4PJbDEX2g8ILoICAyjWiF2lXyNAZml7AaLd6Sn34qK7k3bTP1XdRaeX
	0A0ORmJA0yuTmJQYGfypbebuuqZM0ipUodJKquCk/WGiX9v9BcpT8C+1pkm4CEPbIcb0+sayLkl
	aHXahONgZcZREQ3lopcbNk24pcJQDSd30upNUlbjqhx0PFYALhGRLyERQFLkKo2EUcU+LwoGIqg
	ewqyjTrOLglfksJ0fTV3Ne2/Mwr/ky0ZttGtWZqLnOuDX3K3b0
X-Received: by 2002:a05:701b:4656:b0:143:72b1:9004 with SMTP id
 a92af1059eb24-1b39fed7258mr555855c88.45.1794108631163; Sat, 07 Nov 2026
 19:30:31 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261103-mtu-probing-series-v1-0-a2809e725aaa@gmail.com>
 <20261103-mtu-probing-series-v1-1-a2809e725aaa@gmail.com> <CADVnQy=AHpy6UoiAFopRUmHLNv6Arw07PysXVijiR=qERuzeww@mail.gmail.com>
 <au9zxblIQx7OF_gx@google.com> <CADVnQy=6mDzR6XQxnasHECbq7=9f54AH8cjny+rAdR_yR_ZsTw@mail.gmail.com>
In-Reply-To: <CADVnQy=6mDzR6XQxnasHECbq7=9f54AH8cjny+rAdR_yR_ZsTw@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Sat, 7 Nov 2026 19:30:18 -0800
X-Gm-Features: AclHuK97DApQUstQq_mpiJS3jdsjD0INaaKFdWOXySIkTv--_c4SWQEd8Tu2IKM
Message-ID: <CAAVpQUBc2=6SNDpjXuvR-FPiTWzTYMCZu65-6MXF-3pw60WEaA@mail.gmail.com>
Subject: Re: [PATCH net-next 1/4] tcp: sync MSS after enabling MTU probing on
 passive connections
To: Neal Cardwell <ncardwell@google.com>
Cc: echoowall@gmail.com, horms@kernel.org, edumazet@kernel.org, 
	kuba@kernel.org, shuah@kernel.org, davem@davemloft.net, pabeni@redhat.com, 
	netdev@vger.kernel.org, panweiping3@gmail.com, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 7, 2026 at 7:17=E2=80=AFPM Neal Cardwell <ncardwell@google.com>=
 wrote:
>
> On Sat, Nov 7, 2026 at 2:15=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.c=
om> wrote:
> >
> > On Sat, 07 Nov 2026 12:53:36 -0500, Neal Cardwell wrote:
> > > On Tue, Nov 3, 2026 at 2:09=E2=80=AFAM Yongjian Wang via B4 Relay
> > > <devnull+echoowall.gmail.com@kernel.org> wrote:
> > > >
> > > > From: Yongjian Wang <echoowall@gmail.com>
> > > >
> > > > tcp_v4_syn_recv_sock() and tcp_v6_syn_recv_sock() call tcp_sync_mss=
()
> > > > before MTU probing is enabled, and tcp_init_transfer() enables it l=
ater
> > > > without syncing the MSS again.
> > > >
> > > > With net.ipv4.tcp_mtu_probing=3D2, a passive connection therefore s=
tarts
> > > > at the full MSS instead of tcp_base_mss as documented, while an act=
ive
> > > > connection starts at tcp_base_mss. This has two visible effects, sh=
own
> > > > here with tcp_base_mss=3D1024:
> > > >
> > > >  - The MSS drops when the first probe is acknowledged, from 1460 to=
 1242,
> > > >    although that probe has just shown the path can carry more.
> > > >
> > > >  - On a black hole path the MSS never tries tcp_base_mss. It goes f=
rom
> > > >    1460 straight to 512, since MTU probing is already enabled when =
black
> > > >    hole detection triggers.
> > > >
> > > > Sync the MSS right after tcp_mtup_init(). tcp_sync_mss() only appli=
es
> > > > search_low when MTU probing is enabled, so the other tcp_mtu_probin=
g
> > > > values keep their behaviour.
> > > >
> > > > The Fixes commit kept tcp_mtup_init() in a single place on purpose,=
 so
> > > > sync the MSS next to it instead of moving it back into the
> > > > syn_recv_sock() handlers.
> > > >
> > > > Fixes: 4d83e1773031 ("tcp: delete redundant calls of tcp_mtup_init(=
)")
> > > > Signed-off-by: Yongjian Wang <echoowall@gmail.com>
> > > > ---
> > > >  net/ipv4/tcp_input.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > > > index e1f2d9765..c13f005b2 100644
> > > > --- a/net/ipv4/tcp_input.c
> > > > +++ b/net/ipv4/tcp_input.c
> > > > @@ -6760,6 +6760,7 @@ void tcp_init_transfer(struct sock *sk, int b=
pf_op, struct sk_buff *skb)
> > > >         struct tcp_sock *tp =3D tcp_sk(sk);
> > > >
> > > >         tcp_mtup_init(sk);
> > > > +       tcp_sync_mss(sk, icsk->icsk_pmtu_cookie);
> > > >         icsk->icsk_af_ops->rebuild_header(sk);
> > > >         tcp_init_metrics(sk);
> > > >
> > > >
> > > > --
> > >
> > > Functionally this seems correct. But I'm wondering about the
> > > performance impact, and whether there is a way to achieve this withou=
t
> > > adding this call to the code path for every connection establishment?
> > >
> > > Eric and Kuniyuki, WDYT?
> >
> > Looking at history, initially it seems we properly called
> > tcp_mtup_init() right before tcp_sync_mss() in ->syn_recv_sock(),
> > but 4d83e1773031 removed them.
> >
> > The dup tcp_mtup_init() mentioned in the commit is the one in
> > tcp_init_transfer() today.
> >
> > Then, 27204aaa9dc6 moved only tcp_mtup_init() to tcp_init_transfer()
> > without tcp_sync_mss().
> >
> > The dup exists in tcp_rcv_state_process() from day 0 (5d424d5a674f),
> > and 168a8f58059a copy-and-pasted the unnecessary tcp_mtup_init().
> >
> > So, 4d83e1773031 removed the correct one.
> >
> > Instead of restoring the 2nd set of calls, I think we should
> > revert 4d83e1773031 and remove tcp_mtup_init() in tcp_init_transfer().
> >
> > ---8<---
> > diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
> > index e1f2d9765f81..8d009c0d9359 100644
> > --- a/net/ipv4/tcp_input.c
> > +++ b/net/ipv4/tcp_input.c
> > @@ -6759,7 +6759,6 @@ void tcp_init_transfer(struct sock *sk, int bpf_o=
p, struct sk_buff *skb)
> >         struct inet_connection_sock *icsk =3D inet_csk(sk);
> >         struct tcp_sock *tp =3D tcp_sk(sk);
> >
> > -       tcp_mtup_init(sk);
> >         icsk->icsk_af_ops->rebuild_header(sk);
> >         tcp_init_metrics(sk);
> >
> > diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
> > index a7f9242f1e42..579a88472abf 100644
> > --- a/net/ipv4/tcp_ipv4.c
> > +++ b/net/ipv4/tcp_ipv4.c
> > @@ -1740,6 +1740,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct so=
ck *sk, struct sk_buff *skb,
> >
> >         tcp_ca_openreq_child(newsk, dst);
> >
> > +       tcp_mtup_init(newsk);
> >         tcp_sync_mss(newsk, dst4_mtu(dst));
> >         newtp->advmss =3D tcp_mss_clamp(tcp_sk(sk), tcp_dst_advmss(dst)=
);
> >
> > diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
> > index e006a30360ea..c465fd97baec 100644
> > --- a/net/ipv6/tcp_ipv6.c
> > +++ b/net/ipv6/tcp_ipv6.c
> > @@ -1489,6 +1489,7 @@ static struct sock *tcp_v6_syn_recv_sock(const st=
ruct sock *sk, struct sk_buff *
> >
> >         tcp_ca_openreq_child(newsk, dst);
> >
> > +       tcp_mtup_init(newsk);
> >         tcp_sync_mss(newsk, dst6_mtu(dst));
> >         newtp->advmss =3D tcp_mss_clamp(tcp_sk(sk), tcp_dst_advmss(dst)=
);
> >
> > ---8<---
>
> Thanks, Kuniyuki. I agree that seems like a good approach. Though
> since 27204aaa9dc6 also moved the tcp_mtup_init() out of
> tcp_rcv_synsent_state_process(), I think with your nice approach we'd
> also want to place a call to tcp_mtup_init(sk) right before the
> tcp_sync_mss() call on the active connect code path as well, something
> like:
>
> --- a/net/ipv4/tcp_input.c
> +++ b/net/ipv4/tcp_input.c
> @@ -7015,6 +7015,7 @@ static int tcp_rcv_synsent_state_process(struct
> sock *sk, struct sk_buff *skb,
>                   tp->tcp_header_len =3D sizeof(struct tcphdr);
>           }
>
> +        tcp_mtup_init(sk);
>           tcp_sync_mss(sk, icsk->icsk_pmtu_cookie);
>           tcp_initialize_rcv_mss(sk);
>
> WDYT?

Ah exactly, thanks for catching :)
