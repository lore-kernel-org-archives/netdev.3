Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B7039A05D
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 03:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785554029; cv=pass; b=IOnV+x7RMbFkYBgaEpGP3PIPNj+uMjKazu7S5esDZal1InI5MBJ135B65XpXGADjt2a0DU3ou5rHopiMFxqUyrsSm7ZUcZdnKYytnPt9fhDmK2l9Cc90jG9lK1sRuoo2FPsHk4SyqKjwGtwYS4lohjIU+Uvj0WMYXFeB7eSwAsU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785554029; c=relaxed/simple;
	bh=95QCJbuFW0DJ4I2GQ9WngTVOHrimeZjlLTACZfyrPGs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qgGU4H3SD1rWAi7/yWFTvUtQ2v4rI05FxjrKOeN89tSBdYnkOTHXh74/vr3QoZsnjKfb2t7W7IU4yx7uZFzY+8usQv6tfAnglRdPNLwjzVJdaX060nizOUyXXhy28H5+cxgoVxsS2jsGb8W9RNzpxNvFrVsXR8K29hedZrsgcxU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=debian.or.jp; spf=pass smtp.mailfrom=gmail.com; arc=pass smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=reject dis=none) header.from=debian.or.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-81ed000b507so15858767b3.0
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 20:13:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785554027; cv=none;
        d=google.com; s=arc-20260327;
        b=BGKJfjuMvMekURuOZ+B1YEFX1KiExPWIy9Jk4sX7AxBZ43CSkcpK2DuId4LfsC4nCC
         4AmJDB9PYiArrSxi2r7zWafwRK8SPSdmWgeJ9m0gN8zR4z4ZngXJoJt+bM2X37NVwIPY
         HUmiSSbbSbgGQmcytwPSXFa+8Gmd4LycSSIkbdAblbydRKn0PS+bjSXSz9uCbtdETVhE
         A1akfUyn/jH5GZnI3Xc4LIGuN1vnBIonSIW1GF6ngays3dCLDVnvw9LxcCOJB7exAkxb
         wXqDUqkcsLn7F7awYO5qYLPqSatJgLziBrOyit4oHGQo4HcvIQC1eFBFt8eveNNTsV8v
         SelA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=SeAZ9LnHsy3/NLwDMK5sclw7WS1BzURw2kr/GeL6nEM=;
        fh=/IVd7mwAfdyg9J92AsHPQheNJWL5ubVA2oGkVM88vS8=;
        b=KYwp8sERVA4H1JM9ZHfpTYHO2oqChnPZPHtRuOHy8A93lw8OdorG1MNFhvQl6qVemQ
         wn9C6MBWisO3vL7GVtd1oi9yef4SjXrlTJ5t9jbs/MfW1Pg0qJlkQwohJgYEnsSYSwpo
         IYCUqMXDErkVf7rUmAk0okZy7QcBXMPuJ1PowqDt64KCxhz19k5UK1tIgd6klhyyes4v
         3PUCqK/GT6/JUWsM5ritOHnGbsKRZg7pIthaDdcVxAKYzAS7K8uIwp28mdX7SXtvTqWq
         5iAuo+piNE9EMQkqE3o7qI1C+NCF1YtGSmKs88j1Dj/NIxZxy1Lg/Yrj2NWhv6dW/alh
         Q6BA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785554027; x=1786158827;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=SeAZ9LnHsy3/NLwDMK5sclw7WS1BzURw2kr/GeL6nEM=;
        b=q+ULwsY1CdxFzIZSvBZK6PliObHuR/kn7SVbgGZw58UPRr7wkCAwkOoxOtpIAqMDcF
         q2TRq/4KrTWI4li0yOsgChx1vU4mtO+ijJEZKmH8mNJHm69Vub/yZg7IatNrYjnmfTXQ
         4oCclEz/1Dfk273cRcEGqcladqA3/uYdRZsfsqv1SivCB9lci6NBQGIgPSvQ3c89+CnO
         MokkLBM6wBfXguBbH7FpDr/ZAmZYxPHYRzkcX6P7jiO0HueqoA5tqjGvEcFwHBT1BfhQ
         aFp138+HRJ9TvyM2fm0UuHJczP8zIObiQyvzlBjtkq7cMlXZ7YuSRL8w+xG0n6qYMMaI
         GhZA==
