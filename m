Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793308261;
	b=udc3lucOrOqtvGET6+6uFjyudc32WpUAAlCc+BVsKbu5Yk7geQRWYDUpulqo7KmlIpS+
	 PML4MdmLMhFQqxS+nqv80cuMZjAarbKKtc/9Eo6OT1sukKm01HMvhzKmQWp+F0Y3Rn767
	 HrOQGrb3Ghgj834GTbq8/aG2TCDAurfWBiBOlEjmSPO05aJG299UY1HCXe0Zom5KLlLRB
	 P9/KAxzfNAYRiZM5R7BB7SSg/MzMdy5lhEKY4AXBQDClpVkj4Hu3iHyhOs6XbvDlOcPWi
	 p+cBEXXytzVo9wiB0o2AQm8TJPXtA+ssyiMt7gGotYjxE3CbiKe2O+lJk0prX8U7qaw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793308261;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=9osQKVV1wtsQAS7vDLfnrjRdubZ+d0or7yfUi9GRVJw=;
	b=22GgmdVrIsEVS37Ue8Yp8dKbbZ5SiRpW0rRLDTGbjYvz51dfsC1Vxdn7iOmNx0jqxNTo
	 YJPLKzYat8pZGmuKavG4JVSvdvxJLz/bpKT9DGaoPULXCkE9jYZyvsnKoXkyrGP7iw8vL
	 PEkLJuhOum8L12ivl/9dhJASUZEvhz4MFha+MIQ3RrsKOiXzYZmZvjXRO7IhDO79ablWf
	 XNZjFVhogIIq6ji7umlnvZlWPJVKaaV9IiHLtoV6rNwRK4E/xO6IAexbHH7X1iXZ245M0
	 wYNsWAiKyPpPfZcMM8PofsDpHChmsc9dObdbnKacCzUcSmcxc1hcHBxpQtrQQwHMcMw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lPqUth3e;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.42
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1DEC606A31D
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 21:11:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1DEC606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lPqUth3e
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-8459fdb1e17so21839a34.2
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 14:11:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793308259; cv=none;
        d=google.com; s=arc-20260327;
        b=DWTT24BhMbt8lcb1LwFJXZAltFHWFEzI6K/5waean37qjqjwgEapisgGihk70OhSz7
         WxXojUpRL4Wyw7+zSzSE+GAd9x1b8IYd2fd4XJ1oJGaMTdzkKtJv5ZwMjII4TMq/hpFe
         LizlDagMlciG3TI9+mWP/Rwlw6wDANWMb+4EDskiXX3/ldU9D8WBQqbofErm/qgSTfXP
         NzT+ouv7h4M7wsqE9Vf5L6lm11syG6g139tbiwrgKUpvjiJhD2FV2xd7e3toB4bgTtZO
         Y4J6NCvvOC+lSPkLJHFwmi11Bdh32B76y7VHFh/SbOeYgWkpbje0gLrlQk8c4ab7eFeh
         tIHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9osQKVV1wtsQAS7vDLfnrjRdubZ+d0or7yfUi9GRVJw=;
        fh=nma0JkuurH+k9fQo1r1bDnASnUhWk57TxD2YLOXNngI=;
        b=nwuexMq18HhneTFC2EJEBCT8k6t3RtkMPYu7vi0ZuBWj06LOb0lR3BuHwWMW/opHSS
         uoSpS5yueMAv9v+VyREUcM9qimoiaRZ86zCHOThfsfxSH5y5fzOzcYVklHE0kETgdgNq
         xvS/0vtUW/UE7b16bP7+cqxWQFEwGrtgFPj9j+Khr+VamSAQWPgXKc3B8neLihxXBwXE
         uFNw04WXc6BIgwRhpfYEvcV4a8iCHxwxwCorS1bdrN7R3H3qaDa1Qghy2R59dh6zYRCh
         SMLz7G5lNtl9kENRnCUmhJQ2sOLeDW/uMEyi6oCrsNrnTNKu5Tn7gyFjvVLZH3QRL55/
         K4/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793308259; x=1793913059; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9osQKVV1wtsQAS7vDLfnrjRdubZ+d0or7yfUi9GRVJw=;
        b=lPqUth3eKO/Y0px5tRNis80GtDFfhKR/ac+GaCcUufT9DAd9jwjxOUq+6t80jkl3sB
         aaENgRatOdAZgU8v4Ou73MS/OVSGwhYwU7e4Zp65EZD/6jZZyHcIMs/d+7FmUCTtgA84
         Ekp0crgzhvlyTn62Q88wCJFWdG6YzPyz0mQBNl9Hc//hfO4Z29AdUe8Lmg21q4imaKml
         5IMEzu6AJeUpNKT+Yd95pJNGJIf43zgfueg3GugoQEecW76U+MPLscTslg0FaO5QDiEu
         Ia/eFGaTMp+p+70dXJyNhKiLNS6xHxmCVOLtfpydwHMz0KOXJshICjFYIW/QT87mRlo1
         0gjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793308259; x=1793913059;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9osQKVV1wtsQAS7vDLfnrjRdubZ+d0or7yfUi9GRVJw=;
        b=2OQY5YEcBEX3JjA0wyUt+13AJY9aZpuL/rIacXwYEF3iwof2xxxYLldauEOo6OYySh
         VPrc/IW4qwFRt+gzQUDZsdPE4PhFD0ffu8oebwWgvBJLLSAd3JxTpGin1tq00Pi390mF
         DZssuCzDN/a5nEl18NqrUKAgcH64B4DDVsPp+Trc+9E3fGLoLDTMVh2aladHl0hmwhc9
         rQuisDUDmHMcbguwPz+HlIeIs1WAjkUKW5OFL/caSdRiqM+aamQNZYlDqj2nF9yyYW+G
         HB+75MOros8s0Xvcj2ZKZzUNdtgxt7GRRHdHVR02FDWU6jAF8tqAnDQls2Hee8TKKL4i
         UpLA==
