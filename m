Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793292457;
	b=ohkAqwKf2xWos6ofNvI11dlhkbzSqJIPGto/gd9x7d4Hir7ErPXl8XpIFocCKcBCcK11
	 9T7jQHSs/F0MiJIWTVnuDwFYQae7WRLDEcWMdDm8Y7WHjni+7N+Py19JrmOOc2D2VNVRL
	 lVzwYnCxIPdvRFawLyJTfybSVFNAZwLSmjEqw6B6xRjHY1uJWoktpzaIMzlqT2qpnSPoU
	 koX6HaaV5/NMOxm2ua5eEYuidmJRqmUuxk69Ey9swS+O1nkjkFfCtZCDjWW/wRUwc8OzJ
	 ZJtJxfzIpGRfAGzarRT3JYoVQ4aiXx/DGc7iTDPqeDd8OSCOhDJ8vbgP1FOa2pDJ87g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793292457;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Subject:
	 From:To:Cc:Date:In-Reply-To:References:Content-Type:
	 Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=79DDn4vmcOC3ldaXqJtmkrA2/5RtNDXGpNRnaOFomtw=;
	b=uGZPxH7yOGS+JU2DR9hurZpZRUt1Xag7HTr3c1iPgNjUbotSSs/O3vhv0BqINuY7qqxX
	 2BXJoUCPg3TIp6IAXXLol/u6a67EFPVYr5Hgq0Vz7y2OHGJIAboeSj8F6Omx8LUfUVSsr
	 0KRCyYymdBVLbnVooShEASrEpNmIubJIR1/x9vTN6v6UxpaDokmvUflLFppHGugUacbcH
	 JJyfEdmnVutOyoJjwRbWndrrbA9sSqpHPKTcV47XwSFsdKfhDFutIRGGrYtD2jyoiZTlw
	 uzWdDpyxDRO4uEO5vVXsZGn2gWYYe44Y7FqXQaQZRIekuxVIHmSm4eq9PRpQlr0vxKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="bc3UWHS/";
	arc=none smtp.remote-ip=209.85.216.53
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A34606A31A
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 16:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6A34606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bc3UWHS/
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso1214998a91.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 09:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793292456; x=1793897256; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=79DDn4vmcOC3ldaXqJtmkrA2/5RtNDXGpNRnaOFomtw=;
        b=bc3UWHS/ITwD0lzOlY9HZfRl+H+UlpoFOjSpInaHqsAGuPpJWyh/FXc6a2K2pSXk8w
         iTkYvSbr/AjS/E3BcXEgQzgON7gmFsF3M/7fJ5AxagKMx184QFcpqSt1l5rJFLI5bDVa
         nHyINJKhvRk+27BZYbVV1Rg05Mo3v4/3Y1XKToRKQPk0nni5CUyd7mn17xcCeW+VdeQE
         hwkgFvVf2k/csc87MnoCKBvEqeDnuXyIJNiPcItywFhxtVKgEgOmuQ5cdtqYVIdrZfbq
         cSZJlAoEu4KsgNSOugcHmITimtX+YJAe1RQqYic4vi3h3gFW/mRHyzkMVSJkS5fgDAA9
         yN9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793292456; x=1793897256;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=79DDn4vmcOC3ldaXqJtmkrA2/5RtNDXGpNRnaOFomtw=;
        b=ggN/HCCRG6LYNG5bi9QhFYdRUHHPSKjtghJ+kU+1Hc+CXwMjpzmIhUJ9rDKkp8Jgv2
         fxy+hHjmPnqhelxGmz1n/vrOjmu9fa2gOFa/FSZQwbUaSu2t8Y8SNyW+6IJ3d1mDlzUP
         iYWdtcYKNWznIUmawi9zUNdH9dQSMJ9v3cF2guKyrZkeqQfai3oFH3tAqSr/JpmsfaQc
         j+t2t2ade8oiHPC/CDnDr4c21KCWTeIdbl1zc0S58vTYAaWo0E94p4Lycm3Qp9FcdkbB
         jPa41P5Q4Lt/jFc4EEWYMT+IRlTNGuMV/JwTcsDlVLBDqd7rB+JqBRsiwPGA7J0Gc4nA
         eO0g==
