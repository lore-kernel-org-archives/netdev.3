Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794376511;
	b=0ba6SJfpxrJO3E1ZSaKFnQoMnJpIOmfo0PGSypE0xQz87CVAfpjy9Ull06JaZqFm0etj
	 F07u4z1HkYyU7hI0EHQEIpCitXqYedOd3WKYkKPEe5ZriG62gVxdi6/YLRpfsWX2musTr
	 TVwsI6imHf54dwSiCxwl67Si7RN96O/sxvIiwPUlBQG8GmFva1Z2I8fjngyXctmFL/Q5B
	 9eM6iPKFYLhAU5WUU3EdEZJNY3SK/yeyiR+1FF0IRbIGrxKKCY9c4i4ATKVtaKxIiO9Gr
	 vQtXihsp2m3EIkwJMWP9DnThgoQ5oFHvYDjPMrgs5deu5QTiYNrlwXAz49zpU2rj1xw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794376511;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+moHHOAUSr114DKR8+LPAfS2zNkh0hPWeG+uwWP37Kk=;
	b=4AzEkID09w39a5XPIPPlKNYR+ey+4Lio2NaGjDSkDUvd1jNugYhJDh8p1mEvOvooXPGP
	 UUxmccFQ9zrYA2JEpwh9EmmSij19rWmAR8A9sz5x4tpc3EbbIEaYGOfK5EIpRfJLa962l
	 XTXdMXsqXCmxXqMr6LkFTWNkIIXU0XCaNW/byAFuDY4LDIXluB4+2QdVg4Fw6GUzoTJDz
	 hjzdECvcFGBURzEyu55Lfxsc6J7YwrzBufic0wAQfpAeYG0EPsUdPOBPyu7nlJHuwwmI+
	 tOmWVLrrXRpFfvMXCLrKWia1UQHCl0Q8L0u9udAoqKEghwhFVjVgR8RueULT3OM+4+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YgFhKAf0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 666B6606A31C
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 05:55:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 666B6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=YgFhKAf0
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1931ff67a29so4052862c88.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 21:55:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794376510; cv=none;
        d=google.com; s=arc-20260327;
        b=FYycUdO/39LSP/loaPtUz0Hzb76uQlbwY8wqKEl1lH683TkmaWK1Z+ZSgmKJ1blLsz
         eRAau2dC0kurR4z0HriS8kiHLp2yAfj9Vk9qClshBqeS67aY0v9zTpES73wuTBn9nTLw
         D+mvWTId7F1fN/Pn+KQFgyjn94UMo9ezyiya3CY1Hpsq/dgwbxaR4ZKEnzVKgpyf8A+/
         h5s5HLgGeQXoKtauZtkCf0ajZvqZmSCGX4d5xmLOtgN0SQoLs+n4fSzMhFCuCi7zy1Sy
         5gK9BxgzaWrEHC9faGmq8I+8T8J+7aa1ut69+aJFFOm855jqKkIv54ClCt7T208i1Mgz
         +FZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+moHHOAUSr114DKR8+LPAfS2zNkh0hPWeG+uwWP37Kk=;
        fh=ewIxVpAqJZQXsbzdX3n5jlxaTVOv2q4rZpBpo8tyhSI=;
        b=E9+x9pOszgbwtKX7nsjAnsWlwceTbsgQcBZHAR1qEB2ajWYZZhW9p56MGPAQAnbVb2
         E4l5f48b7rKwD9KH/9JVj2iyl3hOlKSN98XqoWl6/rTvfNIMru9UJ7MVewJSz9WrgphL
         z7qCx/HbzeXnMVTSyQSkSJUoHZnfvsLlnCLYGQpFSQFvlazCYUX182nGKtIl734tlJgE
         zcd48OkDYeybRWNkOhs8HIxZrNL/+EScIEKJq1XV5q4kdVMCyWXuuztByd/dn8Dy9BfS
         SWtmXws3NEUvQLqjb247wtEyesR6XxKRDcy6q//35eYrPE4bYe/F72tv1Cun8xn6FVdj
         Epwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794376510; x=1794981310; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+moHHOAUSr114DKR8+LPAfS2zNkh0hPWeG+uwWP37Kk=;
        b=YgFhKAf0h9doOh/dSY1kaUXQBazfSzjOi91lerbPuaWbuL2WaL3BuTKp8LfnPxWsa6
         tm/LTWicWM6RhOJcuxA9+TK7wq8k/pHNUvf9InsQZOan1p6w2nYhgw2UnzQjasAttary
         P5VwpMpH8rpnvHtXAD2obpHxqaa6UaVguuD2AmKMNPxnY64iSax9x3eBgw/RfFLDjiY7
         Wb0jEE2YohyUbdCNzbUVVZuGEt5uRMr0Jkhmy1ZJfco4+ZlvSUtclQZ4PwrdmZYDBOlF
         f9onT4Mfy+AmbzvMepQp5JAzUNknWUmF3X41OHdKddRS3yNHrPgKj06h95GqFa1wXlAd
         0N1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794376510; x=1794981310;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+moHHOAUSr114DKR8+LPAfS2zNkh0hPWeG+uwWP37Kk=;
        b=mI4RQeDX4/BZOScT33EinJFArbPjpSANSEZRLiHjt8nxWoQD2U0EI7W4C127hPEw4F
         eXZb5YdWOVmbnuwU6HAn5xKiFdr2qC2qNbE/BJ3nEpAnTwTh8zy95wCBda575sVPXfJ/
         24KJpjM2BaHnu9Y38elHJksVGVCv5vuzG/I62KQEwOXUf6Gkinzv5Ook30d/w1qTG+bV
         +lAxtp0LNrThSX1C8yPeKfzrMVAb/DsVpVv8Qc5hq3BRQbvfCBjXtt0UuFC4VMD1Gm5b
         mA+DWtGfV3MCLQwkdm+nBcdAJLqhozITHBBT0NDDFNdKYfBQKJaMWLOHJsY6ph1JM+5l
         43ow==
