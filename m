Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58AF04749C4
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 21:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785275361; cv=pass; b=CeW9Dp+z2INf1cUYC3V7GY93IJ5nB/FiP4OHQyPB0/OUlmxFW2hgkJ3xuvYAxgHL+OI1UVOsxGBYHzJNbQwiNOyHRRMMjhClEuDnlvTNDKOKVGV+vbCLyVCg9zKdWa4MxA0ONUINhU4u3kF3zAW6nZnaShMLvQcS0IGc6Jg6vfE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785275361; c=relaxed/simple;
	bh=6+YVSSISSr4K3N1CESYdcGDiOLPfDJ7tOYGqjIJjHJc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBYIf6zYoQ+jL9QY6FbclyKLVdK15B+Pqe11rbREYDsN409uYWWP75Ajmlk4xbA9GtBUErmnbOvSLBliDt40Hb7u2F4wRmWY5apea0HQ56jbTkjiNLGmYazRqI583F5xdQ2N+N41XrYYvt+PATnAAenoRDVBaYheX43v/klaAow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=jVGX+lrM; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="jVGX+lrM"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8485ef63b68so331770b3a.1
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 14:49:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785275360; cv=none;
        d=google.com; s=arc-20260327;
        b=JFlXTz4vuX1Q7Xuzm/xR9GNJApz/s2lSxXkCFeEvHWdl/bNx4rsxr1IDysuD18zYBU
         ehuOcZiS8jjoYxVto3A4vZxpZQ7eohzzp2cv2tKm3T1nVn8QlRoKGgZJpYlqO1Euu04I
         u3KFMyYUgCkvg5atJtrqe3dK/C5DxpRG+KYG0bfd5MtunBRcriguckCEWpWxeyjzQyXU
         ykjWlXX5m7R0bEQvxZ9xV4jjjY49/K+dC8/ibVAp7zSqjd0XEHR7Ed91UcKHvw2haSXI
         +cfaS4FgwbQk4tCjEY43Xn0VJa+jWVsBsDeQ8xg6NuqMDRqqagQZb6x1h0LPIFZ97oPp
         yYtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=03bH0XOD8NmSRSe9tlCEXsNuTvbzBklSWnh3gNlGzk0=;
        fh=HgDeprUcGA+DnkUlQNUThO7Z4TezGj9mkqzTcSW5AJY=;
        b=kFo5PNHy5z1CQ3e33+mtSw05QE9D5aq+5vA2zQuBOipF4+SX7rt0DBENg+ELjN1iho
         Sdit9hQsFwRlR/p4VLrYq0Mokm4JdoLQS6pxujqj5fZmfo0L/wbxMPMSCnnDcZb9g/Yd
         7maaTHS+d5MBzZ0XMICzz788mP4uvfgmJLpIEMaw4h+hGJ+bet92rq7dNMVrw8ze0Qow
         quNP4uDGRZkBnD6XyrIsMrHnlC9CY30ZKpKvmr8B7+WLs/yJK/cr8vFWKivIIy8rPVsW
         8KCrF5NYa08zG5TXsbK6uxEjAYaYSYS0yoRzzlicRgUdNvQrTZw6B6NffA+RRwidRQFM
         GT0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1785275360; x=1785880160; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=03bH0XOD8NmSRSe9tlCEXsNuTvbzBklSWnh3gNlGzk0=;
        b=jVGX+lrM4L5VvuspsBULsuVJkBB5znpw/etPMItRYpNJl11LLaKNLohsPFZCfvYXG4
         13PbkHVoPj3hIyrcYSGzmo/KcO3X6N1nNyGxjvjc9GXU40A8f6TjPvAEw+DX4jU1sHZS
         9msKmjTmUbqE31Yh4YW8tOsQzMPf6GkyugtCJQVGlrI/wYp+Hqb+RwjuaZ6n+cKhUlTE
         gdkiT8hIrAi4SEZ/JSCDvhjFLl7W47sdQ9PJLbAkRIZy/WvILX7JcckpsBBLqoOt2mLi
         H0pIkzhs5DVwH3krec8nyfGuPr/bLpnBtH968AEnZWX56UPde7G1wBKQ6kzxIVT5H2pQ
         RIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785275360; x=1785880160;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=03bH0XOD8NmSRSe9tlCEXsNuTvbzBklSWnh3gNlGzk0=;
        b=cVYsfDCXjVJqbcLbK0XyChtT9nLbCCim+RVWcBE0S2s2yF0AhEtFLhiLFK7uk9D7RF
         4hkIgQtIs4AwziiEVzItGv/E4k0nHcehs35q4PF4bIemLY/s+qKzhfOMcXqmkINQRezu
         gPZkm268JFK3asLYeKRH6KC7uR+N98MbWzYHecsGZzJwSNXLWEI8tl9AXLneELm+I1Yp
         YqQPWpd8LBuIGd5osn+ecPieSEtcQ5N2fXFjMb1rZM2iuNkesdQhXp4HOC2bg0zIJAEg
         /xaYk/60tQy1S5gj2vx0GNVe5bK/2hIOhXv9rwFeS5c+4H2EcpCXl929sQE1EviiEUZm
         7WRQ==