X-Gm-Message-State: AFq9FYJX1vLhEBz8A4bCyOTBL0ESePlzQHpjZXB1Y5NKpGj9RAcT29oc
	CHwEsD5p4AI8wJqtC1Bd15ST5dbQ8r37W9fuuhVGnLLV8Eogoll7ROIq
X-Gm-Gg: AYBFou2ospVgAKb4hQ6f0pF6f9lnd/j2ADzjQjBnlH5wpyBB2AEgKOPZx+mXD3cxayY
	a72cAoPhxMGVxHXMKos76zR4T4wMpVfQ1iOFwjznrZCpqYC6hMhFcDvD8/uFgWcA1jqpkZWuN/Y
	V528CnMJiwEOBDG/Ws3mCFv5gQppTxXetGIn3CPiTkU8ngEjb9P1YbVqdG5/pMUDo4ijG3jm1Ey
	vRnhiqGx6Px84KXkw7srO4eoGMMIROtE2Hd3Ei6kn4B3KPKDjdO21qYAhuuG1tOZxLV5exzJ/0D
	V2fNEQD3kJytzlT7dkhb8w6ZJISjOR5A+E0GEogw6H4s1lAwpbouoDJLbupe/UaT3rMgi1k8WjB
	xxDYtY7qOKrhNIP46Qx9mL2fa5BgAxewxbwi7NDig6ERtqOlMCrBriYw3gQdopIoClL2FfFkTdy
	k5gHnQUXYYrIEUce46PMJq2wo6IfOarcHaG+lr+FYM1be2LOBT7FUYOKme+tfYR3oGCbc5+WBGf
	db2vtBMgUr7BzEEyJ51A7op5K/bJ1TcXn3rm36xE2FZiW2cUJ0vtsa19k6yXb/ttJ4u864fyDmt
	iLI5zzsVtsfzXH10ysnAF8vuuGm4zTzNmDU8UK8hiPnMAVcojVeyGlCsaSmXYKaSG+okVvEdMRk
	jAv1BEzUDib5tQdxgnL6BX5o0ZVG+DUHYd09EehxvUF/WBQJuGFTHsLkMmvuID1X2P/4=
X-Received: by 2002:a17:90b:57c5:b0:3ab:9f89:e1b3 with SMTP id 98e67ed59e1d1-3ae580dded9mr4420716a91.40.1793292455884;
        Thu, 29 Oct 2026 09:47:35 -0700 (PDT)
