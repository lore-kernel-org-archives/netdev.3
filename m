Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30E022882AB;
	Sat,  3 Oct 2026 21:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791062471; cv=none; b=BPoxBc7tFV07pWQGpaI0Z2id35pGSyLMEJJw0DDvU0MRnUexa4gmpZQjb32T3PucVq3X42IV74MSauJsGcfxm16Py1UEMgAglm/gcUlO/osoEzHi8WzuovAxG2Nh9DuSvitVLlgKQXj5lbWGuC012rEFN5s8HLnaQ9ECnNndah8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791062471; c=relaxed/simple;
	bh=4oY/ipzEWPb9kxkqSvfCZ8BeCfwEdNXPdM8jqm29JRg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VvOqbMYqN9D9R1mA8TWhxd99Q6xl7apj7dhF3FGmaVBRYk7lu9LsEp6XPTTJJDCpmsGDfTMCZ7hZA7PSvQPkQOceCIUdlwGVfvjFX+Bs0ty8h93EWIQh89gR3tde7smOQPzHWi2VM84u9Y5VhApxjCopJrB984s06ZCV+lRIBSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XlPYTYkK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XlPYTYkK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 651F21F0089B;
	Sat,  3 Oct 2026 21:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791062470;
	bh=siJn7d87j+EL2TuyYsogClY+jOSJ9pZF1HmE5ZN+loU=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=XlPYTYkKpePrAZ1FsmcLp+MWdxhkb/esUprCzEHZ/EXwuWen12+dDB4/fBBMcYYeX
	 o47ctuQgCfEIbvZwsWCIsK1OM0emM8YcWMD54hPUrRXrgGca51Up0Obzq95WLQZbjo
	 YFy4nDVoUlscVm91IaMeTFJoVzoYNRPK3Ljcnbi+YI6pJA7HGdmZXn08SIRZixnXYR
	 FzY4VXmM/X+VBsb/Lo+Nh8cCEiOt6POPLyUcdphLKWZW8311Zm0BEQxpdg1Zehmb8V
	 fVaxdKYwyaqg3RxrAd5XFmQfJx0Ppa69+Ck+KdydbjqkLXP8CZZav8ReDfRDiFJLEG
	 LWHv21DhLIgvg==
Subject: Re: [PATCH net v3] net: phy: qcom: at803x: Apply IPQ5018 analog
 settings at probe
From: netdev-bot+sashiko@kernel.org
To: yongzhao.derek@gmail.com
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@kernel.org,
 kuba@kernel.org, pabeni@redhat.com, george.moussalem@outlook.com,
 hzyitc@outlook.com, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Sat, 03 Oct 2026 21:21:08 +0000
Message-ID: <179106246893.434549.12601361985639254046@kernel.org>
In-Reply-To: <20261002210408.730-1-yongzhao.derek@gmail.com>
References: <20261002210408.730-1-yongzhao.derek@gmail.com>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] ipq5018_probe() (drivers/net/phy/qcom/at803x.c) calls
  reset_control_reset(priv->rst) at line 1135.

--

net: phy: qcom: at803x: Apply IPQ5018 analog settings at probe

This commit moves the IPQ5018 internal GE PHY analog settings into a
helper, ipq5018_analog_init(), that both config_init() and probe call.
Probe now applies the settings right after it pulses the PHY reset, then
restarts autonegotiation, so the PHY no longer negotiates with the
reset-default analog settings until the MAC attaches. The helper also
returns MDIO errors now instead of ignoring them.

> diff --git a/drivers/net/phy/qcom/at803x.c b/drivers/net/phy/qcom/at803x.c
> index cacbadf1f4841..09105f1e37379 100644
> --- a/drivers/net/phy/qcom/at803x.c
> +++ b/drivers/net/phy/qcom/at803x.c

[ ... ]

> @@ -1111,6 +1138,21 @@ static int ipq5018_probe(struct phy_device *phydev)
>  
>  	phydev->priv = priv;
>  
> +	/*
> +	 * The PHY starts autonegotiation as soon as it leaves reset. Apply the
> +	 * analog settings now instead of waiting for config_init() at attach
> +	 * time, and restart autonegotiation so that it uses them.
> +	 */
> +	ret = ipq5018_analog_init(phydev);

[Severity: Medium]

Is the GE PHY ready for these debug and MMD register accesses this soon
after the reset?

Earlier in ipq5018_probe(), reset_control_reset(priv->rst) pulses the
reset. That call ends up in qcom_reset():

drivers/clk/qcom/reset.c:qcom_reset() {
	rcdev->ops->assert(rcdev, id);
	fsleep(rst->reset_map[id].udelay ?: 1); /* use 1 us as default */

	rcdev->ops->deassert(rcdev, id);
	return 0;
}

The GCC entry sets no udelay. It covers several GE PHY sub-block resets
at once, including the DSP reset:

drivers/clk/qcom/gcc-ipq5018.c:
	[GCC_GEPHY_MISC_ARES] = { 0x56004, .bitmask = GENMASK(3, 0) },

So nothing waits after deassert before ipq5018_analog_init() runs.
Before this patch, the first analog access happened in config_init().
On the tested board that was about 39 s after the reset.

The patch notes say the vendor SDK waits 200 ms after every Ethernet
reset. If the PHY needs that kind of settle time after ARES deassert,
could the PHY's own init lose or overwrite the probe-time LDO_EFUSE,
DAC_FILTER, EEE, MSE, MDAC and EDAC writes? The PHY would then still
negotiate with reset defaults, which is the failure this patch is meant
to fix.

ipq5018_analog_init() also reads ANA_DAC_FILTER and writes the value
back:

	val = at803x_debug_reg_read(phydev, IPQ5018_PHY_DEBUG_ANA_DAC_FILTER);
	...
	ret = at803x_debug_reg_write(phydev, IPQ5018_PHY_DEBUG_ANA_DAC_FILTER,
				     val);

If the read returns a transient value this early, that value gets
written back. Wouldn't config_init() later re-read the wrong value and
keep it when it rewrites LDO_EFUSE, instead of correcting it?

MDIO transactions don't fail while the target block is busy, so the new
error checks would not catch either case.

The patch notes already ask whether a minimum delay or a readiness check
is needed after ARES is deasserted. Would it make sense to add one after
reset_control_reset() and before ipq5018_analog_init()?

> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to apply analog settings\n");
> +
> +	ret = genphy_restart_aneg(phydev);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to restart autonegotiation\n");
> +
>  	return 0;
>  }
>

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261002210408.730-1-yongzhao.derek%40gmail.com
