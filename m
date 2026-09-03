Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608611FF7C8;
	Thu,  3 Sep 2026 17:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788455915; cv=none; b=TTl9hFhX/UFZ0e7yE6Ni3MLwyLYRagOKWq2IJLjez3DpzeOv3dLW4WG1IUIXu8o1ujhPMZQz+QwJ6k9EyOaGVOHb90Tge+ziMzsbWcFMP5e+Z+IZHuJnuh9n7GgBTzovzh7Mu2QAJGK7nm9PkEyBRPsa91qoTpUgwvb1I5RHzOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788455915; c=relaxed/simple;
	bh=p6rS8X9u8AcSZpDVLpcO4p1MdnCNksBdWa0CcN1a6uc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bdoESDFD2ZP6R1hCMdWdwQgfFd22H6gCHHXBlJlabdEGWAc5SLE1pqZ9VS29PXSK0LNW8dpecOyEIaW9MXD3fbhH6P0IFZJbSOowH4MCft0r7mhC0Qshv6f7wMNjxti+U/uK5E+5FEDNimwm4fxCseg1wiWSCrDbnt+V8ynB36s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efuwS3Ky; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efuwS3Ky"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 027F61F000E9;
	Thu,  3 Sep 2026 17:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788455914;
	bh=VaNiKLjrBkXnRrP+B04GwooKadFpzdr1nDGvyAAiQEg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=efuwS3KyGVnO3KhfxaLo5r1/iLyUjlvyS0Ywu0t+kDTzEp+dW+QQzoHgkNOpsegVO
	 fYMOR0+UXSDx6Sh3frJBtlbhwDLEY1tdzg5AHfO8mjFZ+Sv4MaWO64u3HxsiuwndsS
	 lxIj3dA2GW3/BNS94ZIZgWNMODCqXL26yLDCgBs9O9vpdiPgBHru38kt81u5ompWW+
	 lLpFAzg3OlCo2wTxzbj4u8S0w/sxZOJGLHcq4EhFD8iIF72nBbxnEV4r7sDRYROvP8
	 846OFAA1o15l7hfbkkoxa1akw2JVMEl8TJfQE0JvCGWdhlNE73r88YW6KXLzXclvnG
	 iwbibbMU9pT/Q==
Subject:
 Re: [v26,net-next,01/10] net/nebula-matrix: add minimum nbl build framework
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, kuba@kernel.org, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org
Date: Thu, 03 Sep 2026 17:18:32 +0000
Message-ID: <178845591249.3394541.8367854604654150435@kernel.org>
In-Reply-To: <20260831021408.2325-2-illusion.wang@nebula-matrix.com>
References: <20260831021408.2325-2-illusion.wang@nebula-matrix.com>
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

- [Low] The documentation file added by this patch,
  Documentation/networking/device_drivers/ethernet/nebula-matrix/nbl.rst…

--

net/nebula-matrix: add minimum nbl build framework

This adds the Kconfig/Makefile/MAINTAINERS entries for a new
drivers/net/ethernet/nebula-matrix/ vendor directory, a driver
documentation file, and a PCI driver skeleton (nbl_main.c) whose probe
and remove callbacks are stubs.

> diff --git a/Documentation/networking/device_drivers/ethernet/nebula-matrix/nbl.rst b/Documentation/networking/device_drivers/ethernet/nebula-matrix/nbl.rst
> new file mode 100644
> index 000000000000..ff38302968c5
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
> +The m18110-NIC/m18000-NIC is a series of network interface cards for the Data
> +Center Area.
> +
> +The driver supports link-speed 100GbE/25GE/10GE.
> +
> +m18110-NIC/m18000-NIC devices support MSI-X interrupt vector for each Tx/Rx
> +queue and interrupt moderation.
> +
> +m18110-NIC/m18000-NIC devices support also various offload features such as
> +checksum offload, Receive-Side Scaling(RSS).

[Severity: Low]
Do these three statements describe what the driver actually does, either
at this commit or at the end of the series?

Grepping the vendor directory at the last patch of the series
("net/nebula-matrix: add common dev start/stop operation",
9b90629960395de83faaf5146e29ffc3cb854c5b) finds nothing for any of the
netdev or offload plumbing these sentences describe:

  git grep -E 'register_netdev|netdev_ops|alloc_etherdev|ethtool_ops|NETIF_F_' \
      drivers/net/ethernet/nebula-matrix/
  (no matches)

The directory at that point contains only nbl_main.c plus nbl_channel/,
nbl_common/, nbl_core/, nbl_hw/ and nbl_include/, so the code binds the
PCI function, maps the BARs and brings up the PF mailbox, but never
registers a net_device, never programs per-queue Tx/Rx MSI-X vectors, and
has no RSS, checksum offload, interrupt moderation or link-speed
reporting.

Would it make sense to describe only what is implemented, and add the
link speed / per-queue MSI-X / moderation / RSS / checksum text in the
patches that introduce those features?

> +
> +Support
> +=======
> +
> +For more information about m18110-NIC/m18000-NIC, please visit the following URL:
> +https://www.nebula-matrix.com/snic_s1000_en

Is this the right product page?  The URL names snic_s1000, while
nbl_main.c documents the matched IDs as "SNIC v3r1 product Device IDs
range: 0x3403-0x3412" for m18110/m18000.

> +
> +If an issue is identified with the released source code on the supported kernel
> +with a supported adapter, email the specific information related to the issue to
> +open@nebula-matrix.com.

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/Kconfig b/drivers/net/ethernet/nebula-matrix/Kconfig
> new file mode 100644
> index 000000000000..f16e9663eaed
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/Kconfig

[ ... ]

> +config NBL
> +	tristate "Nebula-matrix Ethernet Controller m18110/m18000 support"
> +	depends on PCI && (64BIT || COMPILE_TEST) && !CPU_BIG_ENDIAN
> +	help
> +	  This driver supports Nebula-matrix Ethernet Controller m18110/m18000
> +	  Family of devices.
> +
> +	  More specific information on configuring the driver is in
> +	  <file:Documentation/networking/device_drivers/ethernet/nebula-matrix/nbl.rst>.

The help text points users at the .rst above as the description of the
option's capabilities, so the same over-claim reaches anyone selecting
CONFIG_NBL: the prompt says "Ethernet Controller m18110/m18000 support",
but no network interface is created by any commit in this series.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831021408.2325-1-illusion.wang%40nebula-matrix.com
