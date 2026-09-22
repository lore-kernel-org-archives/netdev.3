Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CBA40A92B;
	Tue, 22 Sep 2026 05:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790053554; cv=none; b=YK96DtHhB7KUaTCiTdmAs99tiv64Jmv1sFtz37BXZ3pqDbCjcMG7AdLEnjJrgdH/yY+C0svD3HkTi4qYo5t5gV3CeYbERLWvTUPALuR3z6OZYW60r7hC7GWfRoDZW1inn9ouTwoWcM5qsUOjAwKwAk285JTLlXweFiLyK76RKCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790053554; c=relaxed/simple;
	bh=+Dgk1CyyuPfmejmzaDYjPRLvUSEYwPWTY8ChCWIxwsk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QKvEvMkdcHJLMYqwL/7/7GNPScG2Aj0OOFtciKCoasswbf4rPyHUS6RgeqEq3ISjJ67I8IYRGfaEHYGR3sk+Yla5csn/hShWQ0JGJSeF1rgk2F1f84P6A4M53BqFTbkoONU2bHzeWgRhazwC74iAGAviTemtr194NfCNx7RXQ1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bxwbdE5/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bxwbdE5/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D38C1F00893;
	Tue, 22 Sep 2026 05:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790053552;
	bh=f9XRDdyjLgW0k9chwHm3s9xJt8elC0xFaH7Yx/Ph070=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=bxwbdE5/lTwHZ0zgArVkpLAd7b56AMZgp33LR0gXqf92LpnW4L8gAMnYNiq1WBo0P
	 VnKag45pjnn7xtgHxzUu5UacloTmXGhgaNUP2BGoqqLQw0Kf8TVZbDYRdTxYuyJLp+
	 +58i9bIElh2JAlDCz3JTQXVcuCHT7Qk26Oe/izsVtLuFltMUgVCjxBzNrPE8SUZwtS
	 iqQqy4h7QIJaY0oOucChPCdPw7ylilIMTZfYnTJ2x3NYX6UdDMW4HYJYzqkvluOpqG
	 yGnC2nll+ccZXXnRPlFWi0zWWfsiTFL5gnOBYKcNFomZ8jqha9OEbiTPmy2Zc1vFyx
	 FZ6UnGqRzWgRQ==
Subject: Re: [PATCH net v2 2/3] net: stmmac: advertise integrated PCS
 interfaces to phylink
From: netdev-bot+sashiko@kernel.org
To: tom.karpiniec@outlook.com
Cc: netdev@vger.kernel.org, mohd.anwar@oss.qualcomm.com,
 maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, linux@armlinux.org.uk, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 yong.liang.choong@linux.intel.com, brgl@kernel.org, coiaprant@gmail.com,
 linux-arm-msm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 22 Sep 2026 05:05:51 +0000
Message-ID: <179005355105.2160803.1335027133175434239@kernel.org>
In-Reply-To: =?utf-8?q?=3CSJ2PR11MB8401D53F5519472525156BA9E4872=40SJ2PR11MB?=
 =?utf-8?q?8401=2Enamprd11=2Eprod=2Eoutlook=2Ecom=3E?=
References: =?utf-8?q?=3CSJ2PR11MB8401D53F5519472525156BA9E4872=40SJ2PR11MB8?=
 =?utf-8?q?401=2Enamprd11=2Eprod=2Eoutlook=2Ecom=3E?=
X-sashiko-severity: Medium
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

