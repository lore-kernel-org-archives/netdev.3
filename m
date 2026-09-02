Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE2338758C
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 05:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788327998; cv=none; b=S4q39VaBGTUoooEr2tNQsV5VkoqJY/3dAecRRbYaMjQQPw1gyMq+K3XXM/W5GWU23pj+OpIitHNAGfVfjf3bRylQeJKi7FuX492LISnINJ3tM0mUB5ZdqwgGcVBNvNYVZUj1dGswTrVlY+1J2NRD/4Jjl5lzNIl0ZyJRddRhfm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788327998; c=relaxed/simple;
	bh=n1mp/faEZhrMJwB1RTuE3kcDTPLcVGp1qCrrrW5ZXgk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=nVTUYDKrstnKoO1Tk8vWXcA4vtvyp/cCt7Kp6bA0UOBNtvjZF4mNaaojYI7yV8ZHcyOfrNH00K2WimTzCx6JEqckKQVDyo1a0GGQaygs9KZgT/qlL/qG9JkDjPJ/MIO/evIEpPyJ4SSMtNUB5hktj0VBOERbznrtNLw/0neA3rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJK/rN/2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJK/rN/2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80B61F00A3D;
	Wed,  2 Sep 2026 05:46:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788327997;
	bh=ECfjNVxpctrEHhsdNUR0lOgQOHiCLyIw4TPT/xkCD4I=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=VJK/rN/2fXPlywv3UjOLC42lt/n0DGGZqveU/8tJN6FMSa7P6O4HBMuTz8FPoii4s
	 H8YSazkTTG2WXK58+dsJMUvjAjrQsAXtFSEdthbBsbL8QajwnFpLWPlMnieAwJ+f0v
	 xSiLsd7YhdQNZz3MOyq6KFtYgB5b9etX+EguIWr8qBQD5DMutppaL9G4N6INTYaP/K
	 NcD6zEH7qXpnkYGCMgwpDrfksaIrYuSYmGc2gSo3Kzkzn2CLq6H0aRtrh512PBoeFd
	 i59B188EXyJJ1IHoQrRH3QrjxTRDHty86z77KrUBx9Fat4T5waaobDWN9RIRbsGB15
	 gXk87Z46eXMCg==
Subject:
 Re: [net,4/4] bnxt_en: Re-write the BARs following any type of PCIe errors
From: netdev-bot+sashiko@kernel.org
To: michael.chan@broadcom.com
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, andrew+netdev@lunn.ch,
 pavan.chebbi@broadcom.com, andrew.gospodarek@broadcom.com,
 kalesh-anakkur.purayil@broadcom.com, scott.branden@broadcom.com
Date: Wed, 02 Sep 2026 05:46:36 +0000
Message-ID: <178832799645.3394541.4912456497858745197@kernel.org>
In-Reply-To: <20260831024342.2161156-5-michael.chan@broadcom.com>
References: <20260831024342.2161156-5-michael.chan@broadcom.com>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0 (1)

- [Medium] The patch makes the BAR rewrite unconditional but leaves the
  chip-readiness workaround gated on the fatal-only bit.

Pre-existing issues:
- [Low] bnxt_io_slot_reset()
  (drivers/net/ethernet/broadcom/bnxt/bnxt.c:17578-17592) zeroes all six…

--

bnxt_en: Re-write the BARs following any type of PCIe errors

The patch makes bnxt_io_slot_reset() zero the BARs unconditionally so that
pci_restore_state() always rewrites them, instead of only doing so when
BNXT_STATE_PCI_CHANNEL_IO_FROZEN was set.  The clearing of that state bit
moves up into the existing readiness-delay test.

A couple of questions about the new ordering below.

> diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> index c3d561ac53dc..09fed8784a2a 100644
> --- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> +++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
> @@ -17564,7 +17564,7 @@ static pci_ers_result_t bnxt_io_slot_reset(struct pci_dev *pdev)
>  
>  	netdev_info(bp->dev, "PCI Slot Reset\n");
>  
> -	if (test_bit(BNXT_STATE_PCI_CHANNEL_IO_FROZEN, &bp->state)) {
> +	if (test_and_clear_bit(BNXT_STATE_PCI_CHANNEL_IO_FROZEN, &bp->state)) {
>  		/* After DPC, the chip should return CRS when the vendor ID
>  		 * config register is read until it is ready.  On all chips,
>  		 * this is not happening reliably so add a 5-second delay as a

[Severity: Medium]
The BAR rewrite becomes unconditional, but the chip-readiness delay stays
gated on the fatal-only bit.  Is that intentional?

BNXT_STATE_PCI_CHANNEL_IO_FROZEN is only set for pci_channel_io_frozen in
bnxt_io_error_detected(), yet that function returns
PCI_ERS_RESULT_NEED_RESET for non-fatal errors too, and the core then does
a real secondary bus reset before calling back:

drivers/pci/pcie/err.c:pcie_do_recovery() {
	...
	if (status == PCI_ERS_RESULT_NEED_RESET ||
	    state == pci_channel_io_frozen) {
		if (reset_subordinates(bridge) != PCI_ERS_RESULT_RECOVERED) {
	...
}

So on the non-fatal path the driver now issues bnxt_clear_bars() plus
pci_restore_state() right after a bus reset with no delay, even though the
comment just above says the chip does not reliably signal readiness after
such a reset.

If one of those BAR-clear writes does not land while the function is still
coming out of reset, the BAR still equals the saved value and the restore
is skipped:

drivers/pci/pci.c:pci_restore_config_dword() {
	...
	if (!force && val == saved_val)
		return;
	...
}

which leaves the internal BAR latch stale, MMIO reading all-ones, and the
bnxt_try_recover_fw() loop failing all BNXT_FW_SLOT_RESET_RETRY attempts
followed by "Firmware not ready" and PCI_ERS_RESULT_DISCONNECT - the same
failure mode the commit message aims to remove.  Should the readiness delay
be made unconditional along with the BAR clear, or should the rewrite be
verified with a read-back and retried?

Related: bnxt_clear_bars() discards the return value of every
pci_write_config_dword() and nothing reads the BARs back afterwards, so a
dropped write is silent:

	for (off = PCI_BASE_ADDRESS_0; off <= PCI_BASE_ADDRESS_5; off += 4)
		pci_write_config_dword(pdev, off, 0);

> @@ -17580,17 +17580,15 @@ static pci_ers_result_t bnxt_io_slot_reset(struct pci_dev *pdev)
>  			"Cannot re-enable PCI device after reset.\n");
>  	} else {
>  		pci_set_master(pdev);
> -		/* Upon fatal error, our device internal logic that latches to
> +		/* Upon PCIe error, our device internal logic that latches to
>  		 * BAR value is getting reset and will restore only upon
>  		 * rewriting the BARs.
>  		 *
>  		 * As pci_restore_state() does not re-write the BARs if the
>  		 * value is same as saved value earlier, driver needs to
> -		 * write the BARs to 0 to force restore, in case of fatal error.
> +		 * write the BARs to 0 to force restore.
>  		 */
> -		if (test_and_clear_bit(BNXT_STATE_PCI_CHANNEL_IO_FROZEN,
> -				       &bp->state))
> -			bnxt_clear_bars(pdev);
> +		bnxt_clear_bars(pdev);
>  		pci_restore_state(pdev);

[Severity: Low]
This isn't a bug introduced by this patch, since the same sequence has been
used on the fatal path since f75d9a0aa967, but the patch now makes it run on
every PCIe error recovery, so it may be a good moment to ask about the write
ordering.

bnxt_clear_bars() programs all six BAR dwords to 0 after pci_enable_device()
and pci_set_master() have already re-enabled memory decode and bus
mastering.  bnxt_io_error_detected() calls pci_disable_device(), so
enable_cnt reaches 0 and the pci_enable_device() here really does set
PCI_COMMAND_MEMORY again.  Between bnxt_clear_bars() and pci_restore_state()
the function is therefore an enabled decoder claiming a window based at 0,
and for a 64-bit BAR written one dword at a time transiently at
old_high << 32.

The PCI core takes the opposite order:

drivers/pci/pci.c:pci_restore_config_space() {
	...
	/* Restore BARs before the command register. */
	...
}

and pci_std_update_resource() clears PCI_COMMAND_MEMORY before rewriting a
memory BAR.  The other caller, bnxt_init_one(), matches that convention:

	if (is_kdump_kernel()) {
		pci_clear_master(pdev);
		pci_save_state(pdev);
		pcie_flr(pdev);
		bnxt_clear_bars(pdev);
		pci_restore_state(pdev);
	}

Would it be preferable to zero the BARs with decode disabled, i.e. before
pci_enable_device()/pci_set_master(), or to clear PCI_COMMAND_MEMORY around
bnxt_clear_bars()?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260831024342.2161156-1-michael.chan%40broadcom.com
