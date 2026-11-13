Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794592787;
	b=01pyak35KXmqB7+9HZGAOUIpUyreXhjePXtKy/nlOfnP/Tuu4h3qHUZUzIA7bA+Yok9c
	 ar8BMWv7U8fka0jRR6wQklbN6H5o9jjX5u6Hn5cN+CZNrNIcsH9Enk5gNU5GewSGNfdnE
	 pfVJ2P2jf5wMCkFJFyxq6AyMH9PnjrL8sp7f/GlUvGU2Q54f5eWFfZYPZ7Tn64KyB+5NK
	 OqapaWHoPcgXgFzrwKtx5vD8YHYbi3VTnmW2JMIc5vvQiUc1tEhrxMUSGyFc9IoRIK9u/
	 2yIezYM8ZvPkoCFwLj9ovDKymgiCYsZgsDxO47ZrYsPkU+HeLdIYppYwiEZrAHeTGMQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592787;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=R8eGGLrBqtU1dAaaAxOv8oUMtPjBsptJLEN7IG7W8WA=;
	b=M+UQVUsRZTaygYi6/QFy8hziDL7cbaHIXDQL1J1n+Fm4AiDoM4SR1omo5Dk/uvbyagw8
	 2uJrIGlZEjyy+0lhB2dEB+XAg4cd8UN7UXzMviWsuOh2ZsyaZqJ+BsxcE6BU+IfH4toSO
	 cp/c0/PkEJrNs6p7iFTJMD66yeENOkXABPZ548Bgowe3gVlAzRtjEysRust4WR5qTjVzB
	 WDvlXUd3OXZhe5/uvi4aGKbxReq/5/b20O/LB3j44OgAQ3vbEE8KRBE/motdY8ukmatla
	 inwbGXccqrgwuPpGtYwdCjzceouwYIMJgL5ATA4eW7kzf3hCNTZe9O1ztNv9FFsPaZg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aB9hxtMs;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD1E606D48E
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 17:59:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FD1E606D48E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=aB9hxtMs
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1b24f4b15c4so732758c88.1
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 09:59:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794592786; x=1795197586; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R8eGGLrBqtU1dAaaAxOv8oUMtPjBsptJLEN7IG7W8WA=;
        b=aB9hxtMsUtUy/WO3HJNs9t3LyHymjQmC5rU6dMvjd7eP3CPheNuXBRPFRGttCTd6IV
         MV8ECAdkqxaD3ViQmAUqDegMfQflR9Qo9QkMpFAly/W6g4ooZHgypdNeHK8AK/QJoBHp
         GZ/IEn1m+JE3Ep1hbWvlkLFJZSmheGgA+DpUTifPivgEmJ5hCSSo1abCSPbxfo0+/8fc
         NkagsnFt7KF6AjCTE8dW4HghOr5SP+SYzl5GHg2LX3RW2N/H4hHHNO3cAZceaxOyR0WI
         fjykS3/zXf17ifffcpliGcaH0bU8QZI5kw6006s065VjsIw02/PmODcGVIuIgtuWhDTm
         7NZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794592786; x=1795197586;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R8eGGLrBqtU1dAaaAxOv8oUMtPjBsptJLEN7IG7W8WA=;
        b=o7o9xi/yitJOAkFxafv3PcaFNcRA7w2uL8Z7oRQ0D98q7Awuta0VDJXdAVbXn7+8xG
         YHPf7EIyPploteGm5S4tHOvJU05T4mGbvERaykEAM90Yj8qiuZWLYJWdTtYoWHbcvGKE
         Nqc4cp+qk2+4baDazIIlv6RABjWBy1RKgD1+LNXQvnWBVLYhPg+E4kXcOfmtHYb5DjFb
         YthGO5KoW9n993KyWEnUj/TvpxL2lwVnoD7gQpe5tGw0oDY1n4zP2xeWita60mqWest3
         6dl5NwaA577ViEGNm1BCWsX/e0CHP7Zs8y6kYk3BJYrhnivuHJJGCI5fepJCn/DLyZq9
         OSfA==
X-Forwarded-Encrypted: i=1; AL+hErFXpUBq3dRPu8bADtJ6QhBhoXh0cHd1eGIbe/Pkaoq/Eg4mB2urMnQEBo/XK9FjI4QRr3eFTKM=@vger.kernel.org
X-Gm-Message-State: APuU4Z+wwfQrOXow1HEvnj9eKyE/unsCokscIXk2sbAJhXJQSFNkBnqi
	Ixp1URsTIJZvg2oRUH0K4ZbV18tiUKhExer1fsmPaLbq3hXIMLesmirF
