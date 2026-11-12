Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.179
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794518051;
	b=uYyaNQ9xAtCua+mL/Hfz8atdCgt0DZ3wkPP1iXp9pdSXWDBp8krLSEdpH4cDIG6aFPUn
	 ChpllFcnrCfLhkUSAq3S+jisYtncJ14CBbeHVlf8PA0jKeen54bB1guIJa2L8jIuy8Roo
	 onS3HUVfvx1sXV2ha2HQvGnsFNCxXBaUogp3pTJrI9CGEsLoCScuSFHhbWlsDXNIq06MR
	 ZoJfrfIUrnl1x/M9NMrcQWU4bn41iL9g8KmpYEUILnxIrpTLNzg8cbOgoopbUrQkY2O47
	 42ntsqKwCIayKTCpqrNqTELb34hMOAeSs4oIVKUFhFow8xepmj0oWEmRCZevuZKHBjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794518051;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PrfXz08H+34PFhR+mDKWipfCfKpSe7p7ek5/2sq7ELs=;
	b=1DJnsa8zwHzb4qis1TzAt2tOUEnLfnmtAwjbTXZ9j7k19sRcAzgZEhjvLRRC7W4guFZM
	 mQgc30V+wX6JZ7SqEondTh0mHEY6OYa5l4paG53IDEseavVslNC/PeJu1U/xdfOMib6ty
	 eWtcHODNFSd6LJV4aBnsHte13eOEte0VBFU2arKDezXU864FWLYkplzvFqydxYESHpjCa
	 0bLCJUOD22WlR5r8t7c37rCCDN2/mMDzZStuvewJ7rAd8W4f/RSWk/T2VAbST0V+NwSJz
	 7rV1kothOaGrYmwiR31TvoNIf/A+2v6tU+wP7ptn7/mvVJPzXDGm8Imxeof8uPeD4pA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WcBHXqCn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.179
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DDBA606A331
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 21:14:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DDBA606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WcBHXqCn
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-8a9f9473029so274257b3a.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 13:14:09 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794518049; cv=none;
        d=google.com; s=arc-20260327;
        b=TugkO9u+hJiQZhhMND7M0fRdByBvBt2mI4C4Copyp5I69y+yW+lAKQLlGewiraeMyQ
         hAb640gNmtogdcEn34mSuNn4skErWQTqXOSKE1mUqJwXrUev5RkReJUtiHzHdHIOMhRr
         qNgug38Zuozwk5jNwnUrVpjmdzbTChuQzgkiuAWitINj1ya6QqV6nljg0rNXcgnc7BPM
         M/s3E7rlsqaQ98zaPCdzQu262DY7tHpd/7djEpLCSLPrF4ZjV/m1PErJaaMNbpicuOmX
         ABhbeyApN5z506LL3w8w4wi9sLjO54Jus7imNzWgLjRtJmb82hHCoKrPKEJTzWtRQZD3
         etAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PrfXz08H+34PFhR+mDKWipfCfKpSe7p7ek5/2sq7ELs=;
        fh=eOUoAokzubjTohWTNXWKe9b3tHDxP5ZRUBP95ib8px0=;
        b=R4ubOC8RYJE/fjsTp0x3yuUULv7cux5bnHDr+8h0Y5VsbippS6a+3JYDJWFHG/MbIN
         lrRX+PJmXlPRlP5Nctt/jMCOsKIJKer3tVOynZH/owiMF6uLB67nW2PrGPsnEDV8154m
         WO/vx33Z7zR6dmr+0o/L+9Ba0gskgw/H9YmSCynvcn+MO03fKCKHL9Pn3KK/muotKsrJ
         FNMtq3TiykIr6tN4P6NGLT3Z+d81w0D2fUSY+PwIZH+rG59recGU1QTg4O3iKU0Da88j
         OBBFQBH+if60jVZHrlnPE68TMXTv4yMF3W6Ct4Qns4JsGDwMe32kfUkjpVdxmghXYGZj
         viiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794518049; x=1795122849; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PrfXz08H+34PFhR+mDKWipfCfKpSe7p7ek5/2sq7ELs=;
        b=WcBHXqCnx04AgsRRw+B9o59yp2jyEV1UiqvXVnqHdIt5kuB0FmrnJjWM33pISB72n+
         QLfzexQSV6KYXC6u/e5ecjNr/vOnIaAox+ghv42a6me77npj6BqhlmhXDtKXV/Zkg4rM
         utOxFtup3mHOIaz2bHCU23D3ksUbwi8jHLV+F5Fh8oILCQurqEBRzLEebYQh82cUk9ZY
         8LjEOQh1/4uWqWZ+rSMroLhSn7NGWOQTwm3B1RNvGbxShpMZGM9++aEeYs30VMswGvsj
         hDWHsXkMvmYY7rYyeRNJJs7o4E09heEvTdDasSvAliBjoZgk/PFzXphtt+n76mUMuA/C
         OWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794518049; x=1795122849;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PrfXz08H+34PFhR+mDKWipfCfKpSe7p7ek5/2sq7ELs=;
        b=OtWpUGyxxsVwOsLPiIA4qE7u1zmebWRLhIdyYoUmKDUEqJnzmsxQa+qdRbUERIhDS3
         DzJY8Bi1+gxcZRMJ1Xr9azwIylWk/yTmhTktHYzGi0/7c7cMfHdexGN/9f9VzAO1Rtzq
         Z3Ev/glI4PwKv8KQ6G6vrL0f7IZidLjHI+3rqmYUihav/Wktjx37siUqYfGPOEyQwizs
         PlmVM1gp+D5+nHWkuHVh3oC1gvByLloAwdRPF+AplE/bUcy+sdpcW7J2VawfBRMtLP4P
         sC+cJJr6ZfkJa5IRbKQpzVxPBWgtyrD0EPWiV67JOD25OGEPo2YGim7lXzfCBTK0Kw7o
         EPoA==
