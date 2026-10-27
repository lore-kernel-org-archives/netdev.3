Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793106436;
	b=uIHzOvSfWNc73maFUSRRuz5ZTgf01uOZP7zaeVaRYoopca0tkmgFeHVCeC1q7Bdws/i+
	 Fuh1YtOEliQk2K7urCMM9N8baeF2gQzau2lUaD+BM5uu6+g1Gi4GdHaEBO65K8CeT7PGx
	 d473R0lRIxtjL1aA8/UwQCfTJXaTQ0AaT9ttQIj5oY+8Qpx51VKb8tdNlu7inKp9J+Fo9
	 SGxMgZClbtgMrHDqFxk8TRT6pYgxtbN1/4WeKX2p/BZrmFgY+eCNNQoLxOBGi3u8niAhs
	 aw3fKxWPCUqbUJmbOTfvBShh2kUM/vi0p+a+GZqdywM3RnI1UgAHARrmEK/A/wCK1uw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793106436;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=ccxMWNFOhLMuGIVXFYua0P+NYVbasXoXNOavHKrftV0=;
	b=lJQjD9qFndFWnE/7pam8y0SL564/gyHeYLez3Lcl1CSyF95hHwYq5Q8hu1YJjSrN638G
	 gROUKWDkDr5FKXEDVCVR6uxMSwpHWXOU4RxuwYcBUtV5882KZKyQlm82Sw1qRFmisNZmY
	 R2PHO/Q0eRNqELpYMykq20dqUDnXRb8kN9gLtm8MC20jzMDtRu7Nor4FZBbwAn/ltdbQ/
	 WUFj4ZiQqpZvC+gUZVHxxNPUP3UezMct+6qfHX9VI8+b/1bVSrMySlV325OYyiyTNUSjJ
	 OwFAOtA67u8XTKTuQZHnJNOa6hs8zy5z6QgO7OxQJNabTN/HKopcEu0KudvFXmpQUlA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=Gb9F5okG;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.181
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3238606A31A
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 13:07:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D3238606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=Gb9F5okG
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-8a05effaf8dso2746671b3a.2
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 06:07:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793106435; cv=none;
        d=google.com; s=arc-20260327;
        b=O3cxlslr3mSdgvsdoZarI3lDaNmbxmlJiHtiElT88vSBu1aB0FpIbrcEvWZa7C++1k
         CsxfBiDXVY+r45fMquxim2ugyDN31DRU53jr0F4vJjZ5BrdsR8+bTreM98Ir7PZ0F4hm
         flVboeCfeXF3yXr/G5iuI1MwpG1/DF1cG+TYuHkf7VVO/HcSilPUVyvJurpOwd651D8O
         EOpnSVz4LkMGRDLS8IHA8jLkdvwHYbxP945CYkGOsyZ1cD6nFxiFpoDIjVuHTJkiWWFB
         eyD+aQJP/d6YhL1w0RQhZKpUKSQ35v1qFuv89zEXRGuv3Vebatc+5ZBDNQiQFktzlak8
         4mnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=ccxMWNFOhLMuGIVXFYua0P+NYVbasXoXNOavHKrftV0=;
        fh=qw64Cy9Ycm4jlulYXZIMEdxsFFX1Md7Dr4TEel47RWY=;
        b=HtH3p0KYBlmJvx9dAQkTbxGunnNdSkJtgopExp2JzTDXwmZjVxrzGM7R/+MTpGD/Ma
         Xv3sXNdgCGPvJ9eMZEb6lqQE9AEOGE6O3aYJs0pYddLE76HNT+RaeMMNlOsXIzunW7t5
         +r3nKHXAA5TfQZmgXhjkuQltZ0+ArNslXsKdi3yse0ICe2G+FS2ta8Yb1qhDq9Y/x24y
         9aIa6k4GzVp6kVy2nVoSKNjtRA2h0TklTIuU7wrBSH14TufHCOz8e06u9UvsRVxazjzz
         Q3Cvn7kYOqIkONYjmdenANdsajRlWyQuomhsoxlLAK8+hZLZB1BD3k+FgtA/sTg9V2Np
         PFXA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793106435; x=1793711235; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ccxMWNFOhLMuGIVXFYua0P+NYVbasXoXNOavHKrftV0=;
        b=Gb9F5okGMuM/Wz5XQZqmM518zjcsXgGMid8pZUi8fnNCn/adxUoW1OBfS1aF1i/Ml7
         3zESV2BDoV6+0T6OZS2DkqnHER3o1VpSrv+X7rSfFPYVqxRZ+Db6BS9L8Bvzmak1ngGA
         gi1/EV0gcgeLhC4DpU8cUSlB5pqQmTVbN1yIo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793106435; x=1793711235;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ccxMWNFOhLMuGIVXFYua0P+NYVbasXoXNOavHKrftV0=;
        b=VfSGP4gg0xEr95bTL3AkWU67lcs50WodHADeCjKgmXqB0y5zIrbKcNYmNHDdNoN9up
         uC4MOv2CA7zQHhK29amZ608evCIf5PAWLHwLEO62lRods4LtUx1MM9aMHNx+Kwv3oMz5
         xO0e38PcLEQBpYJHgfrX9iIm1hSju5gXXrWo/i/iQbCd2xR0TI6ECi2oi4HlK/GY8Mlw
         9Mypc+6Fway8oW7SUgEr0GUF4Cym9Fuw168d6TJEB71ix8Nr3zT72kUjDJ6OaueGv0d7
         3dPS7icLMeE7IevkmV/MMBeKhIyrzHKGcCjboRcrHR+hJJyCrhxXdzpxaOgWEc9wRXmL
         dwfw==