X-Gm-Gg: AYBFou07X3gRCu5FQyHL1+Y/lPB3tR+k/kfJdvuNbp11182XtmqFmgub77/0VjbeILU
	LNjcJeD9LCt0yp8qyXAi6ZqR+LUM3GuSv+cL4D3Gn9VN6y5JOBjTXf07KOAZv//2UIwxUeyb/XP
	bNcX8UIKAeRw7AY3AfhurpsCFvagokBFc79qjdnmHBAu/mAZly6grMnYS/qxdRDKt4CmbFTz9qA
	jwbPkrenvpnb83ucYuLtESMl7hcsFTONNnqxz24RPG5aOMDOurYfBXY/U5yY8jMl8tDp/8fKBCG
	y93epp14eQ+tJ4xZwL6LB/jjPkNObOn9agyjOULAxM/3v21DtCV/4IofzLXlWluPz7kC+ZXzKg4
	MjyRbsNILRHov6Y0UtTuUs5spm1FdCViUC8iOdiAuPxUC8qpC1siFCpcLR65pcNcgtItGko8vhK
	Ic+sWNWVKQN+pcB0569tCemLDgttNAyML7gtO8P54fGkRzTGtpybVa6FCsVD1LsYEX9G4cIzDqq
	ZM8Ww7sR0VeTsLEr2OKPHfpz2rhAevkuxcm+1ySVLVMkQac1tB3hKYH2XviI1lKVGPRENck2DoH
	Pn5Tr1z8Wri9UBveRdplwnAYvUJphbBo6P+XBW0SYRyY1Y68Cbep3UTWv9+E444NPIEcU46dPO3
	FfTJXYg1gU+Id4819
X-Received: by 2002:a05:7022:ea47:20b0:17a:a3d4:8b17 with SMTP id a92af1059eb24-1b5030990d0mr2764888c88.12.1794592785316;
        Fri, 13 Nov 2026 09:59:45 -0800 (PST)
Received: from ?IPV6:2a03:83e0:1151:15:c24:4ad9:f660:1904? ([2620:10d:c090:500::7:36be])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b50316e195sm10300692c88.8.2026.11.13.09.59.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 13 Nov 2026 09:59:44 -0800 (PST)
Message-ID: <d8d1c197-8c6e-4eae-ad67-fc6a6f8f9d8c@gmail.com>
Date: Fri, 13 Nov 2026 09:59:43 -0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v4] net/mlx5e: advertise tcp-data-split support
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, saeedm@nvidia.com, tariqt@nvidia.com,
 mbloch@nvidia.com, leon@kernel.org, andrew+netdev@lunn.ch,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, gal@nvidia.com,
 cratiu@nvidia.com, dtatulea@nvidia.com, noren@nvidia.com,
 cjubran@nvidia.com, bjorn@kernel.org, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org
References: <20261111170558.1654691-1-dimitri.daskalakis1@gmail.com>
 <179455718216.2199510.10119051325167179247@kernel.org>