X-Forwarded-Encrypted: i=1; AKwUvBwsdGm/424ORf4fN9KSruorW2ARcu287FENTsZD7JkuhdQxI36zFrgngyVA7cp5XclUcmEctzA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKTMIfjGgtVeYyzmDyfXNYsIyM/t7ALw3dkxs/oVledqH6REGWE
	BxoR9oN4Ioo3HSqNVbJz/bauHeIIT1Yb1aUbh7A2yB9S4Ty2mztoAn3TK4LlTi/sD0rXvb0GiAq
	foIMSHs2f7WI7gGWc5+QSBc5+kbAqyovgjW1o0yU=
X-Gm-Gg: AYBFou1KYxo0L4V8GdzvcGzTil2IbMaxHE8sdAXKz+12g98uOgKnMP0BxeK8gOjdtm3
	o2vtmHjsIQfmdXGIEdMbqSjWHCm4Zxd7EK7uBYc4nC4t91PRlITB3RSkk5GdvSRPk5wDGDjsbrW
	e1IBxSbFT4wb9H9N3eKV0KiqxBLTUUcadrXXywo3GuG2M1y1XRZoIbEcF7xYtDIJRTNQMgHsrQ/
	fE3YDDs9vxoZNOvOMvKj8cnRoih0N+jeOkSQQv2FklWfM4IpAYsptEmQKhMBp0uYozXTileZ/Dh
	XkIplhCLwrgw7DFZtoAK9qGfY0WBLR8esUshvoRynTMcgoeptwyINAjmn8CP+0cMJNQXenOOB8A
	q1BtCcdvkX7gjQ2eTeODaMKsNzD/W36atGHoSjXwCiyiDVikgSgOAZkiT+xANSf1v5ehTEX/NeQ
	==
X-Received: by 2002:a05:6808:2219:b0:4bd:73d9:85c7 with SMTP id
 5614622812f47-5640d62be8amr717746b6e.0.1793308259501; Thu, 29 Oct 2026
 14:10:59 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021-netcons-fixes-v4-0-3857120c6340@gmail.com>
 <20261021-netcons-fixes-v4-3-3857120c6340@gmail.com> <auBrysA0RUkVlTOA@gmail.com>
