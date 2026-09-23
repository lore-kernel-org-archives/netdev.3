Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967E04A0127
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 15:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790175922; cv=none; b=P7YEtAYxDpAH3DVOzALGoWf1UBuOPsMXuT7gq+uwlydC25wD7Q3Avu+jpG4PXeQTBmnMdJWVbYZMsIVSbEDjWtMiKiHAysGi7QAMfypeI+ZD4O3aHiJjHoPhzxgSiIRrPWbnCNJSVRSP5UVEfc7ds21k1nmMZElGMTBhYMvn6ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790175922; c=relaxed/simple;
	bh=wz5v6tqnETTrhq0ct0o1DXSnc9iKTEUsqX+mHmBe6IY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=tbwFN+ikEsGgQhg3Ty6gXqiUHMyRSS29X2r0qBfN69lYn2Uie8dkxRIRDY/nwabU2N1zP+YkEosNz3ZBK6fGONhGfui0udRH6oR1E4seEyXYuYE1SbO9d8Gbd041pJu9c8fE3Is1kYCO0vgzpi1JP4G/oURjfIZDbdjuwfrX97g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q2KK+igT; arc=none smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q2KK+igT"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-895eaf30817so15902867b3.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 08:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790175917; x=1790780717; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=V+RN9pGdf/MENO9Klpa0evnZ+IqaWvHGx3bi4rghzqc=;
        b=q2KK+igTaH40e6h617pUWlEHaDTF/AvPTTCuwKCL1paMH0sWXSGhg7D19qy0pd9FXL
         O5bX/FbNHLHhy5auXcRlivAUktGqTtbQ0sVdhb8LsqopgkTLA2NmimTTWN9wnbngSF7g
         tD3aUrebv7lobDuCMHIrHZVKA2C1UYjTACpnLsKlAxEE4xHZpo9VpeKkaD3aE2idAgtL
         toDeO8fugI0DDkf3j4Vd6oTz2EBhOFDVzT3QvM7hLCzCwp+t6Cz2G5llukkEpWfanYIU
         wHGfLOUomgUF5JzTcsvPHBMUpPOfGeuEDIOiqaaa2ZIBedaEYzjrBVpJrxFYzu701oNO
         PSXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790175917; x=1790780717;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V+RN9pGdf/MENO9Klpa0evnZ+IqaWvHGx3bi4rghzqc=;
        b=au/MrVl8nzyEXgQ/GRIYDk5HxvNaolAFWXjDx2UGqsZ4pIqWDsyEj/y6NZ7gelFTPo
         amgB6EwXCnESc+1TqLBSgo+hDFPS7rSGtcF2Q7lz3iaqwRH4R6vFbePXCrdiA1VfUNRQ
         p2xTw3PREls/1/jXK2oSzFrNIJiit3olEL9eN6nkCdl9m+JPkA08rkQtwHrHq+eygj9O
         LK/0LhyhFDO5fGdwT1rUdF0g7+N2z72UzGm794Y7cUvNSgvgRdCACV6smaLF+17846al
         1DVpfkWSp4iTDfKjyE/0Gr3DQQeg0uk3sqKfZ3aG4cqhd4aUyewsR/RAonm0bsnonraJ
         EtXQ==
X-Forwarded-Encrypted: i=1; AKwUvByvSc9adeyq901DsQt2g6Og9K1eRUkHRtyg53OvA53OGmkiGwCxbicrXPqyN+42uSLTHOUp/sE=@vger.kernel.org
X-Gm-Message-State: AFuF++lZSYuzFUVHs2PV8HLefMFWemAg3GPoDSxvJr3d+GElOBc+I/Cp
	qhFDI8VCB7OPtb5qnFVokU9P9hDlr9yRSD0fT3bmlF4pgXVSIBz/ZK8D
