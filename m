Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EC33EC80F;
	Thu,  3 Sep 2026 19:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788463503; cv=none; b=T2cNNWuSrk4G7iw3FO7oe7UjSCRKNT9823XwKFBHxJ6asBoUt+B1z2iOj9t1FbcyF8H/LStGsH8B/PA7RrUJhMGSuyR5hqpfBf2fIJI0OFN8tZBt4peIS+jj3c8KosSQDPjhkVRo/aaT3GJav+xJFC1TNJ7ICjMnl1Rib2BqOgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788463503; c=relaxed/simple;
	bh=6e2gD6QLcFEtVG7hU0Yj1gEOgdQaw8jYJqN9uldQ7zk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PMN4cKl1Ki2aKq/+568GFKItCIi8V0oQm9d63RiScIJyeXL4ebS7g6lj3TSWqmJF6oMq8vlx7Ay9rSbIKiE+qHRHb83mC8wl7caANME3EUP30U30Cn44lqHC5Yw7q0Q6021eD3ePoHFM4hNt1wNfl8zTmlfFm09VnyHKt0IeukI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QR+YBgbx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QR+YBgbx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B30A1F00A3E;
	Thu,  3 Sep 2026 19:24:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788463486;
	bh=hHsEeH/muZhPQe+lUD8KE1ihnHWojWxpzhUTua+LvP8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QR+YBgbxeTBqix5sDVvE/+rMDlh8us2tv3Z210BkM7jJBKwtgV5m8KPuZBgJtv2Yi
	 bJKL8hCFS6cRI0vXCd/LN4b24GRcBZ7/cPAkfZi9CJxeoWPNmhklVqGDUkiqaruwvi
	 6a43V0kBnjj3RZIWmi9hUHpRkl7Y+suyUza+Wh2pad0Q603HZN41cyWr8XI2WiOe2c
	 4yumBgdG6YskpO914kdKgYQtWnrRSsWqySV/pCMF1lMCbUo5Y4QWRTRAddg8YLIHbK
	 16umTL5cuBC8xDlTtX1RwAJYOKxFXwL5+Q/UerHybSuDYOSemJtYNOFm9+x16kxgJA
	 SxNyc8nON39uQ==
Subject: Re: [v9,net-next,3/8] octeontx2-pf: switch: Add pf files hierarchy
From: netdev-bot+sashiko@kernel.org
To: rkannoth@marvell.com
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, sgoutham@marvell.com
Date: Thu, 03 Sep 2026 19:24:45 +0000
Message-ID: <178846348581.3394541.11802559971699122599@kernel.org>
In-Reply-To: <20260831131944.2649362-4-rkannoth@marvell.com>
References: <20260831131944.2649362-4-rkannoth@marvell.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 0 · Low: 1

- [Low] Scaffolding-only commit: the new user-visible Kconfig symbol
  OCTEONTX_SWITCH (drivers/net/ethernet/marvell/octeontx2/Kconfig:31-39)…

--

octeontx2-pf: switch: Add pf files hierarchy

This adds a new user-visible CONFIG_OCTEONTX_SWITCH symbol, creates the
nic/switch/ directory, and links the new stub objects into the rvu_nicpf
module. All of the new sw_* init/deinit and notifier entry points are
empty bodies returning 0.

> diff --git a/drivers/net/ethernet/marvell/octeontx2/Kconfig b/drivers/net/ethernet/marvell/octeontx2/Kconfig
> index 47e549c581f0d..e2fb6dd71078b 100644
> --- a/drivers/net/ethernet/marvell/octeontx2/Kconfig
> +++ b/drivers/net/ethernet/marvell/octeontx2/Kconfig
> @@ -28,6 +28,16 @@ config NDC_DIS_DYNAMIC_CACHING
>  	  , NPA stack pages etc in NDC. Also locks down NIX SQ/CQ/RQ/RSS and
>  	  NPA Aura/Pool contexts.
>  
> +config OCTEONTX_SWITCH
> +	bool "Marvell OcteonTX2 switch driver"
> +	depends on (64BIT && COMPILE_TEST) || ARM64
> +	depends on OCTEONTX2_PF
> +	default n
> +	help
> +	  This driver supports Marvell's OcteonTX2 switch.
> +	  Marvell SWITCH HW can offload L2, L3 flow. ARM core interacts
> +	  with Marvell SW HW thru mbox.
> +

[Severity: Low]
This isn't a bug, but the help text promises behaviour that this commit on
its own does not provide.  At this commit the option only adds two empty
object files: every function it enables is a stub, and nothing in the tree
calls sw_fdb_init(), sw_fdb_deinit(), sw_fl_init(), sw_fl_deinit(),
otx2_sw_fib_init(), otx2_sw_fib_deinit(), otx2_sw_nb_register() or
otx2_sw_nb_unregister().

A grep at this commit for those symbols matches only the newly added
switch/*.c and switch/*.h files, so turning CONFIG_OCTEONTX_SWITCH=y has no
runtime effect here.  The real bodies and the call sites appear later in the
series, where otx2_sw_nb_register() registers the notifiers and calls
sw_fdb_init(), otx2_sw_fib_init() and sw_fl_init().

Would it be preferable to introduce the Kconfig symbol in the patch that
first wires up the functionality, so that no released bisection point offers
a switch option that does nothing?  Alternatively, the help text could say
what is actually offloaded once the series is complete.

Two small nits in the same text: "Marvell SW HW" looks like it should be
"Marvell switch HW", "thru" should be "through", and "default n" is the
Kconfig default and can be dropped.

>  config OCTEONTX2_PF
>  	tristate "Marvell OcteonTX2 NIC Physical Function driver"
>  	select OCTEONTX2_MBOX

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c
> new file mode 100644
> index 0000000000000..500451e85b503
> --- /dev/null
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_fdb.c
> @@ -0,0 +1,19 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Marvell RVU switch driver
> + *
> + * Copyright (C) 2026 Marvell.
> + *
> + */
> +#include "sw_fdb.h"
> +
> +#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
> +int sw_fdb_init(void)
> +{
> +	return 0;
> +}
> +
> +void sw_fdb_deinit(void)
> +{
> +}
> +
> +#endif

[ ... ]

> diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
> new file mode 100644
> index 0000000000000..426a420119301
> --- /dev/null
> +++ b/drivers/net/ethernet/marvell/octeontx2/nic/switch/sw_nb.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Marvell RVU switch driver
> + *
> + * Copyright (C) 2026 Marvell.
> + *
> + */
> +#include "sw_nb.h"
> +
> +#if IS_ENABLED(CONFIG_OCTEONTX_SWITCH)
> +
> +int otx2_sw_nb_unregister(void)
> +{
> +	return 0;
> +}
> +
> +int otx2_sw_nb_register(void)
> +{
> +	return 0;
> +}
> +
> +#endif

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831131944.2649362-1-rkannoth%40marvell.com
