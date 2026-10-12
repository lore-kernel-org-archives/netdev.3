Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55913DAC13
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 23:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791846924; cv=none; b=HOB8O0UkwmVK6bUCLOTj3vvAisfdmfrRhaLQTMi0TnuF2YZJofgrz8jO3Uw/5sBNynlvM4EqNrzV2MjhkgZKKqN1djrRXaBiooHydPCCJyQGFwl8C1KdBsrQgY43qzpzQpdDXUmWh4yGzp1Odd+zbZp61Joxpvyo3XW8kbhGpRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791846924; c=relaxed/simple;
	bh=Bk5O0q10dOQ9CZtvoZtTW5n0HaLFIVFyk6c/lxUV0Ek=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Fhy6ozSr4US9u32MWvXlclF124zL8PPn6CiBLwKTqNa5DOy4lf/El26tsgpnoTbKyW6e9mp0S0KEqufrkF9J6buuMr0NA+4uw+9ztoUhdYOyA3Taw5FwrFvmGtTHZF2qYupHdS0WZ2swhj7YSXcPcW4FQfNZEfOKxRwCpN4UTU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQPwv4eF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQPwv4eF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 831461F008A1;
	Mon, 12 Oct 2026 23:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791846922;
	bh=a14lELD4RyfmHkArcNbxBF6DqVsYA+YjHLEMmtfAGrA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MQPwv4eF34Vrs9D20ZxRM3pE+EMDznx/cT83Zhu/fhIPQ2DcTGsMM3RxYsuKUENz4
	 pFeaD1CU+AQvd1AWzbWrAhzE3LdNXW9xPAfV5h7feKH4DqCX7VSlNjj/8lAFaxd2hN
	 OaCJ32cxULMAwAlemlALvHCY+nly6wIpLtSPHEpn2pVKn7ZmnT88nfbaFMwfAQp2qt
	 /LUpwcEd1TjFpJCt3Tit252LIFIS8X1gFzMZzcO2aC4CDUR7Cmrl6E0bZL5XwcZb2O
	 NiseQr8uEvoD6oItjRPzzzPl4oy08o0C7OurEOJgvSzaSnMF9tZcocSGsxAw0BSEXa
	 ghWu1XGyS/1LA==
Subject: Re: [PATCH net v2 03/15] ice: fix PHY port restart serialization
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 maciej.machnikowski@intel.com, jacob.e.keller@intel.com,
 przemyslaw.korba@intel.com, grzegorz.nitka@intel.com,
 sergey.temerkhanov@intel.com, arkadiusz.kubalewski@intel.com,
 poros@redhat.com, richardcochran@gmail.com, horms@kernel.org,
 pmenzel@molgen.mpg.de, aleksandr.loktionov@intel.com,
 alexander.nowlin@intel.com
Date: Mon, 12 Oct 2026 23:15:21 +0000
Message-ID: <179184692111.434549.8926605466860924920@kernel.org>
In-Reply-To: <20261008215614.1987250-4-anthony.l.nguyen@intel.com>
References: <20261008215614.1987250-4-anthony.l.nguyen@intel.com>
X-sashiko-severity: High
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

Critical: 0 · High: 1 (2) · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] net: ice: UAF/NULL deref of PTP kworker on error path during PHY
  restart

Pre-existing issues:
- [High] On E822 (ICE_MAC_GENERIC), ice_ptp_port_phy_restart() can call
  kthread_queue_delayed_work(pf->ptp.kworker, &ptp_port->ov_work, 0)…
- [High] ice_ptp_link_change() checks `pf->ptp.state != ICE_PTP_READY`
  (line 1308) before it takes adapter->ps_lock (line 1313), and does not…

--

ice: fix PHY port restart serialization

This commit replaces the per-port ps_lock with one mutex for the whole
adapter. The mutex is taken in ice_ptp_restart_all_phy(),
ice_ptp_link_change(), ice_ptp_init() and ice_ptp_release(), and the
stop/restart helpers now assert that it is held. The cached link_up field
is now written in the same critical section as the PHY restart.

