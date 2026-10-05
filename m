Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B41E4BD351
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 15:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791212650; cv=none; b=MhA9gzizWd8D1eycR4Sc0pSwMDGQlBOC3OGxjK57mNqqV5uCqiUOkY9dXbywrXCrePslA50IwcsF2IWYhXYNQ/1JAeEdSRU65khmreIm84ZpN7dLIkUKOkSDUlyPXZvT7wVt6ixn1Rm45xhwjFyAgpuKqHOtBWeL9v7ZacEzSUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791212650; c=relaxed/simple;
	bh=jc7nxP5Oz1XzCnbYXsWKT9BZRoyOhZWdxvaqptoB1Bo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IB6hAJalTX4JhggUxVLikng4C3tmImQb8bCEpLGoIcUiZ58Lg1/SUFEovq8Bp0xIH6JubULEL5HOR6Xixp2dK+PEegmONmnPLtjnGf8haicEQgFpVJs6Zs85MkMzCBUDYo+l7+evQezvyF5EDSjv9AA6jk64/sbEt+1IiSIXe2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SqOa1973; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SqOa1973"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31CD21F00899
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 15:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791212649;
	bh=aw69tHwVf0Z+1Bj0+BQjDmxAeteNgO/GsOUQkhR1JSQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=SqOa1973lrsomz1Me3sSgCRYJK1elZDNW+uXlij2h6dL8Y+dIkhEzYEidqGZD39ZT
	 OLLWdkP8OebMcdp+1Gi3FiJy77tK6BWYahEHvl6hkNxn78R+5jYZedrisDEc9fYACX
	 nnlqEhlXpAF+Vrsq+FaLKAdZhxFmV2U7IGFAUQANVI9lCuiNoUUa2A1eif7Ikk2ayN
	 pcwhtlxBISLk/F0HLqENegZhjqvz1fU4eNUj3blFkVgbDPSWdn9zkLNNjOCHgwsuZC
	 4YEUB03VMQCsIMDgUFTEC+p00La3feQKghMLi/RcCupauBxV9HZXuLI6REpXjpp/WI
	 xZr9FRpF6EKig==
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5bcc24e8fc8so761248e87.2
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 08:04:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwoGpb/AVIBAF3iv1MpKpXbyYjcGw+dwrAtbclyiK6/zbXkYR+5KE41E5tWwPr3jAtsV43xbKQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJzENgR66x/mF84GyaXAse5mGYj2H1MlQ9X1cRW8D45xzEfOHZo
	ZIMJ5HqV8uzgwsJIT5wrjlorXWB+LhGANQh3ul1gUkIGN9VweDY06j5WVcBmLJ8E0KjOtRdA5cy
	A2CHqKUu5wXckiTbzuU5CwfA5eA5XMrA=
X-Received: by 2002:a05:6512:32c9:b0:5bc:b54a:97e8 with SMTP id
 2adb3069b0e04-5bcb54a98e7mr2692560e87.17.1791212647902; Mon, 05 Oct 2026
 08:04:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261002115850.962676-1-o.rempel@pengutronix.de>
In-Reply-To: <20261002115850.962676-1-o.rempel@pengutronix.de>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 5 Oct 2026 17:03:55 +0200
X-Gmail-Original-Message-ID: <CAD++jLn_H40-37QOmNVKfkr3UP2X3AJ6NM31uSvj3gXrzY07KQ@mail.gmail.com>
X-Gm-Features: AclHuK9phD_N5mwQR1EVAD4seWfuKypkmQJWZniQyr1dd2R6ut25CAJJC50mRcE
Message-ID: <CAD++jLn_H40-37QOmNVKfkr3UP2X3AJ6NM31uSvj3gXrzY07KQ@mail.gmail.com>
Subject: Re: [PATCH net-next v1 0/8] net: dsa: realtek: rtl8365mb: DCB ingress
 QoS offload
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	kernel@pengutronix.de, linux-kernel@vger.kernel.org, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>, 
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Oleksij,

thanks for your patch!

On Fri, Oct 2, 2026 at 1:58=E2=80=AFPM Oleksij Rempel <o.rempel@pengutronix=
.de> wrote:

> Add DCB-based ingress QoS offload for the RTL8365MB switch via the dcbnl
> app interface: a per-port default priority, PCP trust, and DSCP trust.
> It also adds the few net/core ieee8021q helpers the driver needs.
>
> Nothing changes on the wire until an admin enables PCP or DSCP trust;
> until then every frame takes the port default and lands on one queue.
>
> Tested on an RTL8365MB-VC.
>
> ETS scheduling and CPU-tag ingress pre-classification build on this and
> will follow once it lands.
>
> Oleksij Rempel (8):
>   net: ieee8021q: print traffic type and queue count with %u
>   net: ieee8021q: add pcp_to_tt()
>   net: ieee8021q: clarify the tt_to_tc() traffic-class mapping
>   net: ieee8021q: add tt_to_pcp()
>   net: dsa: realtek: rtl8365mb: store the egress queue count per chip
>   net: dsa: realtek: rtl8365mb: add QoS baseline and DCB default
>     priority
>   net: dsa: realtek: rtl8365mb: offload DCB apptrust
>   net: dsa: realtek: rtl8365mb: offload DCB DSCP-to-priority

I have one major feedback on the series and it's pretty predictable:
the RTL8366RB has most of these features as well, so they
need to be added to the common helpers in rtl83xx.c and
realtek.h.

- RTL8366RB has the same type of traffic policy, albeit
  with 6 queues per port rather than 8.

- Logic traffic queues are slightly different, RB uses
  queues 0 & 5 for two queues, 0, 1 & 5 for three
  and so on.

- The DSCP bits have slightly different bit layout so each
  backend must deal with this.

- The apptrust in the RTL8366RB is *global* rather than
  per-port so this could perhaps be handled in each back-end.
  The global setting will even affect the CPU port.

If you add something like this to the realtek_ops in
realtek.h:

int (*qos_get_port_prio)(struct realtek_priv *priv, int port);
int (*qos_set_port_prio)(struct realtek_priv *priv, int port,  u8 iprio);

int (*qos_set_pcp_prio)(struct realtek_priv *priv, u8 pcp, u8 iprio);

int (*qos_get_dscp_prio)(struct realtek_priv *priv, u8 dscp);
int (*qos_set_dscp_prio)(struct realtek_priv *priv, u8 dscp, u8 iprio);

int (*qos_set_port_num_queues)(struct realtek_priv *priv, int port,
unsigned int num_queues);
int (*qos_set_prio_tc)(struct realtek_priv *priv,
unsigned int num_queues, u8 iprio, u8 tc);

The getters would return an internal priority or a negative error.
Queue callbacks would own register encoding, table selection
and logical-TC-to-hardware-QID translation.

Common code (rtl83xx.c) could then provide:

- Default-priority get/set callbacks, including PCP <->  traffic-type
  conversion.
- DSCP get/add/delete callbacks, including the series replacement
  guard and restoration of the IETF default.
- Initialization of all eight PCP mappings and all 64 DSCP mappings.
- Priority-to-traffic-class initialization using ieee8021q_tt_to_tc().
- Per-port Best Effort initialization.

Both chip setups should expose their queue count through the
existing ds->num_tx_queues, and set ds->dscp_prio_mapping_is_global
when registering DSCP offload. There is no need to duplicate those
properties in another common structure.

Does this make sense?

Yours,
Linus Walleij