X-Forwarded-Encrypted: i=1; AL+hErESaNMmKM5xCKsIsOvwNz5ax5L1LoO/GCnByKYccF3K/uL8uINguLK/F5pjM4a1NNu6ekdqVeI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8FsiQqzsdr68/9F/wNbS06bbGc2U2q75QG8/NjpJ21AFLm9w5A
	N8cKymA0xvRG8bpB5T36m6DaE6pa8WvS0VoGQtdWphWsBWTWUQ1fvooGvCzNt7xbM9mVYxrco6J
	VfWw0v/iLgGRk9VjUvQRerCzxkOuGouA=
X-Gm-Gg: AYBFou3CxXQ5V+8bnctLKNMs8C/y1PIT+XrLqS2qQxYJvxt4wYjD7QxVthXeMgb80xv
	L33c1Y5YWjxeG9AeeYZlcnE68/MvLTZ8ysaQN4j7HT6Bl1tEKAvO9/H/eJ/g5YCekrsLES17a3t
	4I3uzvZOQaGBwvMMZJbggnKGmPmLoZb/wiEj5cRNANss2TnjV4GV1eFmW7DZKDQ882Rb33O182B
	HVU27/vG3GIUQytpme+ez4EkbaxC43hChOWGXVu0QKfosEUdwVvaSynImulTHHvyZQdgOjNKAln
	i2UR1M7GZ+grL26B2QQUeoh/NZxKwQ1cobB6T5IqChFi17sHe/+h8xhzbTunPD98rTGdZDVUmJa
	6L37at/skPh0qqdkcPHrDPIabsD23cYKotspcDUKirlc0CpltHY5CB0LOEuaHcExo0C/fRdXByY
	/scVbtPJ198LiGgzldXlVW550yeOs1A300wyeBu8/Vz74BT5bOKsqjzlNWJRP64QcwNS0gBSGTL
	x3RVPLDFHpnFVgs9Bg=
X-Received: by 2002:a05:6a00:2311:b0:891:3e34:e06f with SMTP id
 d2e1a72fcca58-8beb7539e7fmr667897b3a.44.1794518048547; Thu, 12 Nov 2026
 13:14:08 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261110120212.1110283-1-pkfxxxing@gmail.com> <20261110120212.1110283-2-pkfxxxing@gmail.com>
