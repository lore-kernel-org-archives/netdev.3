Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBFD137DE8A
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 07:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787730125; cv=pass; b=k36EIuLqnljC8XRiamFXTrZE0SKqBqDNXqp7Z3zR8ifNHxUG4rswim2Kdr0g1OFHexwSxaicSjJXpKVHGJTfE6lNiAzCx9l5PKqrzVQp+Mn1ppfKSRZN0cQ+axnQ8n74dkmGRVpXaXdXqtKGsl/xc/JO1eDL+t4W+TDD06vWoeI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787730125; c=relaxed/simple;
	bh=hDSV9kYRnClQT0/UtSIMuCnfMynQ/JdLc2TuMDFAfNk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FByKLQ6oP4mtYZIwmcAoNoDdZX+frxbjKkEJ5x3S2mbBhtll7yiHsm8NCnkw0Dc2w9VIVbvyPXkyyIxsDA6ICa4VpBp56QteEMUG6C9z6naHQeaUqwJFTL7QYnHwGlkV+sQMoNhUsB7uiyVwjB85uMgs9WpPZeZYUUXmY1xdkUQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gAztmUQu; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gAztmUQu"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b4adcce4b1so38664e87.1
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 00:42:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787730122; cv=none;
        d=google.com; s=arc-20260327;
        b=i5gzYPmkLD4AHk0C2HDvBAIcgjB4TqoC1FMH47FFH3r5c33C+o/4p6nyy5LmB2ChIR
         1bdd0ffqGd6GmcKGZdnljW2B/tT8Z+f7urayru/3l3UtfW1AlOA8cx5Q/SQODuvkrXjj
         KEAJ/YYy0WaJAWZXpG4ynzkX+scYBAFKDcNK/z1oGCjXv+gKAARdXiB2+Lv9Ij4mz7Id
         K/huV2u06GnBFjalK9XWjAkcXHMc4Ro81hxfMsScnsWKaFtpujIdvJaOUTrZf72D7LGT
         5M0mY9MrKcLZhAbHLy5ngmLpmpX77lc8hlPdrDYZ20vtzWuKBG6DTUwdD6c8ptjYlD3f
         /QgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=alztsT2KgekdZvK+g7Utkxk63l7An1Uspdk9OA2Rpfg=;
        fh=nqxMl7021qNehG5Qo1H3xLrbp9W8MVPLOEUHyJuV1SY=;
        b=D1y91KHUvzR30ZBYWBd65LTJvm2ksFaDPB5NPKxdhol30VuYwrdb3YH+bLBqdy426O
         cV5H09C6qdSB2wqfo9Rf1cpBBnTl94WKL9QAPn3Ox5XiV60FqBzYxzaNpIOAPy3PGyqT
         1MFSvw3Yk4+kn9ddy6SUw0aaBd+UmmgS7/y8GYHkEzxYVFIIWM9XFu2lfqYMUEHclpQ8
         9ChTVv97F0qKNHZ0eFgR6UUOfz0ilJhKxt6haawYegIJbCuKdM/v6UAjt99a4tDlNWL8
         w3a1DCliHql6yIsla9+TremeIB54tIMkyXrbTjAfhHtrfPPkXHkj4jmqOsVrNIdqpeqc
         6B+g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787730122; x=1788334922; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=alztsT2KgekdZvK+g7Utkxk63l7An1Uspdk9OA2Rpfg=;
        b=gAztmUQu0l9r8YyQMG4NUKR4WN3pUrxY8Jrj5/SnhCu4GzIOpAXA0GpZPyTQZWy/4N
         1awb+sseZ19+pPhgQ9vUvDFkFpAkj2KXHYbE0KlJ1KlRj3qAOKyTjLnomP/S93io0dOM
         2dan8K0YIobLcfKctPG7QYsUEp5icKkm0jTSxadlc2oY4DaTlOPzpksMlKMIOEodobL6
         g9yxP791y769xAW70As0BDxjVFAbvAfU9EFl9BvzFLfezptOAW1QzTKj6BZPn0N5gJsc
         pKFgiaxHiX/1/2MWfAwuaYAhrdYjeaeomTQYFBT3cKllOt0J9QhONspR4P0TUNKn9nKP
         2xLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787730122; x=1788334922;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=alztsT2KgekdZvK+g7Utkxk63l7An1Uspdk9OA2Rpfg=;
        b=PhCIbqOeYYSAmvq4pch31sxm4uPo/HpTO8yy7u5/uz6YdTTsuVZooHI7Tmt218/qSs
         1tJb2U8MIC/Ps2sRH4Y5V6d2orC9PTuhtEo9L8CdgIVRi8qna6Q7yVWAPQ78rOc1z5Qz
         ig6UKrbsxWqrxbTyViM/qge+Ao0Wjvc0djeHONW20fGxD4if5f3oL+FbNqIm6mAkX5yE
         3omZb+5y/HesKQmyDCXkWvxteZhcPfLKb9CHuU0mJ1lsbGSaQyyRbpE/4+cQ8oIWZ+Xb
         bwOHy6wUpS2JXq9lH5OqYG0VlkY0H36bhpmTr1cIo30D4B3Atpt5wd/VjN5ULFfjkW8b
         f7AA==
