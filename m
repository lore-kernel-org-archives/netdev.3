Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794515818;
	b=Zi6+y0suw+9ZuE9G7K5M6U8PQAhIbSa0E02pPM2B0b+PcMxwJu2D8U4z5zg8QzRxWKTm
	 HQ5hy5FGNDJVSiGZ7ev3VCZ23xi5Bc4hC+PWL3p9OME1qH404772h7/5LK9C43CAirnAf
	 2CxTC9qJXapc0KttW2HTyxAGsBdsLwlsVGPgDj2TgSXhucS0qog0tVMKJGG/+IZrOzwJM
	 n5B2vjMFlu7k6z8oYkvDul8dkCeRw5N+u6QDVAavj8pZGiCJ86KdpJT6NtmYg8K0vPVds
	 QckG5awfEkHhWuVoO0dDGrCoVeNCMzWC02aUQMUC8dVcn56vjyCtH6UMNcNgLRrNbow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794515818;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=jTWXcQAEVRNiJ37CZvBOzUnHBbdFQM+hm9VF7G9FXek=;
	b=4CqhsUjEbcNapcHZfa5XJvfSq9/jYELEsO7TxH+gXbvoUtxl80n6d+9W+xtgzT9DSOI5
	 cmcmZ5wRQug5ZwlgCfuz+zAYB6wpFORsv4VXkHRwfSOiz6BeoBykg3pjeKKOsVSmUN66f
	 dbNVflVZp0VB/uG4oRnqdBxcPe1jlGVIAomgu8joqxSeA2VVY0XiDgP3/dLdpat980c79
	 WFVSGNoyh3NaEqyoAzw043YHyPHP0myjqQeaQ2CLGS9GtGquxBfu5KrfnvbO26xytPxZS
	 xbhW17VPb4te1fF8MFdgKlNnpwk8l/HmeC6dpexkaVquiLqeySWHeoCCmJIeo9QYqIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=joUWLRfh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D372B606A323
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 20:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=joUWLRfh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C0E1F000C7
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 20:36:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794515818;
	bh=jTWXcQAEVRNiJ37CZvBOzUnHBbdFQM+hm9VF7G9FXek=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=joUWLRfh/F4X2DVorHfnYB/IDXtZrEVITyXQl1zPB0u5DmL02wbZtZioQQ5t44sUK
	 gSTkiDM8CBitNqoExoE6NnAWgB8qikoG3mMUmzrbLyr71MATULfiYhhvMJBHtP5WDB
	 oJe6XZ/SKMxGhi6bEVcqm/ckQGm+tZBQupPU8YzWkn74LF1FY4ctk5+tRUhC/q5NSc
	 zkn/noi+FvCdBXzThJJ+GIY2WW5PW4uygJUiFpQqetBJ8sLzOYImiXwGm5tiAoesDh
	 j0dfkgb1K8vdJFqsfgy02nxdNZrrWTBF9HUNVdV+ZYXMjCJmzn+Xt/up5SkrJIQ3Zk
	 /1qKS7pW7qDyg==
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5c102ad8420so236455e87.1
        for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 12:36:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AL+hErGyENLq/LhCav/UhcKSYNLet5xE+/1ZxJCI+wRWhnr1BMqEpAdP/hyn098ZeMpi5nENe0Gt904=@vger.kernel.org
X-Gm-Message-State: APuU4Z8Ke/PBNxAYLJE/UyGuWAbq03zXnGn/mUhljI/IUR0+aTdYvKFq
	x2Wl6yDCw4vlk1i9yLRaFpmkwZelh8+dJH8hhnU9Jk/Qr5R9tAbOJELeEA6z7YZa8Y36bFLM0Kp
	IhWMpQwM+TGnWS6eRlVb7DE3GVcaL1h4=
X-Received: by 2002:a05:6512:401c:b0:5bf:b952:e57f with SMTP id
 2adb3069b0e04-5c170b68b50mr169690e87.59.1794515817248; Thu, 12 Nov 2026
 12:36:57 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261112-rtl8365mb-dcb-ingress-v2-0-f8e6fbdf8c99@pengutronix.de> <20261112-rtl8365mb-dcb-ingress-v2-10-f8e6fbdf8c99@pengutronix.de>
In-Reply-To: <20261112-rtl8365mb-dcb-ingress-v2-10-f8e6fbdf8c99@pengutronix.de>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 12 Nov 2026 21:36:45 +0100
X-Gmail-Original-Message-ID: <CAD++jLnuUdZeGz=rZyPayJEC2EK-RsKm7obecA7Jy0SETSD5jw@mail.gmail.com>
X-Gm-Features: AclHuK-6O1MZON6TJKg3hL1WcNrsf_X-QgpBux5gGIeVOIdYXCWrRn5tPX8QLAg
Message-ID: <CAD++jLnuUdZeGz=rZyPayJEC2EK-RsKm7obecA7Jy0SETSD5jw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 10/10] net: dsa: realtek: rtl8365mb: report
 the DCB DSCP-to-priority map
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

> Report the DSCP-to-priority map through dcbnl, so that "dcb app show"
> lists, on every port, the priority a DSCP value gets once the port
> trusts DSCP.
>
> The switch has one DSCP-to-priority table for all its ports, with
> exactly one priority per DSCP value. dcbnl, in contrast, configures DSCP
> priorities per port and allows several priorities for one DSCP value.
> DSA could mirror a change to every port (dscp_prio_mapping_is_global),
> but a request on one port would still change the classification of all
> ports. Keep the map read-only. The QoS baseline seeds it with the
> default mapping from ietf_dscp_to_ieee8021q_tt(). Requests to change a
> DSCP entry fail with -EOPNOTSUPP.
>
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
> Q: The v1 review (Linus) suggested DSCP get, add and delete callbacks
> in the common code, and setting ds->dscp_prio_mapping_is_global when
> registering DSCP offload. Why are add, delete and the flag gone in v2?
> A: The DSCP get moved into the shared code as asked. Add and del were
> dropped because the table is chip-wide, as the commit message explains.
> Without add and del, nothing would use the flag, so it is not set.
>
> Changes in v2:
> - make the DSCP map read-only, as the table is shared by all ports of
>   the chip and per-port remapping would change every port
> - drop the DSCP add/del ops, whose delete path could leave the hardware
>   out of step with the remaining APP entries (sashiko)
> - do not set ds->dscp_prio_mapping_is_global; without DSCP add/del
>   nothing needs its global set/del path (sashiko)
> - retitled (was "offload DCB DSCP-to-priority")
> - move the DSCP get handling into rtl83xx-qos.c behind a new
>   qos_get_dscp_prio callback (Linus)
> - DSCP table seeding moved to the baseline patch
> - read the table entry through rtl8365mb_qos_regmap_read_field(), which
>   uses field_get() (Luiz)

Excellent revision here, all requests fulfilled from my PoV:
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
