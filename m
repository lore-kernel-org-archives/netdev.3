Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C854751B187
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 19:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789761084; cv=pass; b=uyio2eM+e54nPCYlcjoebtMOA8qpx9Ny6cilZoYAWhUIGykLIan5xWssjkeHPwKecLEdsdyzBBZNj7FrFDfnZRiPY42rv5VGxEKi/KJAI5RVisr4alFzW/x+ZC6V3pwhFYra4kmr06euoUtcT35u/HwHHTrJC6pxnpt3R9ZOyWM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789761084; c=relaxed/simple;
	bh=y/292QxEdUMf5pPsOfQZfieYF0PKSz2Ezz35GxIZDCw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cEBHs0BqYvEB0Ch2Cw8Gu2kRx7R7wo5KVhRXCamOgS3hin2u44YMYEAUPZ2dLV5Db6kw92D5QrtsIpor+KICVtMKk9chK5SASNmgmWAwFqwfJjW6MpxEPqMf64llPl+i7EfZczBW/UDuRY5VRAhQsuItfLAgUPidGQ8ztIsmLPg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lc2AWPgg; arc=pass smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lc2AWPgg"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469d20963so836953b3a.1
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 12:51:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789761082; cv=none;
        d=google.com; s=arc-20260327;
        b=k8UzDeUlVb3fOiG4E1MOIa757SXoa5i0p7ca6s2kOcRjxaz0kMb6BbQDBHV1uNO2og
         4Bl3MGioB0E196cZSXT+2UsaFJc3kxW7Lqb4oH9c4LbolGol+GYkb2oHrPvE8fYKh+Yf
         3WEZ4Kqwo6osGxLrfLoW/rV0h7rBCtRrAx2LjkM3+vUTiRBLQ2YFMZlZy8uA0eBp0X2u
         EbdH5rO7I/DvQ5vG7brpl280ZtXzr/VhQfkOQXCl4RtbMzk4dIJEO9AOqcWos5x9vNds
         6gVyQE89fqNur0bTVB7157XTFDie6Fu0vlASMeP6XJDQvP5VvDdFAXaQ7WGnSx0IUgvL
         to8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=87V+Fh4sb0y1GssnVq8tqPVBCLJOUuiDb7vS0kmG6PY=;
        fh=Tik+2CVeHIgXaxzERVjjWjI02W/nhiqYg0m1qyw+zok=;
        b=s/ZJaO2jhYJGmwhNSghBrtucTs1jKvpu1Fjx1MrRSgGnYI9KYJ/FKzVSfDgdqRHFTl
         83Yb2c7D2TCfze7Me+kiZkU2Cthw8E7w4BqCwCHavLdgV4cT9fEk9oNtZjzTqDR0u1lu
         RJtRnbeqwhT5oIr/ZgOqHNtdl+h2zMXBrlG2bPOoZYLF99nnGvq4EyOMZE/qq1vVCRyZ
         syZZmtM/NdRV+lHxTgNIUBX8SqXxmqXnxLpv2LHAktg39dUDvPqbbGfmlpxV8WNKig9S
         kqehS1lsH0wkDlEdhgtOQrm5FvDqL/cGM7RvFIZ1WOUL1oTqE4lAHWB4aaCA7mxXOUs8
         kt4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789761082; x=1790365882; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=87V+Fh4sb0y1GssnVq8tqPVBCLJOUuiDb7vS0kmG6PY=;
        b=Lc2AWPggj1t+NG78OaGgJrUMRVniORVrZ9OmckywK411wMJyp2gJv9IAcSiiekjKY6
         aCW2rzSY67m7ituBph+TZ4s46cUAZALx+GDAQGQ0x4KXCMRwKR5vEam2oGnwi6hBknh8
         OVzJhMnMMRhw5nOv73VGjKnFaJ9efTiZzCeRo9WGhPqBZFIUMegZJeQaAXuCCSE6qs20
         ri8EH1f8YKkC+vK3I3IPkU8vrSyVBYe/VX7iPrYm4pDtiXms0TMQgoDmjTvYGt51fuBF
         f8iRJjLLLKN1AeLsNCg1+v/KALt9CQ4QAsz9nLWhyBAWEUagVUxPqg9v51Jzdivn9Gj3
         J8EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789761082; x=1790365882;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=87V+Fh4sb0y1GssnVq8tqPVBCLJOUuiDb7vS0kmG6PY=;
        b=J6+r0V93ytUz0OjFL8wA4/vTziFrnDYzxTHQK8O5zuDM43Q1ODex6iba78D41YoccF
         PqqN749c4i1N9kW6dsAVe8IKOfNosjq6jkF4r1e/b2QApVqGT0ynROquNp5QPSJrFol0
         VFN0wUWaEAhH3FVoGlIiUvdJeLvEItsF9mYTuo7P9Rb/4J4IC3CclYlX/ic6dQg2s+S5
         V5d37u1Fx6pkql2+CVtn9hUzzPQXnNDo1qGShPuRODTg3NGpmbZAWBTkVtF4B03+kHK+
         RYWAmtpdkynQpu5jktgoonlIZkFvlXGHprPMges40TmU4szCvf6WO1kFE8ygxrzb+nHj
         7Z1A==
X-Forwarded-Encrypted: i=1; AKwUvBywrqpPiWyBn8fY0S+cmbi4By9d2r5hZB95wNeCgj1PxH4rKOeqvoj4KD7HmguhRav5CfE39iM=@vger.kernel.org
X-Gm-Message-State: AFuF++lHUt822j7Lh5pGioK1UrrBxqUxtkGcsjgiUf8pyD91Ht4XqkIc
	rXBeB/9HBqdGIqr1oockME4fRG2Sitih5aY/jpGbBvUDcD6v03eWzrHJnlZktj/DsUhTJVXASsy
	WH6V4ceMMo+uae28LEVYLtrwyBK7DN14=
