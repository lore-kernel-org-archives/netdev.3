Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD0F2C026C
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 20:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787171246; cv=pass; b=KXGm1dYhgW0KplKSxZvqZiC4I0j9fNuG/EqtZInW5XFj5ubZIHPRWdZJFGHNpXPSo7LMMLFiN5+WrgpBLBXy7sQr6ZWZfuRFzugn95RoyIIkBSrwNDXfw97deVREszgpVYhzoNe8kTjQbZ2NtW//eCBwY/8DqIblqU3LKPW7uwY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787171246; c=relaxed/simple;
	bh=IuI9ArsXBa+KjukmdCWP++NMKTFTvkvUthwrRKEqqvI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QlAQvrUM884Z4+2crS3dLLxol8llc9nTAI5rhkRygbl1niQYm8Z4kFutklZ1NvkwKUaUmL54AyCz7rkD8enkM3n7eqy+V9BLUjEaN2hLBUom7QmSpS8NHfUq8RB2NVfg4jwMdlIDbNsNgA0bWQ3cFSbTgDvP3cuHy3cpPk+qfg0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pE7j50Xu; arc=pass smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pE7j50Xu"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-44cb057311bso1176964fac.0
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 13:27:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787171244; cv=none;
        d=google.com; s=arc-20260327;
        b=dpUDuc5YVzbSkNBS8zndy1mj9xGANg6FElganRU6vsN/UqNyNeidACieh+NDsfRbIQ
         yA+1PFuc/9wI1+XLh/A/J0eH/2mhpE3xzh2ZZHSMWxtjI08di2zNZmfekbq/TtoUEYqM
         WqSusVVemJiogQR9knEj5d//a31oXSO3ubQknu4Nt8uOPLYesq+tJu+stvYnZqJXWVej
         tr5H0Xb64fzSfqac4JhxibvG2eHasjVOWKtFdFLDRwun1wb8X4W4bXdHtHoCrEJSTX4X
         lnFgFSlOngKecgrfvnI9ezjOzKkir96zzISHn0H5reR9cFc7PK59vxcPnpldg1RYVnRr
         1MFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=WAaYWTPdjZdhu2lEVmJlskXIJIAxn2bNm4PbdW3h2Wc=;
        fh=zD9W+mVNL8o1i3IWy9PCzxLV5x06VFZf498JS4OljUA=;
        b=kGDbQ5C6qBVgQ7sW7YQEKn/kUs33yC5aMc078ukwyzx2nlT8SfMXmN3g47RPDMf7zb
         V+orQC28rn9udj29OIN5TmAdNvUHfEN7JLQnxBZAEEbzjEBLqp0XFSuaiNJ189NwoJgk
         U9piQ7GoCEriBNsUtZJK4KZZvALb+9Ny3xy5eym+nJtGf3wVGXA6NQRs+I07I3HVTWEW
         g8DLKOArVv3UkrqiB4rRpZHjyVDBo2O/GVZI83RyMkoSh/PdAEsaPH7wpm/UShRf0WyH
         a6wCS/I6XmC5gaH6BSrzUGnEv+3RVoH4REofHPhsnb8Xt8BeSQct4eN17ZnQHk2ZPr3s
         ZHVA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787171244; x=1787776044; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WAaYWTPdjZdhu2lEVmJlskXIJIAxn2bNm4PbdW3h2Wc=;
        b=pE7j50XuA2CtA9rwLWqCmM49mEfaNZ4zXGBlKviNHz2nQIWW8nW7ci+hISlVswHRw9
         l9qfm2SdqTuKhXEe6Lr7J6V27HKX5as3pT8c09AMXj58YdZ02nTEqyhzCwlsDLmClvdc
         jmronDBHjR6USlP7cFo/pzmihPpqV8e2bxdLLIzha0mT4rHturvJGXJfM67VOtVFz8Zq
         RavBpmTWFxu0RwFQJrv9LAq3tcVAmySuYh6kNLRcALzIfOr7PFCpLg7pQoBVYPI4wAQ9
         OWOUj3lDupWBHp/SKUCI2BhDTuaJXQ8r/JJyajBgLCqPFijWZ9R+ylZOb+/ien+2JxYq
         bb5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787171244; x=1787776044;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WAaYWTPdjZdhu2lEVmJlskXIJIAxn2bNm4PbdW3h2Wc=;
        b=na0OyzboOdMLPToB51nYbmLR+uYMnOCFwxapQe+Hr1OT+cgtDSkualRReirYs6FHre
         YjjuGS0kgzj74WMbGMaUsqrWNDMBGEhh1f2eED4HBu2qSA27CV9dVqVtKI9/D/d7ywPU
         G5+2+0ZWlJxibIf2QXssDYjLhFLoe+F6PHL83DPy/nTkxIvWgqi7dGqY/QqovQ7HBv2Z
         DTcBGgvGPQuMOfIpmZCSTRxBd7V3uKCrGrOdcLVREydmEzMerKLobbt95C3nP1mBsv1Z
         yrfj2fkTes38rg8KKHxK3nKiHpZjwMwo0t+FYB+siByURX5lBoGmSiM8+WtuovIpjppb
         7Dkw==
