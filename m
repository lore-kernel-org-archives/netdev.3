Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965143E2AB6
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 22:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792104730; cv=none; b=TtJl0/irEl96P99koACGyX3/mkJDg1oYJeGifSc7oYdFdA23utrtqhZxzTCdVfor4SR0EulLjYUTMxFvS46RaWqPIm9fRG2iIYY6+PYXF+xdxhFqSZSrppn5umOWh93B1SYgf953mpVOKTJ1My/VIvT3xS4fL6dG4B15yuInMJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792104730; c=relaxed/simple;
	bh=eD+XOczd0SOv/IS2MeWlFj8VnT4R4KP7o4oKX6lQ/tc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s7yKPHw6Iuf1g5K7rZZ/8AwSZEhPCg3AtEGhdnLeSMEjKe/FIiZ1X7VMSkvzMEVs1PdvYvxfQUIPGkJOoxkFYAdbH3HlRUcDhNhkGDvGZKRG9eQy2GL6ufKTK2J/atf5OHcmXk7tN+1yR/XwtYKpRiHK3BVsJnmkTOFHBqlG79o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rolLzD4Q; arc=none smtp.client-ip=74.125.82.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rolLzD4Q"
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-144f79153f5so400935c88.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 15:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792104728; x=1792709528; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jNlpzIcecwwaTDv1YwZkM4sHbEeZr9KYjPYll1ofctc=;
        b=rolLzD4QQnnycEpUA2sr0lYTaKOpXw7hDW243TPETGaoOSh7rCJcr1DSlNveLdsL4J
         Oo5uTBnRqLYWpGSmH/CtJjNhasDEktSV79kqTVd3HCp/i+CBeCNx+diagWyDQa2j4DoM
         qI7MOUPcByloi4FLPiwzNMncHhYDdWgwKVIg0qf3ZnuhrS5CXej8Z7MiCyRoJRW4Dfd8
         b2jDu9KLM9261L9VBrhW6cImviG6LuLQy/YGVkcOFF3Iu87vwPizr05nr/TqdrRRrRHb
         VnpvS5QPn7z9Oy7mUKFpeMbOw4q7uJIpzgOs/q2EWpRtHkzECvMwEND1/waevgJGqMdo
         GPdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792104728; x=1792709528;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jNlpzIcecwwaTDv1YwZkM4sHbEeZr9KYjPYll1ofctc=;
        b=Q6Z9lH02NG3Cufw6kYbQRG3yUCHC+zJ0ZPkq8EFz+pRPXsR1nUhgHoOpTX+3lQlEqj
         i+aryuiDkdrWPlnBYJi+dkbLJB7eIrw4PLoybIACt6iN5uKIfAtgdG/M2aC/RfuMUBpS
         f/iZbuCIE4HPqzhF8sxc+ATApBa6WRey+BzJC9NOWbJNIazznzuqlm3C5PdGyTtZ6siW
         BJKvtSWqFkC8e/P7v3l1BCGAdGe1xZFqjW1m+k6VKpJiej0kUphdjpzqDDE10p7r5KzT
         Oep68HZaq++V3iVRw08+7O4DTZg6w99VJH8HNL6+W7omCslUmoWYH9vjkvGEG1nR7Qle
         qNQw==
X-Forwarded-Encrypted: i=1; AKwUvBw38DxRgYy0I6i0kVky7HtirdWKEx9eoKSWT7UoGAwmWj1NQVkS8OrVjq1iUpjdYwWvknoXgHA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJQC9CJy9q/ik9DWLbeg+jKJWUHf4l6hKJCmnvJwIEy5snUdXNo
	bRex2tU6PA2Pv35/KYlCVF9l8uZ5vPvGDGuiD+9DdQMwb/AvpJ2DZCU+
X-Gm-Gg: AYBFou0upxrN3QmGJNNr/7NjiQJwr5U2w8WsX4tL07PIhPWaIEqqNn4VQ5fNxWAVr1K
	FGUJRt9X9FQXOE81wuuzKPU5VX+L9+/SQrFO6NCOOx27XtFC4MOPIMSPY6E6Qv39RDqXhy/P9tO
	VzcUxggac9hcQ5buNYFlrHroHOFlXle/cl91t5ca3TTBOjQHog1SO5zaLJ3tEzbodCG/BCCC/w9
	ScRHfgPF17PvZmjvDINWDmIY6ta4jP1UwB+C12dt9iuve0CY5IX7bJe2o+7jULW5leZy+6Chzri
	554jl062xD6z1p7iOrtvBsCoo60xmrzQlaK/MnIokruniE4oJWK3evLBkPDrurOCwb4gZtA0PBY
	n58MXbAc+cvoHg/M5rey27jZrus+pktVhhC+2lzrhpN1J3IfowOVqxHzs+edbmM8TT27FZHSdmF
	OqbiIVU2mRaVJAc8qIP6iz1quuwMGeE2OvUbBgr+LOp+xelwHDzLQv71kFKNqHDLvJ3vMn7bLjq
	V1k86dDEo/1HS7st/L4nhcjH7AVQmkXI/KZr6pIKA18NSGJS8me76zuRxkEyg==
