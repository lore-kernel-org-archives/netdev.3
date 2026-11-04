Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816224;
	b=F7jmYiNV6T7cWswCRgyYf0Ek3xwzwqvg2Db+A+tsxq6XScnQtxVr2rCWTr5Z/eMgvnfN
	 ZmaiEc6Pkt3Z7kaYTc2e7UkNOu+mB5Tvu1Q949gYwFvNdEbj7gpP0TN7oAPeT2c+qvtUE
	 fk1nZURWKw+9h40XcnEolS80jpccveWsiURVCIN6xRi1EFVxUC4xrlnudN6UrvGRhiuDZ
	 As0dgaI5NkVbRaE8v09CiUFBFeXKQU57xrNML/IfzdS5Xc7gVvPJgFIvAuoTYwlw+DXbB
	 HLPpxreajxvUEkSrLtPGK/u9jvWJo1CsXy/yJqwz4lThHZTaDK/0clt3pcYty0sknjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816224;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=s0gdN9r7YoIc/ceaZAHCVGlBv0z6JB/WIl0QOT0+9HA=;
	b=p7bkvuoFTAkCgfoWKzHQO9aR9OjGBsnOMb2FhUBpJ37EfDcF5sXot91cXaiTqfJGIPVT
	 YQeKcHjPheAsRDP3u8KWrRlfgod52O67uHj7Gbd5B4BwLh1oc80FiNgAnwmixUfMnF3PI
	 o9eqvJIhrexCywfBGQKcz/uNqCB5XiTDRFyM0H5Azsoa8SoSSP/YieYi9VrJrN/H4R39i
	 f8ubys0OmVbe9Uqg3ndsv66AaVXC5yrbCYECyFUtUqG4lXZ70Ak18MZweBVSJX1KLKJnK
	 DYw1MByCioaqBpYqbMM+C/ysE6q5whvfXhEa5j1w333mQrY1Om8rKoO4WV2pc5NpVfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iNaGzjvk;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E1A3606EE87
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 18:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iNaGzjvk
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11511F00A02
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 18:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793816223;
	bh=s0gdN9r7YoIc/ceaZAHCVGlBv0z6JB/WIl0QOT0+9HA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=iNaGzjvkJ4Jl2OrfVNzq9Qfj/YltTv8SYPeLEeOYM/RH4PM8aLN29ouJT521z7H5M
	 2hJ2iKkIQxszyF5ZIslbBOaeoqzrFy7EPEaFz0JmqY3S9jCj8m9RzHFzWfN/3UeL8U
	 PlrXuQwSmiYegP1GdU7J6qFDqU05Oaz79o4GDwRk8XSvYZBhpVd3SyEofvCHP5DeaM
	 z9/LmxrrMF+dgF0G2FxvTynzKbX5i7DqQEWv2zuiJs2VH/Sn+OMlbf4uQSASRUAfzb
	 A/uhNdSyXSLmi5B/Rok0Goky87tYrxJpkmJfUMN3E/2iE9VI7ifMDLUo+xYpFeGhb1
	 g7G3N/DOfRQsQ==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-4a75a5fa32dso324791fac.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 10:17:03 -0800 (PST)
X-Gm-Message-State: APuU4Z+8EDHSXL9cp+3gEKDhcYXHrq4IUum1TJHZ8fQm0Qq6j3cyXwJm
	8BrjlRj4C+b66mgCeQOw9u9RhsvNEGqu23a+gBOBknY7lg/Uz07awEDAAGeYqs5hXmg5FddlxD9
	PUcnj3keAxbTMdGL8H2cKspN8VdBeFVY=
X-Received: by 2002:a05:6870:1b16:b0:455:adbc:2154 with SMTP id
 586e51a60fabf-4a906ca95aemr9834786fac.0.1793816223219; Wed, 04 Nov 2026
 10:17:03 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261104175517.2395704-1-tactii@gmail.com>
