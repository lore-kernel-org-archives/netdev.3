Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5EB305664
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 07:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788159837; cv=pass; b=AW3wWgA77mK2Vwl4ljUNgXehV/KT2+VKA0T+uZmjSii+2ygHlCT/B/lEqOjPUH5XdeGOuBF///pmEcRNti+nETOIU+cnkaplmrof9sPOgny9+VvNdQKy9aBLG0pmp1JSG+xcPAnuTsORgouPxawHoN1U+Pvl2QQfdHyHGEYKHQ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788159837; c=relaxed/simple;
	bh=0BE+dmVmXkFgYYDKS56uE9rGx92Afk5IK7Am6Q8j+xM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=buqyCwkf0LeeUExmEE2ktfLmj736hsI5xpTPBj1FCefDaFE2xZMKbIcQrbHA75+9sref9PjAror2MvWV0W2pFdkxSrt9922eJT+MiUsbMqeCFo5lk00eaG9Jg2buPARilm4lfyvmyUyUgiuDVj5xZP7dbMOUCpgrtTd26FIm80I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mYur3Bm1; arc=pass smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mYur3Bm1"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5b5607bd3b5so2731170e87.3
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 00:03:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788159834; cv=none;
        d=google.com; s=arc-20260327;
        b=rVpjFUdbJVOXlDyL6T+KXasNUOIPDQ4n+BFXGFuymTBuCxh0Y8RcLPwbjUbJolpMkN
         kQ/ldaMqZyQARp5aS5/YLGmfmexs2vO0ORvnqu/BVgDVwDVMbO459akCQfwSlZVfjiJo
         vN6DgF8TxDwzstItwozPNNgkQAafdb/9ZyJfaktMwJGLSvf8p1lK9rPcCQJRSuoShSk1
         3pFBPoBEWnn0K09LdvquJRCJQZiMUElQSjjTllMPzRsrtBSKTPBsCGQC5vEo/2sWc3/j
         PieIwXkuzkRayZbDAu5VG353bNkjEiHKK2DYpqJISLXFilZGvtW6uwMgygUKMwGhqOpf
         Czqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=deOLXjvMZIXVeNANpLpVuO42of2g4qJoxwxhsXOLKno=;
        fh=d6ii4jHsM52CPPdNRcEeeBkSUoYk+QjCnHzbEL+M0hI=;
        b=n+z2pYUUJ+MlY2jiAkAvjdz1EZeQQbi0hAchiORlb6p9SaJQeMQO87FhO6ZCVuf78t
         5iI1aTJIZwcQDjxBbD7tPr0y3HBKTP6cG40bVKqrdvCsWDw0BhQ6az3qlp4xHp524AGo
         OBWa4xdK0D1z1z19EfMffTZrETp7bhT/bdWVEpIvA0BXAmjFZ+OSTcrmWKT1ATebU6B3
         rlq1cqIaCJovUYPo9p7ofTN5RjkpFz0F0DSEQVSbVlVpGyVSpAJ0XPvG+XqY+mcqof2O
         40eE3z52abV798SDVOUdIdvWMTIAgkO14lyhKCC29hphSKxqgYZ4TxDP/p1RgrZ+14b8
         A82g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788159834; x=1788764634; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=deOLXjvMZIXVeNANpLpVuO42of2g4qJoxwxhsXOLKno=;
        b=mYur3Bm13RjuRWyCU/XB3bcup6MYfZq6Nl9+B8P0/mlrwc37YoP5PHrYMLErLOT2n8
         FAU5ikeVLj/0aths0bZpWhP8LI2R+OfbNrvUqjLVCz+biWqZ8LcVaw4yw0+jrNgr9nMJ
         RBukMTiWPG4AF4tJaqhTIBkYbcpio55O0F6FzgYWIkX9MYxb/CweVdIdFhoNAn1IWuPZ
         0o/x3c6XcTP8mvUTA63bxC2zKZ9WV6WSdU/CbL+dny2OmE1hoz2Y7rGaygXRW3/bAXrU
         pVZaGCsTuU7+2yywS6kE8rHCKjj3tIA42NWnOQvkT1hqQTqGd+xSsyeDsd+b/49r0Vj3
         0tGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788159834; x=1788764634;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=deOLXjvMZIXVeNANpLpVuO42of2g4qJoxwxhsXOLKno=;
        b=GwigmQlLa3XRn6H8GN8uRvNHUd3qXhmJxlxSp3wi127tJwmymmoyq3PcYdgyVV5eOt
         3nuVoFtJdSRA5AjXHv0xRRqvMvC9P0TuoXBKT2QtC1uTwew5iugLOsUxymMzoLshd6n+
         paY+qIQ728SXMPsWGR2uklRGDzzpgJWDbN3G53AIJ+vuTztPJ8EnIPuh3+I40C2LMgIw
         FNyZr0DFk6kcoGWMiWQkccSoX2v1FWpjcgUnMKtwHIN0Y+cl28SWXHsZ2jdTYV0TGm22
         vnb1EePAbAHVTsN45DOgffNxaEfm9RwIgjUJOtw7+uFnu3q4tVesQF5EraJjYQqVfAyk
         kD1w==
