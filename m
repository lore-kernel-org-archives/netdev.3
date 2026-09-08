Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EFB566C77;
	Tue,  8 Sep 2026 16:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788884268; cv=none; b=gdihXY+/z0PBmerHOvICLrPmzp8O9tQHpudFQdYRYU6jJy8p6CYGo/TOA4aopslSBxPPoOeR4zVK/KDh4eBSvU4po3D05h53ZvTWMFm2jdydRnN0hLRBwTSbVUotXOPC6EK3VChJwCxKRmYJp7TSSjJ/avsgSE7x+uHx6OpwjEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788884268; c=relaxed/simple;
	bh=Bg+LfqyEsGkhckYggMUqul/pcpkqv8OR/eyE/SJQNAo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VZuLnxFi0x0Qbdo1s5JE7cdxCDC6ZoSH+YYmxOj9i+YB0mhorDKrgjgLEn7taHuHBZWlTJtrOpgO06cXF+2W6XsTfDvdwIfdZaBMihspm7Ge0KOuIekA3ORDNeqe7LzNqWtENt/GmejPULALc+L1heVmeZfeFReJpSWv7Aih90Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WN59U50U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WN59U50U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 30C8D1F00A3A;
	Tue,  8 Sep 2026 16:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788884264;
	bh=tnZJ4TAR3Sf4Zu6CGRu48cBWy8dW5MWtCE2PWAjoCqc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WN59U50U5G1EKkyX71IUfpoCdPMeC5d90wuJ/gt98+xen9YCUqh8ZG/YidigHUXPP
	 IhlM+NWOWtOUgVdRMk/Gj3buyE37EJaDBeIjp7O5OKeNjkfshbqSp0hAzWT8B5oBV1
	 WQT3dMZizZKwfQeYfA6x2HryRi+AHeGoF8V+H/+ulNhAs+W2K5TbyoXfUAtDR0FPK1
	 yTxOB4s7Jt43xHu2Zdztz3cqSRqiNiHT3JhpEqn6NupYlI+jAxMF3OpxToeAWeXJHW
	 Z8DevSzdNm6cXa86lBRAhOUHOiU+hcxTbDFyjqzhX95SZhD2HKD83uyo3zgDG15oS4
	 1fo4L3eHIz/Kg==
Date: Tue, 8 Sep 2026 17:17:41 +0100
From: Simon Horman <horms@kernel.org>
To: Richard Patel <ripatel@wii.dev>
Cc: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Steve Douthit <stephend@silicom-usa.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH iwl-net v2] ixgbe: fix MDIO bus lifetime
Message-ID: <20260908161741.GB40544@horms.kernel.org>
References: <20260906023319.1978945-1-ripatel@wii.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260906023319.1978945-1-ripatel@wii.dev>

On Sun, Sep 06, 2026 at 02:33:19AM +0000, Richard Patel wrote:
> Plugging in an unsupported SFP module caused ixgbe NICs to get
> wedged permanently.
> 
> ixgbe unregisters the netdev when rejecting an SFP transceiver as
> unsupported.
> 
>   ixgbe 0000:3b:00.0: failed to initialize because an unsupported SFP+ module type was detected.
>   ixgbe 0000:3b:00.0: Reload the driver after installing a supported module.
>   ixgbe 0000:3b:00.0: removed PHC on enp59s0
> 
> This code path failed to unregister an MDIO bus owned by that
> netdev, so when unregister_netdev() tries to tear it down
> (via device_del() -> devres_release_all() -> mdiobus_free()),
> it trips over the leaked registration.
> 
>   ixgbe-mdio-0000:3b:00.0: not in UNREGISTERED state
>   WARNING: drivers/net/phy/mdio_bus_provider.c:711 at mdiobus_free+0x3d/0x50, CPU#21: kworker/u128:0/12
> 
> This prevents ixgbe from reloading, even after PCIe remove/rescan:
> 
>   sysfs: cannot create duplicate filename '/class/mdio_bus/ixgbe-mdio-0000:3b:00.0'
> 
> Switch to devm_mdiobus_register(), drop custom unregister calls.
> This is safe because the bus is already devm-allocated, so unregister
> always happens before free.
> 
> Assisted-by: LLM
> Fixes: 8fa10ef01260 ("ixgbe: register a mdiobus")
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Signed-off-by: Richard Patel <ripatel@wii.dev>
> ---
> v1 -> v2: use devm_mdiobus_register() instead of another
>           mdiobus_unregister() call
> v1: https://lore.kernel.org/netdev/20260826042945.2344686-1-ripatel@wii.dev/
> 
>  drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 9 ++-------
>  drivers/net/ethernet/intel/ixgbe/ixgbe_phy.c  | 2 +-
>  2 files changed, 3 insertions(+), 8 deletions(-)

Reviewed-by: Simon Horman <horms@kernel.org>

