Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7172EEE65
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 23:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791673907; cv=none; b=WIhuNK5atG634cVNrXHFU8HcoNbsf8Z9JHxBhruxHU82QJLtUjhYzf3g620XIJkR6mr3xG6YdcxFMWFa55+MJNpIYeTOlZ4aSASlU8mlrhWVdPgdEHVrNu93Ew9iPwPTzxmDQlIsELsdWavAWE04VjYdvvM+MtQSoUPhBSHzWSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791673907; c=relaxed/simple;
	bh=cUlt01RNA9ngjgu5tLeQTHIa3NmbpY3sGxmZNz55RJc=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DjCXyvPX1VsH+zITTg9curwJkKuJP7qtNf3I6FosgtOYsXGRFkKnxnaXj6XGU3zyVM0nTWUY6E5DTS4qvkGFFlCMhjAoGr/nakrM/Sqr+J9nFPdmcVnPauubYG2jMwx1XgZco2xIS5lLQJweydOgYzBScP4SjGqMEbgs4E0OOtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NY4H9Y8A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NY4H9Y8A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F0F91F000FF;
	Sat, 10 Oct 2026 23:11:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791673906;
	bh=nKSlhEAjR+YrV3tWNlwLFjrgP1ZVgWv5CeBVOTikFmU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=NY4H9Y8AzKdJFUSlwA/maXvYYHZDwBbKNc5VjDArXdrtu3VqOZdGJoLMUt8ARij/P
	 0TBKjcaZ0qdSqNAfp7y0M+e/9NZlbvGeCyzmja81q+ayt41buVzAIAUxucPizn8xQa
	 ttIualhv2UNLx2w5ueIrniPyeoAHkBa1sZuCnJ7bu5Vl1RJ6PvHlWym/qogqfsdrkR
	 BlJqn2+2Rd63Ht2Nxw8CMGKgnJWgXuDcKQ3eXMwOd3D4FKEcE2z3Fe8WbOKYypFqSo
	 mQHbOWzVA5vqlUczXevGiJ27dzIZ/352Uvdry3RMqs13gi+kuNCgdoYnTIrlBu9duf
	 sB+Pro8xRtmUA==
Subject: Re: [PATCH net-next v2] net/mlx5e: advertise tcp-data-split support
From: netdev-bot+sashiko@kernel.org
To: dimitri.daskalakis1@gmail.com
Cc: davem@davemloft.net, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, leon@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, gal@nvidia.com,
 cratiu@nvidia.com, dtatulea@nvidia.com, noren@nvidia.com, cjubran@nvidia.com,
 netdev@vger.kernel.org
Date: Sat, 10 Oct 2026 23:11:44 +0000
Message-ID: <179167390477.434549.15792233825005717153@kernel.org>
In-Reply-To: <20261006225925.568263-1-dimitri.daskalakis1@gmail.com>
References: <20261006225925.568263-1-dimitri.daskalakis1@gmail.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 4 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 (2) · Low: 1 (1)

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] In mlx5e_ethtool_get_ringparam() (en_ethtool.c:382-384),
  tcp_data_split is only ever set to ENABLED, and only while…
- [Medium] With HW GRO enabled and HDS left in auto mode (cfg UNKNOWN),
  mlx5e_ethtool_get_ringparam() now reports tcp-data-split='enabled'.
- [Medium] mlx5e_ethtool_set_tcp_data_split() now calls
  netdev_update_features() whenever dev->cfg->hds_config differs from…
- [Low] The commit message says 'This is not a fix', yet part of the
  patch restores the reporting that 46bcce5dfd33 removed.

Pre-existing issues:
- [Medium] The KeyError cited in the commit message comes from the
  selftest helper _hds_reset() (hds.py:64-82).
- [Medium] mlx5e_ethtool_get_ringparam() reports tcp-data-split=enabled
  whenever SHAMPO is active, whether dev->cfg->hds_config is UNKNOWN or…
- [Low] In hds.py set_hds_enable(), an EINVAL from the *enable* request
  is reported with the skip reason 'disabling of HDS not supported by…

--

net/mlx5e: advertise tcp-data-split support

This patch brings back tcp-data-split reporting in
mlx5e_ethtool_get_ringparam() when SHAMPO packet merge is active.
It also rejects requests to disable tcp-data-split. Finally, it changes
mlx5e_ethtool_set_tcp_data_split() to call netdev_update_features()
whenever the requested value differs from the current hds_config.

