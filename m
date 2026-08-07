Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E6DE3F58C2
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 20:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786136308; cv=none; b=Rp0VpFdNbFtTwBgwxDFXZ0YwAonWpBzLAVfOI8lqulplIGCkF4ZXWbU7/x9JoVHJQp1r6K3VFS7EM54txLXYFlT6Rphi9KKYq6dmaSiYOZJ8D+oqapaBGCVH4KdEIPZT4aj9D6E/ZnteQWDaZIX2syYwFqSmI4Q1i/58/clzVzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786136308; c=relaxed/simple;
	bh=2J/UP/+6DMH2CHEER9PVAEvN6Vtdaca1g6fEmR+C3dU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YtkligJHzTlS2ZcAU5gM2vYh6TojPQpyVsSUMCotDJ97JIp+9qMCMluq58BMXxGFhqarXWRUH9GT6C+tKkJLR5Qh/7eDzX2shmhzlh5sfN/+PfsCUYpH7jEGUWVdcExJOzpQSWWnBFZLZusI7WQZHwGMqd9j0xFltSsmRavElsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=lz1Rd8VC; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="lz1Rd8VC"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4957eefd361so28741335e9.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 13:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786136305; x=1786741105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Ub+G0Ff6hsiwxt6UoJCvVXER5yXovtTMeMwmgc6K8J8=;
        b=lz1Rd8VCvRx7qtS80RxVEavo94LfoBnLpZwb21SCH4j4bTt9UZb0KA+ydFxRIVt7FL
         nxdSsWa74XLiyTQWKTUyAF2pAweLrVmrv+K/+4ntTWWRH7GF9eyT/65qdgEdmJUYMErW
         KwADCpdTBl8zmlaAtd/gN9DP0VLYLq0XIdf00XZzaq32No1ICxgvWuKjx/Iu4Qb+ImGC
         /47SKKrJC+AZf94OJnmycGyyEDOaOq12/Qhi4+GEmYC3Tt0Md/GATxtFUhb6BI+yU7o/
         vN2JER+ycA7xIOPH+nP9nyza8XvzeaQboVHw8kER6MhsVksVDEskb+OoqLyD1Cpg9+Ot
         cpoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786136305; x=1786741105;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Ub+G0Ff6hsiwxt6UoJCvVXER5yXovtTMeMwmgc6K8J8=;
        b=KsIwg1TVWIXlbyl13nb0Q2267FWIR6RKqeetD+icQvQ8c82S5dI6VWlEpA8JgF1BeU
         kNpmorHQQ4G8p38CLFgoLlbRY0wRA/0mbVwpQjnDeFWU14BNjtAx1CxwJy81uB5e8m2D
         GkNsVqP58j8z0YFn0ZW6SLPUi+29g8u3V51zo7VSVWp1xiHfrod6gxKhYyvaulltEKNl
         As3l5BLVfzhxi2lK9N4OjV5pW5PClYuKR3gZ2HTfAajcYNSPA0vUP+jqjRABnm/iA/g7
         a2TKHkQ+oIcrt1JkKpBH3mOp+CeZ80AUwq8oxupgQd3+p/U9zSRv1a2CjoqK0tC/xuFh
         Np2Q==
X-Forwarded-Encrypted: i=1; AHgh+RpstMplrbE0vCS+Yrg3ryW4j6wZ9uZz2XmOxlcjhuxovcqjXviPxN1h8rHSOt1tVaMGoxqIUbk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyM6YE+cZhQWtZGKajfoxI9zn/7Lai8gNhZDwuDpEUD8mqG2/Ue
	5A1PinsiTGTvHnMvN1GpqNx30NLkZIjhm05PxJl176V1nVQR3yUPHr6L2tyGw6vtk/Q=
