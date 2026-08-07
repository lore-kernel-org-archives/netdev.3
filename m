Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB873367B8E
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 19:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786131250; cv=pass; b=APMJc3O9Kr3NFwQ3hnblsYX5mb8dA++LmmMuWypPb+snyP7cqulGsQopP7IedihQikrLoyZ7drrMHEy8p1ERfD4aqVEsMFVEuePfWF4V8Ujy9tAl3KI5uvg5FPKdxpGCwyZbP4kEH73KyU4SnJYnJRZ5t3losdA5rKZK9jWoXVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786131250; c=relaxed/simple;
	bh=U6y2778gV/zoZJ4mqp5v2pm/RGDs0J8HINfVltgsuYk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZajRb1MZahtMpecB8SdNUMx2jRXjqhZ1dRoXru0bNmLkKKqr+Zp/6uf0IJAAoqg7GNgWztmrctRpzm8m6bmfwBUoNT83SeQl6rulcZ7XlomVgvVxbDWHG3a7L4OAA2QEreUaG+Kab1n6XWZxpmnbgAifUSw/U6LwVg1iBnmFeXM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=if9oZXL2; arc=pass smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="if9oZXL2"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5bfb3347ce0so1098125e0c.2
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 12:34:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786131248; cv=none;
        d=google.com; s=arc-20260327;
        b=IvNdhxjX9mesq62f02KwUqS/qEZgRYIDaSsHlVnI7unOdazF2Z7ijFQW628ym4ejBE
         HK3CXRpZ+4L7ljjZIJiaNF0rwuGq0bvAc+CUimCPDfntSGfQ0zKO3XvkLwyFFSJmPgIG
         /Bl3n90Zevi4MjHqK2tLc7kLIhinTeHFTgKkc2OJcMxc/VD9l+W/6FxC/5p8y/mZ7cia
         N/UnqXJ2UGdf4vAMoqIZneRwt8T9UqGteWmk15tLhrFVKLN0y/cmqYsCsjGNtn8rX8Xy
         Ox1E2m3P5DKl+l7hCobCv036rxtuaITZY1BBXXlYSM/NHg6vRfAoVfcE+gaAaU0hkMmo
         XO4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9caxZJDo+1eTj4vuH9vzEsfwbNVL6i24iyprVwcm01c=;
        fh=JNnIPGs2a6CJ1ET3H9cZwf//WZ00nvH1WOFlhXNS7j8=;
        b=AkYB5BdDIScuUX0O5J4UK4agz4caVbv9PgFazdI3tS8uKRVWPNGKJdIisgEcPpTU6a
         mWel2vb165zoSSzUeZzOQ5r0kLbOcyEet+UaQ7oFHaimMVVtkV1YBYWCFDHaYWNrzskk
         z/o8uWzj4MrgGhc/3ArfnOZ6dl+lC321Gacq7PdpPuvM1NCf+a4vFpkKVpAKXq3WNT1p
         mNwrdDIbwSsT4tzyDulKoprrNmcWQc8h5HtGEY/pc+T4TXHslmGQlGtlAIS6p2QCiZLK
         djB+438XpdEQLrXx2zqaHjgHU/JaplnSSRgMAkDi5CVR1p+5CLj+pqlMgI3MTCV7+TGY
         gAMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786131248; x=1786736048; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9caxZJDo+1eTj4vuH9vzEsfwbNVL6i24iyprVwcm01c=;
        b=if9oZXL2QnHfigqUiImu8fydZDDmfepU1ziHSDHwg7vyx4Xxy/XF34gEbxEUmIxlYr
         9lnAor71qGZtrcZ1O/AuT3Xh/Tnc00I0GrcxCDbiovj7vYoBlf/wWyIU5iX1MDNuAiQr
         sR2mxMFCsueH4zaYb4l9jPB6vDN/lJ7pzUNYfgfGxdGHxEYSUB3e84igBa/7w/KH9aOJ
         ljGKoZxmOvtGP7U7YTOighKHbaO/0ihPftlNtXN6NW95qC1Wt35lfYcdtYDNkzgNH4Zx
         UkEwMMrpGixtIM0fpafEEGuwKs4sIkmPozmk2RMLVOphB//8Eh5HDdpWeDByOxTwmbol
         x4rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786131248; x=1786736048;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9caxZJDo+1eTj4vuH9vzEsfwbNVL6i24iyprVwcm01c=;
        b=OuH7qKYeP2qVnrD8u6108KwS6tK4P/G0S+frrkcGJQDkb+xojzG1UWkFhPX4jGrnaF
         kODE0Ucno1UORizeyydo4Oh2bRK6fvfjkUcEemLf86d1JgAwc4Ihnt1g6znbaHzj71Kg
         hsBFlOuyJU+Q6Y84Xp36SID5k1mX3304oGAU2RxF/qIvxAhOBjvEWcBeIg17ImFXsjpH
         GOO5l5yGB1LQ2RDPejVDk/FcKXTrXrHZhxDcLaVUKxKMuYk6c/TBgtStLLdGNAg6uBtB
         iZk+9bf783KdbZ3MaRE4hJe2C4+Ckp95/zUGy3waaEAywAqaBiwAz/EW4wzpU4HXyYOX
         DZhQ==
