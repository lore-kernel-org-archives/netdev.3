Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.170
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793010725;
	b=jbtwIx4fGkVmczjpD/1huVdboazVZ5EGSxa4BpDDommLc5yRQU/yUZviw0z8lWNP4AVJ
	 6TdrivlcIAMJndPLvI9n8gHR7YRB1lMBPeyiL03VXsyNC6ueCWkNlvCHRDTR447KaZYLM
	 X5HsMilCRO1Mswb0p6KlnIR2BZuTWHYVP14baYVUkO5sarOJgjp7vUDtUwMs4YA3pobAs
	 67h8uUahI8eMB4W7bptOphsKp8yUirHRuBMuf61eaSsQgohcNvWGCZm5cV37v33TPSbdN
	 ziYIjzOF1B1k3TVoHCq/18VjA+W7f06W4oH/vsVOz9mtmU8a4S77ZT36LnwQJt42PVA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793010725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=kwVoiFtZibPxzjC3HTNLln9OSCPJ9BfH6erlXGNSsR4=;
	b=e9jAF2uR4V2XB1DBiimkE3fP2NIkyXpq8XJKNU4uiAkbevhlEdfGMUIenHGptiEE8I5p
	 5GB8VJT8lIrvxvFmbx7F5BbCiAm4cFV8g039OpCGinzDm9zWigIa8kEvOKKuL9jzo+8LI
	 1yugw3Tv6R347VjIxYBk+oBceqr/H3y8+ySOoNs/v+bqEHjkO1YI13xU2GuklkUhBvxwg
	 f5+1FENf/GW1no/BHhBES3h93vESxzPa06i3awDYtdYgJcNYBlByDq6WqEj9Tz3POUvOz
	 t8LX4wvICj8C8tUaIqEtrnkNABmwtacfWQSujmWGH0lFeTEtnp9EqpN9VEOB3jUod6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=H7Gfj7eT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B17606A324
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 10:32:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 69B17606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=H7Gfj7eT
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc4aa18f9afso1050434a12.3
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 03:32:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793010724; cv=none;
        d=google.com; s=arc-20260327;
        b=Hbyoqqxrv5IhXxY0UVDmp3MCC5tLXWYGfi7xNW4XpDY1r57rvZy9K9iJ607PDWbsCd
         kLYfOkDk0Byj7bGbxmk/VOH/JQs2mENsaHax5i0aFt7TbUPzHKoxhzNyz5MYIanlMET6
         N5thqkwfNW5Nk1oyE5enrw9LVRyRo32ltgb7etHeoTjDcYKkEzoKkSKKAf4uQnAh+WSv
         UB2UqdvhIhmVf+Q9hI1lzJI5kOkm/KOrOPuuGs6x6S76Es1sPgj+tzEsNFdMJJDRsS6l
         V3p+SZr5rHtA1qc41QDWoLCVpr+gLNTxMh5ke51E9K9TMfvD/NHwZ3vB9lPM8OwzNmVu
         Lg1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kwVoiFtZibPxzjC3HTNLln9OSCPJ9BfH6erlXGNSsR4=;
        fh=KH6pubcg8crNZsy+056e8LwHKXhZIQf6v1SS6bAeJ4o=;
        b=s6R4AUh9cGTdTiovtKUFgio/Iia+eq3+mKByeBJ3Yp2ZtYX1+WQcZOBDfXLIqMoH2l
         rszZDDNlO145vznKvjZVdMo64At5pfFKHyhMIiI7ZihynqCdlxSTJucLtD7DFcUk+lNj
         rVqsAIgrmGX3EbqIv4/YbaLxrsB0kInkYhrVRa1YOodXjx0w3ywfVKq6rk62NOGEwyU1
         piNYLiYmvufVpVivd5aK1tAJuS4XNi5I/d00RcxE54gXhIV65AUm82QcUcP7VOvTZApV
         ubrKJ3WYsZco26M/pXirO4dLIdmQjdKiDwwDz1FR1Yv9l6sgA2/CmsH/Xj2KP+P3tRLD
         8ZNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793010724; x=1793615524; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kwVoiFtZibPxzjC3HTNLln9OSCPJ9BfH6erlXGNSsR4=;
        b=H7Gfj7eTuhByc7aUg+GCjYfRMu8fFjWC/14n/SesDTH4yD28GvwqzBxHrCVlBSgT5z
         /T5mZnJ4gfDjFipblEdlAVU8pZamVerjmEIET2rM6Ux/aB0/M6gEwDSLw/Puyeonx08j
         I5qyDPVUMWKdTttVLVbdePuxM4zaRryuOzea0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793010724; x=1793615524;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kwVoiFtZibPxzjC3HTNLln9OSCPJ9BfH6erlXGNSsR4=;
        b=ZVMofefnByEXu2EZilKfVkJLfnkbX/Xbo4MANOcDeV5aXvotLLWGLiL6NRGK1rRUuj
         k1yun7oBz5s7mtev09qVqQJWWcPnmN7MQ7hPYVLN+KIogNNLuF1PB4cSfom9vejLFZAL
         Rlgik0jRoLNm1I41fywY6UlD4N1fM6Pjn1RFb7j9cKQ9v5iD4WQLqTx9MA5VrcRrvEz3
         SF6I/BjljU6tbSJa4hKc2Otu8WcU9Z6/AnNA3Z9DrquNKRx9ysch0hWaP0wnTn/BC5dy
         IamvmXmt1UsJcquaA1ubMWk8vWk1rCinY3AD0MqHNsNHRAFN7poPXS8fXZ5RXyKoXx3u
         GxQA==
