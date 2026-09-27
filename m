Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 806683C5DA1
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 23:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790551266; cv=none; b=NV/YDSBzXNTuC8+aCQgIapEc5uuNHmmNi9FFAJH7ATRrJRtc2+ILKM9Mkc+mzJX9F7j0xOcvr3YW1rhXPUjGq1bq7bK+mVhWELTY1eduZ5gcOgSmwWAsn0aSHVXblXvN/0Pq7R60vd9yc/rrblsITwL5GH2SEsnsDmbAGsLP66I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790551266; c=relaxed/simple;
	bh=sYNHs1vU/SxlfiSk5EiAtXcembpZY5Y4CmqBv3/bwxY=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QnAO5SYApLnSDytzcvNvt3ZsL6KVLlUhUeq4ezQCF11ZMGLEZzmDMCPjkc62ee/N5jn4IjhWHSP41kKry4YYvp7rg0Q63MBaOR5ymBqmel2mZmaHiOfgcdJ8rUUb0EV7YwvmHfqkDVWLYOSLXwi8El5NNAwk85/g7ptZ/O6sYYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlzlZ/br; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlzlZ/br"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 353281F000FF;
	Sun, 27 Sep 2026 23:21:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790551265;
	bh=hE+x/g/Zv2ZgM1gGUeq4K2eSI/AAPlxnreXn1OdjhYs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=MlzlZ/brP1kgmeQtvNoF3KBVjtuMKSbuSYWjWj40zOYr0l+Piz6nkVAbh2QIEgYKl
	 93xqXMOCyxvDC4jUS0wLEjdQZA+sGdDJm9jbqhXb2zO0QismU1Smz0GwzXDcCR+YkX
	 KxHxoTKVPRzeQcbwsB6FqpQ3Bv2GfNMFuSNLjXRPhx5REikYz8MT+CPOIEOR1qbYNv
	 U4zEDgwKdRyn4aBE3x1zp6Se5lRPX2gI8wGuA6w+ZQDoj+9hzT1rjdWvALGwVdKtLz
	 G1jPLvv1GMzdMFfEXQNU/N5AOBO1bcA2q7BE5Ac+zHNIgm6WX140nHcehLrqQPbtjr
	 kwHG7vfy5oCKg==
Subject: Re: [PATCH net-next] net/mlx5e: advertise tcp-data-split support
From: netdev-bot+sashiko@kernel.org
To: dimitri.daskalakis1@gmail.com
Cc: davem@davemloft.net, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, leon@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, gal@nvidia.com,
 cratiu@nvidia.com, dtatulea@nvidia.com, noren@nvidia.com, cjubran@nvidia.com,
 netdev@vger.kernel.org
Date: Sun, 27 Sep 2026 23:21:03 +0000
Message-ID: <179055126371.3145.7187403042173989856@kernel.org>
In-Reply-To: <20260923230521.1267511-1-dimitri.daskalakis1@gmail.com>
References: <20260923230521.1267511-1-dimitri.daskalakis1@gmail.com>
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

Critical: 0 · High: 0 · Medium: 3 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] mlx5e_ethtool_get_ringparam() now reports tcp-data-split from
  the live SHAMPO state (priv->channels.params.packet_merge.type).
- [Medium] With HW-GRO off (the default, en_main.c:5949 clears
  NETIF_F_GRO_HW), GET now reports 'disabled', so hds.py _get_hds_mode()…
- [Medium] net/mlx5e: ethtool tcp-data-split API contract violation on
  unsupported hardware