> Between these two commits, the hds selftest helper _defer_reset_hds()
> would skip the reset because neither hds-thresh or tcp-data-split was
> present in the ring config. After the second commit this introduced
> a KeyError in the hds.set_hds_enable/disable tests.

[Severity: Medium]
This is a pre-existing issue, but the KeyError itself comes from
_hds_reset() in tools/testing/selftests/drivers/net/hds.py. After
resetting to "unknown", that function reads the attribute directly:

        arg['tcp-data-split'] = "unknown"
        netnl.rings_set(arg)
        cur = netnl.rings_get({'header': {'dev-index': cfg.ifindex}})
        if cur['tcp-data-split'] == rings['tcp-data-split']:

This patch doesn't change the helper, and mlx5 still seems able to reach
it.

For example: rx-gro-hw on, tcp-data-split on, then rx-gro-hw off, so
HW-GRO is kept on because of hds. In that state set_xdp() records
"enabled" and then sets "unknown".

The new hds_config != tcp_data_split path calls netdev_update_features().
That drops HW-GRO and SHAMPO, so the attribute disappears from the GET
reply. The deferred _hds_reset() then sends "unknown" again and hits a
KeyError on cur['tcp-data-split'].

Would using .get() in _hds_reset() be more robust? Any other driver that
accepts "disabled" and reports unknown in auto mode can hit the same
KeyError.

> This is not a fix since the feature is still functional with
> HW GRO enabled.

[Severity: Low]
Part of this patch puts back the reporting that commit 46bcce5dfd33
removed from mlx5e_ethtool_get_ringparam(), which was the
SHAMPO ? ENABLED : DISABLED assignment. Should this have a Fixes: tag for
46bcce5dfd33?

The condition for calling netdev_update_features() also changes. It was
(disabled requested && hds_config enabled) and is now (hds_config !=
requested). That makes "auto" the only way to release HW-GRO that hds
kept on.

