Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67E143AAF71
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 21:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788816233; cv=pass; b=bqFpgfANUDD1ErXtdp/mWVOoDkg3Kp2i1Y0Imdi6jYK9SF9BVcrXvnhOc2bSDNzbiBHiUNJzVI5S1M1YVWMQEGVi5zNFdQluL5O6XYWmgMXWfL6dR+DSyNqPEOvZzIrewR+Bb9f0dXW59Iij1UuR/pKL9pfXVgaLPMvIgoGRU6Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788816233; c=relaxed/simple;
	bh=19/8aQ8d3WRQPVmOABUgfgBS9WSqvPRbfyGSQyZrvXY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ag5TynNuET0eBiASdwve4Qe16VsvaAe0Ttfw28NHTSmIG5lM7wPXEhGdVSzBA5CTlrzhnlAfsxKyTUNuhSaNBi2igwUYLSeu7g0OWaC7k6/6a92C3UF3VQAErJHhAqp3PVcCW0qJu19gNk/l17HCg1c/WopalZLRhh8kB+1rlSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X+MX10c6; arc=pass smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X+MX10c6"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-48441a2ba1bso2837301f8f.1
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 14:23:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788816228; cv=none;
        d=google.com; s=arc-20260327;
        b=sUNhg7ayP9mtK/Zidcxb3QBiUzQQRflfylOHD6Gk+pwFVqkneOOA5C5sNN8NKbtJ8s
         uCE2z/wNs422bdDxJqmHGEsGos1uv/Fh8+KNxPXfMzzA6Ge81SlmTruIwZ7hNkRx6slC
         OyTEjLODXGOd1FIwi2nvxwcp8BL7sjnvRfS7STYNsWNZDDzC7UULUbtUXYcIb8cye0Ld
         Td3dxt3euNAecn3kiJ5vH+9450DqS+N4oUhxTLIP1egy2x6Nd7rZiHGyElS6/tSqLfMM
         Hhvr+DHTvypaEbWpKqk52Tit0MuWbPcsK2Nw6haN//W/KAdteAAIBi7Cxk+jZkyz2V6c
         IOQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wuA9AOewcEEJ8XMU+DUU/y8C9hklGB9rqR+cr/+jZjY=;
        fh=yzY7lndl8Ys3lszzbo3oA4Ni4VAZPZk//1/zDs1SQOQ=;
        b=EU3RYz8qK7UMZW4OJpWtlS5fKnKflqOjieWppkydsJlzjJ5+bqs4rMGF2WuHXESfB9
         Y2neRMBccWkvrrlT+qPM20eTiku/LvRVUEk/86CuJSwdjzT0GQhT+DzgP0gLxMsxweDQ
         81JIN73KUuN6Ugm7/R0t04T3Ks1XogmndYFN/Q2U6MLKADTSuS7qdbx2TaAORSpWMdyi
         XcBJj9HGHtJNJTsrpIrXhDGUCaq2JHeuB/HVHglm48XInpiv6F26HlS6vRE0Z/mJff21
         s4P8vq7xUr2fnb4t57taV+5QLdE/RLMxEAS0BSfnoqQQSl4vrnYBYJDmLbWg9e9Ax+Hi
         OzZg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788816228; x=1789421028; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=wuA9AOewcEEJ8XMU+DUU/y8C9hklGB9rqR+cr/+jZjY=;
        b=X+MX10c6MQhhUHNv/JZ8+iqWZZ8PJVfINv8g286mpS1G48IrG5p7zJqc4RE9w5c4T3
         AvxZwPlPauidlIkE4iwka6Duc0MBMMrHjl5xX8xJE+QFTRUps0m4WuplFB5HAzSEU6r1
         iT3fEgDB2uW7ORy2N+dzEJ6dpFL8pjhFgkM4ZOKoqUJzCEWw4z0Elok02idwv84ajWBi
         mJ8IJqCGeYGQM/rZj2EKG4x/eoaXPPaECCggNWmrL4LbuPRXPeY1wuh/BrZW7Y5pZmpA
         jY4LZV9zCFJ9VM80l7fHUvTHTMRJBJ2xCywPZHz3rdWcYhqiYW9kvlT2ohOs2bX31Aon
         X7Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788816228; x=1789421028;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wuA9AOewcEEJ8XMU+DUU/y8C9hklGB9rqR+cr/+jZjY=;
        b=sukchnY2BmNhVgDTbwj9KIjWwafikGzLShROtyN8pIw+I+wSL91vWlHpSGM+xapNc5
         ul1ZNpSR8yMCGBmRmleKrjUXb9HpySSQSwya7fGKWfXanxR34GdkhNbmE3Y3PRH+nXNN
         rhkHRkZoC3Oped8bSYnLb7UxiEGHe2gT34vIFuCTtmHEuAArx0iKhLjqsLCtw6WeQXh/
         B4rW+oL1USWU5M0nxLanAMgUqJZndIh/9Eea4UN/pzVvshVDLnQ4RbvNsIH2By7NEh45
         JYb0w4TmKv1ZuGbRIqzSIl/b6NpbtXHeU6qbbmDFo741m1aSpBvB2U/fQWEyCTHgKAg0
         HrtA==
