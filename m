Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAE803955C1
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 16:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791477196; cv=none; b=h7YZPWKQxcC/VFcBsMdL00nkNOcIT5fds53k1BLdHU3hPXV7Ya76RPW3yvViKH0FPo2zRo/HTWPlTn9wx98f4pXVZTcSuhc88zUHlZsHNPKTkkC4weHcWcrDdrjXQ/ysJTTuKY2iadthbsEGJ1nY3gsEQAauHGVNAkhqkK+ZUP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791477196; c=relaxed/simple;
	bh=oaCxtLUg3wjxrPwrfeSs5c8FuaJCmKtkUYXFtzkyxbs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O9kl80zQ8MTSP38OobMHrRhcmA3GeliHKPIcOybTpzTj8bT0lkYImAWpfyGW1BHLlnBgmJooJ3T1hsWUXUGbMJA+oPdN/k2loEOdAHdGOEDUXLAnI5l6eDJPw/3gU6yS5pIl0UGcWTnEwFfMTYgxZj6ix8jboB2RuNyAhlp11as=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iGjZek0t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iGjZek0t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D244E1F00898;
	Thu,  8 Oct 2026 16:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791477194;
	bh=de60pFOGAhxkzdDemtwHH1ACAwwxewvV6Fu37teT01s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=iGjZek0tVP1mlODrPeOE2sPk9T0leh1+b3p2ebOkEGxGUW5xGHrsoESrXCHCUo99c
	 j57Y7x3xObGlT36ECqHv+xQUSJKJMWDPNgRcy58SqvoYhCH1QrgG7A7Kg2cXKJU3s/
	 VTRNIHfL/s4hW5PwgcMaEbgi3mwRKdQ4isFjgKyF3TunJATddVT1IyxewNjjOOJsXy
	 GdWEQmA7vkic+7L0CinHy3VqXcIHb7GB2HNQjfR59vy1pg4My+LPXpMD9m3k1Kd8pT
	 mGzNBQHYbVCDsdQWvMAhnLzgrQY/z5aAO9xWY4m6CFUPN2NQZXNo+4gkVB16MlAwvE
	 vQcshUhrY+0WA==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>, "David S . Miller"
 <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Andrew
 Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Gal Pressman
 <gal@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Dragos Tatulea
 <dtatulea@nvidia.com>, Nimrod Oren <noren@nvidia.com>, Carolina Jubran
 <cjubran@nvidia.com>, Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next v2] net/mlx5e: advertise tcp-data-split support
In-Reply-To: <20261006225925.568263-1-dimitri.daskalakis1@gmail.com>
References: <20261006225925.568263-1-dimitri.daskalakis1@gmail.com>
Date: Thu, 08 Oct 2026 18:33:10 +0200
Message-ID: <87se2grw3d.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Dimitri Daskalakis <dimitri.daskalakis1@gmail.com> writes:

> From: Dimitri Daskalakis <daskald@meta.com>
>
> The ability to set tcp-data-split was introduced in
> commit 46bcce5dfd33 ("net/mlx5e: Support ethtool tcp-data-split settings")
> This commit dropped reporting from mlx5e_ethtool_get_ringparam()
> without explaining why. commit d347b28c492e ("net/mlx5e: Add hds-thresh
> query support via ethtool") added support for ETHTOOL_RING_USE_HDS_THRS,
> and modified mlx5e_ethtool_get_ringparam() to report an hds_thresh of 0.
>
> Between these two commits, the hds selftest helper _defer_reset_hds()
> would skip the reset because neither hds-thresh or tcp-data-split was
> present in the ring config. After the second commit this introduced
> a KeyError in the hds.set_hds_enable/disable tests.
>
> mlx5 couples tcp-data-split with rx-gro-hw. Users can currently disable
> tcp-data-split then enable HW GRO. The kernel reports tcp-data-split
> off, but the HW is presumably splitting.
>
> Add back tcp-data-split reporting in mlx5e_ethtool_get_ringparam(),
> and de-feature tcp-data-split disable. Users can either enable it
> (if HW GRO is enabled), or leave it under driver control.
>
> This is not a fix since the feature is still functional with
> HW GRO enabled.
>
> Signed-off-by: Dimitri Daskalakis <daskald@meta.com>
> ---
> Changes in v2:
> - Leave kernel_param->tcp_data_split as ETHTOOL_TCP_DATA_SPLIT_UNKNOWN if=
 the
>   device does not support HW GRO
> - Prevent users from disabling tcp-data-split
> - Link to v1: https://lore.kernel.org/all/20260923230521.1267511-1-dimitr=
i.daskalakis1@gmail.com/
>
> hds.py before:
>  # Interface: eth0, driver: mlx5_core
>  TAP version 13
>  1..13
>  ok 1 hds.get_hds # SKIP tcp-data-split not supported by device
>  ok 2 hds.get_hds_thresh
>  # Exception while handling defer / cleanup (callback 1 of 1)!
>  ...
>  # Defer Exception| KeyError: 'tcp-data-split'
>  # Defer Exception|
>  not ok 3 hds.set_hds_disable
>  # Exception while handling defer / cleanup (callback 1 of 1)!
>  ...
>  # Defer Exception| KeyError: 'tcp-data-split'
>  # Defer Exception|
>  not ok 4 hds.set_hds_enable
>  ok 5 hds.set_hds_thresh_random # SKIP hds-thresh-max is too small
>  ok 6 hds.set_hds_thresh_zero
>  ok 7 hds.set_hds_thresh_max
>  ok 8 hds.set_hds_thresh_gt
>  ok 9 hds.set_xdp # SKIP tcp-data-split not supported by device
>  ok 10 hds.enabled_set_xdp # SKIP tcp-data-split not supported by device
>  ok 11 hds.ioctl # SKIP tcp-data-split not supported by device
>  ok 12 hds.ioctl_set_xdp # SKIP tcp-data-split not supported by device
>  ok 13 hds.ioctl_enabled_set_xdp # SKIP tcp-data-split not supported by d=
evice
>
> hds.py after:
>  # Interface: eth0, driver: mlx5_core
>  TAP version 13
>  1..13
>  ok 1 hds.get_hds # SKIP tcp-data-split not supported by device
>  ok 2 hds.get_hds_thresh
>  ok 3 hds.set_hds_disable # SKIP disabling of HDS not supported by the de=
vice
>  ok 4 hds.set_hds_enable # SKIP disabling of HDS not supported by the dev=
ice
>  ok 5 hds.set_hds_thresh_random # SKIP hds-thresh-max is too small
>  ok 6 hds.set_hds_thresh_zero
>  ok 7 hds.set_hds_thresh_max
>  ok 8 hds.set_hds_thresh_gt
>  ok 9 hds.set_xdp # SKIP tcp-data-split not supported by device
>  ok 10 hds.enabled_set_xdp # SKIP tcp-data-split not supported by device
>  ok 11 hds.ioctl # SKIP tcp-data-split not supported by device
>  ok 12 hds.ioctl_set_xdp # SKIP tcp-data-split not supported by device
>  ok 13 hds.ioctl_enabled_set_xdp # SKIP tcp-data-split not supported by d=
evice
>  # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:9 error:0
> ---
>  .../net/ethernet/mellanox/mlx5/core/en_ethtool.c    | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drive=
rs/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> index 261c466a4d36..f08a968acec4 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
> @@ -378,6 +378,10 @@ void mlx5e_ethtool_get_ringparam(struct mlx5e_priv *=
priv,
>=20=20
>  	kernel_param->hds_thresh =3D 0;
>  	kernel_param->hds_thresh_max =3D 0;
> +
> +	if (priv->netdev->hw_features & NETIF_F_GRO_HW &&
> +	    priv->channels.params.packet_merge.type =3D=3D MLX5E_PACKET_MERGE_S=
HAMPO)
> +		kernel_param->tcp_data_split =3D ETHTOOL_TCP_DATA_SPLIT_ENABLED;
>  }
>=20=20
>  static void mlx5e_get_ringparam(struct net_device *dev,
> @@ -403,9 +407,14 @@ static bool mlx5e_ethtool_set_tcp_data_split(struct =
mlx5e_priv *priv,
>  		return false;
>  	}
>=20=20
> +	if (tcp_data_split =3D=3D ETHTOOL_TCP_DATA_SPLIT_DISABLED) {
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "TCP-data-split can not be disabled");
> +		return false;
> +	}
> +
>  	/* Might need to disable HW-GRO if it was kept on due to hds. */
> -	if (tcp_data_split =3D=3D ETHTOOL_TCP_DATA_SPLIT_DISABLED &&
> -	    dev->cfg->hds_config =3D=3D ETHTOOL_TCP_DATA_SPLIT_ENABLED)
> +	if (dev->cfg->hds_config !=3D tcp_data_split)
>  		netdev_update_features(priv->netdev);

Not directly related to your change, but is it correct to call
netdev_update_features() here? What if later changes in set_ringparam()
fail? Shouldn't the update be done when we know that set_ringparam() is
successful? Seems like we can get into an inconsistent state?


Bj=C3=B6rn