In-Reply-To: <20261110120212.1110283-2-pkfxxxing@gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Thu, 12 Nov 2026 16:13:56 -0500
X-Gm-Features: AclHuK8r89MZhNaP-FJ80tjfRygA5rIFvNd4P4o3dAcP_IW4NOz1scQ_2zf5I0s
Message-ID: <CADvbK_dYGutb+-D+Q6pA2MSJr6WZGQUrD+6haS1NoMqaxZ5a5Q@mail.gmail.com>
Subject: Re: [PATCH 1/1] sctp: revalidate the association socket in timer callbacks
To: liuyong <pkfxxxing@gmail.com>
Cc: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, linux-sctp@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 10, 2026 at 7:03=E2=80=AFAM liuyong <pkfxxxing@gmail.com> wrote=
:
>
> SCTP timer callbacks cache asoc->base.sk before acquiring its BH lock.
> An accept or peeloff can move the association to a new socket in between.
> The callback can then run the state machine under the old socket lock,
> while an abort on the new socket tears down the association's queues.
> The timer's transport and association references do not keep those
> queues alive. With delays inserted to widen the race, KASAN reported a
> slab-use-after-free in sctp_chunk_abandoned() from the T3 retransmit path=
.
>
> Recheck the association's socket after acquiring its BH lock. Treat a
> mismatch like a busy socket and use the existing reference-counted timer
> rescheduling path. The next callback reads the current socket again,
> preventing state-machine execution under the old socket's lock. Retain
> the user-ownership check to handle a migration already in progress.
>
> Apply the check to the T3, association, heartbeat, protocol-unreachable,
> reconfiguration and probe timers. Their BH context and the endpoint's
> RCU-deferred sock_put() protect the cached socket during the callback.
> Pair the socket pointer reads with WRITE_ONCE() in sctp_assoc_migrate(),
> taking the new socket reference before updating the pointer.
>
> The issue was discovered and fixed by Qihoo 360's Tulongfeng multi-agent
> system.
>
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: liuyong <pkfxxxing@gmail.com>
> ---
>  net/sctp/associola.c     |  4 ++--
>  net/sctp/sm_sideeffect.c | 41 ++++++++++++++++++++--------------------
>  2 files changed, 22 insertions(+), 23 deletions(-)
>
> diff --git a/net/sctp/associola.c b/net/sctp/associola.c
> index 4521be3bd8..c5d520c8d7 100644
> --- a/net/sctp/associola.c
> +++ b/net/sctp/associola.c
> @@ -1088,8 +1088,8 @@ void sctp_assoc_migrate(struct sctp_association *as=
soc, struct sock *newsk)
>         sctp_endpoint_hold(assoc->ep);
>
>         /* Get a reference to the new sock.  */
> -       assoc->base.sk =3D newsk;
> -       sock_hold(assoc->base.sk);
> +       sock_hold(newsk);
> +       WRITE_ONCE(assoc->base.sk, newsk);
>
>         /* Add the association to the new endpoint's list of associations=
.  */
>         sctp_endpoint_add_asoc(newsp->ep, assoc);
> diff --git a/net/sctp/sm_sideeffect.c b/net/sctp/sm_sideeffect.c
> index 35f540fb15..bd6b23369f 100644
> --- a/net/sctp/sm_sideeffect.c
> +++ b/net/sctp/sm_sideeffect.c
> @@ -233,15 +233,14 @@ void sctp_generate_t3_rtx_event(struct timer_list *=
t)
>         struct sctp_transport *transport =3D
>                 timer_container_of(transport, t, T3_rtx_timer);
>         struct sctp_association *asoc =3D transport->asoc;
> -       struct sock *sk =3D asoc->base.sk;
> +       struct sock *sk =3D READ_ONCE(asoc->base.sk);
>         struct net *net =3D sock_net(sk);
>         int error;
>
> -       /* Check whether a task is in the sock.  */
> -
> +       /* Defer if the socket is busy or the association has migrated. *=
/
>         bh_lock_sock(sk);
> -       if (sock_owned_by_user(sk)) {
> -               pr_debug("%s: sock is busy\n", __func__);
> +       if (sock_owned_by_user(sk) || sk !=3D READ_ONCE(asoc->base.sk)) {
> +               pr_debug("%s: sock is busy or moved\n", __func__);
>
>                 /* Try again later.  */
>                 sctp_transport_hold(transport);
> @@ -271,13 +270,13 @@ void sctp_generate_t3_rtx_event(struct timer_list *=
t)
>  static void sctp_generate_timeout_event(struct sctp_association *asoc,
>                                         enum sctp_event_timeout timeout_t=
ype)
>  {
> -       struct sock *sk =3D asoc->base.sk;
> +       struct sock *sk =3D READ_ONCE(asoc->base.sk);
>         struct net *net =3D sock_net(sk);
>         int error =3D 0;
>
>         bh_lock_sock(sk);
> -       if (sock_owned_by_user(sk)) {
> -               pr_debug("%s: sock is busy: timer %d\n", __func__,
> +       if (sock_owned_by_user(sk) || sk !=3D READ_ONCE(asoc->base.sk)) {
> +               pr_debug("%s: sock is busy or moved: timer %d\n", __func_=
_,
>                          timeout_type);
>
>                 /* Try again later.  */
> @@ -362,7 +361,7 @@ static void sctp_generate_autoclose_event(struct time=
r_list *t)
>         sctp_generate_timeout_event(asoc, SCTP_EVENT_TIMEOUT_AUTOCLOSE);
>  }
>
> -/* Generate a heart beat event.  If the sock is busy, reschedule.   Make
> +/* Generate a heart beat event.  If the sock is busy or moved, reschedul=
e.   Make
>   * sure that the transport is still valid.
>   */
>  void sctp_generate_heartbeat_event(struct timer_list *t)
> @@ -370,14 +369,14 @@ void sctp_generate_heartbeat_event(struct timer_lis=
t *t)
>         struct sctp_transport *transport =3D timer_container_of(transport=
, t,
>                                                               hb_timer);
>         struct sctp_association *asoc =3D transport->asoc;
> -       struct sock *sk =3D asoc->base.sk;
> +       struct sock *sk =3D READ_ONCE(asoc->base.sk);
>         struct net *net =3D sock_net(sk);
>         u32 elapsed, timeout;
>         int error =3D 0;
>
>         bh_lock_sock(sk);
> -       if (sock_owned_by_user(sk)) {
> -               pr_debug("%s: sock is busy\n", __func__);
> +       if (sock_owned_by_user(sk) || sk !=3D READ_ONCE(asoc->base.sk)) {
> +               pr_debug("%s: sock is busy or moved\n", __func__);
>
>                 /* Try again later.  */
>                 sctp_transport_hold(transport);
> @@ -418,12 +417,12 @@ void sctp_generate_proto_unreach_event(struct timer=
_list *t)
>         struct sctp_transport *transport =3D
>                 timer_container_of(transport, t, proto_unreach_timer);
>         struct sctp_association *asoc =3D transport->asoc;
> -       struct sock *sk =3D asoc->base.sk;
> +       struct sock *sk =3D READ_ONCE(asoc->base.sk);
>         struct net *net =3D sock_net(sk);
>
>         bh_lock_sock(sk);
> -       if (sock_owned_by_user(sk)) {
> -               pr_debug("%s: sock is busy\n", __func__);
> +       if (sock_owned_by_user(sk) || sk !=3D READ_ONCE(asoc->base.sk)) {
> +               pr_debug("%s: sock is busy or moved\n", __func__);
>
>                 /* Try again later.  */
>                 sctp_transport_hold(transport);
> @@ -454,13 +453,13 @@ void sctp_generate_reconf_event(struct timer_list *=
t)
>         struct sctp_transport *transport =3D
>                 timer_container_of(transport, t, reconf_timer);
>         struct sctp_association *asoc =3D transport->asoc;
> -       struct sock *sk =3D asoc->base.sk;
> +       struct sock *sk =3D READ_ONCE(asoc->base.sk);
>         struct net *net =3D sock_net(sk);
>         int error =3D 0;
>
>         bh_lock_sock(sk);
> -       if (sock_owned_by_user(sk)) {
> -               pr_debug("%s: sock is busy\n", __func__);
> +       if (sock_owned_by_user(sk) || sk !=3D READ_ONCE(asoc->base.sk)) {
> +               pr_debug("%s: sock is busy or moved\n", __func__);
>
>                 /* Try again later.  */
>                 sctp_transport_hold(transport);
> @@ -492,13 +491,13 @@ void sctp_generate_probe_event(struct timer_list *t=
)
>         struct sctp_transport *transport =3D timer_container_of(transport=
, t,
>                                                               probe_timer=
);
>         struct sctp_association *asoc =3D transport->asoc;
> -       struct sock *sk =3D asoc->base.sk;
> +       struct sock *sk =3D READ_ONCE(asoc->base.sk);
>         struct net *net =3D sock_net(sk);
>         int error =3D 0;
>
>         bh_lock_sock(sk);
> -       if (sock_owned_by_user(sk)) {
> -               pr_debug("%s: sock is busy\n", __func__);
> +       if (sock_owned_by_user(sk) || sk !=3D READ_ONCE(asoc->base.sk)) {
> +               pr_debug("%s: sock is busy or moved\n", __func__);
>
>                 /* Try again later.  */
>                 sctp_transport_hold(transport);
> --
> 2.43.0
>
Please check the sashiko report:

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261110120212.1110283-=
2-pkfxxxing%40gmail.com

I think you also need to use READ_ONCE() in sctp_err_lookup() and pass sk
to sctp_v4_err_handle() and sctp_v6_err_handle(), and then add
sk !=3D READ_ONCE(asoc->base.sk) check next to sock_owned_by_user(sk) in th=
e
functions it calls like:
sctp_icmp_frag_needed()/sctp_icmp_proto_unreachable()/sctp_icmp_redirect().

Also, use READ_ONCE() in quic_rcv() and sctp_backlog_rcv().

Thanks.
