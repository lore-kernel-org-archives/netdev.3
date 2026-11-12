Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515756;
	b=ySimua4+WWfy5bmmrUlvOAvxFQg6TWRHEr/ZhYoXUT+rGZdk0T+/Vg37LCkBOkzGuAkn
	 GsN3k7ArPhDLtmpVHUuUSmTAl4vPPHP4Bgxn0Pk2TpOMfF4kmo+nNaQFbcl0fPmHFWJ8D
	 c78GSbWvrqlKWBlm3q7XOPiQzVR8QZEuQntws9Te6qfHTO95sg4sG50e6XrZ8p4ZK4hHf
	 ALF+FbDww7NfMkw+x4RUL5Roi/0Xk/ItfDmThcR+sBxez8Q2lQYc7DuL3Wdj1wZ4dwHS9
	 s7Wp3Iqn8R8GUV1OvGsn2LcKQL/oOK5zskcMnFlclg/dp6matgEFCdLgydR9KzA2XsQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515756;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=6nnQnFl772x0ttUe5n0YYK5lmJ4sIS9Uyk55NkUhIc4=;
	b=5UUg6pvvykURfiWgwH0uzi2WinWgRjGkfQQc7mBUCLEuiXcMhxWK/mT7YpdbMTNarNyB
	 nWhAbeEkh/AcH8H84GBr7/3Ds4yrTyAuFJRYjx7XWD+xGPkh3j7AfuSwGHmPlDMfJZL/V
	 X6U3V07g8c+D5vu6FciA/4ZVfI1Y3YD6cWLChGZVz/0NkSE2syrQtSZLLO/YuuffuAsls
	 KnLXK8iZ7YrYAjly3CH1FAN2IIaWveEwe8Ucx5ZSRA+6z/hKtugWBIDkzOdu1HJp1QOWt
	 qGEGzwXDII19IvE6MYN4ZSPtytuuEhpgCKnv2AUlqCecJ0+UXoK+C2bO5iGy2h1mWTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bcbRho79;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDADE606A323
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 20:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bcbRho79
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927E31F000CA
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 20:35:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794515756;
	bh=6nnQnFl772x0ttUe5n0YYK5lmJ4sIS9Uyk55NkUhIc4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=bcbRho79og5+TrQo9mGVyPrV7+u0qubmPkZytHvLGZsm9an4QzBix04Di/VU6UVeI
	 y8mIow9HaoTxdGPzeJBHdyQytGyy7AM9YZepZrfQ/dB/qrOOtGC+lmwkDvBtiwrRfj
	 Ic3eZVTMc27Ij82dz3cDaxyApb+CVN0fsA90FYV9KXGCShqccyWQ8HUrebqOPf1V77
	 kCcP7AMu/NcbzhHfJRyOwJVvAEHvGyW46jfUgK8h+Pf58LMbxqm+ZaMqUQWF/7c/Dg
	 JL3zP5AvQFqg8LTH67rkx5LBCus/aQRR9wFnfQdePozRbZ+aCA8F1Mf/ZA5bVIGkLT
	 XhFFLamz/hhhA==
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-5bfa7c09c9eso218354e87.2
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 12:35:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGXXU5JlnjQAJgei7mW/F9Wu9LBw0vi2s/RhZfnqAqPQ/IDZ5TKAlfXr6BPvZpkE5XnuBBFwk8=@vger.kernel.org
X-Gm-Message-State: APuU4Z+MdZWOvP+Bg+aP35sYNUB2G4QVvExSljzN66ax4+QUDGkOCcAJ
	SPQHjxadf6CDFIM5eIbnwEASwxGpmGHmUZA3D0hlnbuWzYldg2tOlR4YuVqPeE3Nfxzc7LpUoZa
	mTLDnjZnSUpyby9tYUY4AuYSAaCmzZyE=
X-Received: by 2002:a05:6512:1192:b0:5c1:5703:46f4 with SMTP id
 2adb3069b0e04-5c1705d8515mr195706e87.7.1794515755373; Thu, 12 Nov 2026
 12:35:55 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112-rtl8365mb-dcb-ingress-v2-0-f8e6fbdf8c99@pengutronix.de> <20261112-rtl8365mb-dcb-ingress-v2-9-f8e6fbdf8c99@pengutronix.de>
In-Reply-To: <20261112-rtl8365mb-dcb-ingress-v2-9-f8e6fbdf8c99@pengutronix.de>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 12 Nov 2026 21:35:42 +0100
X-Gmail-Original-Message-ID: <CAD++jL=EGaGXJCMGoTX-R5YU+OSU26NpbO3MBbr+yWBO0q6-yA@mail.gmail.com>
X-Gm-Features: AclHuK-MB5ZypNmDSpTL7UbjyzH-7DqQYw4we94SaKV5K5KPZVzBJ2hsaKf5r_8
Message-ID: <CAD++jL=EGaGXJCMGoTX-R5YU+OSU26NpbO3MBbr+yWBO0q6-yA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 09/10] net: dsa: realtek: rtl8365mb: offload
 DCB apptrust
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Luiz Angelo Daros de Luca <luizluca@gmail.com>, =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 12, 2026 at 9:38=E2=80=AFAM Oleksij Rempel <o.rempel@pengutroni=
x.de> wrote:

> Wire up port_get_apptrust and port_set_apptrust. The admin can then
> choose through dcbnl apptrust which ingress classification a port trusts
> for its priority: 802.1p (PCP), DSCP or both. A port that trusts nothing
> keeps the port default priority.
>
> In the driver's model of the hardware, the trusted priority-decision
> table is switch-wide, so all ports that trust something must trust the
> same selectors. While another port trusts a set of selectors, a request
> to trust a different set is refused with -EBUSY.
>
> When both are trusted, DSCP must come first. When PCP is trusted, the
> switch classifies an untagged frame by the PCP given to untagged
> frames. A PCP source ranked above DSCP would then hide DSCP from
> untagged IP frames. Refuse the order pcp dscp and any unknown selector
> with -EOPNOTSUPP.
>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
> Changes in v2:
> - move selector and precedence validation into rtl83xx-qos.c behind new
>   qos_get/set_apptrust callbacks; weights and -EBUSY stay here (Linus)
> - use one-hot decision weights; in the driver's model, the v1 linear
>   weights could tie PCP with DSCP (Linus)
> - define the apptrust slot order once (enum rtl83xx_apptrust_slot) for
>   the shared selector table and the backend source table
> - write the PCP and DSCP weights with one register update, so a failed
>   write cannot leave the trusted table half programmed (sashiko)
> - check that all apptrust sources share the one register that is updated
> - rank DSCP above PCP and refuse pcp dscp with -EOPNOTSUPP, because
>   with PCP first, untagged IP frames never reach DSCP

Very thorough and resolves my issues!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
