Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793092649;
	b=VAbM6D57NIol1PQEcNJ5FjHe/6JcjJO4/MILfHwg2e3BICx3r3DkwUwmwO+poeAuAR0A
	 t5eHLfZjU7SI0olIuSA8Qs6dpcLHEWvp16gj6Cn5lBudiHD0ZelEUh3jG4ZRv+CId8yuV
	 ADr0Uk6LgfJRaW5Yy364XUD1OLeD71gueMJVSciOt5KyAkJ8hCDM4cYajU7N6GfqTMlBh
	 +TC6h/GoTKXipAll8LIessYyW0aFj9SLgjsHW6yZUWqOin7Qq6yWL6ey+6fy4ouqcPL5u
	 q7VUhf0EkTVqiwLiHO+yfh95zy9PxmGevL0DUeGheFozYUvqB7BElx1PWgZFbE4XFGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793092649;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=PgsiDwe5TVVtTcP6ZaengC5JmUG6euBmG9Al8z8/Tw8=;
	b=tJjtxf8Kn5ub1C1MKT7dqnsQdkYIowK5too3uzs9/kTUNFf8Qh8HNLRiyyzP7hVPgUr1
	 bI5qVv3wxsz/4g9J2m5MDeLy8ymEludv3Cf2U/9/RYzAOlFEjHU61GAAH5ykSZySH47aB
	 DON4HHQp0iDsi/ouE9o4VKTc8joiIicf87KuxES/11ABOPCdoLF0uMju/k02ab4mfYOCj
	 u3btRZPq2xKNkFhLPokf0+6/rLkeQvuLTroFbpxg6ExLqPZAkBsscH/lP1y1MkoKrmLds
	 8r7MFOXJhjq+aZKMKD6kr5d5K3D+krFyzdLsTRBkqpR33W55T6eFd2Mamu/DCh1Fqew==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=eFOd8E3M;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.170
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F3F606A31B
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 09:17:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 10F3F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=eFOd8E3M
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8a05f2d5cd3so1601341b3a.0
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 02:17:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793092648; cv=none;
        d=google.com; s=arc-20260327;
        b=NmJAD7o0qZQHE3NgHOUCbmnytYcEoM+JpWcTyuq/fz1jYibd7M9rK+wXMx/uvPSxLN
         WjKNfMatCXnvhlvDRZrEsG6z+HLVBsX56EDHGcQBNuySITpqVODNVD3jxcIHlkhtuLC+
         CHfN2uBUmB+msn5GAHbeXje/fulr70SWZ09Bz4xLwYdrWvxyS3FTxQ+E87Ps27z6iuDw
         GKVb8DZD0E/ZHFtf2N+O9UaaDLTMJb9XAwGxysgPL4u3AvLfwjQ+PpCuCvTyUf4nQ1SE
         eyaYNZWSFw2saeY1t8v2YGDFRUG/XAC/+Cs3ah4efln803/I/lCcyrGhSAXhbap/fIYw
         lr7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PgsiDwe5TVVtTcP6ZaengC5JmUG6euBmG9Al8z8/Tw8=;
        fh=chIauKCbLjqYj2NGIvZjV3iC3x4hWoBbamtcKD4hy1o=;
        b=Bd5HCpqGv/nGgj3MSEiqqCK/LLl3Ybyrlz2Em6I34Avn2z26dSYSs+qZAuRXo2vaEx
         PN7WS+MPL2L/WyG9tCZlLHjxVTyovHXgzyAtoNwSpzRLtysVbSHw1nFyyA0Ie7glKCqC
         krQ29+DNU2rRmMO4fC+Zw9fWto3cj6Mjg/fTGLIYgMDKG4ekM8C8QTUidb290ZnMrQPV
         3Hmkfcdf/nO2m0WFIVy7BBwBT1W1v1/hO7rTkUwnqmAt9jh1YogucGiMHxiGj5sSKGSu
         rg+BFwLCGO2BpB6jHLwweaZalMgPltW7sgwYpCpJJQtfLgCut1/scHREBwnoxtE+HdF6
         fXQw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793092648; x=1793697448; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PgsiDwe5TVVtTcP6ZaengC5JmUG6euBmG9Al8z8/Tw8=;
        b=eFOd8E3MGx6nK00UvsfwAVmqesckS8dQK+Vrip21XyBGCv/s3yi5DCMH9zrIB0xeTF
         BBrTp793oVYhpgCcJXUBZXxUCSwe8o0Q6TcJ3C624pBeuCAqCV6adgydVnLi7P0Jahg3
         lStGSk43i35S9zkME4zk3t6EM9Vo/ePNKW55Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793092648; x=1793697448;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PgsiDwe5TVVtTcP6ZaengC5JmUG6euBmG9Al8z8/Tw8=;
        b=MFRx8FvIDUsI6hHFE3+MTb0idY+oEuLE8reZH6uzSjs03ss4Kfwl36/lx+ALoz++Xw
         xrafZqL8ahGBfufGEzj87jA+vNKsKXW2Aj2mny3ih/j/Q8sPTeAiDsTdz38B6FfI7Sy2
         NckVTMeCmSGBHy6PXzNs+pfFx/g3Lqi2hz9Fm+Wd5k45JLJAnhJAw7dpvg76u/7txlX6
         fLNNGZ377iVQO6k7w7nApC8bhhzeJaQQ8sGUHueDZvPv+2FWJueI/ey0isAzXBGJN56k
         kO6cBft1FwmUW+54XKEpBPyho1BIuhhm9D6/8e5SzRvUMSozRw4z7vgD3ma6mkaoHSCb
         zAuQ==
