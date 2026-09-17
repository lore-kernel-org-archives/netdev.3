Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FBCC53D0D2
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 13:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789652304; cv=pass; b=U8s2JU1/sjvcoPda20HChJeF1bn8kCFln4ezqt7tqbUdpiOHQAh/9pzzuAPRKDcb1aoYccVCzqyZJScA7qZFGo071ENkwSAFTkhzE2WdYNwi6HCisFzYSpfuMJcnBv7wUv7ah+h0RHRRBfuBCTsP0ftsL+sVb+NJz/LK8GnQGT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789652304; c=relaxed/simple;
	bh=QNgM/kGDeBltidJ5TEbfEpxfYTzoLMWF0KKEi/Dse7U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=snzxOXeeCwpFS1EGgWBpC+7UXigbtQx9lhHNX6efaqn0ELvQsboovUVO/iLl8c09M1o6xYjFEsSTowArdCnhqwaBWOE8uO7szKdSXRqdJWL5EvzAfgounaBsG6u9G5VD++TOc4VLp6wkLTA+DUNIlQaoxdmLUnQ0bJKqdPB4eA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pIrSUZxZ; arc=pass smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pIrSUZxZ"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-86ec25cf7ecso728313b3a.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 06:38:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789652292; cv=none;
        d=google.com; s=arc-20260327;
        b=FsBhChbr66I2kmowEpz3tfgODUvuer+NSt0XJvl4o/1jd7t2J/FsIk8Hi9df/xRFuq
         O1k4jFrtupuFvKxdtzykEXUW/qcoBTv6xujAGGD6534aqHIYhm8hyKFQ47llsu0FXLHx
         2QBQEzp4l3PNQlAEB7MXhGBT4GgATwWSaPsByBaK7jNy6tqW6Oeof5g+ulEVJIDI5XOX
         ppe4x3YJvh1kSvurXRloeLlWcAmsGOWvcO2ApsOvelTdIO63qjnCBFYu/P0/Zm6gAzhP
         G8jpPF4XvZWa2YnCwlDMRw6ZaTVVfpJzz7lhGvq5JGkw0UW+UDAXuur0iDgtCkn/7Bg3
         pAow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=iuO1BQZ4V2eevpIqkFGI24nl/ujAkD0tm8XPYi2iD1M=;
        fh=XO/RUtd7zo214TsWLTbZ9bqh/DbTOnkRhyjczXPeQhw=;
        b=fn7tjAPQLP7lix/73ZQAkVOKSyvylSkHuLLBWRmZ9MDj/C66Nqn+uW5tZuQa84VqSb
         3whTcGE2xLww2b1x/kreVSGyebvsCu/WuAxYlVgAJfNAyfspAaCOKVd2rGItgJ2uWmdL
         lfmNSusTTIkyCLDPxFsUQVO6CFiPjlGSlFJRz3Kd/F9s+uuuDhxiIrwcAQ9mheU+qxoG
         fudaOsOVSbUZOIlp6bSt+9SnanCKiLrD9zFwUpbbVfVyf5kmI/3vgjtboM02YF0CjSVU
         i2nQqRibFCRzT++tl/emWMQ7UjjTxG37g5ARiWeBuBzGNSST0qXbUrSMLteW+LTGxMQ4
         I1DA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789652292; x=1790257092; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=iuO1BQZ4V2eevpIqkFGI24nl/ujAkD0tm8XPYi2iD1M=;
        b=pIrSUZxZcSdtIn2adyUd9JOpVISkFGg1qUjGy5JGjBzG8JYWdkHNQAN3IojHp7kMuw
         5rJe0TbTZZULKB3Pq/03PWrAJgDa1LPXpqr8MCLCDE0uJOqUkgO91MDGWhLk7Vqvgo2K
         Q7RGzGY+XeFjdYHdwL0hpsZod7Lsv5kT2f4lA6YxyMQh/fEr/Zx2YoG1C8pLK2pGSqoz
         sjONTM2QL6O7wPGRNz+keRcEiXzi0zj+OsG6vTWz8lwCG+iD8HyR2+2Pnr6XTcQWeEGr
         nBX9XMEwxPIAE89F+vhilGu9PA3T+1wc1AErBYjrlDK9uchf3ZhfXAb/Bkp+3iSfFxQ0
         6TKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789652292; x=1790257092;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=iuO1BQZ4V2eevpIqkFGI24nl/ujAkD0tm8XPYi2iD1M=;
        b=u4jFDtyaH+0sf5p88X0/7pw+RComk+rmCNiOhQE3TYh4SDU5P6oZKQ07cgNwAuFuwS
         5neiFXPRkKA3BHL01MwGifk78J/q+9s1rkBDiecVFqTVEZuSMuxiWTfygyvEePBk6PZV
         KWNILYOudBM+8wsU6SvdQA16IF9vXJfUJH7eoYhotRcSi9JOPcbTxOq0s2c4srqmNiae
         P8iRGV05HZRoyJpwDrNoPvRjziR145wkwU8eHoYbunxm9dBQ//Iy806iM3koReKRA9lc
         Pk2d8cR8b/eYdYYHkv9VdY/V9V+5kT9Gnf8P7XeFbBc3nXUUw2oAA67AQDjTwwjjw+l6
         BRqg==
