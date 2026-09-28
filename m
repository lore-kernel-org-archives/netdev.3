Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB21F33B6FB;
	Mon, 28 Sep 2026 00:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790556364; cv=none; b=RexeDtGe3ftPcAjCtr0xiaYMjab7ksEYnoQmXxFUBWmXfQGIXjrK9vR13YU6LY4O5T0sYshNBaaWmCPTdGmjzHf9/5EvBkTAFjUr8jlsnUuqa3xi5nNpoXlpatgjWwUxGivMwG89rROAia6+be1xn/qik2JKDETCB3ydQt2fK0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790556364; c=relaxed/simple;
	bh=MnbnVylyGuLf3rX0F5bMUHu5xygQPKBQOn4zeybZoOo=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LqXW3n6dslnUm6wSAmma3NVADsMmosEeFMND3qoBtadYqavUsBt7PfBW3FpuriGHHwh4lEZVvWNMa+ASP4lLgv7lQCoiG76TwHMODvq6e51km5OytaIB2QlJrnpAXtfJwAvVhUfQcfuoIa97/socLn5qhwBrAfDA/kuDD7NkaeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EAnMZn35; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EAnMZn35"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046681F000FF;
	Mon, 28 Sep 2026 00:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790556359;
	bh=iDTWTbsesCKDWU0wPcWa5OfHCranjK97rOj/GXBu9QY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=EAnMZn35/3VE3yoGkvt/ULZdEXByOhHU3+7wtcUv/mxOz0sbNAk/AITr/rk4ftyvC
	 WaNfEECVy2ctE+iRlw6/l6azsUG/JNA30Gp1juTM2e55FwWwxZCULF8XqKb9szGgmt
	 wWPymCg6Nbb1By+wQufi+LCRzLXQUOl9jpIHjN41fLmqLLyjyVWiI/yNX38P+LQ+QM
	 0WFnpWAnS0ZPJKeSFeyvykwTt9NPnKvnB95mRyCGkr1mnpv5FybIqDjPMXnURiP84W
	 ymEBAM3UAKZAfNNltzc1QdcS5kXVn0No3r67THaQANzHI4eTOhD52ES18dHwAFv+rF
	 7kI2TFENZyKhg==
Subject: Re: [net-next,PATCH v1] enetc: Increase eMDIO MDC rate to 1.2 MHz
From: netdev-bot+sashiko@kernel.org
To: marex@nabladev.com
Cc: netdev@vger.kernel.org, davem@davemloft.net, andrew+netdev@lunn.ch,
 xiaoning.wang@nxp.com, claudiu.manoil@nxp.com, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, vladimir.oltean@nxp.com, wei.fang@nxp.com,
 imx@lists.linux.dev, linux-kernel@vger.kernel.org
Date: Mon, 28 Sep 2026 00:45:58 +0000
Message-ID: <179055635852.3145.15306649512061194740@kernel.org>
In-Reply-To: <20260924003132.580306-1-marex@nabladev.com>
References: <20260924003132.580306-1-marex@nabladev.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 2 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] enetc: MDIO clock overclocked beyond 2.5MHz on 400MHz platforms
- [Medium] The two MDC rates in the commit message cannot both be right.

--

enetc: Increase eMDIO MDC rate to 1.2 MHz

This commit changes the divider in ENETC_EMDIO_CFG from 258 to 138. The
aim is to raise the eMDIO MDC clock on i.MX95 B0 from 558 kHz to 1.2 MHz,
so that PHYs such as the NXP TJA1120, which need at least 1 MHz, work.

> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_mdio.c b/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
> index 998aaa394e9c4..30ea91cea00e5 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_mdio.c
> @@ -24,7 +24,7 @@
>  
>  #define ENETC_EMDIO_CFG \
>  	(MDIO_CFG_HOLD(2) | \
> -	 MDIO_CFG_CLKDIV(258) | \
> +	 MDIO_CFG_CLKDIV(138) | \

[Severity: High]
Does this divider change only affect i.MX95?

ENETC_EMDIO_CFG is written to ENETC_MDIO_CFG on every access by
enetc_mdio_read_c22(), enetc_mdio_write_c22() and their c45
counterparts. Those helpers are shared by every ENETC eMDIO user.
That includes the LS1028A standalone eMDIO function in
enetc_pci_mdio.c and the Felix internal MDIO bus in felix_vsc9959.c,
not only the i.MX95 ENETC v4 PF.

The commit message only reasons about the i.MX95 clock. On LS1028A,
enetc_pf_data sets sysclk_freq = ENETC_CLK_400M. If MDC is the input
clock divided directly by CLKDIV, 400 MHz / 138 is about 2.9 MHz.
That is above the 2.5 MHz MDC limit in IEEE 802.3 clause 22. PHYs
that only guarantee 2.5 MHz could then return corrupted reads, fail
to probe, or miss link state changes on boards that work today.

The hardware may instead follow clk / (2 * div + 1), which is what
xgmac_mdio_set_mdc_freq() assumes for the sibling FSL block. In that
case LS1028A would land around 1.44 MHz and be fine. The commit
message does not say which relation applies, and it gives no figure
for LS1028A.

Was this tested on LS1028A, and what MDC rate results there? The
same constant gives different rates depending on the SoC clock.
Would it be safer to compute the divider from the actual clock rate
and a target MDC frequency, along the lines of the DT alternative
mentioned in the NOTE, rather than hardcoding one value for all
platforms?

[Severity: Medium]
Can the two MDC rates in the commit message both be right?

The message says:

    The current eMDIO MDC rate is 558 kHz on i.MX95 B0.
    ...
    increase the MDC clock to 1.2 MHz

That is a 2.15x increase. For any linear divider of the form
clk / (a * div + b) with b >= 0, going from 258 to 138 can raise the rate
by at most 258 / 138, about 1.87x.

The sibling FSL driver uses this relation in xgmac_mdio_set_mdc_freq():

    div = ((clk_get_rate(priv->enet_clk) / priv->mdc_freq) - 1) / 2;

That gives mdc = clk / (2 * div + 1), so the ratio here is 517 / 277, about
1.866.

If 558 kHz is the real current rate, the new rate would be about 1.04 MHz,
not 1.2 MHz.

Working the other way, enetc4_pf_data uses sysclk_freq = ENETC_CLK_333M for
i.MX95. That gives 333 MHz / 277, about 1.2 MHz, for the new setting. But
the same clock puts the old setting at 333 MHz / 517, about 644 kHz, not
558 kHz.

Which of the two figures was measured? If 558 kHz was measured on hardware,
the new MDC would be only about 4% above the TJA1120's 1 MHz minimum.

Could the commit message give the MDC rate actually measured after this
change?

>  	 MDIO_CFG_NEG)
>  
>  #define MDIO_CTL_DEV_ADDR(x)	((x) & 0x1f)

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260924003132.580306-1-marex%40nabladev.com
