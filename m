Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371594746DF
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 20:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785270823; cv=pass; b=lGiNhRh3TH2912op9kxZp1iyE/hHCXCJM8P9VlA+wqBPPd7b9IexcO7/RDvxs/iaJhvWubCqq32nIPzku4rsvoykDyk0RFSc2bYEDwziB0T6+QM0z9wZEbzlnErEqyP/nWNRSPyWvvyJY2k85j5tOL3KULHjiPWTkGJCd+sdV8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785270823; c=relaxed/simple;
	bh=FVe5U8Ezhe789ff9SNtkM5DXUXnSnyD96QX8hKTRQVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RQa+AutTuoa5/iGCb+8ktrbz6nWiHBhJH5RdO/ItE2ueC7rgt0ROXPP1DiSDC44ScCS5xLtiMK8Y8X8foS4tgeCgYTPiKAYJLehtvUXNAfyTNrSxcOvvKedUAMx/hcmESo8Nep3rYsUcY3Phw6L9nABA/dMjJ20xSM2WeKcgoYc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K9NtdIpK; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K9NtdIpK"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-698bf053053so273990a12.3
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 13:33:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785270820; cv=none;
        d=google.com; s=arc-20260327;
        b=DPjpjAAFP0KhRnPQMEE68oVHMNzWuah9E9quyMjFZRNGP4CYgNvAJh+gE4kQ5Pbtsu
         I8z/Xk19JHe5Un2EsEllTs76RE5DNWcyQeB8N63U9kz2oRBhzpExCCMfHkdTkGiEhTf5
         fDZkCyuXfl74GC41cIBPM2bwVgQzgPuf7Ey6VJU6JlcnNDF7iN8iqhD3SgZI/IiGHiTw
         6735toCI5xiMnLa3FLDopSHxMXUi3HtwOt1MxFd2kKbQcdD2k7pf6beA/STEm7i7xrqB
         twTmMRHTAKQLxdL9frfsstFq7n2uQuZif/xHxB6KFpccIcQ8pXav4oJUujNuyd5ybggD
         u2sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=uuHPjn3PKoVMpCmx0pcutk3UpRQp0c//Bcfdow0HYRk=;
        fh=fbwz1X0bORBjFkpZ7J49UF+LKefxZr8I5e8O/M1t3h0=;
        b=cExhen5/dujLQFYerPSLgNeREC9zmZCDM3phvKTwkYRBgeaFPqnnBTiE6JKYXRJ7Hm
         dBopGTlQSSvqdfOKr6q9BW0kf24lboy2IL5NoxV0P7FN/SnF4Fujo1qKkjgjoPoyz2u+
         Ia9WFODqjITTsYuNz39EFoOjc/cjJn3HLyQZHANfICse4kLsmBBKwO7/Csmz7lt1mMoW
         rqF3u4x1S7wEhnGsW0ZN0rb9VuC5jPLdiGuXHoVUQV5ygT5yx4ThzKqKQ9TWqhxioYNM
         qoROWcmar3pTLFVC9Ir7D+W7N+zTe+PKNkjfkBh5zE39iWRi8Z81Bp4C0e0Sc/dDBUfo
         nGdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785270820; x=1785875620; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=uuHPjn3PKoVMpCmx0pcutk3UpRQp0c//Bcfdow0HYRk=;
        b=K9NtdIpKutyaXZ97DM0NQ63Fc2r5aRHNZQDvSFr1E7BmWi5WYopXH/kfFhYQf/t7Ap
         mEPtZUPzRgK+i31o42sGp0NMrRcub3rt/gnoNrinsnDm0ELTg4BV92kHtrQLCrKWAEGk
         uuPpAsvl6hxgsmeRXnF4XNMciTu0s7f5M4A+cX+07NX1Elc9V1zZPIIUHq5I/Ixpb8en
         X0GmR32/hXxgjpVrjyNCi3P4RduE1ij+lDHszIVOAZSHSsolWC81jzL7IYH1DFQ1yogC
         Xq3/QkG0sRt4zxn6n4RhImXaBqHAIObU7rfSqTUk1+VYMJWhlvu60hqYuj7z8naGp9Bz
         PQOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785270820; x=1785875620;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uuHPjn3PKoVMpCmx0pcutk3UpRQp0c//Bcfdow0HYRk=;
        b=C+6G2qpk3fppCHtgNc4mzIBwJglHP4WxEkUZt/ZcR9p/lMiABF6yrDh3x4hynTjoad
         6TmuJ9PGN0MwnFzq/nss0xnL2MRf41E1Co+VMsx6Jy8iBaJ/I6Zm/YDJ/2nu1Dm19t9l
         MYSkktMekSsQ8Uw006XeI9QKazJG9DoC/to2fbPt9t1RefdC3UnvTnnizJtKHxLITOmj
         gsYW4N/QG5XIVE3N8rh1HRy5hd2dDbWk8wE4IQRqom1rD5ZJByYLYEi/dtgGvffJOeyg
         Tg0EduSI6AXeTpGnVFLwtBS1IXbynuoeWH+hnIoBp6KRsQCAAubgCS7rcScRFhIMqN5x
         iwnA==
