Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793056029;
	b=I+V+W6og6xImcVMUVkTqTy1/hXB9/+h2B+9Ux3a3erXdTPcvadpjaOVUUELgOvcyh73v
	 SQLEskhoi3xUOn7NUHXrEJX5/a7WKZcQ4ST80fi//cFqWMN/14aDvBCIUXyDgTBf63EEu
	 j36BkkundyhU27M+gBz9exSSRRb+IFooLOkph0Wc6GFJsMU+de+thhvWHwEfpMiaMA433
	 emLCIDef2Y0awpCX4m/hjU2qM0qyxFdpVa7e95f959lKPOb2airIyfYf1Ak+tQW+WbS0g
	 C1P4TbVv4h0+qfCZ1qcg+cU29Ks6+cIT5tp2ZOsQRsZD5e99XmokTo2GULIQt43OYnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793056029;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=V+H0UeILhgx+FzPqIGM1ayP/WqlqIwGNT6ggr7OtvKo=;
	b=p90Y+uckga36FG4zNj3olxgDPmItfXm+A7ukLSLAGwFP3WVCmIBLLN81jitdlgVSypaZ
	 gGafcJk7/ebvbkDkbTjlrryDAEJkojiLfRvVzUz+Q4sNKYfmqUm1zI3iEhwGYpGKdbTuh
	 UYqTS1NxoI6VOODvPOSy53RUTTop8sC7I9tVoWsXdiSkPXRC2GJNxsuImB5UeLbCF1xN0
	 fiyMk3BPNzGQQu3oIzS0Ub/yMJ1rGmf4qJdY8mfhtEy3v10be0rQHKCrmtj2rkRjN5Vhu
	 NxZHVtk4w3KuQI5o8VMykPvrFsEviGQV2Suy057nFmxDayzzfbLhWw/zUBhWzqfm7GA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ICnadLoG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CF0606A324;
	Mon, 26 Oct 2026 23:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ICnadLoG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E2F1F031E1;
	Mon, 26 Oct 2026 23:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793056028;
	bh=V+H0UeILhgx+FzPqIGM1ayP/WqlqIwGNT6ggr7OtvKo=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=ICnadLoG14ZCmYuBvXwz6QpKR2QsKMo/GbEC83FNh4Nzh7X3g9sTVuQU5TVQen8p5
	 TD3VILq+UMJg1WeF6Tge4BPRGHl4+QyMqIyRncryAYevCMBt0567q7blYmybHCewhU
	 viN1ihwPJXAgXK5nmKv0D0A4uOJzYeF5TI1i5jgYZ/DXp30eVoo93ZJAv+us2qwBPp
	 fOtLchB+wBC3+OsC8eDgpqSz+qYYX/iJzM9hvPTgWMGzctGSHRaWjPCPalmyqx6jzG
	 e7l9nj6eXf1E7ctDVdZEf0z/S7qeh4EIwUGfAftdCzKIxeVqUOWLtAhNntBDnAmgFt
	 4AnIUCcl8I13Q==
Subject:
 Re: [PATCH net v2 4/4] net: phy: as21xxx: handle odd firmware on loading
From: netdev-bot+sashiko@kernel.org
To: ansuelsmth@gmail.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 26 Oct 2026 23:07:07 +0000
Message-ID: <179305602759.3134.6990761386999914981@kernel.org>
In-Reply-To: <20261022222955.698722-4-ansuelsmth@gmail.com>
References: <20261022222955.698722-4-ansuelsmth@gmail.com>
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

- [Low] In aeon_firmware_boot() (drivers/net/phy/as21xxx.c), the comment
  directly above the firmware upload loop still reads "/* Firmware is…

--

net: phy: as21xxx: handle odd firmware on loading

This commit changes the firmware upload loop in aeon_firmware_boot() so it
checks the index before reading data[i + 1]. If the firmware image has an
odd size, the last byte is now sent to the PHY mailbox as a zero-padded
16-bit word.

> diff --git a/drivers/net/phy/as21xxx.c b/drivers/net/phy/as21xxx.c
> index e2988cb10c047..db1a7cd68cef1 100644
> --- a/drivers/net/phy/as21xxx.c
> +++ b/drivers/net/phy/as21xxx.c
> @@ -325,7 +325,9 @@ static int aeon_firmware_boot(struct phy_device *phydev, const u8 *data,
>  
>  	/* Firmware is always aligned to u16 */
>  	for (i = 0; i < size; i += 2) {
> -		val = data[i + 1] << 8 | data[i];
> +		val = data[i];
> +		if (i + 1 < size)
> +			val |= data[i + 1] << 8;

[Severity: Low]
This isn't a bug, but should the comment above the loop be updated too?

It still says "Firmware is always aligned to u16". The new i + 1 < size
check exists only because size can be odd. The commit message also says
"we can't assume this will be the same forever".

Nothing enforces an even size either. aeon_firmware_load() passes the
size from request_firmware() straight through:

    ret = aeon_firmware_boot(phydev, fw->data, fw->size);

Someone who trusts the comment later could remove the guard as redundant.
That would bring back the out-of-bounds read of data[size] that this
patch fixes.

Maybe the comment could say something like "Firmware should be u16
aligned, zero-pad a trailing odd byte"?

>  
>  		ret = phy_write_mmd(phydev, MDIO_MMD_VEND1,
>  				    VEND1_GLB_REG_MDIO_INDIRECT_LOAD, val);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261022222955.698722-1-ansuelsmth%40gmail.com
