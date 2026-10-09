Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FB053D1AA6
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 06:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791528116; cv=none; b=u6N5OQDbLIF7QstTKWPZdjNZkKygVbQkFFEDESn/qpYMJPdu3vQRTxoEAGGoxcyCYpm1/wl5AWZ+n4RmXbSipptpVzx4YaW1+noPKy+Nt/rYmbwmPcz55rzmNMAPBIrMY7ScLs+DZEyFh7h+SC0xmGCecZjv37HZBRepuI7bHc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791528116; c=relaxed/simple;
	bh=e948RcljDVVhN9/+TJ9hoR0vH/VBGd82IrSwqH+NMvY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DZSFgvMrdT9Z6MsXQcuWrEcoq6mpsGpDDsJh8Rwvu19XesmQfGXfmFtj+ciEvtdwAtjh8SaBvPccDQ+0P44iIcL5fJwkIAO+x3aS2ku88kZT0GDk0UZ316d9eYrjgrCKD3IBNT/zEWQjEGCVKY/TBEWpsVF0whgBWEbwjIHhf0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QLrX4eMx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QLrX4eMx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E671F000FF;
	Fri,  9 Oct 2026 06:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791528114;
	bh=e948RcljDVVhN9/+TJ9hoR0vH/VBGd82IrSwqH+NMvY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=QLrX4eMxj7vTGYSEzzV+9/8GU0CDscPf4ngJdJjsdNuBwg3wMi4A+fiXQzdz4oJUQ
	 IxC4erXKtFzNIL0wuXgh7Pka6j6775FyDNvgtQdoGXUqsAPbGiXKAzNYPSJSL533Or
	 SY9yKq38xhfYtIQBoj4TSdKnIzlu7ePwdOGcsFGJtjUe7YsR+ZiMO+uR2cErO9icjY
	 KpgG2Fc8rqCi419kwsOPaT8tDctVMped4W36+iHo6mtRkMvzsxfRdGH6p9HnkgZzNC
	 ZpdIqthQtwz9KaPSZgoiFpDhI63U0Mrj9gsCPbveHL2FruxhreSxMSjTs8EphYEiIx
	 DZmUEy+sNNolA==
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
Subject: Re: [PATCH net-next v3] net/mlx5e: advertise tcp-data-split support
In-Reply-To: <20261009025137.2631215-1-dimitri.daskalakis1@gmail.com>
References: <20261009025137.2631215-1-dimitri.daskalakis1@gmail.com>
Date: Fri, 09 Oct 2026 08:41:50 +0200
Message-ID: <87a4ons7dd.fsf@all.your.base.are.belong.to.us>
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
> Additionally, move the call to netdev_update_features() out of
> mlx5e_ethtool_set_tcp_data_split(). If mlx5e_ethtool_set_ringparam()
> fails, this can cause the driver/kernel feature to de-sync.
>
> This is not a fix since HDS/tcp-data-split is still functional with HW
> GRO enabled.

Hmm, but with this move it is a fix, no? (We can probably get in similar
inconsist state as the one you describe with "ethtool blabla rx 1"?)

Maybe:
Fixes: 46bcce5dfd33 ("net/mlx5e: Support ethtool tcp-data-split
settings")

Regardless;
Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
