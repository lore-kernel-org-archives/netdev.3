Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794162773;
	b=jaShPs8/IpHXOasTHumY5f//r14lReETU8ggJjcptfn2lcVZd+XBp/9JKXOzpzR/d849
	 efFP1XPT/sjcXAOWQt3ZgenBSSJCDMwUbNmrBvQAOU7OiEJjctJy1RHZFwBhF4Mn22Gr/
	 xiWDfKsUijI+Vcmrnw8/Jd3X16nhLaQiZ0l39IF0JQ9MLF0DdVStxxPY+sPAW6nBtbHvU
	 aaz70JvlaXEXZKI3B61xLRYsKVKpd6LKZjQl7bwC1gH7wna/7dSVZHGNGjLg7hnXKjVvg
	 kPtNOc4oIm+ianwvItuovh7CgLky7I6CXJ+D7hbpRWqZCtToCvptrf5HpR9xbD719Rg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794162773;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=COJrP3dQukaOhIQRT9U2DOT9xkXjtYyRY85oKSm2Lug=;
	b=fxukXKB0wREjLPiPGX9w+9KRgqL7pcFXEayzIJJ8kxD7XizVHWhy8TSZpFxXcUK3kJZc
	 L3RUuBOXnFn5R7APjlGBRiJII8smkx4bkiwo1g/sQWji09Y6DbMozE+rJikbVVisP295b
	 8q7/Trx4y0SWMMp1yZLLfWgnZwvbbDzjO36tEqeIMNIdIxlwLFBI7t1kaUcGvKc+o5KQ1
	 ln0WwHGAivpopwMqr+1DVZps9igZVlWN+XouMYchP6fS14pbBX3GXN/69unmxSMZvyHHw
	 AiCJbA6NgcZ4cR/7NhUMqzjOuNgU1TktANV06IKTd1Hp3ET77ySN80dlPWCV36vEw8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XW7pDQnE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE2D606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 18:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XW7pDQnE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62031F0089F;
	Sun,  8 Nov 2026 18:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794162772;
	bh=COJrP3dQukaOhIQRT9U2DOT9xkXjtYyRY85oKSm2Lug=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XW7pDQnECOz/QwuQSicN/SuPnpcrumhbYM53nTIl1Dp8qInqclENGMB/kIesGaUdg
	 bFBSfZoLip3x1C1vtt06NZUQjFk0TKjZhMc7K8OtEe3/E5JOnPO68EEmYei9rZ36I4
	 X7UELULqh/dhhNzhtFnwdf87PWYikagA4ooxO56pf6G0dKfd1THpPad55tKjIAEx36
	 vWjn3ICQmgon6PaS5uDouMPuktwe5fHuNL+vDq22VcfJGhJCFTUT5LFs70P1AxyFpX
	 roq7o+YJM/SjF+PmXPQbQdHlOOJNG6q/9n3RN40IPzOswZ/cAnHe4i2HverdlJB19n
	 /S7APf19ZFgDw==
Subject: Re: [net PATCH 2/5] fbnic: Fix service task races with ndo_stop and
 PM suspend
From: netdev-bot+sashiko@kernel.org
To: alexander.duyck@gmail.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, kernel-team@meta.com, kuba@kernel.org,
 pabeni@redhat.com
Date: Sun, 08 Nov 2026 18:32:51 +0000
Message-ID: <179416277142.994134.5623223181953033290@kernel.org>
In-Reply-To: <179381515284.9644.1846335740085170889.stgit@ahduyck-xeon-server.home.arpa>
References: <179381515284.9644.1846335740085170889.stgit@ahduyck-xeon-server.home.arpa>
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

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 0 (1) · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Regression in __fbnic_pm_attach()
  (drivers/net/ethernet/meta/fbnic/fbnic_pci.c): the patch moves…
- [Medium] The Fixes tags are incomplete.

Pre-existing issues:
- [High] This problem wasn't introduced by this patch, but there is an
  unbounded hang across the RTNL drop between the two PCI error-recovery…

--

fbnic: Fix service task races with ndo_stop and PM suspend

This commit runs the service task's health check, BMC check and re-arm
only while the interface is running and the device is present. It also
makes fbnic_pm_suspend() cancel the service task synchronously after
dropping RTNL. On resume, __fbnic_pm_attach() now holds RTNL and the
instance lock across the stats reset, fbnic_up() and the device attach.

> Fixes: 04a230b27d8f ("fbnic: Add logic to repopulate RPC TCAM if BMC enables channel")
> Fixes: 6ae7da8e9e06 ("eth: fbnic: reprogram TCAMs after FW crash")

[Severity: Medium]
Are these Fixes tags complete? The commit message calls the suspend
problem "a worse one":

> It calls ndo_stop
> directly with the device detached but __LINK_STATE_START still set, so
> a late pass there sees the interface running, restores the host state,
> and keeps re-arming itself every second after the mailbox, IRQs and
> MMIO are gone.

This behaviour seems older than both cited commits. In bc6107771bb4
("eth: fbnic: Allocate a netdevice and napi vectors with queues"):