X-Forwarded-Encrypted: i=1; AL+hErHoRZtiy0okGCyZRnE7REPeD0SMk7Tq4L8ozZO3cXPojohRKR26I6KDQ+Q65ledpE3gB96rT6o=@vger.kernel.org
X-Gm-Message-State: APuU4Z/hmwj11K+SAV4xT3y1F9VDRSOF/Fq0YMkU12pAnbqCRELnQD4Z
	jvDwvm8lxal2NBDHFnu4hWCgcZeFBj8FWaeaQAODwzaaVFxRmglcRbIiGItiOOvOm3dVkEghtZP
	AYf+n+gfPxGhnFSZ7iEFZb07/TdqbnHY4k9D96bDe
X-Gm-Gg: AYBFou1PAmlAL/Plsq95/FnLUWktFJLp/2vcFLnYnlX5LUaWfYD3BmBMeq4KpfnISvf
	KwYThmlK06voeNWrY3czX490nVNPgVoe+uRrO6HwYRPFjXxhL1L/qIK5mib82qDg31OZS66LMPo
	GDp7x0Cgq6TAQCG+vI2fHnp2DZkQWdEF/c/Gh+DP4/9smTbWD5DUThVXx83SKiGITPCq2EdqgAL
	Nl50Pr20zGdPVC/oBQg8kZkQ9vl2fu+FbWkxJBqxX0XgWtfpb/SNylNqydeQxDwW4CV1u7g4mDg
	oWwaRC3RdBa6UNlIq+XdL5tkMgH0fovt0jt5vrMkwg8TD9Z2JCdq0kP+6inkT/uXVxZIgxa4K56
	z/9rs6q9wujAyR56zUV6E+E0DEj1OiiwA8U5vE6cpWVJO5XYZ08mssdTpfM2dQHopTmmzRObdre
	WLNqy+u7DwahXrvwZFTyMjV6sKm6mSEkGdu/nU9gnmHvhBZofJo6wr3894UmlBU7SdWf2D4FTyb
	nantJ+DyA==
X-Received: by 2002:a05:701b:20de:20b0:1a1:47b2:5512 with SMTP id
 a92af1059eb24-1b3c0332383mr1512329c88.26.1794376509272; Tue, 10 Nov 2026
 21:55:09 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <avFoNgJENLYu4t7X@v4bel> <avP5PfDz6WfnvckT@google.com> <avQAb-Gb7FRYNNgO@v4bel>
