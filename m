Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792543933;
	b=j7p/hmzsnBofJEKzhTfDQ0JyivvV88DSIt1Fgo4uteqHsOqbW64x+L4/LxbbiLHY9dOE
	 I05XZxohFwQ9rHL4y6l60CFp2goJfGfVx2FKKndxXb2CTjUrYIMsu+BhviXb5wYL7u4Xn
	 3B8hqgX8HRSvH9oikPec6jIIjlCQbXx0ExPHa2cdHqWm6pGfeOnboAt7+hlQAm+w+vzyK
	 1U3AN9xLoo8dNKaQrjcgehQ/Bgzg57nnQ6r682L07VJaIyvfZ6mHbBkE5QPe9YYK4ryh7
	 ObJS3EesQW4XwQtSSD8L67osKN3h5hUCJuUt0CyWKckEU13nPjG+Xt68asmHfFykl9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792543933;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GBFH6oRYSJP/dQWfGegi7pqI65g5/qbXzo/olR5/xbg=;
	b=iMhy+Pb4rCuzJhbWItYKgYWkcy2f4ITE0gzdAzQysELAXJvBPMOOOM12lHV496shFT3H
	 2jwQROWv0Q4etrzACPTQiWzein+F/Ns8VWesaiBCMKzboUPy72OkZZrH69wHfDVEu2e3l
	 8Jbb3Ab17Ol4UZl6U9PicFkY6rx5o0H9FFMbgHUcfGjjIPdMIx8IKmRrf0ZN+zKo1rq9z
	 gFXyOnwVRbysqfdsIh8hoorNI2IRj6RWIo9kBJ3gDu7xhpSRUqSwGUNqqzzjbD/L3zdPU
	 4HW9fG4jE5aKJyQ8XpPBXyoKmhwJiHwicCfOI5UTdF7SHYeFTONyb9D6lf8CqflM/Iw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bII38EBC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61829606A323;
	Wed, 21 Oct 2026 00:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bII38EBC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A690B1F000C9;
	Wed, 21 Oct 2026 00:52:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792543933;
	bh=GBFH6oRYSJP/dQWfGegi7pqI65g5/qbXzo/olR5/xbg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bII38EBCvPXNjrjqOumQ4YCpuKNsNvskPH4yy49yKaPsullfPKOZAGf35AFSKgQLy
	 j9cIwXj2GbDVMG8rr+WoIz6RPtSheHVjwqOdv3BQKUNbHNTyAEtg7JAEZRuOxqhDjk
	 MStfA7WozJuuoO2uorH5vPqIrnoIMPn0IU+39Ny+6cown/DIpjkUnOvYEuyHTWl/k/
	 /ZQ+fd548btLFQR4kLQYR9/bD+a2OOOyHkcub2cN5VeOAc77Sl9lZDIdoo8VMiGcz4
	 1nT+0ZnodbPdx90NmX35t4aSu6SrS5U0J2g2XhVyLhDVMfVauV6V4GcDQFOmR7W2jd
	 wEIaHTmHdlRaA==
From: Jakub Kicinski <kuba@kernel.org>
To: hsu.chih.kai@realtek.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	davem@davemloft.net,
	netdev@vger.kernel.org,
	nic_swsd@realtek.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	edumazet@google.com,
	bjorn@mork.no,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	mail@birger-koblitz.de
Subject: Re: [PATCH net-next v7 05/10] r8152: fix up and down register settings for RTL8156/8156B/8157/8159
Date: Tue, 20 Oct 2026 17:52:12 -0700
Message-ID: <20261021005212.1254979-1-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261014081904.6491-6-nic_swsd@realtek.com>
References: <20261014081904.6491-6-nic_swsd@realtek.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
r8152: fix up and down register settings for RTL8156/8156B/8157/8159

This commit corrects several up/down and OOB register settings for the
RTL8156, RTL8156B, RTL8157 and RTL8159 chips, following the earlier
per-generation split of the up/down callbacks. It changes the PLA_RCR1,
USB_SPEED_OPTION, Clear_SDR, PLA_BDC_CR/PLA_OOB_CTRL and OOB
PLA_RMS/PLA_MTPS settings, and drops PLA_MCU_SPDWN_EN handling from
rtl8157_up()/rtl8157_down().

> diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
> index b245b63fb6aaf..045460a35f383 100644
> --- a/drivers/net/usb/r8152.c
> +++ b/drivers/net/usb/r8152.c

