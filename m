Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794468306;
	b=qQAsRpXFNg350XGTYbHQ2tEz3kBSTO1sB44NjGRSISx3d3eI0NBAiQ6iUnbLV39FxBcy
	 K+11/Bs07LW14jAG+i/EQnxrsOdJPm0wsje5goupPvPWugiZQ+5jBGenY0zYjkgBzLVr6
	 9duh61ft9eHhs3HuA0zchjrNq2vzK1SGPdZVnIs37uhUUfF6EbF4ZV5ceIPSnEHQ9CfxH
	 OXfvg3Fwlc5xyEFSL/NKNZQrxrbXbEVarLmKpbt9gzE/YUipwVOM7oO4UCgqVep5Af1cM
	 xF9dmtk++Q+D7KSu3LCuDvuHMpFd7HxumwKFOwsgrSC/uJ0vpb48QaUjT+zp1O6AkPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794468306;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=pqC808M/mZK8wr2GU+lcOwmAS4GPcScAPoGXHMQXl8k=;
	b=sxAB5HKNndDMkoXDPT2hkpMGSzdSwF7VjrT+cWP31epCbaNTucnX0e9X1vzPA3Fyka7l
	 LBT9G3aDYvTJCngp4we7FiHbckJZp4s7GaQoNlPBKAtA6pmtqBLo8lYuu94pMSbVb3m2p
	 KnzOiZ7/gjLy7Ll6+GkigixkBEVbJNuYeBkBtDPkDShcIzWfgNaXc5GIrIdShs1o7eu/P
	 ISJlqpEJsgMa2NiiGUTC2VniDSRcO0uNqbkzvYT2IaLPOdBXj8jxjC/nN4aWhMELzYHG0
	 SH3bMBfaXlvrNDfP9aR/3fKtytq4571dZGit11tJFX9qqFRl33JZkTUH15FsJqmAXbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HNdFc70J;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C16D6606A32E;
	Thu, 12 Nov 2026 07:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HNdFc70J
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBD01F00A07;
	Thu, 12 Nov 2026 07:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794468306;
	bh=pqC808M/mZK8wr2GU+lcOwmAS4GPcScAPoGXHMQXl8k=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=HNdFc70JhZjcvuKLNs4EfjWppFCSNim5jLbVVJZPo/oeyyFA52BKRw44NrvWunV3t
	 GpbLsLTioy6nWuxiGDslqUkEIzHr7brGuBroD5x0jF01ySwD4gIqg120R9/4fDqEyp
	 1hrtJKFfSQLmZfwJwQyoCbGpSOhRQfHuEfzRA8CHJRPhKrYMCUetbo9ltrMneLJd1x
	 Ld12HPfg1BDRSsBSlnDNByHdlS1RkoQEhhC7BCrms0Qi//fzYgL75T431SRysdNcoL
	 XVWfWspPl0vyg3OATolqSYZSMS5LW/DhDnAxQaRNzsYFeuTjd3hPuVkYJblRle4nL4
	 2yqVn/RVOEQZA==
Subject: Re: [PATCH net-next 3/3] net: ethernet: ti: am65-cpts: implement
 PTP_SYS_OFFSET_PRECISE
From: netdev-bot+sashiko@kernel.org
To: jjc@jclark.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, richardcochran@gmail.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, lee@kernel.org, s-vadapalli@ti.com,
 rogerq@kernel.org, bigeasy@linutronix.de, martin.kaistra@linutronix.de,
 vadim.fedorenko@linux.dev, r-sharma3@ti.com, robertcnelson@gmail.com,
 nm@ti.com, vigneshr@ti.com, c-vankar@ti.com, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, mfd@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Date: Thu, 12 Nov 2026 07:25:04 +0000
Message-ID: <179446830443.2199510.10552580927894870264@kernel.org>
In-Reply-To: <fd826c118aec02c06bde92ff9c20f1958c214b3d.1794284248.git.jjc@jclark.com>
References: <fd826c118aec02c06bde92ff9c20f1958c214b3d.1794284248.git.jjc@jclark.com>
X-sashiko-severity: Medium
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

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 0 · Medium: 3 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The optional ti,gtc-push property fails in two different ways
  in am65_cpts_of_parse() (drivers/net/ethernet/ti/am65-cpts.c).
- [Medium] am65_cpts_gtc_push_select() in
  drivers/net/ethernet/ti/am65-cpts.c writes the EXPBIT_SEL field of…
- [Medium] am65_cpts_gtc_push_select() in
  drivers/net/ethernet/ti/am65-cpts.c reads GTC_CFG0_PUSHEVT back only…

--

net: ethernet: ti: am65-cpts: implement PTP_SYS_OFFSET_PRECISE

This commit adds getcrosststamp support to the TI K3 CPTS driver. It uses
the Global Timebase Counter push event output, routed to a CPTS hardware
timestamp input. For each request the driver enables the push input,
waits for an event and pairs the PHC timestamp with the computed GTC
edge, retrying up to three times. The feature is enabled when the CPTS
node has a ti,gtc-push property naming the GTC CFG0 syscon and the push
input.

> diff --git a/drivers/net/ethernet/ti/am65-cpts.c b/drivers/net/ethernet/ti/am65-cpts.c
> index 0d71147f3c291..70b0d43bfe788 100644
> --- a/drivers/net/ethernet/ti/am65-cpts.c
> +++ b/drivers/net/ethernet/ti/am65-cpts.c

