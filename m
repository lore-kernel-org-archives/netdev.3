Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111614;
	b=rYoDdjM7sCURgjdVrkmQ7lhIm2aVOmOTt0HlEEXB+ZrXxZTHTuuboY4r6h0a1IaaRABT
	 nvkVN2fCSngZppqBbW8LzYLoEXlWQsnNw6vF3RLJTYNgdTO0+8JbeQ6R2Gn4rNtxmZpxl
	 4YNyd/N2RXZ/0Oug4IBTW55b/ekNqaFNP+LicI/Kny+91wq6AGy62VS28rl++4fcX7SCz
	 i6LeZK+QFGOigRgNRpoWwe5QH9WhD5zF9L/2O6OPmLvMq0UUHZXxh9oF+HAJTtSBLd5uy
	 ImmqYsRxbkth63uFEqyzz6ObVMqKU7Zn5HzDowRK+czhTLRiDA5eRk7ZbByDVlRZQMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111614;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=vBbdWP82ARlOWqQaSWH2/vKIyep405DabpbPtzEAJh0=;
	b=PdrHhLpas6LuZdTlBtU8I4c5wmCBbMmOvlnGZlXdo71L8IT7pEsP+RaM1yx8526/0ddR
	 XFu0yRjWN/lkGA6qV8dQchAQaxL8kod8rIcjZ3MH1f1vjmHnZG15fjCOhn2D8sPG96yPD
	 JfylLq00Tf5dzjVhiQAStpGr4ON8+i7vWw1EXCEKVIwxOFNU3iNX9b+cI/3iZqiB6CyXq
	 5RjEu/dB76abfAiuy7H2Y7dr09SpxYm7Uc7XJUL9uG6MiTWeSiwCqIQj+yCcVA4tex99y
	 QAuBXVN0Q+9xeAFOlDl4fJy4L9XIzZecSGOcIm2HocQiENwzkzoLCS5/Pbm4YG2LlRA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SgXakux5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133CC606A31B
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 14:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SgXakux5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7EC81F031E3
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 14:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793111613;
	bh=vBbdWP82ARlOWqQaSWH2/vKIyep405DabpbPtzEAJh0=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SgXakux5sYDugsC71HmJ+VRp87nw7q/DGDbXPQS5084lyiyFZueteGNnEZJYXXn9J
	 MrltqkdH86kvCqUgkGLAuLJg+Xh68Q6pzvO0palJArj/AgkolZQ1Zv/FW5aUwKR0Hx
	 wP+aOuk/mdD2qPTdOKeS/tCEANyysIG5v6K6Yj1NUyD4yyA1dY9PpFNe6t9BcWcE0h
	 LTSjCl0cbqXqFLaBOnrt2YKHM/68aCtUF7L3miKmUyoK366J07OHD5yck2hzmKadcz
	 nw97UjwILQSk9KIPf5q/olvITSm4JHwlGNlhGA6GH38l65b7mnbteYoQD71MbX6SmI
	 9madSDnzRf1/w==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-3ac99992373so2279341fa.3
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 07:33:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzO1/DyslL9Ex7nezcY4A5hqErvx6ZrDzSzg0kAvL8LpgK127iciNOjQ3Jxiiv39IB9vddpUN8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKypWVrq7Er7vkVXj9g+r7+TqMXdBuKK2dRDFm730XspHw9u+xv
	H1TPyx352NEMrXG8+hKHE85IbuUIX4N26FUSEJxopAs4DdZN8+DByVNrD7MbWnXAPpBl02d2Kmy
	Wnkq09JTq/XZFeYXnqOJcLqBlE3NbNJo=