X-Forwarded-Encrypted: i=1; AHgh+Ro6WogPZ3U5mas+TfZPWb7bvZsylVBf6Gr3CKbPp2QPlmx2WydbcwC/iEsUl47vF1MVmP5801Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxmYhWZkDudyy01WgZ7OUf8STQkc4dM5YgoXMMLhf/ieK9cxnRC
	7W/efMSE4LShFaTJFn3ojzsslchCrWnH4VrVx6Fip/z2den7DigykP55yLuUF6g3rOVkPs3cS84
	X1Bz9GzeX0AF2k+pvI+WkfKUTUrCbNLY=
X-Gm-Gg: AR+sD11lxoiTXxke3dZp1QtBLPxcNB7uQVFogdjf1qI+JMet4va1uVPIB3rBUbk0+Ot
	UAjhcRrq1w/1GIDrvlvE6YUJ90d6yX5G1+7/kbVzKOgEv15aeE9t2PDRWyybuQRsMQ1Sz38Rr6i
	tbR3viiG+4EzlPPkqdhllHNdDH1yxH2+nTojRZdTyNZ9FHkn+qFEwwau8NDeHgf5B8d1CUj/Ki1
	WgfIvbN24/F7yCv5NR/ft2nmqZ7soXyGlnDVWZokq27fiC6uX7P8jWuscE7sVkiYU21GGtFVQ81
	Oevvfn274li2jKcpeu/YmmqG0Nb+3SFb+y8bo7SasOuWo59FGBd+qDUg6orxNAy3lCCT+de689b
	Jsw==
X-Received: by 2002:a05:690c:278a:b0:81c:b865:2231 with SMTP id
 00721157ae682-81fd4bf88ecmr32651387b3.33.1785554025363; Fri, 31 Jul 2026
 20:13:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723-pci_id_fix-v4-0-3580726844e1@garyguo.net> <20260728162538.GA1325438@bhelgaas>
In-Reply-To: <20260728162538.GA1325438@bhelgaas>
From: Masanori Goto <gotom@debian.or.jp>
Date: Sat, 1 Aug 2026 12:13:18 +0900
X-Gm-Features: AUfX_mz7siEIuZSDLGecSdNp4xhgCzEOOClyi0oT7r0lmGspOzwc1eUhhS3W20M
Message-ID: <CALZLnaEmm5Zi=30n4i7ioX9ii4KMAePnZTAhAcNScSZFSNB7UA@mail.gmail.com>
Subject: Re: [PATCH v4 0/9] PCI: Fix UAF and TOCTOU related to dynamic ID
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Gary Guo <gary@garyguo.net>, Bjorn Helgaas <bhelgaas@google.com>, 
	Zhenzhong Duan <zhenzhong.duan@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, 
	Niklas Cassel <cassel@kernel.org>, YOKOTA Hiroshi <yokota@netlab.is.tsukuba.ac.jp>, 
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Vaibhav Gupta <vaibhavgupta40@gmail.com>, 
	Jens Taprogge <jens.taprogge@taprogge.org>, Ido Schimmel <idosch@nvidia.com>, 
	Petr Machata <petrm@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, David Airlie <airlied@redhat.com>, 
	linux-pci@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org, 
	linux-scsi@vger.kernel.org, industrypack-devel@lists.sourceforge.net, 
	netdev@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	Sashiko <sashiko-bot@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'm a "nsp32 folk", which patch version should I take a look at?

Best regards,
Masanori


2026=E5=B9=B47=E6=9C=8829=E6=97=A5(=E6=B0=B4) 1:27 Bjorn Helgaas <helgaas@k=
ernel.org>:
>
> On Thu, Jul 23, 2026 at 11:00:39PM +0100, Gary Guo wrote:
> > While working on improving the Rust abstractions [1], Sashiko reported =
that
> > an existing UAF issue related to dynamic ID, which I find to be genuine=
.
> > When taking a look at the code I also find a TOCTOU issue where the
> > existence check of dynamic ID happens in a separate critical section as=
 the
> > actual insertion. This series fix both issues.
> >
> > There are two exported functions pci_match_id() and pci_add_dynid() whi=
ch I
> > have to tweak to implement this cleanly; I created separate "do_xxx"
> > functions to keep the existing APIs because they all have multiple user=
s.
> >
> > There're a few existing users which stores their pci_device_id argument=
 in
