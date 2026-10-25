Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792971837;
	b=5NHc7+EnlBd8q98za7REadmE2keDCP0xiWbEPdUHNaZr9wmPpKoUwhNOMCUKX2OHGiFv
	 WJIJR2hqQL0nAgvWcBODIYuugiIDVLudHJs/pGxOiCM1nu6N1oWF3MqkoTjE4Mjtkt0Rc
	 KLW1FQISfNNbGrSWFEg/67XvyQIr6k0vWCviI3p6Hh0XNLMwf7tWFflvIwIs1NAd1yzlu
	 l4xd8oXzGBS/xt+ZXgjqplQkz/qUPRq6MY+NwO7YUkyfkI5dIRkI6sJgQiCA6fIIj8If5
	 tB7D6sIGMy/TW9ooYj/d7BAVIQ8/k7Z0/tG5DwJrT64wZHYZHWBj2VtJsIBoLTRH8BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792971837;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=/y9KQCuL0a6+RSTaxJj7fFGu3MHaUHqBucfT9urG8ho=;
	b=WJOHR4gebmNZCmXzVtqrYUM4FHAMze5Z+uPcDr1Y1wID4L0e/AFfuU1t8WynnAu+BhsQ
	 t8nzoQFEV7l0NPs+DZ/c0kKv9HcJFbH8Wdtj12YdkMNq9W0GpH/WOp20zD5jaLWhAVnSG
	 y8ufRWOCYekNchCbCiVxD+8vuOcmbJmuyrUChVPfn1plW306D6VRA1CaIf5KxQo64AbpF
	 AWOrFJ9+uxnYT9DOj7sBDjjIle7bKmBqpmvBvGFYaKgZjcNwLIcAjVp7Wcn66IGTc4Pln
	 +Jxa7r/6R5fhkbv24v35TA6NXBIzKn19BXVk/4tTjTg9XKb6Zw8k0+FhIsXWW9BXj/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kN6letLO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9621E606A323
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 23:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kN6letLO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 217A91F01828;
	Sun, 25 Oct 2026 23:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792971837;
	bh=/y9KQCuL0a6+RSTaxJj7fFGu3MHaUHqBucfT9urG8ho=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=kN6letLOZ1NhcJup6JCcEdZTQwuP8zaPPuJMo4yStuv9YYcfD8UGxlYPUSVQvfxJc
	 wOUESuzKt3vVoUGlrhB3bRj1e2EjxmbDjLl6pgPKTVEv5WZ+CNWdrnZ9PzsAPn1wnq
	 C14ZzgOjBd+TA5WIvHioIdi9fOyNSj+MoAlVJd+LLgdbUvKAzzkUInevfuR9TsFieh
	 Bm+uxNigX2WaTjgmCxv0AfSEjTKRkmX1mCkBO6U0hnT3iKh0eSg6EV6XjaR4KlamO+
	 eoe/C9+xkAi5/2vysxBN8YDeySNpSPA2Kpv+YTTnU1dVUNrjYtb7PNIMCnhbb7pdZ3
	 GeRexa7u6qqFw==
Subject: Re: [PATCH net v5 03/13] ice: fix PHY port restart serialization
From: netdev-bot+sashiko@kernel.org
To: jacob.e.keller@intel.com
Cc: przemyslaw.kitszel@intel.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, poros@redhat.com,
 netdev@vger.kernel.org, grzegorz.nitka@intel.com,
 aleksandr.loktionov@intel.com, alexander.nowlin@intel.com,
 anthony.l.nguyen@intel.com, maciej.machnikowski@intel.com,
 przemyslaw.korba@intel.com, sergey.temerkhanov@intel.com,
 arkadiusz.kubalewski@intel.com, richardcochran@gmail.com, horms@kernel.org
Date: Sun, 25 Oct 2026 23:43:55 +0000
Message-ID: <179297183566.3134.6646066636705775074@kernel.org>
In-Reply-To: =?utf-8?q?=3C20261021-jk-e825c-timestamp-processing-logic-fixes?=
 =?utf-8?q?-srcu-v5-3-72289a4ac8eb=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C20261021-jk-e825c-timestamp-processing-logic-fixes-?=
 =?utf-8?q?srcu-v5-3-72289a4ac8eb=40intel=2Ecom=3E?=
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

Critical: 0 · High: 0 · Medium: 1 · Low: 4

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] ice_ptp_link_change() now calls
  mutex_lock(&pf->adapter->ps_lock) on every invocation, before any PTP-…
- [Low] The commit message describes the .settime64 race the wrong way
  round.
- [Low] adapter->ps_lock now also guards writes to ice_ptp_port::link_up
  and the whole of ice_ptp_link_change(), including the SyncE/DPLL…
