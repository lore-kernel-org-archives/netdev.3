Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793733007;
	b=uGzs4615fvzoBuOC2k9bxX62kdv218+kXPxRE2YIG4Z8UKaaTj+kt3lv7UhGxwQHhnEi
	 MqBLXthC+fFfQJSAiszTrIRHo2VEvXiS5bPulwJ0AgYocaeqA9FcGoqIhztS87qFCaFCd
	 D/gB8YFOlCwNWtYfvoQhsK1+1r3WsAhWu9erXyoGbOTXmxBgzI1I/OeIOz7sUN6R2lON5
	 fnvIoKZK63A8FsNVsDIteC3kGSJlAKvnx/HkXmcVijLjMyEB3u9UK2/r+7bntNXBjQHha
	 CGzr4eX2VCVLFzirg3EuaV+2BqsqPXBvSm0Pq0MGGtgrbSKw5qtCb1VrGGaCoE89u+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793733007;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=FIaGWxaC1UicjQpp95sYn8dG+jwJv3SHhNZMjvFVzys=;
	b=fbG3NLK28IagnaxlYnusvOkzz9J5r//Y0rqQ1ZXfbt1r6NZx1PZnbyq7kbjv5A5uKsYR
	 4A9kuEnEdtRfTkyVLMBLA44dkxNXGbYZPHUKL+aAep+O2YEpdKTaOW/x6k7JtsHmtNXp7
	 xNb3Kh5OwibslBi/SLLceWeGed9WICjlB5J9yLcgOBB/k2RtgGFyV9R3tEPbrNH1cHV+J
	 1NY57DJPJTND4Qr49ZcZ+F1iir2Sox9NjY5TxEmln3HUpQgJY1ycDyFzlwJgsIBqKJYll
	 B5Ksoo/tnTdrXuvXomJGH+IGWrM0FkxDib+WtraJW/32m0hRiXBfVo82NKpH5ntMvOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZZRCR0DI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84539606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 19:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZZRCR0DI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230B41F00A17
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 19:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793733007;
	bh=FIaGWxaC1UicjQpp95sYn8dG+jwJv3SHhNZMjvFVzys=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ZZRCR0DIjijUfNZWN34dCXAGJ+Ws6dxnfjFAS5Sh8rUHV739HObhdLjgUukRHAgB5
	 jixEdO6QgTqZ3MFfA6zahY8eAJNzocGrObh7VUQiAdG2EgCufz0Op3zddK+74pB8rL
	 PXsYZiQVOA+ojDm5312hcaToOXbr9XqOmRwisFNjeNsS/Vb3mUrUZxoAiMoU47LrSF
	 VSu87fvXy0tiNytsMASw/rZoc9A/qWHtwnvZVHm5m9tE6rx99vG8QMSp76qd5ZA9mS
	 UtGFAX9se5cYTQTB08HSdM9vlriqa3tYz5spTi0XJmWJAQujqDtGPuDHWkrdiywBG0
	 xW2vJiiRueBWQ==
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-48ed188ee81so2287668fac.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 11:10:07 -0800 (PST)
X-Gm-Message-State: APuU4Z86BX9P9xfYtJiPDnGAXfXC78qctJX05s0OixF60K83r87AhWpr
	0axbF1rOIXTVq/+glMsrx27hkaiPrYeTq91tgaZNGD+HrJ67gOImyvaIjUSPKkFrn5OgypEnogs
	L/3BLpA06tr4Nd1M5p4QnO5YreLFp3Sg=
X-Received: by 2002:a05:6871:580e:b0:475:e2e9:4f4a with SMTP id
 586e51a60fabf-4a9076b7508mr9743973fac.24.1793733006351; Tue, 03 Nov 2026
 11:10:06 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAGTNuWBH2e1T6JSZsHxn5NS3QcG8xyP6XTXjYdGdcTsbbeoveg@mail.gmail.com>
