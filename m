Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC323EA957;
	Fri, 11 Sep 2026 03:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789098106; cv=none; b=ePQwWuGWLhJSs2MdXTsuy7CsFd/lXLlGi8hvRhULZzOxir52LXgsFv0E862yJ639VxR39azOFtidsUdAk+9kSNQ4GgE7nzkZmETPP2aGT8XyYDMtJ7d5PDoQ0DQRkk8KYg6KY6EmC8tDKsYZ9GAwkHkC+CjmkzzliXIiQ8d5OJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789098106; c=relaxed/simple;
	bh=fffmjl3I+t0VoNskA2NPcaWs6UwgQHAQEzNnZOgVtN8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LVMsqjlKgOV05/U4XZos1W+glVMNKUtyZlT4GoDUL4Ntko/1GZKRDkLl5Jv1F3PNX2kJ2y910ccCNGKQwbPaKTzeQ/hC8Iw18eqyNs1as1i3+4GX3BfJZgkP33t/gYTGhCOI5YJ1a68GDIrUgEcNHuRupze24YDwmDs8geqP0rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ca2T/y5T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ca2T/y5T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BF171F000FF;
	Fri, 11 Sep 2026 03:41:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789098104;
	bh=TkgS+0JEYkCNvD9Z8BwlVLBV2hDmg9h+tqMOl3/pZDA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ca2T/y5TVtNflBHHa/uIk7OJq3w5Jz4c/8T2VHA5Zk/9kF0kixasJiR6UZp5o7KIA
	 6XJfiUk+OW9tTwrIpVqVmOkfbNDNR32k5hdl+ZGDn70SSkTooQ7Pom4pfswAUOpwUu
	 +XVJ/qzX46+5Om6pBOOkwqpNhhlmZ4CQuTJh4vCS8BAovwSAz66nzgP0MeOs47WhWy
	 SGpEZStGbWCrONvkTsxJiM7RCFa6N6gmWJyEM4rf8csJlekSc6OY/CugmJ9hmAVTgo
	 ez9DsyxU0VjSYVk5S3s2+9bQqq3U0YPVshj7j8TjjV1o8K1mHBTZ76UVJF4ZwnlLkl
	 YaBTYviraRA0w==
Subject: Re: [PATCH v27 net-next 01/10] net/nebula-matrix: add minimum nbl
 build framework
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, kuba@kernel.org, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org
Date: Fri, 11 Sep 2026 03:41:42 +0000
Message-ID: <178909810279.219967.5775207930662190631@kernel.org>
In-Reply-To: <20260907123848.30256-2-illusion.wang@nebula-matrix.com>
References: <20260907123848.30256-2-illusion.wang@nebula-matrix.com>
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

- [Low] Documentation/Kconfig prose added by this patch describes
  functionality that does not exist at this commit:…

--

net/nebula-matrix: add minimum nbl build framework

This patch adds the Kconfig, Makefile and MAINTAINERS entries for a new
nebula-matrix ethernet vendor directory, a documentation file for the nbl
driver, and a PCI driver skeleton whose probe and remove callbacks are
stubs.

> diff --git a/Documentation/networking/device_drivers/ethernet/nebula-matrix/nbl.rst b/Documentation/networking/device_drivers/ethernet/nebula-matrix/nbl.rst
> new file mode 100644
> index 0000000000000..5540291cf3766
> --- /dev/null
> +++ b/Documentation/networking/device_drivers/ethernet/nebula-matrix/nbl.rst
> @@ -0,0 +1,28 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +================================================================
> +Linux Base Driver for Nebula-matrix m18110-NIC/m18000-NIC family
> +================================================================
> +
> +Overview:
> +=========
> +The m18110-NIC/m18000-NIC (marketed as SNIC s1000) is a series
> +of network interface cards for the Data Center Area.
> +
> +This driver provides the core infrastructure for m18110/m18000-NIC
> +devices, including:
> +
> +- PCI device enumeration and resource (BAR) management
> +- Firmware command interface via PF mailbox
> +- Channel-based communication between driver and firmware
> +- Device initialization and teardown

[Severity: Low]

This isn't a bug, but does the documentation added here describe code that
exists at this commit?  The only C file added is nbl_main.c, where
nbl_probe() returns -ENODEV and nbl_remove() is empty, so there is no BAR
management, no PF mailbox command interface, no channel communication and no
device init/teardown yet.

The same wording appears in the CONFIG_NBL help text below.

All four items are implemented by the end of the series (nbl_probe() ends up
calling nbl_core_init(), which chains nbl_hw_init_leonis(),
nbl_chan_init_common(), nbl_res_init_leonis(), nbl_disp_init() and
nbl_dev_init()), and the .rst text is not touched again, so this is only a
skew within the series.

Would it be preferable to word the first patch's doc and help text to match
the stub state, or to add this prose together with the code it describes?

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/Kconfig b/drivers/net/ethernet/nebula-matrix/Kconfig
> new file mode 100644
> index 0000000000000..dd0e91d14131f
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/Kconfig
> @@ -0,0 +1,32 @@

[ ... ]

> +config NBL
> +	tristate "Nebula-matrix Ethernet Controller m18110/m18000 support"
> +	depends on PCI && (64BIT || COMPILE_TEST) && !CPU_BIG_ENDIAN
> +	help
> +	  This driver provides the core infrastructure for Nebula-matrix
> +	  Ethernet Controller m18110/m18000 Family of devices, including
> +	  PCI enumeration, firmware mailbox and channel communication.

This is the menuconfig text mentioned above; at this commit selecting
CONFIG_NBL=m builds a module that only registers a pci_driver with an
always-failing probe.

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> new file mode 100644
> index 0000000000000..199626159a4ce
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> @@ -0,0 +1,100 @@

[ ... ]

> +static int nbl_probe(struct pci_dev *pdev,
> +		     const struct pci_device_id *id)
> +{
> +	return -ENODEV;
> +}
> +
> +static void nbl_remove(struct pci_dev *pdev)
> +{
> +}

[ ... ]

> +static const struct pci_device_id nbl_id_table[] = {
> +	{ PCI_DEVICE(NBL_VENDOR_ID, NBL_DEVICE_ID_M18110),
> +	  .driver_data = BIT(NBL_CAP_HAS_NET_BIT) },

[ ... ]

> +	/* required as sentinel */
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(pci, nbl_id_table);

Since MODULE_DEVICE_TABLE() publishes all 16 IDs in the 0x1F0F:0x3403-0x3412
range, udev will autoload nbl on matching hardware at this commit and the
device stays unbound because of the -ENODEV above.  Is that the intended
intermediate state for a bisect point?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260907123848.30256-1-illusion.wang%40nebula-matrix.com
