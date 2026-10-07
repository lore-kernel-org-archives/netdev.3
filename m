Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB5640F8EB
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 20:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791405892; cv=none; b=kDREjeNRKlLSD8820qWcGkMJQUvyzB7u786KGIcwicdrQFmqk6D2YmU/TEeefUI/Ab0z1CNLcHgQVrNy5F1zdVV2tKcd7q8ZRAgnJS4ZS+jpWpNUXKfVbBvEUsGwETbpC7DkmzzRM14KVdKZeE415NBJsjBhKyudpUOllyGB3Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791405892; c=relaxed/simple;
	bh=nVUG3CfwfFh8ma+1+Qp71C56zwdNFKUy5H2tt/zKSZ8=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HG8iuvAP0+mw5mx3fGmMq7zwfebMtqmWnseJ/ihYeiL29Nbkl5wYSBjzAs9+XLu3QW62K63a1BGWo0RX0FVWnMR/VHB1deG+I1hqjUmiwiMWRzFXqCmK6rOTyR3cIhJ7uaDUmM3nlf0NRvSJPjkXXixXH3J/TegHKx9Gn0qLBnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IbUPS7Dd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IbUPS7Dd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B781F00893;
	Wed,  7 Oct 2026 20:44:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791405890;
	bh=JA/2y4SkOHLVOXbitUWaPpm/b9AuRgBVSRSEU7G+v4Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=IbUPS7DdcBLmOcbk0HR51DOIDoDRUYTLzOMbZKHaLf0pHkwPgPSvzc1trYkr/mLtr
	 CKOfEpurPlYf6SJOkGU2rVn6r1AqjlF7z9TH3DPzmr6aoktJ7f4W2zZ7tHXVZoWirG
	 lqfNmbJ1WtkWNJXJ5MHTTnMQEklrVtsV7GiMCJtzHQ2VU6Z4gb43hFfU9qoMHSdLbc
	 jFFYOo11pN4GQxv/VnGCXv/z46y/2RkHW1N52Z3US6skht7pq2xlF7mvz1BkuuYczX
	 6ZJXQcLmf6qg3Ls/6BZS+0V6gKddi/+uJbzUDrwAxsoixz/00egRRsbH1xfl9hB6ED
	 A0RD7/Yjp6qNQ==
Subject: Re: [PATCH net v3 3/3] bnxt_en: Re-write the BARs following any type
 of PCIe errors
From: netdev-bot+sashiko@kernel.org
To: michael.chan@broadcom.com
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com, joe@dama.to,
 kalesh-anakkur.purayil@broadcom.com, scott.branden@broadcom.com
Date: Wed, 07 Oct 2026 20:44:49 +0000
Message-ID: <179140588930.434549.1428495142918433704@kernel.org>
In-Reply-To: <20261005204246.3822563-4-michael.chan@broadcom.com>
References: <20261005204246.3822563-4-michael.chan@broadcom.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The new guard `if (!pci_is_enabled(pdev) &&
  pci_enable_device(pdev))` is a non-atomic check-then-act.
- [Medium] In bnxt_io_slot_reset()
  (drivers/net/ethernet/broadcom/bnxt/bnxt.c), the slot-reset handler…
- [Medium] The commit says it disables memory decode and bus mastering
  before rewriting the BARs 'so the device doesn't decode a half-updated…

--

bnxt_en: Re-write the BARs following any type of PCIe errors