X-Gm-Message-State: AFuF++mA6yrkzmt/KO/lsSupvD7guHbiUT1EFVp77EJhTcvXSeZ65kvf
	nh68H/VeRB9gUi8FGc65fZ0vHCcxDTEE25KdrY8gn4d4iY9t0ha9EVUdLE5WVLGZ/iMw0e73QGQ
	oAzfUKuLAqWvyhZxxi88UVWHKQ5ktpGQfU1GP
X-Gm-Gg: AR+sD12x5rinY0aaoWbN2vlw0YHMFu92pOV2ZMbB01jAlUIQOQx34ur6SA/T0LQolt9
	tLEFH2VSsnYrXFf6iateItywxauWj09a7jZFvtbu6695zn68gY/SWBBjTpv4UwdhEva232CTNGs
	iJhNT3Gc7nC0oqDmy6zFLnCgVc37e+srGOULuJWujGPyYPxkP+m1tjBxa1WpJZWKfiI+KkmhqG2
	CVHbHnl+ggNdjbKa2vbJBJyOm19qaaYtd4+fXKrxZQ+u+gbbKLdhxxRp0M3vxbm4ZC1DpknEDEx
	iAgYbvKB2HkD8pWABEl7TrzcQZyDXpQMNmtFgbmLuqQ=
X-Received: by 2002:a05:6512:15a5:b0:5b0:23b4:be97 with SMTP id
 2adb3069b0e04-5b4a8ff419dmr1184130e87.6.1787730121387; Wed, 26 Aug 2026
 00:42:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMuE1bHr84n5LKcj02HmMR5XefPtvQ-UEJAx7+UKfYvRgS0eDg@mail.gmail.com>
 <8c5c1254-34b9-4d38-8cd4-71b3c13e00e4@linux.dev>
In-Reply-To: <8c5c1254-34b9-4d38-8cd4-71b3c13e00e4@linux.dev>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Wed, 26 Aug 2026 10:41:34 +0300
X-Gm-Features: AcwNN1WJJ8gFy09JXDzL_bQPcA4XomYA4ziY7KkAQtiAYWuV87e7vZ5bXMwm7XY
Message-ID: <CAMuE1bGoYCh8cZZRMiA_TJ58p+QeXxmNh=brEVrV3UyAEJw5aA@mail.gmail.com>
Subject: Re: [RFC] ptp: ocp: exposing the TimeCard X2 AXI Ethernet port -
 which approach?