X-Received: by 2002:a05:7022:b0c5:b0:182:61f2:d818 with SMTP id a92af1059eb24-18261f2d979mr1360645c88.5.1792104727370;
        Thu, 15 Oct 2026 15:52:07 -0700 (PDT)
Received: from ?IPV6:2a03:83e0:1151:15:c24:4ad9:f660:1904? ([2620:10d:c090:500::5:d964])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1831b37ce3fsm532896c88.14.2026.10.15.15.52.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2026 15:52:06 -0700 (PDT)
Message-ID: <e34eba12-ecab-4215-b75b-eea3e29fefb2@gmail.com>
Date: Thu, 15 Oct 2026 15:52:05 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3] net/mlx5e: advertise tcp-data-split support
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, leon@kernel.org, andrew+netdev@lunn.ch,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, gal@nvidia.com,
 cratiu@nvidia.com, dtatulea@nvidia.com, noren@nvidia.com,
 cjubran@nvidia.com, bjorn@kernel.org, netdev@vger.kernel.org
References: <20261009025137.2631215-1-dimitri.daskalakis1@gmail.com>
 <179160117016.434549.2094341982375611260@kernel.org>
Content-Language: en-US
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
In-Reply-To: <179160117016.434549.2094341982375611260@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/9/26 7:59 PM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 2 · Low: 2
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The patch is titled "advertise tcp-data-split support" and
>   says it will "Add back tcp-data-split reporting", but…
> - [Medium] On an mlx5 device with rx-gro-hw on,
>   mlx5e_ethtool_get_ringparam() now reports tcp-data-split='enabled'…
> - [Low] The commit message says "This is not a fix" and carries no Fixes:
>   tag, but the patch fixes real defects that the message itself…
> - [Low] With rx-gro-hw on and dev->cfg->hds_config == UNKNOWN,
>   mlx5e_ethtool_get_ringparam() now reports tcp-data-split=enabled from…
> 
> --
> 
> net/mlx5e: advertise tcp-data-split support
> 
> This commit brings back tcp-data-split reporting in
> mlx5e_ethtool_get_ringparam() when SHAMPO is active. It also rejects
> requests to disable tcp-data-split. Finally, it moves
> netdev_update_features() so that it only runs after
> mlx5e_ethtool_set_ringparam() succeeds.
> 
>> This is not a fix since HDS/tcp-data-split is still functional with HW
>> GRO enabled.
> 
> [Severity: Low]
> Is this accurate? The patch seems to fix problems that the commit message
> itself describes:
> 
>   - the tcp-data-split reporting that 46bcce5dfd33 dropped from ethtool -g
>   - the KeyError in hds.set_hds_enable/disable since d347b28c492e
>   - the feature/config de-sync caused by calling netdev_update_features()
>     before mlx5e_ethtool_set_ringparam()
> 
> For the last one: in the baseline, mlx5e_ethtool_set_tcp_data_split()
> called netdev_update_features() before the ring sizes were validated.
> mlx5e_fix_features() looks at netdev->cfg_pending:
> 
> drivers/net/ethernet/mellanox/mlx5/core/en_main.c:mlx5e_fix_features() {
>     ...
> 	if (cfg && cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
> 	    !(features & NETIF_F_GRO_HW)) {
>     ...
> }
> 
> Take a request like "ethtool -G ethX rx 1 tcp-data-split off" while
> hds_config is ENABLED. HW-GRO/SHAMPO could be turned off first. The
> rx_pending minimum check then fails, and the ethtool core discards
> cfg_pending. dev->cfg->hds_config stays ENABLED, but the HW is no longer
> splitting.
> 
> There is no Fixes: tag, so stable tooling won't pick these fixes up for
> kernels that contain 46bcce5dfd33 and d347b28c492e. Could the reporting
> restore and the netdev_update_features() reordering be split into their
> own patches with Fixes: tags? The uAPI behavior change that rejects
> tcp-data-split off could then stay separate.
> 

The lack of tcp-data-split reporting that d347b28c492e introduced does not
cause any user facing issues, so this does not warrant a standalone Fix.

The early call to netdev_update_features() is a real bug. A user can get
themselves into a state where all ring changes are blocked. I've been able
to verify this on a 6.16 kernel. Fortunately this state is not terminal,
users can recover by setting rx-gro-hw on. I'll send the Fix to net.

>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
>> index 261c466a4d362..c30d751cac2fa 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
>> @@ -378,6 +378,9 @@ void mlx5e_ethtool_get_ringparam(struct mlx5e_priv *priv,
>>  
>>  	kernel_param->hds_thresh = 0;
>>  	kernel_param->hds_thresh_max = 0;
>> +
>> +	if (priv->channels.params.packet_merge.type == MLX5E_PACKET_MERGE_SHAMPO)
>> +		kernel_param->tcp_data_split = ETHTOOL_TCP_DATA_SPLIT_ENABLED;
>>  }
> 
> [Severity: Medium]
> The subject says "advertise tcp-data-split support" and the message says
> "Add back tcp-data-split reporting". However, this only ever writes
> ENABLED, and only when SHAMPO is active. The code removed by 46bcce5dfd33
> also reported DISABLED when SHAMPO was not active.
> 
> HW-GRO is off by default on mlx5, since mlx5e_build_nic_netdev() clears
> NETIF_F_GRO_HW. In that case:
> 
>   - rings_prepare_data() pre-fills tcp_data_split from
>     dev->cfg->hds_config (UNKNOWN)
>   - the driver leaves it untouched
>   - rings_fill_reply() leaves out the attribute:
> 
> net/ethtool/rings.c:rings_fill_reply() {
>     ...
> 	    (kr->tcp_data_split &&
> 	     (nla_put_u8(skb, ETHTOOL_A_RINGS_TCP_DATA_SPLIT,
>     ...
> }
> 
> So user space sees tcp-data-split as unsupported, even though the device
> advertises ETHTOOL_RING_USE_TCP_DATA_SPLIT and is in fact not splitting.
> The post-patch log in the changelog shows this:
> 
>   ok 1 hds.get_hds # SKIP tcp-data-split not supported by device
> 
> mlx5e_ethtool_set_tcp_data_split() now also rejects
> ETHTOOL_TCP_DATA_SPLIT_DISABLED unconditionally. On a default-configured
> device, the off state can then be neither reported nor requested.
> 
> Would it be safe to report ETHTOOL_TCP_DATA_SPLIT_DISABLED when SHAMPO is
> not active? Both ethtool_ringparam_get_cfg() and the netlink set path
> replace the driver-reported value with dev->cfg->hds_config.
> 

It's safe to report ETHTOOL_TCP_DATA_SPLIT_DISABLED based on the SHAMPO
state. The set path safely ignores what get returns. Will update this in
the next version.

> [Severity: Low]
> With rx-gro-hw on and dev->cfg->hds_config == UNKNOWN, this now reports
> enabled. Can hds.set_hds_enable then leave hds_config stuck at ENABLED
> after the test finishes?
> 
> _defer_reset_hds() saves tcp-data-split as 'enabled' (from SHAMPO state)
> set_hds_enable() writes tcp-data-split 'enabled'
>   ethnl_set_rings()
>     dev->cfg_pending->hds_config = kernel_ringparam.tcp_data_split;
> _hds_reset() at cleanup:
>     if cur.get('tcp-data-split') != rings.get('tcp-data-split'):
> 
> Both values are 'enabled', so 'unknown' is never written back.
> 
> After that, mlx5e_fix_features() keeps NETIF_F_GRO_HW forced on, and
> "ethtool -K rx-gro-hw off" no longer takes effect. dev_xdp_attach() also
> rejects single-buffer XDP:
> 
> 	if (dev->cfg->hds_config == ETHTOOL_TCP_DATA_SPLIT_ENABLED &&
> 	    prog && !prog->aux->xdp_has_frags) {
> 
> In a full hds.py run, the later set_xdp tests write 'unknown' and hide
> this. It shows up when set_hds_enable runs alone, or as the last test that
> touches HDS.
> 
> The root cause is that the test compares reported state rather than
> config, and netdevsim has the same pattern. This patch is what makes it
> reachable on mlx5, though. Should _hds_reset() or the driver reporting
> be adjusted?
> 

This issue is unique to mlx5 since tcp-data-split is tied to HW-GRO. We
shouldn't modify a generic test to account for this coupling.

> [Severity: Medium]
> On mlx5 with rx-gro-hw on, do hds.set_xdp and hds.ioctl_set_xdp now go
> from SKIP to FAIL?
> 
> Both tests see mode 'enabled', write 'unknown', and then attach a
> single-buffer XDP program:
> 
> tools/testing/selftests/drivers/net/hds.py:set_xdp() {
>     ...
>     if mode == 'enabled':
>         _defer_reset_hds(cfg, netnl)
>         netnl.rings_set({'header': {'dev-index': cfg.ifindex},
>                          'tcp-data-split': 'unknown'})
> 
>     _xdp_onoff(cfg)
> }
> 
> If cfg is already UNKNOWN, ethnl_set_rings() returns 0 on !mod and the
> 'unknown' write does nothing. Otherwise it only clears the config, and
> GRO_HW stays wanted. Either way SHAMPO stays active:
> 
> mlx5e_xdp_set()
>   mlx5e_xdp_allowed()
> 	if (params->packet_merge.type != MLX5E_PACKET_MERGE_NONE) {
> 		netdev_warn(netdev, "can't set XDP while HW-GRO/LRO is on, disable them first\n");
> 		return -EINVAL;
> 
> The log in the changelog only covers the HW-GRO off case, where these
> tests are skipped. Was the HW-GRO on configuration tested as well?
> 
> [ ... ]
> 

It's fine for these test to fail given mlx5's HW-GRO and tcp-data-split
coupling.

