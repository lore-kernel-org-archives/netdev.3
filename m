Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 524573F8250
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 19:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789672016; cv=pass; b=hHS/e+WH+6kpOLtBqfgnTGzlNl6+os6qo8y4WRo9dqMTwXaaw8jOj9+GwJmurBUvZg+wHMvTag8Xur9YSIo/3pZjbTnZ6i9FahCCD86ExJt6sr+lzj3MyViaK5SNLkjRSGMCMdJGWJ+jpOHVo1c24AszDVpoJG/Za2s+JfV4jN0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789672016; c=relaxed/simple;
	bh=qqBrqtVZFn6NsXxcXXIMtlSWkhWESw0qIbjgWLUJZHc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t29KvH4lnv2TfoNmM26u2RNBxYsZStIvIGb7/tBhOuEdkls5MmjY71hTq1bqlMpPMBaHsrac5SiB0BiPpMJ1kv8IpkHz/ivVxDb61dE+UOrUju6HIShXba2azLx4Wo8DCVD8uZbUYwxk6zqzEoPtO32agiXTi7iSSF8Oiq0I8VM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IycoU3EF; arc=pass smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IycoU3EF"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb652d7so22278a91.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 12:06:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789672014; cv=none;
        d=google.com; s=arc-20260327;
        b=ZR11XbBxsRSi65138hAOSjffW+7JHcR/nQGCcEFUZNCtnx3T2D8I2cGkDCsgSy0zSJ
         ac0wUu0kNv4kReekObn1vW5BQ5CYBfqrQxoAgmgcGIOQs0SGDq9WwzNkNk1erVgPnFGH
         FzmCHRTXdLsir+GAlCUuGFN7ErbRor0hd1G/flfX/1qaqjd6neHMuWto++nX+EhQ4kjD
         QKsHQ22CKr+4DAKJdM/3NT++Nfx0iycs6ewAtU2gtKLcmO4fHbW4WyCSvhXD/6H/DUmr
         VYAwYh467J+RtWkWRTfwTMaSEpfb8+xbrM0PkBtPDCuXTxF91m3XKeBCTFZmDRxeP47R
         zzVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AJdmTMqYmE/7xu/8ItFmggn+Kr8BDXFZhgiN1tzQfFI=;
        fh=yCPfumwcs9Q4doBfkuY1oIM/O2XZUdUdU8vVG1SnHjQ=;
        b=POiZCwaemKlh4FxK0UdpNrQ/Rg4QhlQDlGWwPWMjPlwAPUpWeeonXU4GewLFi/+MBI
         BqVQszqH0QYv5ENBDqwqFZNioSXamC7Z6Y9TVqYFhMJOa9cUK3BKUyaoyiOGjHUgykZ0
         pd7zgYefQVvHx06ZAFxZgm/F5HFSmVeHBF6ul7n1N0q4ccRhZJPCOjYohPy80dwlNRoU
         7rweW1WZ+r/U/lyrO89nuq6mitbOKFC6wHNXll7mnp5oK+0NlQfQQp8ycw23pJ6TswwJ
         OOAuBvHBQ+cQnY1bYrA8a1txxK0shfRRZIp4Hi6h3N0UYf89kJ4S+GCJZ3a1eq44k/Zv
         j9tA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789672014; x=1790276814; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=AJdmTMqYmE/7xu/8ItFmggn+Kr8BDXFZhgiN1tzQfFI=;
        b=IycoU3EFALTx1858ujT4tsuxDZ8tn271nr0x3R95A4/sbG16/g5jI1VlOID8w0K79G
         06o6MMxQnyuwyrngxy4KLpkr2jw4k6HXreNVITiaczRMXqxng+adySA3g14sFWpg2X51
         Dkfda3ArcnrZI5RGq28QTnWB+Zs2WHCICpCuuLpVntAc77gCmenmCC7T4M6OozsuTuEz
         lrRV8a8hMr8SqdqsCwenhAIU+cTA4MJE+1pcbC76E8rXuy/J5VmYcb55g/qBIgorYrjy
         ybns6tXE3N3LBYDCcrVyOJxFuCaTnumJkopyJXFEhnOHVEia6Y3rxR1ib5IF55G0Epvt
         5b4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789672014; x=1790276814;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=AJdmTMqYmE/7xu/8ItFmggn+Kr8BDXFZhgiN1tzQfFI=;
        b=owu65ijn6zALe9zkWWXrolKuJkQwsfgYRYdUG8don+WXLvef4Y8gm12+KAVRezwvlM
         qWv9Rf3GhDz+R+83ilD4NVXLozErTvObf40JURdMiMZYsDdkCnUTfopLWQjR/BFjTiPM
         gShOuyuFAiU73ipJzdx1mzi0pZBoAuhozIHBNRSDnDg2O59QTdRO8QJNYTOe8GN6HhlZ
         x5v9HUKDmhc1ksWdkUtS5niHHASpEEu4ed4GO88HOmp42gkNT4cOJvDvNzrnVPEipjot
         +R+ZuTkpUN/MDiRYLyaBaIpyjVJ3bCsBaB0y+MNc/3BC2Vl+JdRL8dbl/jSSss9mNLz2
         ViNA==
