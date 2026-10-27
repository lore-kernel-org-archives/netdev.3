Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793130498;
	b=s66XvTZuPfyU3K5UaTqu7YqF9juxLenllAPg27oj5olAWB/ZbZBq2dp4eWJKD6YIl721
	 5gyUn0LyIOMYE7dju0l6InM2bNNdF6WIazPKB5tDX+XoVwS7PoX4ygXVE5p2dCpcGvIE3
	 ZL6bMJjXpzFjHurC7nEJU2/lMvqLy2oElV119QNnUuOrprheppjAblnvhRmCSLXWZd+UX
	 LKQVvy2Erh9LxuwmSxN9RaB15YS4YGYYNfSNR7CBaC30e+8FeJjHREXJ5zj0x1d03EWtx
	 DfKJYz1+7Ucr0WQw2aKbKaSJPKphuOVQ9ZQUnByfTWEX1a4QSUbEkvzMyFfxDexcMkA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793130498;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=02Ht3mxXBA7UdIIlaZIzhVPlgGBGHpRmxcIbzrCl1Q4=;
	b=piz+67ygikBfB2cchbNh9PKHD5/q8ejHBUd5KIhcPNhVKp9n6cbcrt/PYQfS60GiWlQ+
	 kfLA9e1O3tU10INNjbs+bY1/hC12RA8Bt4nYFvVbz4ENfRPL7grbzGvrtVK7SmPVxwVbp
	 E1KRUFrbKcUANDZ6ZblDCKPdpIePBhBe+CerCyE0j+t2LM4+t6+DWAY6BIEztsRzruGWA
	 yrYxXtz+RnJV4x0F1X6SzoYtK5yr53U9f0U5WYmOVA6amIBz+eP8n4ZPwqwK3ZxV3d2l7
	 cpuHd6o7lEGXLScfPwU0otskZvsnlBQvwHyVviXz4dGIxJ3WkLGOag0NgyR3q1I7eug==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=LDgvF8rV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.174
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2422A606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 19:48:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2422A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=LDgvF8rV
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-8a05effaf8dso173237b3a.2
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 12:48:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793130497; cv=none;
        d=google.com; s=arc-20260327;
        b=NtkUXAzgJ6HZCJhoYif2PL99N+fh9qWXa72kOAyou8f9OAtYVzWzCqISIo538eiQmV
         DVmNdJptMM9tM7O3KAaTWzcllg+BELRov83Rs/XgbQ9aaupJqZGqjzd1Xjc7tedyg3Wl
         mpPONPBQywZoXU0uDw4sBsdX3T1MNYMUnQiAfvL7kOKI4WkHbFAXfwgwJ1u4IREWW8dT
         eLFKU2DvGNWZpkQgU8Dd7WYuMN5xIUCWgQ2g1Tho/BQKEMOeY7AFgRDOaRF92XHRZUFU
         X6vcdXjwbQUw8OTxTJZnEJBKhYBHiJ1NCsft1imXALALckQbrvz54rfafsRczbyfJwl3
         HqDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=02Ht3mxXBA7UdIIlaZIzhVPlgGBGHpRmxcIbzrCl1Q4=;
        fh=shsYV0BKtOggs5cs8p7JIek/nWDXqETGd83LxSdj18Q=;
        b=lAHDyVuGXRsHEcMeBVoNmSFsEB6TCEcWJmCmMd+B2nHqvAgPSo3uz2vCZycob95eJ0
         PfgK3VyqR0dKhj+VU6lFa1uFDT1AsLPpQzADbFCFMIelVQ0u0M9W0jr9wGzGq7UEXpi2
         +5jhyMklD6mBIgljimx6i6Z2bCWT2LBpoCw0BfOU4fF0SnpS8O8AX8o2mjmywE4Trstl
         jcXwzl5r6OjWscBw5gGwZc4rJA9jnvSZjKst8+IwQifrx64KKrPN9zRSnU/4rJeSbE4h
         oeB36ZVtc4a36QVl2l9WN/kbLUra5B2gOgwOKgm9KsFQq5ljU/IZEVWok9GT/naO7tOl
         5iiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793130497; x=1793735297; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=02Ht3mxXBA7UdIIlaZIzhVPlgGBGHpRmxcIbzrCl1Q4=;
        b=LDgvF8rVl8B6iqexGtDVMIHzvKgjU9Q1DYrdMTPEcRI0dsKcblTS/w2aKBAnwndeX4
         EJrwWzC+ezWe8gqvzzUAcjJYbiTRqq/NOepuGTRBXFAnMCZ+ScZEGkcUw9/dsMcgcp2A
         84iKJy5OkBaH/UxwdVvdq6ZY42FJC/wyWq76Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793130497; x=1793735297;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=02Ht3mxXBA7UdIIlaZIzhVPlgGBGHpRmxcIbzrCl1Q4=;
        b=DXR9jTC0cLbTKAk3DOQAqDxg0sdnGY5Rv+NSoPu88X8YDpURWCMT7QBvQVB9a74YhN
         cdKR06N+gb8FFTpxJxnTB+JmRH3woU5eA65/gA6+8eTuk1mcZfjY5wTgITjXIRgwVxCm
         Bm9KnDZgYw91rsMbFt22+N+K4O14uYl10xAFkkz6oap4PjpG3wG3xjb5VwZOsm0vRdZ/
         QCtPEb059et068Lz4tlScLaZRnZv2L/hQ66LSlCcxeTgLJO84Ob1MVg7TFyuYYxyYO9u
         ZrVcxO90LejaN7AAxeehFecwzco6rN7/lc6mLAl0s6U+ay56VJZzFUI6bBzLsCMXrP+Z
         mvQA==