In-Reply-To: <auBrysA0RUkVlTOA@gmail.com>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Thu, 29 Oct 2026 21:10:48 +0000
X-Gm-Features: AclHuK_lhhdW3qGKBlVfZfDNDceq2jZZUkfDOPfDKThGEP0H147Qd10qhtEEAFA
Message-ID: <CAGSyskX4mJJT=VTrS43pWG4UyoJur3hxQ56Qe9MMRL5-c2nnXA@mail.gmail.com>
Subject: Re: [PATCH net v4 3/3] netconsole: recheck device registration after
 waiting for carrier
To: Breno Leitao <leitao@debian.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stephen Hemminger <stephen@networkplumber.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 9:19=E2=80=AFAM Breno Leitao <leitao@debian.org> wr=
ote:
>
> On Wed, Oct 21, 2026 at 03:19:07PM +0100, Gustavo Luiz Duarte wrote:
> > netcons_netpoll_setup() drops RTNL while it waits for carrier when the
> > device is not yet up. If the device is unregistered in that window, the
> > NETDEV_UNREGISTER notifier runs before np->dev is set and has nothing
> > to match.
> >
> > We might then end up setting up netpoll on a device that is being
> > unregistered while holding a reference to it, stalling
> > unregister_netdevice() in netdev_wait_allrefs_any().
> >
> > Add a check to confirm the device is still registered once we retake
> > RTNL. Release the device reference and return -ENODEV otherwise.
> >
> > Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261012-ne=
tcons-fixes-v3-1-1aac85ed7665@gmail.com
> > Signed-off-by: Gustavo Luiz Duarte <gustavold@gmail.com>
> > ---
> >  drivers/net/netconsole.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> > index be7eb632ee42..bd36ebd334aa 100644
> > --- a/drivers/net/netconsole.c
> > +++ b/drivers/net/netconsole.c
> > @@ -534,6 +534,16 @@ static int netcons_netpoll_setup(struct netconsole=
_target *nt)
> >               rtnl_unlock();
> >               netcons_wait_carrier(np, ndev);
> >               rtnl_lock();
> > +
> > +             /* Check that ndev hasn't been unregistered when we relea=
sed
> > +              * the RTNL above.
> > +              */
> > +             if (ndev->reg_state !=3D NETREG_REGISTERED) {
> > +                     np_err(np, "%s was unregistered while waiting for=
 carrier, aborting\n",
> > +                            netcons_egress_dev(np, buf, sizeof(buf)));
> > +                     err =3D -ENODEV;
> > +                     goto put;
> > +             }
> >       }
>
> I think there is a better way to do it, inside netcons_wait_carrier().
>
> netcons_wait_carrier() loops waiting for the carrier, and exit if in
> time_after(). I think it will be cleaner to exit there.

Yes, I think it makes sense to bail out of netcons_wait_carrier() if
we detect that the device is being unregistered. It doesn't replace
the check under RTNL, though, since the device can still be
unregistered after the loop exits and before we retake RTNL.


> then netcons_wait_carrier() would return a bool, and you goto 'put' in
> both case (ndev->reg_state !=3D NETREG_REGISTERED) or in the
> time_after() exit.

Do we really need to check the return value of netcons_wait_carrier()?
If it detected that the device is being unregistered, then
(ndev->reg_state !=3D NETREG_REGISTERED) will still be true here, since
reg_state never goes back to NETREG_REGISTERED, no?

Or do you mean to fail netcons_netpoll_setup() not only when the
device is being unregistered but also when the carrier times out? That
would be a considerable behavior change, because then a slow link
would fail netconsole completely instead of only losing the messages
sent before the link comes up.

I'll keep this patch as the fix for the missed NETDEV_UNREGISTER and
add a separate patch to bail out of netcons_wait_carrier() early.
