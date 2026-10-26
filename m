Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.169
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793007762;
	b=VgjwqtWGoTZKsLGR4pFVpdmHSUFpBRKMdN1Uq6KRZTVMqRzuS3hc5Nks9ITjxX9qq5C1
	 NfWa44BBUz93xjk2JDyUK04+/g/TkqmXywzwR2mcKXms6qVsBbn9psFNgoAqsDT8Ym9Tv
	 YCZAlTgJxRz/GMNF2pBWF14MBPdzf7N0aTno2cziuEWmfUJ2v3AmJJS3U0U8PTZvvEA91
	 L+Iss/SnOb7Us/unMxczEiv+l36ZFA2ABqIcS/cDRY/S7oYBZ0HHBnRt7FMRtMlnPRxki
	 VjHYBC0jHMIfWmTSqYCTty4kWkB/+CEGt6GO4PPgdB0aZ5Qt9mRzmmi+iry1BWDCw8w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793007762;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=1VRakO/y2V/imlB//nrtX81eqpBhTcCSTPsMSK301oM=;
	b=1mahHldE43rKdP2UQ21erJGdX1I3FbcGHWtWpi/ggk1c1GVBHeOmL/ns/ewRymk3CuNP
	 A6jJ1uRKSLdNbVZ+5lENekDB8yi8SX74LQfmA59vevUps08pBnmxki8XZo3+Ic3y2a5v3
	 1WtqqZK2ziWy6UHHc66j8/dB3ZxDkL8IDxP8sxhubm/YwkC6ec0C6dSNTLQAebnXxoa7s
	 2OQpGldOwaZ7kQwW1TlEXHAyvaTCstewLeVWVW/IDbG/Nm57RR2b8BHHbeHeGyJLwLUcf
	 fZHN6wE/11vmoZ2FFilyzoUY+xy9CBFaKAmXKBE8XhUrY7I7kLNoyJmfXNXMjjtikNQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=gar2JInB;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.169
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA7F606A33D
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 09:42:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BA7F606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=gar2JInB
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-8a05e3f0d23so1078859b3a.0
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 02:42:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793007760; cv=none;
        d=google.com; s=arc-20260327;
        b=mk3Wu8KqrhnxOuKB7uPfCE8KtvXpJUomaOxkWpRce5wuRz9EhkS8uXeH1W1Zar2ZTz
         S8MK4QnDmgqMMlQmdC41tdU+sED5R7WOJDoVfC0fIk9CDlqN+uEo5J1DvaphwZR5ba1B
         F72FpeFNb9+NiSe7EmoxwPIq4Kk9zUBJOAq4WD1buBKqRy+KX+KjcbinGbWgYRntVAWJ
         rnrWpAK0gmCbZ4x1LWIY0wuz7e+UCfgLWZp41AKs5cy7sxClWZbBhZiYC+nDKTvZWSQ2
         Ii42YhsijKxtbGQbjVyI32bQ6dufqMec0J/KZMoWEFhhZiaKQAoOrbVoq/NopQxRPgL5
         svZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1VRakO/y2V/imlB//nrtX81eqpBhTcCSTPsMSK301oM=;
        fh=KH6pubcg8crNZsy+056e8LwHKXhZIQf6v1SS6bAeJ4o=;
        b=eEmVJjUyhFCuX/P7jofCPevANFltl5s+IeBKP8Z6bumN/ajM1+paALXZn5d5osQdjG
         HfEeiKrHckMB2TUo2rAlMoJG0n8uIv2mb1gFWZqWPdwDYop1Jeap+Ei8GtDji1Ny38NY
         m3HaJ26Pri8FwXSkJ/64rVdVEwUk0pr83Qs0swk/MZv3ib9a1CxgPT3adnr4Cln7AdWo
         3qfhli6GEAPuxQbUHnuCpPvRiu3WbMeyzDz7u/nPr2jCFIxQSsyEox4KOVBIbUFbeL7T
         3A7hXh5340yYtvlVVaQAKdnEKhLT5vmuXUvERncDadgwYCC3QUcZ/C+ke/FWkWO8ymh5
         i8pA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793007760; x=1793612560; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1VRakO/y2V/imlB//nrtX81eqpBhTcCSTPsMSK301oM=;
        b=gar2JInB+M76BqbODcIOXxlJnq3tSDd19K2qpCcyaviUtM2G5S07P3d52nqVQaf1xG
         pOh0H7fE0/HPV312lVpfF7fAhzhasaRvifGghH9BDzayU1caz1kixISBjjDoxurZu8nc
         39j3MAAK+kmb4M3e5mdaPteD54+iZ3S9yPrXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793007760; x=1793612560;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1VRakO/y2V/imlB//nrtX81eqpBhTcCSTPsMSK301oM=;
        b=HPPgwcqsUcyqw2soiijRJV9SFSfty7URChD7Ckyr5LW6ogtJUWbVQgcHUyBWVgFOV5
         4CbGnnCsw5BY7kCbofOvLXiGp+gjOuVAlHCGoub5yK7ChqwvBc1JTjxz3mGhzOO0uvCV
         mdTqx4XyqugFHFP4eXa1Vye/RpyaZ+TUzJBOoiahOPJeIielLoieEeAElpKzdT54sGhd
         ojZ0kwi93SMvTOUDWsONUwICMjXGql9gVa6u3OG45nDwZ8doKJqaCY3S0tVQcsqpUOnJ
         V0q/VQf1gIr3KZ4flcmoiv5tRcnoVTIsxI6eA3FqZcvgTP/KeaVwh7VHYSji3HZVZaF7
         gaIw==