X-Forwarded-Encrypted: i=1; AKwUvBznaN+1sG3mB3Ym5Vz3zfZTbAxEuykz/cqL3tfYadt3ql76nC1sYVyja/0fXK+cKCEGDDD6cn4=@vger.kernel.org
X-Gm-Message-State: AFuF++n0az76gvZO1x38zu/WWaz4WjE1rc0ue/8EazOaDYpM8T4Ei8vb
	2p8QPaT1xuuO6QySJuQtLagnQjPeUEBA1nLuLPD37p+HmclFNpWutNTj9aS4pxZk5APmn4lQJfI
	69H28KVcz43ZCFSfnbIJCP8JKs1qnass=
X-Gm-Gg: AYBFou0QQI+AMaPHr9mVF280keCSiB1PUepODcv37b6raj3egcje35T8LAwOJiRuSxw
	zl5TilFIYfHy3tilIrzv8FNBFSpcuY2lefsZMuAhUrJSBoXZ+Tes6fsp08Jc/Z0XRC11+fxJXhI
	aqi8wtFaMegrjTL+i5tIXupnDqOmoxqdJK5XpUy5qP5CGX75ISSCn4Lg29cmBRfXxitsw0CBggm
	UgdEveAGmLugD+AofdyxsVHKTauJ/1wwiqg9sEsJCCRpDdVKRF5fD/RXYS9ju8fST+EIaXXzkHn
	uwvz0Z/9KiT/spb9gkjFay73c7oqBTxQIAn98OdCu/cXeSt9YqTcymAdFDUj76QfWCy3lhJjFr/
	5ZimFKlmKRUNUtmyVYWLdySEs25rRvMUE
X-Received: by 2002:a05:600c:8706:b0:49d:191b:88be with SMTP id
 5b1f17b1804b1-49d191b88e2mr11604605e9.0.1788816228283; Mon, 07 Sep 2026
 14:23:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260902-rzn1-miic-fix-array-v3-0-3f7dccffaf5a@reliablecontrols.com>
 <20260902-rzn1-miic-fix-array-v3-2-3f7dccffaf5a@reliablecontrols.com>
 <CA+V-a8tOLKxFEKF+yZ0Asf_KYb=_hrFuJagkdzHPxZ_zf3MNRw@mail.gmail.com> <81f2b455-7df7-4aae-8b67-d7cc9a7039d4@lunn.ch>
In-Reply-To: <81f2b455-7df7-4aae-8b67-d7cc9a7039d4@lunn.ch>
From: "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date: Mon, 7 Sep 2026 22:23:22 +0100
X-Gm-Features: AcwNN1Wo_8wwvrgt5LhiUMun9fC2pDJoIDFWLjv37XoCXAfNGC83f6MaStO_uN4
Message-ID: <CA+V-a8t9C5D+YeV4Qqiw5zKjipE8zLmDAQ_rSqDmw6VWPOBfUQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] net: pcs: rzn1-miic: Verify port number from dtb
To: Andrew Lunn <andrew@lunn.ch>
Cc: khendry@reliablecontrols.com, 
	=?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <clement.leger@bootlin.com>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, linux-renesas-soc@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Mon, Sep 7, 2026 at 9:49=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Mon, Sep 07, 2026 at 08:39:27PM +0100, Lad, Prabhakar wrote:
> > Hi Kyle,
> >
> > Thank you for the patch.
> >
> > On Wed, Sep 2, 2026 at 7:55=E2=80=AFPM Kyle Hendry via B4 Relay
> > <devnull+khendry.reliablecontrols.com@kernel.org> wrote:
> > >
> > > From: Kyle Hendry <khendry@reliablecontrols.com>
> > >
> > > Add check to make sure port number is in range before writing
> > > to dt_val array
> > >
> > > Signed-off-by: Kyle Hendry <khendry@reliablecontrols.com>
> > > ---
> > >  drivers/net/pcs/pcs-rzn1-miic.c | 6 ++++++
> > >  1 file changed, 6 insertions(+)
> > >
> > > diff --git a/drivers/net/pcs/pcs-rzn1-miic.c b/drivers/net/pcs/pcs-rz=
n1-miic.c
> > > index c50b65d064fa..3ee40eb9d545 100644
> > > --- a/drivers/net/pcs/pcs-rzn1-miic.c
> > > +++ b/drivers/net/pcs/pcs-rzn1-miic.c
> > > @@ -692,6 +692,12 @@ static int miic_parse_dt(struct miic *miic, u32 =
*mode_cfg)
> > >                 if (of_property_read_u32(conv, "reg", &port))
> > >                         continue;
> > >
> > > +               if (port < miic->of_data->miic_port_start || port > m=
iic->of_data->miic_port_max) {
> > > +                       dev_err(miic->dev, "Port number out of range:=
 %d\n", port);
> > > +                       kfree(dt_val);
> > > +                       return -EINVAL;
> > > +               }
> > > +
> > Query to maintainers, what policy should be followed? Since the
> > dtbinding check complains if the port is out of range should the code
> > also check it?
>
> Yes, the kernel should check it. Running the checker is
> optional. Crashing the kernel because of an invalid DT blob is not
> something you want to allow.
>
Ack, I'll make a note of it.

Cheers,
Prabhakar
