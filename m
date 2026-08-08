Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E29833C53D;
	Sat,  8 Aug 2026 19:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786218500; cv=none; b=HjvFthSe/UoGdhv2yqKbBOabL5Xu7pcjlkJwyKksR2DIDDDKeoeKMiM05M37a+n2ckw/8V1erw9Hz8ytV243aPrB0ebMsJVFrGfhP7DZ5OPS8F8Wex7m6+JhgKMPRFiF6039xkFwTuIAKLUM2/MrDA+che/eKQrHwXj7Da/lAIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786218500; c=relaxed/simple;
	bh=L0rRFVSC+yuBzeg0nJX/B/pVQqTvl+C3HbsAPhGx65Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sbV289SWqiTeaK0Seqy7mUotVoNs9hh44ShdSklWC46o4dW12eA8EDa9asyc2VtRFUstYXXwprhLtJlV+dukqGcV48RHVm58HHQ53WFNt3KtRR/w/9gMRMeOwF/kdgnlCnGgX2qjW6fIUJraygyvKEBMjkCf2qJjA+rvYunrprQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VsJYgh24; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VsJYgh24"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C081F00A3A;
	Sat,  8 Aug 2026 19:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786218498;
	bh=39gt51/isAO4d8RJ42zRo3vpitwkhl+gNkFO7bVDtdo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VsJYgh24mxEr2VMzMAjW/xrRP3PReaaq+MGQ//C5Fl3TIIV/n6DsOAGdUN/i9eCo9
	 MhEOKT0pYfcQ79qWVXUxzsZln6vJQFnBCT3HboxZrXuYeUjZJ/HJFHyRXHMz+ObOiq
	 l1pMOimK1o6dsVFGrFj75dG5fyvT0znnpV6d0rPti69rZbmIkRIhXWyLgvMUItT00w
	 5Msev3qTKrQ7yDjvstIpZ8qB7gXkwR19sqP4zap9XO0N9XfzDXJvvnO74YoyEsJM8z
	 RHLkmn9dnbHa9j3e0dU8sdYVq37kE2ono9viGhZd0+0+P8+SC/GjehgEtGACI+p7vr
	 h0r2wtFFCprQg==
From: Jakub Kicinski <kuba@kernel.org>
To: nagadheeraj.rottela@amd.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	srinivas.neeli@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	michal.simek@amd.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	horms@kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	git-dev@amd.com
Subject: Re: [PATCH 02/20] net: xilinx: tsn: add TSN endpoint wrapper driver
Date: Sat,  8 Aug 2026 12:48:17 -0700
Message-ID: <20260808194817.132469-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260807104431.157230-3-nagadheeraj.rottela@amd.com>
References: <20260807104431.157230-3-nagadheeraj.rottela@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: xilinx: tsn: add TSN endpoint wrapper driver

Adds a thin wrapper platform driver for the Xilinx TSN Endpoint Ethernet
MAC IP node, along with a new Kconfig symbol and Makefile under
drivers/net/ethernet/xilinx/tsn/. The wrapper enables the six IP-wide
clocks and then populates the sub-nodes so each can bind to its own driver.

A few questions below, all fairly minor.

> diff --git a/drivers/net/ethernet/xilinx/tsn/Kconfig b/drivers/net/ethernet/xilinx/tsn/Kconfig
> new file mode 100644
> index 000000000000..45af4d3f10e6
> --- /dev/null
> +++ b/drivers/net/ethernet/xilinx/tsn/Kconfig
> @@ -0,0 +1,15 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Xilinx TSN device configuration
> +#
> +
> +config XILINX_TSN
> +	tristate "Xilinx TSN Ethernet driver"
> +	depends on OF && HAS_IOMEM

[Severity: Low]
Should this depend on OF_ADDRESS rather than OF && HAS_IOMEM?

The only functional statement in tsn_ip_probe() is:

	return devm_of_platform_populate(dev);

and in include/linux/of_platform.h the real implementation is compiled
only under CONFIG_OF_ADDRESS; otherwise the inline stub is:

	static inline int devm_of_platform_populate(struct device *dev)
	{
		return -ENODEV;
	}