The commit message doesn't say this. The new extack text, "TCP-data-split
can not be disabled", also doesn't point users to "auto". Could both be
mentioned?

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> index 261c466a4d362..f08a968acec49 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> @@ -378,6 +378,10 @@ void mlx5e_ethtool_get_ringparam(struct mlx5e_priv *priv,
>  
>  	kernel_param->hds_thresh = 0;
>  	kernel_param->hds_thresh_max = 0;
> +
> +	if (priv->netdev->hw_features & NETIF_F_GRO_HW &&
> +	    priv->channels.params.packet_merge.type == MLX5E_PACKET_MERGE_SHAMPO)
> +		kernel_param->tcp_data_split = ETHTOOL_TCP_DATA_SPLIT_ENABLED;

[Severity: Medium]
There is only a branch for enabled here. When packet_merge.type is not
SHAMPO, tcp_data_split keeps the value the core copied from
dev->cfg->hds_config. That value is unknown by default, and
rings_fill_reply() leaves the attribute out of the reply in that case:

net/ethtool/rings.c:rings_fill_reply() {
    ...
	    (kr->tcp_data_split &&
	     (nla_put_u8(skb, ETHTOOL_A_RINGS_TCP_DATA_SPLIT,
			 kr->tcp_data_split))) ||
    ...
}

mlx5e_build_nic_netdev() clears NETIF_F_GRO_HW by default. Doesn't that
mean a freshly probed device that supports HW GRO still looks as if it
doesn't support tcp-data-split? The "after" output in the changelog shows
hds.get_hds still skipping with "tcp-data-split not supported by device".

The v2 changelog says unknown is left only "if the device does not
support HW GRO", and the hw_features test looks meant for that. But SHAMPO
is only set in set_feature_hw_gro() on the enable path. So SHAMPO already
means NETIF_F_GRO_HW is in hw_features, and the hw_features test never
changes the result.

Should this report ETHTOOL_TCP_DATA_SPLIT_DISABLED when HW GRO is
supported but SHAMPO isn't active, like the code that 46bcce5dfd33
removed?

[Severity: Medium]
This is a pre-existing limitation of the selftest rather than something
this patch introduces. With this reporting, enabled is returned whenever
SHAMPO is active, whether dev->cfg->hds_config is unknown or enabled.

With HW GRO on and hds_config unknown, hds.py set_hds_enable() records
"enabled", sets "enabled" (hds_config becomes enabled), and then checks
for "enabled". The deferred _hds_reset() only acts when the reported
values differ:

    if cur.get('tcp-data-split') != rings.get('tcp-data-split'):

So hds_config is never set back to unknown, and mlx5e_fix_features() keeps
forcing HW-GRO on:

	if (cfg && cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
	    !(features & NETIF_F_GRO_HW)) {

The core then rejects single-buffer XDP with -EBUSY. In a full hds.py run,
later tests reset to "unknown" and hide this. Running set_hds_enable on
its own leaves the device changed. netdevsim has the same gap, since it
also reports enabled when hds_config is unknown.

[Severity: Medium]
With rx-gro-hw on and HDS left in auto mode, this now reports "enabled",
so hds.py set_xdp() and ioctl_set_xdp() no longer skip. set_xdp() does:

    mode = _get_hds_mode(cfg, netnl)
    if mode == 'enabled':
        _defer_reset_hds(cfg, netnl)
        netnl.rings_set({'header': {'dev-index': cfg.ifindex},
                         'tcp-data-split': 'unknown'})

    _xdp_onoff(cfg)

hds_config is already unknown, so mlx5e_ethtool_set_tcp_data_split()
doesn't call netdev_update_features(). HW-GRO is still in wanted_features
anyway, so packet_merge stays SHAMPO. mlx5e_xdp_allowed() then rejects
the program:

	if (params->packet_merge.type != MLX5E_PACKET_MERGE_NONE) {
		netdev_warn(netdev, "can't set XDP while HW-GRO/LRO is on, disable them first\n");
		return -EINVAL;
	}

Does this turn two tests that used to skip into failures whenever
rx-gro-hw is on? The tests expect XDP installation to work in auto mode,
and the "after" run looks like it was done with HW GRO off.

>  static void mlx5e_get_ringparam(struct net_device *dev,
> @@ -403,9 +407,14 @@ static bool mlx5e_ethtool_set_tcp_data_split(struct mlx5e_priv *priv,
>  		return false;
>  	}
>  

[Severity: Low]
This isn't a bug introduced by this patch. The check just above returns
EINVAL for an enable request when HW GRO is off:

	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
	    !(dev->features & NETIF_F_GRO_HW)) {

hds.py set_hds_enable() reports that EINVAL with a skip reason copied from
set_hds_disable():

        if e.error == errno.EINVAL:
            raise KsftSkipEx("disabling of HDS not supported by the device")

The "after" output shows "hds.set_hds_enable # SKIP disabling of HDS not
supported by the device", which names the wrong operation.

> +	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_DISABLED) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "TCP-data-split can not be disabled");
> +		return false;
> +	}
> +
>  	/* Might need to disable HW-GRO if it was kept on due to hds. */
> -	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_DISABLED &&
> -	    dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED)
> +	if (dev->cfg->hds_config != tcp_data_split)
>  		netdev_update_features(priv->netdev);

[Severity: Medium]
With the wider condition, a change from enabled to unknown ("auto") now
calls netdev_update_features() here. That happens before
mlx5e_set_ringparam() validates the ring sizes:

	if (!mlx5e_ethtool_set_tcp_data_split(priv,
					      kernel_param->tcp_data_split,
					      extack))
		return -EINVAL;

	return mlx5e_ethtool_set_ringparam(priv, param, extack);

What happens if mlx5e_ethtool_set_ringparam() fails after this?

ethnl_set_rings() has already set cfg_pending->hds_config to unknown.
mlx5e_fix_features() reads cfg_pending, so it skips the "Keeping HW-GRO
enabled" override. If the user had earlier turned rx-gro-hw off while hds
kept it on, set_feature_hw_gro(false) switches packet_merge from SHAMPO to
none.

A request like "ethtool -G eth0 tcp-data-split auto rx 1" then fails the
minimum rx size check in mlx5e_ethtool_set_ringparam().
mlx5e_validate_params() or mlx5e_safe_switch_params() can fail at the
same point too. ethnl_default_set_doit() skips the swap when ret < 0:

	if (ret < 0)
		goto out_ops;

	swap(dev->cfg, dev->cfg_pending);

So dev->cfg->hds_config stays enabled while the device no longer splits
headers. GET still reports enabled, single-buffer XDP stays blocked with
-EBUSY, and the core's hds_config check for memory providers passes. The
next unrelated netdev_update_features() forces GRO_HW back on.

The disabled path had the same ordering before, and this patch now
rejects that request, so the trigger has moved to "auto". Could the
feature update happen only after the ring parameters are applied
successfully?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261006225925.568263-1-dimitri.daskalakis1%40gmail.com