X-Gm-Message-State: AFq9FYJh1guXaD096y+orABh34bT5HSCdFwDbu+3GBUzfy8dlmSzm7vz
	K+62Ay89a3vDlQahpIoTeBoifwQXqp++P8OQJHY7W0BlXCGILcxvK7TmciOK9cQX4sELm2z+Q26
	gvHSGz22sbJnr+AP4XIwzLA361+cVO4QAhKCk00J252R+q4GSD/Jsyg==
X-Gm-Gg: AYBFou1/3gssaX38LZA4FVFJsA1CXMX6iLd2HRLTRqQ5SOaQ6sjsh8gtl3IykSSLp+6
	TNo2Mv+NjqErUZMlI9KxUWBKUTayZbHjiZa/E+X/OP+WamvKHAGnNbBZF8912w5Pham1hWEuH7C
	fWeqtJchTG+Gd2lUtg9FnhInJoEmOv5oEoIqJjIwfF6KcO1n61fvnw0UoKsBnXn67Qg0fOBJW89
	s7Bmp6KzVXdq9AIjgB+jF6WKmByx2Px5E59gQz1q+Z0VYqz2ZzASilB7BU3HrIV8yrd9LYnNxQS
	TQWo23dxxK9CAQjHJWKY+25twnajvKyQHvExqgMPWOxF9bABYieJZaYolfje2iQM2gzqVcDohQI
	0LEJ2Zo/A9S88PHr/zp5XMKx6PJgNZJJAyFVLMnMslZy4wHM2ePE9FbVi1WotlIVatBzYKlLaxW
	PLQUFn1ffQZVdlW9gK
X-Received: by 2002:a05:6a21:6111:b0:3e2:86b6:9bf4 with SMTP id
 adf61e73a8af0-3e7bfa64eabmr4670051637.14.1793010723749; Mon, 26 Oct 2026
 03:32:03 -0700 (PDT)
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
 <ACT-N6N4.v3.r0.20261023200137-2@mojatatu.com> <CAM0EoMnjxmnoZ3a4XCB9YERcCwYhYW8-jKw1UZ79YzhFct9+KQ@mail.gmail.com>
In-Reply-To: <CAM0EoMnjxmnoZ3a4XCB9YERcCwYhYW8-jKw1UZ79YzhFct9+KQ@mail.gmail.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Mon, 26 Oct 2026 06:31:52 -0400
X-Gm-Features: AclHuK_YrqRHix7Mh3Yx3ZLSjmRZLvRAdRI9H3tduLWZxKVLN31oQ0yauHEq9G8
Message-ID: <CAM0EoMkct9bMMZHPRKh3xZ-L5GTX0SeLdnp_NQd+C_QWspHW8w@mail.gmail.com>
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

On Mon, Oct 26, 2026 at 5:42=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.com>=
 wrote:
>
> On Sat, Oct 24, 2026 at 10:28=E2=80=AFAM Jamal Hadi Salim <jhs@mojatatu.c=
om> wrote:
> >
> > The issue:
> > When the configured inner protocol is ETH_P_TEB, act_mpls POP can leave
> > the inner Ethernet header in a page fragment after skb_mpls_pop(), eith=
er
> > on an L3 device (mac_len =3D=3D 0) or chained after act_vlan POP_ETH.  =
A
> > following eth_type_trans() can then BUG in __skb_pull().
> >
> > The Fix:
> > After the pop, pull the inner Ethernet header into the linear area only
> > when p->tcfm_proto is ETH_P_TEB; drop the packet only when that pull
> > fails.  Other inner protocols (IP, MPLS, ...) have no inner Ethernet
> > header and must not be required to carry one.  The pull is a no-op when
> > the header is already linear.
> >
> > Conditions to recreate the bug:
> > - egress tc filter on lo: action vlan pop_eth action mpls pop protocol =
teb
> >   (chained), or on an L3 device where mac_len =3D=3D 0.
> > - AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=3D28, and a non-line=
ar
> >   eth / mpls / inner-eth frame.
> > - The inner header is in page frags; a following eth_type_trans() can B=
UG
> >   in __skb_pull().
> >
> > Fixes: 2a2ea50870ba ("net: sched: add mpls manipulation actions to TC")
> > Reported-by: Vega <vega@nebusec.ai>
> > Link: https://lore.kernel.org/r/40fe2d7dfce13411bfbe9271c0f7c54fb7e88e3=
b.1782548651.git.bronzed_45_vested@icloud.com/
> > Link: https://lore.kernel.org/netdev/CAL4WiiqSMdYQYeeW0Fk_GK6ekR4xiS4zP=
rGKrbB9wZknpqf1-w@mail.gmail.com/
> > Link: https://lore.kernel.org/netdev/willemdebruijn.kernel.26d1ddb3bd2a=
e@gmail.com/
> > Cc: stable@vger.kernel.org
> > Suggested-by: Jakub Kicinski <kuba@kernel.org>
> > Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Suggested-by: Eric Dumazet <edumazet@kernel.org>
> > Reviewed-by: Victor Nogueira <victor@mojatatu.com>
> > Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
> >
>
> For the series
>
> pw-bot: cr
>
> Eric, you are reading this? See the discussion with Willem.
>

And to be clear, I am suggesting we fix both the producers and consumers.
Basically, as established, producers alone cannot protect against the
eBPF  privileged bpf_skb_adjust_room(..., BPF_ADJ_ROOM_MAC, ...) or
bpf_xdp_adjust_head() which can re-shrink the head after any producer
fix.
And then we dont have to do this ETH_P_TEB check here.

so i am officially withdrawing this until we reach some consensus.


cheers,
jamal

>
> > ---
> > v2 -> v3:
> >   - drop the pre-pop mac_len gate.  The pull is a no-op when the header
> >     is already linear, so the gate only avoided a cheap call (Willem de
> >     Bruijn).
> >   - restrict the pull to ETH_P_TEB.  act_mpls POP can target IP, MPLS,
> >     etc.; those inner protocols have no Ethernet header and must not be
> >     required to carry one (Willem de Bruijn).
> > ---
> >  net/sched/act_mpls.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/net/sched/act_mpls.c b/net/sched/act_mpls.c
> > index 4ea8b2e08c3a..35a6d27f76a4 100644
> > --- a/net/sched/act_mpls.c
> > +++ b/net/sched/act_mpls.c
> > @@ -79,6 +79,9 @@
> >                 if (skb_mpls_pop(skb, p->tcfm_proto, mac_len,
> >                                  skb->dev && skb->dev->type =3D=3D ARPH=
RD_ETHER))
> >                         goto drop;
> > +               if (p->tcfm_proto =3D=3D htons(ETH_P_TEB) &&
> > +                   !pskb_may_pull(skb, ETH_HLEN))
> > +                       goto drop;
> >                 break;
> >         case TCA_MPLS_ACT_PUSH:
> >                 new_lse =3D tcf_mpls_get_lse(NULL, p, !eth_p_mpls(skb_p=
rotocol(skb, true)));
> > --
> > 2.43.0