OF && HAS_IOMEM does not imply OF_ADDRESS, per drivers/of/Kconfig:

	config OF_ADDRESS
		def_bool y
		depends on !SPARC && (HAS_IOMEM || UML)

sparc selects OF and provides HAS_IOMEM, and NET_VENDOR_XILINX has no
architecture dependency, so XILINX_TSN is selectable there with
OF_ADDRESS=n.

In that configuration tsn_ip_probe() still runs devm_kzalloc(),
devm_clk_bulk_get() and clk_bulk_prepare_enable() for all six clocks and
registers the disable action, and then returns -ENODEV, so the driver can
never bind and no sub-node device is created. The clocks are unwound by
devres, so nothing leaks, but the whole driver is dead code in that
configuration.

This also stays as is through the end of the series, where the symbol is
still "depends on OF && HAS_IOMEM" plus "depends on XILINX_DMA", and
XILINX_DMA only has "depends on HAS_IOMEM".

> +	help
> +	  This driver supports the AMD/Xilinx Time-Sensitive Networking
> +	  (TSN) Endpoint Ethernet MAC IP. It provides the wrapper device
> +	  and the endpoint MAC that connects the IP to the host CPU. The
> +	  three-port switch is supported by NET_DSA_XILINX_TSN.

[Severity: Low]
The help text describes "the endpoint MAC that connects the IP to the host
CPU" and refers the reader to NET_DSA_XILINX_TSN, but at this commit the
symbol only builds xilinx_tsn_main.o (clock enable plus
devm_of_platform_populate()) and no NET_DSA_XILINX_TSN symbol exists in the
tree yet.

Both do appear later in the same series: the end-of-series Makefile has

	xilinx_tsn-y := xilinx_tsn_main.o xilinx_tsn_ep.o

with &xlnx_tsn_ep_driver registered from xilinx_tsn_main.c, and
NET_DSA_XILINX_TSN is added in drivers/net/dsa/xilinx/Kconfig.

Since the text only appears in prose and not in a select or depends on,
there is no build effect; would it be worth wording the help text so it
matches what this commit actually builds, or is the forward reference
intentional for the series?

> +
> +	  If unsure, say N.

[ ... ]

> diff --git a/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c
> new file mode 100644
> index 000000000000..1ef1b0c2ee6e
> --- /dev/null
> +++ b/drivers/net/ethernet/xilinx/tsn/xilinx_tsn_main.c
> @@ -0,0 +1,105 @@

[ ... ]

> +static int tsn_ip_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct xlnx_tsn_ip *w;
> +	int ret;
> +
> +	w = devm_kzalloc(dev, sizeof(*w), GFP_KERNEL);
> +	if (!w)
> +		return -ENOMEM;
> +
> +	for (int i = 0; i < TSN_NUM_CLOCKS; i++)
> +		w->clks[i].id = tsn_clk_names[i];
> +
> +	ret = devm_clk_bulk_get(dev, TSN_NUM_CLOCKS, w->clks);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get clocks\n");
> +
> +	ret = clk_bulk_prepare_enable(TSN_NUM_CLOCKS, w->clks);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to enable clocks\n");
> +
> +	ret = devm_add_action_or_reset(dev, tsn_clk_bulk_disable, w);
> +	if (ret)
> +		return ret;
> +
> +	return devm_of_platform_populate(dev);
> +}

[Severity: Low]
Is there a consumer for xlnx,num-priorities anywhere?

Documentation/devicetree/bindings/net/xlnx,tsn-endpoint-ethernet-mac.yaml
lists it in the top-level required block for this same node:

	required:
	  - compatible
	  - reg
	  - clocks
	  - clock-names
	  - xlnx,num-priorities
	  - ranges

tsn_ip_probe() is the only driver binding
"xlnx,tsn-endpoint-ethernet-mac-3.0", and it only fills clks[].id and
calls devm_clk_bulk_get(), clk_bulk_prepare_enable() and
devm_of_platform_populate(). Grepping for num-priorities or
num_priorities at the end of the series finds hits only inside the YAML
itself plus unrelated fsl-mc and xe files.

So device tree authors must supply the property to pass dt_binding_check
while nothing reads it. Would it make sense to drop it from required
until a driver actually uses it?

[ ... ]