In-Reply-To: <CAGTNuWBH2e1T6JSZsHxn5NS3QcG8xyP6XTXjYdGdcTsbbeoveg@mail.gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 3 Nov 2026 20:09:55 +0100
X-Gmail-Original-Message-ID: <CAL4WiiqY65aYPTv9adq_GVLZanhFmTATsCTEk8FC8iwzvaG_=g@mail.gmail.com>
X-Gm-Features: AclHuK9OJ6AMpKZ6Y8GgSMmfq4KytZCzkkr4b2OMPSfG8ZMHz-BZpxFaq16slX8
Message-ID: <CAL4WiiqY65aYPTv9adq_GVLZanhFmTATsCTEk8FC8iwzvaG_=g@mail.gmail.com>
Subject: Re: [SECURITY] ipv4: heap out-of-bounds write in IP-options echo
To: Sam Dlinn <sledge@meta.com>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 3 nov. 2026 =C3=A0 19:49, Sam Dlinn <sledge@meta.com> a =C3=A9crit =
:
>
> Hello,
>
>
> With AI assistance, we found a locally exploitable heap out-of-bounds wri=
te in the Linux IPv4 IP-options echo path and confirmed local privilege esc=
alation and container escape. The container escape was reproduced on Ubuntu=
 7.0.0-39-generic.
