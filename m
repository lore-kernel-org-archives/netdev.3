Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792768989;
	b=2ZXy1Zqk2eJ6WASdrcAXrwGs9EYvoI0xcZP37SIR9spWJin66Xamej3eOtbDcRzMivvh
	 Dn4ykzxRn6kOhz3e41Jgv3gGM2DYnwcYg3eQvaHgAzjjCl92CIT/lSy+jZmTvO+D0zcFr
	 PkrBwfBaRo7anukFie2fXjvc0E1QybheUlATteZD0w/EjRxlA+Nl52T4Kam4EjAlzU3xg
	 prrLNhIUMwTQXVYYCj9+A5iDGJlSTR1wm6u1aZE9pwszCQB7/jeItOSh+BJYy52qo4tDq
	 uE5LKJWkg+DLCIgO3QKbCIchInDUetk67Gc87hfPbKHNck5OzbbHaIA1a99y45M9NoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792768989;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ImYyqoKQZ/Bt5xgS+fKb1wTFQh3Ewq+y9Md4D4SvTSw=;
	b=41ObNMzS26I7ioUzb1SzbuCQmLWI7amfMWPBs03eafZZNXbWdZ9ewccFlvXr/NykK9r9
	 9se2s73tPggMQZA7EKL9E2RkkdbqM86EJQr6HS/frlu42DmR7jcDJyl/zzeCTjoG/zrhh
	 XFWrojX59dGK+zii6hlsCAZWxzEAfVOFzeHhm/yUwMCBk04VbO5ExFRroaJq+YFxKLTfx
	 J78MOXjQo3mNDw00JPYyAM9fsUp1N1EsYl2WVIHgLEIEqgLa3jmfmJJ/Jn5E3IdcJPyWd
	 FHoWLSZFrNENass7MwPWSx8ZFgMBSBAFUVxCfQo8H+3g0XE8WhJeWhYr0v05+78leCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SIovx3HP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7F6606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 15:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SIovx3HP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A3B1F01825;
	Fri, 23 Oct 2026 15:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792768989;
	bh=ImYyqoKQZ/Bt5xgS+fKb1wTFQh3Ewq+y9Md4D4SvTSw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SIovx3HPaETbiLhSB9xbo5wuNkWTmmpkLKTwbQ9aZuJiNTqwpjfLs6B7el2kymRBm
	 WqlagcdSSHXAvAUTkywCmI2pTyVajJ/amO1e72IC2Fp+kWgTeyIIvE1bEGTJTzpaS2
	 6iqjkswSstjGioRYzMAQ/yoIGLR+Zq6iw2qtSBJ2L+30OcDkcnM0soC/Fa7Cmg1tXC
	 E09UsGuIzGEDF+5tfW3SC8OkZkhFXt9yVAAllqTd2MiDEjyTigsZ1C7RSCMFY2AhVv
	 u8/LXxiYb7nFc+52r+zMS7k/Gqi99Z1jsyTyQKpZcaPkCNiS5Juz3hDf4MlVeHYdRo
	 7lhBvgLavmAow==
Date: Fri, 23 Oct 2026 08:23:08 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Dudu Lu <phx0fer@gmail.com>
Cc: hawk@kernel.org, ilias.apalodimas@linaro.org, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: page_pool: bound queue_idx before indexing
 dev->_rx[]
Message-ID: <20261023082308.23080670@kernel.org>
In-Reply-To: <20261021155611.68473-1-phx0fer@gmail.com>
References: <20261021155611.68473-1-phx0fer@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 21 Oct 2026 23:56:11 +0800 Dudu Lu wrote:
> queue_idx is supplied by the driver alongside PP_FLAG_ALLOW_UNREADABLE_NETMEM
> (the gve, bnxt, bnge, fbnic and mlx5 rx paths all set both); it is the
> driver's own rx queue index, so an in-tree driver passes a valid value.
> page_pool_init() still indexes dev->_rx[] with it while only asserting that
> the netdev lock is held, never checking it against real_num_rx_queues, so
> the exported API trusts the caller for the bound.  This is a sink-side
> hardening fix for page_pool_create_percpu(); the QEMU guest used for the
> reproducer has no such NIC, so the pool was created through a small module.

If all consumer (obviously!) pass the right index - why are you
bothering us with this patch?

Please do not send any patches to linux networking for next 2 months,
and until you learn basic coding skills.
-- 
pv-ban: 2mo
