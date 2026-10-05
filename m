Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CB937C108;
	Mon,  5 Oct 2026 19:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791228444; cv=none; b=o2bey1XYGmw3p8tc3B5nFSbwapXZZtfdISXOyFyapj3hqnm24KOLtsxUWPBpDg35D/6v8i7O19Q1VPObiaS7VD2nRdm+racEgwRVaDFljFQ3zRB8QFc3ySXyl3vThFqX93htgMdjzJzGVRSXUUbqHmb4kBL+Udd2gHa0sQD1IUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791228444; c=relaxed/simple;
	bh=p25mz2c2U6rP08YevsvgxbMxPR/DzThDgMzYskbcgug=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gp4QnJ5DRl1MD/PZDi3GlCkVrDfsyGaY2ocCJbn3hLeF+LitjBKNXGydLq+Z+auDrOT3jfnKgi8kEI47ydj+j8AttIhJnQGJ8G3PvST9K3usGzl58rc0Gyw88hHQiHhfsvxo7B4ID1GuK5LqgNdUpKymITFYEY6aQZ3fcSTvmik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cw1yKbeM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cw1yKbeM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9193B1F000FF;
	Mon,  5 Oct 2026 19:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791228442;
	bh=Ba5ES8avXTTTld+4fo4sHn4uA/GOhpAOcPT2KQAZMm8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cw1yKbeMb+2MPymWgEkSDwzKzm3DoRJtLVnQtp22HOM6axkP36kNakQPhQ+fsr9pA
	 80W/jgF7wwSuSwEe0DfQGGu22iRbJTzaD7GK/MjgGPiGPzzKmSSoED7KFeeyM9LIbV
	 Xxpf+IPHOLNnLJ2vGlVDZ6aaH0L6t7EEaGJd7gsZFhgHE8cxhOy3khXGCBrd4Ey9Gk
	 yTjuj4/AQ+o93MW1GT/PXuZSbGdjC0hP/AJF7YBfL2eJ2PCD6RYf8AtoVm5ICoOOac
	 +tVk6TC41NCm6Ync3ugbJbosSPdhDhVKZBD4S4OhWfLM7yxtkm9qcCIEhNC+eeaeYO
	 3NbF3kohtCY2g==
Subject: Re: [PATCH net-next] net: phy: motorcomm: Add cable test support for
 internal YT861x PHYs
From: netdev-bot+sashiko@kernel.org
To: mmyangfl@gmail.com
Cc: netdev@vger.kernel.org, Frank.Sae@motor-comm.com, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 linux-kernel@vger.kernel.org
Date: Mon, 05 Oct 2026 19:27:21 +0000
Message-ID: <179122844105.434549.17405741788888758665@kernel.org>
In-Reply-To: <20261004184246.1260426-1-mmyangfl@gmail.com>
References: <20261004184246.1260426-1-mmyangfl@gmail.com>
X-sashiko-severity: High
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found 3 potential
issue(s) to consider.

Critical: 0 · High: 1 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] yt861x_cable_test_get_status() in drivers/net/phy/motorcomm.c
  uses one variable, `ret`, for two different things.
- [Medium] yt861x_cable_test_start() clears YT8521_ESC1R_SLEEP_SW (auto-
  sleep) in ext register 0x27 at lines 2568-2570.
- [Low] The MOTORCOMM_PHY Kconfig help in drivers/net/phy/Kconfig still
  says "Currently supports YT85xx Gigabit Ethernet PHYs." The patch adds…

--

net: phy: motorcomm: Add cable test support for internal YT861x PHYs

This patch adds a driver entry for the YT861x family PHYs (PHY ID
0x01e04281) built into YT921x switches. Before this, they bound to the
generic PHY driver. The new entry adds TDR cable test start and status
callbacks.

> diff --git a/drivers/net/phy/motorcomm.c b/drivers/net/phy/motorcomm.c
> index 90a4f86f2758b..ef15fef304aa9 100644
> --- a/drivers/net/phy/motorcomm.c
> +++ b/drivers/net/phy/motorcomm.c

[ ... ]

> @@ -2538,6 +2554,95 @@ static int yt8521_get_features(struct phy_device *phydev)
>  	return ret;
>  }
>  
> +/**
> + * yt861x_cable_test_start() - start a cable diagnostic (TDR) test
> + * @phydev: a pointer to a &struct phy_device
> + *
> + * Returns: 0 or negative errno code
> + */
> +static int yt861x_cable_test_start(struct phy_device *phydev)
> +{
> +	int ret;
> +
> +	/* auto sleep would abort the TDR test */
> +	ret = ytphy_modify_ext_with_lock(phydev,
> +					 YT8521_EXTREG_SLEEP_CONTROL1_REG,
> +					 YT8521_ESC1R_SLEEP_SW, 0);
> +	if (ret)
> +		return ret;
> +
> +	return ytphy_write_ext_with_lock(phydev, YT861X_TDR_CTRL_REG,
> +					 YT861X_TDR_CTRL_START);
> +}