X-Forwarded-Encrypted: i=1; AKwUvBw1c3mvee0kcJtRfh755P7uT7uwWp3J8GzUsVRIVS5eAxQ61bFdvdvalKmbdMLvDOrr2rq72hM=@vger.kernel.org
X-Gm-Message-State: AFq9FYL/RYpzT/9UzSbYVRoWL8aqM5P0uFfhh0TtGCBFaDVWjHTI/W6L
	+sXYP9j9XorMDmukobuqN9oXt+Mgle7pAFH3BwNEHbRrMlS2m7BAiv47ifXlbEJQjxtQbeX8Nuy
	gny/nPjc/i1cG0gZKunRLxZ/F9iNtk8UWsPlT+SWm
X-Gm-Gg: AYBFou0D5Od+VjQKxoJVdT1jFGNriEd4JKsDdDH67cuR4weSF9dIefyj0M7Hc8V88YB
	2vKTlkrv4x+tLJikZ6sWVFPb50rN1viud+hBLebTKNFzU0WRAms1RP84mxqMDVpE+bf3WjOzuFI
	lRsiES1UqXUd1Yh7dABFzX7wGWPN0NKaXj8UpK4MYTdkRDNxiAHGmRQTqo4fY4kSd3vmEVPOAkw
	IO5taWMAIrwTvlEHZsoiQbSjauax4MJ3BfGRhNcoVE3cTQ2NMECn/zfMC5Fbl23LHN32/+Zmeun
	0NiGHJ6K84AkPiI0f/YzckNq7BFkXlNXhSSzUFEFWNpUpaP/EV1/uGdVgANxlnuJo4AyPIoPv3R
	G+9Ky0ZXAztyGrwamyCyO7pg7+B9K386FqksdojqaqbHgrfAKlDUEThtcTu1B0j7oNJwgXXpGS0
	uDMV7w+CsmJAzL94TpPENNNQIoyON1O+uFTY0Z
X-Received: by 2002:a05:6a00:1784:b0:88d:3f61:20f3 with SMTP id
 d2e1a72fcca58-8a36753dbcamr7172694b3a.54.1793092648190; Tue, 27 Oct 2026
 02:17:28 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027082604.1485903-1-edumazet@kernel.org>