X-Forwarded-Encrypted: i=1; AKwUvBx0kV0+6h1gJzzAZgUd7ITQUoxwXBHj6KXxNdLQuC3Zc7l00smhDFWHkYqIavlhds3+jaz4Qws=@vger.kernel.org
X-Gm-Message-State: AFuF++n79yr4JWmrV83IoRW6eUTkVgHNRIJrTaC+PwHxXG5IzB0S+Rhi
	45Q+RuOW983pxXtw0CHZJB9SHSBjy8OuYfE0+PIbCfUsStKJsCpfpbvxwgX3DJFqauhoUvXPtNa
	Xl+Tbweqidaq7N7ctrr2RwEK7Q8RcQYlR8aI4JBqd
X-Gm-Gg: AYBFou2m7OK2AiZI/F2xuMa2Z9/EBEnRz/YBh0VzFx7bSj8NwuHyadAT6boSY3RbjX/
	+kROcfKPD3VOX93QeFtWuJmbmRU/KsPCbZqbjHZUEnik87JL1qOP3lsAhluoVMLfixXh8aPTQrz
	CdUJpDk3JSTA30ltMi2oqDHzFBnIKy32KrboS4kQF/JwOGfv/FgraoKW4sQ1Tec2OfIKnYSgSqp
	/1EIKElH4tEj84Seow+qMCjRTCoS0D9YNFn0ge2gTik7uEqJ3HWcuB6VLI5uHFJP1dWVAZ0DsHb
	p+QBFqf7F5lNb7Q3K5+5ON1UMvC6A2hDLnThj7nVRdqQWfDqIgzgOU/T/N7dBRieFoAfVabv9QK
	ZWsLGVgSByrSCglR5jjJxT9m4WYPFsgoYEybZSIY46Ui+EXCkVgc+gLoxOvChvQwMHfu2Wgzm5o
	RAwqFGTCEqDqleU4+27PIY8aKWZQ==
X-Received: by 2002:a17:90b:54c4:b0:39e:4c7f:7308 with SMTP id
 98e67ed59e1d1-39e55071981mr225580a91.31.1789672013089; Thu, 17 Sep 2026
 12:06:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADvbK_dHPkHjkPwu0RepYgDsHs5reHepprRHU9hDFBxQM9_RGw@mail.gmail.com>
 <20260916234654.420056-1-kuniyu@google.com> <CADvbK_df5X=Szsd-d8=0gndhoBSHJhnEqSh826iYUW6=Ce_xEw@mail.gmail.com>
