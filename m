Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF063A4516
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 08:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775549490; cv=none; b=NgeqZvGvkIK5lLdodBsD+eKjWjprUwThLbQJR5k4Bl84pxwwNieZ9ikaFPm5F0OlIs/JBZ4o3nLkOJ8i93ILLWova7Nt2WHfpFJ9glFXmYH0kbHypXOSklMTGtJw1/qRP7/rEvzltB2YQywiSFPwTaHXmhbLh6hAa7of1RA/c9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775549490; c=relaxed/simple;
	bh=xl3KxYXEqceds/zj+bdUjf39TNJ2eHQdWjTzUaGjRIY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WfSYj8TKfF+7PIn+SDmBwNmg2KFU4dqNVlXFojWfNOFrk6fdGuXf/+zTm2WwkyQJ1SmgghBQjd8MF1KsrprPXIrL6BdkoGcG6AmavRPieghqIBlnIX9qgo3ZmyCCjSFpbd7lLLeWlUuAWfnscSd9rY8cf7E1ohfz4ToH1osLE2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FeNIWDaC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FeNIWDaC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704B0C4AF0C
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 08:11:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775549490;
	bh=xl3KxYXEqceds/zj+bdUjf39TNJ2eHQdWjTzUaGjRIY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FeNIWDaCMXXDz0P4cQF10DSYf2slHKRKutMpjW5+e81x9NaqhjeCeOGdoe6deW4IT
	 3pIgziBRqfq5DRMRxmZzxbPHx/dWhMHJlDsT8kHfDoFWxiIpYWMOtUjeAkoEGW36EH
	 nnx5zSb6pCBW8BN6WDn50UNX5RLM567k6HoGluApBoWp0apJQytOHdoKeCRRTFUEY9
	 PBhh/vL/y+Any2sZ3c98cRtoQS+iMuAbBk4cnUySCap7nIck0x6p+Zp1uNtOSkn9wL
	 UNNlyWzVO2SVV1lU+YH6sG41UT45tqNkwfKMEqH0zRKgfmhoWLaQKBsYdNTHE7Yxp4
	 ECWLSMDggYaeQ==
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7982c3b7da9so41520867b3.1
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 01:11:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXkZ+LK0FimI7pJY/h7Q3uzj3/QgRyHrkFuwUpAp1UsxXLjQmSMJpTXbc4JdDM+Ahvkwlsfthc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5oFfzwDkvXEpAprDDf7K1LmmBqAb03g5O7CJnF/epyJoy0GgN
	mEWJt1iLTseKLFhB307sspO1bdNjBsq63++z+s6jfcj8n2nid1/ooYUb3im4Ss81rjyoHY9hlIm
	5QyEuXEu+MF0PQFct3g037bCYNdqOD+k=
X-Received: by 2002:a05:690c:c501:b0:7a2:4f74:ec8a with SMTP id
 00721157ae682-7a4d5d54244mr144759437b3.43.1775549489753; Tue, 07 Apr 2026
 01:11:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331-realtek_forward-v1-0-44fb63033b7e@gmail.com> <20260331-realtek_forward-v1-7-44fb63033b7e@gmail.com>
In-Reply-To: <20260331-realtek_forward-v1-7-44fb63033b7e@gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 7 Apr 2026 10:11:18 +0200
X-Gmail-Original-Message-ID: <CAD++jLn1gWBmSN7bDkVr_8RmbM3KptKx-z5cycYv+jG-d7FHPg@mail.gmail.com>
X-Gm-Features: AQROBzCgnkSFcrK0EjV8vGn4pl6WRX_wNCe60yD7_PftQpUudN8T44Tc7psarq0
Message-ID: <CAD++jLn1gWBmSN7bDkVr_8RmbM3KptKx-z5cycYv+jG-d7FHPg@mail.gmail.com>
Subject: Re: [net-next PATCH 07/10] net: dsa: realtek: rtl8365mb: add port_bridge_{join,leave}
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	=?UTF-8?Q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
	Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
	Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Luiz, Alvin,

thanks for your patch!

On Wed, Apr 1, 2026 at 1:00=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

>  static int rtl8365mb_port_set_isolation(struct realtek_priv *priv, int p=
ort,
>                                         u32 mask)
> +static int rtl8365mb_port_add_isolation(struct realtek_priv *priv, int p=
ort,
> +                                       u32 mask)
> +static int rtl8365mb_port_remove_isolation(struct realtek_priv *priv, in=
t port,
> +                                          u32 mask)

This is smart!

> +static int rtl8365mb_port_bridge_join(struct dsa_switch *ds, int port,
> +                                     struct dsa_bridge bridge,
> +                                     bool *tx_forward_offload,
> +                                     struct netlink_ext_ack *extack)
> +static void rtl8365mb_port_bridge_leave(struct dsa_switch *ds, int port,
> +                                       struct dsa_bridge bridge)

The content of these functions are very similar to
rtl8366rb_port_bridge_join() and rtl8366rb_port_bridge_leave().

What about moving this code to the shared library rtl8366-core as
rtl8366_port_bridge_join() and rtl8366_port_bridge_leave()
and add per-variant callbacks for ->port_set_isolation()
->port_add_isolation() and ->port_remove_isolation() to
struct realtek_ops and share this with rtl8366rb by refactoring
rtl8366rb.c to use the same callbacks.

Using shared code will help us to avoid having to fix the same
bugs in more than one place.

I don't know about this EFID stuff in  rtl8365mb_port_set_efid()
(maybe RTL8366RB needs something like that too) but certainly that
can be an optional callback in struct realtek_ops for now.

Yours,
Linus Walleij