With this patch, bnxt_io_slot_reset() zeroes and restores the BARs after
every kind of PCIe error, not only fatal ones, and the 5 second wait after
the reset is now unconditional. Memory decode and bus mastering are turned
off while the BARs are rewritten, and pci_enable_device() is deferred until
after the restore. pci_enable_device() in both bnxt_io_slot_reset() and
bnxt_fw_reset_task() is now guarded by pci_is_enabled().

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index 9ea7e172787e2..5bd817479d642 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -15547,7 +15547,7 @@ static void bnxt_fw_reset_task(struct work_struct *work)
>  		if (test_and_clear_bit(BNXT_STATE_FW_ACTIVATE_RESET, &bp->state) &&
>  		    !test_bit(BNXT_STATE_FW_ACTIVATE, &bp->state))
>  			bnxt_dl_remote_reload(bp);
> -		if (pci_enable_device(bp->pdev)) {
> +		if (!pci_is_enabled(bp->pdev) && pci_enable_device(bp->pdev)) {

[Severity: High]

The commit message says bnxt_fw_reset_task() may be re-enabling the device
at the same time as bnxt_io_slot_reset(), and that this guard keeps
enable_cnt balanced. Is the check-then-enable atomic with respect to
bnxt_io_slot_reset()?

In the ENABLE_DEV state, bnxt_fw_reset_task() holds neither netdev_lock
nor any other lock that bnxt_io_slot_reset() takes. So both contexts can
see pci_is_enabled() == 0 before either one reaches the increment:

drivers/pci/pci.c:pci_enable_device_flags() {
    ...
	pci_update_current_state(dev, dev->current_state);

	if (atomic_inc_return(&dev->enable_cnt) > 1)
		return 0;		/* already enabled */
    ...
}

pci_update_current_state() does a config read before the increment, so
the window is wider than it looks.

If both callers get into pci_enable_device(), enable_cnt ends up at 2.
bnxt_io_error_detected(), bnxt_fw_reset_close() and bnxt_cleanup_pci()
each drop a single reference, behind a pci_is_enabled() check:

	if (pci_is_enabled(bp->pdev))
		pci_disable_device(bp->pdev);

drivers/pci/pci.c:pci_disable_device() {
    ...
	if (atomic_dec_return(&dev->enable_cnt) != 0)
		return;
    ...
}

In that case do_pci_disable_device() never runs. Can bus mastering then
stay on while bnxt_free_ctx_mem() and bnxt_free_mem() free DMA memory? Can
the device also stay enabled after unbind?

One way to reach this: bnxt_io_error_detected() returns DISCONNECT because
BNXT_STATE_IN_FW_RESET is already set. A sibling function then votes
NEED_RESET, merge_result() upgrades the result, and slot_reset is still
delivered to this PF while fw_reset_task is active.

Do the two recovery flows need real serialization instead? Some options:
take netdev_lock around ENABLE_DEV, cancel or flush fw_reset_task, or skip
slot_reset recovery when error_detected aborted.

[ ... ]

> @@ -17608,10 +17608,8 @@ static pci_ers_result_t bnxt_io_error_detected(struct pci_dev *pdev,
>  	 * so we disable bus master to prevent any potential bad DMAs before
>  	 * freeing kernel memory.
>  	 */
> -	if (state == pci_channel_io_frozen) {
> -		set_bit(BNXT_STATE_PCI_CHANNEL_IO_FROZEN, &bp->state);
> +	if (state == pci_channel_io_frozen)
>  		bnxt_fw_fatal_close(bp);
> -	}

[Severity: Medium]

BNXT_STATE_PCI_CHANNEL_IO_FROZEN was only set on the path where
bnxt_io_error_detected() actually quiesced the device. Once it is gone,
how does bnxt_io_slot_reset() know whether error_detected took ownership?

Earlier in bnxt_io_error_detected(), this happens when a firmware reset is
already in progress:

	if (test_and_set_bit(BNXT_STATE_IN_FW_RESET, &bp->state)) {
		netdev_err(bp->dev, "Firmware reset already in progress\n");
		abort = true;
	}

	if (abort || state == pci_channel_io_perm_failure) {
		netdev_unlock(netdev);
		return PCI_ERS_RESULT_DISCONNECT;
	}

That path returns without calling __bnxt_close_nic(),
bnxt_fw_fatal_close() or pci_disable_device().

Suppose a sibling function under the same bridge, such as the other PF of
a dual-port adapter, votes NEED_RESET. merge_result() then upgrades the
result:

drivers/pci/pcie/err.c:merge_result() {
    ...
	case PCI_ERS_RESULT_DISCONNECT:
		if (new == PCI_ERS_RESULT_NEED_RESET)
			orig = PCI_ERS_RESULT_NEED_RESET;
    ...
}

report_slot_reset() then calls bnxt_io_slot_reset() on this PF anyway.

bnxt_io_slot_reset() now always clears master and memory decode, zeroes
the BARs and calls pci_restore_state(). The device is still enabled, so
the new pci_is_enabled() guard skips the enable and execution continues.
bnxt_try_recover_fw(), bnxt_hwrm_func_reset(), bnxt_ulp_irq_stop() and
bnxt_clear_int_mode() all run, and BNXT_STATE_IN_FW_RESET is cleared,
while bnxt_fw_reset_task() still owns the device.

Before this patch the BARs were not rewritten on this path. Going by the
commit message, MMIO returned all-ones and recovery stopped at "Firmware
not ready".

Now it can return PCI_ERS_RESULT_RECOVERED, which leads to
bnxt_io_resume()->bnxt_open(). Meanwhile the OPENING state in
bnxt_fw_reset_task() may also call bnxt_open(). It can also take rtnl
there and then block on the netdev_lock that slot_reset holds.

Should error_detected record whether it quiesced the device, so that
slot_reset can bail out in the abort case (or cancel or flush
fw_reset_task)?

[ ... ]

> @@ -17641,65 +17639,80 @@ static pci_ers_result_t bnxt_io_slot_reset(struct pci_dev *pdev)

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
>  

[ ... ]

> +	bnxt_clear_bars(pdev);
> +	pci_restore_state(pdev);

[Severity: Medium]

According to the commit message, decode and bus mastering are turned off
here "so the device doesn't decode a half-updated address". The commit
message also expects bnxt_fw_reset_task() to run at the same time. Does
the guarantee still hold in that case?

The ENABLE_DEV state in bnxt_fw_reset_task() shares no lock with
bnxt_io_slot_reset(), and it does this:

		if (!pci_is_enabled(bp->pdev) && pci_enable_device(bp->pdev)) {
			...
		}
		pci_set_master(bp->pdev);
		bp->fw_reset_state = BNXT_FW_RESET_STATE_POLL_FW;
		fallthrough;

pci_enable_device() can set PCI_COMMAND_MEMORY, and pci_set_master() sets
PCI_COMMAND_MASTER.

Suppose that lands after the PCI_COMMAND_MEMORY clear above but before
pci_restore_state() finishes. Wouldn't the function then decode memory
with the BARs zeroed by bnxt_clear_bars()? It would keep decoding while
the BARs are rewritten one dword at a time:

drivers/pci/pci.c:pci_restore_config_space() {
    ...
		pci_restore_config_space_range(pdev, 10, 15, false);
		/* Restore BARs before the command register. */
		pci_restore_config_space_range(pdev, 4, 9, false);
		pci_restore_config_space_range(pdev, 0, 3, false);
    ...
}

For a 64-bit BAR, the upper dword could be correct while the lower dword
is still zero, with bus master enabled.

The reverse can also happen. The POLL_FW_DOWN and POLL_FW states read
BAR0 through bnxt_fw_health_readl() and bnxt_hwrm_poll() without
netdev_lock. If those reads land while slot_reset has decode turned off,
would they get Unsupported Request completions and all-ones data that the
reset state machine reads as firmware status?

The new pci_is_enabled() checks only change enable_cnt bookkeeping. They
don't order the Command register and BAR writes between the two paths.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261005204246.3822563-1-michael.chan%40broadcom.com
