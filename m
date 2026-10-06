Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE9F4A6897;
	Tue,  6 Oct 2026 18:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791312250; cv=none; b=UtdnBt7+wZDOgSZAAfP/wgo5dWKrDvft41PEiEnU/KZUqjFacdEkPfFawSsYwekS5gLjO9cYNCtrFsOW99NzR3YuIi/JraWowtcZ4hAOYy7EIycZnMm0l4OQK5Ei0ZeR43qeMJpDYqkd6yUHKlzBIaJuqe2oUSHQm508mvnbBvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791312250; c=relaxed/simple;
	bh=9h0qHpCGEfPCVkVg+oh3spz2EcspcNBBKd1/If9+TUM=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z4iX9eraqclbWevDBMFhbabxDSX73fqn5VMyOAYDWFnXBfcJ5kbTviK8pzZGnoSPkciO4VL8E/0Q9WzGzdFIfPuz/ng6Ug+GK5LAwDF8eE+opCmtjZq89o66uVjP3vPUZKDc7zGj8FL2XzyCqicKkzqme/EvIUECbjLT4cfr1Qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XOYDKj//; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XOYDKj//"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 580241F0089C;
	Tue,  6 Oct 2026 18:44:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791312247;
	bh=jey4Enu4iKory+h1BBSHLzfnCv8BGwuXqsB+ZwE/8Dg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XOYDKj//nWpzVrWiMvHk8ZAR1ugvvFJe4Gse+PnUkjP6fEBXe6hyEz94jpjX8zNyp
	 Z13ZzYAm2mTiE+w/dJ5i6BMvRqqD3I6/SUr2Jf4YQ2dc8zOcGqJQpMjfT9IUfYk+R7
	 qC8y8Zti7bpYUwSXOhhP7ixnNqXwa8PJdVRW9qbs3485GOqATKe4zPho2FdM2o+yQa
	 NYS5G6xqwUVUs1smr8HI/ZX6YKSJM8J0HJDJYM1Dqq6t2igiWQCZblCzl28LZ1JrYa
	 +KQORuBi0R1dczB6mfJsZRnXvupipb/PiZ+EynFl5ZaK3VQcgZ+ZVOoM14cppk+Lbd
	 vzhibNtRqOrCQ==
Subject: Re: [PATCH net-next v11 3/7] net: dsa: motorcomm: use fixed-width
 GENMASK_U*() helpers
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
 horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com,
 sijia.huang@gl-inet.com
Date: Tue, 06 Oct 2026 18:44:05 +0000
Message-ID: <179131224591.434549.13716645949884608730@kernel.org>
In-Reply-To: <20261002173706.1225502-4-kyle.switch@motor-comm.com>
References: <20261002173706.1225502-4-kyle.switch@motor-comm.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The commit message says what the patch does but not why, and its
  wording claims more than the patch does.

--

net: dsa: motorcomm: use fixed-width GENMASK_U*() helpers

This commit switches the GENMASK() call sites in chip.c and mdio_bus.c to
the fixed-width GENMASK_U16() and GENMASK_U32() helpers. The converted
values are unchanged, so the patch has no runtime effect.

> Replace the plain GENMASK() uses with the fixed-width GENMASK_U16()
> and GENMASK_U32() variants.

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index 79422def16ffb..13fc286d4194b 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c
> @@ -101,19 +101,19 @@ static const struct yt921x_mib_desc yt921x_mib_descs[] = {
>  static const struct yt921x_info yt921x_infos[] = {
>  	{
>  		"YT9215SC", YT9215_MAJOR, 1, 0,
> -		GENMASK(4, 0),
> +		GENMASK_U16(4, 0),
>  		BIT(9),
>  		BIT(8) | BIT(9),
>  	},

[ ... ]

[Severity: Low]
This isn't a bug, but does the commit message match what the patch does?

"Replace the plain GENMASK() uses" reads as if every plain GENMASK() in
the driver is converted. Only six call sites in chip.c and mdio_bus.c
change.

After this patch, drivers/net/dsa/motorcomm/ still has 153 plain GENMASK()
uses: 133 in chip.h, 16 in leds.h and 4 in mdio_bus.h. The mdio_bus.h ones
are the field masks for the mdio_bus.c file this patch edits:

drivers/net/dsa/motorcomm/mdio_bus.h:
#define  YT921X_MBUS_CTRL_PORT_M		GENMASK(25, 21)
#define  YT921X_MBUS_CTRL_REG_M			GENMASK(20, 16)
...

Even inside yt921x_infos[], only the GENMASK() values for the u16
internal_mask field are converted. The BIT() values for xmii_mask and
serdes_mask, which are also u16, stay as unsigned long BIT() constants.
So does internal_mask for YT9214NB and YT9213NB:

	{
		"YT9214NB", YT9215_MAJOR, 3, 2,
		BIT(1) | BIT(3),
		BIT(9),
		BIT(8),
	},

include/linux/bits.h already has BIT_U16() and BIT_U32() for these.

The later YT922x patch in this series ("net: dsa: motorcomm: Add support
for Motorcomm YT922x") also adds new plain GENMASK() defines to chip.h,
such as YT922X_PORT_SPEED_M and YT922X_SERDES_MODE_M. That means the
series never finishes the conversion.

Could the commit message explain why this conversion is wanted and why it
stops at these call sites? Could it also say that there is no functional
change?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002173706.1225502-1-kyle.switch%40motor-comm.com
