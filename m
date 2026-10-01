Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3631831280D
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 01:01:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790816522; cv=none; b=IbBGzB+0l1s561QDvIoRYf3sZ24LQ3WWeMet/w1HmeP4ZSt7SyNoepQpFLiqJXr1TeLeYS05qUiSJWMoDADE6q+c6WkDWPj0XBBAh6ow7FAjZ3IyoGKbR25teM9asV/eAd8y+Ml1ZDKeZuZFOs9T975RrNgdXxXT1tySS2EkKpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790816522; c=relaxed/simple;
	bh=fiPZ99+9NTlAMydtpJmCxAojICNGMx/XbSXYcgCQjt0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ujWWpAivN9OU+WvISd80VFf4B8/+NGjTz2N454Yg6/kgDy1o/7bwofi/YhJd3yyddsnL2mhiF0iR7t9xArNEoSACUzhfrj3CngKklQ3I0RK2rKm2DTSNAT5nIeJ+6EyC+OEti7Ovow25/lsUPNrEc/xk45O7mc5k9g48j22cJIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bYXggEj1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bYXggEj1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 116C31F0089A;
	Thu,  1 Oct 2026 01:01:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790816519;
	bh=e2PDw4aTGLo7/DW7mZv2ue7CqFXJm6H9pI41Il6kcuU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bYXggEj1dKX0SLIp+JT8f2Gl/zj8f5O9i5SJFOI5/ALQzpl1dwG9UqU6dlbav6cft
	 h8+5XFo8xCxJppv0tYSsSlVzNv6RRqPH4Deee4dfgRHJ1NP+ylFgXVLRfBGq1u0+nx
	 EkaMNjBdYTAFQpCFwAsfi30gyHfi7bp0KJvLIhuwGoHN3Y1NKMiKUn7+Mwmud6hXpg
	 u3Wiu0+3HYzBnHXxu5dZ0NtFPPtx8QP8G7Y51RzD8gwgwyCC3+5lJJyzHf6oPED/pY
	 vzAWO7uw2wVMura2vsxnCxMnMB34SWSeoegqtIM4ddlvw0o1GZ/Pc2oeHIt/ZvoMSt
	 qvnzteX3sxhSQ==
Subject: Re: [PATCH net v2 9/9] bnxt_en: Re-write the BARs following any type
 of PCIe errors
From: netdev-bot+sashiko@kernel.org
To: michael.chan@broadcom.com
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com, joe@dama.to,
 kalesh-anakkur.purayil@broadcom.com, scott.branden@broadcom.com
Date: Thu, 01 Oct 2026 01:01:58 +0000
Message-ID: <179081651865.434549.15031496035757252020@kernel.org>
In-Reply-To: <20260928041712.3467803-10-michael.chan@broadcom.com>
References: <20260928041712.3467803-10-michael.chan@broadcom.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In bnxt_io_slot_reset()
  (drivers/net/ethernet/broadcom/bnxt/bnxt.c), the new sequence of…
- [Low] In bnxt_io_slot_reset()
  (drivers/net/ethernet/broadcom/bnxt/bnxt.c), only the first…

--

bnxt_en: Re-write the BARs following any type of PCIe errors

This patch makes bnxt_io_slot_reset() zero and restore the BARs after
any PCIe error, not only fatal ones, and makes the 5 second post-reset
wait unconditional. It turns off bus mastering and memory decode before
the BAR rewrite. It also moves pci_enable_device() to after
pci_restore_state(), and skips it if the device is already enabled.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index e4530b091d3b..810219d9cae2 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c

[ ... ]

> @@ -17743,65 +17741,80 @@ static pci_ers_result_t bnxt_io_slot_reset(struct pci_dev *pdev)

[ ... ]

> +	/* Upon PCIe error, our device internal logic that latches to
> +	 * BAR value is getting reset and will restore only upon
> +	 * rewriting the BARs.
> +	 *
> +	 * As pci_restore_state() does not re-write the BARs if the
> +	 * value is same as saved value earlier, driver needs to
> +	 * write the BARs to 0 to force restore.
> +	 */
> +	pci_clear_master(pdev);
> +	pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> +	cmd &= ~PCI_COMMAND_MEMORY;
> +	pci_write_config_word(pdev, PCI_COMMAND, cmd);

[Severity: Low]
Should this second PCI_COMMAND read also be checked with
PCI_POSSIBLE_ERROR()?

If this read returns 0xFFFF, cmd becomes 0xFFFD. The write then sets
PCI_COMMAND_MASTER, PCI_COMMAND_IO, SERR and parity right before
bnxt_clear_bars().

pci_clear_master() goes through __pci_set_master(), which does not check
its own read either. So nothing confirms that mastering and decode are
off before the BARs are zeroed.

pci_restore_state() restores the saved Command register afterwards, so
the bad value would only be transient. However, the same read-modify-write
on the re-enable failure path below is guarded with
!PCI_POSSIBLE_ERROR(cmd).