X-Forwarded-Encrypted: i=1; AKwUvBxC/j+GQfoqcmJUC00zWUsP+Jum2J2n0sGAh3U6gNvuCjZ2jbENzfGlT+kY+CLPv6wFSpI7IFI=@vger.kernel.org
X-Gm-Message-State: AFq9FYJHVkl/sv5iZ5RTzFnzvSGAZ4uLsjffeMgmCK1lgK+X6LEhha6h
	IE8hGiMZUIYaHf99fWJUiVC/bpKTC71Y2Gh2jCplqQBIMmOekJfOjX+EG4ZDe0Q9bqY3STeZoEY
	NZOcsKC5kYTvpN5JFfcjaNriYzxxv61v17P8jMCQa
X-Gm-Gg: AYBFou2GKPNTI5bWGDF5qaFqqu0L0+c9CYrwCSjPS9nMQ83UzsHTSsV4IYTAAZ8YLUz
	SDsqwY/OTCyaI8PhjhXgXrbpxX4+96Ms/5vigwEHyltTtOYpU3zuKhbU6OLmRncHFtQEK2VCV/C
	5bSZJkSynCHDVdRC1Sjw5Vmi+Xag9Uceq62jqZcJWb5aDK5Omt546up7+qxpcAd56E/5iG16r8Y
	WYuJnind7X3+YbEnDKwBYgyGm+f4qfEr/yyAtY8NdRirJ/TZV67XHy5XrdNtUrSEGVaGth5mOyJ
	sULLzAz4q6g9nfk6tat8+jhik8T+X7jGSMJrzrLpOQZqo6JzRatBefKsm9tTrn9vCJhRNXvaMQV
	fqON3OIHuCmH6Q20bOi1MfEFq84V5qXbQIKvLoDHsKDsc4s1tWMJrLvfL6Rxr/wsuQe4UQ68sIO
	0ruqPrltuDT7L6W28=
X-Received: by 2002:a05:6a00:e8a:b0:898:664:446 with SMTP id
 d2e1a72fcca58-8a368aa1a79mr7612299b3a.54.1793106435172; Tue, 27 Oct 2026
 06:07:15 -0700 (PDT)
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
 <CAL4WiipM12m6mi07bebyCGsA8D-r6YRL1_q6+ZFF2Vx0jv7NiQ@mail.gmail.com>
In-Reply-To: <CAL4WiipM12m6mi07bebyCGsA8D-r6YRL1_q6+ZFF2Vx0jv7NiQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 27 Oct 2026 09:07:03 -0400
X-Gm-Features: AclHuK-JMPpCyc7uL8fdhV22ZTdCZAosWg_AdfAToAJtyef3UCGbQkaCudOqreo
Message-ID: <CAM0EoMkkVK5V9dVRdr-iOSU_pmXEjf9m3Og71MEFzWZFnOGV1Q@mail.gmail.com>
Subject: Re: [PATCH net 0/5] net: fix eth_type_trans() crashes on skbs coming
 from the stack
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>, 
	Ilya Maximets <i.maximets@ovn.org>, Jiri Pirko <jiri@resnulli.us>, dev@openvswitch.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Ren Wei <weir@nebusec.ai>
Content-Type: multipart/mixed; boundary="0000000000001d1ce0065ed22057"

