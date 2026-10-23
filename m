Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792760493;
	b=C9Wd+DO5G1c7u7i3nnwxeH/zyy6DYMJlDZC6iwVw7UAiEBoupkau7Z70QnNmBqqZsaP5
	 XowvrLiMIskYwbUEUYKjlrNxpdtiNTeUX8e8Vh50Qtu4JxUL1VyDSZSmD7yC+TwYHZlme
	 CVBvd/KI2Og/DxQ5+jOZ4dZrOpSJQlZjk1blPwREXf4HP72bBm1rx98LRyNgYXTogOmLt
	 XnikXmlNKxBDa7gafg9fm0PsplG/kbKV12Bnwmf5YlLo+UomHZV5IfTPcN3hEsFC1KAcx
	 /pxFLlGNS0BEHFjjIWWj4Bshu1eKAaxN5lVCjB8O/oOPvs7Ey5bNjj4jXs6JTlYI/vg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792760493;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=zW/Tu6G2P143M5yOiwqhQlrPzgSe2ppBT7C/fkz52fE=;
	b=VNpXKfUwvQRbviqoDgNIal6L369/fLwsCN0xx/euO8a2XIGnAFGfLGeCLws6xq05BIjr
	 XZA8M1PtDSBMaFsPVosh7PoTJWb1eWhWtXCrluxmlR7jjq6aP0CXF5STpT0ImRv4Vw3o3
	 PO0MSNIZ15XV3RMJg/xDuwtSdsf+XKz1Dh8NFJiDSthWw1Cr0bIMP6qCcVS1kL8C3CFmq
	 YtVFCR275autJ1KWfaIOPZ3wbie2BEv2XcT8lx0Hlr9uvWQFsE2xButMWTMLf2W1cUVt4
	 XsECLiu4AHJOrfJvNBKuWK9AZwF/HIeoJoq10etAPKwuYhcJbfdf8QLM5jlWDJo1yVQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mgpaWphN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF2F606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 13:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mgpaWphN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA3661F031E0
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 13:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792760492;
	bh=zW/Tu6G2P143M5yOiwqhQlrPzgSe2ppBT7C/fkz52fE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=mgpaWphN+KbA2Dbt2SqY6GT75J1EmnwjkTpCzBcp7sEwG0NWjKfvD1pyIbZU1WQ9M
	 bZDHG0Xq60r0XGrJpxxiGPi//3E+EZgB1xyxiaplLOsi0SOmCDixAd7I+zP8NG4e2C
	 ABKG7j6Ld3yqJ9/R2lEa8FsWGEz+Q3PTCSQgb2b2cXFpLzDpxkhTV7oeRGVTqYE62Q
	 ndx21hmdIuyzr4xrp+SvEnIU/dW41cybPbvCy0WFrcvXU2CzRoIzBUpojD36mHWgSQ
	 JwFzVcqwr8KJ4RaKxPTZiurXt5cqybWj7B2cdRDmXZE8W6VCeJsjtYz+M1qYmAa86p
	 yFI8N6posa1TQ==
Received: by mail-oi1-f179.google.com with SMTP id 5614622812f47-4f55a53898cso414315b6e.3
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 06:01:32 -0700 (PDT)
X-Gm-Message-State: AFq9FYJHxiySfswxg7rbdIXO8jFSKYmJk26ywUFpzXz/WZJ7vbSE1hTP
	0kcz88pri5me+KmPmG42EsJWj5EkUqcr1pBECXkuxswl6xCzUWCbbsiKO/RORqvQBptsTerwdGA
	S9l1qRUlYXQtosRbbaXL7zWVhB1zs40s=
X-Received: by 2002:a05:6808:c3f3:b0:503:8f9d:f11a with SMTP id
 5614622812f47-55be83732famr1312266b6e.29.1792760492126; Fri, 23 Oct 2026
 06:01:32 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ACT-N6N4.v2.r0.20261022191829@mojatatu.com> <ACT-N6N4.v2.r0.20261022191829-1@mojatatu.com>
 <ACT-N6N4.v2.r0.20261022191829-2@mojatatu.com>
In-Reply-To: <ACT-N6N4.v2.r0.20261022191829-2@mojatatu.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Fri, 23 Oct 2026 15:01:19 +0200
X-Gmail-Original-Message-ID: <CAL4WiipmpDUeT3au2yPQFi=is1tiMZRTd8SuD+14n_09gFfGEQ@mail.gmail.com>
X-Gm-Features: AclHuK_emv7YwmEpyMuOD169Cb1tzAQTRU7DNCg5vkj8MB2QytjcxoGYSV4Q--U
Message-ID: <CAL4WiipmpDUeT3au2yPQFi=is1tiMZRTd8SuD+14n_09gFfGEQ@mail.gmail.com>
Subject: Re: [PATCH net v2 2/6] net/sched: act_mpls: pull the inner Ethernet
 header after POP
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Martin Varghese <martin.varghese@nokia.com>, Pravin B Shelar <pshelar@ovn.org>, Vega <vega@nebusec.ai>, 
	John Hurley <john.hurley@netronome.com>, Willem de Bruijn <willemb@google.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le ven. 23 oct. 2026 =C3=A0 13:59, Jamal Hadi Salim <jhs@mojatatu.com> a =
=C3=A9crit :
>
> The issue:
> act_mpls POP can leave the inner Ethernet header in a page fragment after
> skb_mpls_pop(), either on an L3 device (mac_len =3D=3D 0) or chained afte=
r
> act_vlan POP_ETH.  A following eth_type_trans() can then BUG in
> __skb_pull().
>
> The Fix:
> After the pop, if the original MAC header is shorter than ETH_HLEN, pull
> the inner Ethernet header into the linear area and drop only when
> pskb_may_pull(skb, ETH_HLEN) fails.  skb_mpls_pop() does nothing when the
> skb was not MPLS, so no separate state is needed.
>
> Conditions to recreate the bug:
> - egress tc filter on lo: action vlan pop_eth action mpls pop
>   (chained), or on an L3 device where mac_len =3D=3D 0.
> - AF_PACKET SOCK_RAW with PACKET_VNET_HDR, hdr_len=3D28, and a non-linear
>   eth / mpls / inner-eth frame.
> - The inner header is in page frags; a following eth_type_trans() can BUG
>   in __skb_pull().
>

Reviewed-by: Eric Dumazet<edumazet@kernel.org>