- fbnic_service_task() already re-armed on netif_running() alone.
- fbnic_service_task_stop() already used the non-sync
  cancel_delayed_work().
- fbnic_pm_suspend() already called netif_device_detach() and then
  ndo_stop(), with no cancel_delayed_work_sync().

The instance lock added around fbnic_up() in __fbnic_pm_attach() also
fixes an older problem. fbnic_up()->fbnic_napi_enable()->
napi_enable_locked() expects the instance lock. That requirement came in
with 4ddb17c1a2c2 ("eth: fbnic: request ops lock").

Should bc6107771bb4 and 4ddb17c1a2c2 also get Fixes tags? Without them,
stable trees that have the fbnic PM and service task code but not the two
TCAM commits won't pick up the suspend fix.

> diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> index 09eeb4b4ded8f..09ae797b1f0dc 100644
> --- a/drivers/net/ethernet/meta/fbnic/fbnic_pci.c
> +++ b/drivers/net/ethernet/meta/fbnic/fbnic_pci.c

[ ... ]

> @@ -558,19 +571,26 @@ static void __fbnic_pm_attach(struct device *dev)
>  	struct net_device *netdev = fbd->netdev;
>  	struct fbnic_net *fbn;
>  
> -	rtnl_lock();
> -	fbnic_reset_hw_stats(fbd);
> -	rtnl_unlock();
> -
>  	if (fbnic_init_failure(fbd))
>  		return;

[Severity: Medium]
fbnic_reset_hw_stats() now sits below the init failure check, so it no
longer runs when fbd->netdev is NULL. Was that intended?

Commit b1161b1863c5 ("eth: fbnic: Reset hw stats upon PCI error") put the
reset ahead of this check on purpose. fbnic_reset_hw_stats() also handles
a NULL netdev:

	if (fbd->netdev)
		ASSERT_RTNL();

A device in init failure mode stays bound so devlink still works. It also
keeps the debugfs pcie_stats file created by fbnic_dbg_fbd_init(), and
reading that file calls fbnic_get_hw_stats().

Resume or AER/DPC recovery (fbnic_err_resume()->__fbnic_pm_attach()) can
reset the hardware counters. The next read then goes through
fbnic_hw_stat_rd64():

	new_reg_value = fbnic_stat_rd64(fbd, reg, offset);
	stat->value += new_reg_value - stat->u.old_reg_value_64;

Won't this subtraction against the stale old_reg_value_64 wrap? That would
permanently add a huge value to ob_rd_tlp, ob_wr_tlp, ob_cpl_tlp and the
other PCIe counters. The 32-bit counters would get wrong deltas the same
way.

The new RTNL and attach ordering doesn't seem to need the reset skipped
here, and the commit message doesn't mention this change.

> +	/* Hold RTNL until the device is attached, so the service task pass
> +	 * fbnic_up() schedules cannot run until it will see it present.
> +	 */
> +	rtnl_lock();
> +	netdev_lock(netdev);
> +
> +	fbnic_reset_hw_stats(fbd);
> +
>  	if (netif_running(netdev))
>  		fbnic_up(fbn);
>  
>  	netif_device_attach(netdev);
> +
> +	netdev_unlock(netdev);
> +	rtnl_unlock();
>  }

[Severity: High]
This is a pre-existing issue, not one introduced by this patch. Error
recovery adds the NAPI vectors under one RTNL hold and enables them under
a later one. Can a close between the two hang?

fbnic_err_slot_reset()->__fbnic_pm_resume() calls __fbnic_open() under
rtnl_lock() and netdev_lock(). That reaches netif_napi_add_config_locked(),
which leaves NAPI_STATE_SCHED and NAPI_STATE_NPSVC set. Then both locks
are dropped:

	if (netif_running(netdev)) {
		err = __fbnic_open(fbn);
	...
	netdev_unlock(netdev);
	rtnl_unlock();

The NAPIs are only enabled later, in
fbnic_err_resume()->__fbnic_pm_attach()->fbnic_up()->fbnic_napi_enable().

In between, __LINK_STATE_START is still set, and __dev_close_many() calls
ndo_stop even on a detached device. So "ip link set dev X down" in that
window would run:

fbnic_stop()
  fbnic_down()
    fbnic_down_noidle()
      fbnic_napi_disable()
        napi_disable_locked()

napi_disable_locked() then waits for bits that only napi_enable_locked()
clears:

	while (val & (NAPIF_STATE_SCHED | NAPIF_STATE_NPSVC)) {
		usleep_range(20, 200);
		val = READ_ONCE(n->state);
	}

Wouldn't that loop spin forever while holding RTNL and the instance lock?
fbnic_err_resume()->__fbnic_pm_attach() would then block on rtnl_lock().

This patch now holds RTNL across fbnic_up() and the attach. The gap
between __fbnic_open() and fbnic_up() is still open, though.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/179381496288.9644.9775319757787890210.stgit%40ahduyck-xeon-server.home.arpa
