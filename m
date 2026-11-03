Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793734677;
	b=GR7b6CHGGtAWS2uf3etQhwYTZTMaBM7oL7ERwnJhJ3tsTujQh5UklcLH5AZ5XFn21rzj
	 nEZOj2+8OnkcTpZvoEOsomiVDB+HmpjK2iwwTW8yIbFyy/W0UxHvljTMKlLy3pZPAofYM
	 O6TmoKGBrzMNw9eIlKSFJqUdfPLwROsrVbN6Ga5WfJU7utH0rDPfJON3Q1RwSIlRHcOON
	 6EsbD870IRKiKeVeNjr6Opy2kfxouJGx02fMnDSMSIIIQlLHlk46a9Vfqp3Arw/3nG5EP
	 x3XSaeyU0DWMNMKDAcwC82l5qUl6PxykMWs9lxkFmIIoKykRw9+b48edyddDGrwJyxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793734677;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=ItAo9qYkmyvqf88f/LW+ytUpAFOtt3hebtfMpwFkRN0=;
	b=w2SKf6kjDApGNdgWWZfGzkzvK3pIE1nWJugLVuu3c9SkpGgbTbUhFPZbHRBY7uX2uq32
	 dpJuSsjH8XpCnj749V3XfNQz/WNyNcc3x9vKrF8I9LfUz1iX2owzkoqGa8U7Lu4EtkLQ+
	 0mx7fgypP7YVIAwv8c/cZUijttg3SQwZvVIcPB9sFLVISEhRbg7hHZn8ldXmvij1lIXcz
	 ef/jnIo9aFE9AMecimjS92QQ1z4nx60HyYlfAcMW2LMtv0bBgC1FrK0rmvnLmSov0yPMA
	 f6HiX3f9iZsoKWnvy7c06S9zKBlIxt7na061pAlUzEHu8IMwQyR/3X4uQcZvyzvR6vQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TtFnvrFg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE12B606A31B
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 19:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TtFnvrFg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D2151F0093A
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 19:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793734676;
	bh=ItAo9qYkmyvqf88f/LW+ytUpAFOtt3hebtfMpwFkRN0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=TtFnvrFgJ4LexlXbJVvg3d77tz6QZ1WwXk9RMjJolAO4CjfjvPW8HVmpgOHcQ/R0y
	 5sRwGBUbH5WAexfXq508yDEoio5t2k7NTLk4ovwAU+tekKewqLa1vNvCFHtE/zvlAr
	 XA/2Rz2pKVKp7tx5xIoOVTwHb4JI/00lIsC02ECXAydEYTrexk3Pk4mqz9nsJO6sTL
	 AQ7OV60z8e3Q728qQJfOu7Ekz257G502lbR+acVi3GUVN97Qs/EjMoOIhYxfxzt7kj
	 Ibf9Uc1JYIbU341HFuA06n2u0HjnfHET/ouut5LvUuW1ISm1oGSeDmWxtpKX26qRI5
	 HF4Lvedgf1BEg==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4ab8cb2a6e4so3278216b6e.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 11:37:56 -0800 (PST)
X-Gm-Message-State: APuU4Z/xvoOG/2wGsazA96V/0awtgWeZADBXBaV73g1dnY7K/GyH5XYA
	qzdrrGokRG+CQ15h5ejBvQahu4C34HOij4HeL1WWwi/nYXtqC7T4cu/rEJhBlwBOljl6hO5tfoL
	gN5X1Tg5vXxRCi0130tojh8aDAVJeplw=
X-Received: by 2002:a05:6809:1c8:10b0:564:5fe0:dd76 with SMTP id
 5614622812f47-5645fe0f8f1mr2447428b6e.18.1793734675879; Tue, 03 Nov 2026
 11:37:55 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261101194433.2637113-1-alexei.starovoitov@gmail.com>
In-Reply-To: <20261101194433.2637113-1-alexei.starovoitov@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 3 Nov 2026 20:37:45 +0100
X-Gmail-Original-Message-ID: <CAL4Wiiqw9kPmPp8WKJqUCOs+KUYY=Ek9yruY7QNZ1ZqqBcyxgw@mail.gmail.com>
X-Gm-Features: AclHuK_lWYrFuPqxHF7f8eVNTy2rRRIATiIorWPnhP8XtQMXmlNogVjkmkttJxk
Message-ID: <CAL4Wiiqw9kPmPp8WKJqUCOs+KUYY=Ek9yruY7QNZ1ZqqBcyxgw@mail.gmail.com>
Subject: Re: [PATCH net] net: reject a negative TCP header offset in qdisc_pkt_len_segs_init()
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, dongchenchen2@huawei.com, 
	bpf@vger.kernel.org, daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le dim. 1 nov. 2026 =C3=A0 20:44, Alexei Starovoitov
<alexei.starovoitov@gmail.com> a =C3=A9crit :
>
> From: Alexei Starovoitov <ast@kernel.org>
>
> qdisc_pkt_len_segs_init() stores skb_transport_offset(), or the inner
> offset, in the unsigned hdr_len. A header in front of skb->data gives a
> negative offset. For an offset a little below zero, pskb_may_pull() gets =
a
> small length and succeeds. Then a 64-bit kernel reads the TCP header far
> after the skb and can crash. Further below zero pskb_may_pull() fails.
>
> Commit 28a57fb2c5df ("net: iptunnel: fix stale transport header during
> tunnel decapsulation") fixed one source of such offsets. Other code that
> removes bytes from the front of a packet can leave the same stale header.
>
> Return SKB_DROP_REASON_SKB_BAD_GSO for a negative offset in the TCP branc=
h.
> SKB_GSO_UDP_L4 and the other GSO types read no header and still get a wro=
ng
> qdisc_pkt_len(). On a 64-bit kernel only packets that cause the read afte=
r
> the skb today get a new result. Then __dev_queue_xmit() drops them and
> returns -EINVAL, but sch_handle_ingress() ignores the result. Their conte=
nt
> can be valid. Thus the code that leaves the header stale needs its own fi=
x.
>
> Fixes: 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()")
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
