Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F562282F06;
	Mon, 19 Oct 2026 02:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792377532; cv=none; b=TJKsYrSDxj/DCxi0G71+IQnwIlJCuA4Is9t0BSrWoJgUMiqqRCKVgJkKb78Yrug1rXZIwZHsmzao1ZdebmzHUJ2pH2/VFyOLxa2oQMdf5fgvcSUNqPHCsZolkipRDrgLyzy84oQdpAUJumrWcMbILvqyJ07hMSqaIzhMmQmMGu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792377532; c=relaxed/simple;
	bh=0utscW1Ay5PuVaHP9RG+RmPBpT+DRbevjbFu6KzlW+4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ncJ33QvONrQ693364hSHPLGPKJjq27jDkJ5sZCNbyESMb5H2PgMgdpFgL86g+BBaTqk11BW2EFjI3Ap0qiPp8fthocnIP44+lIJADFNmHc04P+eAkAnbN5qzwhRfD5XF0PAvQDKrbWklQbHl9yNqvtVhzZ3gw+hTZVQK+97y250=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dgvo3hcZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dgvo3hcZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7921F000C4;
	Mon, 19 Oct 2026 02:38:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792377530;
	bh=Kxz1J2jz0Dgrez27Av1yXC9DiUz57J5s6852uaYH4aY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=Dgvo3hcZ19acNa+9x73k6fxo7IUS4pxsJ6vuexR5eCMHe9KpZs4Bb7IrLucqOxNW+
	 R4FTzlhMmq9LS4GbrCDZmj9Gbxc8VydbntJsgxS/xMEFNUR2mkPuI9jEegfSxyCBPd
	 TvUNnqhprfnzGF3MMnG28rqRXV/PiNVaUeh2olUFj/6Nu71N0W7D6BJnz/t7UEot4s
	 TTBfvVKS6NJULxCFh24Falxf+g1bmy7dx9GRdjfAYEep7fxerauQ4CfxODqQzDKtLI
	 Ge94AcASPaAasoVsCfgg7KIlbAbCzmNi2HuDNbqSDxLLW80gzkfDJkXUvSe74lXjjs
	 w7P9QckMpBemg==
Subject: Re: [PATCH net-next v26 2/3] net: phy: Add support for Template
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
Date: Mon, 19 Oct 2026 02:38:49 +0000
Message-ID: <179237752933.3135.17947846708749105573@kernel.org>
In-Reply-To: <20261018022151.2677056-3-kyle.switch@motor-comm.com>
References: <20261018022151.2677056-3-kyle.switch@motor-comm.com>
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

- [Low] The new UAPI macro MDIO_PMA_10GBT_TESTMODE_MASK in
  include/uapi/linux/mdio.h is defined as GENMASK(15, 13).

--

net: phy: Add support for Template Control register for PMA

This adds the 10GBASE-T PMA Template Test Mode register definitions to
the UAPI mdio.h header. It also adds a genphy_c45_template_testmode()
helper that selects one of the eight test modes (Normal and
TestMode1..TestMode7) through phy_modify_mmd().

> diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
> index 06f4bc3c20c71..353ca13c64fca 100644
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
Will userspace that uses MDIO_PMA_10GBT_TESTMODE_MASK from the installed
<linux/mdio.h> still build?

GENMASK is defined in include/linux/bits.h, and that header is not
exported. Under include/uapi, include/uapi/linux/bits.h only provides
__GENMASK, __GENMASK_ULL and __GENMASK_U128. Also, include/uapi/linux/mdio.h
only includes <linux/types.h> and <linux/mii.h>.

A userspace program that expands this macro, for example a tool that
uses SIOCGMIIREG/SIOCSMIIREG on a C45 PHY, would hit an undeclared
GENMASK unless it defines one itself. The kernel build is fine because
kernel code gets GENMASK from include/linux/bits.h.

This header already does the same thing in MDIO_AN_C73_0_S_MASK,
MDIO_AN_C73_0_E_MASK and MDIO_AN_C73_1_T_MASK. This patch adds one more
macro that userspace can't use, though.

Most masks in this file are hex literals. Would 0xe000 work here instead?

> +#define MDIO_PMA_10GBT_TESTMODE_NORMAL 0x0 /* Template Normal */
> +#define MDIO_PMA_10GBT_TESTMODE_1 0x1 /* Template TestMode1 */

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261018022151.2677056-1-kyle.switch%40motor-comm.com
