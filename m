Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5C049B202
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 08:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792398499; cv=none; b=Br9XCkkJtJT+iJddAT+W5ZfJ2g1o0HIu7sje7huWb9N76g+BzTZSywvC893Nj/vTGn7PjM4CF8C/aWO+gPf+kYzIpZIonb0apxhd4v+6xRw98xzdrTKaigC+fl7oud1xabcIQmdImIKKZc07jSinXrR6K2WP4crGMaF4jm1tCVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792398499; c=relaxed/simple;
	bh=vP/erouG01Q3Jo+KBHNH0VtorkMVsOnWd5Q4NOmBMzc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pLSKeVx1ukhB7NR5YBoLX6WK4e29Ui7e2b+52QFac69mpc+odkFKeAYYVcYp8tNy87DEWLvPP5oh4fgCTxlPOOVGo09Le0jq/1NLrQGxVLjNWArFLpiaohBRiG2/7YjmRJuSiiB4wUU0LgckD7Jdoh479vZwgG2hgM2YuRzqLVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lt0iu5yi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lt0iu5yi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 559831F000C6
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 08:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792398497;
	bh=a7NuP9Mmd/niqWds8h4TLzPA0U0+f5BoktGRSIL7us4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=lt0iu5yiNf8YZH+2758ytAclkHk04UD329o2FRJvnFXeiXLMJKsxkI2oysfd1UDWj
	 Oi5JDCQqLlAfyeoxh7DzmHLg2Hivx8/5QgKoyhmL6Y0G5UOJCK+0Dl3IWp44NCCBe6
	 clb7tmBnvyKEoUuye0+BdI4lMVFm8Mp6oopwAlB/gZyuUOau5gWIid0owSfZnGbLtY
	 Nyd2xIf3siK8uGuPaWqFwB30soXWwd6OQrOPmg7y+cKRG7BioMDuXH5+JDg9i97tmH
	 NP9qcPxgpHA5+JaVCgG/3BWeGe41X9jfAG15ogZLfDfNMVb7KQOmLtT5pDlHY9jQYP
	 EQr7TBt9B8nTw==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5ba3ec92031so2184766e87.2
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 01:28:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBwFR1iNxzqW37K4O62ABXg5PeieA2eoN95g2pZ6i97VdE8bwX94rCsSJGVGFSjLzYe3DERkK40=@vger.kernel.org
X-Gm-Message-State: AFq9FYIqQ9SEBB5yTzQ+1qN3OT918Mzm/sm7cTSN4FhgFD7JxztNT5Ck
	sZZDUwAtg9l/5BL+n+6SomSdmchL238bwWP/v17aRxdkKlvr+iLikGS8KooHMQdCZ9Pxba7Elfj
	5dcCxNgYBZg2f4YRHmLpCHaPDF8ZI5eE=
X-Received: by 2002:a05:6512:2243:b0:5bc:b8f0:7a0d with SMTP id
 2adb3069b0e04-5be50a7132fmr2147053e87.47.1792398495968; Mon, 19 Oct 2026
 01:28:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5a4715dd-89e0-4868-9ffb-c8fb73b18d04@yahoo.com>
 <75829f0c-69d4-4c16-8300-142023f840d7@yahoo.com> <CAJq09z5ZAxca0rRT0mSiU_3xp2wxEU4qahbDM3SBGpwe1vbMRw@mail.gmail.com>
In-Reply-To: <CAJq09z5ZAxca0rRT0mSiU_3xp2wxEU4qahbDM3SBGpwe1vbMRw@mail.gmail.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 19 Oct 2026 10:28:03 +0200
X-Gmail-Original-Message-ID: <CAD++jLnTJNBBKyD0oBL9X9jg084sd-=Au8a1rMhQTO5_tuf23w@mail.gmail.com>
X-Gm-Features: AclHuK9NakDrk9fKpI7K6rebx5OdnmJoE51eWXbFykt45TgltrZzPkFIZbWm3Io
Message-ID: <CAD++jLnTJNBBKyD0oBL9X9jg084sd-=Au8a1rMhQTO5_tuf23w@mail.gmail.com>
Subject: Re: [PATCH net-next v6 3/9] net: dsa: realtek: rtl8365mb: set speed
 for family D
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Mieczyslaw Nalewaj <namiltd@yahoo.com>, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	linux@armlinux.org.uk, maxime.chevallier@bootlin.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 19, 2026 at 12:41=E2=80=AFAM Luiz Angelo Daros de Luca
<luizluca@gmail.com> wrote:

> >  #define RTL8365MB_PORT_SPEED_10M       0
> >  #define RTL8365MB_PORT_SPEED_100M      1
> >  #define RTL8365MB_PORT_SPEED_1000M     2
> > +#define RTL8365MB_D_PORT_SPEED_2500M   5
>
> I also used the same _<FAMILY>_ tag trick previously, but it gets
> confusing quickly. Does RTL8365MB_D_xxx mean something exclusive to
> family D, or family D and later? I hope a more seasoned reviewer can
> weigh in on this.

I'm not seasoned.

But in the Microchip switches there are a ton of different
devices and it is managed by way of family-specific
files, includes etc. But we bake everything into one single
module in the end, the only optional part is PTP.

Here the family is somewhat and piecemal encoded in the
hardware registers so:

#define REG_CHIP_ID0                    0x00

#define SW_FAMILY_ID_M                  GENMASK(15, 8)
#define KSZ84_FAMILY_ID                 0x84
#define KSZ87_FAMILY_ID                 0x87
#define KSZ88_FAMILY_ID                 0x88
#define KSZ8895_FAMILY_ID               0x95

#define SW_CHIP_ID_M                    GENMASK(7, 4)
#define KSZ87_CHIP_ID_94                0x6
#define KSZ87_CHIP_ID_95                0x9
#define KSZ88_CHIP_ID_63                0x3
#define KSZ8895_CHIP_ID_95XA            0x0
#define KSZ8895_CHIP_ID_95              0x4
#define KSZ8895_CHIP_ID_95R             0x6

it all comes pretty naturally from this.

Then we go on to define boolean family deduction helpers:

static inline bool ksz_is_ksz87xx(struct ksz_device *dev)
{
        return dev->chip_id =3D=3D KSZ8795_CHIP_ID ||
               dev->chip_id =3D=3D KSZ8794_CHIP_ID ||
               dev->chip_id =3D=3D KSZ8765_CHIP_ID;
}

static inline bool ksz_is_ksz88x3(struct ksz_device *dev)
{
        return dev->chip_id =3D=3D KSZ88X3_CHIP_ID;
}

This makes it pretty straight-forward to code it up.

The same can be achived even if you don't have any hardware
ID registersm with made-up family enums and using DT match
data obviously.

Yours,
Linus Walleij