--0000000000001d1ce0065ed22057
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 5:52=E2=80=AFAM Eric Dumazet <edumazet@kernel.org> =
wrote:
>
> Le mar. 27 oct. 2026 =C3=A0 10:17, Jamal Hadi Salim <jhs@mojatatu.com> a =
=C3=A9crit :
> >
> > On Tue, Oct 27, 2026 at 4:26=E2=80=AFAM Eric Dumazet <edumazet@kernel.o=
rg> wrote:
> > >
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
> >
> > Looks interesting ;-> I dont think you are covering xdp/bpf holes but
> > we can worry about that later.
> > I will spend time later this morning looking closely and actually
> > running it. Will keep you posted.
>
> Thanks Jamal.
>
> I went through the holes you listed earlier:
>
> 1) bpf_skb_adjust_room() + bpf_redirect():
>    An egress redirect ends in the target ndo_start_xmit():
>    loopback (patch 2), veth (already pulls ETH_HLEN), OVS internal
>    port (patch 4). An ingress redirect goes through
>    __dev_forward_skb2() (patch 3). The repro in patch 3 uses
>    bpf_skb_change_head(), the only helper I found that leaves
>    1 <=3D mac_len < ETH_HLEN with an almost empty head, passing the
>    mac_header < network_header check in __bpf_redirect_common().
>
> 2) bpf_clone_redirect(): same __bpf_redirect() path as 1).
>
> 3) ingress: after tc ingress, eth_type_trans() is only called again
>    if the packet is redirected, see 1).
>
> 4) XDP: bpf_xdp_adjust_head() and bpf_xdp_adjust_tail() refuse to
>    leave less than ETH_HLEN bytes in the linear part, and multi-buffer
>    tail shrinking only trims frags. skbs built from xdp buffers
>    (XDP_PASS, veth XDP, generic XDP) have a full Ethernet header in
>    skb->head.
>
> Let's use something that can be plugged / unplugged easily in the future.

I reviewed and tested all existing issue, they are fixed - kudos ;->
But, but.... you missed one;-> see attached patch.

Additional questions:
1) Would be interesting to see what performance degradation happened here.
2) I think it is reasonable i send my original patches 1-3 to net-next
when it opens as "hardening" patches
3) Is it correct to put multiple Fixes: in net patches (you have i
think 4 in one of them)? Sashiko complained once that a patch I sent
made stable backporting hard. Either you pick one or split into
multiple patches. I realize picking a "good" fix tag is very hard in
this case.

cheers,
jamal

--0000000000001d1ce0065ed22057
Content-Type: application/octet-stream; name="bpf_redirect_neigh.patch"
Content-Disposition: attachment; filename="bpf_redirect_neigh.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mvqp8jkp0>
X-Attachment-Id: f_mvqp8jkp0