X-Gm-Message-State: AOJu0YxRMVSRmImaMqcmCqkvUS+6Rfz9cXiqUl6NmXPXWTvktVtwe0wC
	d1nT1TYZErPN/FTFMW9yPzzUJgYk3CP1rObEjzNKiJGLhUN446+nmLglOh75dom8GO2zZFD8tQq
	RdJWqDtgd/PNRv4dYZuROaCSXTowI4+A=
X-Gm-Gg: AR+sD11dtN1b1XSdHyoDDUCV995B7tgNj5B/Frf4uuuOqFRk/59aq6LjoV2G0rRCAV+
	1uUOfOUmmbw7DBYpfbtGZIYaV1zwcs9MKUN+HAwJjPL+CLBXluCCbyNAYChPk6r0XfcjxOs1osd
	g/DwvOvPN+gDtdlEGHhFEJIhRKG7uGgS3wJVk5oXqMauQDehvhiAGcZNtHtwuBeUVKTdAWds3ln
	KIHbiUFekR32P/YDFodZngRNZfsWvIawx7eora+FeFD0HlSbADyUJB1aBFtCNnHz4xyKp9RcMJc
	uDO53FO165FVtoc+90ypc0RNE8Hbf77dWvsYkJNkyp//RIsFplomxfw6uqdxOTdXpG0ZLg+uRfe
	EsDAyuYcHBJGtE/VoQOOWrCjI/D7CtWbctBgGJamBbJ8TJP/3m70AqWBQFkIrZCS5mn2P8WSN
X-Received: by 2002:a05:6402:3605:b0:69f:e3cd:5ae3 with SMTP id
 4fb4d7f45d1cf-6a034a5457fmr2077489a12.24.1785270820245; Tue, 28 Jul 2026
 13:33:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260727234049.287278-1-rosenp@gmail.com> <CAOiHx==kU-CHtL07OfQcxzOjdnzYwhO7MnS+WD8wcCRC8Ce84g@mail.gmail.com>
In-Reply-To: <CAOiHx==kU-CHtL07OfQcxzOjdnzYwhO7MnS+WD8wcCRC8Ce84g@mail.gmail.com>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 28 Jul 2026 13:33:28 -0700
X-Gm-Features: AUfX_mwiCnZb_k1eJ0QfdZtx5w0RrqmriOzybMogqTqn7jT-YYy6AZc8zYncjmQ
Message-ID: <CAKxU2N-C9oDkSjz_BDuRAcbs5ZGBxUnNiBMF86v4nr+8X_Ceug@mail.gmail.com>
Subject: Re: [PATCHv2 net-next] net: dsa: b53: srab: propagate errors from
 init helpers
