Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792508937;
	b=Em/FPXqGRZaEP42FWrcHC7df9b2vyKWH76wotFp4bb0aELM1FL1D+ulTG73I2M+M3+zF
	 aax9v+l4mnU5/MhMXRS4Tf8imffV/K8CHSJ/SJFhe52xuqc9A1JAYo3QHDERZIiQVJ53T
	 VDPuSZTEpHJnSR2V6j7QBRde4ZXQcDFDMqubKZ9v8w9Ve7cfnPDaRl+3NAkf46PhvMohf
	 +S6z3Mw1Z+UrcjoLbk8TPRUl92acE90uEdkdmsNpTQUyUc/Hj+S0ssi5WgAoppcZoZ9Sy
	 BPq/gZ/GN5HLWqBU6sQuZ6DcBZfke8UJcM+VJjU3xLHiREV/efWl6gpMlkrfFZeZjaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792508937;
	h=Received:Received:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=x/LDu3V5q69aJnMnC8UTw2DlNI1htl3YHUpx31QNhLA=;
	b=CD6l0O3XAn3dlb1RmiJBFSNHLmEptacI0oy/4ZGaYJjHAICB+GzIcABBW86pZArYuH79
	 jerenOsvesx2Wahy+428R5Vqg5K2ETZWorkddxmL4ABvYouk05vuWrIV93DZ/RaDCNBCL
	 wYL10fgU3XgTj1EDkfGIBPeCsnjs9lzofy3EpzOCRMAqo/EwhkLLf0QTwM5/334waN+SD
	 WmtzRMFFiQKEHNrs5QXMAW5NifuQs8EfKR+Jtwj6ivVQJfRPoWrG+0K+qTGZChOyZPgVA
	 f2KLyAdrwLGjbAZKyV/onFCFoms/Q8X3UU/N8RBecS5hz0AUe/MLhxy55abp7BOaNOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EDA5606A333
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 15:08:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F18A91F000C7
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 15:08:55 +0000 (UTC)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-49ddddefadbso1222785fac.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 08:08:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx7BotNzhbM1NRLbOwJdhSpVR9dhZZ533rFmuJri70UApkhTxUOCPzUKWLmyDhjnscaSRnRL3k=@vger.kernel.org
X-Gm-Message-State: AFq9FYJboODEFCjE3ML2tqKTCWp/8h4yZ9xVakjPiPU0SjkYbI1RpdGF
	OFm38MfjI9uw3svwTVjmwIkyrpqydmgnIhaSM285TiXtnZgHObmV7vrH3WbfHO5scV4I1Dh/HIt
	XdB3d0RwLIl6nGU7eFaraSTqlHXKLN80=
X-Received: by 2002:a05:6871:878e:b0:4a7:233d:6b8f with SMTP id
 586e51a60fabf-4a7579aece6mr9724160fac.36.1792508905251; Tue, 20 Oct 2026
 08:08:25 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020143031.1829-1-qingfang.deng@linux.dev>
In-Reply-To: <20261020143031.1829-1-qingfang.deng@linux.dev>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 20 Oct 2026 17:08:14 +0200
X-Gmail-Original-Message-ID: <CAL4Wiiptz1zyxRDKrCrnK2Q-qn0_1d1aSxuUPkJKWnODpjMp1g@mail.gmail.com>
X-Gm-Features: AclHuK8hTXIraLSjqiX-ygtYNxZi_7BJWAcAxLMq2zWJ_IkOfRwEoETe4HBpDSw
Message-ID: <CAL4Wiiptz1zyxRDKrCrnK2Q-qn0_1d1aSxuUPkJKWnODpjMp1g@mail.gmail.com>
Subject: Re: [RFC net] net: force software segmentation of PPPoE packets
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Stanislav Fomichev <sdf.kernel@gmail.com>, 
	Hangbin Liu <liuhangbin@gmail.com>, Martin Karsten <mkarsten@uwaterloo.ca>, 
	Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Pablo Neira Ayuso <pablo@netfilter.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 20 oct. 2026 =C3=A0 16:30, Qingfang Deng <qingfang.deng@linux.dev> =
a =C3=A9crit :
>
> Ordinary TSO does not update the PPPoE payload length. A PPPoE GRO packet
> forwarded by a bridge can retain hardware GSO features and reach the
> driver without software segmentation, if the egress Ethernet interface
> advertises TSO.
>
> To force software segmentation, clear the GSO feature mask for
> ETH_P_PPP_SES in harmonize_features().
>
> Fixes: 55a5d8fca836 ("net: pppoe: implement GRO/GSO support")
> Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
> ---
>  net/core/dev.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/net/core/dev.c b/net/core/dev.c
> index a6951ea08961..27483a2ad747 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -3831,6 +3831,10 @@ static netdev_features_t harmonize_features(struct=
 sk_buff *skb,
>         type =3D skb_network_protocol(skb, NULL);
>         features =3D net_mpls_features(skb, features, type);
>
> +       /* Ordinary TSO does not update the PPPoE payload length. */
> +       if (IS_ENABLED(CONFIG_PPPOE) && type =3D=3D htons(ETH_P_PPP_SES))
> +               features &=3D ~NETIF_F_GSO_MASK;
> +
>         if (skb->ip_summed !=3D CHECKSUM_NONE &&
>             !can_checksum_protocol(features, type)) {
>                 features &=3D ~(NETIF_F_CSUM_MASK | NETIF_F_GSO_MASK);
> --
> 2.34.1
>

Ouch.

harmonize_features() is called for every packet, GSO or not.

This is a GSO-only problem, please do not add more protocol-specific
tests in this path. gso_features_check() is only called for GSO
packets, and the cost there is amortized over all segments.

Devices without NETIF_F_HW_CSUM already lose GSO for ETH_P_PPP_SES
because of the can_checksum_protocol() check in harmonize_features(),
and fraglist GRO packets (the main use case for PPPoE GRO) are
segmented in software anyway.

This leaves bridged, non fraglist GRO PPPoE packets sent to a
NETIF_F_HW_CSUM + TSO device. Have you hit this on real hardware?
