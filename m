Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49842E7381
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 15:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784561166; cv=pass; b=M51cNYqsaXar6/ozf433fpTWilXAtepIDTh8Uc69D8rKstxGr1Rtf0GwV2F4qPpePC2qX6mmIxcR5d60Uj1xKcJq+5FLyprbczP/V/b9h7YqfXybT30Ai4Rar7kHjLYOd41zXO6BHH7RltUXCKwuMh60TbxHIhe38Szsk/apG9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784561166; c=relaxed/simple;
	bh=IunsqnEz/1Pn3fZK1zV4V1SviDMNSBXP3t+MpjQdMPQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KNSM1jlIHVg6Fij1R8MCLbXsFR34N2rgXJ3IbwI/Ea2B+iuLOn7q97jpVMp0IiuxqYCPkwqcGrwH3j4a2OJdKL5XvGFwnR0G0wzsww2Jx2e3Y7FpVBMVAAuwWBIRoyrfPM30YdRaEBENzs+xIk9c0KOpnGwya0BSIXznNEQUV/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S54/NzGJ; arc=pass smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S54/NzGJ"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-848595b338cso11694826b3a.0
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 08:26:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784561161; cv=none;
        d=google.com; s=arc-20260327;
        b=b2uQIHqvwSTqIcYCZS+SyWeNM9p3nCNpzUQbfT2fo0P9GrijHV4Uhi5MboavCU60TO
         d+D8vxdh7Kxy2oGl+uaW2FbtTQp6ZhAJ0hv0P9YTD+FCdHOBzWx0pDO5n2kodq3x7IwA
         xK2KY+onkjtsE7cT4s2EjeZWanSQNBdoMcS1+q78IQ/G5s7rQsAGT8t5VsNzeZPlzwaW
         AqkcyrrY7plSgJvMsgTfk28lNulMk0/h83lmQG/DTlbV9vi5saSy779TeEPUP3uyS3Pk
         mymrp2sWyasndjBnqnIxWvewUajVw/kgYKAFIxF2fEN2RO69q1VNhdG4jq0B9hclPNFb
         ebag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B5X+/rf0QzcF5B93IYv9JZ6xs3/FlAEwkKMPzpox2ug=;
        fh=FZcp5itZQYvKBsglKzcB97XRICMpc4+wuuC7qNvslrE=;
        b=JY8+H7CI5Odwqo3NsaCcdDuGX59g1Jv2TO79wa60pwd1NfPO35ZXESlX8w3NTwF01H
         cmgiboohpym400iKcQFuwBxMiHtn9m2TYn7ydoOhsQ8zw501PJrCgVEIAK0hHr2mVV3m
         kVDRqunL5FusAV4CQLoHPRxGBrNjXKQVQ100JhTL99oN3ChMRZEmoa1USIB+7NqUNRP+
         7b2zJR3yBq8PKCwzMeM2Lk1v0hKkIxCjRy5JN6DK48JBR1iEF0JITVAk+FjzCxxvInnI
         BNQpIpelwV0rC2wyS94nmCq9qaGwlbz04SroVaDD45UuqODalmvIQRTj+lwpXzT64E5o
         g+8A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784561161; x=1785165961; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B5X+/rf0QzcF5B93IYv9JZ6xs3/FlAEwkKMPzpox2ug=;
        b=S54/NzGJGz08pE3Wvv7gHfyohjGFxbAyOB7uiwn2Q07gb9YkGJZ2/Ds3/5edi1ak9N
         eVKMC3p+qPt3aSlhqdSLlBp23ObNGjDTf/3gPnAJH4mkWVbt8tctUF4/KeYo2Y80mqy8
         tq82zVyS9FnSEi/B/asHVapLeGO3HABDqF2GQ+LPe9rJIapTstBWscXwoy/tu66MDdFx
         tDsA+xsw6VgCJLGckyxXRyO4u5LeFixOGjSAkDi+GfZ1hqr5hCMG78sgnDRaILXyUONw
         ePW/AymDBQ7VJzIyPVcK0oWF0fcf0CVXh//WVsovJ2s5a2t7VmASMpFjF01A4hDH7a+T
         Z/xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784561161; x=1785165961;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B5X+/rf0QzcF5B93IYv9JZ6xs3/FlAEwkKMPzpox2ug=;
        b=CxGKeJ66a/UQ9KtMg0DAjRGkWaXzk9NEsvoI1Nlwd3ZqeS8/jhW3jyAr2SyEvQ1ZMk
         kw383PLf6ZRkW+rPx8cJX3TvTkfCrHv1xgqrq13ENJIeqnckOSkR0kmflBgS0o1murJa
         dVNY9DlJ402tezFNeUy3CuTrPauLh2euIn/AZtsgzPck2xsK/ae7oH83xvuL6QtcoJ61
         7/SdTMuWZvFwUrSzQwSyOBmn8ca06Z2Ips1SzCxoNiHN61DzYrWtFG0Pt0FBLafaOwBk
         /dfDymMSOTou8F41Vb4Ac7Hu3pYpW6Mu0W9HPhxY32RRoczI/6HE8+8q7BW7TEPPKjlz
         Xc0Q==