X-Gm-Message-State: AFuF++kgBi54eFYERHBvzo9D+WBdRuMSFF7VfDU0vvqMfo/YjNa4HRQj
	3Dx32ZSydcdAkTM8BjsxEQ/3ASv+VzOca1kcVGlVrJMZlDOvpu1LV9GijMBJfomcWx/21hnm3GZ
	VlmIr8Zl7GIFbYKQkFM94F7T+SvaPeRQ=
X-Gm-Gg: AYBFou08O0WlamfhuUjjs8Mm992TzPmqp/lOznWZegEVTLldNqX9Ax6wCjTjks1BMtt
	iu3tT0aTkEhGptnmdFyOaC7n6wQ2Wa/5syaKQFtZLZmUd88aKRfgC7LzFVEfLx3ZJA/iQVRf34C
	i5Ar4jj5ORB5/DEAkxkLcAEEJR0MXSRYKam/2gtDaE3EAMFF6PP//zFH7Ve0Mkr5T13sYnzV17l
	6VU7xvk0GaqTERinn39jSfrkOy0wgqjGRtCdnlcrDJa079MGiGGdfHW2VnZ2X/a2huAOSPu9eZ9
	ZQQ6fhdYSCp4egedXC8kp/WI1ZLMtHQgMXbrBymqPyU=
X-Received: by 2002:a05:6512:3050:b0:5ae:bbd3:27e3 with SMTP id
 2adb3069b0e04-5b5e689fb05mr7608311e87.5.1788159833464; Mon, 31 Aug 2026
 00:03:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMuE1bHr84n5LKcj02HmMR5XefPtvQ-UEJAx7+UKfYvRgS0eDg@mail.gmail.com>
 <12744a63-ac8e-4808-a559-f78fede30a40@amd.com>
In-Reply-To: <12744a63-ac8e-4808-a559-f78fede30a40@amd.com>
From: Sagi Maimon <maimon.sagi@gmail.com>
Date: Mon, 31 Aug 2026 10:03:26 +0300
X-Gm-Features: AcwNN1XPOHnRAmLFiBiL9XpPMa9FXyfskqPKL5CI85UY29DSgAOGnONBrwV4igc
Message-ID: <CAMuE1bHhsLnAOHkD85wrsJzZRvcZ4ib1fSfkcm_RYESRp+5_0g@mail.gmail.com>
Subject: Re: [RFC] ptp: ocp: exposing the TimeCard X2 AXI Ethernet port -
 which approach?
To: "Gupta, Suraj" <suraj.gupta2@amd.com>
Cc: Netdev <netdev@vger.kernel.org>, Jonathan Lemon <jonathan.lemon@gmail.com>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 30, 2026 at 5:05=E2=80=AFPM Gupta, Suraj <suraj.gupta2@amd.com>=
 wrote:
>
> Hi Maimon,
>
> On 8/20/2026 8:31 PM, Sagi Maimon wrote:
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
>
> Is AXI Ethernet being used for 1588 timestamping here?
>

No. The AXI Ethernet is a plain data path on this card. It does no 1588
timestamping, and this series neither adds nor touches any timestamping
support in axienet. It could be added later, as separate work.

> Could you please share the role of axienet in the TimeCard architecture,
> including:
>
> - Which timestamping device/IP is used

The FPGA clock/ToD block on the ptp_ocp side, disciplined by GNSS and the
local oscillator, not by network packets. That block is the PHC that
ptp_ocp registers. The MAC and AXI DMA sit at a separate register window
with no timestamp unit between them.

> - How timestamps are generated and handled

Not on this path at all -- there is no timestamp unit on the Ethernet
datapath to generate them.

> - How the driver interacts with the timestamping mechanism
>

It doesn't, and there is nothing in axienet for it to use: no
.get_ts_info, no .ndo_hwtstamp_get/set, and axienet_ioctl() only
forwards to phylink_mii_ioctl(). I mention this explicitly because the
Xilinx vendor tree's axienet does carry a hwtstamp/TSU path -- we are
not using, porting or touching it.

The scope here is only to expose the existing Ethernet port as a
netdevice by reusing the in-tree driver, rather than duplicating the MAC
and DMA logic inside ptp_ocp.

Thanks,
Sagi

> Regards,
> Suraj
>
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
> >
> > Thanks,
> > Sagi Maimon
>