Received: from ?IPv6:2605:59c1:38c:400:82ee:73ff:fe41:9a02? ([2605:59c1:38c:400:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3ae6e9583c1sm5285959a91.10.2026.10.29.09.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 09:47:35 -0700 (PDT)
Message-ID: <31444b89635e8520c262ae915235991c3c075a0a.camel@gmail.com>
Subject: Re: [PATCH iwl-net v2] e1000e: fix Tx descriptor field wrapping
From: Alexander H Duyck <alexander.duyck@gmail.com>
To: Matt Vollrath <tactii@gmail.com>, intel-wired-lan@lists.osuosl.org, Tony
 Nguyen <anthony.l.nguyen@intel.com>, Przemek Kitszel
 <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub
 Kicinski <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>, Andre Brait
 <andrebrait@gmail.com>, stable@vger.kernel.org
Date: Thu, 29 Oct 2026 09:47:34 -0700
In-Reply-To: <20261028170239.28606-1-tactii@gmail.com>
References: <20261028170239.28606-1-tactii@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44) 
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

On Wed, 2026-10-28 at 13:02 -0400, Matt Vollrath wrote:
> When an skb arrives at the driver and the header length exceeds the u8
> hdr_len, tucss and tucso fields in e1000_context_desc, wrapped values
> are sent to the card. If TSO is enabled, some header lengths will cause
> the card to hang.
>=20
> This was reproduced on an I218-V with an unprivileged Python script.

Can you elaborate on what the script did to trigger this? I am
wondering if it can even get there with a valid frame supported by the
interface since most of these e1000e parts don't support tunnels and
such.

Also did it have separate cases for the CSUM vs the GSO? I would
suspect this is more a CSUM issue than a GSO issue.

> Fix it by disabling GSO and checksum offload when the header length (and
> checksum offset) would exceed the field widths. Compensate for a
> software-inserted VLAN tag.
>=20
> Because of a quirk in the ordering of ndo_features_check, the skb's
> transport_header field may be stale. If the skb carries
> CHECKSUM_PARTIAL, use csum_start to find the header. Otherwise, there's
> no reliable interface, so don't offload it.
>=20
> Fixes: bc7f75fa9788 ("[E1000E]: New pci-express e1000 driver (currently f=
or ICH9 devices only)")

I am pretty sure this Fixes tag is bogus. This is the introduction of
the e1000e driver which was in 2007. The ndo_features_check didn't
exist until 2014 sometime after that if I am not mistaken.

Much of the complexity that enabled frames to build up massive headers
wasn't until much later when the network tunnels and OVS started being
added.

> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Matt Vollrath <tactii@gmail.com>
> ---
>  drivers/net/ethernet/intel/e1000e/netdev.c | 34 +++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/eth=
ernet/intel/e1000e/netdev.c
> index 6f85dab5c55c5..370776657d100 100644
> --- a/drivers/net/ethernet/intel/e1000e/netdev.c
> +++ b/drivers/net/ethernet/intel/e1000e/netdev.c
> @@ -7355,6 +7355,38 @@ static int e1000_set_features(struct net_device *n=
etdev,
>  	return 1;
>  }
> =20
> +static netdev_features_t e1000_features_check(struct sk_buff *skb,
> +					      struct net_device *netdev,
> +					      netdev_features_t features)
> +{
> +	/* Do not offload packets whose header lengths exceed the u8 fields
> +	 * in the descriptor.
> +	 */
> +	unsigned int hdr_len =3D 0;
> +
> +	if (skb->ip_summed =3D=3D CHECKSUM_PARTIAL) {
> +		const struct tcphdr *th =3D (const void *)skb_checksum_start(skb);
> +
> +		hdr_len =3D skb_checksum_start_offset(skb);
> +		if (skb_is_gso(skb) && skb_is_gso_tcp(skb))
> +			hdr_len +=3D __tcp_hdrlen(th);
> +		else
> +			hdr_len +=3D skb->csum_offset;
> +	} else if (skb_is_gso(skb)) {
> +		/* Work around untrustworthy header offsets in this case. */
> +		return features & ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
> +	}

Most drivers currently assume if the CHECKSUM_PARTIAL isn't set then
the frame must not be TCP/UDP GSO since for those normally the checksum
and offsets should be populated. Have you identified cases where we are
seeing TCP/UDP GSO w/o the checksum being set up?

From what I can tell it looks like the only valid cases for it not to
be set and instead it is set to CHECKSUM_UNNECESSARY on a GSO frame are
FCoE and SCTP (GSO_FRAGS) which are both non-TCP/UDP specialty cases
anyway.

> +
> +	if (skb_vlan_tag_present(skb) &&
> +	    !vlan_hw_offload_capable(features, skb->vlan_proto))
> +		hdr_len +=3D VLAN_HLEN;
> +
> +	if (hdr_len > U8_MAX)
> +		features &=3D ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
> +
> +	return features;
> +}
> +
>  static const struct net_device_ops e1000e_netdev_ops =3D {
>  	.ndo_open		=3D e1000e_open,
>  	.ndo_stop		=3D e1000e_close,
> @@ -7374,7 +7406,7 @@ static const struct net_device_ops e1000e_netdev_op=
s =3D {
>  #endif
>  	.ndo_set_features	=3D e1000_set_features,
>  	.ndo_fix_features	=3D e1000_fix_features,
> -	.ndo_features_check	=3D passthru_features_check,
> +	.ndo_features_check	=3D e1000_features_check,
>  	.ndo_hwtstamp_get	=3D e1000e_hwtstamp_get,
>  	.ndo_hwtstamp_set	=3D e1000e_hwtstamp_set,
>  };
>=20
> base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5
