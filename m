Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793572398;
	b=RtGl94z9unU5ObddGSO8l99hjiAUj6f33xvNaLe9eXJHzsNjYsVNJ1O/dcRfY1ECKJcI
	 fnS7uGyhZ5jOrpT3hu0tLQ62qMjAY6jkzOQUImB95SBOIgxXIPop7nuJEFls4eo0iLNb8
	 ixWbd/7h9uJrPl9Q20IMhsMYoZFj1exbsqI85KoISiJB1LYX7S6shZtKf3Ima0EYn+mTk
	 Tn+S23beew+GearJ+5Z/Ky7WnVWM3gj5RFtZtW0mWbEKofV6vCCwfwOpJ2T3ETVI2n7S3
	 n0KrQP62TpLo2pYv1VHuc+X8r0GnsqDiB+Ki+odeuKDJHhGPyz7S7lh3XTX7gapjokg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793572398;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=46T6BFV/iHnX5mChinKdsO0BZDHY+q96TmCPcnLOoWw=;
	b=VgW6Tpa1sDdWccQk5O/egA/zQt5BnMYOM0tpVOSRL86VevJ/7kM3M7yYqEv7XH+A4D3p
	 ycSQD17/+u/l4l0l+mWKOYfRj+zqAXoX71YE99FovDY35mv1PETN+uYHRO+3BsRiWNVhu
	 s+PMRdpVkOufPpJFnNpp0RJO/5lGAexSSgOLwN0jNWzLtE0tUwdeimL//YJ3a0AfpHBwh
	 ZuH22p5snVbUN9Dzzuh3GrUQG3qFm6G5E7HrRpToR3Vh9zFR2ZdD3fotQ8wsPDWTDWGvC
	 TzXqpn3dyE7jX/DOlhPLVhxAuaixrsCkhMj+qElVW8/jPQh0tMBKF81sJWIXG3aVHcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hH3DZHOn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ABC60A2600
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 22:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hH3DZHOn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21C9F1F00A15;
	Sun,  1 Nov 2026 22:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793572397;
	bh=46T6BFV/iHnX5mChinKdsO0BZDHY+q96TmCPcnLOoWw=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hH3DZHOn1kQcdQOxBvs1EgVgeaX/UWMkQRVjgSwYHV2XvMh52RBOu5AwdFzfCo/LY
	 OUxtuvQGUKSV+QVm2ydBLelQJw0h2K7KLAzAULJ4SLNqSGoT3EUbNPprR2uD2k1sE1
	 s2QjIlKzSd3m9Ft+6HSO4JYUhfveJecW65ZTmOOrNzenDXrpXd90KvtZaOG0MvBJHo
	 B8TG88bagC1bO93OsmoO9L0LwP2IcJg1H+xfgw4han8wkiUIA77wQUHOQ81RzZpju8
	 Cd9ylOeg+J696v8vyGeFn29Zn2nf6kII/pW+EgYVzdVU1Jd3+pFClCYLppk1ILaFW8
	 IKfzW6iIKlCJQ==
Subject: Re: [net PATCH 05/13] fbnic: Don't touch host filters from a service
 task pass after ndo_stop
From: netdev-bot+sashiko@kernel.org
To: alexander.duyck@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, kernel-team@meta.com, kuba@kernel.org,
 pabeni@redhat.com
Date: Sun, 01 Nov 2026 22:33:16 +0000
Message-ID: <179357239672.3131.17410114269530913916@kernel.org>
In-Reply-To:
 <179322339510.40667.1479012020546652264.stgit@ahduyck-xeon-server.home.arpa>
References:
 <179322339510.40667.1479012020546652264.stgit@ahduyck-xeon-server.home.arpa>
X-sashiko-severity: High
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 0 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] The patch is incomplete.

--

fbnic: Don't touch host filters from a service task pass after ndo_stop

This commit moves fbnic_health_check() and fbnic_bmc_rpc_check() in
fbnic_service_task() under the netif_running() check that re-arms the
task. A pass that was blocked on RTNL during ndo_stop should then skip
the firmware recovery and BMC TCAM rebuild. The fix relies on
__dev_close_many() clearing __LINK_STATE_START before it calls ndo_stop.

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> index ad234bb0f75d0..e7744915d001c 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> @@ -229,18 +229,23 @@ static void fbnic_service_task(struct work_struct *work)

[ ... ]

> -	if (netif_running(netdev))
> +	/* fbnic_service_task_stop() does not wait for a pass that is already
> +	 * blocked on RTNL, so one can run after ndo_stop. Leave host state
> +	 * alone in that case; __fbnic_open() reclaims and rebuilds it.
> +	 */
> +	if (netif_running(netdev)) {
> +		fbnic_health_check(fbd);
> +
> +		fbnic_bmc_rpc_check(fbd);
> +
>  		schedule_delayed_work(&fbd->service_task, HZ);
> +	}

[Severity: High]
Does this gate cover the ndo_stop call in fbnic_pm_suspend()?

That path calls ndo_stop directly and does not go through
__dev_close_many(). Before calling it, it only does
netif_device_detach():

drivers/net/ethernet/meta/fbnic/fbnic_pci.c:fbnic_pm_suspend() {
    ...
	rtnl_lock();
	netdev_lock(netdev);
    ...
	netif_device_detach(netdev);

	if (netif_running(netdev))
		netdev->netdev_ops->ndo_stop(netdev);
    ...
	netdev_unlock(netdev);
	rtnl_unlock();
    ...
}

netif_device_detach() clears __LINK_STATE_PRESENT and leaves
__LINK_STATE_START set. So netif_running() is still true after
fbnic_pm_suspend() drops RTNL.

fbnic_pm_suspend() is reached from system suspend, fbnic_shutdown() and
fbnic_err_error_detected(). On those paths, can the same sequence the
commit message describes still happen?

CPU1 (fbnic_pm_suspend)              CPU2 (fbnic_service_task)
rtnl_lock()
                                     rtnl_lock()  <- blocks
ndo_stop()
  fbnic_stop()
    fbnic_down()
      fbnic_service_task_stop()
        cancel_delayed_work()
    fbnic_fw_xmit_ownership_msg(fbd, false)
      fw_heartbeat_enabled = false
rtnl_unlock()
                                     netif_running() is still true
                                     fbnic_health_check()
                                       fbnic_fw_config_after_crash()
                                     fbnic_bmc_rpc_check()
                                     schedule_delayed_work()

In that pass, fbnic_health_check() sees fw_heartbeat_enabled == false
with an empty Tx mailbox. It reports a firmware crash through devlink
that did not happen. fbnic_fw_config_after_crash() then reclaims
ownership and writes the host rules back with __fbnic_set_rx_mode()
while the host queues are disabled.

If FBNIC_FW_CAP_F_BMC_TCAM_REINIT is set, fbnic_bmc_rpc_check() also
runs fbnic_bmc_rpc_init(), fbnic_rss_reinit() and __fbnic_set_rx_mode().

The pass also re-arms itself through schedule_delayed_work(). After
fbnic_pm_suspend() drops RTNL, it goes on to call fbnic_fw_free_mbx()
and fbnic_free_irqs() and to set uc_addr0/uc_addr4 to NULL. It never
does a synchronous cancel of service_task. Could the task keep running
every HZ after that teardown, until reboot on shutdown or until
__fbnic_open() on resume?

Would it be more robust to use a driver-owned stop indication? It could
be set under RTNL in fbnic_down() or fbnic_stop() and checked by the
service task, or the work could be drained synchronously, instead of
keying on netif_running().

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179322311834.40667.5383039334126572422.stgit%40ahduyck-xeon-server.home.arpa