X-Gm-Gg: AR+sD13AETSpZcgnsko5EMsudoSyLkI2UHLLhPWz5dtK41wjzwPxOUEpaUGBiQzo6gU
	EGEh4eT82wSplgqz+VAl9KALYuOhaO7/eMxe+PlrS/fm9S0CeDeE5+9pwUsBhdsBV1/dBcSsISB
	qDDFCNvKI4/0RpJfUTkMeYdD2R5KB2fndi5GPng2EZ78gWNL572MCp1WfgekJAoC1q6O/P3yFSg
	cDASWCGLanlyGCj5Tkw74kiapVKnAKzKtABWRvWfVmBPYi1cf6m2yRXAxlUIsKaxmPVtxQ44d1a
	0oRW+hsHSsfJOvgZ7CU6Z7xXQ1r/1yOdsReeSOC569/0XYli93w9cjh4oBl8LonJ+yorqLRIAc8
	v2CcLLxVuEIkgCx/u4jyxU+ysjFbf3C63qru01sIYHuIhyImwG1KOOs7F02ltCx1HvumwXGzNej
	BKa3ustyuYKt5RAXUbUurUF7zw3PFAfRl5U9FVeQ+eHgwX2Jwh23k9nD2CLRiU5W0l6g==
X-Received: by 2002:a05:600c:6612:b0:495:4811:7998 with SMTP id 5b1f17b1804b1-4995e0ebf84mr102518595e9.17.1786136305361;
        Fri, 07 Aug 2026 13:58:25 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4800215078asm8418961f8f.12.2026.08.07.13.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 13:58:24 -0700 (PDT)
Date: Fri, 7 Aug 2026 22:58:23 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
Cc: Srinivas Neeli <srinivas.neeli@amd.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, Michal Simek <michal.simek@amd.com>, 
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
	Simon Horman <horms@kernel.org>, Russell King <linux@armlinux.org.uk>, netdev@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, git-dev@amd.com
Subject: Re: [PATCH 02/20] net: xilinx: tsn: add TSN endpoint wrapper driver
Message-ID: <anZGPKSopP9GLKJt@monoceros>
References: <20260807104431.157230-1-nagadheeraj.rottela@amd.com>
 <20260807104431.157230-3-nagadheeraj.rottela@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="yneap3wk5hqcchh7"
Content-Disposition: inline
In-Reply-To: <20260807104431.157230-3-nagadheeraj.rottela@amd.com>


--yneap3wk5hqcchh7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH 02/20] net: xilinx: tsn: add TSN endpoint wrapper driver
MIME-Version: 1.0

Hello,

On Fri, Aug 07, 2026 at 04:14:13PM +0530, Nagadheeraj Rottela wrote:
> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c
> new file mode 100644
> index 000000000000..1ef1b0c2ee6e
> --- /dev/null
> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c
> @@ -0,0 +1,105 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Time Sensitive Networking (TSN) Ethernet MAC wrapper driver.
> + *
> + * Copyright (C) 2026 Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/of_platform.h>
> +#include <linux/platform_device.h>
> +#include <linux/slab.h>
> +#include <linux/types.h>

Please drop <linux/mod_devicetable.h>. This header is planned to go away
soon and you can rely on <linux/platform_device.h> to provide
of_device_id.

> [...]
> +static struct platform_driver * const tsn_drivers[] = {
> +	&tsn_driver,
> +};
> +
> +static int __init xlnx_tsn_init(void)
> +{
> +	return platform_register_drivers(tsn_drivers, ARRAY_SIZE(tsn_drivers));
> +}
> +module_init(xlnx_tsn_init);
> +
> +static void __exit xlnx_tsn_exit(void)
> +{
> +	platform_unregister_drivers(tsn_drivers, ARRAY_SIZE(tsn_drivers));
> +}
> +module_exit(xlnx_tsn_exit);

I assume you expect tsn_drivers[] to grow? If not, use
module_platform_driver() to reduce boilerplate.

--yneap3wk5hqcchh7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmp2RusACgkQj4D7WH0S
/k5magf9GDZifuMmMgVgWbOijgerh1NAUQiervav2kcbQ650bgaya6orUyAqUnnd
eGe7DyhyOOdkl3qnsTwH9/e4Xn739LEnnjAwWIBrFn56ErYRhl/Dd+vuD/9U0LPd
bGwI5ss9L6itgtlzGpZRsi4KhSiWG0asI7Ll3WFkUrhOdMd5a2+L22Vd47E3gXAo
lVQ7ntvXRliL54xVe1tVbSbz/JrN89nHRR7sI/FWjUEknfpTbVVldBt95gevSOc9
pVoI5wtCOSAMPQTzSAHFoj1qZcrOofeK49hvnUiasTy8OWa5oJiuCzHknYyPXcOS
JWFSEfqueZ+Xqyq+Y71krOsj8b+cYw==
=pHZr
-----END PGP SIGNATURE-----

--yneap3wk5hqcchh7--
