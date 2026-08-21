Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF114156DF
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 06:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787294144; cv=pass; b=VE2H5/KlFMEDDBpcCAUv+yhdZcgi8xCXK9u7DD7qc7QUCK9Uv3blbb0DbeTaJ+mJzrXbkSDBAN3+uGTqvoE3yxtCkQHFc7ROJ3BssxWrcrDIM/pTFr/2QjfulyhyM1+le73ibMxcxmmOPHlaL0HB7xYcU5tLuI8ccvC7JM3Tu9w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787294144; c=relaxed/simple;
	bh=ag1yFpe3Herrhw5HFjVmcTPH4/yyI4bVFWNis89tczE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jf+q/RnpWzhp82jo2w+0FdnJHlGtEm+Gex4QL8+CqOmP7sCdss6hngTzs4yN3gVGRW9VOKAeysvBIRGZpLR71G86FOyo5SR88FsyeN8AJ8hjd9Mu3RFUIuIeO9uul3L58AxJUE2Id+OhjfLRPfEd7zQkKFQZh1cCkMZhPL5hmUM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mRJuzJDZ; arc=pass smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mRJuzJDZ"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-81dfdbd86d1so10071177b3.1
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 23:35:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787294138; cv=none;
        d=google.com; s=arc-20260327;
        b=Fk84pqGIDd7VjL18/MFdDZ9yQgfFYW4iMkvxeC0ulG+vqJoRc+wTDVt19xFapEw068
         3aQcQLuLL68aiuFyrFbdSvxjvAEuaAySboBrdvZuu6/RpsDVhnq/tz2sa2MAEMNb3sDp
         1qUVtnprk3aAo9ZOQFS+/Gzo2oMRJbxNcffazkPeZvWLGTrAzVh651YEOK8L1oy8fkFH
         z9G7F7bYZjE8ICD98eMycqFerpeTFvd3sglduG9R7ltVv3l7zfCZFdln3Xf3uBVU1usf
         Anaq5X5ab/hqaqbYQ20Hgw3h0uktBj8nvROJ9YJJDSEr0mPituBMK1HSj4CU8n95naSh
         QuRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=v8w5n7BW+hAKEm33YG90unDP82OEl/cgKgYMKYKcCWY=;
        fh=MleuEGGG1ov478itHBMR/Kxn9xtVbRWYD1YYd7Y+6xo=;
        b=aS1YZuaCbnh7qbOZ+YNezJgzWpBh5pYrT45Zl2hhqzVIRJB1aC75o/boo3sFL0UkN+
         mc+6t9wYiAdatTs8L9fClXOP0J/iGnhXJeaZZgQXwrFloWG8kGx83+pbJXyBV/KXS2Pf
         05e3lHiEYKiNFgtr6dLuhoQUGtaRkQDY66eBQsRcyGm4JBxbB8qPgdaeyl6vpa+kzFov
         SQT3dnls4ODhUGLirylnDOEaMEJjTgJSpsv0fjrw36wyEL1rOwRGHWNSethdMAWyAubU
         1QH8M5VCnmuVJECvfZVC/IpkheWuWfTqC/YeDYBcM4cPIqTIh779Jyo3sy4ejxTPxXJ0
         RPKA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787294138; x=1787898938; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=v8w5n7BW+hAKEm33YG90unDP82OEl/cgKgYMKYKcCWY=;
        b=mRJuzJDZv5jr/NBqLamcAu2pT97MVm6E80+CgonE/hZvW8kc4QMAClr/hZEuR//+7w
         UMYnd6tQN6R2Qus/Z5EIsh/pcN/6gwOKEwwQm+QHLCVfEHp/XQVxuU60nI2EXnAT4Dlm
         cQ1iN4OvHcb033vb1OmHzYBzGfXXqIezq3x70HRW6XoZwHbWGsnfIsxvQIVZIGYoHM3J
         jm8Iu1jg2i42qm7ee7xSYIjmH+hMt0UlSK+WFPglCmY/VV0FAkR83ibi1yfNTYj+bAJB
         0J75xUHuy79UYoDjHWYXq0BvKHCr+Lqw86STUEnCZGws8mg5/ZdcVVf5dt3WQWMDx7Ba
         4lzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787294138; x=1787898938;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=v8w5n7BW+hAKEm33YG90unDP82OEl/cgKgYMKYKcCWY=;
        b=Wjl9sfAonOMmJqdbummBtDqpzTm+qfmaSxPUPIQ+GBAdHfDYlj/v9m8gB+QBE6CyCa
         QuKr7mwZNJMa6/7zfceufB0/ikZbFfgbTmj694OInYHgTVU/maFdLikJ5qY8D7Bu5rvT
         Dr1m/ClUhcn2+c8BGjG3mwtbdUUAxqSaQxDWPGJYFEH46iUerbbqZccMN+5is7b3pyg3
         cUTUrKVtfiKlUAMMaKgsY7BBid5uyqd//CIP2kxa2FH7h4ctBtq5RL1+OEuF+5e9XeXl
         s1ocxbM+RgFJ44JMHX59MSZMaj+apDpdq9cHoXgim3Cajx4p+rDhfkKTP36SMmbsBV98
         CNEw==
