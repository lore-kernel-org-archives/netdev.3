Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793116207;
	b=LbXcHf22NT6t5vv6k1GM0qtskowLPDLwTk/3KjHXwUXgY3cVhtWSdJZfzWr60jzUotSI
	 cwTF/YGAUSEDlNX+S0nRNna8HIlSczV3XnHRO1e+8txNL7m+fUxUZFZDZXSimZm2AiFps
	 8hv5JxJ4wFqSbPRfnitq+8+G4F8kj239rC0vHoMU+pSKNi7SdU2/aifSm2FEug2qlZLyM
	 LQjnkC93Rp7kaSrEewiGEywf9wFuxC0AYA+ZBbmxQjKblrjmHQW04C888Fqv9uRPqUWx6
	 ZJGrXXJHKaV8qAoMLpkDihPT3K4DN+IXvBQgKBE/+KD4aSj57bE/M8UTated6dTuUbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793116207;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=XNXBTh+mWm8JV4gRA4uvH2PMx1FLXqKxxU1LaaqRpiE=;
	b=trse6Q+sa75qAGGiyOGseracKE+Wps7SwvciZOiHjshzBmxwrLpUCiuTZik6pgKxQI7y
	 MrvpRp9f7R+Ndx1e4E9YwkTEvf7fcU2BaMIpM0svjb1am7awuGA5SlAOkALK41PDXVWVY
	 jfJjxIuMrj9QjxpNEZBwmryOLodmfGuvz6M2lTrXEFrbdCDyuPtrtEJpWnWWhbZrzrguF
	 QWzMMDGUf8XVxN+YDTWEQJTXKCBxezv5RNj53BcrFZZH0F2Hovq729mJ9JQUqrJ/j2/rl
	 FyRVcVoR1jpeaXGMNWJJZtRMyS1PFjalvOB/ev1crqrIPqVsVlt7owAlbdaZgx6ZBZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lRfYNCiv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2469606A31B
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 15:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lRfYNCiv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CE9E1F031EC
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 15:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793116206;
	bh=XNXBTh+mWm8JV4gRA4uvH2PMx1FLXqKxxU1LaaqRpiE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=lRfYNCiv/1q4zJo933sBpe7vhO8+KJhsMIuSqrn2ji5VEijLlemnWa23xE3wG0P9S
	 sMMe9SwsRoDnIyLG3gNNBiP9OUVkjawrFTYsKVrFl4te07EPQwNRsQcsiQUDphuazp
	 8y4pCCcgktY6gHKTjWZeDhJhQP4NsRUMlAkBSfmVKZfGS8egTIU3I10KXamS02DlEN
	 Er7LHpW1v6kYwoM5nlMM4pk6GqNR/okqpB11NP6+to1WrUjcr+6Uxq6oC43zHJ4dFn
	 yPYqG6Ep2lJiPezM/1G/JyZNWPJs1Jd5ROZ+r3VgGguVoLPf2kbBooFw3Hbw4nClo/
	 gdLhiAVYW7jZg==
Received: by mail-oo1-f43.google.com with SMTP id 006d021491bc7-6df7f544919so61431eaf.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 08:50:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzuKuJxGNIBKsBiU/lTXr+jKsduMQ2ZZls9MpOGw1Vqv+IyJm9nqJlwCgvwurQeq+zNmwqfeuc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJfJAeX0BojPqFqqq6BRZqAXbW41LD3DEm4y3J2KLRQLCiZL0YK
	shOa2znEc1rC5YzQDq/2DgdiaGq29ah1AOFsqieQu5/BaXTtOZEhjdn56dqfkQqOOTcTxkxqqfp
	ezsXQja80jYMbz9gWr1lTpu3UNo0ehQU=
X-Received: by 2002:a05:6820:5708:10b0:6d7:c5f2:9c0b with SMTP id
 006d021491bc7-70ba0f6bc3bmr3989116eaf.68.1793116205605; Tue, 27 Oct 2026
 08:50:05 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027082604.1485903-1-edumazet@kernel.org> <willemdebruijn.kernel.22807e0fe104d@gmail.com>