X-Gm-Message-State: AFq9FYIX/1PVoc4wp5qri1Ls1BVZgMDl2luS7fRu9FQSxEAcuaUAeN9O
	/DpmwmD1pSRGE3nxfm2UsF5OZ1+s/0GpQomr3WrEbCBpW1loAKtXR9YcmbkxgEwMHidK4B653eY
	s+bq3yUzcIL5dx9jmgl4RubQZTONjCtZR/qDJ9sNNPtgaVMwcdTg=
X-Gm-Gg: AYBFou1iOTB5zB5VTcnrX3IIWRHULYYLLIU0wRxZh7pIBoh4oxOUib+EIs3bGOY8vtj
	CQBWh9ynAfIf9ZEUqwvYkoLXbZEMM0EbSDyETT4YUKrQrtGhloVH8IyUYxzd0SU4Ji+UGt8gFY4
	RZm/n+UCp9cAbEOW4Sc6ZaW1eq1FP1vRJMJvqPjovq2BsmMjufx5PtMFxbp01WcoxCuH9x//fRv
	xTatylelByx53ggr4G5z8iSbLS5Wzy04T3tTcutfcu48sQE4T1447nkG64Hy9zlWitTXehQu7qF
	qbBG6wzzabAXohxMVCgzEikta2N+QO6QAGn9ERllKHE5l/HVf9iRBBUS12knjCIkR8j4ifWp0cM
	G4xPNNgFZBUPI5R6RLYmUp5KX2McSZQOg0jvu6k/OtpEYsRnbdvr29X36OjBDvEDhbLWYZtOKaC
	hPHSu6ljOYkb2+eLY=
X-Received: by 2002:a05:6a00:2448:b0:8a0:7677:c8c9 with SMTP id
 d2e1a72fcca58-8a367a2f8efmr5287454b3a.51.1793007760427; Mon, 26 Oct 2026
 02:42:40 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ACT-N6N4.v3.r0.20261023200137@mojatatu.com> <ACT-N6N4.v3.r0.20261023200137-1@mojatatu.com>
 <ACT-N6N4.v3.r0.20261023200137-2@mojatatu.com>
