Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com [74.125.230.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CED47DFAA
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 10:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789467970; cv=pass; b=aLMcgWDLjDL/Jr9R3pzudM2fUcdRB4or6Lx/nvxWyFHz1nd+Dxu88WK7sTGfDyDEz3j8EsSvsXHZ7Wua8zQ4n71nwZKghVuMu54SDCHk8HcvV1HAWciK0oQEisHNwj/K7ePhBxQzctIi9Z1y+9PXpq6exlSiklI9rNlPR4QNi90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789467970; c=relaxed/simple;
	bh=JBUy+nz8yoNC+BZ+++kswfX4CT9SuhGl69xtoGeYccI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gQQKk083UaO0m9Qo54u+9NBKXSvmUeSVsSdw7qxS9xw+Vjt0GbzloYVcD4SeXzrZgJtmbtz9bc7T1lKM5fGmCWNjxWUZUpikWQqnezwJ5EoO1z82fyE258v87mXeADlZgsFanrueF7cV365mW27gHGYXI9VysU8gIH9xkj2CgD0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jDeeb4TT; arc=pass smtp.client-ip=74.125.230.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jDeeb4TT"
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-9106feddbdfso35790226d6.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 03:26:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789467966; cv=none;
        d=google.com; s=arc-20260327;
        b=lobJ+2lSMyFU2F3ldRB37bCfp0P08Idrg9diuz8kdcDnaN9l5wfqy2F5RbwNY9ZQnb
         bUfx/DF4S4xXibA6RgOzPS1scAV064y4dEvlYIbrhu/6YDb6AF7WYnfAWgEolp/vZ/lJ
         EYWcUj/135JQIte/Jw1M6Y5inV0Ahyln94jN9adt28NA3AGPotqIHBhNx/l7JsdJQbdk
         IHuqLZL9QAA+Rw2THChtHw1wadj8tlymEBIGZKXn4qxJmRNb1wPF+9vXHkFdt4u3xutU
         tB75LJK4u4D6Ul6qYb7VlM0qaYO3TWrF5XpPXNZlhuh8AJs1k/zswuXq1+Oj1Jvj2ryg
         7r8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=TmqZCDgFfpZ8cNrOODbC41NVyTbNreASHxYyKCFmeq0=;
        fh=8Z+fa/r5hB34cEuMbT59FJmUZuDNG9xevuvOtWwKTFA=;
        b=oq02vUqrMWQzIDHwxVQ2Dr9aATdK+lF81nuX+c6+8svy6vM9UvV+SZtVi+FdnfLIG/
         MaBanG+78e2m0v05WSlUx6hoZg2SXWeLrdILn3jFJq4162nHvq00kCb62CRxmI+3BP2A
         +4dAFgi+3UkNWd/NLkbhtBCRNI0PLd3frxakqyVh8p6M+6yZaj/Sws+DdGv5P6/xqUsU
         N3isDCdNMA2IWROnFmIf0gf4AqZtc8z7Y5qf/ff09XMDfdvoJTeBmQi8Mm/LC1Sp0jYu
         OO1wuMC0FRsUxI+KDaoNZRkMs9H+JvyZKaf/vQiEsEFcn9ZeIbR1ksDoth7Spe2Y4vXM
         EMYA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789467966; x=1790072766; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TmqZCDgFfpZ8cNrOODbC41NVyTbNreASHxYyKCFmeq0=;
        b=jDeeb4TTmliDBWyDkhBxUQ/XHnCS0QKZvC65IAMifHD4q1oUfOho/THOonXqg+p7Np
         E28VsyDwBPuuaXEMNwAjapDB3aXXSMW4FARVzt8v4mrVeefS8WU5DyrM5jVrb/JBWeIQ
         YhkDMevzzlb4lvWLj7kB5+jvZ87PRT0uM0iOhGxqzUsJ76Yrd3rUTfBuWMVWDE/ohj1Q
         v1pDp3ouiORLcie65UTh4msG/vEKed3cFtHOZx5vooM9gOQaOoBPLqlxU7mqvjF5sfff
         gkGYItt+qdsjr6aqvWpLNRFmQcJt9gFEn4P3T++YLHMMt9ULMT9DrsrHwp4U1aKEY5VO
         Grag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789467966; x=1790072766;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TmqZCDgFfpZ8cNrOODbC41NVyTbNreASHxYyKCFmeq0=;
        b=dIK3EcO9avOwARjsLawD7OjobDTGCzXagX55B9MS27GVoi+CWGjXsb4bYXIoX4tsWr
         e7ZU/nNl3pH4fJD6huy7Lhb0Y827c8l0gGykW0pJ9/IQzPNjSO5sfF70ukxYR6xYirLi
         uujLvLefk+7Leyz3AaywI3R6dadWe6nOYi0XKvMApU63n/oW9/QkBjvUlGXkRyGUyZQ3
         dOwhqAOIU8cNYG1BIm5OtAVSaLyJ1h+8Doy9lHUh114Sn8g48M7BbsJ38b/geSMEiKqB
         XvWAGJWFhp5e8/BlD+phROMZYbe6cHdQYsI/MzbuQ7umS7dqNCdWAJvTm1aaVy9mOShD
         d/ew==
X-Forwarded-Encrypted: i=1; AKwUvBx/LZJM3F82Qx1dyVnSpkUa3VyiqXSTekWYSOUilm3mSgTymbm740WyL6dLrkV7AZJbBAXhOX8=@vger.kernel.org
X-Gm-Message-State: AFuF++kDtlsYxZ3/qxwjOdhfYkq4vWtnzVR7+q4obLre5UWlRQbIj83n
	uMCe+5jY1dM8+lRtr+TX+e7TneNnOFE8t/NciX0LEJQa/GuWDyGaScm7XWjPMh7DOARAAEf3wYT
	Ie4xEfsI9SYrTDpGTYsZHQ7gepXWsN/s=
X-Gm-Gg: AYBFou2vyIS9/LZcpYH6gy0l0wZSMXIkj9saFj77Yi1tjJaXDRRP1dCHQ3iQOY0o6eC
	nED2KjucnQwEbTxPHgrdRZtSklL6mnqmJ0mwseWEA25O/oyY9okaznEl06VgqjHQsz17MzfZ/W7
	TgezwUC2rX4tdaBOwWS59cBG+sGnIiO+6VhW8Cv6lJEOB+6QnkdwAyM52eZ1r/OJbUB4pmJpCK7
	ZrjARK+t6rnbqQY9BLwbrMv3GDWWvYMv0NwsS5uL1s2b+clFQPlNpVq7i5S3LEyz2ScXiv0mpoe
	eHTmN+u81B1f4I4OO86DXTYFMiWrQEtkFNxE1S7nceINYxprZ1vFvF747BTWqJBzMaY=
X-Received: by 2002:a05:6214:6285:20b0:912:3162:523e with SMTP id
 6a1803df08f44-9123162551bmr69922176d6.8.1789467966144; Tue, 15 Sep 2026
 03:26:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260914214720.2467586-1-donggeunyoo.kernel@gmail.com>
In-Reply-To: <20260914214720.2467586-1-donggeunyoo.kernel@gmail.com>
From: "Christian Marangi (Ansuel)" <ansuelsmth@gmail.com>
Date: Tue, 15 Sep 2026 12:25:54 +0200
X-Gm-Features: AcwNN1U-3EGl1dwa2s6HBcl5buSVBgdBb0MTb6m6SgGCBXYkYsN7vkg0bISTlEY
Message-ID: <CA+_ehUwT_RYztjGJ0P_czx++wxNShT3Zv3JhjQ_eBbaoGQoNRA@mail.gmail.com>
Subject: Re: [PATCH net v2] net: phy: qca808x: handle the active-high LED
 polarity mode
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, Daniel Golle <daniel@makrotopia.org>, 
	Rosen Penev <rosenp@gmail.com>, Sashiko <sashiko-bot@kernel.org>, netdev@vger.kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Il giorno lun 14 set 2026 alle ore 23:47 Donggeun Yoo
<donggeunyoo.kernel@gmail.com> ha scritto:
>
> Commit a274465cc3be ("net: phy: support 'active-high' property for PHY
> LEDs") added PHY_LED_ACTIVE_HIGH but did not cover qca808x, so
> qca808x_led_polarity_set() returns -EINVAL for it. phy_probe() propagates
> that, leaving the mdio device unbound and phy_attach_direct() falling back
> to the genphy driver.
>
> Accepting the mode alone is not enough: led_polarity_mode records
> active_low, so an explicit 'active-high' node stores 0, while
> qca808x_config_init() re-asserts QCA808X_LED_ACTIVE_HIGH only for -1. The
> bit does not survive the reset phy_init_hw() runs first, so the LED would
> come up active-low.
>
> An 'active-low' node needs nothing here: the bit is clear after the reset,
> which is the polarity it asks for.
>

The commit description looks a bit "dense" and took me well 2-3 minutes to
parse the english and understand the change. Was also the commit description
assisted by LLM?

Anyway more comments below for the patch.

> Reported-by: Sashiko <sashiko-bot@kernel.org>
> Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908105959.70453-1-donggeunyoo.kernel%40gmail.com
> Cc: stable@vger.kernel.org
> Fixes: a274465cc3be ("net: phy: support 'active-high' property for PHY LEDs")
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
> Assisted-by: Claude:claude-fable-5 sparse
> ---
> v2:
>   - No code change.  Rebased onto net/main.
>   - Cc Rosen Penev and Christian Marangi, per Andrew Lunn -- they may have
>     QCA808x hardware.  Christian wrote f203c8c77c76 ("net: phy: qcom:
>     qca808x: default to LED active High if not set"), the default this
>     patch extends.  If either of you can put an 'active-high' LED node on
>     a QCA8081 and confirm the LED comes up the right way round, I would
>     appreciate it.
>   - Say why an 'active-low' node needs nothing in qca808x_config_init().
> v1: https://lore.kernel.org/netdev/20260912012819.2072067-1-donggeunyoo.kernel@gmail.com/
>   - Supersedes [PATCH net v3 3/3],
>     20260908105959.70453-4-donggeunyoo.kernel@gmail.com, whose
>     Reviewed-by from Andrew Lunn is dropped: that version only accepted
>     the mode, this one also makes it survive the reset.
>
> Compile-tested only (W=1, sparse).  I have no QCA808x hardware, and there is
> no KUnit suite or MDIO mock under drivers/net/phy to exercise the MMD7 write
> without it.
>
>  drivers/net/phy/qcom/qca808x.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/phy/qcom/qca808x.c b/drivers/net/phy/qcom/qca808x.c
> index 8eb51b1a006c..68fd4d0fe31b 100644
> --- a/drivers/net/phy/qcom/qca808x.c
> +++ b/drivers/net/phy/qcom/qca808x.c
> @@ -200,8 +200,8 @@ static int qca808x_config_init(struct phy_device *phydev)
>         struct qca808x_priv *priv = phydev->priv;
>         int ret;
>
> -       /* Default to LED Active High if active-low not in DT */
> -       if (priv->led_polarity_mode == -1) {
> +       /* Set LED Active High unless active-low was requested in DT */

Why the comment was changed if it does say exactly the same thing?

> +       if (priv->led_polarity_mode != 1) {

This change is O.K but I would ask you to better clarify this. -1, 0 and 1
is very confusing here.

I would introduce a simple define like
#define QCA808X_PHY_LED_UNSET -1

And set this in probe and change the condition here to directly check
for the macro PHY_LED_ACTIVE_LOW.

>                 ret = phy_set_bits_mmd(phydev, MDIO_MMD_AN,
>                                        QCA808X_MMD7_LED_POLARITY_CTRL,
>                                        QCA808X_LED_ACTIVE_HIGH);
> @@ -603,6 +603,9 @@ static int qca808x_led_polarity_set(struct phy_device *phydev, int index,
>                 case PHY_LED_ACTIVE_LOW:
>                         active_low = true;
>                         break;
> +               case PHY_LED_ACTIVE_HIGH:
> +                       active_low = false;
> +                       break;

The ACTIVE_HIGH wasn't a thing when this was introduced if I'm not wrong.
Anyway this change looks good. The only problem is that I feel it would be
better to split this patch in 2 different commits.

This really addresses 2 different problems and splitting also makes the commit
description easier to understand.

One doesn't account the case where phy is reset, the other doesn't account
the mode in led_polarity set.

>                 default:
>                         return -EINVAL;
>                 }
>