X-Forwarded-Encrypted: i=1; AKwUvByxCUD3Q+nFsmuVADf6ge2HQCYWhjGSGcJ7x4CrlNfdYjCwfJ3sIOjkf6y7usRmI3OVcMl5Xik=@vger.kernel.org
X-Gm-Message-State: AFuF++lhylttA2DL+SpD1paC0rZIx9zpnB1beVK8HM3EYInTPtH3pA4o
	LgwWlf9VSIUJ2JKm4Ivb3GxHubcyJfb9ltQQ6vsLfwDULwNHjh+sM/wABVtLu99LC0sB22I8nOi
	HmX4Zwc8sjc9/E5Z1gw2G9yFUfL9eLdg=
X-Gm-Gg: AYBFou3jVdbYa91ek/jZ4rr6LjvSTpH0Cz47sROGVE7EAR+2GNeTYGOptE5GAYHSXyn
	yizq/70tz9b9iAsEqbN28SstCdP8C4gG+oI3fUXcZaZQvJvVGPzWxwCfwma0b/ls3q7hZIEgSVb
	1XcSxSGNR8jJ+Lay5VENvlhfQWshiW2QcGxcAGcnMe9uIM1v0DK5LWwy0cyRRUtUz5hyCQjUhje
	yHgPrM0qI9N2JIJoLvF3YiBRNrAEBH1UNkiM5P2Io5+Z41cqJu9fGslNBWBcWWMfUVPwBHLEaua
	cUNsn6oDWrLHcw4R2UqX6t8m2/3uPyIST8CFxIysc2xHZmXySKaQZDQuOSnZtfQxc1guvaYLV0r
	uViIb3c+m4durxeM4AKHDh4lk/SxxKmfrgtLG6G9drKYJv/rtwOupjb0=
X-Received: by 2002:a05:6a00:c58e:10b0:874:72b6:7dac with SMTP id
 d2e1a72fcca58-87472b68104mr229753b3a.39.1789652291802; Thu, 17 Sep 2026
 06:38:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADvbK_dHPkHjkPwu0RepYgDsHs5reHepprRHU9hDFBxQM9_RGw@mail.gmail.com>
 <20260916234654.420056-1-kuniyu@google.com>
In-Reply-To: <20260916234654.420056-1-kuniyu@google.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 17 Sep 2026 09:38:00 -0400
X-Gm-Features: AcwNN1WyswquGpQo0eLBq8SospQls0DTN_D79sTSRdER_SDP9o7rXxWvgz7asJ4
Message-ID: <CADvbK_df5X=Szsd-d8=0gndhoBSHJhnEqSh826iYUW6=Ce_xEw@mail.gmail.com>
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

On Wed, Sep 16, 2026 at 7:46=E2=80=AFPM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> From: Xin Long <lucien.xin@gmail.com>
> Date: Wed, 16 Sep 2026 14:08:22 -0400
> > > > +struct sock *quic_listen_sock_lookup(struct sk_buff *skb, union qu=
ic_addr *sa,
> > > > +                                  union quic_addr *da, struct sock=
 *usk,
> > > > +                                  struct quic_data *alpns)
> > > > +{
> > >
> > > [ ... ]
> > >
> > > > +out:
> > > > +     if (sk && sk->sk_reuseport)
> > > > +             sk =3D reuseport_select_sock(sk, quic_addr_hash(net, =
da), skb, 1);
> > >
> > > [Severity: Medium]
> > > Should the hdr_len argument be 0 rather than 1 here?
> > >
> > > quic_udp_rcv() already did skb_pull(skb, sizeof(struct udphdr)) befor=
e
> > > quic_packet_rcv() is reached, so skb->data points at the QUIC payload=
, and
> > > reuseport_select_sock() documents hdr_len as how far the pointer must=
 advance
> > > to reach the payload.
> > >
> > > With a classic SO_ATTACH_REUSEPORT_CBPF program, run_bpf_filter() doe=
s:
> > >
> > > net/core/sock_reuseport.c:
> > >         if (unlikely(!pskb_may_pull(skb, hdr_len)))
> > >                 return -EINVAL;
> > >         ...
> > >         pskb_pull(skb, hdr_len);
> > >         ...
> > >         __skb_push(skb, hdr_len);
> > >
> > > so the filter would see the datagram starting one byte into the QUIC =
header:
> > > all its offsets are shifted and the first byte (form/fixed/type bits)=
 is
> > > invisible, which can select the wrong socket in the reuseport group.
> > >
> > > [ ... ]
> > >
> > True:
> >
> > BPF programs may need to access the QUIC header, so I will pass 0 to
> > reuseport_select_sock() to ensure the full QUIC packet is visible.
>
> Why do you use reuseport_select_sock() here ?

Because QUIC socket supports SO_REUSEPORT and allows multiple sockets
listening on the same addr/port/ALPNs:

https://github.com/lxin/quic/blob/main/modules/net/quic/socket.c#L724

The client Initial packet can select the listening socket based on the
packet's source address and port, or by a BPF program that can inspect
the QUIC packet.

Thanks.