Content-Language: en-US
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
In-Reply-To: <179455718216.2199510.10119051325167179247@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 11/13/26 12:06 AM, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 1 · Low: 1
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] mlx5e_get_ringparam() now reports tcp-data-split as ENABLED
>   whenever SHAMPO is active, even when dev->cfg->hds_config is still…
> - [Low] The patch has no Fixes: tag, even though its commit message
>   describes regressions caused by commit 46bcce5dfd33 ("net/mlx5e:…
> 
> --
> 
> net/mlx5e: advertise tcp-data-split support
> 
> On devices that support HW-GRO, mlx5e_get_ringparam() now reports
> tcp-data-split as enabled when SHAMPO is active and as disabled otherwise.
> The patch also rejects disabling tcp-data-split while HW-GRO is on.
> mlx5e_fix_features() now keeps HW-GRO off when tcp-data-split is disabled.
> 
>> Since commit 46bcce5dfd33 ("net/mlx5e: Support ethtool tcp-data-split
>> settings"), mlx5 no longer reports tcp-data-split from
>> mlx5e_ethtool_get_ringparam() and the reply carries only the stored
>> config. With the default config (auto) the attribute is omitted, so the
>> device looks like it does not support tcp-data-split, even while HW-GRO
>> is on and SHAMPO is splitting headers.
> 
> [Severity: Low]
> This isn't a bug, but should this patch carry a Fixes: tag?
> 
> The commit message names 46bcce5dfd33 as the cause. That commit removed
> the assignment of kernel_param->tcp_data_split from the SHAMPO state in
> mlx5e_ethtool_get_ringparam().
> 
> Since then, rings_prepare_data() seeds the value from
> dev->cfg->hds_config. rings_fill_reply() only emits
> ETHTOOL_A_RINGS_TCP_DATA_SPLIT when the value is non-zero, so in auto mode
> the attribute is missing.
> 
> 46bcce5dfd33 also enforced only one direction in mlx5e_fix_features().
> This patch restores the reporting and adds the missing direction, so
> would this be appropriate:
> 
> Fixes: 46bcce5dfd33 ("net/mlx5e: Support ethtool tcp-data-split settings")
> 
> Without the tag, stable kernels that contain 46bcce5dfd33 would keep the
> missing attribute in auto mode.
> 

The fix was for updating netdev features after a successful ring param
change. That was sent here [1].

As for the rest of this patch, it's more of a user behavior change than a
fix. The HW splitting capability still works when GRO is enabled, it's just
reporting to the stack/user that gets corrected.

[1] https://lore.kernel.org/all/20261017005401.1582755-1-dimitri.daskalakis1@gmail.com/

>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
>> index 1f534051cdfe4..8e7c748caf2d2 100644
>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
>> @@ -388,6 +388,13 @@ static void mlx5e_get_ringparam(struct net_device *dev,
>>  	struct mlx5e_priv *priv = netdev_priv(dev);
>>  
>>  	mlx5e_ethtool_get_ringparam(priv, param, kernel_param);
>> +
>> +	if (dev->hw_features & NETIF_F_GRO_HW)
>> +		kernel_param->tcp_data_split =
>> +			priv->channels.params.packet_merge.type ==
>> +			MLX5E_PACKET_MERGE_SHAMPO ?
>> +			ETHTOOL_TCP_DATA_SPLIT_ENABLED :
>> +			ETHTOOL_TCP_DATA_SPLIT_DISABLED;
>>  }
> 
> [Severity: Medium]
> With this change, tcp-data-split is reported as enabled whenever SHAMPO
> is active, even while dev->cfg->hds_config is still auto
> (ETHTOOL_TCP_DATA_SPLIT_UNKNOWN). Does this break the XDP cases in
> tools/testing/selftests/drivers/net/hds.py?
> 
> With HW-GRO on, set_xdp() and ioctl_set_xdp() now see 'enabled' and set
> tcp-data-split back to 'unknown'. hds_config is already unknown, so
> ethnl_set_rings() sees no change and returns without calling the
> driver. HW-GRO and SHAMPO stay on.
> 
> The core checks in dev_xdp_attach() and netif_xdp_propagate() only
> reject single-buffer XDP when hds_config is
> ETHTOOL_TCP_DATA_SPLIT_ENABLED. The request therefore reaches the driver,
> and mlx5e_xdp_allowed() rejects it:
> 
> 	if (params->packet_merge.type != MLX5E_PACKET_MERGE_NONE) {
> 		netdev_warn(netdev, "can't set XDP while HW-GRO/LRO is on, disable them first\n");
> 		return -EINVAL;
> 
> That matches "not ok 9 hds.set_xdp" and "not ok 12 hds.ioctl_set_xdp" in
> the posted run. Before this patch, ioctl_set_xdp found the attribute
> missing in auto mode and skipped.

It's fine for set_xdp() and ioctl_set_xdp() to fail. We should not modify the test
to account for mlx5's tcp-data-split and HW-GRO coupling.

> 
> In auto mode with HDS reported as on, the ring param also can't be used
> to turn HDS off. mlx5e_ethtool_set_tcp_data_split() now rejects
> 'disabled' while HW-GRO is on.
> 
> With HW-GRO off, enabled_set_xdp() and ioctl_enabled_set_xdp() call
> rings_set() with tcp-data-split set to 'enabled' and no exception
> handling. The driver now returns -EINVAL for that request.
> 

The above two cases are expected behavior. If HW-GRO is on, users
cannot disable tcp-data-split. And vice-versa, if HW-GRO is off users
cannot enable tcp-data-split.

> The "SKIP enabling of HDS not supported by the device" lines in the
> posted results don't seem to exist anywhere under
> tools/testing/selftests/. Did those results come from a locally modified
> hds.py?
> 

This was from a local change I forgot to revert. Here's the results from an
unmodified hds.py with HW-GRO disabled.

# Interface: eth0, driver: mlx5_core
TAP version 13
1..13
ok 1 hds.get_hds
ok 2 hds.get_hds_thresh
ok 3 hds.set_hds_disable
ok 4 hds.set_hds_enable # SKIP disabling of HDS not supported by the device
ok 5 hds.set_hds_thresh_random # SKIP hds-thresh-max is too small
ok 6 hds.set_hds_thresh_zero
ok 7 hds.set_hds_thresh_max
ok 8 hds.set_hds_thresh_gt
ok 9 hds.set_xdp
# Exception| Traceback (most recent call last):
...
# Exception| net.lib.ynl.pyynl.lib.ynl.NlError: Netlink error: mlx5_core: TCP-data-split can not be enabled without HW-GRO, set it to 'auto' and enable HW-GRO first: Invalid argument
# Exception|
not ok 10 hds.enabled_set_xdp
ok 11 hds.ioctl
ok 12 hds.ioctl_set_xdp
# Exception| Traceback (most recent call last):
...
# Exception| net.lib.ynl.pyynl.lib.ynl.NlError: Netlink error: mlx5_core: TCP-data-split can not be enabled without HW-GRO, set it to 'auto' and enable HW-GRO first: Invalid argument
# Exception|
not ok 13 hds.ioctl_enabled_set_xdp

The failures are acceptable, we should not modify the selftest to account for mlx5's
tcp-data-split and HW-GRO coupling. 

> Because of the _hds_reset() logic in hds.py, some of these cases could
> already fail before this patch, depending on test order.
> 
> Should hds.py be updated together with this change? If not, could the
> commit message mention the expected hds.py failures on mlx5?
> 
> [ ... ]
> 

Updates to hds.py have already been merged [2]. The behavior here is expected.
If this series needs a re-spin for other reasons, I can modify the commit message.

[2] https://lore.kernel.org/all/20261106031208.465456-1-dimitri.daskalakis1@gmail.com/