In-Reply-To: <CADvbK_df5X=Szsd-d8=0gndhoBSHJhnEqSh826iYUW6=Ce_xEw@mail.gmail.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 17 Sep 2026 12:06:41 -0700
X-Gm-Features: AcwNN1Vf1Dgl1Yuz1331KMxjXrgwRsS9uLrWePJOZIUaTVSoZLWo_yT69Va3HQo
Message-ID: <CAAVpQUCRcBQOS4H5zJBOoYeCgsQBiGyu8gjhXaocDXDw9jqTOg@mail.gmail.com>
Subject: Re: [PATCH net-next v15 15/15] quic: add packet parser base
To: Xin Long <lucien.xin@gmail.com>
Cc: aahringo@redhat.com, alibuda@linux.alibaba.com, 
	andrew.gospodarek@broadcom.com, chuck.lever@oracle.com, daniel@haxx.se, 
	davem@davemloft.net, dhowells@redhat.com, dreibh@simula.no, 
	edumazet@google.com, hare@suse.de, hepengtao@xiaomi.com, horms@kernel.org, 
	illiliti@protonmail.com, jbaron@akamai.com, jlayton@kernel.org, 
	kernel-tls-handshake@lists.linux.dev, kuba@kernel.org, linkinjeon@kernel.org, 
	linux-cifs@vger.kernel.org, mail@johnericson.me, marcelo.leitner@gmail.com, 
	matttbe@kernel.org, mbuhl@openbsd.org, mef@scarletmail.rutgers.edu, 
	metze@samba.org, netdev-bot+sashiko@kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, paul@jakma.org, pc@manguebit.org, quic@lists.linux.dev, 
	sd@queasysnail.net, steved@redhat.com, tfanelli@redhat.com, tom@talpey.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 17, 2026 at 6:38=E2=80=AFAM Xin Long <lucien.xin@gmail.com> wro=
te:
>
> On Wed, Sep 16, 2026 at 7:46=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.=
com> wrote:
> >
> > From: Xin Long <lucien.xin@gmail.com>
> > Date: Wed, 16 Sep 2026 14:08:22 -0400
> > > > > +struct sock *quic_listen_sock_lookup(struct sk_buff *skb, union =
quic_addr *sa,
> > > > > +                                  union quic_addr *da, struct so=
ck *usk,
> > > > > +                                  struct quic_data *alpns)
> > > > > +{
> > > >
> > > > [ ... ]
> > > >
> > > > > +out:
> > > > > +     if (sk && sk->sk_reuseport)
> > > > > +             sk =3D reuseport_select_sock(sk, quic_addr_hash(net=
, da), skb, 1);
> > > >
> > > > [Severity: Medium]
> > > > Should the hdr_len argument be 0 rather than 1 here?
> > > >
> > > > quic_udp_rcv() already did skb_pull(skb, sizeof(struct udphdr)) bef=
ore
> > > > quic_packet_rcv() is reached, so skb->data points at the QUIC paylo=
ad, and
> > > > reuseport_select_sock() documents hdr_len as how far the pointer mu=
st advance
> > > > to reach the payload.
> > > >
> > > > With a classic SO_ATTACH_REUSEPORT_CBPF program, run_bpf_filter() d=
oes:
> > > >
> > > > net/core/sock_reuseport.c:
> > > >         if (unlikely(!pskb_may_pull(skb, hdr_len)))
> > > >                 return -EINVAL;
> > > >         ...
> > > >         pskb_pull(skb, hdr_len);
> > > >         ...
> > > >         __skb_push(skb, hdr_len);
> > > >
> > > > so the filter would see the datagram starting one byte into the QUI=
C header:
> > > > all its offsets are shifted and the first byte (form/fixed/type bit=
s) is
> > > > invisible, which can select the wrong socket in the reuseport group=
.
> > > >
> > > > [ ... ]
> > > >
> > > True:
> > >
> > > BPF programs may need to access the QUIC header, so I will pass 0 to
> > > reuseport_select_sock() to ensure the full QUIC packet is visible.
> >
> > Why do you use reuseport_select_sock() here ?
>
> Because QUIC socket supports SO_REUSEPORT and allows multiple sockets
> listening on the same addr/port/ALPNs:
>
> https://github.com/lxin/quic/blob/main/modules/net/quic/socket.c#L724

Okay, I was wondering how it was supposed to work without
reuseport_add_sock() etc.

reuseport_select_sock() should be moved to a later patch.


>
> The client Initial packet can select the listening socket based on the
> packet's source address and port, or by a BPF program that can inspect
> the QUIC packet.
>
> Thanks.
