Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BE733C9EE5
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 13:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784812095; cv=none; b=Dw1VL41HmtAjcnx4lOQICT1/odtvW2BBGkcmJr4T3leCs7OtJdyAanjqUdNxwWV19cyjDVpXJjIBg3wtJ77TFWed3OsbXtbv4iQWy628r0tG1m4sWJTXutl3Nlntt9rdJgipNjHLXK/LRHtJfBlytAa/X4PSEc9MR4DIsKADr2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784812095; c=relaxed/simple;
	bh=usc0iLQZIAxUtbpo0UUexXNi+H/LP/5+tfAGpxqIDLo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QseAGdomLaL4l7KI06eZHrDJ8fp6ot9wV8HdIL0ydVAwcGEhiWcMUnL88u0OCJCghWAXFmF22LqLhQBxT5dwSxGlOoh4/qB+QQ+fhTe6jXfpM3z9MkwfzbEQDprWjwsrsEonaNWA2xWKGNa+fpFr2FRs5VJi2iK6Hv4CzEp/RFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gJGYMGuF; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FX23fYHU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gJGYMGuF";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FX23fYHU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784812092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z8tfBjliZcRP+YVIKBiEexjxC3PGiQqhQXDQZvnOmN0=;
	b=gJGYMGuFBr/usJ6gEDybw2lo/vtVwrQqwwXp0qemlU3Honvy2d5XOMcEMVB3wJIj0gropf
	5naO3L+w1vDoxpZ3qsgTeKAjLWrkfIF2rjQETuVsBWpi8KmMNHfDt2GP/1OFWIoOdlquYh
	p/VxJ4ZTF6JtSlG7hc0xibwfioZQPHo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-tOOkibAvPfWeIA5op9qatw-1; Thu, 23 Jul 2026 09:08:10 -0400
X-MC-Unique: tOOkibAvPfWeIA5op9qatw-1
X-Mimecast-MFC-AGG-ID: tOOkibAvPfWeIA5op9qatw_1784812090
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c15deb3377eso57302366b.3
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 06:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784812090; x=1785416890; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=z8tfBjliZcRP+YVIKBiEexjxC3PGiQqhQXDQZvnOmN0=;
        b=FX23fYHU6zBG+sbJAHS7BUM5LywcoupNUy2nU6HpXujE+BCkQzhnHYEWGL6cP7j1Br
         uxpaKAZfv+moxOOEcY/6JRhMBm4Q1G9dP8PWSYa2zdzeBbzV/KSE15Pc9GxkKThDyRB1
         FnmOPvaQ2KeC7725Cg5dECFPDycmU39q3SRT2sutC7Vvcvw1AZJtQRN2rd4bn0kBRM7W
         sUovcsWJqKzKJ2HsBc8ewA6kjuLUTClj5HgXZ6ROkGvxLowVUCZ7R91b5tAaXssRly52
         oeb2WQQr03jsVO5Y5DZ+0GT7QJGdjYdDxfW3kH5aklkRcwhKcr4/FamZn9XOSKYyesRz
         V91w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784812090; x=1785416890;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z8tfBjliZcRP+YVIKBiEexjxC3PGiQqhQXDQZvnOmN0=;
        b=JvhkmFkvP4CvMkDX4YpjDE7tnJfoVSOLiv4TyQDx2T4Ulj88d8KX10Z+2vjVWi2asw
         Jsmi+WRsO8KMgoBcvINfiA7UeWvvx2fwZZvueXKhtJwqOC/DgQuY0ChxJ2pOCBjjIqWA
         EyFSSBTRGd9JWCTf6h244BIOSNQDK3SoohxAYjIRH2pvnHljpCAxu+iWbmrRZ1tPouxg
         bBcoPPL+PE68TTTOLKQloNXE0bPs7dimbSqVoAHFS+IdkL2WkdI6rWtrRHmhEkSzve/q
         d2FsYUcuxRFIJH5laGOrqn/ysx+YQVpU1F0a5722Z4N12H2Z9AJ/adm7QQd+KQs+NbLK
         PnTA==