X-Forwarded-Encrypted: i=1; AKwUvBzch2Zu74tNA1fJVWcfPeahOvoxlm2LkCxH1XPHpKQX3JZKjpMRqTPCx5KvNtiH5h7xTWbI1VA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ3BA78fJRJTQR4AcmVvFOIEfsr8ZEFFSAoz66LhLRNIPj3rP1a
	ol1ZllZxtObcXBa0tNHRxZhYhfnjbGi2UuIAj2B4i0ltM4mRu3P88jxUeBtOBo+sTlKaUiK7x+/
	VWI7srBlMzliASfMqasowkwj90fIfU5KIcOOKx2YV
X-Gm-Gg: AYBFou1Mf0ci4N1UYbP4zEUrwGPAqAZKx2qdErndiDZLfGymeg/ztOuNQkyHYEJ9bAK
	ejJohOYZdUbb/SHRpnjVhYak8YfezOZ0KzM4Kvc/NleUyCSKeVjXGPLI9pds+1fcdBy1RfRejR7
	T3dMCPAQOGwMtzTYACoUJK8IxgpaoonOb3rgcwskAFWi5+GKuajSQmff/HBpmojHYeDK0PZRccT
	FNsIRx7YF6rVyhfFe5KSEgaDMqfeZDk+eB3NXkJDCGjjLDoRudwV24NsW8CrpJOcpmzCskLop/r
	zSDmEJ/sV96+hs5h7oTPcscJWSFIHk4OpwbUZQ9sIXGXvkFLCDevTrviVMIhTJEDgUUFYdiQPC8
	FNoGT2jappraXl7LWLRw2LMH1vvDzszPjOD7GULp9pGsunASJhspJ1tfdq9mPfUvqH5Asnhsv3J
	NOCT7kxnATpxUmERM=
X-Received: by 2002:a05:6a00:ab05:b0:881:8b53:f66 with SMTP id
 d2e1a72fcca58-8a6e6a17a15mr234459b3a.24.1793130497474; Tue, 27 Oct 2026
 12:48:17 -0700 (PDT)
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
 <CAL4WiirUmA1GnUaZq5MQgENZRo1248YSo6AOYb_OseWS8p-Cbw@mail.gmail.com>
