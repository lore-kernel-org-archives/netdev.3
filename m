Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2B640E8FA
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 20:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791405890; cv=none; b=GD5iB020KHvksv8ExYmxgDv1AvNieB3IgLdUnDxAu92++NALz/fLf1TybxiRd39KSvyxohz7qtDLf0I8HEfz2FrMMatoopEMnevlrJH3G+dnnAi67HdWLiYZMjJusa6GjFIgeCno5VMzHwVLk7z6D0zwHbQgmkJOGH7GSj0Yy7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791405890; c=relaxed/simple;
	bh=JEAaxYDc199ZUGYGVEC2nTZPal3cjIA4WxGi6LeA8kw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WWqkRze2Wc8KhIyO1wR0glcxUg4MWZk1YCOqdKdOHTeth5KdbG5xXD2JFH+xS25ULxWCL4oBE/XgAALXnNzLT0LqjoDkXqHC2hzu192DxkI0Z3IoB7IIc+bawaWCFp8sg3zc0PwQVPdkvK/giX0TAfcqfmpwNdrEwX0Fc7P+qvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WbozL8Nc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WbozL8Nc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AC451F000FF;
	Wed,  7 Oct 2026 20:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791405889;
	bh=21iEUWR9+okajNMH3e2L6tokAGfZJqtMCAo8Byf3M2o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=WbozL8NciVO0EwsqVmi5bNFDuLa+Dq0iy216FMr4514IEb7dLA3d+PCcrSoC4r4Xz
	 +Cp4TZBQa5LRJF1wLYoKb2X6DSmlUT9ZCPDRpth3ya0dpJyw6f2VcK0xGpKwqP8l6R
	 j2sXYB+mOB3tIJPfGAC25UwJKPDiWoVVSuZ/29vGw+wZx4trEfHSgb2xDqTwbZwkg+
	 OMg3Ggw8v9VGkZZRLbGj4qY9hxzDn+oYJny52yXu8YOh/LWBDADxSql4HICqm8hEw3
	 nzYbTtA36S23741/NsH8HNhs+zTeblw/u20hC/bFIkZN/6NSBQft3LfniD03pxGxxi
	 /J5SQ+MEh3T+A==
Subject: Re: [PATCH net v3 2/3] bnxt_en: Fix driver init in kdump kernel
From: netdev-bot+sashiko@kernel.org
To: michael.chan@broadcom.com
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com, joe@dama.to,
 kalesh-anakkur.purayil@broadcom.com, scott.branden@broadcom.com
Date: Wed, 07 Oct 2026 20:44:48 +0000
Message-ID: <179140588802.434549.7437964489574338925@kernel.org>
In-Reply-To: <20261005204246.3822563-3-michael.chan@broadcom.com>
References: <20261005204246.3822563-3-michael.chan@broadcom.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] bnxt_kdump_reset() (drivers/net/ethernet/broadcom/bnxt/bnxt.c)
  checks that config space is reachable only after the FLR, never before…

--

bnxt_en: Fix driver init in kdump kernel

This commit adds bnxt_kdump_reset() and calls it from bnxt_init_one() in
the kdump kernel. It disables bus master and memory decode, saves PCI
state, issues an FLR, polls config space for up to 5 more seconds, clears
the BARs and restores the saved PCI state, so a PCIe switch in synthetic
mode sees the BARs reprogrammed.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 8ce8a82d34530..9ea7e172787e2 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -17119,6 +17119,43 @@ static void bnxt_clear_bars(struct pci_dev *pdev)
>  		pci_write_config_dword(pdev, off, 0);
>  }
>  
> +/* Clear any pending DMA transactions from crash kernel while loading driver in
> + * capture kernel.
> + */
> +static int bnxt_kdump_reset(struct pci_dev *pdev)
> +{
> +	int rc, i;
> +	u16 cmd;
> +
> +	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> +	cmd &= ~(PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY);
> +	pci_write_config_word(pdev, PCI_COMMAND, cmd);
> +
> +	if (pci_save_state(pdev))
> +		dev_warn(&pdev->dev, "Failed to save PCI state, PCI restore may be incomplete\n");
> +
> +	rc = pcie_flr(pdev);
> +	if (rc)
> +		dev_warn(&pdev->dev, "pcie_flr() failed (rc: %d), trying to continue\n",
> +			 rc);
> +
> +	/* In case device is not returning CRS, wait 5 seconds longer */
> +	for (i = 0; i < 50; i++) {
> +		pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> +		if (!PCI_POSSIBLE_ERROR(cmd))
> +			break;
> +		msleep(100);
> +	}
> +	if (PCI_POSSIBLE_ERROR(cmd)) {
> +		dev_err(&pdev->dev, "PCI config space inaccessible after FLR, aborting\n");
> +		return -ENODEV;
> +	}
> +
> +	bnxt_clear_bars(pdev);
> +	pci_restore_state(pdev);
> +	return 0;

[Severity: Medium]
What happens in bnxt_kdump_reset() if the function is not answering config
reads when the kdump kernel probes it? One example is a chip reset that is
still running.

The first PCI_COMMAND read at the top of the function is not checked with
PCI_POSSIBLE_ERROR(). In that case cmd would be 0xffff, and the masked
value gets written back. pci_save_state() also does not check what it
reads:

drivers/pci/pci.c:pci_save_state() {
	for (i = 0; i < 16; i++) {
		pci_read_config_dword(dev, i * 4, &dev->saved_config_space[i]);
		...
	}
	dev->state_saved = true;
	...
}

So it returns 0 with an all-ones snapshot, and the "Failed to save PCI
state" warning does not fire.

pcie_flr() would then fail its pci_dev_config_accessible() check. It
returns -ENOTTY without doing the reset, and the code carries on.

If the device starts responding during the new 5 second poll,
bnxt_clear_bars() zeroes BAR0-5. pci_restore_state() then writes back
every saved dword that differs from the live value, plus the PCIe control
registers:

  - BAR0-5 and the ROM BAR get 0xffffffff instead of the assigned
    addresses
  - PCI_COMMAND becomes 0xffff, which enables memory/IO decode and bus
    master on a function that was never FLR'd
  - BIST gets 0xff
  - pci_restore_pcie_state() writes DEVCTL as 0xffff, which includes
    PCI_EXP_DEVCTL_BCR_FLR

bnxt_kdump_reset() still returns 0 in this case. bnxt_init_one() then goes
on to bnxt_init_board() and maps BARs the device no longer decodes.

Could this cause the same UR/AER errors behind the PCIe switch that this
patch is meant to fix?

Would it make sense to check PCI_POSSIBLE_ERROR(cmd) after the first read,
or to validate the saved header before restoring it? The code could then
abort or skip the save/restore.

The later patch in this series, "bnxt_en: Re-write the BARs following any
type of PCIe errors", does not change bnxt_kdump_reset(). So this seems to
remain at the end of the series.

> +}
> +

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261005204246.3822563-1-michael.chan%40broadcom.com
