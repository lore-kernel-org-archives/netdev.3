Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD91D49A3B0;
	Thu, 17 Sep 2026 22:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789684503; cv=none; b=sz7Ao9/GolsISbhsCoMeQAzGNS9J7h/oPkVYr/j4W+z3h2eEqaYpl9C3MzdvKBlUkEJQRGflcwk+jHfQLe2FhJSwk5pCjhUVaPmFT4DympQsS8M5Tkm+1zcaxEiKyQ52R8VSoFbfk8iLWbzReEtyTzJBBDwkckyoCZbOfT7wvOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789684503; c=relaxed/simple;
	bh=xo2xEJz092NiB3/4xM6oRE6VjGoHWGxww2opRd4YIeg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kvpMI0aK7d1VwEgSyI/CuyJmr0gI6rIGguZ6XirH080cfj7CdcAYlF6pidGKqr4oRZjonBaYT7tZZt/jipNSBNBUV0bOQ6nlvXneqf/E+AXTmRnfSrGoEzZC/xM11CSBbeXo0qpD45xXJLSaf9ejoD8Um9otaKGa2SIK11ugYcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i7f3fmGX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i7f3fmGX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C50A01F00893;
	Thu, 17 Sep 2026 22:35:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789684501;
	bh=YOWH69iM4IL2IPGbqiDWdmSiKejWyoko7o+0RQna5+4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=i7f3fmGXe0Ht7fyG9DCzPqQouFFgJ0PIK46Oaaa2tkpUZ2kZOyKfyqFJtgxAx7tDP
	 nybH3eJPVG0ZMuEeRheUvUpEa9s3p8EajepT/bnwlqbkzYprAohHCLF/StDjEIj62L
	 9HlM+BxUCedP1lN0Ucn4Hs67ELdfEPy+P9VrFiH/hquYEMhVPLJFdFeqGOAHGX0Nat
	 jyHPRFOqKGdJ/2fJahKryYpPaG5DWD4yPGhVF4UXXn59T0DQ0cOwZ7bXD92XiXiYMk
	 HokDbBb/WDK35+CuIZmtcLw4jQs5+tCvG0xDuMVMAe14i4+4bT2vWN+brEoPnj89jE
	 kGra5LsfzPOMQ==
Subject: Re: [PATCH v28 net-next 02/10] net/nebula-matrix: add core driver
 architecture and HW layer initialization
From: netdev-bot+sashiko@kernel.org
To: illusion.wang@nebula-matrix.com
Cc: dimon.zhao@nebula-matrix.com, alvin.wang@nebula-matrix.com,
 sam.chen@nebula-matrix.com, netdev@vger.kernel.org, andrew+netdev@lunn.ch,
 corbet@lwn.net, kuba@kernel.org, horms@kernel.org, linux-doc@vger.kernel.org,
 pabeni@redhat.com, vadim.fedorenko@linux.dev, lukas.bulwahn@redhat.com,
 edumazet@google.com, enelsonmoore@gmail.com, skhan@linuxfoundation.org,
 hkallweit1@gmail.com, linux-kernel@vger.kernel.org
Date: Thu, 17 Sep 2026 22:35:00 +0000
Message-ID: <178968450038.22033.4539335797454415990@kernel.org>
In-Reply-To: <20260914123429.56596-3-illusion.wang@nebula-matrix.com>
References: <20260914123429.56596-3-illusion.wang@nebula-matrix.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 2 · Low: 1

