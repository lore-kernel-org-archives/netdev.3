Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA7049B465;
	Mon, 28 Sep 2026 10:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790591961; cv=none; b=B2o1D2m37tspcOxz2XikUPkhdouC9RY0VzLZbImkLgmzrynFLS+JxPQUD2VZaz6Niu83WN6a5IXhQ8dY35X6J2Zw0sPnIU0M/e0fMgNQQ4z+9ibey4eBwet1skZFR1GAOYSA0WgDhcQYT3VwDFLnVla8N6UesDGigIIypwsjc3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790591961; c=relaxed/simple;
	bh=6gTVcHRbICw0sz0jRiXa3L5E5R7mJOsLQ8DrOiV0hT0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lyLK9otdB/YUIldICvOkTq31Xy/zK5bUcTnztewQ/kywNpyKg7gr4ZRVjPFtNkIXFTCFqdh7nj2JMqGH6H/w6U9y5jM1fsZPr1NJN2efSuqL279BFg25MsdvEDarzlYD5t+m9v1xd6ajo+euxEUTmvmCpK8Y1YBHCNt69GNByuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R26SCuVs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R26SCuVs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AE921F00893;
	Mon, 28 Sep 2026 10:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790591959;
	bh=1LZ3XpDsjo8wGL6BDOWLVtSDb0Lw5LJi/frYniFXLkU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=R26SCuVsWSX6Bwz1IObBsyjom028w2Z9fKqz7HC6D6oC9ggy3HOLeSg1nlg3kAkRf
	 02cjQfTbOOeDlja2Xa8bq5/tKgXxsfSxnaQ2t15RCo19NWPuj8h7Hf54QbVJqpRrAn
	 BtIcFY+Gn3M6nHzEJjLqWn4IIVGSobR/XJ00D9V/JxN/M9JxbepZYN+toEwNUJEOLq
	 bfYktSkw5JUpXQFeSR6F+Ly6hm9fjZFQB9lt3lD7TUv+kDFCsb6d9S669qqi0cTX6j
	 nbinQRcPaEw4Iu5Tg3Nk9vzOLLrI5t9+s0QbHwRuvBugFQFDIB1EBdorh6Ga+HD6LF
	 J/91SAFOt4Mzg==
Subject: Re: [PATCH net-next v9 2/7] net: dsa: motorcomm: use max_ports in
 series for port bounds checking
From: netdev-bot+sashiko@kernel.org
To: kyle.switch@motor-comm.com
Cc: andrew@lunn.ch, olteanv@gmail.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
 horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
 xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com, wei.zhang@gl-inet.com,
 sijia.huang@gl-inet.com
Date: Mon, 28 Sep 2026 10:39:18 +0000
Message-ID: <179059195808.3145.17249114041755929761@kernel.org>
In-Reply-To: <20260924094146.4128703-3-kyle.switch@motor-comm.com>
References: <20260924094146.4128703-3-kyle.switch@motor-comm.com>
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

- [Low] Concern: the commit overclaims, and nothing ties
  series->max_ports to the fixed-size port storage.

Pre-existing issues:
- [Low] Concern: yt921x_mbus_int_read()/write() and phy_mask bound the
  internal MDIO bus by the total DSA port count (series->max_ports = 11…

--

net: dsa: motorcomm: use max_ports in series for port bounds checking

This patch replaces the hardcoded YT921X_PORT_NUM with the per-series
priv->series->max_ports in three places: the internal MDIO bus bounds
checks in yt921x_mbus_int_read() and yt921x_mbus_int_write(), and the
phy_mask computed in yt921x_mbus_int_init().

> diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
> index d4a565994940..b95f3c355511 100644
> --- a/drivers/net/dsa/motorcomm/chip.c
> +++ b/drivers/net/dsa/motorcomm/chip.c
> @@ -357,7 +357,7 @@ static int yt921x_mbus_int_read(struct mii_bus *mbus, int port, int reg)
>  	u16 val;
>  	int res;
>  
> -	if (port >= YT921X_PORT_NUM)
> +	if (port >= priv->series->max_ports)
>  		return U16_MAX;

[Severity: Low]
The commit message says this "removes family-specific constants from the
common code path". Nothing in the patch ties series->max_ports to the size
of the per-port storage, though. Is that intended?

struct yt921x_priv still sizes its port array with the YT921x constant:

drivers/net/dsa/motorcomm/chip.h:struct yt921x_priv {
    ...
	struct yt921x_port ports[YT921X_PORT_NUM];
    ...
};

YT921X_PORT_NUM also still bounds loops in these functions:

  yt921x_lag_set()
  yt921x_isolate()
  yt921x_bridge() (twice)
  yt921x_chip_setup_dsa() (twice)

Meanwhile ds->num_ports now comes from priv->series->max_ports.

With the current table this can't happen. At the end of the series,
YT921X has max_ports = 11 and YT922X has max_ports = 9, so both fit. The
remaining YT921X_PORT_NUM loops are also only reachable from YT921x-only
code.

If a future series entry had max_ports greater than YT921X_PORT_NUM,
though, could priv->ports[] be indexed out of bounds? Would a
BUILD_BUG_ON() or a probe-time check that max_ports is no larger than
ARRAY_SIZE(priv->ports) be worth adding?

[ ... ]

> @@ -402,7 +403,8 @@ yt921x_mbus_int_init(struct yt921x_priv *priv, struct device_node *mnp)
>  	mbus->read = yt921x_mbus_int_read;
>  	mbus->write = yt921x_mbus_int_write;
>  	mbus->parent = dev;
> -	mbus->phy_mask = (u32)~GENMASK(YT921X_PORT_NUM - 1, 0);
> +	max_ports = priv->series->max_ports;
> +	mbus->phy_mask = (u32)~GENMASK(max_ports - 1, 0);

[Severity: Low]
This is a pre-existing issue, and this patch didn't introduce it. It
shows up here because the bound is being changed. max_ports counts every
DSA port, not only the integrated PHYs:

drivers/net/dsa/motorcomm/chip.h:
/* 8 internal + 2 external + 1 mcu */
#define YT921X_PORT_NUM			11

As a result, yt921x_mbus_int_read() and yt921x_mbus_int_write() still
allow internal MDIO bus transactions to addresses 8-10 if the DT puts a
PHY there. The phy_mask computed here doesn't limit scanning either,
because __of_mdiobus_register() overwrites it with ~0.

The baseline used the same value, so "No functional change for existing
YT921X devices" is accurate.

Bounding by info->internal_mask may not be right either. Later in the
series, YT922x uses internal bus addresses that are not integrated UTP
PHYs, via yt922x_sds_phyaddr_get(): SerDes addresses 0 and 8, and
YT922X_COMMON_EXT_PHYADDR (9).

Should the internal bus bound describe the addresses that actually exist
on that bus, rather than the total port count? Or is using max_ports here
intentional?

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924094146.4128703-1-kyle.switch%40motor-comm.com