In-Reply-To: <ACT-N6N4.v3.r0.20261023200137-2@mojatatu.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 26 Oct 2026 05:42:29 -0400
X-Gm-Features: AclHuK9Kbj8dxBWyUQ9ZZzVwC1rYp76rQKzNYxfRgPM9tqs42Y9bAdm-hXSXTdw
Message-ID: <CAM0EoMnjxmnoZ3a4XCB9YERcCwYhYW8-jKw1UZ79YzhFct9+KQ@mail.gmail.com>
Subject: Re: [PATCH net v3 2/6] net/sched: act_mpls: pull the inner Ethernet
 header after POP
To: netdev@vger.kernel.org
Cc: Jiri Pirko <jiri@resnulli.us>, Victor Nogueira <victor@mojatatu.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Martin Varghese <martin.varghese@nokia.com>, Pravin B Shelar <pshelar@ovn.org>, Vega <vega@nebusec.ai>, 
	Willem de Bruijn <willemb@google.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 24, 2026 at 10:28=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com=
> wrote:
>
> The issue:
> When the configured inner protocol is ETH_P_TEB, act_mpls POP can leave
> the inner Ethernet header in a page fragment after skb_mpls_pop(), either
> on an L3 device (mac_len =3D=3D 0) or chained after act_vlan POP_ETH.  A
> following eth_type_trans() can then BUG in __skb_pull().
>
> The Fix:
> After the pop, pull the inner Ethernet header into the linear area only
> when p->tcfm_proto is ETH_P_TEB; drop the packet only when that pull
> fails.  Other inner protocols (IP, MPLS, ...) have no inner Ethernet
> header and must not be required to carry one.  The pull is a no-op when
> the header is already linear.
>
> Conditions to recreate the bug:
> - egress tc filter on lo: action vlan pop_eth action mpls pop protocol te=
b
>   (chained), or on an L3 device where mac_len =3D=3D 0.
> - AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=3D28, and a non-linear
>   eth / mpls / inner-eth frame.
> - The inner header is in page frags; a following eth_type_trans() can BUG
>   in __skb_pull().
>
> Fixes: 2a2ea50870ba ("net: sched: add mpls manipulation actions to TC")
> Reported-by: Vega <vega@nebusec.ai>
> Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c0f7c54fb7e88e3b.=
1782548651.git.bronzed_45_vested@icloud.com/
> Link: https://lore.kernel.org/netdev/CAL4WiiqSMdYQYeeW0Fk_GK6ekR4xiS4zPrG=
KrbB9wZknpqf1-w@mail.gmail.com/
> Link: https://lore.kernel.org/netdev/willemdebruijn.kernel.26d1ddb3bd2ae@=
gmail.com/
> Cc: stable@vger.kernel.org
> Suggested-by: Jakub Kicinski <kuba@kernel.org>
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Suggested-by: Eric Dumazet <edumazet@kernel.org>
> Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
>

For the series

pw-bot: cr

Eric, you are reading this? See the discussion with Willem.

cheers,
jamal


> ---
> v2 -> v3:
>   - drop the pre-pop mac_len gate.  The pull is a no-op when the header
>     is already linear, so the gate only avoided a cheap call (Willem de
>     Bruijn).
>   - restrict the pull to ETH_P_TEB.  act_mpls POP can target IP, MPLS,
>     etc.; those inner protocols have no Ethernet header and must not be
>     required to carry one (Willem de Bruijn).
> ---
>  net/sched/act_mpls.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
> index 4ea8b2e08c3a..35a6d27f76a4 100644
> --- a/net/sched/act_mpls.c
> +++ b/net/sched/act_mpls.c
> @@ -79,6 +79,9 @@
>                 if (skb_mpls_pop(skb, p->tcfm_proto, mac_len,
>                                  skb->dev && skb->dev->type =3D=3D ARPHRD=
_ETHER))
>                         goto drop;
> +               if (p->tcfm_proto =3D=3D htons(ETH_P_TEB) &&
> +                   !pskb_may_pull(skb, ETH_HLEN))
> +                       goto drop;
>                 break;
>         case TCA_MPLS_ACT_PUSH:
>                 new_lse =3D tcf_mpls_get_lse(NULL, p, !eth_p_mpls(skb_pro=
tocol(skb, true)));
> --
> 2.43.0