X-Forwarded-Encrypted: i=1; AHgh+RpWF1lwgpWNqJTtE2jnyGQWt/4GSB7+SotPIGpZR21eyw/xWYYlKrGkZ2YLtH7JXAetXy4js3Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZhpMJkUwHmQBT5ht329wyvjmZKCDjuK17h2TSqSKqO1WTaOTv
	QuN0nAL+Qzp8Ijcre3Nm+Nf8XoHr6X91r5AF6alL6KRWqfJNHy1YuX72THo8U0frtICzi0nVVlt
	NNG4skHwRmdsjV/nSsNT18ESQJzF6106hO+2nsYAW
X-Gm-Gg: AR+sD11ioOgaP9EPjxFDQd8v/aRbDm6zcctAkeD8rxwulOlJqV2hOLqZ+qK30Y863JI
	tWxnT7vSeikHX479wi7nRO4zj4a59z70us3vYmEtQAXfyuMVd0joybS6gvdoYRrSwMaox3v67GK
	qL5Olk3C4qm1Stmr1vnjTNV3+K8OZEZBKDxA15q4+BoEdIJfSYdtLwMaqSlfPEmimcUXgseHi0v
	PAtKuWaAevzZkKG3TwTblFxRr0qdB+s2p2cx2k9QZ0B4QXK17vNnlgh5iNlHwCV8D9L7chBYruq
	SXzrn+U9Wv6VezTmu61C3NxjU7Q9DiTOYivHygGIGYISmueQVGSNEkZmO5fhSZEr6XGPP4vBVRC
	LzKgEJrrw57k=
X-Received: by 2002:a05:6a00:1d8b:b0:845:d274:bf8a with SMTP id
 d2e1a72fcca58-84e9335f318mr4494616b3a.51.1785275359649; Tue, 28 Jul 2026
 14:49:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720204430.1886091-1-xmei5@asu.edu> <20260723100949.4443811e@kernel.org>
 <20260724151100.16b60b15db7c6353b4fedf99@uniroma2.it>
In-Reply-To: <20260724151100.16b60b15db7c6353b4fedf99@uniroma2.it>
From: Xiang Mei <xmei5@asu.edu>
Date: Tue, 28 Jul 2026 14:49:08 -0700
X-Gm-Features: AUfX_mzK-an7Hyw5hp2or3KBHIYfYbcYnhJqBwBsGPEyZFNPZU6diryoA7IZ6Wc
Message-ID: <CAPpSM+QNoS4VQ51UTM2idgG-V_5cNgJ5rf=k9uN0ya7UR2n27Q@mail.gmail.com>
Subject: Re: [PATCH net] seg6: fix NULL deref in input_action_end_dx{4,6}_finish()
 after nf hook
