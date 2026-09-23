Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF8F2D738F
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 00:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790122786; cv=none; b=Y/bVoHzODBNWHkkSczTxGG+KiiK+67lxZbL0pDm5c4cM/kve78OLfyAcPZqPtk/VjKDw2Qk6GnUcSLZpOTYBUF3+SaBVRZI+j1xxHPQdPGlLcy14G45PBoDWf3rqhc4FRmr7X42wH0UqqR7F8H3g0GkyD/qtljs72zbFxgJZDsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790122786; c=relaxed/simple;
	bh=oYWXFW2tSb3Frq12vOe4rSgc97KSCMmVurw6T5QGq/4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hi9IBWmvonC/sUk5mIg2yafydaPWgR6SPn3tzkm2fzRuxWM0upi+K8L5dGPGpv7iLNsRAZnCMLQI3Gsxp4Y1GDLm3doRDZKKt64Gj3hIlhkOAD9M59EmEd/EjeSmY+Po3Fjmii7WnqZMppz3q9/UaWzC2GgbkI3OTMdJdNDJWH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSilNW+X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kSilNW+X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D2661F000FF;
	Wed, 23 Sep 2026 00:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790122785;
	bh=oYWXFW2tSb3Frq12vOe4rSgc97KSCMmVurw6T5QGq/4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kSilNW+XPG4UaUe+1Q//kvnFThwB2pJXuv1LWl9H801g8frWn3VyS+RiGWv/J1+0I
	 Ma82t23Zy9uVLRe+aRvatC9AyKzqsVZftaJYCKcL4kz0JfuyUeLOwsL8LQbmJSruAx
	 OIwdYUVcHCzQ8/4Yn9gUr1wFXyZ3yw1du7/gDQ1TSdxxi100paiIfXp7+eH4XwVFiV
	 ZPLe2JGJTIoNSK2nypS/H5+01Qj2FsSaO+tX6q3Ybp5fEvc68ahJXfSthK3g0GyCFD
	 4E6CFFFfxzz8hZUjWrhHututaxrAoR2hx+3dNVxL2WRJidyMZIJh9seAPHjPSqTYQV
	 Y83jDsdsLTb0Q==
Date: Tue, 22 Sep 2026 17:19:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "mengyuanlou@net-swift.com" <mengyuanlou@net-swift.com>
Cc: netdev@vger.kernel.org, jiawenwu@trustnetic.com,
 duanqiangwen@net-swift.com, linglingzhang@net-swift.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, jacob.e.keller@intel.com, richardcochran@gmail.com
Subject: Re: [PATCH net v6] net: Wangxun: protect ring accesses with RCU
Message-ID: <20260922171944.6ba2da64@kernel.org>
In-Reply-To: <BE54C737-C413-4A44-A27B-55040D41B1FD@net-swift.com>
References: <20260915065731.6007-1-mengyuanlou@net-swift.com>
	<20260921170509.3f471b54@kernel.org>
	<BE54C737-C413-4A44-A27B-55040D41B1FD@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 22 Sep 2026 16:48:16 +0800 mengyuanlou@net-swift.com wrote:
> Sorry about that. I=E2=80=99ll fix both issues in the next revision and m=
ake sure to
> address the previous review comments more carefully.
> Thanks.
>=20
> Another question:
>=20
> wx_init_interrupt_scheme() =E2=86=92=20
> wx_lib.c:2392 wx_cache_ring_rss() =E2=86=92=20
> wx_lib.c: rcu_dereference_protected(..., lockdep_rtnl_is_held())
>=20
> When wx_init_interrupt_scheme is in xxx_probe, unlike other txgbe_setup_tc
> and ngbe_resume, at this point the netdev has not yet been registered.
>=20
> +rtnl_lock();
> err =3D wx_init_interrupt_scheme(wx);
> +rtnl_unlock();
> if (err)
> goto err_cancel_service;
>=20
> At this point, rntl_lock is merely used to address RCU_LOCKDEP_WARN.
> Is this approach appropriate?

I think that's acceptable. Maybe add a comment as well just to make it
clear why we're taking the lock.
