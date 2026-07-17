Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBD336C9C2
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 18:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784312358; cv=none; b=KqJ4FjiO7rvheb+mx/Z7BKvlHmsqayb4i1JI0WldIunp+4zfVaMCkhhUabDRw5GR688jjL5acOb0KFOFOcVArIKyTNdS4425Kg1zKZz94MCuFiol5sY8kSocca0NCShuKGwU8egh0+LbxdE9BWwjSHeVOLTwJzpGs93Dhw4zK3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784312358; c=relaxed/simple;
	bh=jd0V0MFdrrBAdXDg9zP1xaMqHYbPXVKt2e5sOzglh9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pwej88EN8iUCTRMZ1S48HmH2b6w/pFYjRYCB2OzNqbISJnDAzyV9km7LKFKQELqMY4LtoYSPYv6LRnKevhLaTPg94Pylz4JzbHkvLMAQVoJ5s1b5hKt0TaUIwPDscoUHtw+bVleZiMmEYmZFIc8Hx0YDBT3/D2ZXCWaFQ4Vjx+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g65uSrJA; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g65uSrJA"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-493c733f15aso70531375e9.0
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 11:19:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784312355; x=1784917155; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Tk2nGHCYfzwju+ihpkILs3avZ72pIN3My6xR/p7+cWE=;
        b=g65uSrJAwsWh3ncposWya7b6yJYfI2HvXMxLBlbYw324ZkdH0m5e6xgkfOv6n/kSM2
         sb+gHGPRMpf5nXHBW88zxWT/jz9KHEbxsLol/9VB/NGk5XB+Q34Fno0Ey62AS3sVF5tX
         lIUbQcMJwAyaCD3Xqg0V8tExDHCshFiggEyDMvGr8lkAjpZT3Y28nncV9CLNovb32IYk
         wtwrx5sV7++0oUUoUgXtwyS8/sJ5BK6a2q77uq2vzaGz9O/k+qOzPUKWkeaIZl7HzwWU
         jIV8jWp9GrKU1VuEuJjPMPdm9amuJjSLfe5fRhIv0jstFPKM+9GvHXRINW4ZeXmQkO8a
         /L4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784312355; x=1784917155;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Tk2nGHCYfzwju+ihpkILs3avZ72pIN3My6xR/p7+cWE=;
        b=IzXXm0qznlfWVe1GaF0EX7X0ttLxEFGzq8LTmInie4H7gnLqhpRqPwTTkHdxY2U3pY
         +0CHCCInrTXzgH+J+nuf69M/5AGBQBdAMk6UxpkV1JBf63ZRZMjHQ/7va/KMNw9pqsaO
         z2iUIoOAe84IoGp3TriZjAZT72vbc/olPVHjJe1sZ5fGnxPPnM6qTWe0LFlrgLIvQljZ
         nCdYnCBQtu/38iPoQgXcJEbh9nPJWKcd5+IRKR6rCjj7kPkpupm+cG/1M2S7NvFfLR3Q
         j5iNqU5b7H9+/dkbImcrJ4qKEGZfwHCi2pHs2EZlWXZZE6vtz3h0ffLcIRBYxyEo1nE6
         qR1Q==
X-Forwarded-Encrypted: i=1; AHgh+RqjmMb9uCfztd+REHGKlOIhF2swvToHQfaXjwArMfOscI1tbujhjUw+5x1eYNLRSHzBTk2K4E8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMwPRwwtOJOJjB+Cl+K0vbfGyRlDcmPSXYLwJYycSRyO07anfa
	1tWrgw6nor5HOSEYiXVVSzP7UyFImsA5nTKmX1IPVN3c2mygW/HrLyhV
X-Gm-Gg: AfdE7ckyUETMiHwp5o7jLHDhQdyQL4HKFtFFhVJdmMeWYh5ZQwBfQz7LP9rTw3mBIdR
	mERG0ZNDMkzEiozwQyLTo+2a2CIh6xVEyNj5S3PgLPUwlQjiLXZPqdIpb5xzgVjmM7XURk0p1N/
	INXKDMc9mW6NrOYNhDhKQwIW1mbdlQkMduumDgsyC5HN+coNLAk0Dw+yvVOO/v70CI8JeY0V/lu
	81Qcvca4emZhHGPYp53szVahMVlPfoWfO1raQARGcJxtjufYiArRBWteBbZkg2LKvBuIBUX4pzM
	VTPlTVIZMSYbON/6MJrKDPE2IF5T0bYuPG8kRkWwpcQC65dHh/X7uIP7DFlqjEPtjSIp+LrNdej
	iGwDJ+MBfQFhvMSznOwr2JgkCzno9PmLjKDYiWEv5nxO4sbyqgHDO7+yCz4sxMqptDkbUN4dkEv
	rYvmD9V2c+2KBSu/zzCR/L2bJht3uyP/roSsKeAuY=
X-Received: by 2002:a05:600c:574d:b0:492:4a50:41fe with SMTP id 5b1f17b1804b1-4954a405e58mr31399415e9.22.1784312354889;
        Fri, 17 Jul 2026 11:19:14 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2eddb8sm137976275e9.14.2026.07.17.11.19.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 11:19:14 -0700 (PDT)
Date: Fri, 17 Jul 2026 19:19:13 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Xin Long <lucien.xin@gmail.com>
Cc: luoqing <l1138897701@163.com>, jedrzej.jagielski@intel.com,
 davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 kuba@kernel.org, linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org,
 luoqing@kylinos.cn, marcelo.leitner@gmail.com, netdev@vger.kernel.org,
 pabeni@redhat.com
Subject: Re: [PATCH net v3] sctp: socket: remove unused 'err' parameter from
 sctp_skb_recv_datagram
