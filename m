Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793094724;
	b=qH949T0fgqK+jMV0jy8mY6Oc7Ty+2VJJ8Jhb3de7mtNFDDJPjyVfSe8BU3gipzlRSj1H
	 ZhTpdbJWwUzr7CYfKa20VnsrPXNclpO8Ec2KiV/AmLzuR/S2yq3nf7jvI4x+OyqiLa0ei
	 T9wJDtVM5zn0SfxlcBZLqBxxkAZxE7BQh/j+yVQ/rH69XV98ymlPsrThoh6pUdO6Mnjp4
	 QZEox9Ux9+VvougIM5MGpA1wZlVysjI6JnywD8E7qk1cYvpBaiaw3Cy7PiOG+e713XVBJ
	 QwyPk2tmYULiswvh+vH3XyWq6/7dE/YUL5oR4Hh4+t3VmkDVKpZsnR401SO/4I4DCmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793094724;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=xFZpBT9DIZMXvsufjosDdH8L1MfFB127Xo+xO5yp6sI=;
	b=KfqAHNdDbfhezZt9jKJozRCJAsIygrBRoMgRK5b4QmKbgN73QiTApjz9aqRTpbebCelD
	 8JMl9pBT6P+4RRUAvcDVg2HCO/lN8cojzysbf3010Tgc5/WmA53w/LMbgwhdcxB7XD8xz
	 SW7qU9M6RRHyM6GVTj/SuQTYLU7P4p6EpIrvotoHyG7+pa4Gn61+EWj1aunOKEwToPU4o
	 xaHw5+/DHXGF2IQPJv3ResQZfsGqqvln7llswCHcue3ukkoWfnQ3hTtxXh1wzJt000oe1
	 fOlKbr8iHfHTSmvdr2Q7dR9Z4hYCweP075ZZ1ormNXyb4wD12cFi5zq0WZMi+GRTriQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IwNWJad3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD37606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 09:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IwNWJad3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CEF01F031E6
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 09:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793094723;
	bh=xFZpBT9DIZMXvsufjosDdH8L1MfFB127Xo+xO5yp6sI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=IwNWJad3lGZJ7XLKxoUDrlw7nXobz+RfcdTNMegUgFUKlzcJJyZ1sqhX+HGDug80i
	 yRbJq6MX/8tcuQi2U9RfcYWqFIYonm7ZopjyWPTJuzONb0+vIFjmDwcUwXRxYNtDYj
	 BOEBMuQ1HP9pM/PzxulMgxi0sCmkWKMgRB2VAwYdeA+/EjnuvfAIag1YXFPf42VIXa
	 onze8lQAHx4t/1UKigdbaYCO7h8KPXnTHWAUqJ69R9xtsclm10AsylDKZl3t4tGLjr
	 MHXCGbWP/UCpJJ56U7+LvX1v8If2X9a09TMW/Hz+eY7qWD3X6M+n3xv7YOoPgLmtrd
	 Bxpoo+l6JlulA==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3ac97e45a79so856911fa.3
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 02:52:03 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBxT+hmzNftvyxrDEhH/Y9u2avjr85ZiHmUPdJQEWpKvESXielODoXAqyGkQkP2wRtK5gMjM+hQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKPLBoiu3gWv69rqPy2w5PEaJySjmzYugG4/a6m+LTFY8OYQb1H
	wOKfTCzWfo1XzGTy8Il7yw0e47t+8tb5ONvhnkc/t+4+3vEeSC8y0mpHFZ1cJSlZ4RhGCQ9Ojqa
	yri+mPuQdKKMLeMY1lD5nfhZa10W/RVs=
X-Received: by 2002:a05:651c:31cc:b0:3ab:41c8:fc15 with SMTP id
 38308e7fff4ca-3ac6fcd31a1mr22698281fa.12.1793094721972; Tue, 27 Oct 2026
 02:52:01 -0700 (PDT)
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
In-Reply-To: <CAM0EoMmmnNttUE3FWWg5Y52gCFz-JqxBUXAZEVoxzmvziyV3UA@mail.gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 27 Oct 2026 10:51:49 +0100
X-Gmail-Original-Message-ID: <CAL4WiipM12m6mi07bebyCGsA8D-r6YRL1_q6+ZFF2Vx0jv7NiQ@mail.gmail.com>
X-Gm-Features: AclHuK9h9fsS6gulKZAoX4gALERfJWj53NLBjfnU7cnHUbA-FTtuWeR86U-O5j8
Message-ID: <CAL4WiipM12m6mi07bebyCGsA8D-r6YRL1_q6+ZFF2Vx0jv7NiQ@mail.gmail.com>
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