In-Reply-To: <avQAb-Gb7FRYNNgO@v4bel>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Tue, 10 Nov 2026 21:54:57 -0800
X-Gm-Features: AclHuK8GA0SrN_7fmv1tIaOnVassLjLjwOOBuPn4Ji8fBUiqEvXrXl1pzmT-Yvw
Message-ID: <CAAVpQUDwTjXE0-Y1MOjrK2naZ3PTzqdB+sBhC3+8R+1gBPyFkQ@mail.gmail.com>
Subject: Re: [PATCH net] tcp: fix request_sock use-after-free during Fast Open accept()
To: Hyunwoo Kim <imv4bel@gmail.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 9:43=E2=80=AFPM Hyunwoo Kim <imv4bel@gmail.com> wro=
te:
>
> On Wed, Nov 11, 2026 at 05:13:15AM +0000, Kuniyuki Iwashima wrote:
> > On Mon, 09 Nov 2026 15:29:10 +0900, Hyunwoo Kim wrote:
> > > Commit e3d95ad7da4f ("inet: avoid fastopen lock for regular accept()"=
)
> > > made inet_csk_accept() check tfo_listener before taking fastopenq.loc=
k
> > > to avoid taking the lock for connections that did not use Fast Open.
> > >
> > > reqsk_fastopen_remove() clears tfo_listener while holding fastopenq.l=
ock,
> > > then reads req->sk. If inet_csk_accept() concurrently observes
> > > tfo_listener after it has been cleared, it skips fastopenq.lock and
> > > drops the last reference to the request_sock. This can free the
> > > request_sock while reqsk_fastopen_remove() is still using it.
> > >
> > > If the freed memory is reused for a new request_sock with req->sk =3D=
=3D
> > > NULL, the reset path in reqsk_fastopen_remove() can append the new
> > > request_sock to the original listener's list of requests that caused =
an
> > > RST. After the new request_sock is freed, the next append writes thro=
ugh
> > > the stale rskq_rst_tail into freed memory.
> > >
> > > KASAN reported the following use-after-free when writing
> > > fastopenq->rskq_rst_tail->dl_next =3D req:
> > >
> > >   BUG: KASAN: slab-use-after-free in reqsk_fastopen_remove+0x142/0x21=
0
> > >   Write of size 8 at addr ffff888108230688 by task swapper/5/0
> > >   ...
> > >   Call Trace:
> > >    <IRQ>
> > >    ...
> > >    reqsk_fastopen_remove+0x142/0x210
> > >    tcp_check_req+0x96f/0xdd0
> > >    ...
> > >    tcp_rcv_state_process+0x19c/0x26b0
> > >    ...
> > >    tcp_v4_do_rcv+0x16e/0x490
> > >    tcp_v4_rcv+0x14a0/0x1af0
> > >    ...
> > >    ip_protocol_deliver_rcu+0x39/0x1e0
> > >    ip_local_deliver_finish+0x124/0x1e0
> > >    ip_local_deliver+0xfb/0x1e0
> > >    ...
> > >    </IRQ>
> > >
> > > To widen the race windows, mdelay(5) was added after newsk =3D req->s=
k,
> > > mdelay(20) after the if (req) reqsk_put(req) block, and mdelay(100)
> > > after tcp_rsk(req)->tfo_listener =3D false. The KASAN report above wa=
s
> > > reproduced with this kernel.
> > >
> > > For the lockless check, use tcp_sk(newsk)->syn_fastopen_child instead=
 of
> > > tfo_listener, which reqsk_fastopen_remove() clears.
> > >
> > > syn_fastopen_child is a field of the Fast Open child TCP socket
> > > referenced by newsk, not of the request_sock. It is set before the ch=
ild
> > > socket is added to the accept queue. The paths that call
> > > reqsk_fastopen_remove() in response to a remote ACK or RST do not cle=
ar
> > > this field.
> > >
> > > inet_csk_accept() uses this field to take fastopenq.lock only for Fas=
t
> > > Open child sockets and rechecks tfo_listener while holding the lock.
> > > Connections that did not use Fast Open continue to avoid the lock.
> > >
> > > Other bitfields sharing the same byte can be modified concurrently, s=
o
> > > annotate the lockless read of syn_fastopen_child with data_race().
> > >
> > > Fixes: e3d95ad7da4f ("inet: avoid fastopen lock for regular accept()"=
)
> > > Cc: stable@vger.kernel.org
> > > Assisted-by: LLM
> > > Signed-off-by: Hyunwoo Kim <imv4bel@gmail.com>
> > > ---
> > >  net/ipv4/inet_connection_sock.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connecti=
on_sock.c
> > > index e56beec438773..e5e7b844fed44 100644
> > > --- a/net/ipv4/inet_connection_sock.c
> > > +++ b/net/ipv4/inet_connection_sock.c
> > > @@ -683,7 +683,8 @@ struct sock *inet_csk_accept(struct sock *sk, str=
uct proto_accept_arg *arg)
> > >     newsk =3D req->sk;
> > >
> > >     if (sk->sk_protocol =3D=3D IPPROTO_TCP &&
> > > -       tcp_rsk(req)->tfo_listener) {
> > > +       /* Stable while reqsk removal can race; adjacent bitfields ma=
y change. */
> > > +       data_race(!!tcp_sk(newsk)->syn_fastopen_child)) {
> >
> > Are data_race() and !! necessary ?
>
> It was intended to avoid spurious KCSAN reports.

1-bit cannot be torn, and I guess KCSAN will not complain
even if there were a concurrent writer.


>
> Still.. I agree that it looks a little odd. If you think it is
> unnecessary, I will send a v2 without it.

I feel it's misleading as data_race() implies the concurrent
writer, but when syn_fastopen_child is set, the bit itself
and the other bit fields are not written concurrently either.


>
> >
> >
> > >             spin_lock_bh(&queue->fastopenq.lock);
> > >             if (tcp_rsk(req)->tfo_listener) {
> > >                     /* We are still waiting for the final ACK from 3W=
HS
> > > --
> > > 2.43.0
> > >
