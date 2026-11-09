Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794220426;
	b=zQNHHoFnR/wGued8+3dOYxw6w/E2p1Uoz5PM543lqF7YxIAHLq56zd2kg9q12aW3ewm4
	 /Ng3JQt2GmlBdWAex4pHRKg4QOVEx2zywDjre1xtQlpmu9ETvRtTjdFD45+Gdcmo5J8OK
	 b9emCobuOwFRx0r7GA8ju9HLpAfn1vHEJZUuvLUKKlm3y+FwCJmkfssYua4d0QDT1Yxjo
	 MxSsKm8dFs84FVWAZ6dLkJmjpzLCn/tLr54EISOWB7jGX6nrZsuyMeVBjP2SePVrkQI9s
	 JNh6PUoiPqhJq1FrznjP1vi6tfXweKeAN+CQ0KWW7QQqtZ0OCbGn3V+Kn2uLRlDpqVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794220426;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=VRrPkVXdrF4F4ZQHVBYtdU9kJYRffolcAoStU51ARY0=;
	b=sToIKqpQ5RugLm6gtrpKZitLXw9Ea7HsMnoYmnMYOp5CwRVi80DlwpD5uuyUT94DlM9d
	 cWnpec41SqqU7LoB605w61rHp/ATzADyIXdIM6eRBie8C2A/w8EIDGe8ZK6X1857UOzg0
	 869zUb4v3SOgpcb+RgsIaZNtes6uzWPmMQ/QIfK81dw2dPgxfRnWGBaL39or2kZCO9Lnb
	 91AX08jLjH204a9G2jEsAeTX43xuLzjgPdnDMsz9EZqi+1A5rryzLnzfUbGF3YoSZo1kI
	 JbTbgjNMtTYhgHAasWtEodYely20FyhBMBItU3mwaKTr8u9X+LX7odm+n3sW/oXB4ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bd6GdokD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6B8C606A31C
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 10:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bd6GdokD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD5E81F0089F;
	Mon,  9 Nov 2026 10:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794220425;
	bh=VRrPkVXdrF4F4ZQHVBYtdU9kJYRffolcAoStU51ARY0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Bd6GdokDOg0fr92ciNihq3ZNQ1ney4lla5Q6zpGt1/DhRUA/FsTF/fGRR8Mg84Uw+
	 18ZPQkqKni+7xrTyKAjDSZk1s002P1cm/qrbn+fD7FrmyN0Zqf3rHCdEFS9+boepsN
	 uYa63yGCeNiIr/ATnuYVXdLaKyukg/WGs5F7SuOAg43KAtVnpV5Cdh5u1fA5H4fX9p
	 GUxOMgmqWEqg8J2xa+k/hdMdfHXra3eoraD75ITlM3R7CpAg2z6AsNkQWfM1wbiMHe
	 uZEkUXeJYvzW8hNz6Ea+7Bdleg738UVSsua2HXIkODKg/BUKhBdGC1YLCL4A2Oe9a1
	 xa0UhmTkguanA==
Subject:
 Re: [PATCH net] net: wwan: iosm: Re-bind the driver around system suspend too
From: netdev-bot+sashiko@kernel.org
To: zevpaneth@gmail.com
Cc: loic.poulain@oss.qualcomm.com, ryazanov.s.a@gmail.com,
 johannes@sipsolutions.net, mail@maciej.szmigiero.name, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org
Date: Mon, 09 Nov 2026 10:33:44 +0000
Message-ID: <179422042429.994134.17042297165807075263@kernel.org>
In-Reply-To: <20261105102009.34534-1-zevpaneth@gmail.com>
References: <20261105102009.34534-1-zevpaneth@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 5 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 4 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The commit message rests on a premise the code contradicts:
  that "the driver keeps the device in D0" during s2idle.
- [Medium] pm_notify() now unbinds and re-binds the driver on
  PM_SUSPEND_PREPARE/PM_POST_SUSPEND with no conditions.