X-Forwarded-Encrypted: i=1; AHgh+RrrxwHbgqLaH+Ev3zIaL17X5l6PO/DXuaDJkG57+pMfEz6TLfYIz5GhLHNDWg9m98nVFUfehF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkgXhM2YA+hS92XIwha+EqkaNo3m8BR3Alvhm9A4JqVbVW7rKD
	Yl/x12mAELBsLatqmSClIcHcQUYvaI9LycVHlyuFps+6bRAeJ8IL61iZACJj0p28qMtZ/Cw92Vq
	jAPA18QdA5B3taR0R9HuVMX+hZLSEyY0=
X-Gm-Gg: AR+sD13fJkNvl3Th4MmbCod2JAtyqDTk6z6FjbXhDkQ9Dy5TmDlhRjBTV5hHqI+f5Hy
	/JXVy3Yhmat+wFWLdMqbytvFC6ex7dkoWchfXRK/HelpHaTErxJpNK4Q98hVt6DqwYg6vYSE1HO
	+6j7XEw0SYoTqNJWWD4dnQg5FFHt3+D6zbDjDkO+FqfOsVFyy5VkEZGWfOb1kRGpC8sfuDialJz
	jUKaqwxEE1hylXaxzLrkN2vptJkYTiy80IpRniFTaQkRCuoJo8zgOYG81e3EtJH4Pyp48OMOsyV
	g5R8xKL5aO+M/7dB0XfKnjh8jGKnImbgSG3mESQ3m7sNIWyEQ4W8ZyjzPeW7e43w2KuISKcp5wG
	0lrzI2xsaKcDI1uLS1KCSZkrE1RvGeLzulgfaLr7jPfoBgaKZnrwFiaHTe1htUZizkik8vAApEr
	h5Igx5dGgCXMD8UHQjyO+X8jFqhflp4gk+AgrV
X-Received: by 2002:a05:6102:d8e:b0:739:478b:5bf2 with SMTP id
 ada2fe7eead31-760e8f347d4mr6463052137.13.1786131247763; Fri, 07 Aug 2026
 12:34:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-submit-mdio-of-dynamic-v2-v4-0-4beb0c50d5ba@gmail.com>
 <b2e83ba0-2e9c-4105-b806-8a155e8b9aa5@lunn.ch> <CADvTj4rame1n8eQL2GUOaJHnOcR_cqNxzNYO+QeCLYDczEFeUA@mail.gmail.com>
 <ddce5cfa-8cf9-4f9e-ab0a-0b415706876a@lunn.ch> <CADvTj4qxGVw+PW2LeF-a3h1XfmirQZGfJA9-6Czt72XASbVLBQ@mail.gmail.com>
 <4aeebecb-81fe-4f09-9dfe-a3be2f778bb8@lunn.ch> <CADvTj4qrYYA-e+9iJ+q4UaZteUjpypRa6HBSmwp-ajwPbwYERg@mail.gmail.com>
 <3cd188e7-7dc4-4d67-82de-e2ef3edee232@lunn.ch>
In-Reply-To: <3cd188e7-7dc4-4d67-82de-e2ef3edee232@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 7 Aug 2026 13:33:56 -0600
X-Gm-Features: AUfX_mxMpD-qand8wklMDqDrRd_xxDI0iY7G3-8rmiKaEvXH5AFL93SLf7_FiGM
Message-ID: <CADvTj4pJG56UERve8BfbYzjCLO4KBDDuFviTcz1ivuwUFRMdxA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/4] net: mdio: support dynamic OF device changes
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, Richard Cochran <richardcochran@gmail.com>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Jonas Gorski <jonas.gorski@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Ciprian Regus <ciprian.regus@analog.com>, 
	Andreas Larsson <andreas@gaisler.com>, Mark Einon <mark.einon@gmail.com>, 
	Iyappan Subramanian <iyappan@os.amperecomputing.com>, 
	Keyur Chudgar <keyur@os.amperecomputing.com>, Michael Chan <michael.chan@broadcom.com>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Doug Berger <opendmb@gmail.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Wei Fang <wei.fang@nxp.com>, 
	Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Jijie Shao <shaojijie@huawei.com>, Jian Shen <shenjian15@huawei.com>, 
	Bryan Whitehead <bryan.whitehead@microchip.com>, UNGLinuxDriver@microchip.com, 
	Vladimir Zapolskiy <vz@mleia.com>, Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, Timur Tabi <timur@kernel.org>, 
	nic_swsd@realtek.com, Byungho An <bh74.an@samsung.com>, 
	Steve Glendinning <steve.glendinning@shawell.net>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
	Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, 
	Thangaraj Samynathan <Thangaraj.S@microchip.com>, Sebastian Reichel <sre@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 1:16=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Fri, Aug 07, 2026 at 12:48:43PM -0600, James Hilliard wrote:
> > On Fri, Aug 7, 2026 at 11:15=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wr=
ote:
> > >
> > > > I guess it can also be used like this for live dt modification:
> > >
> > > A guess is not good enough. Give us a concrete, in kernel use cases.
> >
> > I searched the current tree for callers of the OF changeset and
> > overlay APIs and for OF reconfiguration notifiers. I did not find a
> > current in-tree path which adds or removes a child below an already
> > registered MDIO bus.
>
> So lets wait for a real user to come along.

So should I just drop the final "net: mdio: support dynamic OF device
changes" patch and keep the MDIO hardening patches?

>
>         Andrew