Message-ID: <20260717191913.490e5d80@pumpkin>
In-Reply-To: <CADvbK_dHFt6cceHQ5BwPMWbF1j4i8BtYZ4Su067SvMeiiD6Rcw@mail.gmail.com>
References: <PH0PR11MB5902DBD696C30DB0A2308A49F0C72@PH0PR11MB5902.namprd11.prod.outlook.com>
	<20260717082048.948262-1-l1138897701@163.com>
	<CADvbK_dHFt6cceHQ5BwPMWbF1j4i8BtYZ4Su067SvMeiiD6Rcw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 17 Jul 2026 11:10:21 -0400
Xin Long <lucien.xin@gmail.com> wrote:

> On Fri, Jul 17, 2026 at 4:21=E2=80=AFAM luoqing <l1138897701@163.com> wro=
te:
> >
> > From: luoqing <luoqing@kylinos.cn>
> >
> > The 'err' parameter in sctp_skb_recv_datagram() is never used by any
> > of its callers. Both sctp_recvmsg() and sctp_ulpevent_read_nxtinfo()
> > pass the address of a local variable but never check its value after
> > the function returns, rendering the parameter completely useless.
> >
> > Remove the unused parameter to simplify the function signature and
> > eliminate dead code.
> >
> > Signed-off-by: luoqing <luoqing@kylinos.cn>
> > ---
> >  include/net/sctp/sctp.h |  2 +-
> >  net/sctp/socket.c       | 10 +++-------
> >  net/sctp/ulpevent.c     |  3 +--
> >  3 files changed, 5 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
> > index d50c27812504..b86d50d6b146 100644
> > --- a/include/net/sctp/sctp.h
> > +++ b/include/net/sctp/sctp.h
> > @@ -97,7 +97,7 @@ void sctp_sock_rfree(struct sk_buff *skb);
> >
> >  extern struct percpu_counter sctp_sockets_allocated;
> >  int sctp_asconf_mgmt(struct sctp_sock *, struct sctp_sockaddr_entry *);
> > -struct sk_buff *sctp_skb_recv_datagram(struct sock *, int, int *);
> > +struct sk_buff *sctp_skb_recv_datagram(struct sock *sk, int flags);
> >
> >  typedef int (*sctp_callback_t)(struct sctp_endpoint *, struct sctp_tra=
nsport *, void *);
> >  void sctp_transport_walk_start(struct rhashtable_iter *iter);
> > diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> > index c7b9e325ec1c..3804382d78e0 100644
> > --- a/net/sctp/socket.c
> > +++ b/net/sctp/socket.c
> > @@ -2123,7 +2123,7 @@ static int sctp_recvmsg(struct sock *sk, struct m=
sghdr *msg, size_t len,
> >                 goto out;
> >         }
> >
> > -       skb =3D sctp_skb_recv_datagram(sk, flags, &err);
> > +       skb =3D sctp_skb_recv_datagram(sk, flags);
> >         if (!skb)
> >                 goto out;
> >
> > @@ -9082,7 +9082,7 @@ static int sctp_wait_for_packet(struct sock *sk, =
int *err, long *timeo_p)
> >   * Note: This is pretty much the same routine as in core/datagram.c
> >   * with a few changes to make lksctp work.
> >   */
> > -struct sk_buff *sctp_skb_recv_datagram(struct sock *sk, int flags, int=
 *err)
> > +struct sk_buff *sctp_skb_recv_datagram(struct sock *sk, int flags)
> >  {
> >         int error;
> >         struct sk_buff *skb;
> > @@ -9120,17 +9120,13 @@ struct sk_buff *sctp_skb_recv_datagram(struct s=
ock *sk, int flags, int *err)
> >                 if (sk->sk_shutdown & RCV_SHUTDOWN)
> >                         break;
> >
> > -
> >                 /* User doesn't want to wait.  */
> >                 error =3D -EAGAIN;
> >                 if (!timeo)
> >                         goto no_packet;
> > -       } while (sctp_wait_for_packet(sk, err, &timeo) =3D=3D 0);
> > -
> > -       return NULL;
> > +       } while (sctp_wait_for_packet(sk, &error, &timeo) =3D=3D 0);
> >
> >  no_packet:
> > -       *err =3D error;
> >         return NULL;
> >  }
> >
> > diff --git a/net/sctp/ulpevent.c b/net/sctp/ulpevent.c
> > index 8920ca92a011..8ed51a15c3a4 100644
> > --- a/net/sctp/ulpevent.c
> > +++ b/net/sctp/ulpevent.c
> > @@ -1061,9 +1061,8 @@ void sctp_ulpevent_read_nxtinfo(const struct sctp=
_ulpevent *event,
> >                                 struct sock *sk)
> >  {
> >         struct sk_buff *skb;
> > -       int err;
> >
> > -       skb =3D sctp_skb_recv_datagram(sk, MSG_PEEK | MSG_DONTWAIT, &er=
r);
> > +       skb =3D sctp_skb_recv_datagram(sk, MSG_PEEK | MSG_DONTWAIT);
> >         if (skb !=3D NULL) {
> >                 __sctp_ulpevent_read_nxtinfo(sctp_skb2event(skb),
> >                                              msghdr, skb);
> > --
> > 2.25.1
> > =20
> I think it's used at [1] in sctp_recvmsg():
>=20
>         skb =3D sctp_skb_recv_datagram(sk, flags, &err);
>         if (!skb)
>                 goto out;

Would it make more sense to ERR_PTR() etc ?

	David

> ...
>=20
> out:
>         release_sock(sk);
>         return err;   <------ [1]
>=20
> Thanks.
>=20