X-Forwarded-Encrypted: i=1; AHgh+RpDU0CMDiWb0P/QfE4u6XnMffEIhTvW6vliax9CCKDMeJbU077qM1arI596+ZzAJrg5bHHWXWY=@vger.kernel.org
X-Gm-Message-State: AFuF++ksvkw3y+nQGvJInk44PdBll1AmEzhy3TQaiVaBQrm3lO0hHkup
	umMPycPWMa/1LwqumRJyTYB1BH3hw54MvbUiXovuPE1M3FYiHSmX1/ZVqDKYcPIXw+4EM3OdU6w
	RypOOiU90QZ9NYqvqbZIH8yOQkHMwinCqounzwko7
X-Gm-Gg: AR+sD10WcUMSyzURJQOF3a9YNIJudUz43HqKAUudN08KjG8gmToJoF9gsg0hRdrIwPa
	a+IO4VhykLyzxfOS6MAimAC+I6KWKSI/V9CEeQpnDFdVLh/f/9VxCLgKvNAUzze20O8NErtRcBm
	dxB4hkeH7xP7cugsEPOKH118fGFcZHN4UEKy5WqGMinJe+40hSgiRvg2Jmq4DsRfnK89eMuEjuM
	eX0A+mWNh2i+AI33S/6ZWfNu0lC0fcyKfP5ewWXHeAcGZuModwrhiXDBjN6OeqIHzmgqeLwsavD
	9GhmzPoqdXwCB/3RGKFCkNKP8fkJ2Rr71HFnBTnx0vBBsCDm5HWIO7/nPqqRkuwI4Tkry+Ufhd9
	Aa5LlRF70+8FhX6nfg6POj/WrRh8IMSeg/qA5oKCsiwEAv0cngsiYwHFs8Q==
X-Received: by 2002:a05:690c:e188:10b0:821:2f24:5a42 with SMTP id
 00721157ae682-849f782f130mr11190087b3.25.1787294137373; Thu, 20 Aug 2026
 23:35:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813033855.3372172-1-dongchenchen2@huawei.com>
 <CANn89iLCrzmOfUVwa0yeROpkZxWmVsAkbH7=SBA3XuVxkmTfKA@mail.gmail.com>
 <53e86f6f-43b9-4e06-b185-1344f69cd650@huawei.com> <CANn89iJWTwiQJbjWz5jY6DE_TSA0EEMyJtQFbDSzMJfjV=MHQQ@mail.gmail.com>
 <9a80f88e-c8a6-44fb-a7b2-7cdbaa3bba24@huawei.com> <CANn89iKg5XhJQQQWaF0UMxs+Bwjthk=StBKVnKfh+VKBAywkpA@mail.gmail.com>
 <f8549a27-8052-4d74-a505-9c0b42c73687@huawei.com> <CANn89iKxgad2uPQqNCuf1iA7ntUM-twA_deZY=JB+uqABBqwVw@mail.gmail.com>