X-Received: by 2002:a05:651c:98f:b0:3ac:471e:649f with SMTP id
 38308e7fff4ca-3ac6fd8bee0mr27382841fa.28.1793111612458; Tue, 27 Oct 2026
 07:33:32 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027082604.1485903-1-edumazet@kernel.org> <CAM0EoMmmnNttUE3FWWg5Y52gCFz-JqxBUXAZEVoxzmvziyV3UA@mail.gmail.com>
 <CAL4WiipM12m6mi07bebyCGsA8D-r6YRL1_q6+ZFF2Vx0jv7NiQ@mail.gmail.com> <CAM0EoMkkVK5V9dVRdr-iOSU_pmXEjf9m3Og71MEFzWZFnOGV1Q@mail.gmail.com>
In-Reply-To: <CAM0EoMkkVK5V9dVRdr-iOSU_pmXEjf9m3Og71MEFzWZFnOGV1Q@mail.gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 27 Oct 2026 15:33:19 +0100
X-Gmail-Original-Message-ID: <CAL4WiioJJkywnOeBrieRL9yQdoSObUudwrjeHEWdLML4p4E55A@mail.gmail.com>
X-Gm-Features: AclHuK-hBRt6-As4sIXPnVigySVUuD6RjvRAms5Cua38kRYhpZWnriGzKWQ3XwY
Message-ID: <CAL4WiioJJkywnOeBrieRL9yQdoSObUudwrjeHEWdLML4p4E55A@mail.gmail.com>
Subject: Re: [PATCH net 0/5] net: fix eth_type_trans() crashes on skbs coming
 from the stack
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>, 
	Ilya Maximets <i.maximets@ovn.org>, Jiri Pirko <jiri@resnulli.us>, dev@openvswitch.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Ren Wei <weir@nebusec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 27 oct. 2026 =C3=A0 14:07, Jamal Hadi Salim <jhs@mojatatu.com> a =
