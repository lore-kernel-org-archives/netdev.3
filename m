Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793091437;
	b=QsvGxSHDl4AA1wSwIiK23or7aAh7dKSDBno/klkqq9nZAl6DjKDVZSxiW4ZsawL7eh5E
	 QocR6gKap1UGNtqGi0xXIKFBjiZrG+QG9/p4PDIhn7wpJj5y6X7gGDqUQ9CPVT6xpztLt
	 xiGnJ2QhLa1ewHKVvbIcg8vcmPDtJ5LaFGvCRY74AXp88XaZTyIEYX5DxfDUYaE0zDclt
	 7/cfmpU8YzCRv7XKILFNXHKcqBXhbJsVmQGEDLNosLsI1x06HBJYlSo5B2yXkrlBvB/kc
	 xg4s9XvOqdCnonpqHe/G+uvtqAtWR4upLfaYbH2Owt2vOGW0sb7dNGi0WXP3BsN359Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793091437;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:
	 Subject:To:Cc:Content-Type;
	bh=6wITKebm02DSzXpPmZ3P3V2j16CsSQYiy9lUQJxJN8U=;
	b=Imes6GD1CuEOdLXRhzVK5o0o0DNo2vfObigmPugjBtN55RVYdDsejKxUmTyN5rTAq13G
	 AO4qbhTzTcQWqexfw80y4OQccRIf++Y2ZxVyB44a2Sj1MnMQYxDzpdPPxzu745zfrNk+O
	 0EAaXeziibmiM8gLodRNJ+pVsX0qrASUM8skpkKC7dXYmTWTI1+7dliZbrwvoowYCMDYE
	 XkORX3KhmrzCXXU3ed/7uktD4Kpzj4OYJnazv1wby7/cb/XPecjU8Ab0/n4UxPnEU+pI5
	 9QqUuWUQ6EQSvEBrk4bewA7SLgttNFuOt7ht/lU6z2xI/SnnTHY6f0lB97hiqHkCaiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V4GW3Wuq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00867606A336
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 08:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V4GW3Wuq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F18C1F031EB
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 08:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793091436;
	bh=6wITKebm02DSzXpPmZ3P3V2j16CsSQYiy9lUQJxJN8U=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=V4GW3WuqA1XYC/547F3eUifA0z7vD2uXvpN63zCquHskOT2Zo493D1JHPzLZlRnkq
	 VNCh8MnVlTRqRqx7mFV4t1BjhzjIPwf4lbFj2lV28Q6rxYC+jgV7QxW+YFHZfUdBDx
	 1lhX/yGO+8Uz5KApL5qQ8gqEIbSbzOhyoh3eqn3Ug3Yhkw2WSoTQKFpT919Iu5feu8
	 62+632WqXlG3Qyu1rccUppgRDQmGOebR3y8hlBj3RW2Ip7GuDLCmHe+6zff8jXHhWc
	 p0Kzq3iBNmgcL4Z+TI3GssdSxUbcRPle7SmpmRxfnsBSkinvo0uaTd/7BwS8rzLyd7
	 1uUzVMiY81BRw==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c34bff61551so569741866b.2
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 01:57:16 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzJrwrcktQKQOz7F4AZVVW09Yxg+A9LTue1fHZbsBDHkMrpOJh3nOXuooSFQWnIhToi7zOVmnY=@vger.kernel.org
X-Gm-Message-State: AFq9FYK3yQHWKKcw7Fkpy+nmFi0llvKNU5xzjhXBDrF2WCnpfou5RbCB
	jhksQ+vOJyARnsCKmn1x1sg28qJTjjp7Jy4PxtxPJuks+oXctoRsDX/o/2f7x0jurH2uj+QWG+X
	LCoaivaZGcQmMCCV9NxBAaJeduzX7EzQ=
X-Received: by 2002:a17:907:780a:b0:c49:9383:a28 with SMTP id
 a640c23a62f3a-c4993831289mr306624266b.35.1793091435523; Tue, 27 Oct 2026
 01:57:15 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027065012.191348-1-chunyuzhiqiang@yinhe.ht> <20261027065012.191348-2-chunyuzhiqiang@yinhe.ht>
In-Reply-To: <20261027065012.191348-2-chunyuzhiqiang@yinhe.ht>
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 27 Oct 2026 09:57:03 +0100
X-Gmail-Original-Message-ID: <CAMZ6RqL-3EBC=hFmpRyxcD4YA3PiMMnC3o+bAxN+ABDGqCNX6g@mail.gmail.com>
X-Gm-Features: AclHuK_4fAhpPs6TY0ZmiWtv2y46siAzZORz3V1x1x_oFVRYvygyfl06H0jKtk0
Message-ID: <CAMZ6RqL-3EBC=hFmpRyxcD4YA3PiMMnC3o+bAxN+ABDGqCNX6g@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] can: dev: can_tdc_fill_info(): don't read
 automatic TDCV if interface is down
To: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>
Cc: netdev-bot+sinfo@kernel.org, netdev@vger.kernel.org, 
	linux-can@vger.kernel.org, mkl@pengutronix.de, kernel@pengutronix.de, 
	haibo.chen@oss.nxp.com, shawnguo@kernel.org, imx@lists.linux.dev, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue. 27 Oct. 2026 at 07:54, ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht> wrote:
> The automatic TDCV readback calls into the driver via do_get_auto_tdcv().
> Some drivers, such as xcan_get_auto_tdcv(), read controller registers
> without taking a runtime PM reference, so calling this while the
> interface is down can touch registers whose clocks are gated.
>
> Gate do_get_auto_tdcv() on netif_running() in can_tdc_fill_info() and
> adjust can_tdc_get_size() and can_data_bittiming_get_size() so that only
> the automatic TDCV size is skipped when the interface is down. The other
> TDC parameters are still reported, as they are meaningful while the
> interface is down.
>
> This is a defensive hardening based on code inspection; the automatic
> TDCV path has not been triggered on hardware.
> Signed-off-by: ChunYuZhiQiang <chunyuzhiqiang@yinhe.ht>

Reviewed-by: Vincent Mailhol <mailhol@kernel.org>

I think it is still preferable to add a fix tag here:

Fixes: e8060f08cd69 ("can: netlink: add can_priv::do_get_auto_tdcv()
to retrieve tdcv from device")

@Marc, not sure if b4 would automatically pick the Fixes tag. If not,
can you add it while applying?


Yours sincerely,
Vincent Mailhol
