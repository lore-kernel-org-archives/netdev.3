Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8990F372ED3
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 20:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790971401; cv=none; b=hkRdDIiZivZKJDVI1rnrq2HogwrGY88Sze4AVArP+KgNmzhjnP9PtjPHYzXvWa13UTeJDKCal0xGrg3Zfwqyj86V/2ssrF7zV24AulM7YfpIIgWtb1lh6uzLv5yv3tfU+za0ZNUieIl1rf1AcK1ka9/rKekAS0vzBXX/rij877I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790971401; c=relaxed/simple;
	bh=DNKwyp7UBhoDCcM6tUMHVE3Dx4R8wjM7+6ujwju1OzE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=PUxZA20YZPEuv+rSgcp4gNYyNrwRrS6NO7MQHBRaxL+uvr7zg+7EF735QVcQ+yIqkszbIQ8mR8QuGXIwyn+/rKkSU1a2KqtIWooTw0/QRlPq8K/rEgfmNnMXTVBvsRKCsp31RLP90BF7jCuxyLOljc9LWkQbrF6r3KE5JoQ559Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2mkGdrr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2mkGdrr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 436D91F000FF;
	Fri,  2 Oct 2026 20:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790971400;
	bh=N6wXwcQnGp3cY5IApcB5leU+HfDuvJc4kJG82oc7SrM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=o2mkGdrrlJPyW5oHsjxi8118VgyjQNQ56wBKt3QjuYZdHVXlVVpNKOpEMr2rD37cW
	 sMcW7llVmP+jOms3oQ+cIR8Wn5PU434x43JGaH2F0rg8SiO1DQVkcAKezPX/p0dYn0
	 AyM5AhlU6051JGDplNq+QvZTG/MVsJcAgpiFyKgbgTWr9QT+fsxGZ7l0WzXUjSrTSQ
	 H9MBEJPtPLZWtzAnlyERzKPkaXU99z3PhmGmR7J4zrtKAzmGGRlXNw5y+HW1Gvksup
	 OlaMKAVZW0VyDJxKGfVSPtrU5LWsVrVKa50TcgH+SIc8hQUzjz99VjHiMr9eeOV/5M
	 wSze15bnzCeNw==
Subject: Re: [PATCH net-next 01/10] ice: reduce loglevel to debug for 'Can't
 delete DSCP' message
From: netdev-bot+sashiko@kernel.org
To: anthony.l.nguyen@intel.com
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, andrew+netdev@lunn.ch, netdev@vger.kernel.org,
 przemyslaw.kitszel@intel.com, grzegorz.nitka@intel.com,
 aleksandr.loktionov@intel.com, marcin.szycik@intel.com,
 jacob.e.keller@intel.com, przemyslaw.korba@intel.com, xiongwm2026@163.com,
 ynorov@nvidia.com, horms@kernel.org
Date: Fri, 02 Oct 2026 20:03:18 +0000
Message-ID: <179097139876.434549.11484324352193604521@kernel.org>
In-Reply-To: <20260929224153.1455466-2-anthony.l.nguyen@intel.com>
References: <20260929224153.1455466-2-anthony.l.nguyen@intel.com>
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

Critical: 0 · High: 1 · Medium: 0 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] In FW DCB mode, the driver's own flush of removed APPs always
  fails, and this patch hides that failure.

Pre-existing issues:
- [Medium] This problem wasn't introduced by this patch, but
  ice_dcbnl_delapp() compacts the desired APP table using the local…

--

ice: reduce loglevel to debug for 'Can't delete DSCP' message

This commit lowers the "can't delete DSCP netlink app when FW DCB agent
is active" message in ice_dcbnl_delapp() from netdev_err() to
netdev_dbg(). The commit message says this is expected behavior in FW
DCB mode and that the device is fully operational.

> diff --git a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
> index a10c1c8d86977..bb5cc0a2ba69b 100644
> --- a/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
> +++ b/drivers/net/ethernet/intel/ice/ice_dcb_nl.c
> @@ -872,7 +872,7 @@ static int ice_dcbnl_delapp(struct net_device *netdev, struct dcb_app *app)
>  	int ret = 0;
>  
>  	if (pf->dcbx_cap & DCB_CAP_DCBX_LLD_MANAGED) {
> -		netdev_err(netdev, "can't delete DSCP netlink app when FW DCB agent is active\n");
> +		netdev_dbg(netdev, "can't delete DSCP netlink app when FW DCB agent is active\n");
>  		return -EINVAL;
>  	}