In-Reply-To: <20261027082604.1485903-1-edumazet@kernel.org>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Tue, 27 Oct 2026 05:17:17 -0400
X-Gm-Features: AclHuK9RVeRkyewLRCwW0w4xdjYtmnPctjSw4cKBJqOlCb_P5C-KqlOFj2LgyH8
Message-ID: <CAM0EoMmmnNttUE3FWWg5Y52gCFz-JqxBUXAZEVoxzmvziyV3UA@mail.gmail.com>
Subject: Re: [PATCH net 0/5] net: fix eth_type_trans() crashes on skbs coming
 from the stack
To: Eric Dumazet <edumazet@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, Simon Horman <horms@kernel.org>, 
	netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>, 
	Ilya Maximets <i.maximets@ovn.org>, Jiri Pirko <jiri@resnulli.us>, dev@openvswitch.org, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Ren Wei <weir@nebusec.ai>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 4:26=E2=80=AFAM Eric Dumazet <edumazet@kernel.org> =
wrote:
>
> eth_type_trans() assumes ETH_HLEN bytes are present in skb->head.
> NIC drivers always provide this, and they should keep using the fast
> version, without an extra pskb_may_pull().
>
> Devices looping skbs from their transmit path back to their receive
> path get skbs built by the stack instead. tc actions (act_vlan pop_eth,
> act_ife decode), BPF helpers (bpf_skb_change_head() before a redirect)
> or OVS actions (pop_eth followed by pop_mpls/pop_nsh) can leave fewer
> than ETH_HLEN bytes in the linear part, and eth_type_trans() then hits
> the BUG() in __skb_pull().
>
> Instead of fixing every producer, or adding a check to all
> eth_type_trans() users, fix the few consumers exposed to this:
>
> - Patch 1 adds eth_type_trans_careful(), which pulls the Ethernet
>   header first and returns a drop reason on failure.
> - Patch 2 uses it in loopback_xmit().
> - Patch 3 uses it in __dev_forward_skb2(), used by BPF redirects to
>   ingress and by veth, macvlan, ipvlan, netdevsim and l2tp_eth.
> - Patch 4 uses it in OVS internal_dev_recv(), covering both the MPLS
>   (TEB) and NSH pop cases at once (only the MPLS case was tested).
> - Patch 5 (from Jamal) fixes act_ife decode on egress, which was
>   consuming the inner Ethernet header. This is no longer a crash after
>   patch 2, but egress decode never delivered a correct frame.
>
> Other eth_type_trans() users already pull the header or never see
> such skbs:
> - vrf_process_v{4,6}_outbound() already pull ETH_HLEN + IP header
>   before vrf_local_xmit().
> - tun already uses pskb_may_pull_reason(skb, ETH_HLEN).
> - XDP: bpf_xdp_adjust_head() and bpf_xdp_adjust_tail() keep at least
>   ETH_HLEN bytes in the linear part, and multi-buffer tail shrinking
>   only trims frags.
>
> Tested under virtme-ng with AF_PACKET reproducers. Without the series,
> all four cases crash in eth_type_trans():
> - lo egress "action vlan pop_eth", eth/eth/8192 bytes frame
> - lo egress "action ife decode pipe", IFE frame with 8192 bytes payload
> - lo egress "action vlan pop_eth continue", then a BPF program doing
>   bpf_skb_change_head(skb, 1, 0) + bpf_redirect(veth1, BPF_F_INGRESS)
> - OVS flow "pop_eth,pop_mpls(0x6558),0" to the internal port,
>   eth/mpls/eth/4096 bytes frame
> With the series, no crash. An ICMP echo inside an IFE frame decoded
> on lo egress is now received and answered. Normal traffic on lo,
> veth (including 8000 byte pings) and vrf is unchanged.
>
> Link: https://lore.kernel.org/netdev/20261005052249.1914367-2-weir@nebuse=
c.ai/
> Link: https://lore.kernel.org/netdev/ACT-N6N4.v3.r0.20261023200137-4@moja=
tatu.com/
>

Looks interesting ;-> I dont think you are covering xdp/bpf holes but
we can worry about that later.
I will spend time later this morning looking closely and actually
running it. Will keep you posted.

cheers,
jamal