X-Forwarded-Encrypted: i=1; AHgh+RrXYVK0dUhAnVqcKGmkfaj3WrW3ZezSA8/cIc+RGy7agtdEwKDXWmTvsthtGEs3tiGMGMQpQbM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGFzIVnn22VKoU7ED2j8AfAtkziD0eePy/txxALbMuLnKN5zMi
	XzDj3Q/n5xRi8npZSsOsZx2aEbM7ejBAJ+r0/zHPZHOenRM4Lw/19PbeaFI1m/fFMtqFAOIWcgM
	4VkbkKgN/2OElbHs0qMZ7Xvw0NWuMKE2iCAU3
X-Gm-Gg: AfdE7cn44vSZ0Z+DtEmtv4zkBj93D+wgr0uTWJZklTf8rd1aVkif5TVvVNGzJ8UW/Ig
	EelRE95G5dXn3vp9mxidLk1LYjwqepqCYnmZGQBgh3G4cdxxC8Y9Mx/xtfCODyLLep4dckIe7AT
	Q4HYfJFlV0yT0ZedRcIRe+Oh0RR3sC0QODKuBV6Dl/XY8wtNXIinXuIoe8JS9OlJ/U2TnkCoEG5
	sZvazBn6xq5Z+y1v8iJYD3UjQrMzZ+bKP+svQJXgWqoB+m+YozTjuXVV4wIUhydupAzX6l9Ns3E
	5GIlydTmrRdUTf/n0ydhVmsCrL4QHCl0vW6B3WjsbAIXB19z0HA9sj+tS5F/NA5iqssashjfGA=
	=
X-Received: by 2002:a05:6a00:2e2a:b0:847:95a6:eb74 with SMTP id
 d2e1a72fcca58-84c2930f035mr15096588b3a.23.1784561161052; Mon, 20 Jul 2026
 08:26:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <PH0PR11MB5902DBD696C30DB0A2308A49F0C72@PH0PR11MB5902.namprd11.prod.outlook.com>
 <20260717082048.948262-1-l1138897701@163.com> <CADvbK_dHFt6cceHQ5BwPMWbF1j4i8BtYZ4Su067SvMeiiD6Rcw@mail.gmail.com>
 <20260717191913.490e5d80@pumpkin>
In-Reply-To: <20260717191913.490e5d80@pumpkin>
From: Xin Long <lucien.xin@gmail.com>
Date: Mon, 20 Jul 2026 11:25:49 -0400
X-Gm-Features: AUfX_mzleTwQDArjEhrrX6Cq0N6HoU0SDPI8Cw61rRb62BuX9DVgp4jWswVPYE0
Message-ID: <CADvbK_dxAc+oepu05pvoj5Ze93u6tMdB-6QQQRaMVhznM_9MTg@mail.gmail.com>
Subject: Re: [PATCH net v3] sctp: socket: remove unused 'err' parameter from sctp_skb_recv_datagram
To: David Laight <david.laight.linux@gmail.com>
Cc: luoqing <l1138897701@163.com>, jedrzej.jagielski@intel.com, davem@davemloft.net, 
	edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-sctp@vger.kernel.org, luoqing@kylinos.cn, 
	marcelo.leitner@gmail.com, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 17, 2026 at 2:19=E2=80=AFPM David Laight
