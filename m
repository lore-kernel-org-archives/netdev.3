Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1080142AF86
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 08:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.225.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789633852; cv=pass; b=Vxkp1SA1ByJNtTrPwvhrQtOdG7SF+V44PWnN/ja/NqSIUyV46U4zmgLF6cngxVldr6S7jAJkzYrXOS6QOjnujItH8c8dshpvJOaAokrAjanmwVmUvt+8vzvhUMfZaUXFlU/7h6vam8wPzj7v4PrcHtZtArJKyRat7+skKFkPVtU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789633852; c=relaxed/simple;
	bh=G5FOvTerYV+i+bh5EByuYps3MCibaVHg+MJbwyAppPU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oFdqnbYKKTOlJt+004mRIPLVSpLOBkkYfXZmcWmvGXs5o29A8jZwfop8MXp2IBsIxnnIkKJ1DjzK/RePSQXhXjPET0Gq0NyUi9RwOEAl/UunkkH/1J02gtDRR0vSxAhRHtVpz1LNIPJ4lHdwUVVqSjjpEJR/+NjakIVYRv86Obo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K/A+uI4m; arc=pass smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K/A+uI4m"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-486e1a044c5so393821f8f.3
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 01:30:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789633835; cv=none;
        d=google.com; s=arc-20260327;
        b=WWcv3qRC2j0cII5IeEBJmbZUDB1pBovJNHEV9qIzFXSS2O6aNlukcTkFjCzz3/Unr+
         zUaUoLaX3Rya+t0+teowaq1GJW2bXpRQLQSAWlsXrOYPnnolwNMWFfbveL5o/s0LDuQ3
         PZaq1F/YKOAHzSK3GrrfPbhIMT+1eb1M9cOY+I9tV/5WnajCiN0aenXz49euF5NJN5PL
         mAvuINKot9NUCEdsfz1ExE3w8X+n/9cGBoGURJQ5SVSVVaglbRk/bPz2GVRMo7nH1lp8
         OXJScNei528R5PeD6hcLoc3kBqqOpUWyOjv03MaEyq8De77MH82jzqHXGhHwsSwFv0dw
         QZqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dKETHQ/f5XJ/hL1DtWxBym7ccO70VFb5IjdqZcf6Fq4=;
        fh=W6CSzqjvlQF5+nx4hu748sgxpBweTwcjiswnXM8cKFw=;
        b=bvX7pdhFYDkNzPuKZWn+HoWJ4TlGT5ahPwj8VpPXeDKmoEB1b4yFFqzPHTFrCQRV/n
         VA8LrhThGjTRbKejKmV8mDRzaQEZf4qlPV7vFXO5QomNSFPYdgfP8hwGcFAbmwxp08vv
         qKQjR6b3tgEJT5ZM6F9Nfvzlmqq0QkoRpoog4oPbV1UHLzYMq9zAkgR/QOPmIBlWzXcU
         tWuS5yFLb60jscKiiQB4oOhVQ02nhFWN4lgeRawl9YkIHUd29ROWIqJmYE5RlgWXw353
         TKaHRdK2JWummsS8z1dL9AZ/f2xtFdHp0BzVYj4OxnhYySujzBYV0vlUVqAGm8XMhEsN
         pAiA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789633835; x=1790238635; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dKETHQ/f5XJ/hL1DtWxBym7ccO70VFb5IjdqZcf6Fq4=;
        b=K/A+uI4mOxrhaq2jaFoW9j/Kzc+kG4QOL8z7W57QIsCRZZFYgj2vOR3FPs1FhI3mQ8
         ktNr2rUxL1gDNIY5XK5yqgL+9/b05Pqh2ytRzwJWNA6GqMSq4J035pysKIeNS8XSJG+K
         vEGYvksEAVxF6VOt0B1z8WnZkddiVuUhh6w1X/YlAZ1G65BnogUyq7jqfJdrkFb+laBY
         MiMyKmOUOY9LGLH2LHsh3yQbu05KdQ4UHeQi8Ky2IIhal9dgQl9b8qgaQEx3XT6qg5gR
         cQsLyYM+1icogCEIzO7Uisj2xibG0cu0k5Mj9/LdPnd+D0KlSKKGXz/meH/coYncxtrH
         h45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789633835; x=1790238635;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dKETHQ/f5XJ/hL1DtWxBym7ccO70VFb5IjdqZcf6Fq4=;
        b=dfGxV25XinI2TWLO6lKFOSPs4CePzZ6vqu6cPHL2ROFasE58VyDsXQ2IIx1bgIo/Yl
         J4BDM5xIwrfyPx3zgk+FJDmtGPdIe2NLGhpV22fXBZcyiRA9zy7EC+qRYloCizztTyO/
         5/1FE80UF78BOC96FfGE7sddf8kd5+Glt8NhCtby5ruf/UpNYjW7vDEYhqd4+RgYqYfU
         u9GRWR1Iy5LJTZcfyJAUyLFp7md6VYGNtYZd4Na5KYm3qKN/3961geNd7jjnJUjO9z1Q
         lbSpH4SEXm6CnSal1lWXaJpTavoOcWo/2+9vHxzGVjLDdAUdUGjETZZyDfgEBSbwojph
         h4Dg==