Closes: https://lore.kernel.org/netdev/20260916011228.1632848-1-kuba@kernel.org/

> diff --git a/drivers/net/ethernet/intel/ice/ice_ptp.c b/drivers/net/ethernet/intel/ice/ice_ptp.c
> index 94a66e9d8c05d..adc5308baefce 100644
> --- a/drivers/net/ethernet/intel/ice/ice_ptp.c
> +++ b/drivers/net/ethernet/intel/ice/ice_ptp.c

[ ... ]

> @@ -1310,12 +1310,13 @@ void ice_ptp_link_change(struct ice_pf *pf, bool linkup)
>  
>  	ptp_port = &pf->ptp.port;
>  
> -	/* Update cached link status for this port immediately */
> +	mutex_lock(&pf->adapter->ps_lock);
> +
>  	ptp_port->link_up = linkup;

[Severity: High]
This is a pre-existing issue, but now that ps_lock is taken here, should
ice_ptp_link_change() check ICE_PTP_READY again after mutex_lock()?

Right now the state is only checked before the lock is taken:

    if (pf->ptp.state != ICE_PTP_READY)
        return;

    ptp_port = &pf->ptp.port;

    mutex_lock(&pf->adapter->ps_lock);

ice_ptp_release() does three things in order. It sets the state to
ICE_PTP_UNINIT, it takes and drops ps_lock around ice_ptp_port_phy_stop(),
and then it destroys the worker:

    mutex_lock(&pf->adapter->ps_lock);
    ice_ptp_port_phy_stop(&pf->ptp.port);
    mutex_unlock(&pf->adapter->ps_lock);

    if (pf->ptp.kworker) {
        kthread_destroy_worker(pf->ptp.kworker);
        pf->ptp.kworker = NULL;
    }

Suppose a link change passes the READY check and then blocks on ps_lock,
for example behind a sibling PF's restart holding the adapter-wide mutex.
If release takes the lock first, the link change then runs against the
torn-down port:

  - E82x with linkup == false: ice_ptp_port_phy_stop() calls
    kthread_cancel_delayed_work_sync(&ptp_port->ov_work), but
    ov_work.work->worker still points at the freed kthread_worker.

  - linkup == true: ice_ptp_port_phy_restart() calls
    kthread_queue_delayed_work() with pf->ptp.kworker == NULL.

Two callers can race with ice_unload()->ice_deinit_features()->
ice_ptp_release(). One is ice_down() (ndo_stop under rtnl). The other is
ice_link_event(), called from the service task.

The service task keeps running through ice_unload(), because
ice_service_task_stop() is only called later, from ice_deinit_dev().

Later in the series the ice_down() caller goes away. ice_link_event() and
ice_rebuild() still call ice_ptp_link_change() from the service task,
though, and the state check is still outside the lock at the end of the
series. The same window existed with the old per-port lock.

[ ... ]

> @@ -3404,14 +3403,16 @@ void ice_ptp_init(struct ice_pf *pf)
>  
>  	err = ice_ptp_init_port(pf, &ptp->port);
>  	if (err)
> -		goto err_destroy_ps_lock;
> +		goto err_exit;
>  
>  	err = ice_ptp_setup_pf(pf);
>  	if (err)
>  		goto err_release_tx_tracker;
>  
>  	/* Start the PHY timestamping block */
> -	ice_ptp_reset_phy_timestamping(pf);
> +	mutex_lock(&pf->adapter->ps_lock);
> +	ice_ptp_port_phy_restart(&ptp->port);
> +	mutex_unlock(&pf->adapter->ps_lock);

[Severity: High]
This isn't a bug introduced by this patch, but on E822, can the
ice_ptp_port_phy_restart() call here dereference a NULL pf->ptp.kworker?