X-Gm-Message-State: AOJu0YwU1R7pS/6lc5l6ptWof4mDDX6kttJcBZKOpnm0/CdGrBaLribS
	uGa0d06I3LX+OTU1XNbcYy5fYN91lKpW9Untf+gdhLRZj2s7mLTSFGBNtT/Cbfosi4vUIuzUSon
	ey9lTeCdyauRn+uLuFMW9HfxpbmkP5R8=
X-Gm-Gg: AR+sD10qziBh2rWvlcoCZWkJHVa4Yfh+lyoWoGY+x9V/bsoiSQzakEDdFXgWbknpeup
	XRyLbwH1yziKNs+CWETzQSE67F+6/urkw5Aofl/C5+oHC8mDHd6k+jcDvksdByOHkbxSqh3Vxd6
	nY5bSK10xlEdrf+hp70N5VgTP4v/UUIK/VEu4Tc9DzYhjHXT/U6zdDiUii6a4mmeClP3C4WXycZ
	3VR/ApCEr6UvIkiX3DPpOxXsTHY/9KiYPr+WJk+KBfoOemlCH1xY3MzUDRT03KxktY7+KqbX8Q8
	6MCr4pSQ/wwEGAAEJ5eHMjbjFpEl7YWo/7sQzSsjHXkQJsNfzw1WAJ7n4eZjDYJX9qvD/0RsOzf
	YeWSptO5ciOAp22I3Ww==
X-Received: by 2002:a05:6808:4fce:b0:48b:5dcb:85ab with SMTP id
 5614622812f47-4b2bc9a5f1bmr6676268b6e.8.1787171243751; Wed, 19 Aug 2026
 13:27:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260816193905.218112-4-mmyangfl@gmail.com> <20260818171027.4020346-1-kuba@kernel.org>
In-Reply-To: <20260818171027.4020346-1-kuba@kernel.org>
From: David Yang <mmyangfl@gmail.com>
Date: Thu, 20 Aug 2026 04:26:47 +0800
X-Gm-Features: AcwNN1XdkSBGFMcpevYyOrH9h5-_3jHwbxITx96-MyaoLkzIBsanpPveobuyS5Y
Message-ID: <CAAXyoMOJBRg9h9RDOi+PoQkH2GcB89u6DZs-aK7CjvrDzr2JYQ@mail.gmail.com>
Subject: Re: [PATCH net-next v10 3/4] net: dsa: motorcomm: Add LED support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 19, 2026 at 1:10=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
> > @@ -4581,6 +4580,12 @@ static int yt921x_dsa_setup(struct dsa_switch *d=
s)
> >       if (res)
> >               return res;
> >
> > +#if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
> > +     res =3D yt921x_leds_setup(priv);
> > +     if (res)
> > +             dev_warn(dev, "Failed to setup LEDs: %d\n", res);
> > +#endif
> > +
> >       return 0;
> >  }
>
> [Severity: Low]
> Can this dev_warn() ever be reached?  yt921x_leds_setup() discards the
> result of every yt921x_leds_setup_port() call and has a single
>
>         return 0;
>
> as its only exit, so res is always zero here.