To: Vadim Fedorenko <vadim.fedorenko@linux.dev>
Cc: Netdev <netdev@vger.kernel.org>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 25, 2026 at 7:38=E2=80=AFPM Vadim Fedorenko
<vadim.fedorenko@linux.dev> wrote:
>
> On 20/08/2026 16:01, Sagi Maimon wrote:
> > Hi,
> >
> > Before posting patches I would like to check which of two approaches yo=
u would
> > prefer, since they differ a lot in how much code lands and where.
> >
> > The ADVA TimeCard X2 is a PCIe card whose FPGA image contains a Xilinx =
AXI
> > Ethernet MAC and an AXI DMA engine alongside the timing blocks ptp_ocp =
already
> > supports. We want to expose that Ethernet port as a netdevice.
> >
> > Approach A - let xilinx_axienet drive it.
> >
> > ptp_ocp creates a platform device describing the two register windows a=
nd the
> > three MSI-X vectors, and xilinx_axienet binds to it. This is what ptp_o=
cp
> > already does for the Xilinx SPI and I2C cores on the same card, see
> > ptp_ocp_i2c_bus() and ptp_ocp_register_spi().
> >
> > There is no device tree, so a software node stands in for one: "phy-mod=
e"
> > replaces a phy-handle, since the MAC is wired to the fabric internally =
with no
> > MDIO and no PHY, and a "fixed-link" child node pins the link at 1 Gbit/=
s full
> > duplex.
> >
> > This needs two things from xilinx_axienet:
> >
> >    1. Read its configuration through the generic device property API in=
stead of
> >       the OF-specific one, so it can be described by a software node. O=
n a
> >       device-tree system dev_fwnode() resolves to the OF fwnode and the=
 reads
> >       land in the same OF code as today, so this is a no-op for existin=
g users.
> >       It is also in line with the wider move from of_* to
> >       device_property_*/fwnode_*.
> >
> >    2. A dma_dev in struct axienet_local. Descriptors and buffers must b=
e mapped
> >       against the device that masters the bus, which for a platform dev=
ice
> >       created by a PCIe parent is that parent - a platform device does =
not
> >       inherit its parent's DMA ops or IOMMU domain. For every existing =
user
> >       dma_dev would equal dev, so no behavioural change.
> >
> > That comes to about 50 changed lines in xilinx_axienet and about 180 ne=
w lines
> > in ptp_ocp.
> >
> > Approach B - a separate driver under drivers/ptp.
> >
> > Reimplement the descriptor rings, NAPI and ethtool support against the =
same IP,
> > roughly 2500 lines, and share xilinx_axienet's register definitions out=
 of
> > drivers/net/ethernet/xilinx/.
> >
> > We have both working. Approach A is tested on 7.0.0-rc1 with the card:
> >
> >    xilinx_axienet xilinx_axienet.512 eth0: configuring for
> > fixed/internal link mode
> >    xilinx_axienet xilinx_axienet.512 eth0: Link is Up - 1Gbps/Full -
> > flow control off
> >
> > ping at 0% loss, a 90 s bulk TCP transfer moving ~9000 packets each way=
 with
> > zero errors and no TX timeouts, ethtool -S/-g/-c/-a all working, and cl=
ean
> > module unload and reload.
> >
> > We would much rather do A than maintain a duplicate of an existing driv=
er, so
> > the questions are:
> >
> >    1. Is instantiating xilinx_axienet from a PCIe parent as a platform =
device
> >       acceptable, or would you prefer the driver split so the device ca=
n be
> >       created on the auxiliary bus? The platform device route keeps the=
 change
> >       to xilinx_axienet small and matches what ptp_ocp already does for=
 the SPI
> >       and I2C cores, but auxiliary bus is the more usual choice for sub=
-devices
> >       of a PCIe function and would make the DMA parent explicit.
> >
> >    2. For the dma_dev, we currently infer it by testing whether the par=
ent is a
> >       PCI device. That is concise but implicit; we are happy to pass it=
 in
> >       explicitly if you would prefer it were not inferred.
> >
> > I can post the series straight away if you would rather look at the cod=
e.
>
> Well, we definitely don't want to copy code but rather reuse existing as
> much as possible. Looks like platform device is the way to go. Let's
> discuss the code.
>

Thanks - agreed on reusing the existing driver rather than duplicating
it, and good to hear the platform device approach looks acceptable.

On timing: the X2 Ethernet support depends on X2 board support in
ptp_ocp, which doesn't exist yet, and that in turn builds on the CPLD
programming work I currently have in flight for X1.  So the order will
be: finish the X1 CPLD series, then X2 board support, then the Ethernet
series - the axienet property/dma_dev changes together with the ptp_ocp
patch that uses them, as one series since it is all net-next.

I'd rather send them in that order than post Ethernet patches against a
board the driver doesn't know about yet.  Happy to share the Ethernet
code early as an RFC if it's useful for the architecture discussion in
the meantime.

Thanks,
Sagi