In-Reply-To: <20261104175517.2395704-1-tactii@gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Wed, 4 Nov 2026 19:16:52 +0100
X-Gmail-Original-Message-ID: <CAL4WiiocQ1-jpdkYi1u_5T3J7oXK9qXnKDV+316Nd9KtDvsOKw@mail.gmail.com>
X-Gm-Features: AclHuK9MhxRJ-Q82O8AA_HSW9XkbB7IFwX1IFAS1rWiAFskKmqjeLS6mCnCbDUg
Message-ID: <CAL4WiiocQ1-jpdkYi1u_5T3J7oXK9qXnKDV+316Nd9KtDvsOKw@mail.gmail.com>
Subject: Re: [PATCH net] net: reset transport_header for ndo_features_check
To: Matt Vollrath <tactii@gmail.com>
Cc: netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Alexander Duyck <alexanderduyck@fb.com>, 
	Tony Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mer. 4 nov. 2026 =C3=A0 18:55, Matt Vollrath <tactii@gmail.com> a =C3=A9=
crit :
>
> ndo_features_check() can see a transport_header that does not point at
> the L4 header, while ndo_start_xmit() for the same skb sees the right
> one.
>

The change looks fine to me, but this is net-next material: the bug is
very old, there is no report from real hardware, and the patch changes
what every ndo_features_check() sees. Please drop the Cc: stable and the
Fixes: tag. For 6.1.y, send a backport of 5f0764cb1c81 to stable@
separately.


> Commit 663ead3bb8d5 ("[NET]: Use csum_start offset instead of
> skb_transport_header") made csum_start authoritative because receive
> processing overwrites transport_header, and resets it from csum_start
> "just before we push a packet with partial checksums off into the device
> driver". That reset, which now sets inner_transport_header instead for
> encapsulated skbs, sits in validate_xmit_skb(), on the non-GSO path
> only, after netif_skb_features() has called ndo_features_check().
>
> So the hook sees a wrong transport_header for a CHECKSUM_PARTIAL skb
> (after GRO, or from a container or VM) when no stacked device (VLAN,
> bond, tunnel) ran validate_xmit_skb() first and something earlier
> pointed the header elsewhere:
>
> * IPv6 forwarding with a destination options or routing header:
>   ip6_rcv_core() sets it just past the fixed header, and only hop-by-hop
>   options are stepped over before forwarding.
> * br_nf_pre_routing_ipv6() does the same for bridged IPv6.
> * seg6 inline, rpl and ioam6 point it at the header they insert.
>
> A hook that bounds header lengths with transport_header can then leave
> offloads enabled that the hardware cannot handle. For example,
> i40e_features_check() limits IPLEN using skb_network_header_len(),
> which returns 40, while i40e_tx_enable_csum() writes the real length
> into the 7-bit IPLEN field, so more than 468 bytes of extension headers
> overflow into L4_FC_LEN. Rather than make every driver measure from
> csum_start, give the hook the headers the transmit path gets.
>

Only from validate_xmit_skb(). ip_finish_output_gso(), some qdiscs and
netpoll still call netif_skb_features() without the reset.

The changelog is also too long, something like this would be enough
for v2:

    net: reset transport header before ndo_features_check()

    For CHECKSUM_PARTIAL skbs, validate_xmit_skb() resets
    transport_header (inner_transport_header for encapsulated skbs)
    from csum_start, but only after netif_skb_features() has called
    ndo_features_check().

    The hook can therefore see a transport_header left elsewhere by
    the receive path, while ndo_start_xmit() sees the reset one. For
    example, ip6_rcv_core() leaves it after the fixed header of
    forwarded IPv6 packets with destination options or a routing
    header, and seg6, rpl and ioam6 point it at the header they insert.

    i40e_features_check() then bounds IPLEN with a 40 byte
    skb_network_header_len(), while i40e_tx_enable_csum() programs the
    real length, which can overflow the 7-bit field.

    Move the reset before netif_skb_features(). Skbs that are not
    segmented in software reach ndo_start_xmit() with the same headers
    as before, and software GSO parses the headers itself.

pw-bot: cr
