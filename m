Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABC64446E8
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 21:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786136414; cv=none; b=E8RS350EZ4LgT+2/AN3rLutb2to5W+IqMB+z+qsoa24Zn3ICXZrKLDuBWtZPPE20Ysm13B2bC/OsDYQnC1JHRQTbDGoCCH90xRsb1yWeM4kgeiEtdUk8suw0dxBpwvFD1+5shxwbWGZxji5B24DNpLzox0YWrLj0qgkvAQskp2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786136414; c=relaxed/simple;
	bh=9kRu9s6sylkq4R57DiZLd0w8rMbxTFR+JqfzBmRWz1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qUCyaKLLHipOgffRRlLNSw4iE09yTJ3hCzka+Ola30xqJU3mjev1cS050hh+SQGMvPox4fqT2cQcIh/scpUaob15FfvDL+QCvMCCgeHJlRRpBy2MvVUI6OT7sQSrbkMrf3e9uQTwnnXc8dMYtXPNl/uKjVylPQLbcuzzOakbTGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=TvEej7As; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="TvEej7As"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47f703a9d05so2498054f8f.0
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 14:00:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1786136409; x=1786741209; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=n2jSfoVmmGxnKuCYX8tAJQ7xubX2vrZV9GTQr1E87rk=;
        b=TvEej7AsybxgM22dCCDyIX7OteOz06DymOsvyfRgIj+GS04SqxLy4PctB4r7tzVnbZ
         OLJRuPOqEnXZ7maiaPOSSiPEJ5xyoAcVxxuiyWsusvwS80Q1MqoIX/YJ+Z8wxR3LSGMO
         cVS/0REVj4o0BIYUemwLRsI1SaXJLlMFLMzWX/02MHVYYS4YhgD+5tab5bihQA3Gx6Lj
         mMRTDWVQkbbppLQ7jOkXKtMKUakSxCVLLBlz/Iwz1NDPHWZseBhtiMmLJg7kTEjg/5JG
         h1zbxcX/4UXhhMV2PpTvgn6I9nSk7cWoqFsj7kjTG22EWn9D71G1o1KT46kZSkfpRXv+
         PorQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786136409; x=1786741209;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=n2jSfoVmmGxnKuCYX8tAJQ7xubX2vrZV9GTQr1E87rk=;
        b=RrRrnKpXH8EM8IPiRh8v/8chaXcu1DHRuUX/TCw+Nr3FG42C527k/DVUFg2p2ji94u
         IPkhQjjgLWGVKGsAuksbxxBwKPkcusR2NuU1b3LPLuCtYJ9OpbHwGrfm/Rhrm20uP9nd
         sq/K6mivS2ktj8sOUbUYtK9kw9KDoXVSz8M0/4ADDGB4wF6A1PuOee5gCtBYvbSi3flS
         iYBgf8dE6mx+H/OOng7KhPDttmoCM8RBYvFb+Au1G7LYQckJz0wtPNNHeqFTnMb1HBrR
         Jm7kuL7/aIJ5SXpQDI3P8sU0a4wME4wjx4LC4uNo1WmunERDQ9aetkCxGk/MrBNMAGjE
         KmyA==
X-Forwarded-Encrypted: i=1; AHgh+RrblrxgoZQyeyQqKK0Iljw7Ol9DljTEIc89sY3zMgN7Q1HwzEZNYqyuUHrOTfauC9P+07bFPeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMZnLSdydSWAkn03CFr29iMXd2+rz1KAnbuygQcC1BEwwjLTJX
	cZySh3jXq/Pui9dla5jButovECV5780CgD3/g5XQreEbHRqSgG01Ay0pxJyf4HUHrOo=
X-Gm-Gg: AR+sD11TkTxTZajBUmR2HhjfseQeWnFIuwVQVK/oStMO71m9SeHmOV3jVnRxag4C6ba
	+FXM7pfQ5fSZODYmI2khYofXrtx4VzgzxO8Mn9QcJ66zN0OqN4gEDrxTnlFXbbQmCgP1xzXPEG0
	nwKo5PSZ1vG3V/a4/NyB8mpx+W2Uu7BnRROHbF+PinWIUZGYpr2AVhJYHuwbWm3lRIVL3xbV4o0
	UM6lwdja5b7VphOW9nZ8rwyu/i1TpQ1qm3ABGv5PG2Wb0F1QkVyHXo/ejPj0hDlqSg+Uibg8p9d
	byqQDMeuQj/KrM/+1Ap8fco8UyrtNTcGFhWtfYvOjm+tNJvfPUBdrAEjEUFDyD6zfd62L1bZbpH
	kyWedRyoyhKVENRPuEdjz41jUQRjroq+NZEySLXy9c5IA6euUaU3J4DQncZy6U0caK1f7GjTlpq
	b8RlTHwnTnkAA6psBIFiRZ12CYMByU91dgF8bNfbIS0UGe8lGKGDMCOZLe/IiFaAqsM+Emnj/Vx
	Lt9+Q==
X-Received: by 2002:a05:6000:388:b0:474:d7a5:4b7a with SMTP id ffacd0b85a97d-480026ee69emr10610830f8f.28.1786136409374;
        Fri, 07 Aug 2026 14:00:09 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-480021509a5sm8514666f8f.16.2026.08.07.14.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 14:00:08 -0700 (PDT)