[ ... ]

> @@ -797,6 +839,226 @@ static int am65_cpts_ptp_enable(struct ptp_clock_info *ptp,

[ ... ]

> +/* select the counter bit the GTC exports on its push event output */
> +static int am65_cpts_gtc_push_select(struct am65_cpts *cpts)
> +{
> +	u32 val;
> +	int ret;
> +
> +	ret = regmap_update_bits(cpts->gtc, AM65_CPTS_GTC_PUSHEVT,
> +				 AM65_CPTS_GTC_PUSHEVT_EXPBIT_SEL,
> +				 FIELD_PREP(AM65_CPTS_GTC_PUSHEVT_EXPBIT_SEL,
> +					    AM65_CPTS_GTC_PUSH_BIT));

[Severity: Medium]
Is it safe for this driver to own the EXPBIT_SEL field of GTC_CFG0_PUSHEVT?

The register belongs to the SoC-wide GTC, not to the CPTS.
am65_cpts_ptp_getcrosststamp() rewrites it on every PTP_SYS_OFFSET_PRECISE
request. The previous value is never saved or restored, on success or on
error.

The GTC push event output goes into the Time Sync Router, which can send
it to other timesync capture inputs, SYNC_OUT pins, or software on other
cores. Suppose one of those consumers expects a different exported bit.
Won't its signal frequency change after the first request from Linux, and
then be forced back to bit 15 on every later request?

The ti,gtc-push binding added in this series describes the GTC as the
SoC's system counter. It doesn't give this CPTS exclusive ownership of the
push output.

> +	if (ret)
> +		return ret;
> +	/* flush the posted write before the input is enabled */
> +	return regmap_read(cpts->gtc, AM65_CPTS_GTC_PUSHEVT, &val);

[Severity: Medium]
Should val be checked here, to confirm that EXPBIT_SEL now reads back as
AM65_CPTS_GTC_PUSH_BIT?

am65_cpts_gtc_push_next_edge() and the window check in
am65_cpts_gtc_push_wait() both assume rising edges at k * 2^16 + 2^15:

	if ((s64)(popped - edge) < 0 ||
	    (s64)(popped - edge) >= (s64)AM65_CPTS_GTC_PUSH_PERIOD) {
		...
		return -EAGAIN;
	}

	push->cycles = edge;

The write might not take effect. For example, the CFG0 region could be
firewalled or read-only in some security configuration, or another agent
could rewrite the field. Then the exported bit b' is not 15.

With b' < 15, the first event comes from an edge before the expected
bit-15 edge. If IRQ thread latency puts popped past edge, the attempt is
accepted with push->cycles = edge. The result is off by up to that
latency.

With b' = 16, every bit-16 edge falls 2^15 cycles after a bit-15 edge,
which is inside the window. About half of attempts would pass while being
about 164 us off at 200 MHz.

In both cases, wouldn't PTP_SYS_OFFSET_PRECISE return a wrong
cross-timestamp to userspace with no error? The syscon regmap is uncached,
so a FIELD_GET() on val would catch the mismatch.

[ ... ]

> @@ -1160,6 +1423,24 @@ static int am65_cpts_of_parse(struct am65_cpts *cpts, struct device_node *node)
>  		}
>  	}
>  
> +	if (of_property_present(node, "ti,gtc-push")) {
> +		gtc = syscon_regmap_lookup_by_phandle_args(node, "ti,gtc-push",
> +							   1, &prop[0]);
> +		if (IS_ERR(gtc))
> +			return dev_err_probe(cpts->dev, PTR_ERR(gtc),
> +					     "Failed to get GTC syscon\n");

[Severity: Medium]
Should a failed syscon lookup be fatal here? A bad index just below only
logs an error and leaves the feature disabled.

Returning here makes am65_cpts_create() return ERR_PTR(ret).
am65_cpsw_init_cpts() in am65-cpsw-nuss.c then fails the whole CPSW probe:

	if (IS_ERR(cpts)) {
		int ret = PTR_ERR(cpts);

		of_node_put(node);
		dev_err(dev, "cpts create err %d\n", ret);
		return ret;
	}

So a problem with the optional cross-timestamp property takes down the
Ethernet interface.

A correct DT can also hit this. TI_K3_AM65_CPTS does not select or depend
on MFD_SYSCON, and ARCH_K3 does not select it either:

config TI_K3_AM65_CPTS
	tristate "TI K3 AM65x CPTS"
	depends on ARCH_K3 && OF
	depends on PTP_1588_CLOCK

With CONFIG_MFD_SYSCON=n, the syscon stub returns ERR_PTR(-ENOTSUPP). Any
DT with ti,gtc-push would then stop Ethernet from probing. The same
happens if the phandle points at a node without the "syscon" compatible.

The existing ti,pps handling and the new index check both treat errors as
non-fatal. Could this path do the same, or should a Kconfig dependency on
MFD_SYSCON be added?

> +
> +		if (prop[0] > 7 ||
> +		    (cpts->pps_present && prop[0] == cpts->pps_hw_ts_idx)) {
> +			dev_err(cpts->dev,
> +				"invalid GTC push HWx_TS_PUSH index: %u\n",
> +				prop[0]);
> +		} else {
> +			cpts->gtc = gtc;
> +			cpts->gtc_push_hw_idx = prop[0];
> +		}
> +	}

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/cover.1794284248.git.jjc%40jclark.com