yt921x_leds_setup() is allowed to fail (not now, but in the future),
like all other init callbacks.

> > +static int
> > +yt921x_led_force_set(struct yt921x_priv *priv, int port, int group, bo=
ol on)
> > +{
> > +     struct yt921x_port *pp =3D &priv->ports[port];
> > +     struct yt921x_led *led =3D pp->leds[group];
> > +     u32 ctrl;
> > +     u32 mask;
> > +
> > +     led->use_cycle =3D false;
> > +     led->use_duty =3D false;
> > +
> > +     mask =3D YT921X_LED2_PORT_FORCEn_M(group);
> > +     ctrl =3D on ? YT921X_LED2_PORT_FORCEn_ON(group) :
> > +            YT921X_LED2_PORT_FORCEn_OFF(group);
> > +     return yt921x_reg_update_bits(priv, YT921X_LED2_PORTn(port), mask=
,
> > +                                   ctrl);
> > +}
>
> [Severity: Low]
> Should use_cycle/use_duty only be cleared once the register update has
> succeeded?  If the SMI/MDIO transfer in yt921x_reg_update_bits() fails,
> the LED keeps hardware-blinking while the driver records that this group =
no
> longer uses the shared per-port duty and cycle fields.
>
> The same pattern appears in yt921x_led_trigger_set(), which clears both
> flags before two fallible yt921x_reg_update_bits() calls and never
> restores them on failure.

IO transfers are not expected to fail. If that does happen, we won't
have much control over HW consistency, nor can safely revert the
register changes. In that case, sacrificing an LED seems a better
solution.

>
> > +     /* The chip seems to jam a while if changing duty directly */
> > +     res =3D yt921x_reg_read(priv, YT921X_LED2_PORTn(port), &val);
> > +     if (res)
> > +             return res;
> > +
> > +     ctrl =3D val & ~YT921X_LED2_PORT_FORCEn_M(group);
> > +     ctrl |=3D YT921X_LED2_PORT_FORCEn_DONTCARE(group);
> > +     if (val !=3D ctrl) {
> > +             res =3D yt921x_reg_write(priv, YT921X_LED2_PORTn(port), c=
trl);
> > +             if (res)
> > +                     return res;
> > +     }
>
> [ ... ]
>
> > +     res =3D yt921x_reg_update_bits(priv, YT921X_LED1_PORTn(port), mas=
k, ctrl);
> > +     if (res)
> > +             return res;
>
> [Severity: Low]
> This is a multi-register sequence: FORCE is first switched to DONTCARE, s=
o
> the LED immediately follows whatever activity bits happen to be programme=
d,
> then the shared YT921X_LED1_PORTn duty and OTHER_BLINK fields are updated=
,
> then forced blinking is selected.  Both intermediate error returns leave
> the earlier writes in place with no unwind.
>
> Since the conflict check earlier in this function trusts use_cycle and
> use_duty to decide whether another group owns the shared timing fields, c=
an
> a later request silently retime a sibling LED that is still blinking, or
> leave an LED driven by stale activity bits?

Again register reversion dilemma.

> > +             yt921x_leds_setup_port(priv, port);
> > +             /* Allow partial configuration: LEDs are optional */
> > +     }
> > +
> > +     return 0;
> > +}
>
> [Severity: Low]
> These two functions are the ones that make the dev_warn() in
> yt921x_dsa_setup() unreachable, as noted above.  Is the "LEDs are optiona=
l"
> policy meant to coexist with that warning, or should one of them go?

dev_warn() in yt921x_dsa_setup() is for interface consistency.