X-Gm-Gg: AYBFou2ffdsCHdMf1UMEjf1+hjYVUrP2Xaw8VaYP5+w+dAa0UhEqM8qcTxHjWB4f+X0
	wuiTnbNAdxVxWJ4wcwcNiNaQe5oFI3zPzZbLgWAw5L3Y/AZVw566P2B/wDNPlSUkAAhdpzKggtL
	MletKP/xLEwVaMFCeEWIR6jYsgQb252I3YfbZcfqTwVHTPj8aRqwfGUIhsAOhrsyBZI4sKy/yG8
	xF4jW6oWVDQZsLmwo3zrKgiB/A6NU5n09RAqOx6rBznbfxQ4pcme03hpGbPkrxmwDn0nPwnu+xk
	qrCDVwoK5rHI/gqiaW6wGOSr48ag3e0gIepBQpk4b2w15dP0wRoCjd6bRsm7i3yVxFj9YIW22br
	oaCscRWSiL0jfpR62Hq0nZ9yewI1WyKGYbmZ2MGnse/RlozN+9E9gZm4V
X-Received: by 2002:a05:6a00:4185:b0:86b:b308:b926 with SMTP id
 d2e1a72fcca58-874dcbed261mr7094177b3a.14.1789761082116; Fri, 18 Sep 2026
 12:51:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADvbK_dHPkHjkPwu0RepYgDsHs5reHepprRHU9hDFBxQM9_RGw@mail.gmail.com>
 <20260916234654.420056-1-kuniyu@google.com> <CADvbK_df5X=Szsd-d8=0gndhoBSHJhnEqSh826iYUW6=Ce_xEw@mail.gmail.com>
 <CAAVpQUCRcBQOS4H5zJBOoYeCgsQBiGyu8gjhXaocDXDw9jqTOg@mail.gmail.com>
In-Reply-To: <CAAVpQUCRcBQOS4H5zJBOoYeCgsQBiGyu8gjhXaocDXDw9jqTOg@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Fri, 18 Sep 2026 15:51:09 -0400
X-Gm-Features: AcwNN1VIcCElFEGPge_VRMPC4oISQAbf6IB5C7NCKiJGMnhf9LEZN0g8RJucO_Q
Message-ID: <CADvbK_cweNjHtX-m=Ba5BT3g3aHhJ7se5TqaW44OXicONW6oYQ@mail.gmail.com>
Subject: Re: [PATCH net-next v15 15/15] quic: add packet parser base
To: Kuniyuki Iwashima <kuniyu@google.com>
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

On Thu, Sep 17, 2026 at 3:06=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Thu, Sep 17, 2026 at 6:38=E2=80=AFAM Xin Long <lucien.xin@gmail.com> w=
rote:
> >
> > On Wed, Sep 16, 2026 at 7:46=E2=80=AFPM Kuniyuki Iwashima <kuniyu@googl=
e.com> wrote:
> > >
> > > From: Xin Long <lucien.xin@gmail.com>
> > > Date: Wed, 16 Sep 2026 14:08:22 -0400
> > > > > > +struct sock *quic_listen_sock_lookup(struct sk_buff *skb, unio=
n quic_addr *sa,
> > > > > > +                                  union quic_addr *da, struct =
sock *usk,
> > > > > > +                                  struct quic_data *alpns)
> > > > > > +{
> > > > >
> > > > > [ ... ]
> > > > >
> > > > > > +out:
> > > > > > +     if (sk && sk->sk_reuseport)
> > > > > > +             sk =3D reuseport_select_sock(sk, quic_addr_hash(n=
et, da), skb, 1);
> > > > >
> > > > > [Severity: Medium]
> > > > > Should the hdr_len argument be 0 rather than 1 here?
> > > > >
> > > > > quic_udp_rcv() already did skb_pull(skb, sizeof(struct udphdr)) b=
efore
> > > > > quic_packet_rcv() is reached, so skb->data points at the QUIC pay=
load, and
> > > > > reuseport_select_sock() documents hdr_len as how far the pointer =
must advance
> > > > > to reach the payload.
> > > > >
> > > > > With a classic SO_ATTACH_REUSEPORT_CBPF program, run_bpf_filter()=
 does:
> > > > >
> > > > > net/core/sock_reuseport.c:
> > > > >         if (unlikely(!pskb_may_pull(skb, hdr_len)))
> > > > >                 return -EINVAL;
> > > > >         ...
> > > > >         pskb_pull(skb, hdr_len);
> > > > >         ...
> > > > >         __skb_push(skb, hdr_len);
> > > > >
> > > > > so the filter would see the datagram starting one byte into the Q=
UIC header:
> > > > > all its offsets are shifted and the first byte (form/fixed/type b=
its) is
> > > > > invisible, which can select the wrong socket in the reuseport gro=
up.
> > > > >
> > > > > [ ... ]
> > > > >
> > > > True:
> > > >
> > > > BPF programs may need to access the QUIC header, so I will pass 0 t=
o
> > > > reuseport_select_sock() to ensure the full QUIC packet is visible.
> > >
> > > Why do you use reuseport_select_sock() here ?
> >
> > Because QUIC socket supports SO_REUSEPORT and allows multiple sockets
> > listening on the same addr/port/ALPNs:
> >
> > https://github.com/lxin/quic/blob/main/modules/net/quic/socket.c#L724
>
> Okay, I was wondering how it was supposed to work without
> reuseport_add_sock() etc.
>
> reuseport_select_sock() should be moved to a later patch.
>
I'll try. Thanks.