- [Low] The patch puts back exactly the tcp_data_split assignment in
  mlx5e_ethtool_get_ringparam() that commit 46bcce5dfd33 ('net/mlx5e:…

--

net/mlx5e: advertise tcp-data-split support

This patch makes mlx5e_ethtool_get_ringparam() report tcp-data-split
again. The value is ENABLED when the channel packet merge type is SHAMPO
and DISABLED otherwise. Commit 46bcce5dfd33 dropped this reporting.
After commit d347b28c492e started reporting hds_thresh, the hds.py
selftests hit a KeyError on tcp-data-split.

> The ability to set tcp-data-split was introduced in
> commit 46bcce5dfd33 ("net/mlx5e: Support ethtool tcp-data-split settings")
> This commit dropped reporting from mlx5e_ethtool_get_ringparam()
> without explaining why.

[Severity: Low]
The assignment added here is the same one that 46bcce5dfd33 removed from
mlx5e_ethtool_get_ringparam(). The message also names both commits that
led to the selftest failure.

Should this have a Fixes: tag, for example:

Fixes: 46bcce5dfd33 ("net/mlx5e: Support ethtool tcp-data-split settings")

so that stable and backport tooling picks it up?

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> index 261c466a4d362..62060a6fa185c 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> @@ -378,6 +378,11 @@ void mlx5e_ethtool_get_ringparam(struct mlx5e_priv *priv,
>  
>  	kernel_param->hds_thresh = 0;
>  	kernel_param->hds_thresh_max = 0;
> +
> +	kernel_param->tcp_data_split =
> +		(priv->channels.params.packet_merge.type == MLX5E_PACKET_MERGE_SHAMPO) ?
> +		ETHTOOL_TCP_DATA_SPLIT_ENABLED :
> +		ETHTOOL_TCP_DATA_SPLIT_DISABLED;

[Severity: Medium]
What does this report on a device that cannot do SHAMPO at all?

If the SHAMPO capability bits, such as MLX5_CAP_GEN(mdev, shampo),
are not set, HW-GRO can never be turned on. In that case
packet_merge.type can never be MLX5E_PACKET_MERGE_SHAMPO, so this
assignment always reports ETHTOOL_TCP_DATA_SPLIT_DISABLED.

The ethtool netlink code leaves ETHTOOL_A_RINGS_TCP_DATA_SPLIT out of
the RINGS_GET reply only when the value is
ETHTOOL_TCP_DATA_SPLIT_UNKNOWN. Userspace therefore treats the presence
of the attribute as "the device supports header-data split".

With this change every mlx5e device advertises the feature as
supported but off. That includes devices where
mlx5e_ethtool_set_tcp_data_split() can only reject a later
"tcp-data-split on", because GRO HW is not available.

hds.py shows the effect. _get_hds_mode() skips only when
'tcp-data-split' is missing from the reply. On such hardware, get_hds
and the xdp tests would now run instead of skipping, and the enable
paths would fail with EINVAL.

Should the value stay ETHTOOL_TCP_DATA_SPLIT_UNKNOWN when the device
lacks SHAMPO support? For example, the driver could check the SHAMPO
capability, or whether NETIF_F_GRO_HW is in priv->netdev->hw_features,
before reporting ENABLED or DISABLED.

[Severity: Medium]
Can this report "enabled" right after a "tcp-data-split off" request has
succeeded?

GET now reflects the live SHAMPO state. The set path does not always
turn SHAMPO off when DISABLED is requested. In
mlx5e_ethtool_set_tcp_data_split():

	/* Might need to disable HW-GRO if it was kept on due to hds. */
	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_DISABLED &&
	    dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED)
		netdev_update_features(priv->netdev);

	return true;

Suppose the user has run "ethtool -K ethX rx-gro-hw on", so
NETIF_F_GRO_HW is in wanted_features:

- If hds_config is UNKNOWN, netdev_update_features() is never called.
- If hds_config is ENABLED, mlx5e_fix_features() only stops forcing
  GRO_HW on. GRO_HW stays on because it is still wanted.

In both cases SHAMPO stays active.

mlx5e_ethtool_set_ringparam() then returns early because the ring sizes
did not change:

	if (log_rq_size == priv->channels.params.log_rq_mtu_frames &&
	    log_sq_size == priv->channels.params.log_sq_size)
		return 0;

and ethnl_set_rings() commits the request:

	dev->cfg_pending->hds_config = kernel_ringparam.tcp_data_split;

On the next RINGS_GET, rings_prepare_data() prefills tcp_data_split
from dev->cfg->hds_config, which is DISABLED. This new assignment then
overwrites it with ENABLED.

With rx-gro-hw on, wouldn't set_hds_disable() in hds.py still fail?
It would now fail on ksft_eq('disabled', rings['tcp-data-split'])
instead of the KeyError.

Should the driver actually turn SHAMPO off for DISABLED, or reject the
request?

[Severity: Medium]
HW-GRO is off by default, so this now reports "disabled" and
_get_hds_mode() in hds.py no longer skips. Is that why enabled_set_xdp
and ioctl_enabled_set_xdp go from SKIP to FAIL in the "After" log in the
commit message?

Both tests always request:

    netnl.rings_set({'header': {'dev-index': cfg.ifindex},
                     'tcp-data-split': 'enabled'})

but mlx5e_ethtool_set_tcp_data_split() rejects that unless HW-GRO is
already on:

	if (tcp_data_split == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
	    !(dev->features & NETIF_F_GRO_HW)) {
		NL_SET_ERR_MSG_MOD(extack,
				   "TCP-data-split is not supported when GRO HW is disabled");
		return false;
	}

set_hds_enable() gets the same -EINVAL. The test maps it to a skip, and
the existing skip message looks copy-pasted from set_hds_disable():

        if e.error == errno.EINVAL:
            raise KsftSkipEx("disabling of HDS not supported by the device")

So the rejected enable shows up as a skip with the wrong reason, and the
enable path is never tested.

Should the driver turn on HW-GRO when tcp-data-split=enabled is
requested? Or should the tests enable rx-gro-hw first, or skip on EINVAL?
As things stand, the state the driver reports does not match what the
selftests expect.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260923230521.1267511-1-dimitri.daskalakis1%40gmail.com