In-Reply-To: <willemdebruijn.kernel.22807e0fe104d@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 27 Oct 2026 16:49:53 +0100
X-Gmail-Original-Message-ID: <CAL4WiirUmA1GnUaZq5MQgENZRo1248YSo6AOYb_OseWS8p-Cbw@mail.gmail.com>
X-Gm-Features: AclHuK8O6qL0p46BbYPuOf5E_RfJ0wDanl3GUypcn7qSXPE0kwPay5TqkJOsS8I
Message-ID: <CAL4WiirUmA1GnUaZq5MQgENZRo1248YSo6AOYb_OseWS8p-Cbw@mail.gmail.com>
Subject: Re: [PATCH net 0/5] net: fix eth_type_trans() crashes on skbs coming
 from the stack
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>, 
	Ilya Maximets <i.maximets@ovn.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	dev@openvswitch.org, Ren Wei <weir@nebusec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 27 oct. 2026 =C3=A0 15:40, Willem de Bruijn
<willemdebruijn.kernel@gmail.com> a =C3=A9crit :
>
> Eric Dumazet wrote:
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
>
> Definitely a nice approach.

Thanks!

>
> You previously suggested catching most of the TC modifications with a
> single check in sch_handle_(e|in)gress. Is that no longer needed?

Not for these crashes. The sch_handle_egress() check would only cover
tc egress. It would miss OVS and the redirect paths you mention, and it
would add a check for every packet going through clsact. Fixing the
consumers covers all producers, including future ones, at almost no
cost. NIC drivers are not affected.

We can still add it later as hardening, if another class of bugs shows up.


>
> The few mirred/redirect cases are a bane, causing so many issues. And
> escape any such check, as they call netif_receive_skb, netif_rx,
> dev_queue_xmit, directly.
>
> If it's only act_mirred, bpf_redirect and OVS, maybe a single
> validation helper across all three before they pass to the rx/tx
> path, that for starters calls eth_type_trans_careful. It quite likely
> won't be the last packet corruption they are capable of..

I agree these are the problems, and Jamal just found another one in
__bpf_redirect_neigh(), which does its own skb_pull(ETH_HLEN).

A single helper is tempting, but what it must check depends on the
target:
- Egress to an Ethernet device: ETH_HLEN at skb_mac_header().
- Egress to an L3 device (tun, ipip, wireguard...): no MAC header at all.
- Ingress: data at the network header. eth_type_trans() is not
  called again, except through __dev_forward_skb2() (patch 3).

Also, the original loopback crash needs no redirect at all:
"vlan pop_eth" on lo egress is enough.

So I would keep this series as the minimal fix for net/stable, and
look at a common helper for net-next, probably based on
dev->min_header_len / dev->hard_header_len of the target device,
called from tcf_mirred_forward(), skb_do_redirect() and OVS do_output().

Thanks!

>
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
> > Eric Dumazet (4):
> >   net: add eth_type_trans_careful()
> >   loopback: use eth_type_trans_careful()
> >   net: use eth_type_trans_careful() in __dev_forward_skb2()
> >   openvswitch: use eth_type_trans_careful() in internal_dev_recv()
> >
> > Jamal Hadi Salim (1):
> >   net/sched: act_ife: do not consume the inner header on egress
> >
> >  drivers/net/loopback.c               |  8 +++++++-
> >  include/linux/etherdevice.h          | 28 ++++++++++++++++++++++++++++
> >  net/core/dev.c                       | 18 +++++++++++++-----
> >  net/openvswitch/vport-internal_dev.c |  8 +++++++-
> >  net/sched/act_ife.c                  |  4 ++++
> >  5 files changed, 59 insertions(+), 7 deletions(-)
> >
> > --
> > 2.53.0
> >
>
>
