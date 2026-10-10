Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 288E438B157
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 02:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791601173; cv=none; b=num8WCr9KgxbFGPksLFyeq2vk9PBo3cNICE8+U/sKWkdlMrsXCIBCRvspZY5FxQ7XNvlKM3G7uD3HT890KA57I4RyM8VwULOTAdcwBiqTsu/lrY4fbzRfRDp4y6hZsI/xwgrYyWfHhgOmQDBmXyNVQxSUn/9P5W+QLWDZXWsjjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791601173; c=relaxed/simple;
	bh=eOWKi+90UDsaBSQok0+tvI9ILPzw5GYhHYjJFZOjig4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XAZeXAAUuFoY78vqswTDqkURIwgJWSveFTsOcwQHvqLgjFGH+ZzBmD13IzfcuVIpQlXHMgXn5ELhJwx8xo3Xmxm6AqZCmkV0AN+S4Iil4Mnsn2M9l9YZ2baUUaCkXCn4igDxzD4lKH/QVEQOEnz6MwwtzEjoJ8+0/LM9eUnZDpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AIZVX8bv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIZVX8bv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90311F000FF;
	Sat, 10 Oct 2026 02:59:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791601171;
	bh=zFzxqVjro4anFHZ9xw159Y+eVQ0k1chhiGkCrongoT0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=AIZVX8bvQRoU3i6XZsaGQOkCZIPHpP6nX51fTpOk7I/gRvbO+jeFHmP+8SSWHWFlQ
	 WI1U4xqkamfmeeVwyQZaXFqqqmgEv+RHUserAmcJfym2jkqUrkcwEvufYsNX9ZUsfc
	 qKR8sSwDkzi10W/67wydB40ZdDyNh7gR3ddFa96GOXnL530i/AgQ2K8Ff5HxxjLFL+
	 klLInHhQ8jMsW2h+f1uCqPqbreKiqw+1GucTrVLzNyELxEeApNhWGOmz8o0yirMGcA
	 3GNtX/Qp+QT9PC75NP2vt45KfQXScym87k92MYhGJ8dv75MDZlyWiH7/mddjkTRPju
	 Iq49jJXOhjlDg==
Subject: Re: [PATCH net-next v3] net/mlx5e: advertise tcp-data-split support
From: netdev-bot+sashiko@kernel.org
To: dimitri.daskalakis1@gmail.com
Cc: davem@davemloft.net, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, leon@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, gal@nvidia.com,
 cratiu@nvidia.com, dtatulea@nvidia.com, noren@nvidia.com, cjubran@nvidia.com,
 bjorn@kernel.org, netdev@vger.kernel.org
Date: Sat, 10 Oct 2026 02:59:30 +0000
Message-ID: <179160117016.434549.2094341982375611260@kernel.org>
In-Reply-To: <20261009025137.2631215-1-dimitri.daskalakis1@gmail.com>
References: <20261009025137.2631215-1-dimitri.daskalakis1@gmail.com>
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

Critical: 0 · High: 0 · Medium: 2 · Low: 2

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch is titled "advertise tcp-data-split support" and
  says it will "Add back tcp-data-split reporting", but…
- [Medium] On an mlx5 device with rx-gro-hw on,
  mlx5e_ethtool_get_ringparam() now reports tcp-data-split='enabled'…
- [Low] The commit message says "This is not a fix" and carries no Fixes:
  tag, but the patch fixes real defects that the message itself…
- [Low] With rx-gro-hw on and dev->cfg->hds_config == UNKNOWN,
  mlx5e_ethtool_get_ringparam() now reports tcp-data-split=enabled from…

--

net/mlx5e: advertise tcp-data-split support

This commit brings back tcp-data-split reporting in
mlx5e_ethtool_get_ringparam() when SHAMPO is active. It also rejects
requests to disable tcp-data-split. Finally, it moves
netdev_update_features() so that it only runs after
mlx5e_ethtool_set_ringparam() succeeds.

> This is not a fix since HDS/tcp-data-split is still functional with HW
> GRO enabled.

[Severity: Low]
Is this accurate? The patch seems to fix problems that the commit message
itself describes:

  - the tcp-data-split reporting that 46bcce5dfd33 dropped from ethtool -g
  - the KeyError in hds.set_hds_enable/disable since d347b28c492e
  - the feature/config de-sync caused by calling netdev_update_features()
    before mlx5e_ethtool_set_ringparam()

For the last one: in the baseline, mlx5e_ethtool_set_tcp_data_split()
called netdev_update_features() before the ring sizes were validated.
mlx5e_fix_features() looks at netdev->cfg_pending:

drivers/net/ethernet/mellanox/mlx5/core/en_main.c:mlx5e_fix_features() {
    ...
	if (cfg && cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
	    !(features & NETIF_F_GRO_HW)) {
    ...
}

Take a request like "ethtool -G ethX rx 1 tcp-data-split off" while
hds_config is ENABLED. HW-GRO/SHAMPO could be turned off first. The
rx_pending minimum check then fails, and the ethtool core discards
cfg_pending. dev->cfg->hds_config stays ENABLED, but the HW is no longer
splitting.

There is no Fixes: tag, so stable tooling won't pick these fixes up for
kernels that contain 46bcce5dfd33 and d347b28c492e. Could the reporting
restore and the netdev_update_features() reordering be split into their
own patches with Fixes: tags? The uAPI behavior change that rejects
tcp-data-split off could then stay separate.

> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> index 261c466a4d362..c30d751cac2fa 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> @@ -378,6 +378,9 @@ void mlx5e_ethtool_get_ringparam(struct mlx5e_priv *priv,
>  
>  	kernel_param->hds_thresh = 0;
>  	kernel_param->hds_thresh_max = 0;
> +
> +	if (priv->channels.params.packet_merge.type == MLX5E_PACKET_MERGE_SHAMPO)
> +		kernel_param->tcp_data_split = ETHTOOL_TCP_DATA_SPLIT_ENABLED;
>  }

[Severity: Medium]
The subject says "advertise tcp-data-split support" and the message says
"Add back tcp-data-split reporting". However, this only ever writes
ENABLED, and only when SHAMPO is active. The code removed by 46bcce5dfd33
also reported DISABLED when SHAMPO was not active.

HW-GRO is off by default on mlx5, since mlx5e_build_nic_netdev() clears
NETIF_F_GRO_HW. In that case:

  - rings_prepare_data() pre-fills tcp_data_split from
    dev->cfg->hds_config (UNKNOWN)
  - the driver leaves it untouched
  - rings_fill_reply() leaves out the attribute:

net/ethtool/rings.c:rings_fill_reply() {
    ...
	    (kr->tcp_data_split &&
	     (nla_put_u8(skb, ETHTOOL_A_RINGS_TCP_DATA_SPLIT,
    ...
}

So user space sees tcp-data-split as unsupported, even though the device
advertises ETHTOOL_RING_USE_TCP_DATA_SPLIT and is in fact not splitting.
The post-patch log in the changelog shows this:

  ok 1 hds.get_hds # SKIP tcp-data-split not supported by device

mlx5e_ethtool_set_tcp_data_split() now also rejects
ETHTOOL_TCP_DATA_SPLIT_DISABLED unconditionally. On a default-configured
device, the off state can then be neither reported nor requested.

Would it be safe to report ETHTOOL_TCP_DATA_SPLIT_DISABLED when SHAMPO is
not active? Both ethtool_ringparam_get_cfg() and the netlink set path
replace the driver-reported value with dev->cfg->hds_config.

[Severity: Low]
With rx-gro-hw on and dev->cfg->hds_config == UNKNOWN, this now reports
enabled. Can hds.set_hds_enable then leave hds_config stuck at ENABLED
after the test finishes?

_defer_reset_hds() saves tcp-data-split as 'enabled' (from SHAMPO state)
set_hds_enable() writes tcp-data-split 'enabled'
  ethnl_set_rings()
    dev->cfg_pending->hds_config = kernel_ringparam.tcp_data_split;
_hds_reset() at cleanup:
    if cur.get('tcp-data-split') != rings.get('tcp-data-split'):

Both values are 'enabled', so 'unknown' is never written back.

After that, mlx5e_fix_features() keeps NETIF_F_GRO_HW forced on, and
"ethtool -K rx-gro-hw off" no longer takes effect. dev_xdp_attach() also
rejects single-buffer XDP:

	if (dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
	    prog && !prog->aux->xdp_has_frags) {

In a full hds.py run, the later set_xdp tests write 'unknown' and hide
this. It shows up when set_hds_enable runs alone, or as the last test that
touches HDS.

The root cause is that the test compares reported state rather than
config, and netdevsim has the same pattern. This patch is what makes it
reachable on mlx5, though. Should _hds_reset() or the driver reporting
be adjusted?

[Severity: Medium]
On mlx5 with rx-gro-hw on, do hds.set_xdp and hds.ioctl_set_xdp now go
from SKIP to FAIL?

Both tests see mode 'enabled', write 'unknown', and then attach a
single-buffer XDP program:

tools/testing/selftests/drivers/net/hds.py:set_xdp() {
    ...
    if mode == 'enabled':
        _defer_reset_hds(cfg, netnl)
        netnl.rings_set({'header': {'dev-index': cfg.ifindex},
                         'tcp-data-split': 'unknown'})

    _xdp_onoff(cfg)
}

If cfg is already UNKNOWN, ethnl_set_rings() returns 0 on !mod and the
'unknown' write does nothing. Otherwise it only clears the config, and
GRO_HW stays wanted. Either way SHAMPO stays active:

mlx5e_xdp_set()
  mlx5e_xdp_allowed()
	if (params->packet_merge.type != MLX5E_PACKET_MERGE_NONE) {
		netdev_warn(netdev, "can't set XDP while HW-GRO/LRO is on, disable them first\n");
		return -EINVAL;

The log in the changelog only covers the HW-GRO off case, where these
tests are skipped. Was the HW-GRO on configuration tested as well?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261009025137.2631215-1-dimitri.daskalakis1%40gmail.com