- [Low] The patch's link-edge handling depends on ice_ptp_link_change()
  reading pf->ptp.state inside the adapter ps_lock critical section.
- [Low] To justify replacing the per-port ps_lock with a single adapter-
  wide lock, the commit message says 'the PHY restart procedure already…

--

ice: fix PHY port restart serialization

This commit replaces the per-port ps_lock with a single adapter-wide
ps_lock. The lock is taken in ice_ptp_link_change(),
ice_ptp_restart_all_phy(), ice_ptp_init() and ice_ptp_release(), so link_up
is updated in the same critical section as the PHY start/stop. It also
moves the ICE_PTP_READY transition in ice_ptp_init() ahead of the initial
PHY restart, so link edges during init are not lost.

Closes: https://lore.kernel.org/netdev/20260916011228.1632848-1-kuba@kernel.org/

> If a PHY restart occurs concurrently with a link transition, it is possible
> that the link state read could be re-ordered such that the link transition
> would start the PHY but a concurrent restart (such as from .settime64)
> could see the old link state and decide it must stop the PHY.

[Severity: Low]
Does the race go in this direction? Before this patch,
ice_ptp_restart_all_phy() only called ice_ptp_port_phy_restart() after
checking link_up:

    if (port->link_up)
        ice_ptp_port_phy_restart(port);

A stale "down" value there only skips the port. It never issues a stop.

The inner !ptp_port->link_up check in ice_ptp_port_phy_restart() reads the
same variable later in program order. While the link is going up, it
can't see "down" after the outer check saw "up".

On the old code, the race that does look possible is the opposite one,
on link down:

CPU0 (.settime64)                 CPU1 (link down)
ice_ptp_restart_all_phy()
  port->link_up == true
  ice_ptp_port_phy_restart()
    link_up check passes
                                  ice_ptp_link_change()
                                    ptp_port->link_up = false
                                    ice_ptp_port_phy_restart()
                                      ice_ptp_port_phy_stop()
                                        lock/unlock ps_lock
    mutex_lock(&ptp_port->ps_lock)
    ice_start_phy_timer_e82x()

This leaves timestamping running on a down link.

The new adapter-wide ps_lock closes both directions, so the code change
itself looks fine. Could the commit message describe the scenario that is
actually being fixed?

> Additionally note that the PHY restart procedure already cannot run
> concurrently across two ports. The procedure requires executing timer
> commands which in turn require the PTP hardware semaphore.

[Severity: Low]
Is this accurate for E822/E823? ice_start_phy_timer_e82x() issues its
timer commands without holding ice_ptp_lock():

ice_start_phy_timer_e82x() {
    ...
    err = ice_ptp_one_port_cmd(hw, port, ICE_PTP_INIT_INCVAL);
    ...
    ice_ptp_src_cmd(hw, ICE_PTP_NOP);

    ice_ptp_exec_tmr_cmd(hw);
    ...
    err = ice_ptp_one_port_cmd(hw, port, ICE_PTP_INIT_INCVAL);
    ...
    ice_ptp_exec_tmr_cmd(hw);
    ...
    ice_ptp_exec_tmr_cmd(hw);

    err = ice_sync_phy_timer_e82x(hw, port);
    ...
}

Only the final ice_sync_phy_timer_e82x() step takes the semaphore. On
E825, ice_start_phy_timer_eth56g() does hold it around its port command.

The single adapter lock serializes more than the old per-port lock did,
so the patch doesn't depend on this claim. Could the justification in the
commit message be corrected, though?

A related point: ice_ptp_one_port_cmd() writes P_REG_TMR_CMD on every
port (NOP on the non-target ports). The clock owner's ice_ptp_tmr_cmd()
paths (adjfine/adjtime/settime) also program every port's TMR_CMD, and
they hold only the semaphore, not ps_lock. This patch did not introduce
that possible interleaving, and the old per-port lock didn't cover it
either. Whether it matters depends on how the hardware handles the timer
command sync across PFs.

> diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.h b/drivers/net/ethernet/intel/ice/ice_adapter.h
> index c61bd645e460..5cefcd7af8b3 100644
> --- a/drivers/net/ethernet/intel/ice/ice_adapter.h
> +++ b/drivers/net/ethernet/intel/ice/ice_adapter.h
> @@ -41,6 +41,7 @@ struct ice_port_list {
>   * @txq_ctx_lock: Spinlock protecting access to the GLCOMM_QTX_CNTX_CTL register
>   * @cpi_phy_lock: Per-PHY mutex serializing CPI REQ/ACK transactions.
>   *               Index 0 = PHY0, index 1 = PHY1. Used on E825C devices.
> + * @ps_lock: Mutex to serialize PHY port start/stop across adapter.

[Severity: Low]
This isn't a bug, but should this description cover everything the lock
now protects? After this patch, ps_lock also guards writes to
ice_ptp_port::link_up and the whole of ice_ptp_link_change(). That
includes the SyncE/DPLL reconfiguration and ice_txclk_update_and_notify().

The @link_up kernel-doc in ice_ptp.h still just says "indicates whether
the link is up". It doesn't say that writers hold adapter->ps_lock, or
that lockless readers such as ice_ptp_process_tx_tstamp() use READ_ONCE().

Also, ice_ptp_port_phy_stop(), ice_ptp_port_phy_restart() and
ice_ptp_restart_all_phy() all gained a Context: line. ice_ptp_link_change()
now takes ps_lock unconditionally, but its kernel-doc has no "Context:
acquires the adapter ps_lock" line.

[ ... ]

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 55241802d17a..7a1deb3ea212 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c

[ ... ]

> @@ -1309,17 +1309,14 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
>  	struct ice_ptp_port *ptp_port;
>  	struct ice_hw *hw = &pf->hw;
>  
> -	if (pf->ptp.state != ICE_PTP_READY)
> -		return;
> -
>  	ptp_port = &pf->ptp.port;
>  
> -	/* Update cached link status for this port immediately */
> -	ptp_port->link_up = linkup;
> +	mutex_lock(&pf->adapter->ps_lock);

[Severity: Medium]
Can this dereference a freed ice_adapter during device removal? Before
this patch, ice_ptp_link_change() returned early once ice_ptp_release()
had moved the state away from ICE_PTP_READY, and it never touched
pf->adapter. Now the mutex is taken before any state check.

In ice_remove(), the adapter reference is dropped before the service task
is synchronously stopped:

ice_remove()
    ice_unload(pf);           <- PTP torn down via ice_ptp_release()
    ice_deinit(pf);           <- only sets ICE_SERVICE_DIS
    ice_vsi_release_all(pf);
    ...
    ice_adapter_put(pdev);    <- may kfree() the adapter
    ice_deinit_hw(&pf->hw);
    ice_deinit_dev(pf);       <- ice_service_task_stop()->cancel_work_sync()

The ice_probe() unroll path uses the same order:

unroll_adapter:
	ice_adapter_put(pdev);
unroll_hw_init:
	ice_deinit_hw(hw);
	if (need_dev_deinit)
		ice_deinit_dev(pf);

Suppose a service task is already in ice_link_event() and has passed the
ice_get_main_vsi() check when removal runs through ice_adapter_put(), and
this PF held the last adapter reference. Wouldn't the task then reach:

ice_service_task()
  ice_clean_adminq_subtask()
    ...
      ice_link_event()
        ice_ptp_link_change()
          mutex_lock(&pf->adapter->ps_lock);

on an adapter that ice_adapter_free() has already passed to mutex_destroy()
and kfree()?

The teardown ordering predates this patch, but the patch adds a new
unconditional adapter access on this path.

[ ... ]

> @@ -3419,14 +3414,16 @@ void ice_ptp_init(struct ice_pf *pf)
>  	if (err)
>  		goto err_release_tx_tracker;
>  
> -	/* Start the PHY timestamping block */
> -	ice_ptp_reset_phy_timestamping(pf);
> -
>  	/* Configure initial Tx interrupt settings */
>  	ice_ptp_cfg_tx_interrupt(pf);
>  
>  	ptp->state = ICE_PTP_READY;
>  
> +	/* (Re)start the PHY timestamping block */
> +	mutex_lock(&pf->adapter->ps_lock);
> +	ice_ptp_port_phy_restart(&ptp->port);
> +	mutex_unlock(&pf->adapter->ps_lock);

[Severity: Low]
Should the ICE_PTP_READY store happen under ps_lock? The link-edge
reasoning in the commit message relies on ice_ptp_link_change() reading
pf->ptp.state inside the ps_lock critical section. Here, though, the
store is a plain write made before mutex_lock().

If a link event already holds ps_lock when this store happens,
ice_ptp_link_change() can see READY through a plain load:

    if (pf->ptp.state != ICE_PTP_READY || pf->hw.reset_ongoing)
        goto out_unlock;

Nothing pairs that load (no release/acquire) with the earlier
initialization writes (pf->ptp.kworker, ov_work, the Tx tracker). It then
goes on into ice_ptp_port_phy_restart(), which on E822 calls
kthread_queue_delayed_work(pf->ptp.kworker, ...).

In practice the window is very small, and both outcomes described in the
commit message are handled correctly. It is still a plain-access data
race that KCSAN could report.

Would it make the ordering explicit to set the state to READY inside the
ps_lock section just before the initial restart, or to use
smp_store_release()/smp_load_acquire()?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261021-jk-e825c-timestamp-processing-logic-fixes-srcu-v5-0-72289a4ac8eb%40intel.com
