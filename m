Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792560067;
	b=OBCqOhxEVu6IAEyaJus3kF+hjhyelD6Pn6PMnYKpUL+CLAfWtKyW0JULu35tghihW6GJ
	 pBK3gjq1urkkAvIfvdio9yU7MNfXsLziNrdaViaPgwdmoH0Zl2PvKDJxM4mWZj8kVIIQD
	 b/HfR9dlp+vFyBaTZoviwrlY4elytMKvtNZmwv7MumA0iQmI4TPp39nN0TKMmrZy0Paic
	 eCB+xSli/Dc5w0qZwtuiiBheUm5GVx800kQjCWYLVTLxnI2I/sUOzOglUm6DsqSNR63AD
	 BWdAp4ufGDYrtjkl9wI9WMca1thpKyFoLbfY89NlyN8K8PdC8XHvIBGatSo8f9QWvxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792560067;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=+zwq9CURf+CmUWAR+V9f51vXK3xezEQGZb6fNB7au+E=;
	b=efR4jfPxwBxlVmPGKyxZtmzhVLoregonQ56Pepu9mGzHzlP/sGCfy/g2lbYKgt/yacr2
	 5n/tQ8PVEGLwewvYde7ULeiPWrAw32Kjna+vO8twEhpiMRs1wIKad17hBZ7g5OOSrsm1P
	 YR2NtP2DVwwq4D7YarHLlhyiqUuby2TT8iTPQS8/FxZy1rEpt4mhQm/Civo7+zA5clYNe
	 zO42ipTukn3T8kcW3kmxiywR974xkUmTx+WqRkvHqUsAsG8bfXLj2dbgPgZdj6ZpLl9Gk
	 taALimyupaHKJ3ZxCjiyutE031TzdHlpwuMBBJCIKUMy3TCwKvchbakqIdjYjhtoIkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QOqnDTCn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A21606A31D;
	Wed, 21 Oct 2026 05:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QOqnDTCn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27661F000CC;
	Wed, 21 Oct 2026 05:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792560067;
	bh=+zwq9CURf+CmUWAR+V9f51vXK3xezEQGZb6fNB7au+E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=QOqnDTCneMPwB6usyLEYfCXEBsg6juKbSiDdRyszCM89QVG/4wFpVHXfrC1J1qf9X
	 20hGym9soeGNN+HxvgBAk5nYEsO+JvRcAYcaX/xnaOiFd4h+B6Qyt/RZFtIB9oHSWB
	 Md94UgKBiuG7dinmy8/UqgwSt/mPfMWQEyDqfL7Qv+qAcIANbbzlemPTBeNQ1jyn3e
	 k4L2kAhtefQpjd8UZiZb28ByfDlwnnjG/B8Ost/FrLASE24abPT5CAUX0XHWVMfXKe
	 ShHkUrF/HnHX4QX7PhoMjIesDutDBSl9IKhKKHwP8WYAWPKF5GrQ47hVrPJFWlId+4
	 qp1uTqPI4d3WA==
Subject: Re: [PATCH net-next v27 2/3] net: phy: Add support for Template
 Control register for PMA
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, Frank.Sae@motor-comm.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 ming.xu@motor-comm.com, xiaolin.xu@motor-comm.com,
 jianmin.wang@motor-comm.com
Date: Wed, 21 Oct 2026 05:21:05 +0000
Message-ID: <179256006554.3135.14588045194539327406@kernel.org>
In-Reply-To: <20261020021929.3028490-3-kyle.switch@motor-comm.com>
References: <20261020021929.3028490-3-kyle.switch@motor-comm.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] include/uapi/linux/mdio.h line 325 defines the new exported uAPI
  macro MDIO_PMA_10GBT_TESTMODE_MASK as GENMASK(15, 13).

--

net: phy: Add support for Template Control register for PMA

This commit adds definitions for the 10GBASE-T PMA Template Test Mode
register (PMA register 132, bits 15:13) to the mdio uAPI header. It also
adds a genphy_c45_template_testmode() helper, which selects one of the
eight test modes (Normal through TestMode7).

> diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
> index 06f4bc3c20c7..353ca13c64fc 100644
> --- a/include/uapi/linux/mdio.h
> +++ b/include/uapi/linux/mdio.h

[ ... ]

> @@ -320,6 +321,17 @@
>  /* PMA 10GBASE-R Fast Retrain status and control register. */
>  #define MDIO_PMA_10GBR_FSRT_ENABLE	0x0001	/* Fast retrain enable */
>  
> +/* PMA 10GBASE-T Template Test Mode Register*/
> +#define MDIO_PMA_10GBT_TESTMODE_MASK GENMASK(15, 13) /* Template test mode */

[Severity: Low]
Will MDIO_PMA_10GBT_TESTMODE_MASK compile when userspace uses it?

GENMASK() is defined in the kernel-only include/linux/bits.h. The
exported include/uapi/linux/bits.h only provides these:

    #define __GENMASK(h, l) ...
    #define __GENMASK_ULL(h, l) ...
    #define __GENMASK_U128(h, l) ...

Also, include/uapi/linux/mdio.h only includes <linux/types.h> and
<linux/mii.h>.

So a userspace program that includes the installed <linux/mdio.h> and
uses MDIO_PMA_10GBT_TESTMODE_MASK would fail with GENMASK undeclared. The
in-tree build works because phy-c45.c gets GENMASK() from the kernel
headers. CONFIG_UAPI_HEADER_TEST would not catch this either, because
the macro is never expanded there.

Could this use __GENMASK(15, 13) with the uapi <linux/bits.h>, or the
literal 0xe000?

The header already has the same problem in MDIO_AN_C73_0_S_MASK,
MDIO_AN_C73_0_E_MASK and MDIO_AN_C73_1_T_MASK, but this patch adds a new
exported symbol with it. The later patches in the series leave this
definition unchanged.

> +#define MDIO_PMA_10GBT_TESTMODE_NORMAL 0x0 /* Template Normal */
> +#define MDIO_PMA_10GBT_TESTMODE_1 0x1 /* Template TestMode1 */

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261020021929.3028490-1-kyle.switch%40motor-comm.com