Critical: 0 · High: 0 · Medium: 2 · Low: 0

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] The Fixes tag names 68cff4fff61f ("net: stmmac: add BASE-X
  support to integrated PCS", 2026-03-18) and the stable Cc is…
- [Medium] The patch makes PHY_INTERFACE_MODE_1000BASEX runtime-
  selectable by phylink on every platform with an integrated PCS (the…

--

net: stmmac: advertise integrated PCS interfaces to phylink

This adds the integrated PCS supported_interfaces bitmap into
config->supported_interfaces in stmmac_phylink_setup(), so that
interfaces handled by the integrated PCS are advertised to phylink.
The stated symptom is SGMII missing from the bitmap on qcom-ethqos when
firmware selects 2500BASE-X, which makes phylink drop the lower-speed
modes of a QCA8081.

>     Fixes: 68cff4fff61f ("net: stmmac: add BASE-X support to integrated PCS")
>     Cc: stable@vger.kernel.org # 7.0+

[Severity: Medium]

Is 68cff4fff61f the right commit to blame here, and is the stable range
wide enough?

The thing being fixed is that stmmac_phylink_setup() never folded
priv->integrated_pcs->pcs.supported_interfaces into
config->supported_interfaces.  Both priv->integrated_pcs and the SGMII bit
appear to come from 2c81f3357136a ("net: stmmac: convert to phylink PCS
support"), which already had:

drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c:stmmac_integrated_pcs_init()
	__set_bit(PHY_INTERFACE_MODE_SGMII, spcs->pcs.supported_interfaces);

git blame attributes that SGMII line to 2c81f3357136a, while only the
surrounding 1000BASEX/2500BASEX/support_tbi_rtbi lines come from
68cff4fff61f.

The described symptom also doesn't seem to need anything 68cff4fff61f
added.  dwmac-qcom-ethqos implements neither get_interfaces() nor
select_pcs(), and has no xpcs or hw->phylink_pcs, so
config->supported_interfaces was just {2500BASEX} via the fallback:

	if (phy_interface_empty(config->supported_interfaces))
		__set_bit(priv->plat->phy_interface,
			  config->supported_interfaces);

phylink_validate_phy() then does phy_interface_and() against
phy->possible_interfaces, and qca808x_fill_possible_interfaces() only sets
SGMII + 2500BASEX, so the intersection collapsed to {2500BASEX} on kernels
containing 2c81f3357136a but not 68cff4fff61f as well.

Should the Fixes tag point at 2c81f3357136a and the stable Cc cover the
corresponding range, so those kernels get the fix too?  The patch applies
unchanged to any tree containing 2c81f3357136a.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 1350e92943ac..f956e0d2ec64 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -1414,6 +1414,12 @@ static int stmmac_phylink_setup(struct stmmac_priv *priv)
>  		__set_bit(priv->plat->phy_interface,
>  			  config->supported_interfaces);
>  
> +	/* If we have an integrated PCS, add the interfaces it supports. */
> +	if (priv->integrated_pcs)
> +		phy_interface_or(config->supported_interfaces,
> +				 config->supported_interfaces,
> +				 priv->integrated_pcs->pcs.supported_interfaces);
> +

[Severity: Medium]

Does this make 1000BASE-X selectable on platforms that cannot program
their SerDes for it?

stmmac_integrated_pcs_init() sets the 1000BASEX bit unconditionally, so
after this change config->supported_interfaces contains 1000BASEX on every
platform with an integrated PCS.  On qcom-ethqos, though, only SGMII and
2500BASEX reach the SerDes:

drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c:ethqos_mac_finish_serdes()
	if (interface == PHY_INTERFACE_MODE_SGMII ||
	    interface == PHY_INTERFACE_MODE_2500BASEX)
		ret = phy_set_mode_ext(ethqos->serdes_phy, PHY_MODE_ETHERNET,
				       interface);

	return ret;

The SerDes driver does distinguish the rates, so a stale setting is a real
mismatch rather than a don't-care:

drivers/phy/qualcomm/phy-qcom-sgmii-eth.c:qcom_dwmac_sgmii_phy_calibrate()
	case PHY_INTERFACE_MODE_SGMII:
	case PHY_INTERFACE_MODE_1000BASEX:
		/* 1.25Gbps mode */
		qcom_dwmac_sgmii_phy_init_1g(data->regmap);
		break;
	case PHY_INTERFACE_MODE_2500BASEX:
		/* 3.125Gbps mode */
		qcom_dwmac_sgmii_phy_init_2p5g(data->regmap);

So if 1000BASE-X is selected after a 2500BASE-X link, the QSERDES stays at
3.125 Gb/s while the integrated PCS runs 1000BASE-X at 1.25 Gb/s, and
ethqos_mac_finish_serdes() still returns 0, so nothing reports an error.

One way to reach that selection is an optical 1000BASE-X SFP module, since
phylink intersects the module's interfaces with the config bitmap:

drivers/net/phy/phylink.c:phylink_sfp_config_optical()
	phy_interface_and(pl->sfp_interfaces, pl->config->supported_interfaces,
			  pl->sfp_interfaces);

Previously such a module was rejected with "unsupported SFP module: no
common interface modes".

I could not find an in-tree PHY driver that exports 1000BASEX in
possible_interfaces, nor a qcom arm64 DT that pairs ethqos with an sfp
node, so this may not be reachable with in-tree configurations today.  Is
an ethqos board DT with an SFP cage expected to work here, and if so should
ethqos_mac_finish_serdes() also handle PHY_INTERFACE_MODE_1000BASEX (or
should the interface be masked out for platforms that can't program it)?

>  	/* If we have an xpcs, it defines which PHY interfaces are supported. */
>  	if (priv->hw->xpcs)
>  		pcs = xpcs_to_phylink_pcs(priv->hw->xpcs);

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/SJ2PR11MB8401F5C3A075DE2A0013E063E4872%40SJ2PR11MB8401.namprd11.prod.outlook.com