=C3=A9crit :
>
> On Tue, Oct 27, 2026 at 5:52=E2=80=AFAM Eric Dumazet <edumazet@kernel.org=
> wrote:
> >
> > Le mar. 27 oct. 2026 =C3=A0 10:17, Jamal Hadi Salim <jhs@mojatatu.com> =
a =C3=A9crit :
> > >
> > > On Tue, Oct 27, 2026 at 4:26=E2=80=AFAM Eric Dumazet <edumazet@kernel=
.org> wrote:
> > > >
> > > > eth_type_trans() assumes ETH_HLEN bytes are present in skb->head.
> > > > NIC drivers always provide this, and they should keep using the fas=
t
> > > > version, without an extra pskb_may_pull().
> > > >
> > > > Devices looping skbs from their transmit path back to their receive
> > > > path get skbs built by the stack instead. tc actions (act_vlan pop_=
eth,
> > > > act_ife decode), BPF helpers (bpf_skb_change_head() before a redire=
ct)
> > > > or OVS actions (pop_eth followed by pop_mpls/pop_nsh) can leave few=
er
> > > > than ETH_HLEN bytes in the linear part, and eth_type_trans() then h=
its
> > > > the BUG() in __skb_pull().
> > > >
> > > > Instead of fixing every producer, or adding a check to all
> > > > eth_type_trans() users, fix the few consumers exposed to this:
> > > >
> > > > - Patch 1 adds eth_type_trans_careful(), which pulls the Ethernet
> > > >   header first and returns a drop reason on failure.
> > > > - Patch 2 uses it in loopback_xmit().
> > > > - Patch 3 uses it in __dev_forward_skb2(), used by BPF redirects to
> > > >   ingress and by veth, macvlan, ipvlan, netdevsim and l2tp_eth.
> > > > - Patch 4 uses it in OVS internal_dev_recv(), covering both the MPL=
S
> > > >   (TEB) and NSH pop cases at once (only the MPLS case was tested).
> > > > - Patch 5 (from Jamal) fixes act_ife decode on egress, which was
> > > >   consuming the inner Ethernet header. This is no longer a crash af=
ter
> > > >   patch 2, but egress decode never delivered a correct frame.
> > > >
> > > > Other eth_type_trans() users already pull the header or never see
> > > > such skbs:
> > > > - vrf_process_v{4,6}_outbound() already pull ETH_HLEN + IP header
> > > >   before vrf_local_xmit().
> > > > - tun already uses pskb_may_pull_reason(skb, ETH_HLEN).
> > > > - XDP: bpf_xdp_adjust_head() and bpf_xdp_adjust_tail() keep at leas=
t
> > > >   ETH_HLEN bytes in the linear part, and multi-buffer tail shrinkin=
g
> > > >   only trims frags.
> > > >
> > > > Tested under virtme-ng with AF_PACKET reproducers. Without the seri=
es,
> > > > all four cases crash in eth_type_trans():
> > > > - lo egress "action vlan pop_eth", eth/eth/8192 bytes frame
> > > > - lo egress "action ife decode pipe", IFE frame with 8192 bytes pay=
load
> > > > - lo egress "action vlan pop_eth continue", then a BPF program doin=
g
> > > >   bpf_skb_change_head(skb, 1, 0) + bpf_redirect(veth1, BPF_F_INGRES=
S)
> > > > - OVS flow "pop_eth,pop_mpls(0x6558),0" to the internal port,
> > > >   eth/mpls/eth/4096 bytes frame
> > > > With the series, no crash. An ICMP echo inside an IFE frame decoded
> > > > on lo egress is now received and answered. Normal traffic on lo,
> > > > veth (including 8000 byte pings) and vrf is unchanged.
> > > >
> > > > Link: https://lore.kernel.org/netdev/20261005052249.1914367-2-weir@=
nebusec.ai/
> > > > Link: https://lore.kernel.org/netdev/ACT-N6N4.v3.r0.20261023200137-=
4@mojatatu.com/
> > > >
> > >
> > > Looks interesting ;-> I dont think you are covering xdp/bpf holes but
> > > we can worry about that later.
> > > I will spend time later this morning looking closely and actually
> > > running it. Will keep you posted.
> >
> > Thanks Jamal.
> >
> > I went through the holes you listed earlier:
> >
> > 1) bpf_skb_adjust_room() + bpf_redirect():
> >    An egress redirect ends in the target ndo_start_xmit():
> >    loopback (patch 2), veth (already pulls ETH_HLEN), OVS internal
> >    port (patch 4). An ingress redirect goes through
> >    __dev_forward_skb2() (patch 3). The repro in patch 3 uses
> >    bpf_skb_change_head(), the only helper I found that leaves
> >    1 <=3D mac_len < ETH_HLEN with an almost empty head, passing the
> >    mac_header < network_header check in __bpf_redirect_common().
> >
> > 2) bpf_clone_redirect(): same __bpf_redirect() path as 1).
> >
> > 3) ingress: after tc ingress, eth_type_trans() is only called again
> >    if the packet is redirected, see 1).
> >
> > 4) XDP: bpf_xdp_adjust_head() and bpf_xdp_adjust_tail() refuse to
> >    leave less than ETH_HLEN bytes in the linear part, and multi-buffer
> >    tail shrinking only trims frags. skbs built from xdp buffers
> >    (XDP_PASS, veth XDP, generic XDP) have a full Ethernet header in
> >    skb->head.
> >
> > Let's use something that can be plugged / unplugged easily in the futur=
e.
>
> I reviewed and tested all existing issue, they are fixed - kudos ;->
> But, but.... you missed one;-> see attached patch.

Yes, I mostly focused on eth_type_trans().

>
> Additional questions:
> 1) Would be interesting to see what performance degradation happened here=
.

NIC drivers still use the plain eth_type_trans().
Only loopback, __dev_forward_skb2() and OVS internal ports pay for one
inline skb_headlen() comparison.

> 2) I think it is reasonable i send my original patches 1-3 to net-next
> when it opens as "hardening" patches

  Yes.

> 3) Is it correct to put multiple Fixes: in net patches (you have i
> think 4 in one of them)? Sashiko complained once that a patch I sent
> made stable backporting hard. Either you pick one or split into
> multiple patches. I realize picking a "good" fix tag is very hard in
> this case.

Yes,  both are real origins. Stable can use the oldest. That's common pract=
ice.

>
> cheers,
> jamal
