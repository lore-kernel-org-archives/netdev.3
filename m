Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 874AB2E0914
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 05:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786943251; cv=none; b=pH+swzzUwIhexYtVeUPYHeaysaQifV7EnpKpd8qN+a0wilwXu+9VQmjcYLn2ErojaLFNnhRpzXSMrVQSYZ3XmSQP89dl4tOp0AJZesgZNZas9yLoIlSVyrujzZXtrxBh+/YPLi2cZx4fDDZdiSf78PEgfTCH29LZqDS0Y0hFlcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786943251; c=relaxed/simple;
	bh=CZsGDR7Jj3sc7V6hHrZSAF+wL1e/VqLtBl0pEZfNlJY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d8BjUMyFOpkgjSfb8Ey3BjBEnQfaefzegvRoV0mmh6gBZY5LbuxM+IKHHehS5LxkVCyxV598EB5X/0Jb53hdpWLQ/fHzUC2VpGt9YJTTyR8p2qTb5FWTrBC1a7CV6f1hoPyCl8skwpaURD0+z0OInBicuBfVWP00EslhHGOxyJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M9zvdPVc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M9zvdPVc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55FA71F00ADF
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 05:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786943249;
	bh=yS38VDvjxIHvJQQePFE/uve25YqUcMbvKDjYh88GLeY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=M9zvdPVc5p3HxjAc7XDyEsBr37odzVTSWEJT0oHPHoifoMRlpVYSqmIUWyAnj62g3
	 qspdCmXnyg/HuEkBdM+Uc2ZXDfVwVnZ3mNKArVHEO4qVgStfPP8GsWMisfZi1PDXqX
	 v6vCmOAox13wGPZfDn7sKJPibcbpPug4/T6s7L9OEhpkjUl03q1HDzmz3TckRh6dIg
	 bbPBB4ARW7NeehEy2SJ8ryIRGZ65cocBEvdkcMh19nB801AoUAgcZaho0N4BzKif0M
	 ro5LKtHB2SPkwtGFf4aoadIcq+MFeiK0BLPC4FSy/dO7rwhRNs+qqwYsrlZccauGy8
	 cQXotCctOl+IA==
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c15cb6f5c12so537134266b.0
        for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 22:07:29 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrgg6j7wwfDU1qoNnMD+y6F1cJqmvVwMVfJtEC9XNuxY7WbM40GdDpUpQFznbyC9gQPN0bPDes=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMjUfHRxZyS/seMiyZKFuUBXcXdjM1J+29qEAo+5xKeYNUyYAr
	6/isnme+wv0ja3GbGhVJeyAqWdUXFMJM6q8YpTNOq9jwERmGe+AtmtEESugZtGA6mfyVUSNQsZ2
	jEQ6+rubFnRbi0JTQgXPvoSWkfBR0nyg=
X-Received: by 2002:a17:907:3ea0:b0:c20:af9d:454a with SMTP id
 a640c23a62f3a-c216bbc2660mr283350466b.16.1786943248103; Sun, 16 Aug 2026
 22:07:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260816-submit-phy-package-fwdevlink-v1-v2-0-23e55dd59fad@gmail.com>
In-Reply-To: <20260816-submit-phy-package-fwdevlink-v1-v2-0-23e55dd59fad@gmail.com>
From: Saravana Kannan <saravanak@kernel.org>
Date: Sun, 16 Aug 2026 22:07:16 -0700
X-Gmail-Original-Message-ID: <CACRMN=eWk8OTgAQio2COZnpL3EP+Bb4k6iF+ypX_Z0s2pmsUUA@mail.gmail.com>
X-Gm-Features: AcwNN1UZfpzsKhPz-t7ewM8k9bTtKAZVHDHfDBwqkJA6wsgvrBMdMaJInNki1J4
Message-ID: <CACRMN=eWk8OTgAQio2COZnpL3EP+Bb4k6iF+ypX_Z0s2pmsUUA@mail.gmail.com>
Subject: Re: [PATCH net-next v2 0/4] of: mdio: fix fw_devlink for Ethernet PHY packages
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Christian Marangi <ansuelsmth@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi James,

Thanks for the patch set.