To: Jonas Gorski <jonas.gorski@gmail.com>
Cc: netdev@vger.kernel.org, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 28, 2026 at 12:59=E2=80=AFAM Jonas Gorski <jonas.gorski@gmail.c=
om> wrote:
>
> Hi,
>
> On Tue, Jul 28, 2026 at 1:40=E2=80=AFAM Rosen Penev <rosenp@gmail.com> wr=
ote:
> >
> > Convert b53_srab_prepare_irq() and b53_srab_mux_init() from void to
> > int-returning functions so probe failures are properly propagated.
> >
> > b53_srab_prepare_irq() now returns -ENOMEM on allocation failure and
> > -EPROBE_DEFER if any port IRQ is not yet available.
> >
> > b53_srab_mux_init() now returns PTR_ERR on ioremap failure instead of
> > silently ignoring it.
> >
> > Check and propagate both return values in b53_srab_probe() so the
> > driver core sees the real error instead of always reaching
> > b53_switch_register().
> >
> > Add error handling in probe as a result of b53_srab_prepare_irq().
> >
> > Assisted-by: Opencode:Big-Pickle
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  v2: address memory leak in b53_srab_prepare_irq().
> >  drivers/net/dsa/b53/b53_srab.c | 36 ++++++++++++++++++++++++++--------
> >  1 file changed, 28 insertions(+), 8 deletions(-)
> >
> > diff --git a/drivers/net/dsa/b53/b53_srab.c b/drivers/net/dsa/b53/b53_s=
rab.c
> > index b9939bbd2cd5..289504321f3e 100644
> > --- a/drivers/net/dsa/b53/b53_srab.c
> > +++ b/drivers/net/dsa/b53/b53_srab.c
> > @@ -531,7 +531,7 @@ static void b53_srab_intr_set(struct b53_srab_priv =
*priv, bool set)
> >         writel(reg, priv->regs + B53_SRAB_CTRLS);
> >  }
> >
> > -static void b53_srab_prepare_irq(struct platform_device *pdev)
> > +static int b53_srab_prepare_irq(struct platform_device *pdev)
> >  {
> >         struct b53_device *dev =3D platform_get_drvdata(pdev);
> >         struct b53_srab_priv *priv =3D dev->priv;
> > @@ -551,18 +551,22 @@ static void b53_srab_prepare_irq(struct platform_=
device *pdev)
> >
> >                 name =3D kasprintf(GFP_KERNEL, "link_state_p%d", i);
> >                 if (!name)
> > -                       return;
> > +                       return -ENOMEM;
> >
> >                 port->num =3D i;
> >                 port->dev =3D dev;
> >                 port->irq =3D platform_get_irq_byname_optional(pdev, na=
me);
> >                 kfree(name);
> > +               if (port->irq =3D=3D -EPROBE_DEFER)
> > +                       return port->irq;
> >         }
> >
> >         b53_srab_intr_set(priv, true);
> > +
> > +       return 0;
> >  }
> >
> > -static void b53_srab_mux_init(struct platform_device *pdev)
> > +static int b53_srab_mux_init(struct platform_device *pdev)
> >  {
> >         struct b53_device *dev =3D platform_get_drvdata(pdev);
> >         struct b53_srab_priv *priv =3D dev->priv;
> > @@ -572,11 +576,11 @@ static void b53_srab_mux_init(struct platform_dev=
ice *pdev)
> >         int ret;
> >
> >         if (dev->pdata && dev->pdata->chip_id !=3D BCM58XX_DEVICE_ID)
> > -               return;
> > +               return -ENODEV;
>
> I don't think this is correct. If you look at the b53_srab_of_match[]
> table, only some srab devices have BCM58XX_DEVICE_ID, so returning an
> error code here would break probing all other srab devices.
>
> Just returning 0 here is not enough though ...
>
> >
> >         priv->mux_config =3D devm_platform_ioremap_resource(pdev, 1);
> >         if (IS_ERR(priv->mux_config))
> > -               return;
> > +               return PTR_ERR(priv->mux_config);
>
> ... since some devices don't have match data, so their pdata is
> unpoulated and the above check would still allow them, so they would
> then be rejected here.
>
> So the above check should be if (!dev->pdata || dev->pdata->chip_id !=3D
> BCM58XX_DEVICE_ID) return 0;
I thought this as well. That was v1. Guess I'll send a v3 the same as v1...
>
> Best regards,
> Jonas