[Severity: High]
Is this message really expected behavior? It looks like it may be the only
visible sign that the driver's own APP flush always fails in FW DCB mode.

In FW mode, ice_dcb_process_lldp_set_mib_change() takes pf->tc_mutex,
refreshes dcbx_cap and then flushes the removed APPs:

drivers/net/ethernet/intel/ice/ice_dcb_lib.c:ice_dcb_process_lldp_set_mib_change() {
    ...
	pf->dcbx_cap = ice_dcb_get_mode(pi, false);

	need_reconfig = ice_dcb_need_recfg(pf, &tmp_dcbx_cfg,
					   &pi->qos_cfg.local_dcbx_cfg);
	ice_dcbnl_flush_apps(pf, &tmp_dcbx_cfg, &pi->qos_cfg.local_dcbx_cfg);
    ...
}

ice_dcb_get_mode(pi, false) always sets DCB_CAP_DCBX_LLD_MANAGED. The flush
then goes through the user-facing .ieee_delapp op:

ice_dcbnl_flush_apps()
  ice_dcbnl_vsi_del_app()
    ice_dcbnl_delapp()
      if (pf->dcbx_cap & DCB_CAP_DCBX_LLD_MANAGED)
          return -EINVAL;

So dcb_ieee_delapp() is never reached, and the entry stays in the netdev's
dcbnl APP table.

The add side, ice_dcbnl_set_all(), calls dcb_ieee_setapp() directly, with
no FW-mode check. In FW mode, APPs get added but are never removed when
firmware drops or re-prioritises them. For example, an LLDP peer can
trigger this by changing the TLVs it advertises. The stale entries stay
visible through DCB_CMD_IEEE_GET and through dcb_ieee_getapp_mask() and
dcb_getapp().

This also doesn't match the ice_dcbnl_flush_apps() kernel-doc, which says:

 * Find and delete all APPS that are not present in the passed
 * DCB configuration

Even without the guard, ice_dcbnl_delapp() would not work as the callee
here. The caller already holds pf->tc_mutex, and ice_dcbnl_delapp() calls
mutex_lock(&pf->tc_mutex) again.

Could ice_dcbnl_vsi_del_app() call dcb_ieee_delapp() directly instead,
the same way ice_dcbnl_set_all() calls dcb_ieee_setapp()? That would
remove the stale entries and drop the spurious message on the internal
path. User-initiated deletes rejected in FW mode would keep their error
message. With that fix, this log level change would no longer be needed.

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch.
Further down in ice_dcbnl_delapp(), the desired table is compacted using
the local table as the source:

	old_cfg = &pf->hw.port_info->qos_cfg.local_dcbx_cfg;
	...
	new_cfg = &pf->hw.port_info->qos_cfg.desired_dcbx_cfg;
	...
	for (j = i; j < new_cfg->numapps; j++) {
		new_cfg->app[j].selector = old_cfg->app[j + 1].selector;
		new_cfg->app[j].prot_id = old_cfg->app[j + 1].prot_id;
		new_cfg->app[j].priority = old_cfg->app[j + 1].priority;
	}

Index i was found in desired_dcbx_cfg, but the shifted entries come from
local_dcbx_cfg. Can the two tables be out of sync at this point?

The early exit for non-DSCP selectors returns before ice_pf_dcb_cfg() runs,
so the local table is never synced:

	if (app->selector != IEEE_8021QAZ_APP_SEL_DSCP ||
	    !ice_is_feature_supported(pf, ICE_F_DSCP)) {
		ret = ICE_DCB_HW_CHG;
		goto delapp_out;
	}

ice_pf_dcb_cfg() can also fail after desired has been edited: -EBUSY with
custom Tx enabled, or -EINVAL from ice_dcb_bwchk(). When ice_set_dcb_cfg()
fails, it restores local_dcbx_cfg from old_cfg, but desired keeps the edit.

For example, start with local = desired = [A,B,C,D]:

1. Deleting B leaves desired as [A,C,D].
2. A HW failure restores local to [A,B,C,D].
3. Deleting C finds i = 1 in desired and copies local[2] = C into
   desired[1], leaving desired as [A,C].

C comes back and D is lost. ice_pf_dcb_cfg() can then commit that table to
hardware.

Should the shift copy from new_cfg->app[j + 1] instead? The compaction
logic appears to date back to commits b94b013eb626 ("ice: Implement DCBNL
support") and fc2d1165d4a4 ("ice: Refactor DCB related variables out of
the ice_port_info struct").

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260929224153.1455466-1-anthony.l.nguyen%40intel.com