>
>
> All source references below are against upstream stable v6.18.52, commit
>
> 8f3741e6feb045da5b406df0a80b42a1adfb289b.
>
>
> tcp_v4_save_options() in include/net/tcp.h:2651-2667 allocates the saved
>
> options using the compiled opt->optlen, then passes them to
>
> __ip_options_echo():
>
>
>        const struct ip_options *opt =3D &TCP_SKB_CB(skb)->header.h4.opt;
>
> struct ip_options_rcu *dopt =3D NULL;
>
>
> if (opt->optlen) {
>
> int opt_size =3D sizeof(*dopt) + opt->optlen;
>
>
> dopt =3D kmalloc(opt_size, GFP_ATOMIC);
>
> if (dopt && __ip_options_echo(net, &dopt->opt, skb, opt)) {
>
>
> __ip_options_echo() in net/ipv4/ip_options.c:89-96 instead reads the Reco=
rd
>
> Route length from the packet:
>
>
> sptr =3D skb_network_header(skb);
>
> dptr =3D dopt->__data;
>
>
> if (sopt->rr) {
>
> optlen  =3D sptr[sopt->rr+1];
>
> soffset =3D sptr[sopt->rr+2];
>
> dopt->rr =3D dopt->optlen + sizeof(struct iphdr);
>
> memcpy(dptr, sptr+sopt->rr, optlen);
>
>
> An nftables LOCAL_IN payload rule can change the RR length byte after
>
> ip_options_compile() validates the options. The compiled opt->optlen
>
> remains unchanged, allowing the copy to exceed the allocation.
>
> Our exploit used an eight-byte Record Route option on a TCP connection re=
quest making tcp_v4_save_options() allocate 40 bytes. After ip_options_comp=
ile() validates it, an attacker-controlled nftables payload rule in the att=
acker's own network namespace changes the RR length byte up to 255. When __=
ip_options_echo() copies using the modified length, it writes attacker-sele=
cted bytes past the allocation. Duplicate SYNs repeat the operation. The ec=
hoed options in the SYNACK can be turned into an adjacent-object memory dis=
closure.
>
> The unchecked copy is also present at mainline commit
>
> 05441d697f7f9a927264f4058cbbc6a03dfcac9d. The demonstrated trigger is
>
> restricted by 968cc2c96390 ("netfilter: disable payload mangling in
>
> userns") and df07998dfd40 ("netfilter: nftables: restrict linklayer and
>
> network header writes").
>
>
> The proposed patch below validates the source bounds, option fields and
>
> cumulative output length, including padding. (This was written by AI, so =
please review it with a grain of salt)
>
>
> Best,
>
> Sam Dlinn
>
> Offensive Security Engineer @ Meta
>
>
> Proposed patch:
>
>
> ---
>
> diff --git a/net/ipv4/ip_options.c b/net/ipv4/ip_options.c
>
> --- a/net/ipv4/ip_options.c
>
> +++ b/net/ipv4/ip_options.c
>
> @@ -65,13 +65,34 @@ void ip_options_build(struct sk_buff *skb, struct ip_=
options *opt,
>
>   }
>
>  }
>
>
>
> +static int ip_options_echo_len(const unsigned char *sptr,
>
> +       const struct ip_options *sopt,
>
> +       const struct ip_options *dopt,
>
> +       unsigned int offset, unsigned int minlen)
>
> +{
>
> + unsigned int len =3D sopt->optlen;
>
> + unsigned int end =3D sizeof(struct iphdr) + len;
>
> + unsigned int optlen;
>
> +
>
> + if (offset < sizeof(struct iphdr) || offset > end ||
>
> +     minlen > end - offset)
>
> + return -EINVAL;
>
> +
>
> + optlen =3D sptr[offset + 1];
>
> + if (optlen < minlen || optlen > end - offset ||
>
> +     dopt->optlen > len || optlen > len - dopt->optlen)
>
> + return -EINVAL;
>
> +
>
> + return optlen;
>
> +}
>
> +
>
>  /*
>
>   * Provided (sopt, skb) points to received options,
>
>   * build in dopt compiled option set appropriate for answering.
>
>   * i.e. invert SRR option, copy anothers,
>
>   * and grab room in RR/TS options.
>
>   *
>
> - * NOTE: dopt cannot point to skb.
>
> + * NOTE: dopt cannot point to skb and must hold sopt->optlen option byte=
s.
>
>   */
>
>
>
>  int __ip_options_echo(struct net *net, struct ip_options *dopt,
>
> @@ -85,13 +106,23 @@ int __ip_options_echo(struct net *net, struct ip_opt=
ions *dopt,
>
>
>
>   if (sopt->optlen =3D=3D 0)
>
>   return 0;
>
> + if (sopt->optlen > MAX_IPOPTLEN || (sopt->optlen & 3))
>
> + return -EINVAL;
>
>
>
>   sptr =3D skb_network_header(skb);
>
> + if (sptr > skb_tail_pointer(skb) ||
>
> +     (size_t)(skb_tail_pointer(skb) - sptr) <
>
> +     sizeof(struct iphdr) + sopt->optlen)
>
> + return -EINVAL;
>
>   dptr =3D dopt->__data;
>
>
>
>   if (sopt->rr) {
>
> - optlen  =3D sptr[sopt->rr+1];
>
> - soffset =3D sptr[sopt->rr+2];
>
> + optlen =3D ip_options_echo_len(sptr, sopt, dopt, sopt->rr, 3);
>
> + if (optlen < 0 || sptr[sopt->rr] !=3D IPOPT_RR)
>
> + return -EINVAL;
>
> + soffset =3D sptr[sopt->rr + 2];
>
> + if (soffset < IPOPT_MINOFF)
>
> + return -EINVAL;
>
>   dopt->rr =3D dopt->optlen + sizeof(struct iphdr);
>
>   memcpy(dptr, sptr+sopt->rr, optlen);
>
>   if (sopt->rr_needaddr && soffset <=3D optlen) {
>
> @@ -104,8 +135,12 @@ int __ip_options_echo(struct net *net, struct ip_opt=
ions *dopt,
>
>   dopt->optlen +=3D optlen;
>
>   }
>
>   if (sopt->ts) {
>
> - optlen =3D sptr[sopt->ts+1];
>
> - soffset =3D sptr[sopt->ts+2];
>
> + optlen =3D ip_options_echo_len(sptr, sopt, dopt, sopt->ts, 4);
>
> + if (optlen < 0 || sptr[sopt->ts] !=3D IPOPT_TIMESTAMP)
>
> + return -EINVAL;
>
> + soffset =3D sptr[sopt->ts + 2];
>
> + if (soffset < 5)
>
> + return -EINVAL;
>
>   dopt->ts =3D dopt->optlen + sizeof(struct iphdr);
>
>   memcpy(dptr, sptr+sopt->ts, optlen);
>
>   if (soffset <=3D optlen) {
>
> @@ -141,11 +176,18 @@ int __ip_options_echo(struct net *net, struct ip_op=
tions *dopt,
>
>   dopt->optlen +=3D optlen;
>
>   }
>
>   if (sopt->srr) {
>
> - unsigned char *start =3D sptr+sopt->srr;
>
> + unsigned char *start;
>
>   __be32 faddr;
>
>
>
> - optlen  =3D start[1];
>
> + optlen =3D ip_options_echo_len(sptr, sopt, dopt, sopt->srr, 3);
>
> + if (optlen < 0)
>
> + return -EINVAL;
>
> + start =3D sptr + sopt->srr;
>
> + if (start[0] !=3D (sopt->is_strictroute ? IPOPT_SSRR : IPOPT_LSRR))
>
> + return -EINVAL;
>
>   soffset =3D start[2];
>
> + if (soffset < IPOPT_MINOFF)
>
> + return -EINVAL;
>
>   doffset =3D 0;
>
>   if (soffset > optlen)
>
>   soffset =3D optlen + 1;
>
> @@ -173,12 +215,16 @@ int __ip_options_echo(struct net *net, struct ip_op=
tions *dopt,
>
>   }
>
>   }
>
>   if (sopt->cipso) {
>
> - optlen  =3D sptr[sopt->cipso+1];
>
> + optlen =3D ip_options_echo_len(sptr, sopt, dopt, sopt->cipso, 2);
>
> + if (optlen < 0 || sptr[sopt->cipso] !=3D IPOPT_CIPSO)
>
> + return -EINVAL;
>
>   dopt->cipso =3D dopt->optlen+sizeof(struct iphdr);
>
>   memcpy(dptr, sptr+sopt->cipso, optlen);
>
>   dptr +=3D optlen;
>
>   dopt->optlen +=3D optlen;
>
>   }
>
> + if (ALIGN(dopt->optlen, 4) > sopt->optlen)
>
> + return -EINVAL;
>
>   while (dopt->optlen & 3) {
>
>   *dptr++ =3D IPOPT_END;
>
>   dopt->optlen++;
>
>
> base-commit: 647b81ddefc6364290e67bf33c89d54971f8995e
>

Thanks for the report.

The IPv4 stack relies on the IP header and its options not being changed
after ip_options_compile() has validated them. The bug is netfilter
allowing such writes, and this has been addressed in netfilter rather
than in every consumer of IPCB(skb)->opt:

968cc2c96390 ("netfilter: disable payload mangling in userns")
54f34607d184 ("netfilter: nfnetlink_queue: restrict writes to network heade=
r")
df07998dfd40 ("netfilter: nftables: restrict linklayer and network
header writes")
112e447d17f7 ("netfilter: validate L4 headers after userspace packet writes=
")

With them, nft payload can no longer write past iph->daddr, nfqueue
rejects any ihl or IP options change, and neither is available from a
user namespace. Other netfilter writers (xt targets, NAT, helpers,
nft_exthdr, BPF netfilter programs) do not touch the IPv4 options.

Current upstream is therefore not affected, and I do not think we
want to add checks to __ip_options_echo() (and similar helpers like
ip_forward_options()) to cope with a header modified after validation.

These commits have no Fixes: or Cc: stable tags, which is probably why
v6.18.52 and the Ubuntu 7.0 kernel are still exploitable. Florian, could
you check whether they can be sent to stable? Distros should pick
them up as well.

Thanks.
