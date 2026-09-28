Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com [74.125.228.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E8C3D47A6
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 12:29:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598595; cv=pass; b=TYFwyawtEITuTos+aM1UkXSxxx07BU+Po/vDwnjPUfEHss/n9PlXJfNfkjwJKtenEQxFNBFRhmQdt8txRDPdT1snaxpMtMSI30lEdEfPXlvFtfNmwM9Ys/Ghe5eUmn9BWgJjIIiKADA+mczaZ/azxggs8w4OEmHrTsdhlsBmWt0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598595; c=relaxed/simple;
	bh=xEL5URHcePqM5nbi5/mukI8PUvnbitE33QoPlYESpEw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lN2EXEw27x8MEvgnLXdcnkrxlrSZBHRDmJ39Cj88xbVbswcnB3zMzCf8b1EYoAQv0a7ALUHq+u1VpOHduxos5bbM6pPr9c7SlLpbwCh23kwA04Hb31aXo6gLbIPssw0NmSGd3lcE9bbVpmzbuOdgX+nlZr6vda0vQdqGdqFIDhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr; spf=pass smtp.mailfrom=sartura.hr; dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b=O9ts7O2W; arc=pass smtp.client-ip=74.125.228.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sartura.hr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sartura.hr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sartura.hr header.i=@sartura.hr header.b="O9ts7O2W"
Received: by mail-pz2-f39.google.com with SMTP id 41be03b00d2f7-cc78dd54610so930638a12.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 05:29:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790598592; cv=none;
        d=google.com; s=arc-20260327;
        b=W6vR7YQ0ffzbO5dFpexERHscAgIcI1R46Z/O8hFiiiqNcWIdg2P0H5Dq2TB61qJjg2
         2Bve76k7Ogq7guTja3uyb2v4RTBU8I8HKmC3WNAwh17bhdkkoneO0auI4Pg/sgSQkl6H
         3gz/O23fP2nzsTbmuzGLx28runIhCG8laYOjSccv9iDQGVnw43bA8BGOFngepwytkCFd
         /l01bj8J63ogbCStBheUm/HmKkZDofm8R3d3HlMm1mj5IUarhKURjgc8pZuhg05sp2A0
         CnWkh8K7GtosMlSRw2QMO2iYyB/5GnykGcp/219878CAvKTBa7ITAUXT5yDSObCDIKpo
         V1pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lkBawcJZORsxZeSYcvknPN1o23VT6bn/NSzgx7OBRD0=;
        fh=ulPH71by4tkgLTfrhmyKICaithV4StJTtz8QyrRvtMY=;
        b=TRmVOXOjUZ3+hWH/wtqjSPRlTJo6kbFsu+xylKaUi9gUCW7p4Q3L1uVghjzfkjyk8H
         fCQ4NhldDc9aHFNyWWNcvgBGJtZzOPTILTvg4w4f3rH+A6Fplk+VmJ1wxlN7TmCmB4mJ
         mljySuQCBU0o4DxcAD/nZ+YVgpcu5d5R+QapE44Qx9mBFKB9jMn5CnOpe4pVxcrxg5go
         /xlNyKT6jVcWechYRwdaZ/sVlTzVx0q0oV8VfHRWtKwZ/gE9yKVQeVspx+5jLOZ/IT65
         UVhSwrNSyRImm1kpg9ZXEnxTR2d+qx6U3xGJmKFG4jxJtIUOBFGaUqHHle1es31V/UjX
         6obQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura.hr; s=sartura; t=1790598592; x=1791203392; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=lkBawcJZORsxZeSYcvknPN1o23VT6bn/NSzgx7OBRD0=;
        b=O9ts7O2Wr5fi7gySwHhPrDrpQ+m4+lErPU5pHrIE++5dMfKzGxvYu2wNbU5+I/hgFS
         ZucpOsIYfvlPnnP54mHZsaAqCkcfKLMOmj8O5SJcA5Im/vRaYtoqfrPbdq5ZQqkiQdqJ
         27ChfsmcNXNEOvln3r5WtD5GH1vcsPdout3/+s4rRhLRFUjoNwOOzmX7LR3ge9irWduL
         DHc2S8OwcgrJ+yv+mrznjoElhn/3zlMrqCqX3me7I6i91LTW6dWez+ga7gmVDw/LMFdo
         8gHWD61TdNUKf+nU5IsBlZKiUBUM1Nqp0zFodK2COQcbl7IwaXAxYX3v039CNbUfl4Hc
         VW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790598592; x=1791203392;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lkBawcJZORsxZeSYcvknPN1o23VT6bn/NSzgx7OBRD0=;
        b=PBIflB0cBBiG3xYGS7HvQRtD9bjSUne9MYqgJOxmVPRls99BuA0+c/BsuCzXnsouga
         Fz/hTX7S0VbU+/KSJ4qfHYI3IW5KLc5EwsJUy+32rprTwJGmSpVDNX57yqwJVadOrn99
         yIoomzhlb75CxVOx9yf+/OHSM+C8m7pSHw68ouiLcs6RNJVGiHNsKevmOlvfnMP8oEjP
         K4T0uXXgrS7tKpDWff94dZeh/Nikq+BooUtmRA/N0bWsxPT1Jl1xghKv3GPF1F+kvxou
         WQJBHGX62+sMflu/kKfZTjrtSFmdIBMhryQ/x5RJQL1H/64rY8cLnL97UDr6ymTgzcrP
         8u8A==
X-Forwarded-Encrypted: i=1; AKwUvBxDQKO5s+SCWj1xfI5x+4kkmtNMrDYZXwE+zgXYNTIbS4AovDd4br8BMHq3t6h/XCkSquofF7M=@vger.kernel.org
X-Gm-Message-State: AFuF++kDW4gdcekZgtbiavIeLKJ81Zp7voABI5b2KAsRwY2A44+AulUK
	CHr4tmbmUYP+1M+7luPY67Q2tMm69e6UEobjM7LHOq2oSoD9/TPlumgXC3AlWQTakoNYq4/vpGD
	d3x38eWD+S/dZR8vdTOdvlaLD4nkCoWh+kL7C95hqBA==
X-Gm-Gg: AYBFou3p9S7zIqyXYbBFMuzBCx0BetSW5NEZpPX1/+sh36qSKT8c/likSdobNOEH4Td
	1qJE7EO1uFIvYoJPXI5w67jSgZh1iHmmgLxkGF/0WbH1FHI6u9v0noBbALb/kz/3lW9GRePdS3N
	AKHNe+mKcnIRGqlxOniBokTeAi1VOq0GacifhKcmla40Kz/H/cJyyqqWkgs5+BW9w0ZjRDxHu12
	Ap/RakTtmBtMgakj7unru/ZL+Wfo6AYAgNPnF6rA6955QH4Wq/8txrUbvu9j5zmxGZMvq26aTAs
	cbtpjF068AnjsR9ITgTgRVJ4LR7JCpT50Fp0maqf9FOXaKDTuRH3jVmT2IaAgd0mWXt7JvydNvo
	dHF/FnSGC+DCw1bAP921TU7Ky7nCi912GO9U=
X-Received: by 2002:a05:6a21:6f12:b0:3dd:a196:3091 with SMTP id
 adf61e73a8af0-3de0e953993mr11609993637.65.1790598592229; Mon, 28 Sep 2026
 05:29:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260922125112.2111256-1-robert.marko@sartura.hr>
 <20260928091804.hjnabzi52kz4ktmf@DEN-DL-M70577> <CA+HBbNG2nGXpXC63AVUJX3KaqzJG+Q=-Md92eTpq7Y-O4CHMzg@mail.gmail.com>
 <20260928110438.unoxnyymg7zwuuqk@DEN-DL-M70577>
In-Reply-To: <20260928110438.unoxnyymg7zwuuqk@DEN-DL-M70577>
From: Robert Marko <robert.marko@sartura.hr>
Date: Mon, 28 Sep 2026 14:29:40 +0200
X-Gm-Features: AclHuK_nzNTo2nwU3xgEirfWnjz5VEDaxc01jJkDIRwQ-q74rDelYXQzHvCKWN0
Message-ID: <CA+HBbNHNdz3TpJRAYt08CnYtA081i-SXxO8ia+tbHvbcx+KAJw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: lan969x: correct RGMII port mapping index
To: Daniel Machon <daniel.machon@microchip.com>
Cc: UNGLinuxDriver@microchip.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	Steen.Hegelund@microchip.com, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	luka.perkov@sartura.hr
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 28, 2026 at 1:04=E2=80=AFPM Daniel Machon
<daniel.machon@microchip.com> wrote:
>
> Hi Robert,
>
> > On Mon, Sep 28, 2026 at 11:18=E2=80=AFAM Daniel Machon
> > <daniel.machon@microchip.com> wrote:
> > >
> > > Hi Robert,
> > >
> > > > Currently, the lan969x_port_dev_mapping does not check for RGMII po=
rts
> > > > and just returns the physical port index.
> > > >
> > > > However, this does not work for RGMII ports as they have dedicated =
DEVRGMII
> > > > register space with an dedicated instance per RGMII port.
> > > >
> > > > So, check if requested port index is an RGMII port and return the c=
orrect
> > > > DEVRGMII index.
> > > >
> > > > Signed-off-by: Robert Marko <robert.marko@sartura.hr>
> > > > ---
> > > >  drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c | 9 ++++++=
+++
> > > >  1 file changed, 9 insertions(+)
> > > >
> > > > diff --git a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.=
c b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
> > > > index f3a9c71bea36a..bf5320c7a6ca8 100644
> > > > --- a/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
> > > > +++ b/drivers/net/ethernet/microchip/sparx5/lan969x/lan969x.c
> > > > @@ -142,6 +142,15 @@ static u32 lan969x_get_dev_mode_bit(struct spa=
rx5 *sparx5, int port)
> > > >
> > > >  static u32 lan969x_port_dev_mapping(struct sparx5 *sparx5, int por=
t)
> > > >  {
> > > > +       if (lan969x_port_is_rgmii(port)) {
> > > > +               switch (port) {
> > > > +               case 28:
> > > > +                       return 0;
> > > > +               case 29:
> > > > +                       return 1;
> > > > +               }
> > > > +       }
> > > > +
> > > >         if (lan969x_port_is_5g(port)) {
> > > >                 switch (port) {
> > > >                 case 9:
> > > > --
> > > > 2.55.0
> > > >
> > >
> > > The mapping itself is right, but as far as I can see nothing upstream
> > > uses the returned index to access DEVRGMII. Every caller of
> > > sparx5_port_dev_index() pairs it with sparx5_to_high_dev() or
> > > sparx5_to_pcs_dev(), which never return TARGET_DEVRGMII. Those paths
> > > are also never taken for RGMII ports. The code that does access
> > > DEVRGMII, in lan969x_rgmii.c, computes its own index with
> > > RGMII_PORT_IDX(). Sashiko, correctly points this out.
> > >
> > > So I don't think anything is broken today. Did you see a problem on
> > > hardware that this fixes?
> > >
> > > FYI, we carry the same change downstream. But there it was added toge=
ther with
> > > RGMII MTU support, which reads and writes DEVRGMII_MAC_MAXLEN_CFG() u=
sing this
> > > index.
> >
> > Hi Andrew,
> > As pointed out nothing yet is broken, hence no fixes tag.
> >
> > I am using it downstream as well, for the MTU change support where as
> > you pointed out RGMII code
> > uses it to get the correct index.
> >
> > So, I thought that it would be good idea to send it upstream before
> > eventually getting around to sending
> > the MTU change support as well.
>
> It wasn't clear to me that this was preparation work for a future feature=
. As a
> standlone patch it does nothing. IDK, to me it would make more sense to j=
ust
> send it together with the patchset that would actually use it.

That is fine by me.

Regards,
Robert

>
> /Daniel
>
> >
> > Regards,
> > Robert
> >
> > >
> > > /Daniel
> >
> >
> >
> > --
> > Robert Marko
> > Staff Embedded Linux Engineer
> > Sartura d.d.
> > Lendavska ulica 16a
> > 10000 Zagreb, Croatia
> > Email: robert.marko@sartura.hr
> > Web: www.sartura.hr



--=20
Robert Marko
Staff Embedded Linux Engineer
Sartura d.d.
Lendavska ulica 16a
10000 Zagreb, Croatia
Email: robert.marko@sartura.hr
Web: www.sartura.hr
