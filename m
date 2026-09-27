Received: from mail-wr2-f34.google.com (mail-wr2-f34.google.com [74.125.225.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D031F395266
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 23:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790550070; cv=pass; b=rtgQg8nlPFcwI3N8QflDJRfE1wguoQssmMoOpRxGbfsxJaolb3eCDoeA3GutrgVYqSzrzZLsMZ+7ME56Dl6TTwhGqLDqAmU8DHfLoks4M1eHtRdkjlJKkAnF5H9OoMtwQnF+8gOxIDJCNuRIGRKiFft60D2L0nvkQHT6ZfbCFyE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790550070; c=relaxed/simple;
	bh=JCpwn/WWICwDSoLBnOOTTp6gTS0SfU3IsgvUz7VJvnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ayUZihYgfOz+PGWNPaFwN6EfGAfceu90kU50Kwsw4fN9IuyuxK8aQPVLTEEbwcFDJPiUOZ2pl2OX/G8/zD2zhn+jBsFuTePUlAru/WYuEBSoXgcsY4BnWVaY3LOdaVO3wSMDj2jFye9yJRUMq8f7HVDpdtssxW4SE/biIvIzs7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=InaRM3Pg; arc=pass smtp.client-ip=74.125.225.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="InaRM3Pg"
Received: by mail-wr2-f34.google.com with SMTP id ffacd0b85a97d-48884b0219bso883786f8f.2
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 16:01:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790550067; cv=none;
        d=google.com; s=arc-20260327;
        b=SfDxhSGWnVuGsceMcAFmJBRp/EKt2ogFQzbYivSu6v5vidSazUM35BZwQ7H/esLWjd
         zm8Qc68RfbZR37gOWiNqXpEPOzf9WsKH9qyVrMM0Uslu1cxalBWmxmXA9J0HMXJf90zw
         lnA+LWMSmUBwQdXjEPNtNmgKCkATfatxhgT7uaHD6XwARBsEsSL6TGilwZmMZx7iteyd
         n7K6CqxXRuiSqjCyB04x1Np/pNF9bUOXo4UvOdOuz924V614o+wE0awQFYOO8UZr5fPV
         /U/E30WdFUyD1rLvJpTqUUj5pCw2aXlttFgkTUKFP8FyFeiQr7OeIpO9/ZNagi1mYE9j
         DCUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pC1cDVE6Id7bEPJ+YQ1AhsXzN8ywZhzrUwp85FIkVFE=;
        fh=PHg7TJh2OJYu8iYa24fMWtqFN/wLoHk5LYoDd2uSpyk=;
        b=GrOpkit5B0eNp8nIo8cSnirfQRNbaWGxHvygh66MczjNNqQrkLSrcTZtdaRg/UTuLh
         cw/lbhtMwxwzYzmkV0r2ute4VZY0A+hG6to14czxxu0gpg6kH78BcG+NgEsb+XC7ZTJc
         i5Ik1/i2uKMRw00QymaFPnxXgETApu6dO06OGVP5ACD2fnx+/izRk3/OurnB3y9j/NTM
         OtnOecAYgJiro/Dv70Soh7K7Bh7WlIQCYQbjgLFNvWH09+74zpwSCHCub+qRRRslB2nL
         KKRQGRsrFBW+yoPItDvXkVwSsXRoYr5XVOrAFLzJINAjorGEZNGyXbPfmeutKdLqw8hm
         xEMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790550067; x=1791154867; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=pC1cDVE6Id7bEPJ+YQ1AhsXzN8ywZhzrUwp85FIkVFE=;
        b=InaRM3PgpHKQsECCIra6A9YmBRSU1CMHlqJyRd8yeerQpCQvd3hxYGeJLq952g7t1l
         FImRr7qA0/AGrx7QxUnbOU5d+BnBCmYSQDEWuFNqPIHk4mX5he6yGEJjtkkqlgcKoMQm
         hm4goQmzW42wUPJqgLA9xR9+tJoKcep0QWKiBqTFJYVpgTDFyltqbipx21vYM8cTsDSr
         xiYygf5JmKi3LurfHIfc7IdCgY1NFg+SvB09aBBFguhRYLgn5GNFCXRHNfmSiQmnsKXD
         ReVm9SKwMqKcJWhtslwaJlV2MAj6XX8/EKaL7sU3COjGjb59ORyKDIdhKESRex9q91BC
         HQkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790550067; x=1791154867;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pC1cDVE6Id7bEPJ+YQ1AhsXzN8ywZhzrUwp85FIkVFE=;
        b=2cznFq5RCJrLAYWYgS3flcSWpYwo8Bof/q35GT6j6kODvGOPQVWLFcxjV9zmy+fThh
         abTj0JPHmPCSHx68YqusF/PK3M5xx4BeZMK3coq4PcP0Ns+WfX9k9RLDmflpaPHuyv9E
         4IaY+dYHsibK2ISrPuHNN0U5BiSOyaqhL6/WgFnJjGNRfx8HD1uSgrVyRlrrMZBYZ/0r
         W8nQbGUruEh+zNbimzqbSPlFFu+C/qf4WICtTqmQMzTI/P9QEGD2PRq8oabdPTB0rD02
         2V8+Y+ylYHk2o9on4ggXmDVAirD/X+LO0NNPPmApQWaRd8/7Ey9rFFSd1+DAoMhW0q9k
         IhHw==
X-Forwarded-Encrypted: i=1; AKwUvBzf4FeN9YUp3kJVYQz6/oTErRFyCLWFpIzxYVxo9zNT7Xk9GRWfSGsVgca0k89Lst81mVuf3so=@vger.kernel.org
X-Gm-Message-State: AFuF++k3c7BY2W7bEX1fxADlSDh/tl6/+APewqaqiTwpIFBr3WEiHT1q
	IZr3N2UZ0yTL6oLuIbl20sWI/1c4kbJz+rY2uXlHAo/hu3KXDXYTPNDXJmHGv5tAUfE/s6QHME7
	y9VewpqLuJGJURv5m8O3y/sZ4uWEQJBc=
X-Gm-Gg: AYBFou1mjkmSR1g6BsMR2Qhc13u2d0EWuNQ2FmgIUv3URqQpIackkAvq/nIlMUzxVuY
	z2HAFiDGCSslDQcriyl0OVX95XPYV0o2QgOiGDRsP2FhaQ1oZLvDqJjqhkVLHYMChmyT9HLowxD
	V91CGwL076rf/PXtCYyzX/QSjdLbUFWwlFYhsXH+CKD0q1MoEzM9rtYApkH1NcNnl0Cw6jy3U4A
	EVHK8sKR1Ak/bETO5l2C8pJyWBVYd3UIyNYKpbqzvB3iyUE3sYH2GvSruEu03aDke1SsSvFtCcj
	y8RsmtPzv4Ka6QdM+rNrfYzUUIf6lG5CrOdQZaBfJ4xs+a3MEvUIIN0hvCQDnGWyZvIxM6VWSwX
	HZJRm/8VRQV5SRRgDFKu7cCCSVZEoLCcc64ZPfIUrC1YhKgFpUaprgJrdMqEVGXU5eHiuzeIdtw
	==
X-Received: by 2002:a05:600c:4f47:b0:49f:c199:e1e2 with SMTP id
 5b1f17b1804b1-49ff06ed9c1mr170160015e9.28.1790550066832; Sun, 27 Sep 2026
 16:01:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <TYCPR01MB74815955A10817B64BD6FB93A4812@TYCPR01MB7481.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB74815955A10817B64BD6FB93A4812@TYCPR01MB7481.jpnprd01.prod.outlook.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 28 Sep 2026 00:00:00 +0100
X-Gm-Features: AclHuK9lqYCvHMC1AiAR3XuaDXFU85jazCSKt890eRq6J5XWeWZVuaVBpqASpBo
Message-ID: <CA+V-a8vOrmXpr8Nx9aiE-D4axAQNf9oKhSgHaQXqdjE-bWeyNA@mail.gmail.com>
Subject: Re: [PATCH net v4] net: pcs: rzn1-miic: Clear MIIC protection state
 before unprotect sequence
To: Yoshihisa Yamamoto <yoshihisa.yamamoto.xn@renesas.com>
Cc: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	Russell King <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>, 
	"linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 11:45=E2=80=AFAM Yoshihisa Yamamoto
<yoshihisa.yamamoto.xn@renesas.com> wrote:
>
> On RZ/T2H and RZ/N1D MIIC, writing 0x0000 to the MIIC protection
> register clears the protection state machine.
>
> The initial protection state cannot be assumed to be constant,
> as it may be influenced by previous activity before the driver
> takes ownership of the hardware.
>
> Clear the protection state before issuing the unprotect sequence
> so that register access always starts from a known state, regardless
> of any previous activity.
>
> Fixes: 7dc54d3b8d91 ("net: pcs: add Renesas MII converter driver")
> Signed-off-by: Yoshihisa Yamamoto <yoshihisa.yamamoto.xn@renesas.com>
> ---
> V4:
> - Clarify commit message
> - Point Fixes tag to 7dc54d3b8d91, as the issue also affects RZ/N1D
>
> v3: https://lore.kernel.org/all/TYCPR01MB7481CE8351FDB2CDCA229955A4872@TY=
CPR01MB7481.jpnprd01.prod.outlook.com
> - Add Fixes tag
>
> v2: https://lore.kernel.org/all/TYCPR01MB748157ECB6B92D8E3FFD433BA4B82@TY=
CPR01MB7481.jpnprd01.prod.outlook.com
> - Fix indentation
>
> v1: https://lore.kernel.org/all/TYCPR01MB748139F059DF2459B9813416A4B92@TY=
CPR01MB7481.jpnprd01.prod.outlook.com
>
>  drivers/net/pcs/pcs-rzn1-miic.c | 3 +++
>  1 file changed, 3 insertions(+)
>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Tested-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Cheers,
Prabhakar

> diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-m=
iic.c
> index 2b72fa98ddf1..279f709c889b 100644
> --- a/drivers/net/pcs/pcs-rzn1-miic.c
> +++ b/drivers/net/pcs/pcs-rzn1-miic.c
> @@ -270,6 +270,9 @@ static struct miic_port *phylink_pcs_to_miic_port(str=
uct phylink_pcs *pcs)
>
>  static void miic_unlock_regs(struct miic *miic)
>  {
> +       /* Clear protection state */
> +       writel(0x0000, miic->base + MIIC_PRCMD);
> +
>         /* Unprotect register writes */
>         writel(0x00A5, miic->base + MIIC_PRCMD);
>         writel(0x0001, miic->base + MIIC_PRCMD);
> --
> 2.34.1
>