In-Reply-To: <CAL4WiirUmA1GnUaZq5MQgENZRo1248YSo6AOYb_OseWS8p-Cbw@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 27 Oct 2026 15:48:04 -0400
X-Gm-Features: AclHuK-FF5sNZQAKK9UQMayklgKAkZVtQOswWiBymadY4veINyjvFnP44UXAJwg
Message-ID: <CAM0EoMkTUK1cvNbeSvyOGLQ9yxQfR9-TsmQXXZbosbX+pz_2WQ@mail.gmail.com>
Subject: Re: [PATCH net 0/5] net: fix eth_type_trans() crashes on skbs coming
 from the stack
To: Eric Dumazet <edumazet@kernel.org>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	Andrew Lunn <andrew+netdev@lunn.ch>, Aaron Conole <aconole@redhat.com>, 
	Eelco Chaudron <echaudro@redhat.com>, Ilya Maximets <i.maximets@ovn.org>, Jiri Pirko <jiri@resnulli.us>, 
	dev@openvswitch.org, Ren Wei <weir@nebusec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 11:50=E2=80=AFAM Eric Dumazet <edumazet@kernel.org>=
 wrote:
>
> Le mar. 27 oct. 2026 =C3=A0 15:40, Willem de Bruijn
> <willemdebruijn.kernel@gmail.com> a =C3=A9crit :
> >
> > Eric Dumazet wrote:
> > > eth_type_trans() assumes ETH_HLEN bytes are present in skb->head.
> > > NIC drivers always provide this, and they should keep using the fast
> > > version, without an extra pskb_may_pull().
> > >
> > > Devices looping skbs from their transmit path back to their receive
> > > path get skbs built by the stack instead. tc actions (act_vlan pop_et=
h,
> > > act_ife decode), BPF helpers (bpf_skb_change_head() before a redirect=
)
> > > or OVS actions (pop_eth followed by pop_mpls/pop_nsh) can leave fewer
> > > than ETH_HLEN bytes in the linear part, and eth_type_trans() then hit=
s
> > > the BUG() in __skb_pull().
> > >
> > > Instead of fixing every producer, or adding a check to all
> > > eth_type_trans() users, fix the few consumers exposed to this:
> >
> > Definitely a nice approach.
>
> Thanks!
>
> >
> > You previously suggested catching most of the TC modifications with a
> > single check in sch_handle_(e|in)gress. Is that no longer needed?
>
> Not for these crashes. The sch_handle_egress() check would only cover
> tc egress. It would miss OVS and the redirect paths you mention, and it
> would add a check for every packet going through clsact. Fixing the
> consumers covers all producers, including future ones, at almost no
> cost. NIC drivers are not affected.
>
> We can still add it later as hardening, if another class of bugs shows up=
.
>
>
> >
> > The few mirred/redirect cases are a bane, causing so many issues. And
> > escape any such check, as they call netif_receive_skb, netif_rx,
> > dev_queue_xmit, directly.
> >
> > If it's only act_mirred, bpf_redirect and OVS, maybe a single
> > validation helper across all three before they pass to the rx/tx
> > path, that for starters calls eth_type_trans_careful. It quite likely
> > won't be the last packet corruption they are capable of..
>
> I agree these are the problems, and Jamal just found another one in
> __bpf_redirect_neigh(), which does its own skb_pull(ETH_HLEN).

I didnt add my reviewed-by or tested-by because i wasnt sure  if you
are going to resend and include the patch i sent?

cheers,
jamal

