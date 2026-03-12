Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5CF738238A
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 06:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773296960; cv=none; b=afaGcYavnJk7iM3a/smEg9dgMpQapGhu52vwpgMyN5I93FQU0g96jVaUA4HDbyeTzZt8kdk7miD1lbMkG0o55eiYEaZZXQDTQQNNZa/C9KIXH+dOIhLD4sEdCsw2S2oqPxBgAVc7GEAZLODt/nmFAfuFhjEUGvb3yBT/vuQjI9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773296960; c=relaxed/simple;
	bh=5f8lz5fAU2KSI7baSw14/mD4GXpdAG8dN/4wJscx+g4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oO6W85t50v3ey/049AiJfHYJyFpstT5uOnXoNfvW3vj4lJcl1E8SvmWFzHaIcaj8v+wFTejOlVUECAbDBv90sKTBcMAptD8KaUeGMk1VCkANBvLe1NPb0+q2ETvbNTqBAM3zQoA99uIKt5Hyjutf9hHkp4uarW8qFtluq51/2oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h2bfxSm9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h2bfxSm9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8861C4AF09
	for <netdev@vger.kernel.org>; Thu, 12 Mar 2026 06:29:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773296960;
	bh=5f8lz5fAU2KSI7baSw14/mD4GXpdAG8dN/4wJscx+g4=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=h2bfxSm9wzsf/polDEIYiL5js/Faoto78VnkE14vjPt3yXmGy34sqnvVwcLxs6Dtu
	 vPN9gjsDB4qA/G3xrAsq7bk0Cj33zvZNvMj7s1iFsK7Alc1LH6wk1aPKqMlWNM07lN
	 G+mQ8RUyWauKGwtwHzu9ePPDjX9Fg4m1W99rSq2iYH6QC2o90nP7JccnfoS+SMGNkU
	 eJ8fHfJOCLP4UNg5Me1PV2oy5philQBEi8SNi2DtWS3fdcxTqtLhM7G0ycefupuW2v
	 gzDeDdxxWissPV3Mp9ea2z6jz8BG21QB405o8edtyO/Hi3T/8FjKj58RGV9t+cVeIt
	 3pTWwbq9dJawA==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-38a3066b68bso6289211fa.3
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 23:29:20 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCURSWJMTPZcI4LGQHOxuUxdOt/w+/Z/mEsCnKJ13U38vf5t0l/b6fy74kDsEKOVqX8JMPO44Lg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw00X/MvDCA2NwLi6wepO7wbc+KLojjgakriAqS2K4PSjpRlisO
	2X3BvF2850NZ7NI+TyVWQC6u5PPmgcHcDgKY0qygCtPM7p2sAnhZdHDxanAgLlW1AXyJ5J98DVR
	QyaZSB8JDmBNU4T4NACBk6/xdSioboXs=
X-Received: by 2002:a2e:a544:0:b0:389:fc6b:943f with SMTP id
 38308e7fff4ca-38a67de53a5mr18901371fa.11.1773296958936; Wed, 11 Mar 2026
 23:29:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260302144458.3180702-1-wens@kernel.org> <5f8e32e1-c73c-4a3f-a1ff-21b78f764bfd@lunn.ch>
In-Reply-To: <5f8e32e1-c73c-4a3f-a1ff-21b78f764bfd@lunn.ch>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 12 Mar 2026 14:29:05 +0800
X-Gmail-Original-Message-ID: <CAGb2v66MY02xvA_Mvt=6O001XEgz1AVH6ePorPvNtL0s8=W8rw@mail.gmail.com>
X-Gm-Features: AaiRm50N7EZSmg55aQpjnndqzFiacnsEDhd-Cbp1wYEVjcocF86lRPoMFnxLdVY
Message-ID: <CAGb2v66MY02xvA_Mvt=6O001XEgz1AVH6ePorPvNtL0s8=W8rw@mail.gmail.com>
Subject: Re: [PATCH net-next] net: phy: Handle PHY reset during initial PHY ID read
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 12, 2026 at 3:05=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > This work was the result of Russell mentioning [1] that placing the
> > reset GPIO under the PHY node in the device tree might result in it
> > not working.
> >
> > I also talked about this at Plumbers in Tokyo last year during the
> > Device Tree MC. There a few people mentioned that MDIO reset handling
> > has been a pain point.
>
> It is definitely a pain point. I wish we never added support for
> resets, just left it to the bootloader to get the hardware into a
> usable state before starting linux.
>
> Anyway, i don't really see this being a MDIO/PHY problem. It is a
> generic device driver model problem. We need the core to have generic
> code used for any enumerable bus, PCIe, USB, SDIO, MDIO etc to ensure
> the clocks, resets, regulators, etc are in the correct state that the
> probe can work.

I agree it's not just a MDIO/PHY problem. I am looking into it for all
the common enumerable bus types. Currently SDIO, USB, and PCIe all have
some solution, though the SDIO one is deprecated, and the USB one is
incomplete.

That said, this doesn't fit into the driver model well: to create a struct
device the device needs to be enumerated; to enumerate the device, its
resources need to be provided and enabled, but at this point there's no
device to tie the resources to.

All the existing solutions scan the DT and create extra platform devices
to handle the power sequencing. Some bus specific code is needed for this.
USB is simpler, since once the USB device powers up it will initiate a
handshake with the host. All the other bus types rely on the host controlle=
r
doing a scan to enumerate the devices, so the power sequencing code needs
to be inserted into the bus scanning code. The PCI implementation is
extra complicated: some controllers have dedicated PERST# functions
that are toggled from the controller's registers instead of using
GPIOs for the device reset.

> Once the core has this facility, we can modify MDIO to make use of it,
> if needed.

We already have the power sequencing framework (drivers/power/sequencing).
So instead of the open coded reset GPIO I did in this patch, it would
just be calls to pwrseq_get() and pwrseq_power_on(). I would need to
figure out how to actually work them into the MDIO subsystem, and also
how to model a generic PHY power sequencing provider. But the recent
M.2 slot work [1] provides some good examples.

Does that sound more acceptable?


Thanks
ChenYu

[1] https://lore.kernel.org/all/20260107-pci-m2-v5-0-8173d8a72641@oss.qualc=
omm.com/
[2] https://lore.kernel.org/all/20260112-pci-m2-e-v4-0-eff84d2c6d26@oss.qua=
lcomm.com/