On the ICE_MAC_GENERIC success path, the restart queues work without
checking the worker:

    kthread_queue_delayed_work(pf->ptp.kworker, &ptp_port->ov_work,
                               0);

ice_ptp_init_work() only runs later in ice_ptp_init(). That is after this
restart, and after ptp->state is set to ICE_PTP_READY.

ice_ptp_release() destroys the worker and sets pf->ptp.kworker = NULL, but
it never clears ptp.port.link_up. Link events after release return early
because the state is not READY.

So take a devlink reload (ice_unload() -> ice_load()) while the link is
up. link_up is still true when this restart runs, and
kthread_queue_delayed_work() then takes worker->lock on a NULL worker
while ps_lock is held.

Two other paths reach the same call:

  - A sibling PF's ice_ptp_restart_all_phy() (from owner settime64 or
    rebuild) can find this port as soon as ice_ptp_setup_pf() has added it
    to the adapter ports list with list_add_rcu().

  - A link-up event can see ICE_PTP_READY before the worker exists.

The later patch "ice: call PTP link change only from link events" moves
ice_ptp_init_work() ahead of the restart and the READY transition, and
seeds link_up. That covers this init-path restart and the link-up event.

The sibling PF path still looks open at the end of the series.
ice_ptp_setup_pf() still publishes the port on the list before the worker
is created and before link_up is reseeded. ice_ptp_restart_all_phy() also
does not check ptp.state.

Would creating the worker, or clearing link_up, before the port is added
to the ports list close this window?

[ ... ]

> @@ -3470,7 +3469,6 @@ void ice_ptp_release(struct ice_pf *pf)
>  		}
>  		ice_ptp_cleanup_pf(pf);
>  		ice_ptp_release_tx_tracker(pf, &pf->ptp.port.tx);
> -		mutex_destroy(&pf->ptp.port.ps_lock);
>  		return;
>  	}
>  

[Severity: High]
This hunk only drops the mutex_destroy(). Looking at the rest of this
branch, though, can a sibling PF still reach this port after its
kworker has been destroyed?

In the ice_ptp_release() branch for a PF whose state is not
ICE_PTP_READY, the order is:

  - kthread_destroy_worker() is called and pf->ptp.kworker is set to
    NULL.
  - ice_ptp_cleanup_pf() is called after that.

ice_ptp_cleanup_pf() is what removes the port from adapter->ports.list.
Until it runs, the port is still published on the list.

During that window, another PF can call ice_ptp_restart_all_phy(), for
example from ice_ptp_settime64() on the clock owner or from rebuild.
That function:

  - walks the list under SRCU,
  - takes a port->ref,
  - calls ice_ptp_port_phy_restart() without looking at ptp.state.

Nothing in release clears ptp_port->link_up, so it can still be true.
On ICE_MAC_GENERIC the restart then ends in:

    kthread_queue_delayed_work(pf->ptp.kworker, &ptp_port->ov_work,
                               0);

Depending on timing, pf->ptp.kworker is either already freed or NULL.
If link_up is false, the walker goes through ice_ptp_port_phy_stop()
instead. Its kthread_cancel_delayed_work_sync(&ptp_port->ov_work) may
also end up taking the lock of the freed worker that
ov_work.work.worker still points to.

This matters for this patch because ice_ptp_restart_all_phy() now
holds adapter->ps_lock across the walk, and ps_lock is meant to be
what serializes PHY start/stop. This branch of ice_ptp_release() never
takes ps_lock, so the new lock does not order the teardown against a
concurrent restart from a sibling PF. As I read it, the READY branch
unpublishes the port before the worker goes away, so it does not have
this window.

Should ice_ptp_cleanup_pf() run before the worker is destroyed here,
as in the READY path? The idea is that the port is unpublished, and
any SRCU walker that already found it has finished, before
pf->ptp.kworker is freed. Or would you rather take ps_lock around this
teardown?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261008215614.1987250-1-anthony.l.nguyen%40intel.com