X-Forwarded-Encrypted: i=1; AKwUvBxEMTk2EQd0U9GYkDHEO+7uHw4bL2AmaAnY9313egbvLm7R2XEidKEZcLisxPefTGPUiWXC+Iw=@vger.kernel.org
X-Gm-Message-State: AFuF++lwhc1Rbom0pl/WqVipbAhVOPglyDt7nMMTgiAKd3/wBZXZ6Xwq
	yMrIK/+12hI5Aot8rPoq/sPH8elseCn6BhMNnnY/hcV1RzDnqjv9XVROD9m6AfAWYTV+eURSV5g
	txF6Q+WULTbo6S72Kkamq70lPOZTyf+Q=
X-Gm-Gg: AYBFou164v1OdwzBFUfoWyLQ8SRCbWUR47aPPKM5pjWd25LaDl6okSmv2phzJhoW8EE
	VeFLKiAFX4+5ZVC3wbJA3eVMFO1sHpoPghzOsOqypXSI9Egw6JQQp4GxbSsrLI9wtOeffsFVgmm
	02YdgkPVVdxTQXRnyirAtO9vJIcWDg5As/E+2I8tM41nTvHfb9r32rj9l7HQ4Qz+Tuea+5+lqYA
	XBIwRPG2FUwLVAel6PQP1YIsPqV8+CQCTO6Se5LlfWButb5RgrxbN/sI7yX37D18vEJ6lpDvpSb
	OuxHnWRrCjS3a66dgmfmFt/43HtYYAGjoVfkswwpkZFV+7vkTmbZ91LALqOWwbU79CCzkAnKQY/
	uryD90/FZkfC45KF2SLKwAnio0A==
X-Received: by 2002:a05:6000:2c02:b0:487:7fd:734 with SMTP id
 ffacd0b85a97d-4870cf2bab0mr7400506f8f.18.1789633833682; Thu, 17 Sep 2026
 01:30:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <TYCPR01MB748139F059DF2459B9813416A4B92@TYCPR01MB7481.jpnprd01.prod.outlook.com>
 <TYCPR01MB748157ECB6B92D8E3FFD433BA4B82@TYCPR01MB7481.jpnprd01.prod.outlook.com>
In-Reply-To: <TYCPR01MB748157ECB6B92D8E3FFD433BA4B82@TYCPR01MB7481.jpnprd01.prod.outlook.com>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Thu, 17 Sep 2026 09:30:07 +0100
X-Gm-Features: AcwNN1U8vjkIrSzMqHnYBmAsTNjSFszApsXoNAyb_ZFCyUrlOZkMUDMj9NBc6DY
Message-ID: <CA+V-a8vZZB0vwdgOxWm30_Jzv2FCrtNTna7PWMGeyEKcNK8otw@mail.gmail.com>
Subject: Re: [PATCH net v2] net: pcs: rzn1-miic: Reset PRCMD state before
 unprotect sequence
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

Hi Yoshihisa-san,

Thank you for the patch.

On Thu, Sep 17, 2026 at 3:55=E2=80=AFAM Yoshihisa Yamamoto
<yoshihisa.yamamoto.xn@renesas.com> wrote:
>
> On RZ/T2H MIIC, writing 0x0000 to PRCMD resets the command state
> machine to the IDLE state.
>
> Reset PRCMD before issuing the unprotect sequence so that it always
> starts from a known state, regardless of any previous PRCMD activity.
>
Please add the Fixes tag; the rest looks good to me.

Cheers,
Prabhakar

> Signed-off-by: Yoshihisa Yamamoto <yoshihisa.yamamoto.xn@renesas.com>
> ---
>
> v2:
> - Fix indentation
>
>  drivers/net/pcs/pcs-rzn1-miic.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rzn1-m=
iic.c
> index 2b72fa98d..818756bb8 100644
> --- a/drivers/net/pcs/pcs-rzn1-miic.c
> +++ b/drivers/net/pcs/pcs-rzn1-miic.c
> @@ -270,6 +270,9 @@ static struct miic_port *phylink_pcs_to_miic_port(str=
uct phylink_pcs *pcs)
>
>  static void miic_unlock_regs(struct miic *miic)
>  {
> +       /* Reset PRCMD state before unprotect sequence */
> +       writel(0x0000, miic->base + MIIC_PRCMD);
> +
>         /* Unprotect register writes */
>         writel(0x00A5, miic->base + MIIC_PRCMD);
>         writel(0x0001, miic->base + MIIC_PRCMD);
> --
> 2.34.1