> > probe callback. This is a bad pattern because nothing except driver_dat=
a
> > inside pci_device_id is what they want; actual ID information can be
> > retrieved from pci_dev instead.
> >
> > There are two users that performs pointer arithmetic on the pci_device_=
id;
> > these are also problematic with dynamic ID and driver_override, so fix =
them
> > as well.
> >
> > I've used the following coccinelle script to flag all cases where the
> > pci_device_id is used other than reading its fields.
> >
> > @usage@
> > identifier fn, id;
> > position p;
> > @@
> >   fn(..., struct pci_device_id *id, ...)
> >   {
> >     ...
> >     id@p
> >     ...
> >   }
> >
> > // Due to cocci isomorphism this needs to be explicit
> > @bad@
> > identifier fn, id;
> > type T;
> > position usage.p;
> > @@
> >   fn(..., struct pci_device_id *id, ...)
> >   {
> >     ...
> >     (T*)id@p
> >     ...
> >   }
> >
> > // Good use cases
> > @good@
> > identifier fn, id, fld;
> > expression E;
> > position usage.p;
> > @@
> >   fn(..., struct pci_device_id *id, ...)
> >   {
> >     ...
> > (
> >     id@p->fld
> > |
> >     E(..., id@p, ...)
> > |
> > // Redundant checks, but ignore
> >     !id@p
> > |
> > // Redundant checks, but ignore
> >     id ? ... : ...
> > )
> >     ...
> >   }
> >
> > @script:python depends on usage && (bad || !good)@
> > p << usage.p;
> > @@
> > coccilib.report.print_report(p[0], "suspicious use of pci_device_id")
> >
> > Link: https://lore.kernel.org/all/20260618-id_info-v1-0-96af1e559ef9@ga=
ryguo.net/ [1]
> > Link: https://lore.kernel.org/all/20260619170503.518F61F00A3A@smtp.kern=
el.org/ [2]
> >
> > ---
> > Changes in v4:
> > - Code and commit message style fixes (Bjorn)
> > - Link to v3: https://patch.msgid.link/20260706-pci_id_fix-v3-0-2d48fc0=
25acc@garyguo.net
> >
> > Changes in v3:
> > - Fix users which uses pci_device_id for pointer arithmetic. (Sashiko)
> > - Convert to scoped_guard. (Danilo)
> > - For static IDs, still give out static pointers and avoid making a cop=
y.
> > - Link to v2: https://patch.msgid.link/20260630-pci_id_fix-v2-0-b834a98=
c0af2@garyguo.net
> >
> > Changes in v2:
> > - Fix users which store pci_device_id.
> > - Clarify in probe documentation about the lifetime of pci_device_id
> >   parameter.
> > - Dynamic ID conflict check now ignores override_only. (Sashiko)
> > - Link to v1: https://patch.msgid.link/20260626-pci_id_fix-v1-0-a35c803=
f1b95@garyguo.net
> >
> > ---
> > Gary Guo (9):
> >       ata: ata_generic: don't store pci_device_id
> >       scsi: nsp32: don't store pci_device_id
> >       ipack: tpci200: don't store pci_device_id
> >       mlxsw: pci: don't store pci_device_id
> >       agp/via: Don't rely on address of pci_device_id
> >       agp/amd-k7: Don't rely on address of pci_device_id
> >       PCI: Make pci_match_one_device() match on ID instead of device
> >       PCI: Fix dyn_id add TOCTOU
> >       PCI: Fix UAF when probe runs concurrent to dyn ID removal
> >
> >  drivers/ata/ata_generic.c                 |   6 +-
> >  drivers/char/agp/amd-k7-agp.c             |  26 +--
> >  drivers/char/agp/via-agp.c                | 308 +++++++---------------=
--------
> >  drivers/ipack/carriers/tpci200.c          |   1 -
> >  drivers/ipack/carriers/tpci200.h          |   1 -
> >  drivers/net/ethernet/mellanox/mlxsw/pci.c |  11 +-
> >  drivers/pci/pci-driver.c                  | 194 ++++++++++---------
> >  drivers/pci/pci.h                         |  43 +++--
> >  drivers/pci/search.c                      |   8 +-
> >  drivers/scsi/nsp32.c                      |   8 +-
> >  drivers/scsi/nsp32.h                      |   8 +-
> >  include/linux/pci.h                       |   1 +
> >  12 files changed, 237 insertions(+), 378 deletions(-)
>
> I put this on pci/enumeration and plan it for v7.3, hopefully with
> acks from the AGP, tpci200, and nsp32 folks.
