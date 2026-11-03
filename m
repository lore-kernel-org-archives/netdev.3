Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793717591;
	b=Pb2PbkEDzWWQ9NCr+ZmP41hr90Hb9X90w/48IKNxTSIlD0+0zkN+NHIWnMq2yEFww5dB
	 2zP8TQkstIELluiNUU/BoSZMz41W90VF2I1IoW/9Nlh8JL7QKPRW7LGkpBJbqn2Texj8E
	 ceJ2zmYmH8vW66W9zKRLELX+IEYoMw0UuOeIAIddhYFvzUQlwervJTyPeflx7zmy09sR1
	 EFYDkqZKvS6MttiIu1h5yReOwh6mZ8yjrb5cDxNtUO7GOsQ52d06BZbPnCbko1oFIQw9h
	 hqw375ljUFn6S+Hk4jaU86Js018hsNqwMU/pyb5fB50lPYf10Y24amxYnfehLeBHbPg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717591;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=t6aL0KS08y3lw+fbFyxxj89k4kn2zrtKzdEdMJuh9jE=;
	b=LulD7zpRtULrcidUjTQYdoAqXr345jBbX94tBiurRCg6P+GX0yDh6Mr5bf/y6aeQkkz4
	 miFOLWxRihx5+myRzsQUn7RsEqQtjCTFhrA2G5O5URDOsZR2j/6Q40mW5wxjfw/giS0Do
	 PPc2pEWsQcKHoInz3XtqHvC1IHv3KGUBJ+vNM3yk4/sl6VGn/WCg3s4Wh0+Q/jnLh8CSg
	 S/qtePujjq/NtLyaNGUxvdtj7C407s07313ty/oDwXlBf1BtLIVImQYUAHvF8/1LcJ4rD
	 Cn0FLedP/j9hqFOfaOEeYuE7mBhFs9RRQkzxSEtPhLhVmNgd604ZWqhqdKRYhL/HPQg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Y+H0OJPV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.52
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E98606C83E
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 14:53:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12E98606C83E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Y+H0OJPV
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6b1b12de661so11018a12.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 06:53:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793717589; cv=none;
        d=google.com; s=arc-20260327;
        b=lDQih2yoNrEwg5CTWG/d0L/WUdNFtj1J9crG/xPnlF4j1Gb01ngEKBPaXohv63W60O
         R07mJB/DnYIHoubWBrUMEfxiju+Waf+h0ShbZd24gfG+U5xQCXwXxPidKcoRk5MP7mh3
         +LaFoydHMTzkgaxKwtymfe3AahLJyW21cUUH4c64a8KbZFmL/waUOuYQ8QmqCXcrarqI
         b0jULK1kci4OcqUSQkdk+ZMQATdDTrm3d1Dirxd1NQZ7Xbo2DCgnKRg6vbeGkvxRql9+
         ViULcMonZKL05lxvhTFi2Ttm1UnxEbhBLjtb5VPlJf2LH5g8vZa0PsKCntVPhIKsJIGl
         bj2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=t6aL0KS08y3lw+fbFyxxj89k4kn2zrtKzdEdMJuh9jE=;
        fh=YnPj5Xjk8SgwmaxXG6VMP48u1YsvFnDU+997QU+zx/Y=;
        b=Oj70RaNSB65haWLWLCodFWYbFLDKPI6PN3LuUY/XwXYcJ2ztrvZm0Z3cF4xHUXi57T
         Ul4eJKK3p4MH3D/gGoXbDBA9WjybJysardIVB5AkQTr82/OCYK6VjpDbh/Xa1ib7BLPu
         lYXQ1nN6GkhwDlow8bEClSjBVhLXAyOZurKY5GsjFgydjEkJLewpKFDAIt6pWZPy4CA+
         GdHFVaPhVvswGI7PADlOm1FCC80j63tOSgOsS+NOzcTwYwE+OSFj4qINeSs/WZw9pkIF
         8Z+W5CtA7TEl0VEs3jReK0kqgjxOU9BmV4q3V53/kgELyKFsxqG5/pBt99LL6XrMPGmU
         8/DA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793717589; x=1794322389; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=t6aL0KS08y3lw+fbFyxxj89k4kn2zrtKzdEdMJuh9jE=;
        b=Y+H0OJPVgHDZCYeP2enbnr5FPxcAmQTxI3HKvOduQJ8ZbovEsbNIyW7B1wlNCh8u8w
         2Ydd3bDG91Z0lOjY81c6J1GwpiDRRALIQvxgXNYN062HfH62xQHnen5wx/sWgkoJGokf
         yIfE10xzWzomHsI4sASlc/W0lJUKAp92KwDdvlJWYn9Ks4r3qJlTQ7ycK+W1N28/wokx
         gyMmIU3yJhkRM0TD56x87F/uqu3waUu+VhdoIjCn5UdixXgVUDv2Fucrmul7VzIax2jk
         Ck2RrqeKIjxqw3au+C9KsvKS5JH+aBGCGUvyxtdXkOM0clMMdTCtr6W0N9fV3JSSQXxy
         d8cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793717589; x=1794322389;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t6aL0KS08y3lw+fbFyxxj89k4kn2zrtKzdEdMJuh9jE=;
        b=yUw0zXevGZEOmv8uHyMhPBZwivZDe7tSssnU9nLITgaFDA4KsPnQBworlkOD5PGBW9
         rYiC9+4A/Xne2rDdkD6l4RT1Ye1B+BSliQMJBRodZKZ7SAUcaHvv17wvdgBw3KjkJjAW
         g9DN7iGWJDha1yW99GzhKhyhlseC+c+UxkMRPB7vb5BPeF/nEblS8ufaHHvmA5oxyLUZ
         7K7fbo+CzqavxJjJqWbXvmA8XiJc+gwoB2U9rvlIAm/LlxFtDvLDEv2VcsoNLS5WLGxC
         dtZRaaUOpAKb+MpJGhZdpnfO1Pgy24JxWlr2Dtwem098tDFKFCCZh9XGvEQP5OJeNoJl
         yklQ==
