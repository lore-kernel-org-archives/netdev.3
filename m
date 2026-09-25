Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAD63B14B7;
	Fri, 25 Sep 2026 18:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790361787; cv=none; b=kLtZcpzuRC5bBZJF0i2IjXpHnDhFcQ4212/P4PXhY25q7L3MJc4F5igjSVMkoASgONpm/T2P7P8GxeEHqWonDKuYPUTM21qRq1/KI/g+jwdCTrp54XTnM8G2nGT80VGNbmipLwfmwVBwtW3droH50FHbZ7y88qnDDRVPi3Fg26Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790361787; c=relaxed/simple;
	bh=wKfCsQQMeZSeqxSgDauk8svih84GS4XuTP6ZJBPgTE4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TpAM1fNdVeMyxWNiEqc7q5g7tzrwHZxoJBzzZLls195FKVLIDmnbDqX1SzErRm0HEhw3fpSIkXWuRzoSKjq12Ai4kjH1FZxNZ5fFh30JPLHtYlIojuI2cg6gKtsKBaZdZN50RaYDpl0IFnIM96aHu2rHVSJJWitAdZlJzxCyWCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KNfwTJAZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KNfwTJAZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADC5F1F000FF;
	Fri, 25 Sep 2026 18:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790361785;
	bh=NvG9jW/6Ypl5e1J7vlxrwdFbpCJZ3skRDSf1wuygkBU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=KNfwTJAZPooPdvcLyn+EKHhJZga5jtdo4d7i9uhHlWE2M2rc2qcmr65v/BrpLjmXZ
	 Wn2zruQpxvYMgVFsYRVYFOv8Gk9oymC1Ddp2jWEZPQSHakwDSHgvEq3xJBbHAAfdnF
	 hUNjDVTS1DndrK8xwZshELvXuIhHee2TfmsGTOA2bolTvKZZxy+0J8jSuU6U8N8UIn
	 gpb9xvZPwSGh7i90np3INc/94HIKXDX0p5vXZclVhOthnz4VW9mriwd+QKrEKLXBMq
	 T0NMiYvxtoe8SV/gdALw6RCi16LzfXFZTozcwPElkjFPtCn2cBdZN7Juf/n7qZ+RmU
	 RQBjYpAwD8pmQ==
Subject: Re: [net-next,PATCH v2] enetc: Increase eMDIO MDC rate to 2.5 MHz
From: netdev-bot+sashiko@kernel.org
To: marex@nabladev.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
 xiaoning.wang@nxp.com, claudiu.manoil@nxp.com, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vladimir.oltean@nxp.com, wei.fang@nxp.com,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Fri, 25 Sep 2026 18:43:04 +0000
Message-ID: <179036178420.2160803.4979357583820016009@kernel.org>
In-Reply-To: <20260924180607.60932-1-marex@nabladev.com>
References: <20260924180607.60932-1-marex@nabladev.com>
X-sashiko-severity: Medium
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 1 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The patch changes ENETC_EMDIO_CFG in
  drivers/net/ethernet/freescale/enetc/enetc_mdio.c from…

Pre-existing issues:
- [Medium] Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml
  covers pci1957,ee01 (LS1028A) and pci1131,ee00 (i.MX95/94).

--

enetc: Increase eMDIO MDC rate to 2.5 MHz

This commit changes the fixed eMDIO clock divider in ENETC_EMDIO_CFG from
258 to 66. The goal is to raise MDC from 558 kHz to 2.5 MHz on i.MX95 B0.
The NXP TJA1120 PHY needs an MDC of at least 1 MHz, which is the reason
for the change.

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_mdio.c b/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
> index 998aaa394e9c4..a90a04a47befd 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
> @@ -24,7 +24,7 @@
>  
>  #define ENETC_EMDIO_CFG \
>  	(MDIO_CFG_HOLD(2) | \
> -	 MDIO_CFG_CLKDIV(258) | \
> +	 MDIO_CFG_CLKDIV(66) | \
>  	 MDIO_CFG_NEG)

[Severity: Medium]
The commit message only describes i.MX95 B0. What MDC rate does this
divider give on the other SoCs that use it?

ENETC_EMDIO_CFG is a compile-time constant and does not depend on the
input clock. enetc_mdio_read_c22(), enetc_mdio_write_c22(),
enetc_mdio_read_c45() and enetc_mdio_write_c45() write it to MDIO_CFG
before every transaction:

    mdio_cfg = ENETC_EMDIO_CFG;
    ...
    enetc_mdio_wr(mdio_priv, ENETC_MDIO_CFG, mdio_cfg);

These accessors are installed by:

  - enetc_pci_mdio_probe(), for both the LS1028A EMDIO (1957:ee01) and
    the i.MX95/i.MX94 netc_emdio (1131:ee00)
  - enetc_mdio_probe() and enetc_imdio_create() in enetc_pf_common.c
  - vsc9959_mdio_bus_alloc(), for the LS1028A Felix switch internal MDIO
  - netc_port_create_emdio_bus(), for the NETC switch per-port EMDIO

The driver uses a different system clock for each of the two generations
in enetc.c:

    .sysclk_freq = ENETC_CLK_400M,  /* enetc_pf_data */
    .sysclk_freq = ENETC_CLK_333M,  /* enetc4_pf_data */

The sibling QorIQ driver, xgmac_mdio.c, puts its divider at the same bit
position and uses MDC = f_in / (2 * div + 1). Under that formula the new
divider gives f_in / 133.

If the LS1028A EMDIO is clocked at 400 MHz, would MDC be about 3.0 MHz?
The old divider gave about 774 kHz. That new rate is above the 2.5 MHz
802.3 limit the commit message is aiming for. Even at 333 MHz, the result
would be about 2.504 MHz, slightly over the limit.

The driver has no per-SoC divider and does not read the input clock rate.
Boards such as LS1028A RDB/QDS, Kontron sl28 or TQ MBLS1028A would have
no way to bring MDC back down.

Could the divider be derived from the actual input clock, or at least
chosen per SoC?

[Severity: Medium]
This is a pre-existing issue and was not introduced by this patch. The
binding and the driver do not agree on how the MDC rate is set.

Documentation/devicetree/bindings/net/fsl,enetc-mdio.yaml covers both
pci1957,ee01 and pci1131,ee00. It includes mdio.yaml, so the generic
clock-frequency property passes schema validation:

clock-frequency:
    description:
      Desired MDIO bus clock frequency in Hz. Values greater than IEEE 802.3
      defined 2.5MHz should only be used when all devices on the bus support
      the given clock speed.

enetc_pci_mdio_probe() never reads this property. It only calls:

    err = of_mdiobus_register(bus, dev->of_node);

The divider therefore always comes from ENETC_EMDIO_CFG, and any
clock-frequency value in the DT is silently ignored. By comparison,
xgmac_mdio_set_mdc_freq() in xgmac_mdio.c and fec_main.c both honour this
property.

This patch makes the fixed MDC about 3.9 times faster on every board.
Should the driver honour clock-frequency, so that a board whose PHY or
wiring can't handle the new rate can lower it through the DT?

That would also need the input clock rate. The netc_emdio and
enetc_mdio_pf3 DT nodes don't provide it today.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924180607.60932-1-marex%40nabladev.com