- [Medium] Because the driver is unbound at PM_SUSPEND_PREPARE, which
  suspend_prepare() sends before devices suspend and before processes…
- [Medium] The commit message says the device is "re-initialized from
  scratch on resume, exactly as it is at boot", but nothing resets the…
- [Low] After this patch the driver is unbound before every system-sleep
  transition: suspend (via PM_SUSPEND_PREPARE, sent for every state from…

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but the patch
  makes it reachable on every suspend.

--

net: wwan: iosm: Re-bind the driver around system suspend too

This commit extends pm_notify() in the iosm driver. The PCI driver is now
unregistered on PM_SUSPEND_PREPARE and re-registered on PM_POST_SUSPEND,
in addition to the existing hibernation and restore events. The goal is to
recover a modem that comes back in its boot ROM stage after a long s2idle
cycle by re-probing it from scratch on resume.

> On some platforms the modem loses power during suspend-to-idle even
> though the driver keeps the device in D0 and its s2idle resume path
> only sends a wake-up command.

[Severity: Medium]
Is the "keeps the device in D0" part accurate?

With the driver bound and the D0L1.2 BIOS setting, ipc_pcie_suspend_cb()
calls ipc_pcie_suspend_s2idle(), which only does this:

drivers/net/wwan/iosm/iosm_ipc_pcie.c:ipc_pcie_suspend_s2idle() {
	ipc_cp_irq_sleep_control(ipc_pcie, IPC_MEM_DEV_PM_FORCE_SLEEP);
	...
	set_bit(0, &ipc_pcie->suspend);
	...
	ipc_imem_pm_s2idle_sleep(ipc_pcie->imem, true);
}

Nothing in drivers/net/wwan/iosm/ calls pci_save_state(), and
SIMPLE_DEV_PM_OPS() provides no .suspend_noirq. So pci_pm_suspend_noirq()
falls through to pci_pm_suspend_noirq_common() with state_saved clear:

drivers/pci/pci-driver.c:pci_pm_suspend_noirq_common() {
	if (!pci_dev->state_saved) {
		pci_save_state(pci_dev);
		...
		if (!pci_dev->skip_bus_pm && pci_power_manageable(pci_dev))
			pci_prepare_to_sleep(pci_dev);
	}
	...
}

pci_prepare_to_sleep() then picks D3hot or a platform state for the
modem, possibly D3cold through ACPI.

If the PCI core already moves the modem out of D0 on the D0L12 s2idle
path, could that be what cuts modem power on the test platform?

If so, would it be a more targeted fix to keep the device in D0 for the
D0L12 case (for example by saving PCI state in the suspend callback to
opt out of bus PM) instead of unbinding the driver on every suspend?

> diff --git a/drivers/net/wwan/iosm/iosm_ipc_pcie.c b/drivers/net/wwan/iosm/iosm_ipc_pcie.c
> index 49052eb511baa..ebd4c45e1f4e5 100644
> --- a/drivers/net/wwan/iosm/iosm_ipc_pcie.c
> +++ b/drivers/net/wwan/iosm/iosm_ipc_pcie.c
> @@ -534,12 +534,14 @@ void ipc_pcie_kfree_skb(struct iosm_pcie *ipc_pcie, struct sk_buff *skb)
>  
>  static int pm_notify(struct notifier_block *nb, unsigned long mode, void *_unused)
>  {
> -	if (mode == PM_HIBERNATION_PREPARE || mode == PM_RESTORE_PREPARE) {
> +	if (mode == PM_HIBERNATION_PREPARE || mode == PM_RESTORE_PREPARE ||
> +	    mode == PM_SUSPEND_PREPARE) {
>  		if (pci_registered) {
>  			pci_unregister_driver(&iosm_ipc_driver);
>  			pci_registered = false;
>  		}

[Severity: Medium]
Should this be limited to the affected platforms or suspend states?

suspend_prepare() sends PM_SUSPEND_PREPARE for every suspend state:

kernel/power/suspend.c:suspend_prepare() {
	...
	error = pm_notifier_call_chain_robust(PM_SUSPEND_PREPARE, PM_POST_SUSPEND);
	...
}

Nothing here checks pm_suspend_target_state, ipc_pcie->d3l2_support or
the platform. So every iosm device (7360 and 7560) on every platform now
goes through pci_unregister_driver()->ipc_pcie_remove()->
ipc_imem_cleanup() on each s2idle, S3 or standby entry:

	if (test_and_clear_bit(FULLY_FUNCTIONAL, &ipc_imem->flag)) {
		ipc_mux_deinit(ipc_imem->mux);
		ipc_debugfs_deinit(ipc_imem);
		ipc_wwan_deinit(ipc_imem->wwan);
		ipc_port_deinit(ipc_imem->ipc_port);
	}

That destroys the wwan netdevs, hangs up open AT/MBIM port fds, tears
down devlink and drops the data session. The roughly 50 second reconnect
follows.

Commit 0b6f6593aa8c, which this patch builds on, says it was "Tested on
XMM7360 in HP EliteBook 855 G7 both with s2idle (which uses the existing
suspend / resume handlers)". So at least that configuration worked with
s2idle before this change.

Would the DMI quirk mentioned in the commit message be the safer default?

[Severity: Medium]
What happens to the modem during system suspend once it has no driver?

The unbind happens at PM_SUSPEND_PREPARE, before dpm_suspend(). So
dev->driver is NULL when the PCI core suspends the device, and
pci_pm_suspend_noirq() takes this branch:

drivers/pci/pci-driver.c:pci_pm_suspend_noirq() {
	...
	if (!pm) {
		pci_save_state(pci_dev);
		goto set_unknown;
	}
	...
}

This skips pci_pm_suspend_noirq_common() entirely. As far as I can tell,
that means:

- The driver's own sleep handshake no longer runs. Neither the D0L12
  IPC_MEM_DEV_PM_FORCE_SLEEP doorbell plus ipc_imem_pm_s2idle_sleep()
  nor the D3L2 ipc_pcie_suspend() is called. The only thing sent to the
  modem is the IPC_MEM_DEVICE_IPC_UNINIT doorbell from
  ipc_imem_device_ipc_uninit().

- The endpoint is never put into D3 and wake/PME is never armed, because
  pci_prepare_to_sleep() is where device_may_wakeup() is honored. So
  modem-initiated wakeup cannot work.

- The endpoint no longer sets bus->self->skip_bus_pm. The root port may
  then enter D3hot/D3cold while the endpoint is still in D0 and its CP
  has not been force-slept.

Could this raise suspend power or hurt S0ix residency on platforms where
the modem used to survive s2idle?

[Severity: Low]
This isn't a bug, but with PM_SUSPEND_PREPARE added the driver is now
unbound before every system sleep transition. As a result the
iosm_ipc_pm table can no longer be reached:

static SIMPLE_DEV_PM_OPS(iosm_ipc_pm, ipc_pcie_suspend_cb, ipc_pcie_resume_cb);

The same goes for ipc_pcie_suspend_s2idle()/ipc_pcie_resume_s2idle(),
ipc_pcie_suspend()/ipc_pcie_resume(), the suspend bit checked in the IRQ
path, and the d3l2_support value that ipc_pcie_read_bios_cfg() reads at
probe. The BIOS D0L1.2/D3L2/Disabled setting no longer changes anything.

Should these callbacks be removed, or at least documented as unused?

The kernel-doc for ipc_pcie_suspend()/ipc_pcie_resume() in
iosm_ipc_pcie.h calls them runtime PM callbacks. That was already wrong,
and now it describes functions that nothing can call.

[Severity: High]
This isn't a bug introduced by this patch, but the patch makes an existing
use-after-free in the teardown path reachable on every suspend.

In MUX_AGGREGATION mode (7560), the UL encode paths in
ipc_imem_handle_irq() and ipc_mux_tq_ul_trigger_encode() arm
ipc_imem->adb_timer with a 500 us timeout. Nothing on the teardown path
cancels it. ipc_imem_cleanup() only does:

	hrtimer_cancel(&ipc_imem->td_alloc_timer);
	hrtimer_cancel(&ipc_imem->tdupdate_timer);
	hrtimer_cancel(&ipc_imem->fast_update_timer);
	hrtimer_cancel(&ipc_imem->startup_timer);

It then calls ipc_mux_deinit(), which frees the mux without clearing
ipc_imem->mux. The imem_config_fail error path in ipc_imem_init() also
leaves adb_timer pending.

If adb_timer is still pending at that point:

ipc_imem_adb_timer_cb()
  ipc_task_queue_send_task()
    ipc_imem_tq_adb_timer_cb()
      ipc_mux_ul_adb_finish(ipc_imem->mux)   <- freed mux

ipc_mux_ul_adb_finish() reads ul_adb from the freed mux and writes the
sequence and accounting fields. It can also call
ipc_imem_td_update_timer_start(), which re-arms tdupdate_timer after it
was cancelled. That timer can then fire after ipc_pcie_deinit() has done
kfree(ipc_pcie->imem).

If adb_timer fires after ipc_task_deinit() and kfree(ipc_imem->ipc_task),
ipc_task_queue_send_task() touches the freed task as well.

Before this patch the teardown ran only on rmmod or hibernation. Now
pm_notify() runs it from suspend_prepare() on every s2idle/S3 entry,
before processes are frozen, so UL traffic can still be arming adb_timer
while the driver is unbound.

Should ipc_imem_cleanup() also cancel adb_timer before ipc_mux_deinit()?

> -	} else if (mode == PM_POST_HIBERNATION || mode == PM_POST_RESTORE) {
> +	} else if (mode == PM_POST_HIBERNATION || mode == PM_POST_RESTORE ||
> +		   mode == PM_POST_SUSPEND) {
>  		if (!pci_registered) {
>  			int ret;

[Severity: Medium]
The commit message says the device is "re-initialized from scratch on
resume, exactly as it is at boot". Does that hold when the modem keeps
power?

That covers platforms where the modem survives s2idle, short s2idle
cycles on the affected platform, and PM_POST_SUSPEND after a suspend
that was aborted before platform sleep.

Nothing on this path resets the modem: no FLR, PERST, _RST or cold
reset. Re-probe then finds the CP still in RUN and depends on the UNINIT
handshake done at unbind time in ipc_imem_device_ipc_uninit():

	if (ipc_pcie_check_data_link_active(ipc_imem->pcie)) {
		ipc_doorbell_fire(ipc_imem->pcie, IPC_DOORBELL_IRQ_IPC,
				  IPC_MEM_DEVICE_IPC_UNINIT);
		...
		while ((ipc_state <= IPC_MEM_DEVICE_IPC_DONT_CARE) &&
		       (ipc_state != IPC_MEM_DEVICE_IPC_UNINIT) &&
		       (timeout > 0)) {

This handshake is skipped if the link is not active. It waits at most
about 30 ms and returns void, so an incomplete handshake goes unnoticed.

On re-bind, ipc_imem_config() requires the UNINIT state for the
PSI/EBL/RUN phases:

		if (ipc_imem->ipc_requested_state ==
		    ipc_mmio_get_ipc_state(ipc_imem->mmio)) {
			ipc_imem_ipc_init_check(ipc_imem);

			return 0;
		}
		dev_err(ipc_imem->dev,
			"ipc_status(%d) != IPC_MEM_DEVICE_IPC_UNINIT",
		...
	return -EIO;

If the state is anything else, probe fails. pci_register_driver() still
returns 0 in that case, so pm_notify() sets pci_registered = true with
no device bound.

Could this leave the modem unusable after resume until a manual rebind
or a reboot?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261105102009.34534-1-zevpaneth%40gmail.com