> A single helper is tempting, but what it must check depends on the
> target:
> - Egress to an Ethernet device: ETH_HLEN at skb_mac_header().
> - Egress to an L3 device (tun, ipip, wireguard...): no MAC header at all.
> - Ingress: data at the network header. eth_type_trans() is not
>   called again, except through __dev_forward_skb2() (patch 3).
>
> Also, the original loopback crash needs no redirect at all:
> "vlan pop_eth" on lo egress is enough.
>
> So I would keep this series as the minimal fix for net/stable, and
> look at a common helper for net-next, probably based on
> dev->min_header_len / dev->hard_header_len of the target device,
> called from tcf_mirred_forward(), skb_do_redirect() and OVS do_output().
>
> Thanks!
>
> >
> > >
> > > - Patch 1 adds eth_type_trans_careful(), which pulls the Ethernet
> > >   header first and returns a drop reason on failure.
> > > - Patch 2 uses it in loopback_xmit().
> > > - Patch 3 uses it in __dev_forward_skb2(), used by BPF redirects to
> > >   ingress and by veth, macvlan, ipvlan, netdevsim and l2tp_eth.
> > > - Patch 4 uses it in OVS internal_dev_recv(), covering both the MPLS
> > >   (TEB) and NSH pop cases at once (only the MPLS case was tested).
> > > - Patch 5 (from Jamal) fixes act_ife decode on egress, which was
> > >   consuming the inner Ethernet header. This is no longer a crash afte=
r
> > >   patch 2, but egress decode never delivered a correct frame.
> > >
> > > Other eth_type_trans() users already pull the header or never see
> > > such skbs:
> > > - vrf_process_v{4,6}_outbound() already pull ETH_HLEN + IP header
> > >   before vrf_local_xmit().
> > > - tun already uses pskb_may_pull_reason(skb, ETH_HLEN).
> > > - XDP: bpf_xdp_adjust_head() and bpf_xdp_adjust_tail() keep at least
> > >   ETH_HLEN bytes in the linear part, and multi-buffer tail shrinking
> > >   only trims frags.
> > >
> > > Tested under virtme-ng with AF_PACKET reproducers. Without the series=
,
> > > all four cases crash in eth_type_trans():
> > > - lo egress "action vlan pop_eth", eth/eth/8192 bytes frame
> > > - lo egress "action ife decode pipe", IFE frame with 8192 bytes paylo=
ad
> > > - lo egress "action vlan pop_eth continue", then a BPF program doing
> > >   bpf_skb_change_head(skb, 1, 0) + bpf_redirect(veth1, BPF_F_INGRESS)
> > > - OVS flow "pop_eth,pop_mpls(0x6558),0" to the internal port,
> > >   eth/mpls/eth/4096 bytes frame
> > > With the series, no crash. An ICMP echo inside an IFE frame decoded
> > > on lo egress is now received and answered. Normal traffic on lo,
> > > veth (including 8000 byte pings) and vrf is unchanged.
> > >
> > > Link: https://lore.kernel.org/netdev/20261005052249.1914367-2-weir@ne=
busec.ai/
> > > Link: https://lore.kernel.org/netdev/ACT-N6N4.v3.r0.20261023200137-4@=
mojatatu.com/
> > >
> > > Eric Dumazet (4):
> > >   net: add eth_type_trans_careful()
> > >   loopback: use eth_type_trans_careful()
> > >   net: use eth_type_trans_careful() in __dev_forward_skb2()
> > >   openvswitch: use eth_type_trans_careful() in internal_dev_recv()
> > >
> > > Jamal Hadi Salim (1):
> > >   net/sched: act_ife: do not consume the inner header on egress
> > >
> > >  drivers/net/loopback.c               |  8 +++++++-
> > >  include/linux/etherdevice.h          | 28 ++++++++++++++++++++++++++=
++
> > >  net/core/dev.c                       | 18 +++++++++++++-----
> > >  net/openvswitch/vport-internal_dev.c |  8 +++++++-
> > >  net/sched/act_ife.c                  |  4 ++++
> > >  5 files changed, 59 insertions(+), 7 deletions(-)
> > >
> > > --
> > > 2.53.0
> > >
> >
> >
