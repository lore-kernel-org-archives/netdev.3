Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812EA2C026C
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 14:24:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792247059; cv=none; b=tFWGYzxZEEQ3c4Ul/x2YU9GkViyMDYHob1SN+hrUszMGF+v28rpinGib53hwOHs78nOGb7Y+NB2rLPLCD0AZDk1B1fwxk597Y4qtxRWMYu0LtVgRdXEqwAYYWtUGCsE3J3NdQyt7yRcDqMA3KMUYg/nkqHalc26KrxRzlXOY0Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792247059; c=relaxed/simple;
	bh=ft67JGSMC3wN+9xS6mjoVVJGXuQt5bb+kO+P68KyxiE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KhtmjZS3QaSbfSsIE6mO0Fet/oHQKpcBAdyWyN5AmzY6VMtbvkzzNrfSAKlK2THRnf9kF+e5k90ZF0LTWrQjUe24GsdXa/Ln5Lge1hqZxiEt0yFKldar2x7oG7ZMoM1OaysLLOO/5bF7JtvDGgMQhjQkqKVsSCRxhl25URcL4uQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lqnb5bg4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lqnb5bg4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9644E1F000C4;
	Sat, 17 Oct 2026 14:24:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792247058;
	bh=UEIk44fUwx1+8vgDSwhov4TpQCE2WReyCOB6+3cVrag=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Lqnb5bg4G8YQfgkxEZURxpRUdqB7VaCE+IlEWoPpoN+id/pFhWo/omyVS97ccnB7u
	 5RKiyp8cXSp6DID1QGYwadogOhnQNgyEnTjAvRLBjHRoAmkxzbt54MFlGyYx3vqGLO
	 mpZgmSmcOUz8FPEYkeTDvHyom18UQUuvJM8htyPEGWqekUkpmt0WPawOrJ9va/cXAq
	 sbFFhrf4iDDsYLA9IU4OM+afGr0dxpIGNklziXmYyslEzu+Nw0CUW/Poo5V9k3gcCJ
	 e81VeS3hMDEwHIu7DqY7WYFMFP3ThzIv9HWfvg7LDxTzAG6OAZMojehhus0ldgZvHa
	 EhYsZJDdqy1cg==
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
Subject: Re: [PATCH net] net/mlx5e: Update netdev features only after a
 successful ringparam set
In-Reply-To: <20261017005401.1582755-1-dimitri.daskalakis1@gmail.com>
References: <20261017005401.1582755-1-dimitri.daskalakis1@gmail.com>
Date: Sat, 17 Oct 2026 16:24:14 +0200
Message-ID: <878q3w4d81.fsf@all.your.base.are.belong.to.us>
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
> mlx5 couples HW-GRO with tcp-data-split. If a user sets rx-gro-hw on ->
> tcp-data-split on -> rx-gro-hw off, the driver will leave HW-GRO on.
> mlx5e_ethtool_set_tcp_data_split() calls netdev_update_features() when
> tcp-data-split goes from enabled to disabled in case HW-GRO needs to be
> released. mlx5e_fix_features() reads the new HDS config from
> dev->cfg_pending, so HW-GRO is released before all ring parameters are
> validated.
>
> If the subsequent call to mlx5e_ethtool_set_ringparam() fails, the
> ethtool core discards the pending change and reports tcp-data-split
> enabled. The device is no longer splitting, and subsequent ring changes
> are blocked.
>
> Move the call to netdev_update_features() after
> mlx5e_ethtool_set_ringparam() exits successfully.
>
> The issue was discovered by manual code inspection during review of
> a change that stops mlx5 users from disabling tcp-data-split. It was
> reproduced on a ConnectX-7 with ethtool alone.
>
> Steps to reproduce:
> ethtool -K eth0 rx-gro-hw on
> ethtool -G eth0 tcp-data-split on
> ethtool -K eth0 rx-gro-hw off # HW-GRO kept on for tcp-data-split
>
> ethtool -G eth0 tcp-data-split off rx 1 # de-sync driver & kernel state
>  netlink error: mlx5_core: rx (1) < min (16)
>  netlink error: Invalid argument
>
> ethtool -G eth0 rx 1024 # valid ring changes are now blocked
>  netlink error: mlx5_core: TCP-data-split is not supported when GRO HW is=
 disabled
>  netlink error: Invalid argument
>
> This is not a terminal state, users can recover by setting rx-gro-hw on.
> With the fix, the failing ringparam set leaves rx-gro-hw on and later
> ring changes succeed.
>
> Fixes: 46bcce5dfd33 ("net/mlx5e: Support ethtool tcp-data-split settings")
> Reported-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
> Closes: https://lore.kernel.org/87se2grw3d.fsf@all.your.base.are.belong.t=
o.us/
> Signed-off-by: Dimitri Daskalakis <daskald@meta.com>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