On Sun, Aug 16, 2026 at 5:00=E2=80=AFPM James Hilliard
<james.hilliard1@gmail.com> wrote:
>
> Ethernet PHY package nodes describe resources shared by their member
> PHYs, but the package node is a container rather than a struct device.
> fw_devlink therefore represents those dependencies with temporary
> sync-state-only links from the closest existing ancestor device to each
> supplier.
>
> For OF MDIO, that ancestor is the MDIO bus class device. The bus is

This is not a unique problem, but not too common. This is exactly why
__fw_devlink_pickup_dangling_consumers() has:

// Email comment: This picks up class devices intentionally
if (fwnode->dev && fwnode->dev->bus)
    return;

And not:

// Email comment: This would have not picked up links from class devices.
if (fwnode->dev)
    return;

We can have cases of class devices being consumer devices and
preventing sync_state() and also cases of class devices being supplier
devices and preventing consumer device probes.

The right fix is to have class devices properly update the device link
states of MANAGED device links similar to bus devices being probed.
So, a class device being added should start off with dl_dev_state is
DL_DEV_PROBING, and if the device_add() finishes without issues, move
the dl_dev_state to DL_DEV_DRIVER_BOUND. Similar changes for class
device removal, start off as DL_DEV_UNBINDING, and end up in
DL_DEV_NO_DRIVER.

This has been in my todo list for way too long (see previous LPC
talks). So, I'd be happy to review it if someone wants to take a stab
at it. I have a clear design and corner cases in my head and it just
needs to get converted to code and I've been swamped.

You just need to create equivalent functions to
device_links_driver_bound() and call it at the end of device_add() for
class devices. Or something along those lines.

> driverless, so its proxy links never reach the usual driver-bound
> cleanup. They can remain after all member PHYs have probed and
> indefinitely prevent suppliers from receiving sync_state().
>
> Before fixing the proxy-link lifecycle, skip supplier links when a bindin=
g
> cannot resolve its consumer node. This prevents malformed graph descripti=
ons
> from passing a NULL consumer to the fwnode-link core.
>
> Fix both parts of the lifecycle. First, factor the sync-state-only
> cleanup already performed by device_links_driver_bound() and expose it
> to frameworks which populate children below driverless devices.

This should be fixed at the driver core level. No need to fix it one
framework at a time.

-Saravana

> Next,
> treat each enabled member PHY as a consumer of suppliers referenced by
> its package node. Finally, call the cleanup helper after successful OF
> MDIO population. The real links from each member PHY retain dependency
> and runtime-PM ordering.
>
> This was found while validating an X-Powers AC300 package whose input
> clock is supplied by PWM. Before the fix, the PWM driver reported that
> sync_state() was pending due to stmmac-0 even after the PHY had probed.
>
> The complete fix was tested on an Allwinner H616 board with an X-Powers
> AC300 PHY package. All five real supplier links targeted the member PHY,
> and no proxy link remained on the driverless MDIO bus. The PWM supplier
> reached state_synced while continuing to generate the PHY clock. The PHY
> negotiated a 100 Mbps full-duplex link, 8 MiB was transferred in each
> direction, and 100 consecutive pings completed without loss.
>
> Validation completed with:
>
>   - arm64 defconfig object builds of driver core, OF property and OF MDIO
>     with W=3D1;
>   - strict per-patch checkpatch checks; and
>   - the H616/AC300 hardware test described above.
>
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
> Changes in v2:
> - Add a preparatory guard for malformed graph consumers (reported by Sash=
iko)
> - Rebase on net-next/main
> - Link to v1: https://patch.msgid.link/20260814-submit-phy-package-fwdevl=
ink-v1-v1-0-2319844f057a@gmail.com
>
> ---
> James Hilliard (4):
>       of: property: skip links without a consumer node
>       driver core: factor sync-state-only link cleanup
>       of: property: link PHY package suppliers to member PHYs
>       net: mdio: release fw_devlink proxies after population
>
>  drivers/base/core.c        | 74 +++++++++++++++++++++++++++++++++++-----=
------
>  drivers/net/mdio/of_mdio.c |  5 +++-
>  drivers/of/property.c      | 18 ++++++++++-
>  include/linux/device.h     |  1 +
>  4 files changed, 79 insertions(+), 19 deletions(-)
> ---
> base-commit: e6a5d573d24cd375e09d24f136523cb3cc85c9d3
> change-id: 20260814-submit-phy-package-fwdevlink-v1-76a8f9efe539
>
> Best regards,
> --
> James Hilliard <james.hilliard1@gmail.com>
>