Date: Fri, 7 Aug 2026 23:00:07 +0200
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
Subject: Re: [PATCH 03/20] net: xilinx: tsn: add endpoint MAC driver skeleton
Message-ID: <anZG-AucFEZrwjjO@monoceros>
References: <20260807104431.157230-1-nagadheeraj.rottela@amd.com>
 <20260807104431.157230-4-nagadheeraj.rottela@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="s3a2p35cknyjhbm7"
Content-Disposition: inline
In-Reply-To: <20260807104431.157230-4-nagadheeraj.rottela@amd.com>


--s3a2p35cknyjhbm7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 03/20] net: xilinx: tsn: add endpoint MAC driver skeleton
MIME-Version: 1.0

On Fri, Aug 07, 2026 at 04:14:14PM +0530, Nagadheeraj Rottela wrote:
> From: Srinivas Neeli <srinivas.neeli@amd.com>
>=20
> The TSN Endpoint MAC owns the IP's host-side MCDMA data path and is the
> netdev physically wired to the CPU. The DSA switch needs this netdev to
> exist as its conduit.
>=20
> Add a platform driver (compatible "xlnx,tsn-ep-mac") for the endpoint.
> Register the netdev named "ep", set its MAC address, and provide minimal
> netdev and ethtool ops. This skeleton handles device bring-up only, with
> no data path yet. So ndo_open just starts the queues and ndo_start_xmit
> drops frames.
>=20
> Signed-off-by: Srinivas Neeli <srinivas.neeli@amd.com>
> Co-developed-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
> Signed-off-by: Nagadheeraj Rottela <nagadheeraj.rottela@amd.com>
> ---
>  drivers/net/ethernet/xilinx/tsn/Makefile      |   2 +-
>  drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h  |  15 ++
>  .../net/ethernet/xilinx/tsn/xilinx_tsn_ep.c   | 152 ++++++++++++++++++
>  .../net/ethernet/xilinx/tsn/xilinx_tsn_main.c |   3 +
>  4 files changed, 171 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h
>  create mode 100644 drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
>=20
> diff --git a/drivers/net/ethernet/xilinx/tsn/Makefile b/drivers/net/ether=
net/xilinx/tsn/Makefile
> index 6f99226f3dc8..5886828b386f 100644
> --- a/drivers/net/ethernet/xilinx/tsn/Makefile
> +++ b/drivers/net/ethernet/xilinx/tsn/Makefile
> @@ -1,2 +1,2 @@
>  obj-$(CONFIG_XILINX_TSN) +=3D xilinx_tsn.o
> -xilinx_tsn-y :=3D xilinx_tsn_main.o
> +xilinx_tsn-y :=3D xilinx_tsn_main.o xilinx_tsn_ep.o
> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h b/drivers/net/e=
thernet/xilinx/tsn/xilinx_tsn.h
> new file mode 100644
> index 000000000000..b0757e22d1fd
> --- /dev/null
> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * AMD/Xilinx TSN Endpoint Ethernet MAC driver, shared definitions.
> + *
> + * Copyright (C) 2026 Advanced Micro Devices, Inc.
> + */
> +
> +#ifndef _XILINX_TSN_H
> +#define _XILINX_TSN_H
> +
> +#include <linux/platform_device.h>
> +
> +extern struct platform_driver xlnx_tsn_ep_driver;
> +
> +#endif /* _XILINX_TSN_H */
> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c b/drivers/ne=
t/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> new file mode 100644
> index 000000000000..9b556edf5423
> --- /dev/null
> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_ep.c
> @@ -0,0 +1,152 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AMD/Xilinx TSN Endpoint MAC driver.
> + *
> + * Copyright (C) 2026 Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/etherdevice.h>
> +#include <linux/ethtool.h>
> +#include <linux/if_ether.h>
> +#include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/netdevice.h>
> +#include <linux/of.h>
> +#include <linux/of_net.h>
> +#include <linux/platform_device.h>
> +#include <linux/string.h>
> +#include <linux/types.h>

As for patch #2: Please drop <linux/mod_devicetable.h>.

Best regards
Uwe

--s3a2p35cknyjhbm7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmp2R1MACgkQj4D7WH0S
/k5O/Af/TgMIOtaQklVLmWBMkmBIzcsGU429YEzvVu05CyiD5QqR8zjbZJwQxKmw
SkyMCDxo8Lq8CrA6KdsXb8wFOgqxMS/L1M4pvvsMdK32qvm80JzIg6E7SGtf+tOE
WkMebpH8sCnZ+fawjduQcfq3KJP3vF8QS/GFeUxDtPrvAwt29padXs7p9fKdRVKd
OwKoX7evpfoIVchzwiduw8NKgwyL3PxM4rofCXNYn2bEN6wgBp3BlBguCrkthyey
OK7y/Un+T0wIHPiT7jyJgMobOIlJPqhbvLIdL0QWN2jg+fpzjaGGAMeH/yIkSUWw
G9Yviixwsqv9xIP/h8edIDavoQLkPw==
=9zsc
-----END PGP SIGNATURE-----

--s3a2p35cknyjhbm7--
