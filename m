Received: from mail-pj2-f40.google.com (mail-pj2-f40.google.com [74.125.227.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CA036998C
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 18:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790794604; cv=none; b=vAmgKCso1Zhj9TWfySe3xLSXqdEBwhoPEmtddb7XLuMSL6nKU6fxofy7rMoOTzjzj09SXfqWLA8jiI0ARWZ50L+nMCyPLdmNOYeTW1g2uzVy6Mlyi8vKGK0joRezwNKiQO1+dZyG/+/Xv8TLAAK5msC84RxlPc2hwzwpqF/8OxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790794604; c=relaxed/simple;
	bh=rViubhqoHWGmFuA+3F3qZEwr/cb55uT503SdmRwifAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J1EiBK5JJEFvKm5t7JI27jy74D+PPpJcoj2mud9ay4N/gAGJGqM2bPm4/TMRXoXmwU/NSRRc0A/01JTyq5vNkuq9+wCOJyJ8AKWmANnBeIMazuVYGpQbGT6TUUZxL1QTrZVYyU0L3MrEbukGmU6jkEV2n4FoyXIa4VYZIu6A52k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C6+T7n2B; arc=none smtp.client-ip=74.125.227.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C6+T7n2B"
Received: by mail-pj2-f40.google.com with SMTP id d9443c01a7336-2dfaf76605dso17755245ad.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 11:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790794603; x=1791399403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=O+20kIxHtKb9U+2Mk1J4J3Aam69vUTJ/KamdQlNU6l8=;
        b=C6+T7n2Bp3xi6EtcxXqWoc8TVsdpp9xmfEfpuTaGR4XHyB7G5YQ/FeFTUF9u/ym3eO
         fZNvLaaJK8L7fJ3cgxtIfyH9urnB0MOC6ak9Y0TMXi4gSrt2w3OvjpBw3c5DJ+Jjc3qT
         SktvlA91XrgKCkogImeITGOIvUVj4Te+ZZkEPw8pCfgB2se2quTVmz1wsMwggJ6d85xM
         K6ZAaUnlrHUsgnggI6HSkxy6M+AsfEJ0qIa4UdkL4xcVLv5qz9epQMapKCSrZ/SxY75x
         1rT1JZysA/8O+lafBPOJtolrQUYmhB2OzlWjVeWWd6t1QcFEfdDm0ooUDEyHcfTZkcm7
         0Fjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790794603; x=1791399403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O+20kIxHtKb9U+2Mk1J4J3Aam69vUTJ/KamdQlNU6l8=;
        b=U/j6Iy5GtcTDtscBC+KuYa7/PtDXjjQt03TnqTjuJvGPbs2hLcSeHgQQg2QzBoNECt
         gdgftuOiW+J5NGz/LPJu/e2Kox8Bk02Tfl4qpJlb/Ha/jUuGBuk3lJGkXsUEpwh/jEMx
         clSHxc1JQzNfY62VPiK62eDGdIWH+nYzJOnekpfzUuOMDkhecP8YrdEDJuRHKlgFqG/n
         +PJ2LkCikC9xdtxfRsAKOe/LOlovBvfWyexqAJMOOQxyXOBd/9nVVYL7FFsam088n53E
         reRdoo12XiosIMkIGl0/o98Q3qDHivjDw7ccYbuPGh4doQKLMMizszZ8cHEMJwwj8ufw
         AV3A==
X-Forwarded-Encrypted: i=1; AKwUvBw3Vo3/lCOSc5yRoT2K3001nHeVOuVdxYjWrsBplUMe5ap1Wzc3Jg1ibkFomtpUMkdgxY9YNFI=@vger.kernel.org
X-Gm-Message-State: AFq9FYKrSoAUTVoUezVjALs3s7ul9Iel9gYx5OAk+O4OkisU1Q2QMMGk
	8HROUcjLVk6NcKyYMLwOUVQVSJ9gjri2rM5Ix4UgblicW1inatkpzm6D
X-Gm-Gg: AYBFou1CLPKV3E1YDXr9ucLVmI0M6JgNG6b8zLjoz4Ya1ukSBdzEVWrsqGYf0b4PV6J
	mlbTO5DXPMhG4NYkkcMUM7nHE2uxX8w/BaqWP5C48EDdxnvslznD91+gaXVlK7X4XgndD5c8k81
	0nqx7E85jNClKkBn3DMtuCCIsVThm5nN6K9wqs0HUtwdJ2m+tFmGZN0Oz9wNRHN+FHI1PP+hYxb
	TszmykKQtN1EwOOXRo1doWZidEyRZysGoCJqFKM6LWAhKUerQnjq1WKKPLzVdQAr+Aar0aKY9cI
	bXHwmbbA+M2qMa/V+mHBcBqtC7JTh2cQGVu35gxObQrCHkEfqC8OiGiOibbhEuQTkm+OXBiGe1R
	JRY2k+xUUSBr27BCR8NWdBxBBQT+o7lKeDb6+xVzGjmnJRnbV88QUFU9uyVuejdxAtPI9gzohtv
	w4m/5lL2nelWcSE+hUTvsfXKvlKyvwJ1PUsfo/xOwMaQkfmvxqcLx5U8a/S40xa63OqUfUA78oI
	wB0/A==
X-Received: by 2002:a17:902:fda5:b0:2e2:d77b:e576 with SMTP id d9443c01a7336-2e2e4be9d57mr19027845ad.49.1790794602544;
        Wed, 30 Sep 2026 11:56:42 -0700 (PDT)
Received: from localhost ([2a03:2880:7ff:59::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e30099ac1csm1531185ad.20.2026.09.30.11.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 11:56:42 -0700 (PDT)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	davem@davemloft.net,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	leon@kernel.org,
	andrew+netdev@lunn.ch,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	gal@nvidia.com,
	cratiu@nvidia.com,
	dtatulea@nvidia.com,
	noren@nvidia.com,
	cjubran@nvidia.com,
	netdev@vger.kernel.org
Subject: Re: [PATCH net-next] net/mlx5e: advertise tcp-data-split support
Date: Wed, 30 Sep 2026 11:56:36 -0700
Message-ID: <20260930185641.3303158-1-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <179055126371.3145.7187403042173989856@kernel.org>
References: <20260923230521.1267511-1-dimitri.daskalakis1@gmail.com> <179055126371.3145.7187403042173989856@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Sep 27, 2026 at 11:21:03PM +0000, netdev-bot+sashiko@kernel.org wrote:
> > The ability to set tcp-data-split was introduced in
> > commit 46bcce5dfd33 ("net/mlx5e: Support ethtool tcp-data-split settings")
> > This commit dropped reporting from mlx5e_ethtool_get_ringparam()
> > without explaining why.
>
> [Severity: Low]
> The assignment added here is the same one that 46bcce5dfd33 removed from
> mlx5e_ethtool_get_ringparam(). The message also names both commits that
> led to the selftest failure.
>
> Should this have a Fixes: tag, for example:
>
> Fixes: 46bcce5dfd33 ("net/mlx5e: Support ethtool tcp-data-split settings")
>
> so that stable and backport tooling picks it up?

The feature is still usable. Without the advertisement some selftest
expectations break. That's why I did not include a Fixes: tag.

> > +	kernel_param->tcp_data_split =
> > +		(priv->channels.params.packet_merge.type == MLX5E_PACKET_MERGE_SHAMPO) ?
> > +		ETHTOOL_TCP_DATA_SPLIT_ENABLED :
> > +		ETHTOOL_TCP_DATA_SPLIT_DISABLED;
>
> [Severity: Medium]
> What does this report on a device that cannot do SHAMPO at all?
>
> [...]
>
> Should the value stay ETHTOOL_TCP_DATA_SPLIT_UNKNOWN when the device
> lacks SHAMPO support? For example, the driver could check the SHAMPO
> capability, or whether NETIF_F_GRO_HW is in priv->netdev->hw_features,
> before reporting ENABLED or DISABLED.

My thought was to restore the code that previously existed. But it should be
fine to gate this on the device's HW-GRO support.

> [Severity: Medium]
> Can this report "enabled" right after a "tcp-data-split off" request has
> succeeded?
>
> [...]
>
> With rx-gro-hw on, wouldn't set_hds_disable() in hds.py still fail?
> It would now fail on ksft_eq('disabled', rings['tcp-data-split'])
> instead of the KeyError.
>
> Should the driver actually turn SHAMPO off for DISABLED, or reject the
> request?

mlx5e_ethtool_set_tcp_data_split() can be modified to reject tcp-data-split
disables if rx-gro-hw is enabled. I'm ok with this,
but if any maintainers disagree please let me know.

> [Severity: Medium]
> HW-GRO is off by default, so this now reports "disabled" and
> _get_hds_mode() in hds.py no longer skips. Is that why enabled_set_xdp
> and ioctl_enabled_set_xdp go from SKIP to FAIL in the "After" log in the
> commit message?
>
> [...]
>
> Should the driver turn on HW-GRO when tcp-data-split=enabled is
> requested? Or should the tests enable rx-gro-hw first, or skip on EINVAL?
> As things stand, the state the driver reports does not match what the
> selftests expect.

It's ok for the tests to fail. We shouldn't modify the tests to account for
MLXs coupling of HW-GRO and tcp-data-split.

pw-bot: cr