[ ... ]

> +	bnxt_clear_bars(pdev);
> +	pci_restore_state(pdev);
>  
> -		if (err) {
> -			dev_err(&pdev->dev, "Firmware not ready\n");
> -			goto reset_exit;
> +	if (!pci_is_enabled(pdev) && pci_enable_device(pdev)) {

[Severity: High]
Can enable_cnt still go unbalanced when bnxt_io_error_detected() took
its abort path?

Every path in bnxt_io_error_detected() that returns NEED_RESET disables
the device. So the only way to reach bnxt_io_slot_reset() with the
device still enabled seems to be the abort path, where a firmware reset
is already in progress:

bnxt_io_error_detected() {
    ...
	if (test_and_set_bit(BNXT_STATE_IN_FW_RESET, &bp->state)) {
		netdev_err(bp->dev, "Firmware reset already in progress\n");
		abort = true;
	}

	if (abort || state == pci_channel_io_perm_failure) {
		netdev_unlock(netdev);
		return PCI_ERS_RESULT_DISCONNECT;
	}
    ...
}

A sibling under the same bridge might vote NEED_RESET. That could be the
other PF, a VF, or any device below the same root port or switch. In
that case merge_result() in drivers/pci/pcie/err.c promotes the
DISCONNECT vote to NEED_RESET:

	case PCI_ERS_RESULT_DISCONNECT:
		if (new == PCI_ERS_RESULT_NEED_RESET)
			orig = PCI_ERS_RESULT_NEED_RESET;

report_slot_reset() then calls ->slot_reset() on this function too. At
that point bnxt_fw_reset_task() is still active, and nothing tells
slot_reset that it does not own recovery.

In the common case bnxt_fw_reset()->bnxt_fw_reset_close() has already
called pci_disable_device(), so enable_cnt is 0. The following sequence
then looks possible:

bnxt_io_slot_reset()
    pci_enable_device()              enable_cnt = 1
    bnxt_try_recover_fw() retry loop ...

bnxt_fw_reset_task(), ENABLE_DEV state, no netdev_lock
    pci_enable_device()              enable_cnt = 2
    pci_set_master()

bnxt_io_slot_reset()
    reset_exit:
    clear_bit(BNXT_STATE_IN_FW_RESET, &bp->state)

pci_enable_device_flags() increments enable_cnt every time:

	if (atomic_inc_return(&dev->enable_cnt) > 1)
		return 0;		/* already enabled */

The commit message says:

  "Skip re-enabling the device in bnxt_io_slot_reset() if it is already
  enabled, so enable_cnt does not go unbalanced."

Does the pci_is_enabled() check cover this case?

Before this patch, the BARs were never touched on this path, because
BNXT_STATE_PCI_CHANNEL_IO_FROZEN was only set after the abort check. Now
the decode-off, bnxt_clear_bars() and pci_restore_state() sequence also
runs here. bnxt_fw_reset_task() may be doing bar0 MMIO at the same time
in POLL_FW_DOWN, RESET_FW or POLL_FW (bnxt_fw_health_readl(),
bnxt_reset_all(), bnxt_hwrm_poll()).

Could those accesses get all-ones or UR responses, and confuse the
health status checks or raise a new AER event?

The worker's pci_enable_device() might also land between clearing
PCI_COMMAND_MEMORY and pci_restore_state(). If so, do_pci_enable_device()
would turn memory decode back on while the BARs are zero, which is the
case the commit message says this avoids:

  "Disable memory decode and bus mastering before rewriting the BARs so
  the device doesn't decode a half-updated address"

The worker's unlocked pci_set_master() read-modify-write of PCI_COMMAND
could also overwrite the update made here.

Some of this is not new with this patch. On this path slot_reset already
sent HWRM_FUNC_RESET, called bnxt_clear_int_mode(), and cleared
BNXT_STATE_IN_FW_RESET even though it never acquired that bit.

Would it be better to record the abort in bnxt_io_error_detected()?
bnxt_io_slot_reset() could then return PCI_ERS_RESULT_DISCONNECT in that
case, or serialize with or cancel bnxt_fw_reset_task(), instead of
relying on the pci_is_enabled() check.

> +		dev_err(&pdev->dev,
> +			"Cannot re-enable PCI device after reset.\n");
> +		pci_read_config_word(pdev, PCI_COMMAND, &cmd);
> +		if (!PCI_POSSIBLE_ERROR(cmd)) {
> +			cmd &= ~(PCI_COMMAND_MASTER | PCI_COMMAND_MEMORY);
> +			pci_write_config_word(pdev, PCI_COMMAND, cmd);
>  		}
> +		goto reset_exit;
> +	}
> +	pci_set_master(pdev);

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928041712.3467803-1-michael.chan%40broadcom.com