X-Forwarded-Encrypted: i=1; AKwUvBwQESgCkRBTxnULLI72W8vOR3DVl+woNM/9gM6L9Uh5h+1FNe9Tn+9fSfOHCjre60O+NsV+uPA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+V59fUe5G4bqH99vc8TWOpSkQIUoNQsfGxoQMzvEaeHODg9XMW
	DlLkZ93UOkRs76i5XvNRTcg3H7B8BEt7vv7McKNLidIWX0DO+eKBdeRX3O8LR5ozBMqjDpivjQ1
	L+R8OEZtDxLKK+kPK5GvmpRcNaL6mwzKmD5Afpbj1
X-Gm-Gg: AYBFou0tsYT26KvNea8FllLzPHZhMiIB45N0RRNIPbSptz5s/PWKSnIt8Peb82FDTI6
	YtqapGftRa/BdFLa2PgVLWLlRVzIzaMKGkgWmSK/U3t0dMd+f0IesHlv3ejlccu+n5XU3g5Ocxb
	mmRQuuZu/V8A0ECDzQldKrhiXt5lg3iioEVyFoBFDMf3R2j8CQnxzFHUOLjH9WYXcOhRPTe4uUa
	ljgaZmbdKTnU26IlHUxYVMpjSEZOewoLVr2n51IbCTr7WptgZEeE223dsB4urkoJDWtvZdwTIBU
	lsUWeOCgoQBr7h6Ehwzf6pVyO00TrfwLFrS7+wbCLKF7V34wOe9+cm1ZgWQqi8HjC0OVqaTbisj
	G+ANzr0A0Z+SII3qvEny2bz9SPk41If2TmgkL1YUUiUAy4YNPlP6nRk6G5t2pTbxjOofZc6Lk/p
	2zQ5HUbG9OkWgak9twX3ejZB0Z5jA=
X-Received: by 2002:a05:6402:a519:10b0:6af:b196:68bf with SMTP id
 4fb4d7f45d1cf-6b53e7443a7mr46490a12.7.1793717588777; Tue, 03 Nov 2026
 06:53:08 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102035943.9700-1-qingfang.deng@linux.dev>
 <bfbc4b3c-fe19-4070-97b4-4ff8ded06011@linux.dev> <d6ba5426-fbee-49da-b18b-1419fd84fa0f@linux.dev>
 <CAL4Wiio9VXUtGg4UrFFU1kG2JENYL8xi0DzsDmhOp=zXs0DiUg@mail.gmail.com>
 <b8595ed2-6e7a-48f1-8240-3d522776e378@linux.dev> <CAL4WiioRi2hZRMTv-v=iUpSZhbnj__rh=Uh+g2dOCre-YBa6Ug@mail.gmail.com>
 <aulxmZNZqmAzK6r1@google.com>
In-Reply-To: <aulxmZNZqmAzK6r1@google.com>
From: Neal Cardwell <ncardwell@google.com>
Date: Tue, 3 Nov 2026 09:52:48 -0500
X-Gm-Features: AclHuK-j4hFEfW-ro6EopyT-Tk8HqSro_wq-t_bz6R1ZwuBKQefVxhZGd66IHmk
Message-ID: <CADVnQymrKnfXu4irTp6ysuR5puXeeWZVys=K7Z+ianbHsbE_NQ@mail.gmail.com>
Subject: Re: [PATCH net] tcp: initialize send sequence numbers before
 deferring TFO
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Qingfang Deng <qingfang.deng@linux.dev>, 
	Jiayuan Chen <jiayuan.chen@linux.dev>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Yuchung Cheng <ycheng@google.com>, Wei Wang <weiwan@google.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 3, 2026 at 12:32=E2=80=AFAM Kuniyuki Iwashima <kuniyu@google.co=
