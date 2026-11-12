Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515633;
	b=4B1OnCrKAl7w4H92zAkJyro7gta68DIBcM1pbmzmRQa33rd2jVQFulZiCtmgbw+StOdv
	 Opaiim9J65q3b7cmf3Kl1IHCBn/zJvaUEyGhVz/OVl1RHnaATiU+3Xe9NSWvornL3qgYm
	 roin45yKRUePOYbcfYhYS8Q35bxhUAxoHlt/i5DZqvUQ29Hvbsj+PZnqEv+75o4WvVWNK
	 J6JZlayijNcAHveFErnbolDhKvmJQgaa31wCZ+xPh8rAbRnbrWkXSn/ud0CETGF59asaD
	 hDTuB/lT8bfaL9/3jIx4PlSPySQVye2ex+8fraJ7P70oIzHnA6WddNSGRw7O7xiXuZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515633;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=SJVo0kq9ZIhx2MTsLF5tHAHH/u/EXnQs3SWVLemHcVA=;
	b=pS1KruQ/eeoO3eDuo9Av5JcfBNh+SHEOHgEgd/Xe0xmnUEU6xTDMGkuvyll8Czf5hFTU
	 54OkJpgjFX6K8I1Aif+ABGG/GbZigKo5iPXsR3kDzE0xzEf1Dl/9gC56vgwESEAe3zu+P
	 vHdT4w54DKZiwsUlLMjAUTkEtMbun8u3PvEiiAWe7hZvX7D10rlMDkmojlZFVsVFX+7e0
	 vuaUeVNQrqDMCd3L9cOcfeGG5AffGxZ+C9OQN6Gibhu2DzismKQZWaqKwDVcZ1bsYU012
	 belMH2X0Il4j1LRtMijKlYeDMWhKSPVaN7D6Tpc8BKDjkhsKJO1bRUhIgV/Rop6sxzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ABY1QDe1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E04606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 20:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ABY1QDe1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A131F000CE
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 20:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794515633;
	bh=SJVo0kq9ZIhx2MTsLF5tHAHH/u/EXnQs3SWVLemHcVA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ABY1QDe1LbATdjQXJ0YDtqjHxt1pdNX1pK2YtHFoyHiXlyIJIohHPO4bvowxjvoms
	 tj7mnzBniHa3k6hiP8UeF4BM+2l+LIFHJThskZPImspxdCw7D5qzcIDdm1Y5i1KLMn
	 FkBQZTI7p1e8wsAPTsUwwGYuPnJzPYN6vCvop/RwszV3wRFF0135wwmQCYRuLZa5Um
	 pYhIKbPnt5OMPvn4woWtsqnW8aJCeKth5cUKM4wzn+uankNC41I5AnsmOo8/OJ+rS8
	 /6SlyZ1Get56Ia0UNcrxoj7+2+jvsUa8xqUnVfDDRvp7V6WlH2O2ggJX+QEWDySPB0
	 ZNiD/P/9KV5Bg==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3ae0eb56ba1so1658351fa.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 12:33:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErHEih/AU0FLNqJ8z8t52VMk6Uer0f8ckYgy1Aylu73HuU+tKnlVu1aZBJd/HfROJh2eAJr+6VY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9HqFpLPI0/X/XgBVp/JGT+5RkCr5p85yjjsAAzigqFbC3MH863
	/XH+v0OEILJ/91vexlRl2jPbJBppo5l1WIpiweFdmkL3TnOlJjEVyw159FeKzXHIe80IK7rczyv
	vG7oM0uNsI97rd51JX5O3BmlOLSJ/PeI=
X-Received: by 2002:a05:6512:31ca:b0:5bf:aa60:26ac with SMTP id
 2adb3069b0e04-5c170a27234mr168752e87.67.1794515631894; Thu, 12 Nov 2026
 12:33:51 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112-rtl8365mb-dcb-ingress-v2-0-f8e6fbdf8c99@pengutronix.de> <20261112-rtl8365mb-dcb-ingress-v2-8-f8e6fbdf8c99@pengutronix.de>
In-Reply-To: <20261112-rtl8365mb-dcb-ingress-v2-8-f8e6fbdf8c99@pengutronix.de>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 12 Nov 2026 21:33:39 +0100
X-Gmail-Original-Message-ID: <CAD++jLm2d=xRZm1deNmi4J5AgZy1i1yqKFd2pTyJXQ7vnp2ZsA@mail.gmail.com>
X-Gm-Features: AclHuK9yp7a2NrLjfOQFqjSofozhv3Qv7luLwSklQKps2cfMM_xtltmfP-EWkW0
Message-ID: <CAD++jLm2d=xRZm1deNmi4J5AgZy1i1yqKFd2pTyJXQ7vnp2ZsA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 08/10] net: dsa: realtek: rtl8365mb: program
 the PCP of untagged frames
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Luiz Angelo Daros de Luca <luizluca@gmail.com>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 9:37=E2=80=AFAM Oleksij Rempel <o.rempel@pengutroni=
x.de> wrote:

> Program the PCP that the switch gives to untagged frames whenever the
> port default priority is set.
>
> With PCP trust, the switch classifies an untagged frame by this value.
> The value is 0 after reset, so untagged frames would be Best Effort
> whatever the port default priority is. PCP trust is added by "net: dsa:
> realtek: rtl8365mb: offload DCB apptrust".
>
> The switch also puts this value into the tag it adds on egress. So far,
> an untagged frame that left a VLAN-tagged port carried PCP 0. With a
> default priority set, it now carries that priority as its PCP. The
> standards require this:
>
> IEEE 802.1AC-2016, 13.1: "The priority parameter of the
> M_UNITDATA.indication shall take the value of the Default Priority
> parameter for the SAP on which the MA_DATA.indication was received."
>
> IEEE 802.1Q-2022, 6.9.4: "For untagged frames, the priority parameter
> signaled in the corresponding M_UNITDATA.indication is taken to be the
> received priority."
>
> IEEE 802.1Q-2022, 6.9.3: "The priority and drop_eligible parameters
> are encoded in the PCP field of the VLAN tag using the Priority Code
> Point Encoding Table for the Port". With the default priority
> regeneration (Table 6-4) and the 8P0D encoding (Table 6-2), the PCP
> equals the Default Priority.
>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
> Changes in v2:
> - New in v2. PCP trust needs it, or untagged frames would be Best
>   Effort.

I really like the patch and the very helpful commit log.

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