X-Gm-Gg: AYBFou1XLPq0U4KslsrxRXMnpXXlIsVBogNP14rihtBd8LiAWvYoiWd7GJY6d8PoaMj
	UHMf/J2nElJ3LOCFaYOm2ep8tsH8vBeLI2aHc/BK//aJf5gXpTHSHGml4CC+cQTNpIgbqb3sUTO
	V+321FzheUJ3ofwi7p+5w569M6jzdr4ov9UYMooJ7o++vKc9BLLfZL99jKEbstnv/qo8Zdajtef
	XpxIP06gr+emhaSxjZhtIyZLGRhxEft14dfM6EXHrdbpu5GgSmlzpSI4m+Ma/zO2tAYIwAVxOBd
	7SetB9djZySyO4YOg9TJk9WtHs9AVmOnTf5MFrd9T5yTlaRKOG93eivSs6Cj3jpjjGABNruZ/y9
	O0PdsSzRjDUW3DBFVSYN51yDP9+lurcg8m31/+srJLR3AKw92o2lle4sp7mFvvCf9G1OHMs0VxU
	qTjPgM7tOvaxeWUWNP34piBTWJJg0NlpWBhv6JQFJf5Nvg9ifLiiA0nrYrP5hJgXfc6J+8YPtSF
	yOTELE2zhfNv012MAf3nt2lO9WxjcVQtigK2zDI5+09Qch4JcNynU0TGRm/sKiO2sJM2MmlEw==
X-Received: by 2002:a05:690c:4990:b0:8a5:279:c4bb with SMTP id 00721157ae682-8a502892c37mr10292227b3.25.1790175917079;
        Wed, 23 Sep 2026 08:05:17 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a465dc176dsm10757107b3.21.2026.09.23.08.05.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 08:05:16 -0700 (PDT)
Date: Wed, 23 Sep 2026 11:05:15 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev-bot+sashiko@kernel.org, 
 benquike@gmail.com
Cc: willemdebruijn.kernel@gmail.com, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.2ffc47a14776d@gmail.com>
In-Reply-To: <178994135589.2160803.3896990579971629208@kernel.org>
References: <20260919215237.3470987-1-benquike@gmail.com>
 <178994135589.2160803.3896990579971629208@kernel.org>
Subject: Re: [PATCH] net/packet: zero-pad spkt_device and preserve sa.origlen
 across MSG_PEEK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

netdev-bot+sashiko@ wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider.
> =

> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 2
> =

> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchw=
ork
> know by including "pw-bot: cr" as a separate line at the end of your re=
ply
> (one such reply per series is enough).
> =

> - [Medium] Hunk #1 (strscpy() -> strscpy_pad() in packet_rcv_spkt(),
>   net/packet/af_packet.c:1921) is a genuine kernel-memory information=E2=
=80=A6
> - [Low] The commit bundles two independent defects with different bug
>   classes, different code paths and different regression lineages: (a)=E2=
=80=A6
> - [Low] The commit message mis-states the user-visible symptom of fix #=
2.
> =

> --
> =

> net/packet: zero-pad spkt_device and preserve sa.origlen across MSG_PEE=
K
> =

> This changes packet_rcv_spkt() to use strscpy_pad() when filling
> spkt->spkt_device, and moves the sll_family/sll_protocol assignments in=

> packet_recvmsg() from PACKET_SKB_CB(skb) into the destination
> msg->msg_name buffer so that the aliased sa.origlen is not clobbered.
> =

> No Link: tags were present in the commit header.
> =

> > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > index 50cae32ae269..15def2d16806 100644
> > --- a/net/packet/af_packet.c
> > +++ b/net/packet/af_packet.c
> > @@ -1918,7 +1918,7 @@ static int packet_rcv_spkt(struct sk_buff *skb,=
 struct net_device *dev,
> >  	 */
> >  =

> >  	spkt->spkt_family =3D dev->type;
> > -	strscpy(spkt->spkt_device, dev->name, sizeof(spkt->spkt_device));
> > +	strscpy_pad(spkt->spkt_device, dev->name, sizeof(spkt->spkt_device)=
);
> >  	spkt->spkt_protocol =3D skb->protocol;
> =

> [Severity: Medium]
> Is this hunk actually closing a leak of uninitialized kernel memory to
> userspace rather than just padding a buffer?
> =

> spkt here is PACKET_SKB_CB(skb)->sa.pkt, i.e. it is built in place at
> offset 0 of skb->cb[48], which is never zeroed and carries residue from=

> earlier layers (for example qdisc_skb_cb on the transmit capture path v=
ia
> dev_queue_xmit_nit()).  strscpy() terminates but does not pad, so for a=

> short name like "eth0" the remaining 9 bytes of the 14-byte spkt_device=

> keep whatever was in skb->cb.
> =

> packet_recvmsg() then copies the whole struct out with no memset of the=

> destination on the SOCK_PACKET branch:
> =

> 	if (sock->type =3D=3D SOCK_PACKET) {
> 		__sockaddr_check_size(sizeof(struct sockaddr_pkt));
> 		msg->msg_namelen =3D sizeof(struct sockaddr_pkt);
> 		copy_len =3D msg->msg_namelen;
> 	}
> 	...
> 	memcpy(msg->msg_name, &PACKET_SKB_CB(skb)->sa, copy_len);
> =

> so those bytes end up in the source address returned by
> recvmsg()/recvfrom().
> =

> The sibling accessor packet_getname_spkt() already does:
> =

> 	memset(uaddr->sa_data, 0, sizeof(uaddr->sa_data));
> 	strscpy(uaddr->sa_data, dev->name, sizeof(uaddr->sa_data));
> =

> which suggests the padding is a deliberate defence in this file rather
> than hygiene.  The commit message only says "so trailing bytes after
> dev->name's NUL terminator in the 14-byte buffer are zeroed" - could it=

> name the user-visible disclosure and carry its own Fixes: tag so stable=

> triage does not treat the hunk as cleanup?
> =

> [Severity: Low]
> Should this hunk be a separate patch?  The single tag in the header:
> =

> 	Fixes: 2472d7613bd3 ("net: packet: use sockaddr_ll fields as storage f=
or skb original length in recvmsg path")
> =

> only describes the packet_recvmsg() change.  Reading 2472d7613bd3, it
> introduced the origlen/sockaddr_ll union and the recvmsg writes, and it=

> did not touch packet_rcv_spkt() or this strscpy() call at all.
> =

> The two changes affect different socket types (SOCK_PACKET here,
> SOCK_RAW/SOCK_DGRAM in packet_recvmsg()) and have different lineages, s=
o
> as submitted neither can be backported or reverted on its own.  Would
> splitting this into two patches, each with its own Fixes: tag, work
> better?
> =

> > @@ -3510,15 +3510,8 @@ static int packet_recvmsg(struct socket *sock,=
 struct msghdr *msg, size_t len,
> >  	if (err)
> >  		goto out_free;
> >  =

> > -	if (sock->type !=3D SOCK_PACKET) {
> > -		struct sockaddr_ll *sll =3D &PACKET_SKB_CB(skb)->sa.ll;
> > -
> > -		/* Original length was stored in sockaddr_ll fields */
> > +	if (sock->type !=3D SOCK_PACKET)
> >  		origlen =3D PACKET_SKB_CB(skb)->sa.origlen;
> > -		sll->sll_family =3D AF_PACKET;
> > -		sll->sll_protocol =3D (sock->type =3D=3D SOCK_DGRAM) ?
> > -			vlan_get_protocol_dgram(skb) : skb->protocol;
> > -	}
> =

> [Severity: Low]
> Is the symptom described in the commit message the one this hunk fixes?=

> The message says the clobbered value affects:
> =

> 	subsequent recvmsg(MSG_PEEK | MSG_TRUNC) calls
> 	on the same skb
> =

> which reads as though the length reported for MSG_TRUNC is wrong.  The
> return value of packet_recvmsg() does not use origlen:
> =

> 	err =3D vnet_hdr_len + ((flags&MSG_TRUNC) ? skb->len : copied);
> =

> The only consumer in net/packet/ is inside the PACKET_SOCK_AUXDATA bloc=
k:
> =

> 	if (packet_sock_flag(pkt_sk(sk), PACKET_SOCK_AUXDATA)) {
> 		...
> 		aux.tp_len =3D origlen;
> =

> So the observable appears to be a garbage tp_len in the PACKET_AUXDATA
> cmsg on a second recvmsg() of a peeked skb (the old code had written
> AF_PACKET | protocol << 16 over the aliased bytes), and only when
> setsockopt(PACKET_AUXDATA) is enabled.  Could the message mention that
> precondition, so that someone reproducing with MSG_PEEK|MSG_TRUNC alone=

> does not conclude the bug is not real?

Agreed on all three points. Thanks for the fixes! Please do respin with

1. Separate the two fixes, with separate Fixes tags
2. For spkt_device describe that it solves a kernel mem leak through msg_=
name
3. For origlen, double check what the consequence of the peek overwrite i=
s