In-Reply-To: <CANn89iKxgad2uPQqNCuf1iA7ntUM-twA_deZY=JB+uqABBqwVw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 21 Aug 2026 08:35:26 +0200
X-Gm-Features: AcwNN1XnYe8C04UxhaW5X-ZBHMoZDfsKaAorJzRLb0M863MoS-Q3eJqjWcXi0nY
Message-ID: <CANn89iJQ3UNnfLaMtrb3W09=7AYxA0_4OtPEomN+jo3Wsk4Muw@mail.gmail.com>
Subject: Re: [PATCH net] net: iptunnel: fix stale transport header during
 tunnel decapsulation
To: "dongchenchen (A)" <dongchenchen2@huawei.com>
Cc: davem@davemloft.net, pabeni@redhat.com, kuba@kernel.org, horms@kernel.org, 
	herbert@gondor.apana.org.au, kuniyu@google.com, idosch@nvidia.com, 
	andrew+netdev@lunn.ch, ap420073@gmail.com, steffen.klassert@secunet.com, 
	laforge@gnumonks.org, jiayuan.chen@linux.dev, jhs@mojatatu.com, 
	zhangchangzhong@huawei.com, netdev@vger.kernel.org, 
	syzbot+83181a31faf9455499c5@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 21, 2026 at 8:23=E2=80=AFAM Eric Dumazet <edumazet@google.com> =
wrote:
>
> On Fri, Aug 21, 2026 at 4:21=E2=80=AFAM dongchenchen (A)
> <dongchenchen2@huawei.com> wrote:
> >
> >
> >
> > =E5=9C=A8 2026/8/21 0:32, Eric Dumazet =E5=86=99=E9=81=93:
> > > On Thu, Aug 20, 2026 at 12:04=E2=80=AFPM dongchenchen (A)
> > > <dongchenchen2@huawei.com> wrote:
> > >>
> > >>
> > >>
> > >> =E5=9C=A8 2026/8/20 17:16, Eric Dumazet =E5=86=99=E9=81=93:
> > >>> On Thu, Aug 20, 2026 at 10:58=E2=80=AFAM dongchenchen (A)
> > >>> <dongchenchen2@huawei.com> wrote:
> > >>>>
> > >>>>
> > >>>>> On Thu, Aug 13, 2026 at 5:30=E2=80=AFAM Dong Chenchen <dongchench=
en2@huawei.com> wrote:
> > >>>>>>
> > >>>>>> Syzbot reported a crash in qdisc_pkt_len_segs_init() caused by a=
 stale