[ ... ]

> @@ -6938,8 +6937,18 @@ static void r8156_enter_oob(struct r8152 *tp)
>  	rtl_disable(tp);
>  	rtl_reset_bmu(tp);
>  
> -	ocp_write_word(tp, MCU_TYPE_PLA, PLA_RMS, 1522);
> -	ocp_write_byte(tp, MCU_TYPE_PLA, PLA_MTPS, MTPS_DEFAULT);
> +	switch (tp->version) {
> +	case RTL_VER_16:
> +	case RTL_VER_17_QFN68:
> +	case RTL_VER_17_QFN100:

[Severity: Medium]
This patch has three Fixes: tags:

  Fixes: 195aae321c82 ("r8152: support new chips")
  Fixes: fd3c7d080df5 ("r8152: Add support for the RTL8157 hardware")
  Fixes: ad2a55b63b41 ("r8152: Add support for the RTL8159 chip")

Will it apply and build on the trees those tags point to?

RTL_VER_17_QFN68 and RTL_VER_17_QFN100 come from an earlier patch in this
series, "r8152: split RTL_VER_17 into QFN68 and QFN100 package variants".
Before that patch the enum only has RTL_VER_17.

rtl8157_up() and rtl8157_down() also only exist after "r8152: split
rtl8156_enable/up/down into per-generation functions", which is described
as no functional change. Before that patch there is one shared
rtl8156_up() with tp->version >= RTL_VER_16 and tp->version < RTL_VER_16
checks.

So a stable backport would either conflict or need both non-fix patches
as prerequisites. One of them is the package detection change, which
makes an unrecognised PLA_PKG_DET value fall back to RTL_VER_UNKNOWN.

Could these fixes go to net separately, written against the pre-refactor
code? Or could the commit message at least name the prerequisites?

> +		ocp_write_word(tp, MCU_TYPE_PLA, PLA_RMS, 1526);
> +		ocp_write_byte(tp, MCU_TYPE_PLA, PLA_MTPS, 10 * 1024 / 64);
> +		break;

[ ... ]

> @@ -6997,6 +7008,11 @@ static void rtl8157_up(struct r8152 *tp)
>  	}
>  
>  	r8153_aldps_en(tp, true);
> +
> +	/* Enable Clear_SDR */
> +	ocp_byte_set_bits(tp, MCU_TYPE_USB, 0xd378, BIT(7));
> +	/* Clear SDR bit */
> +	ocp_word_clr_bits(tp, MCU_TYPE_USB, 0xcd06, BIT(15));
>  }

[Severity: High]
The commit message says:

  - RTL8156B (VER_13/15) need Clear_SDR enabled on up, which nothing
    ever did for them.

Is the RTL8156B part missing from this patch? These are the only
Clear_SDR writes the patch adds. rtl8157_up() is only used for
RTL_VER_16, RTL_VER_17_QFN68 and RTL_VER_17_QFN100.

In rtl_ops_init(), RTL_VER_13 and RTL_VER_15 are bound to rtl8156_up():

	case RTL_VER_12:
	case RTL_VER_13:
		tp->support_2500full	= 1;
		fallthrough;
	case RTL_VER_15:
		...
		ops->up			= rtl8156_up;

This patch does not change rtl8156_up(), and it still writes no
Clear_SDR register:

	r8156_exit_oob(tp);

	ocp_word_clr_bits(tp, MCU_TYPE_PLA, PLA_MAC_PWR_CTRL3, PLA_MCU_SPDWN_EN);

	ocp_word_clr_bits(tp, MCU_TYPE_USB, USB_SPEED_OPTION,
			  RG_PWRDN_EN | ALL_SPEED_OFF);

	ocp_write_dword(tp, MCU_TYPE_USB, USB_RX_BUF_TH, 0x00600400);
	...
	r8153_aldps_en(tp, true);
	r8153_u2p3en(tp, true);

So every open or resume on an RTL8156B goes through ops->up ->
rtl8156_up() without the Clear_SDR enable. The later patches in the
series don't add it to rtl8156_up() either.

Should rtl8156_up() get the RTL8156B Clear_SDR writes under an
RTL_VER_13/RTL_VER_15 check, or should this bullet come out of the commit
message? The 0xd378/0xcd06 writes used for RTL8157/8159 can't be assumed
to apply to RTL8156B.