RnJvbSA2MjRmZjljZTQwZjU3Zjk4MTc2YzIzYmFjNGRlZGQyOWFiNTcyNzQ1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBKYW1hbCBIYWRpIFNhbGltIDxqaHNAbW9qYXRhdHUuY29tPgpE
YXRlOiBUdWUsIDI3IE9jdCAyMDI2IDA4OjA3OjU5IC0wNDAwClN1YmplY3Q6IFtQQVRDSCBuZXRd
IGJwZjogRml4IHNrYl9wdWxsKCkgQlVHIGluIF9fYnBmX3JlZGlyZWN0X25laWdoKCkKVG86IEVy
aWMgRHVtYXpldCA8ZWR1bWF6ZXRAa2VybmVsLm9yZz4KQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5v
cmcsCiAgICBicGZAdmdlci5rZXJuZWwub3JnLAogICAgc3RhYmxlQHZnZXIua2VybmVsLm9yZwoK
X19icGZfcmVkaXJlY3RfbmVpZ2goKSBjYWxscyBza2JfcHVsbChza2IsIHNpemVvZigqZXRoaCkp
IGFmdGVyCmNoZWNraW5nIG9ubHkgdGhhdCBtYWNfaGVhZGVyIDwgbmV0d29ya19oZWFkZXIuICBJ
dCBkb2VzIG5vdCBjaGVjawp0aGF0IHRoZSBNQUMgaGVhZGVyIGlzIGxvbmcgZW5vdWdoIG9yIHRo
YXQgaXQgaXMgbGluZWFyLgoKQSBTQ0hFRF9BQ1QgQlBGIHByb2dyYW0gY2FuIGRvOgoKICAgIGJw
Zl9za2JfY2hhbmdlX2hlYWQoc2tiLCAxLCAwKTsKICAgIGJwZl9yZWRpcmVjdF9uZWlnaChsbywg
TlVMTCwgMCwgMCk7CgphZnRlciB2bGFuIHBvcF9ldGguICBUaGUgc2tiIHRoZW4gaGFzIG1hY19s
ZW4gPT0gMSBhbmQgb25seSBvbmUgYnl0ZQpvZiBsaW5lYXIgZGF0YTsgc2tiX3B1bGwoRVRIX0hM
RU4pIHRyaXBzIHRoZSBza2ItPmxlbiA8IHNrYi0+ZGF0YV9sZW4KQlVHIGluIF9fc2tiX3B1bGwo
KToKCiAgICBrZXJuZWwgQlVHIGF0IGluY2x1ZGUvbGludXgvc2tidWZmLmg6MjgzOQogICAgUklQ
OiBza2JfcHVsbCsweGM1LzB4MTAwCiAgICBDYWxsIFRyYWNlOiBza2JfZG9fcmVkaXJlY3QgLT4g
Li4uCgpEcm9wIHNrYnMgd2hvc2UgTUFDIGhlYWRlciBpcyBzaG9ydGVyIHRoYW4gRVRIX0hMRU4s
IGFuZCB1c2UKcHNrYl9tYXlfcHVsbCgpIHRvIGVuc3VyZSB0aGUgRXRoZXJuZXQgaGVhZGVyIGlz
IGxpbmVhciBiZWZvcmUgcmVhZGluZwpvciBwdWxsaW5nIGl0LiAgUmUtcmVhZCBldGhoIGFmdGVy
IHBza2JfbWF5X3B1bGwoKSwgd2hpY2ggbWF5CnJlYWxsb2NhdGUgc2tiLT5oZWFkLgoKRml4ZXM6
IGI0YWIzMTQxNDk3MCAoImJwZjogQWRkIHJlZGlyZWN0X25laWdoIGhlbHBlciBhcyByZWRpcmVj
dCBkcm9wLWluIikKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKU2lnbmVkLW9mZi1ieTogSmFt
YWwgSGFkaSBTYWxpbSA8amhzQG1vamF0YXR1LmNvbT4KLS0tCiBuZXQvY29yZS9maWx0ZXIuYyB8
IDYgKysrKystCiAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0p
CgpkaWZmIC0tZ2l0IGEvbmV0L2NvcmUvZmlsdGVyLmMgYi9uZXQvY29yZS9maWx0ZXIuYwppbmRl
eCA3MGRjNjIxNjcyZjIuLjRkMzQ0ZWMwOTczNiAxMDA2NDQKLS0tIGEvbmV0L2NvcmUvZmlsdGVy
LmMKKysrIGIvbmV0L2NvcmUvZmlsdGVyLmMKQEAgLTI0MzIsMTAgKzI0MzIsMTQgQEAgc3RhdGlj
IGludCBfX2JwZl9yZWRpcmVjdF9uZWlnaF92NChzdHJ1Y3Qgc2tfYnVmZiAqc2tiLCBzdHJ1Y3Qg
bmV0X2RldmljZSAqZGV2LAogc3RhdGljIGludCBfX2JwZl9yZWRpcmVjdF9uZWlnaChzdHJ1Y3Qg
c2tfYnVmZiAqc2tiLCBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAogCQkJCXN0cnVjdCBicGZfbmhf
cGFyYW1zICpuaCkKIHsKLQlzdHJ1Y3QgZXRoaGRyICpldGhoID0gZXRoX2hkcihza2IpOworCXN0
cnVjdCBldGhoZHIgKmV0aGg7CiAKIAlpZiAodW5saWtlbHkoc2tiLT5tYWNfaGVhZGVyID49IHNr
Yi0+bmV0d29ya19oZWFkZXIpKQogCQlnb3RvIG91dDsKKwlpZiAodW5saWtlbHkoc2tiLT5tYWNf
bGVuIDwgRVRIX0hMRU4gfHwKKwkJICAgICAhcHNrYl9tYXlfcHVsbChza2IsIEVUSF9ITEVOKSkp
CisJCWdvdG8gb3V0OworCWV0aGggPSBldGhfaGRyKHNrYik7CiAJYnBmX3B1c2hfbWFjX3Jjc3Vt
KHNrYik7CiAJaWYgKGlzX211bHRpY2FzdF9ldGhlcl9hZGRyKGV0aGgtPmhfZGVzdCkpCiAJCWdv
dG8gb3V0OwotLSAKMi40My4wCgo=
--0000000000001d1ce0065ed22057--