> > >>>>>> transport_header offset after tunnel decapsulation.
> > >>>>>>
> > >>>>>> BUG: unable to handle page fault for address: ffffed102091a42e
> > >>>>>> Oops: Oops: 0000 [#1] SMP KASAN NOPTI
> > >>>>>> CPU: 0 UID: 0 PID: 340 Comm: qdisc_uaf_repro Not tainted 7.2.0-r=
c4-00061-g248951ddc14d #256 PREEMPT(full)
> > >>>>>> Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-=
debian-1.16.3-2 04/01/2014
> > >>>>>> RIP: 0010:__asan_load2
> > >>>>>> <IRQ>
> > >>>>>> qdisc_pkt_len_segs_init (net/core/dev.c:4145)
> > >>>>>> __dev_queue_xmit (net/core/dev.c:4787)
> > >>>>>> br_dev_queue_push_xmit (net/bridge/br_forward.c:53)
> > >>>>>> br_handle_frame_finish (net/bridge/br_input.c:229)
> > >>>>>> br_handle_frame (net/bridge/br_input.c:315)
> > >>>>>> __netif_receive_skb_core.constprop.0 (net/core/dev.c:6099)
> > >>>>>> __netif_receive_skb_list_core (net/core/dev.c:6287)
> > >>>>>> netif_receive_skb_list_internal (net/core/dev.c:6445)
> > >>>>>> napi_complete_done (net/core/dev.c:6813)
> > >>>>>> gro_cell_poll (net/core/gro_cells.c:74)
> > >>>>>> __napi_poll (net/core/dev.c:7735)
> > >>>>>> net_rx_action (net/core/dev.c:7798 net/core/dev.c:7955)
> > >>>>>> handle_softirqs (kernel/softirq.c:622)
> > >>>>>> do_softirq (kernel/softirq.c:523  kernel/softirq.c:510 )
> > >>>>>> __local_bh_enable_ip (kernel/softirq.c:450)
> > >>>>>> tun_get_user (drivers/net/tun.c:1986 (discriminator 1))
> > >>>>>> tun_chr_write_iter (drivers/net/tun.c:2032)
> > >>>>>>
> > >>>>>> The crash requires four conditions to line up:
> > >>>>>>
> > >>>>>> 1. The incoming packet is encapsulated and carries GSO metadata.=
  The outer
> > >>>>>>       transport header offset is stored in skb->transport_header=
 while the
> > >>>>>>       packet is still in the outer tunnel context.
> > >>>>>> 2. The tunnel receiver strips the outer headers.  skb->data is a=
dvanced to
> > >>>>>>       the inner frame, but skb->transport_header is left pointin=
g to the
> > >>>>>>       now-removed outer L4 header, so it becomes a negative offs=
et relative to
> > >>>>>>       the new data.
> > >>>>>> 3. The inner frame is not delivered to the local IP stack.  Inst=
ead, it
> > >>>>>>       is forwarded at L2 by a bridge or HSR, so ip_rcv_core() ne=
ver runs and
> > >>>>>>       the transport header is not reset to the inner L4 offset.
> > >>>>>> 4. The forwarding path calls __dev_queue_xmit(), which enters
> > >>>>>>       qdisc_pkt_len_segs_init().  That function computes the GSO=
 header length
> > >>>>>>       from skb_transport_offset(skb).  Because the offset is neg=
ative, the
> > >>>>>>       unsigned cast overflows and pskb_may_pull(skb, hdr_len +
> > >>>>>>       sizeof(struct tcphdr)) reads past the end of the skb, trig=
gering a
> > >>>>>>       KASAN fault or page fault.
> > >>>>>>
> > >>>>>> Fix this by clearing skb->transport_header to the ~0U sentinel a=
t the
> > >>>>>> tunnel decapsulation boundary, after each tunnel receive functio=
n has
> > >>>>>> finished all processing that needs the outer L4 header and befor=
e the skb
> > >>>>>> is handed to GRO or the stack. The IP/GRO receive paths then set=
 the
> > >>>>>> transport header correctly when they parse the inner packet.
> > >>>>>>
> > >>>>>> Fixes: 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_in=
it()")
> > >>>>>
> > >>>>> This Fixes: tag seems pretty random to me. Issue was present long
> > >>>>> before that commit.
> > >>>>> Next time, please be precise with the `Fixes:` tag; it's not deco=
ration.
> > >>>>>
> > >>>> Thanks for your review. Sorry for the late reply.
> > >>>> The stale transport header has been present since 1da177e4c3f4
> > >>>> ("Linux-2.6.12-rc2"), which is completely latent until
> > >>>> 7fb4c1967011 ("net: pull headers in qdisc_pkt_len_segs_init()"
> > >>>> was merged.
> > >>>>
> > >>>>    From the perspective of the root cause introduced by the issue,
> > >>>> we can use 1da177e4c3f4 ("Linux-2.6.12-rc2") as fixtag.
> > >>>>
> > >>>>> Also, calling skb_unset_transport_header(skb) directly from
> > >>>>> gro_cells_receive() would make more sense and
> > >>>>> your patch would be less intrusive.
> > >>>>>
> > >>>>
> > >>>> gtp=EF=BC=8Csit use netif_rx to receive pkt. so modifying only gro=
_cells_receive
> > >>>> cannot solve all the problems. netif_rx is widely
> > >>>> used and is not only invoked by the tunnel driver, and serval path
> > >>>> (such as genve encap) will reset transport header before netif_rx.
> > >>>> Therefore, should we retain unset in the GTP/SIT tunnel?
> > >>>
> > >>> Hi Dong,
> > >>>
> > >>> 1) Regarding SIT:
> > >>>
> > >>> SIT decapsulates IPv6 over IPv4 (IPPROTO_IPV6). There is no outer L=
4 transport
> > >>> header (no UDP/TCP), so skb->transport_header is not pointing to an
> > >>> outer L4 header.
> > >>>
> > >>> 2) Regarding GTP:
> > >>>
> > >>> GTP is an L3-only point-to-point device (ARPHRD_NONE). It cannot be
> > >>> enslaved by a bridge
> > >>> or forwarded at L2; its packets always go through ip_rcv()/ip6_rcv(=
)
> > >>> where the headers
> > >>> are properly parsed/reset,
> > >>>
> > >> Hi, Eric. Thanks for the review!
> > >>
> > >> I missed the rcv path in the commit message.
> > >> With an ingress qdisc attached to gtp, the stale transport header
> > >> will been consumed in sch_handle_ingress() and its not covered by
> > >> gro_cells_receive() either. So maybe gtp is not safe by
> > >> construction.
> > >>
> > >> gtp_encap_rcv
> > >>     gtp_rx //stale transport header
> > >>       __netif_rx
> > >>         __netif_receive_skb_core
> > >>           sch_handle_ingress
> > >>             qdisc_pkt_len_segs_init
> > >>
> > >
> > > Let's step back a bit :)
> > >
> > > For non-GSO packets, qdisc_pkt_len_segs_init() returns immediately:
> > >
> > > qdisc_skb_cb(skb)->pkt_len =3D skb->len;
> > > if (!shinfo->gso_size) {
> > >      qdisc_skb_cb(skb)->pkt_segs =3D 1;
> > >      return SKB_NOT_DROPPED_YET;
> > > }
> > >
> > > It does not inspect skb->transport_header at all. It will be set
> > > eventually later if needed,
> > >
> > > GTP does not implement GRO on RX and does not use gro_cells, so incom=
ing
> > > packets in gtp_rx() have gso_size =3D=3D 0.
> > >
> >
> > Hi, Eric. Thanks for your patient explanation.
> >
> > Normal GTP traffic indeed cannot trigger this issue and pkt without
> > SKB_GSO_UDP_TUNNEL will be caught by udp_unexpected_gso.
> > The only way to reproduce this for gtp is by constructing and injecting
> > packets, such as TAP device injects a GSO UDP-tunnel packet (with
> > GSO_TCPV4 and GSO_UDP_TUNNEL flag, Ethernet/IPv4/UDP/GTP-U/IPV4/TCP).
> > Should we add interception for such illegal pkts?
> >
> > diff --git a/net/core/dev.c b/net/core/dev.c
> > index af260ff5462a..8620428b950f 100644
> > --- a/net/core/dev.c
> > +++ b/net/core/dev.c
> > @@ -4138,6 +4138,10 @@ static enum skb_drop_reason
> > qdisc_pkt_len_segs_init(struct sk_buff *skb)
> >          if (likely(shinfo->gso_type & (SKB_GSO_TCPV4 | SKB_GSO_TCPV6))=
) {
> >                  const struct tcphdr *th;
> >
> > +               /* Defensive: stale offsets from buggy tunnel decap can
> > underflow. */
> > +               if (unlikely(hdr_len > INT_MAX))
> > +                       return 0;
> > +
> >                  if (!pskb_may_pull(skb, hdr_len + sizeof(struct tcphdr=
)))
> >                          return SKB_DROP_REASON_SKB_BAD_GSO;
>
> Certainly not. Do not add defensive code in the fast path for GTP that
> nobody uses.
>
> Add everything you think of in GTP itself, I do not care.
>
>  I suggest you look at skb_gso_reset(), this might be missing in GTP.

Or simply drop GSO packets in GTP they must be evil: we do not support
GSO in GTP and never will.