m> wrote:
>
> On Mon, 02 Nov 2026 09:20:41 +0100, Eric Dumazet wrote:
> > Le lun. 2 nov. 2026 =C3=A0 09:13, Qingfang Deng <qingfang.deng@linux.de=
v> a =C3=A9crit :
> > >
> > > On 2026/11/2 16:00, Eric Dumazet wrote:
> > > > Le lun. 2 nov. 2026 =C3=A0 08:41, Qingfang Deng <qingfang.deng@linu=
x.dev> a =C3=A9crit :
> > > >> On 2026/11/2 14:11, Jiayuan Chen wrote:
> > > >>> On 11/2/26 11:59 AM, Qingfang Deng wrote:
> > > >>>> TCP_FASTOPEN_CONNECT can return from connect() before tcp_connec=
t_init()
> > > >>>> when a cached cookie or cookieless Fast Open allows deferring th=
e SYN.
> > > >>>> At this point write_seq contains the initial sequence number, wh=
ile
> > > >>>> snd_una and snd_nxt have not been initialized to that sequence n=
umber.
> > > >>>>
> > > >>>> Consequently, inet_diag and /proc/net/tcp{,6} report the initial
> > > >>>> sequence number as the send queue length despite no SYN or paylo=
ad being
> > > >>>> queued.
> > > >>>>
> > > >>>> Initialize snd_una and snd_nxt to write_seq before marking the
> > > >>>> connection as deferred. Both sequence-based queue lengths then r=
emain
> > > >>>> zero until the first write starts the connection and runs
> > > >>>> tcp_connect_init().
> > > >>> This patch looks good to me. But idiag_wqueue can still go negati=
ve
> > > >>> on the normal connect path, since the socket is already hashed an=
d
> > > >>> diag does not take the socket lock. We always set write_seq first=
,
> > > >>> then init snd_una later:
> > > >>>
> > > >>>     tcp_v4_connect
> > > >>>       WRITE_ONCE(tp->write_seq, st.seq)
> > > >>>       tcp_connect
> > > >>>         tcp_connect_init
> > > >>>           WRITE_ONCE(tp->snd_una, tp->write_seq)
> > > >>>
> > > >>> Can you try this instead?
> > > >>>
> > > >>>     r->idiag_wqueue =3D READ_ONCE(sk->sk_wmem_queued) ?
> > > >>>                       READ_ONCE(tp->write_seq) - READ_ONCE(tp->sn=
d_una) : 0;
> > > >> This does not guarantee the load order on a weakly-ordered CPU. LL=
M
> > > >> suggests using this load-acquire/store-release sequence:
> > > >>
> > > >> r->idiag_wqueue =3D smp_load_acquire(&sk->sk_wmem_queued) ?
> > > >> READ_ONCE(tp->write_seq) - READ_ONCE(tp->snd_una) : 0;
> > > >>
> > > >> Then in tcp_connect_queue_skb(), replace sk_wmem_queued_add()
> > > >> with smp_store_release():
> > > >>
> > > >> /* Paired with smp_load_acquire() in tcp_diag_get_info(). */
> > > >> smp_store_release(&sk->sk_wmem_queued, sk->sk_wmem_queued + skb->t=
ruesize);
> > > >>
> > > >> What do you think?
> > > > Please do not do this.
> > > >
> > > > /proc/net/tcp and inet_diag dump sockets without holding the socket
> > > > lock. They provide a best effort snapshot, and transient inconsiste=
nt
> > > > values are expected (see the comment about rx_queue in get_tcp4_soc=
k()).
> > > >
> > > > The window in tcp_v4_connect()/tcp_v6_connect() is a few usec, with=
 the
> > > > socket lock held by the caller. Adding memory barriers in the TCP s=
tack,
> > > > on a field updated in many places, to cover this is not worth it.
> > >
> > > tcp_connect_queue_skb(), as the name suggests, only queues the
> > > connecting SYN. So this adds a small setup cost on weakly-ordered CPU=
s
> > > (on x86, smp_store_release degrades to a compiler barrier).
> > >
> > > If strong memory ordering is not required, do you prefer Jiayuan's ap=
proach?
> >
> > Neither, let's keep v1 as is.
> >
> > I know tcp_connect_queue_skb() only queues the SYN. The cost is not the
> > problem; sk_wmem_queued has many other writers, and one release store
> > among them is a special ordering rule that nobody will remember the
> > next time this code is changed. This is too much complexity to hide a
> > transient value in a best-effort dump.
>
> +1.  v1 looks good to me too.
>
> Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>

v1 LGTM as well.

Reviewed-by: Neal Cardwell <ncardwell@google.com>

thanks,
neal