[Severity: Medium]
Can auto-sleep stay disabled if the test does not finish normally?

yt861x_cable_test_start() clears YT8521_ESC1R_SLEEP_SW. The only code
that sets it again is the success path at the end of
yt861x_cable_test_get_status(). These exits skip that restore:

- the YT861X_TDR_CTRL_REG write above fails, and the error is returned
  without restoring the sleep bit
- the YT861X_TDR_STATUS_REG read in yt861x_cable_test_get_status() fails,
  so the state machine calls phy_abort_cable_test()
- phy_stop() aborts the test, for example on "ip link set down" while a
  test is running
- the restoring ytphy_modify_ext_with_lock() call itself fails

The abort path is:

phy_stop()
  phy_abort_cable_test()
    ethnl_cable_test_finished()
    phy_init_hw()
      genphy_soft_reset()

The new driver entry has no config_init, so phy_init_hw() never writes
YT8521_EXTREG_SLEEP_CONTROL1_REG again. The success path sets SLEEP_SW
itself before calling genphy_soft_reset(). That suggests a BMCR reset does
not restore this ext register.

The restore also always writes SLEEP_SW=1 instead of the value that was
set before the test.

Could the previous value be saved and restored on every exit path? Or
could the bit be set again from a config_init callback?

> +
> +/**
> + * yt861x_cable_test_get_status() - report cable diagnostic test results
> + * @phydev: a pointer to a &struct phy_device
> + * @finished: set to true when the test is complete
> + *
> + * Returns: 0 or negative errno code
> + */
> +static int yt861x_cable_test_get_status(struct phy_device *phydev,
> +					bool *finished)
> +{
> +	int ret;
> +
> +	*finished = false;
> +
> +	ret = ytphy_read_ext_with_lock(phydev, YT861X_TDR_STATUS_REG);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (ret & YT861X_TDR_STATUS_BUSY)
> +		return 0;
> +
> +	for (int pair = ETHTOOL_A_CABLE_PAIR_A; pair <= ETHTOOL_A_CABLE_PAIR_D;
> +	     pair++) {
> +		u8 code;
> +
> +		switch ((ret >> (2 * pair)) & 0x3) {

[ ... ]

> +		ethnl_cable_test_result(phydev, pair, code);
> +
> +		if (code != ETHTOOL_A_CABLE_RESULT_CODE_OK &&
> +		    code != ETHTOOL_A_CABLE_RESULT_CODE_UNSPEC) {
> +			ret = ytphy_read_ext_with_lock(phydev,
> +						       YT861X_TDR_PAIR_LENGTH_REG(pair));

[Severity: High]
Does this overwrite the status word in ret while the switch above still
needs it for the remaining pairs?

If a pair is SHORT or OPEN, ret is replaced by that pair's fault length in
cm, or by a negative errno if the read fails. The next pairs are then
decoded from bits of that value, not from YT861X_TDR_STATUS_REG.

Take an unplugged cable, where the status is 0x00ff (all pairs open).
Pair A is reported OPEN. If each pair's length reads back as 300 (0x12c),
pair B decodes as OPEN, pair C as SHORT and pair D as OK.

If the length read returns -EIO, later pairs decode as SHORT or OPEN from
the errno bits. Length registers are then read for faults the hardware
never reported.

Should the status word be kept in a separate variable from the length
read?

> +			if (ret >= 0)
> +				ethnl_cable_test_fault_length(phydev, pair,
> +							      ret);
> +		}
> +	}

[ ... ]

> @@ -3194,7 +3308,7 @@ static struct phy_driver motorcomm_phy_drvs[] = {
>  
>  module_phy_driver(motorcomm_phy_drvs);
>  
> -MODULE_DESCRIPTION("Motorcomm 8511/8521/8531/8531S/8821 PHY driver");
> +MODULE_DESCRIPTION("Motorcomm 8511/8521/8531/8531S/861x/8821 PHY driver");

[Severity: Low]
This isn't a bug, but the MOTORCOMM_PHY help text in
drivers/net/phy/Kconfig still says:

	  Currently supports YT85xx Gigabit Ethernet PHYs.

The header comment and MODULE_DESCRIPTION now mention 861x. Should the
Kconfig help be updated to match? It was already missing YT8821 before
this patch.

[ ... ]

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20261004184246.1260426-1-mmyangfl%40gmail.com