- [Medium] nbl_probe() starts claiming every device in nbl_id_table()
  from this patch onwards (patch 1 of the series deliberately returned…
- [Medium] nbl_get_func_param() grants the chip-global management role
  solely from host/guest-visible PCI topology: `if…
- [Low] The constant NBL_BAR2_MAX_LEN (nbl_hw_leonis.h) is named as the
  *maximum* mailbox BAR length (0x300) but nbl_hw_init_leonis() uses it…

--

net/nebula-matrix: add core driver architecture and HW layer initialization

This patch adds the nbl_adapter/nbl_core/nbl_common_info device context,
turns nbl_probe() into a real probe that enables the device and maps the
Leonis BARs, and adds the capability parsing that decides whether a
function gets the chip-global control role.

A few questions below about the commit message wording and about how
has_ctrl and NBL_BAR2_MAX_LEN are used.

>     Note:
>     This commit binds the PCI device during probe, but does not create or
>     register netdev. Netdev support will be added in later patches of this
>     series.

[Severity: Medium]
Is this accurate for the series as posted?  Grepping the driver directory
at the tip of the series for register_netdev, alloc_etherdev or netdev
returns no matches, so no network interface appears to be created in any
of the following patches.

>From this patch onward nbl_probe() claims every ID in nbl_id_table(),
enables bus mastering, maps the BARs, and (on the control function)
programs chip-global registers, but returns success without providing a
netdev or any other user-visible interface:

	adapter = nbl_core_init(pdev, &param);
	...
	pci_set_drvdata(pdev, adapter);
	return 0;

Would it be better to either keep the -ENODEV stub until the netdev
patch lands, or reword this note so it does not promise a netdev that
the series does not add?

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> new file mode 100644
> index 0000000000000..cf40ddc451921
> --- /dev/null
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_hw/nbl_hw_leonis/nbl_hw_leonis.c
> @@ -0,0 +1,153 @@

[ ... ]

> +	if (common->has_ctrl) {
> +		/*
> +		 * Hardware layout: MEMORY BAR total size is 64M.

[ ... ]

> +		hw_size = PAGE_ALIGN_DOWN(NBL_MEM_BAR_TOTAL_SIZE -
> +					  NBL_RDMA_NOTIFY_LEN);
> +		hw_mgt->hw_addr =
> +			pcim_iomap(pdev, NBL_MEMORY_BAR,
> +				   hw_size);
> +	} else {
> +		if (bar_len < NBL_REG_NET_ONLY_LEN) {

[ ... ]

> +		hw_size = NBL_REG_NET_ONLY_LEN;
> +		hw_mgt->hw_addr = pcim_iomap(pdev, NBL_MEMORY_BAR,
> +					     hw_size);
> +	}

[ ... ]

> +	if (bar_len < NBL_BAR2_MAX_LEN) {
> +		dev_err(&pdev->dev, "MAILBOX BAR length %pa too small\n",
> +			&bar_len);
> +		ret = -EINVAL;
> +		goto setup_mgt_fail;
> +	}
> +	hw_mgt->mailbox_bar_hw_addr = pcim_iomap(pdev, NBL_MAILBOX_BAR,
> +						 bar_len);

[Severity: Low]
This isn't a bug, but the constant name and its use disagree.
NBL_BAR2_MAX_LEN reads as a maximum, while the test here treats it as the
minimum required register extent:

	if (bar_len < NBL_BAR2_MAX_LEN)
		... -EINVAL;

The mapping and the recorded window size then use the full advertised BAR
length rather than the constant:

	hw_mgt->mailbox_bar_hw_addr = pcim_iomap(pdev, NBL_MAILBOX_BAR,
						 bar_len);
	...
	hw_mgt->mailbox_bar_size = bar_len;

Could the constant be renamed to something like NBL_BAR2_MIN_LEN or
NBL_BAR2_REG_LEN, or alternatively the pcim_iomap() length and
mailbox_bar_size clamped to it?

[ ... ]

> diff --git a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> index 199626159a4ce..f2552bc732937 100644
> --- a/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> +++ b/drivers/net/ethernet/nebula-matrix/nbl/nbl_main.c
> @@ -8,16 +8,108 @@

[ ... ]

> +static void nbl_get_func_param(struct pci_dev *pdev, kernel_ulong_t driver_data,
> +			       struct nbl_init_param *param)
> +{
> +	param->caps.has_net = !!(driver_data & BIT(NBL_CAP_HAS_NET_BIT));
> +
> +	/*
> +	 * Hardware fixed rule: physical PF0 is the only management PF with
> +	 * global ctrl capability. All PFs share identical PCI device ID, so
> +	 * distinguish control PF via physical function ID.
> +	 *
> +	 * Hardware & firmware design FORBID passing any PF through to virtual
> +	 * machines, there is no scenario where a non-management PF appears
> +	 * as Func 0 inside guest. Thus using PCI_FUNC(pdev->devfn) to identify
> +	 *  control PF is safe on our platform.
> +	 */
> +	if ((PCI_FUNC(pdev->devfn) == 0) && !pdev->is_virtfn)
> +		param->caps.has_ctrl = 1;
> +}

[Severity: Medium]
Is PCI topology a sufficient source for the chip-global control role?

The comment states that hardware and firmware forbid passing a PF through
to a VM, but nothing in the kernel enforces that.  A host admin can bind
vfio-pci to any of these PFs; inside the guest pdev->is_virtfn is 0 and
VMMs commonly place the first assigned function at devfn 0x00, so:

	if ((PCI_FUNC(pdev->devfn) == 0) && !pdev->is_virtfn)
		param->caps.has_ctrl = 1;

is satisfied for a non-management PF.

has_ctrl then selects privileged, chip-wide behaviour.  In
nbl_hw_init_leonis() it picks the ~64 MiB global register window instead
of the 8 KiB net-only window:

	if (common->has_ctrl) {
		...
		hw_size = PAGE_ALIGN_DOWN(NBL_MEM_BAR_TOTAL_SIZE -
					  NBL_RDMA_NOTIFY_LEN);

Later in the series it also gates nbl_res_start() -> nbl_res_init_pf_num()
/ nbl_intr_mgt_start(), which read global registers and own MSI-X map
entries of remote PFs, and nbl_dev_init() -> nbl_dev_setup_ctrl_dev(),
which programs chip-wide datapath registers and the mailbox qinfo routing
table for every PF.  nbl_res_remove_leonis() acknowledges this with "the
control PF, which may hold maps for remote PFs that are still bound".

Could the control role be derived from a firmware/hardware identity read
(and default to non-ctrl when that read is unavailable), rather than from
devfn?  Whether the ASIC actually filters BAR0 writes from a
non-management function to the global blocks is not visible from the
source here, so it would help to have that stated explicitly.

> +
>  static int nbl_probe(struct pci_dev *pdev,
>  		     const struct pci_device_id *id)
>  {
> -	return -ENODEV;
> +	struct nbl_init_param param = { { 0 } };

[ ... ]

> +	nbl_get_func_param(pdev, id->driver_data, &param);
> +	/* never return fail when DMA_BIT_MASK(64) */
> +	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> +
> +	pci_set_master(pdev);
> +
> +	adapter = nbl_core_init(pdev, &param);
> +	if (IS_ERR(adapter)) {
> +		dev_err(dev, "Nbl adapter init fail: %pe\n", adapter);
> +		err = PTR_ERR(adapter);
> +		goto adapter_init_err;
> +	}
> +	pci_set_drvdata(pdev, adapter);
> +	return 0;

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914123429.56596-1-illusion.wang%40nebula-matrix.com