X-Forwarded-Encrypted: i=1; AHgh+RonkE3hQsiU9Q2BMtDxyWep36qV6BGeUol/GoxTIUrEpaoecm21nKd+kOq8N2da/b8nuaHPIGk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw6RrWVK7JbAYR0ni7tYLWebVD0pWltsDFr1PyPyHl4xzuzc9Iv
	O5i3Qn1dNEC08M6zhvY+FKwfVjCN0im74gYE9SjSBkiBQ4LsHRQKyf7fffINHipNvaBxQlSLo5e
	RoSHeMMzvy4ztOPu9QEgvF2AERSdeLsp5CbYUnt13+NuuKRDTMEmISyovgg==
X-Gm-Gg: AR+sD13Xkx2X4H5U18hyR/AhkFhm430NXILoCbPrO5wOEShV+GGMk6G7ZFeCoLzs8B5
	kVvRpNRyPBx31pZxZGXD45TVHwzqIJK7I0a0aorfOpoWVbmJ7ELctSO+Ms+mq1yrNM7TkDGfBBS
	uYertgeLnQSfxEycLpYylvzz5wVADhGrtUuf75V5uFnrZaaor793MJJJbB8Np6le1qhMxJUJPrm
	Ph38cj42SUwXetNIC/8PXjMgHGwq0+ctJ5mMiPRm5TQGSZKSopbiLGrjsNFfcn9j1NxifrCOuf1
	G1dVLeBZw8+nSkC4/CpQkrfDdWIitJuFI4weKs+s8Htj8AudiTx5oneXbNsE8YgcQt7FMITMbGn
	fJAzFUodl+KWNWL3wzYpTdXVwX5oMku/eDKyj/2MgNSqFNGafPyBYaXk6FvbcTCtz/6bRUkZjCa
	pLzQ==
X-Received: by 2002:a17:907:6088:b0:c16:1655:309d with SMTP id a640c23a62f3a-c1c50d82182mr130120866b.56.1784812089488;
        Thu, 23 Jul 2026 06:08:09 -0700 (PDT)
X-Received: by 2002:a17:907:6088:b0:c16:1655:309d with SMTP id a640c23a62f3a-c1c50d82182mr130117066b.56.1784812088622;
        Thu, 23 Jul 2026 06:08:08 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:5521:6b10:58fd:68f:7756:389d? ([2a0d:3344:5521:6b10:58fd:68f:7756:389d])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c1c32c90b42sm233079766b.38.2026.07.23.06.08.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jul 2026 06:08:07 -0700 (PDT)
Message-ID: <430ff31a-4199-402f-b234-167f71d87fa6@redhat.com>
Date: Thu, 23 Jul 2026 15:08:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 4/9] net: dsa: lan9645x: add basic dsa driver
 for LAN9645X
To: =?UTF-8?Q?Jens_Emil_Schulz_=C3=98stergaard?=
 <jensemil.schulzostergaard@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Woojung Huh <woojung.huh@microchip.com>,
 Russell King <linux@armlinux.org.uk>,
 Steen Hegelund <Steen.Hegelund@microchip.com>,
 Daniel Machon <daniel.machon@microchip.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20260713-dsa_lan9645x_switch_driver_base-v10-0-a4886a08fb15@microchip.com>
 <20260713-dsa_lan9645x_switch_driver_base-v10-4-a4886a08fb15@microchip.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260713-dsa_lan9645x_switch_driver_base-v10-4-a4886a08fb15@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 7/13/26 4:32 PM, Jens Emil Schulz Østergaard wrote:
> Add the LAN9645X basic DSA driver with initialization, parent regmap
> requests, port module initialization for NPI, CPU ports and front ports,
> and phylink integration for MAC side configuration.
> 
> This patch only wires up the internal CuPHYs (ports 0-4) and the RGMII
> paths for ports 7 and 8. The supported SerDes-based modes: SGMII,
> QSGMII, 1000BASE-X and 2500BASE-X on ports 5-8 are deferred, and support
> will be added in follow-up patches. Port 5-6 have no usable interface
> mode in this patch, and should not be declared in DT until SerDes
> support lands.
> 
> The intended way to bind this driver is using a parent MFD driver,
> responsible for the register IO protocol, and distributing regmaps to
> child devices. The goal is to use the same approach as the MFD driver in
> drivers/mfd/ocelot-spi.c.
> 
> This driver expects to request named regmaps from a parent device. This
> approach is similar to the DSA driver
> 
> drivers/net/dsa/ocelot/ocelot_ext.c
> 
> which supports being driven by an external CPU via SPI with parent
> device drivers/mfd/ocelot-spi.c.
> 
> The MFD driver will come in a later series, because there are
> requirements on the number of child devices before a driver qualifies as
> a MFD device.
> 
> Reviewed-by: Steen Hegelund <Steen.Hegelund@microchip.com>
> Signed-off-by: Jens Emil Schulz Østergaard <jensemil.schulzostergaard@microchip.com>
> ---
> Changes in v9:
> - Drop the DEV4 RGMII muxing support.
> 
> Changes in v8:
> - Remove the CPU_PORT macro, which named the chips internal CPU port
>   module and collided with the DSA CPU port terminology. Reference the
>   module as lan9645x->num_phys_ports.
> - Rework the port map comment to distinguish the chip CPU port modules
>   (indices 9-10) from the DSA CPU port (the NPI front port).
> - Derive PGID_GP_START from NUM_PHYS_PORTS instead of CPU_PORT.
> - Add a port_mux_lock mutex to serialize port mux arbitration in
>   lan9645x_phylink_mac_prepare().
> 
> Changes in v7:
> - use cpu queue LAN9645X_CPUQ_TRAP for bpdu frames
> 
> Changes in v5:
> - remove dd_dis and tsn_dis, and add SKU supported port validation
>   during setup
> - phylink: remove MAC_2500FD
> - phylink: add comment about empty supported_interfaces for port 5-6.
> - phylink: fix 2:1 rgmii port muxing for port module 4 and 7 to be fully
>   dynamic and validate requested mux settings.
> - phylink: add comment about 2:1 rgmii port muxing for port module 4
>   and 7.
> - rx/tx-internal-delay-ps checked against support 2ns value
> - update commit message
> - init lan9645x->npi = -1 at probe and check port < 0 in npi_deinit
> 
> Changes in v4:
> - add comment to QSYS_RES_CFG configuration
> - phylink_mac_prepare: fix to make sure we can dynamically change rgmii
>   on port 4
> - move ports allocation to probe
> - tag_npi_setup: reject cascaded setups
> - skip WARN_ON in lan9645x_to_port
> 
> Changes in v3:
> - move DEV_MAC_TAGS_CFG config to port setup, for vlan overhead in port
>   frame maxlen
> - remove code disabling ipv6 on conduit
> - use of_property_read_u32 for {rx,tx}-internal-delay-ps
> - use dsa_user_ports(ds) instead of
>   GENMASK(lan9645x->num_phys_ports - 1, 0) as base flood mask.
> - update obey vlan comment
> 
> Changes in v2:
> - source Kconfig from drivers/net/dsa/Kconfig
> - sorting in Kconfig and Makefiles
> - remove unused struct fields
> - remote path delays
> - use port_setup and dp->dn instead of DTS parsing
> - phylink: split rgmii setup into dll and speed config
> - phylink: remove pcs/sgmii/qsgmii related code
> - phylink: simplify mac_prepare
> - phylink: remove phylink_ops wrappers
> - phylink: remove unrelated config from link up
> - phylink: reorder functions according to phylink call order
> ---
>  drivers/net/dsa/Kconfig                            |   2 +
>  drivers/net/dsa/microchip/Makefile                 |   1 +
>  drivers/net/dsa/microchip/lan9645x/Kconfig         |  11 +
>  drivers/net/dsa/microchip/lan9645x/Makefile        |   8 +
>  drivers/net/dsa/microchip/lan9645x/lan9645x_main.c | 447 +++++++++++++++++++++
>  drivers/net/dsa/microchip/lan9645x/lan9645x_main.h | 332 +++++++++++++++
>  drivers/net/dsa/microchip/lan9645x/lan9645x_npi.c  |  85 ++++
>  .../net/dsa/microchip/lan9645x/lan9645x_phylink.c  | 382 ++++++++++++++++++
>  drivers/net/dsa/microchip/lan9645x/lan9645x_port.c | 214 ++++++++++
>  9 files changed, 1482 insertions(+)
> 
> diff --git a/drivers/net/dsa/Kconfig b/drivers/net/dsa/Kconfig
> index 4ab567c5bbaf..91431ef6c425 100644
> --- a/drivers/net/dsa/Kconfig
> +++ b/drivers/net/dsa/Kconfig
> @@ -72,6 +72,8 @@ config NET_DSA_MV88E6060
>  
>  source "drivers/net/dsa/microchip/Kconfig"
>  
> +source "drivers/net/dsa/microchip/lan9645x/Kconfig"
> +
>  source "drivers/net/dsa/mv88e6xxx/Kconfig"
>  
>  source "drivers/net/dsa/mxl862xx/Kconfig"
> diff --git a/drivers/net/dsa/microchip/Makefile b/drivers/net/dsa/microchip/Makefile
> index 9347cfb3d0b5..e75f17888f75 100644
> --- a/drivers/net/dsa/microchip/Makefile
> +++ b/drivers/net/dsa/microchip/Makefile
> @@ -12,3 +12,4 @@ endif
>  obj-$(CONFIG_NET_DSA_MICROCHIP_KSZ9477_I2C)	+= ksz9477_i2c.o
>  obj-$(CONFIG_NET_DSA_MICROCHIP_KSZ_SPI)		+= ksz_spi.o
>  obj-$(CONFIG_NET_DSA_MICROCHIP_KSZ8863_SMI)	+= ksz8863_smi.o
> +obj-$(CONFIG_NET_DSA_MICROCHIP_LAN9645X)	+= lan9645x/
> diff --git a/drivers/net/dsa/microchip/lan9645x/Kconfig b/drivers/net/dsa/microchip/lan9645x/Kconfig
> new file mode 100644
> index 000000000000..4d9fdf34104e
> --- /dev/null
> +++ b/drivers/net/dsa/microchip/lan9645x/Kconfig
> @@ -0,0 +1,11 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config NET_DSA_MICROCHIP_LAN9645X
> +	tristate "Microchip Lan9645x switch support"
> +	depends on NET_DSA
> +	select NET_DSA_TAG_LAN9645X
> +	help
> +	  This driver adds DSA support for Microchip Lan9645x switch chips.
> +	  The lan9645x switch is a multi-port Gigabit AVB/TSN Ethernet Switch
> +	  with five integrated 10/100/1000Base-T PHYs. In addition to the
> +	  integrated PHYs, it supports up to 2 RGMII/RMII, up to 2
> +	  BASE-X/SERDES/2.5GBASE-X and one Quad-SGMII/Quad-USGMII interfaces.
> diff --git a/drivers/net/dsa/microchip/lan9645x/Makefile b/drivers/net/dsa/microchip/lan9645x/Makefile
> new file mode 100644
> index 000000000000..7cc0ae0ada40
> --- /dev/null
> +++ b/drivers/net/dsa/microchip/lan9645x/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +obj-$(CONFIG_NET_DSA_MICROCHIP_LAN9645X) += mchp-lan9645x.o
> +
> +mchp-lan9645x-objs := \
> +	lan9645x_main.o \
> +	lan9645x_npi.o \
> +	lan9645x_phylink.o \
> +	lan9645x_port.o \
> diff --git a/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> new file mode 100644
> index 000000000000..b253813518c2
> --- /dev/null
> +++ b/drivers/net/dsa/microchip/lan9645x/lan9645x_main.c
> @@ -0,0 +1,447 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/* Copyright (C) 2026 Microchip Technology Inc.
> + */
> +
> +#include <linux/platform_device.h>
> +
> +#include "lan9645x_main.h"
> +
> +static const char *lan9645x_resource_names[NUM_TARGETS + 1] = {
> +	[TARGET_GCB]          = "gcb",
> +	[TARGET_QS]           = "qs",
> +	[TARGET_CHIP_TOP]     = "chip_top",
> +	[TARGET_REW]          = "rew",
> +	[TARGET_SYS]          = "sys",
> +	[TARGET_HSIO]         = "hsio",
> +	[TARGET_DEV]          = "dev",
> +	[TARGET_DEV + 1]      = "dev1",
> +	[TARGET_DEV + 2]      = "dev2",
> +	[TARGET_DEV + 3]      = "dev3",
> +	[TARGET_DEV + 4]      = "dev4",
> +	[TARGET_DEV + 5]      = "dev5",
> +	[TARGET_DEV + 6]      = "dev6",
> +	[TARGET_DEV + 7]      = "dev7",
> +	[TARGET_DEV + 8]      = "dev8",
> +	[TARGET_QSYS]         = "qsys",
> +	[TARGET_AFI]          = "afi",
> +	[TARGET_ANA]          = "ana",
> +	[NUM_TARGETS]         = NULL,
> +};
> +
> +static int lan9645x_tag_npi_setup(struct dsa_switch *ds)
> +{
> +	struct dsa_port *dp, *first_cpu_dp = NULL;
> +	struct lan9645x *lan9645x = ds->priv;
> +
> +	dsa_switch_for_each_user_port(dp, ds) {
> +		if (dp->cpu_dp->ds != ds) {
> +			dev_err(ds->dev,
> +				"NPI port on a remote switch is not supported\n");
> +			return -EINVAL;
> +		}
> +
> +		if (first_cpu_dp && dp->cpu_dp != first_cpu_dp) {
> +			dev_err(ds->dev, "Multiple NPI ports not supported\n");
> +			return -EINVAL;
> +		}
> +
> +		first_cpu_dp = dp->cpu_dp;
> +	}
> +
> +	if (!first_cpu_dp)
> +		return -EINVAL;
> +
> +	lan9645x_npi_port_init(lan9645x, first_cpu_dp);
> +
> +	return 0;
> +}
> +
> +static enum dsa_tag_protocol lan9645x_get_tag_protocol(struct dsa_switch *ds,
> +						       int port,
> +						       enum dsa_tag_protocol tp)
> +{
> +	return DSA_TAG_PROTO_LAN9645X;
> +}
> +
> +static void lan9645x_teardown(struct dsa_switch *ds)
> +{
> +	struct lan9645x *lan9645x = ds->priv;
> +
> +	lan9645x_npi_port_deinit(lan9645x, lan9645x->npi);
> +}
> +
> +static int lan9645x_change_mtu(struct dsa_switch *ds, int port, int new_mtu)
> +{
> +	return lan9645x_port_set_maxlen(ds->priv, port, new_mtu);
> +}
> +
> +static int lan9645x_get_max_mtu(struct dsa_switch *ds, int port)
> +{
> +	struct lan9645x *lan9645x = ds->priv;
> +	int max_mtu;
> +
> +	/* Actual MAC max MTU is around 16KB. We set 10000 - overhead which
> +	 * should be sufficient for all jumbo frames. Larger frames can cause
> +	 * problems especially with flow control, since we only have 160K queue
> +	 * buffer.
> +	 */
> +	max_mtu = 10000 - ETH_HLEN - ETH_FCS_LEN;
> +
> +	if (port == lan9645x->npi) {
> +		max_mtu -= LAN9645X_IFH_LEN;
> +		max_mtu -= LAN9645X_LONG_PREFIX_LEN;
> +	}
> +
> +	return max_mtu;
> +}
> +
> +static int lan9645x_reset_switch(struct lan9645x *lan9645x)
> +{
> +	int val = 0;
> +	int err;
> +
> +	lan_wr(SYS_RESET_CFG_CORE_ENA_SET(0), lan9645x, SYS_RESET_CFG);
> +	lan_wr(SYS_RAM_INIT_RAM_INIT_SET(1), lan9645x, SYS_RAM_INIT);
> +	err = lan9645x_rd_poll_timeout(lan9645x, SYS_RAM_INIT, val,
> +				       SYS_RAM_INIT_RAM_INIT_GET(val) == 0);
> +	if (err) {
> +		dev_err(lan9645x->dev, "Failed to init chip RAM.\n");
> +		return err;
> +	}
> +	lan_wr(SYS_RESET_CFG_CORE_ENA_SET(1), lan9645x, SYS_RESET_CFG);
> +
> +	return 0;
> +}
> +
> +static int lan9645x_setup(struct dsa_switch *ds)
> +{
> +	struct lan9645x *lan9645x = ds->priv;
> +	struct device *dev = lan9645x->dev;
> +	int supported, used = 0;
> +	struct dsa_port *dp;
> +	u32 front_ports;
> +	int err;
> +
> +	lan9645x->num_phys_ports = ds->num_ports;
> +	front_ports = dsa_user_ports(ds);
> +	supported = lan9645x->num_phys_ports - lan9645x->num_port_dis;
> +
> +	dsa_switch_for_each_available_port(dp, ds)
> +		used++;
> +
> +	if (used > supported) {
> +		dev_err(ds->dev,
> +			"%d physical ports in use in DT, SKU supports at most %d\n",
> +			used, supported);
> +		return -EINVAL;
> +	}
> +
> +	err = lan9645x_reset_switch(lan9645x);
> +	if (err)
> +		return err;
> +
> +	err = lan9645x_tag_npi_setup(ds);
> +	if (err) {
> +		dev_err(dev, "Failed to setup NPI port.\n");
> +		return err;
> +	}
> +
> +	/* Link Aggregation Mode: NETDEV_LAG_HASH_L2 */
> +	lan_wr(ANA_AGGR_CFG_AC_SMAC_ENA |
> +	       ANA_AGGR_CFG_AC_DMAC_ENA,
> +	       lan9645x, ANA_AGGR_CFG);
> +
> +	/* Flush queues */
> +	lan_wr(GENMASK(1, 0), lan9645x, QS_XTR_FLUSH);
> +
> +	/* Allow to drain */
> +	usleep_range(1000, 2000);
> +
> +	/* All Queues normal */
> +	lan_wr(0x0, lan9645x, QS_XTR_FLUSH);
> +
> +	/* Set MAC age time to default value, the entry is aged after
> +	 * 2 * AGE_PERIOD
> +	 */
> +	lan_wr(ANA_AUTOAGE_AGE_PERIOD_SET(BR_DEFAULT_AGEING_TIME / 2 / HZ),
> +	       lan9645x, ANA_AUTOAGE);
> +
> +	/* Disable learning for frames discarded by VLAN ingress filtering */
> +	lan_rmw(ANA_ADVLEARN_VLAN_CHK_SET(1),
> +		ANA_ADVLEARN_VLAN_CHK,
> +		lan9645x, ANA_ADVLEARN);
> +
> +	/* Queue system frame ageing. We target 2s ageing.
> +	 *
> +	 * Register unit is 1024 cycles.
> +	 *
> +	 * ASIC: 165.625 Mhz  ~ 6.0377 ns period
> +	 *
> +	 * 1024 * 6.0377 ns =~ 6182 ns
> +	 * val = 2000000000ns / 6182ns
> +	 */
> +	lan_wr(SYS_FRM_AGING_AGE_TX_ENA_SET(1) |
> +	       SYS_FRM_AGING_MAX_AGE_SET((2000000000 / 6182)),
> +	       lan9645x,  SYS_FRM_AGING);
> +
> +	/* Setup flooding PGIDs for IPv4/IPv6 multicast. Control and dataplane
> +	 * use the same masks. Control frames are redirected to CPU, and
> +	 * the network stack is responsible for forwarding these.
> +	 * The dataplane is forwarding according to the offloaded MDB entries.
> +	 */
> +	lan_wr(ANA_FLOODING_IPMC_FLD_MC4_DATA_SET(PGID_MCIPV4) |
> +	       ANA_FLOODING_IPMC_FLD_MC4_CTRL_SET(PGID_MC) |
> +	       ANA_FLOODING_IPMC_FLD_MC6_DATA_SET(PGID_MCIPV6) |
> +	       ANA_FLOODING_IPMC_FLD_MC6_CTRL_SET(PGID_MC),
> +	       lan9645x, ANA_FLOODING_IPMC);
> +
> +	/* There are 8 priorities */
> +	for (int prio = 0; prio < 8; ++prio)
> +		lan_wr(ANA_FLOODING_FLD_MULTICAST_SET(PGID_MC) |
> +		       ANA_FLOODING_FLD_UNICAST_SET(PGID_UC) |
> +		       ANA_FLOODING_FLD_BROADCAST_SET(PGID_BC),
> +		       lan9645x, ANA_FLOODING(prio));
> +
> +	/* Allow VLAN table to control whether cpu copy from the pgid table is
> +	 * enabled. Index PGID_ENTRIES is CPU src pgid, so we skip it as the
> +	 * configuration makes little sense here.
> +	 */
> +	for (int i = 0; i < PGID_ENTRIES; ++i)
> +		lan_wr(ANA_PGID_CFG_OBEY_VLAN_SET(1),
> +		       lan9645x, ANA_PGID_CFG(i));
> +
> +	/* Disable bridging by default */
> +	for (int p = 0; p < lan9645x->num_phys_ports; p++) {
> +		lan_wr(0, lan9645x, ANA_PGID(PGID_SRC + p));
> +
> +		/* Do not forward BPDU frames to the front ports and copy them
> +		 * to CPU
> +		 */
> +		lan_wr(ANA_CPU_FWD_BPDU_CFG_BPDU_REDIR_ENA,
> +		       lan9645x, ANA_CPU_FWD_BPDU_CFG(p));
> +	}
> +
> +	for (int i = 0; i < 16; i++) {
> +		/* The register instance number corresponds to the
> +		 * address of the extracted frame. For instance:
> +		 * CPUQ_8021_CFG[4].CPUQ_BPDU_VAL
> +		 * is the cpu extraction queue used for BPDU frames
> +		 * with address 01-80-C2-00-00-04
> +		 */
> +		lan_rmw(ANA_CPUQ_8021_CFG_CPUQ_BPDU_VAL_SET(LAN9645X_CPUQ_TRAP),
> +			ANA_CPUQ_8021_CFG_CPUQ_BPDU_VAL,
> +			lan9645x, ANA_CPUQ_8021_CFG(i));
> +	}
> +
> +	/* Reserve ~1700 bytes of buffer memory per (port, prio) for source
> +	 * tracking (resource 0, indices 0..95) and destination tracking
> +	 * (resource 2, indices 512..607). These are access watermarks, not
> +	 * pre-allocations: a flow draws from its reservation first, then
> +	 * from the shared pool. Keeping the reservation above a max-size
> +	 * Ethernet frame prevents a single frame from spilling into the
> +	 * shared pool, and cause pause frames to be emitted without actual
> +	 * congestion.
> +	 */
> +	for (int i = 0; i <= QSYS_Q_RSRV; ++i) {
> +		lan_wr(QS_SRC_BUF_RSV / 64, lan9645x, QSYS_RES_CFG(i));
> +		lan_wr(QS_SRC_BUF_RSV / 64, lan9645x, QSYS_RES_CFG(512 + i));
> +	}
> +
> +	lan9645x_port_cpu_init(lan9645x);
> +
> +	/* Multicast to all front ports */
> +	lan_wr(front_ports, lan9645x, ANA_PGID(PGID_MC));
> +
> +	/* IP multicast to all front ports */
> +	lan_wr(front_ports, lan9645x, ANA_PGID(PGID_MCIPV4));
> +	lan_wr(front_ports, lan9645x, ANA_PGID(PGID_MCIPV6));
> +
> +	/* Unicast to all front ports */
> +	lan_wr(front_ports, lan9645x, ANA_PGID(PGID_UC));

Sashiko noted that the port mask here should likely include the CPU
port, to allow correct handling of unknown unicast.

https://sashiko.dev/#/patchset/20260713-dsa_lan9645x_switch_driver_base-v10-0-a4886a08fb15%40microchip.com

For the same reason I think even multicast should be forwarded to the
CPU port.

There are a couple of other reports, but I think they are false positives.

Note that is expected that you replies to sashiko reports on the ML.

/P