<david.laight.linux@gmail.com> wrote:
>
> On Fri, 17 Jul 2026 11:10:21 -0400
> Xin Long <lucien.xin@gmail.com> wrote:
>
> > On Fri, Jul 17, 2026 at 4:21=E2=80=AFAM luoqing <l1138897701@163.com> w=
rote:
> > >
> > > From: luoqing <luoqing@kylinos.cn>
> > >
> > > The 'err' parameter in sctp_skb_recv_datagram() is never used by any
> > > of its callers. Both sctp_recvmsg() and sctp_ulpevent_read_nxtinfo()
> > > pass the address of a local variable but never check its value after
> > > the function returns, rendering the parameter completely useless.
> > >
> > > Remove the unused parameter to simplify the function signature and
> > > eliminate dead code.
> > >
> > > Signed-off-by: luoqing <luoqing@kylinos.cn>
> > > ---
> > >  include/net/sctp/sctp.h |  2 +-
> > >  net/sctp/socket.c       | 10 +++-------
> > >  net/sctp/ulpevent.c     |  3 +--
> > >  3 files changed, 5 insertions(+), 10 deletions(-)
> > >
> > > diff --git a/include/net/sctp/sctp.h b/include/net/sctp/sctp.h
> > > index d50c27812504..b86d50d6b146 100644
> > > --- a/include/net/sctp/sctp.h
> > > +++ b/include/net/sctp/sctp.h
> > > @@ -97,7 +97,7 @@ void sctp_sock_rfree(struct sk_buff *skb);
> > >
> > >  extern struct percpu_counter sctp_sockets_allocated;
> > >  int sctp_asconf_mgmt(struct sctp_sock *, struct sctp_sockaddr_entry =
*);
> > > -struct sk_buff *sctp_skb_recv_datagram(struct sock *, int, int *);
> > > +struct sk_buff *sctp_skb_recv_datagram(struct sock *sk, int flags);
> > >
> > >  typedef int (*sctp_callback_t)(struct sctp_endpoint *, struct sctp_t=
ransport *, void *);
> > >  void sctp_transport_walk_start(struct rhashtable_iter *iter);
> > > diff --git a/net/sctp/socket.c b/net/sctp/socket.c
> > > index c7b9e325ec1c..3804382d78e0 100644
> > > --- a/net/sctp/socket.c
> > > +++ b/net/sctp/socket.c
> > > @@ -2123,7 +2123,7 @@ static int sctp_recvmsg(struct sock *sk, struct=
 msghdr *msg, size_t len,
> > >                 goto out;
> > >         }
> > >
> > > -       skb =3D sctp_skb_recv_datagram(sk, flags, &err);
> > > +       skb =3D sctp_skb_recv_datagram(sk, flags);
> > >         if (!skb)
> > >                 goto out;
> > >
> > > @@ -9082,7 +9082,7 @@ static int sctp_wait_for_packet(struct sock *sk=
, int *err, long *timeo_p)
> > >   * Note: This is pretty much the same routine as in core/datagram.c
> > >   * with a few changes to make lksctp work.
> > >   */
> > > -struct sk_buff *sctp_skb_recv_datagram(struct sock *sk, int flags, i=
nt *err)
> > > +struct sk_buff *sctp_skb_recv_datagram(struct sock *sk, int flags)
> > >  {
> > >         int error;
> > >         struct sk_buff *skb;
> > > @@ -9120,17 +9120,13 @@ struct sk_buff *sctp_skb_recv_datagram(struct=
 sock *sk, int flags, int *err)
> > >                 if (sk->sk_shutdown & RCV_SHUTDOWN)
> > >                         break;
> > >
> > > -
> > >                 /* User doesn't want to wait.  */
> > >                 error =3D -EAGAIN;
> > >                 if (!timeo)
> > >                         goto no_packet;
> > > -       } while (sctp_wait_for_packet(sk, err, &timeo) =3D=3D 0);
> > > -
> > > -       return NULL;
> > > +       } while (sctp_wait_for_packet(sk, &error, &timeo) =3D=3D 0);
> > >
> > >  no_packet:
> > > -       *err =3D error;
> > >         return NULL;
> > >  }
> > >
> > > diff --git a/net/sctp/ulpevent.c b/net/sctp/ulpevent.c
> > > index 8920ca92a011..8ed51a15c3a4 100644
> > > --- a/net/sctp/ulpevent.c
> > > +++ b/net/sctp/ulpevent.c
> > > @@ -1061,9 +1061,8 @@ void sctp_ulpevent_read_nxtinfo(const struct sc=
tp_ulpevent *event,
> > >                                 struct sock *sk)
> > >  {
> > >         struct sk_buff *skb;
> > > -       int err;
> > >
> > > -       skb =3D sctp_skb_recv_datagram(sk, MSG_PEEK | MSG_DONTWAIT, &=
err);
> > > +       skb =3D sctp_skb_recv_datagram(sk, MSG_PEEK | MSG_DONTWAIT);
> > >         if (skb !=3D NULL) {
> > >                 __sctp_ulpevent_read_nxtinfo(sctp_skb2event(skb),
> > >                                              msghdr, skb);
> > > --
> > > 2.25.1
> > >
> > I think it's used at [1] in sctp_recvmsg():
> >
> >         skb =3D sctp_skb_recv_datagram(sk, flags, &err);
> >         if (!skb)
> >                 goto out;
>
> Would it make more sense to ERR_PTR() etc ?
>
Let's keep consistent with skb_recv_datagram() where it's &err,
besides, there's a shutdown condition (returns 0 via err param).

Thanks.