Le mar. 27 oct. 2026 =C3=A0 10:17, Jamal Hadi Salim <jhs@mojatatu.com> a =
=C3=A9crit :
>
> On Tue, Oct 27, 2026 at 4:26=E2=80=AFAM Eric Dumazet <edumazet@kernel.org=
> wrote:
> >
> > eth_type_trans() assumes ETH_HLEN bytes are present in skb->head.
> > NIC drivers always provide this, and they should keep using the fast
> > version, without an extra pskb_may_pull().
> >
> > Devices looping skbs from their transmit path back to their receive
> > path get skbs built by the stack instead. tc actions (act_vlan pop_eth,
> > act_ife decode), BPF helpers (bpf_skb_change_head() before a redirect)
> > or OVS actions (pop_eth followed by pop_mpls/pop_nsh) can leave fewer
> > than ETH_HLEN bytes in the linear part, and eth_type_trans() then hits
> > the BUG() in __skb_pull().
> >
> > Instead of fixing every producer, or adding a check to all
> > eth_type_trans() users, fix the few consumers exposed to this:
> >
> > - Patch 1 adds eth_type_trans_careful(), which pulls the Ethernet
> >   header first and returns a drop reason on failure.
> > - Patch 2 uses it in loopback_xmit().
> > - Patch 3 uses it in __dev_forward_skb2(), used by BPF redirects to
> >   ingress and by veth, macvlan, ipvlan, netdevsim and l2tp_eth.
> > - Patch 4 uses it in OVS internal_dev_recv(), covering both the MPLS
> >   (TEB) and NSH pop cases at once (only the MPLS case was tested).
> > - Patch 5 (from Jamal) fixes act_ife decode on egress, which was
> >   consuming the inner Ethernet header. This is no longer a crash after
> >   patch 2, but egress decode never delivered a correct frame.
> >
> > Other eth_type_trans() users already pull the header or never see
> > such skbs:
> > - vrf_process_v{4,6}_outbound() already pull ETH_HLEN + IP header
> >   before vrf_local_xmit().
> > - tun already uses pskb_may_pull_reason(skb, ETH_HLEN).
> > - XDP: bpf_xdp_adjust_head() and bpf_xdp_adjust_tail() keep at least
> >   ETH_HLEN bytes in the linear part, and multi-buffer tail shrinking
> >   only trims frags.
> >
> > Tested under virtme-ng with AF_PACKET reproducers. Without the series,
> > all four cases crash in eth_type_trans():
> > - lo egress "action vlan pop_eth", eth/eth/8192 bytes frame
> > - lo egress "action ife decode pipe", IFE frame with 8192 bytes payload
> > - lo egress "action vlan pop_eth continue", then a BPF program doing
> >   bpf_skb_change_head(skb, 1, 0) + bpf_redirect(veth1, BPF_F_INGRESS)
> > - OVS flow "pop_eth,pop_mpls(0x6558),0" to the internal port,
> >   eth/mpls/eth/4096 bytes frame
> > With the series, no crash. An ICMP echo inside an IFE frame decoded
> > on lo egress is now received and answered. Normal traffic on lo,
> > veth (including 8000 byte pings) and vrf is unchanged.
> >
> > Link: https://lore.kernel.org/netdev/20261005052249.1914367-2-weir@nebu=
sec.ai/
> > Link: https://lore.kernel.org/netdev/ACT-N6N4.v3.r0.20261023200137-4@mo=
jatatu.com/
> >
>
> Looks interesting ;-> I dont think you are covering xdp/bpf holes but
> we can worry about that later.
> I will spend time later this morning looking closely and actually
> running it. Will keep you posted.

Thanks Jamal.

I went through the holes you listed earlier:

1) bpf_skb_adjust_room() + bpf_redirect():
   An egress redirect ends in the target ndo_start_xmit():
   loopback (patch 2), veth (already pulls ETH_HLEN), OVS internal
   port (patch 4). An ingress redirect goes through
   __dev_forward_skb2() (patch 3). The repro in patch 3 uses
   bpf_skb_change_head(), the only helper I found that leaves
   1 <=3D mac_len < ETH_HLEN with an almost empty head, passing the
   mac_header < network_header check in __bpf_redirect_common().

2) bpf_clone_redirect(): same __bpf_redirect() path as 1).

3) ingress: after tc ingress, eth_type_trans() is only called again
   if the packet is redirected, see 1).

4) XDP: bpf_xdp_adjust_head() and bpf_xdp_adjust_tail() refuse to
   leave less than ETH_HLEN bytes in the linear part, and multi-buffer
   tail shrinking only trims frags. skbs built from xdp buffers
   (XDP_PASS, veth XDP, generic XDP) have a full Ethernet header in
   skb->head.

Let's use something that can be plugged / unplugged easily in the future.