To: Andrea Mayer <andrea.mayer@uniroma2.it>
Cc: Jakub Kicinski <kuba@kernel.org>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pablo Neira Ayuso <pablo@netfilter.org>, Ryoga Saito <contact@proelbtn.com>, 
	AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com, 
	kys@microsoft.com, stefano.salsano@uniroma2.it
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 6:11=E2=80=AFAM Andrea Mayer <andrea.mayer@uniroma2=
.it> wrote:
>
> On Thu, 23 Jul 2026 10:09:49 -0700
> Jakub Kicinski <kuba@kernel.org> wrote:
>
> > On Mon, 20 Jul 2026 20:44:29 +0000 Xiang Mei (Microsoft) wrote:
> > > When nf_hooks_lwtunnel is enabled, the End.DX4/End.DX6 actions dispat=
ch
> > > the decapsulated inner packet through the NF_INET_PRE_ROUTING hook ch=
ain
> > > with input_action_end_dx{4,6}_finish() as the okfn. Both functions re=
ad
> > > the lwtunnel state via orig_dst =3D skb_dst(skb) and dereference
> > > orig_dst->lwtstate.
> >
> > Per Sashiko's feedback - we need to validate not only that the dst
> > is there but also that it is of the expected type, no?
> > --
> > pw-bot: cr
>
> Right, and seg6_input_core/seg6_output_core in seg6_iptunnel.c (added by
> 7a3f5b0de364) read skb_dst()->lwtstate after a NF_HOOK too, and this patc=
h does
> not touch them. A hook can leave a valid dst whose lwtstate is NULL there
> (reproducible with SNAT and an XFRM policy), so they need fixing as well.
>

You are right. Following your hint, I also found seg6_local_input_core(),
which has the same shape. v2 is a series of two patches and covers all
five sites:

seg6_local.c:
  seg6_local_input_core()        LOCAL_IN
  input_action_end_dx4_finish()  PRE_ROUTING
  input_action_end_dx6_finish()  PRE_ROUTING
seg6_iptunnel.c
  seg6_input_core()              POST_ROUTING
  seg6_output_core()             POST_ROUTING

In v2:
  1/2 is for seg6_local.c; 2/2 is for seg6_iptunnel.c.

> seg6/seg6local behaviors carry their processing state in the route's
> lwtunnel_state. That state should be preserved across the hook, and after=
 the
> hook skb_dst() may not carry it, or may point to a different instance of =
the
> same type.
>
> Thanks,
> Andrea

I think you are right about the model, and I spent some time trying to
follow it. These are the places the state could live across the hook:

  okfn argument   fixed signature, cannot change
  skb->cb         owned by IPCB/IP6CB during the chain
  out of band     stale after NF_QUEUE and a late reinject
  re-attach dst   defeats the rule that dropped it
  skb extension   works

So an skb extension really would do it. SKB_EXT_* is refcounted, rides
with the skb, and nf_queue leaves it alone. I want to be clear that your
suggestion is workable; I just did not take it in this series.

My reasoning is scope. It means a new skb_ext type plus an lwtstate
reference on every seg6 packet, which feels like net-next material.

There is also one open question. I want your view on it, and that of
the other maintainers.

Say a DNAT rule in PRE_ROUTING rewrites the inner packet's destination,
and End.DX4 then runs with its state preserved. Then which one is intended:

1) send the packet to slwt->nh4, the nexthop from the SRv6 route.
     This ignores the DNAT rule the admin installed.

 2) route on the new destination instead. This ignores the nexthop the
     SRv6 route asked for.

v2 does neither. It drops the packet. If you have a suggestion for
this, I can do it in v3.

I left the "different instance of the same type" case alone for the same
reason. The type test passes, and the behavior uses another route's
parameters. It is wrong, but it is not a memory bug, and it predates the
crash.

Thanks again,
Xiang
