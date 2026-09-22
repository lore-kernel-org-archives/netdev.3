Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B71738DC7E;
	Tue, 22 Sep 2026 05:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790053555; cv=none; b=mfteHxss2q7xlQcuTgAN67PwWK6fnUlskXDMLZUP4HJwjMyCBGtLpFmkTE/gKx7GjRnngNZ4arwS+oP1vl0wbUnkIivA6ej6qzJAjzyNpEKjLWL+n6jYhZAa+39fwUAJMvc452TPXDbaGa7Sn4v2O87QZ9KzSWL4mUvyhFueH2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790053555; c=relaxed/simple;
	bh=OEJqIOjJkXySBGYpqCANlBQbWBN+cWrJyD5tncHzBR0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HwGf4uBwB8Z/wZSf4ny8/oAwSIHu6GHG3+IWiM018kZUXkLDcuiRLc2fZ9c29wKKIFhY42LgtGh14Hd4tJbvChqytPt/oe3yBbjH6L1CI8bMPh0vIb1ualikqwj+8l+4wYs5hmtAmTEOfxRL1Cj1D/zxoqRQFvpm3xocxTFuw9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YcT/qu6s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YcT/qu6s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2201B1F000FF;
	Tue, 22 Sep 2026 05:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790053554;
	bh=6kQbiD1Lcj2OWY/76m82GwPbkC5l7XKW4gKK4kfOBnY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=YcT/qu6sl+JMXk1R4lstVDIs3tHiwLFBrWGn5UYrktqxptGWL0IIJOMYY8rdgNM0l
	 SU3YGWMifg5l1/Qt7f9y71UTNocq7w1SHYz4xVE3M1tPmbzIBFrBW/xDr9HqOtVyk9
	 DdCAp39crKTJ5oK/LvTKxQESWx3ORivyqFFnoJzAh2sHnt+1YY33pU44RtBmx+zEZi
	 9/JxOsIx0ZgL0kwoDwlHp1oA5bCKH9V2bd3CIVy73eRjFNsrWc4JNgrLpKhLbty3HP
	 8U+BrTgri6PpHjemyobkJEYDJzsHArSUWXwqy0F9Q2dHs7HPSz/IrjSDkcQHivrhr0
	 BDaB5GKzNVKFg==
Subject: Re: [PATCH net v2 3/3] net: stmmac: qcom-ethqos: enable 2500BASE-X in
 integrated PCS
From: netdev-bot+sashiko@kernel.org
To: tom.karpiniec@outlook.com
Cc: netdev@vger.kernel.org, mohd.anwar@oss.qualcomm.com,
 maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, linux@armlinux.org.uk, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 yong.liang.choong@linux.intel.com, brgl@kernel.org, coiaprant@gmail.com,
 linux-arm-msm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 22 Sep 2026 05:05:52 +0000
Message-ID: <179005355270.2160803.6905383715293377235@kernel.org>
In-Reply-To: =?utf-8?q?=3CSJ2PR11MB84018DBB1F18F07D79DBC5E3E4872=40SJ2PR11MB?=
 =?utf-8?q?8401=2Enamprd11=2Eprod=2Eoutlook=2Ecom=3E?=
References: =?utf-8?q?=3CSJ2PR11MB84018DBB1F18F07D79DBC5E3E4872=40SJ2PR11MB8?=
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

- [Medium] Misattributed Fixes: tag and inconsistent stable range.
- [Medium] Setting STMMAC_FLAG_SERDES_SUPPORTS_2500M makes
  stmmac_mac_select_pcs() (stmmac_main.c:1031-1033) return the dwmac…

--

net: stmmac: qcom-ethqos: enable 2500BASE-X in integrated PCS

This sets STMMAC_FLAG_SERDES_SUPPORTS_2500M in qcom_ethqos_probe() when the
optional SerDes phy is present, so that stmmac_integrated_pcs_init() adds
PHY_INTERFACE_MODE_2500BASEX to the integrated PCS supported_interfaces
bitmap.

A couple of questions about this one.

> Fixes: 61e9be0efbe8 ("net: stmmac: qcom-ethqos: add support for 2.5G BASEX mode")
> Cc: stable@vger.kernel.org # 7.0+

[Severity: Medium]
Is this the right commit to blame?  The behaviour being corrected is the
flag gate in stmmac_integrated_pcs_init():

drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c:stmmac_integrated_pcs_init() {
	...
	/* Only allow 2500BASE-X if the SerDes has support. */
	if (priv->plat->flags & STMMAC_FLAG_SERDES_SUPPORTS_2500M)
		__set_bit(PHY_INTERFACE_MODE_2500BASEX,
			  spcs->pcs.supported_interfaces);
	...
}

git show 61e9be0efbe8 only touches dwmac-qcom-ethqos.c (it adds
qcom_ethqos_speed_mode_2500() and the PHY_INTERFACE_MODE_2500BASEX switch
case); it does not touch stmmac_pcs.c or include/linux/stmmac.h.

git blame points both the gate above and the

	#define STMMAC_FLAG_SERDES_SUPPORTS_2500M	BIT(16)

definition in include/linux/stmmac.h at 68cff4fff61f ("net: stmmac: add
BASE-X support to integrated PCS"), which is also where the flag first
appeared, and no in-tree platform ever set it.  Should the Fixes tag name
68cff4fff61f instead?

There is also a mismatch between the two tags: 61e9be0efbe8 shipped in
v6.11, so the Fixes tag nominates trees that predate the code being fixed,
while the Cc annotation says 7.0+.  Which range is intended?

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index ac7d6d3e205a..0e07225a70ca 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -786,6 +786,7 @@ static int qcom_ethqos_probe(struct platform_device *pdev)
>  		plat_dat->host_dma_width = data->dma_addr_width;
>  
>  	if (ethqos->serdes_phy) {
> +		plat_dat->flags |= STMMAC_FLAG_SERDES_SUPPORTS_2500M;

[Severity: Medium]
Does setting this flag leave auto-negotiation enabled for 2500BASE-X on
ethqos?

With 2500BASEX now in the integrated PCS supported_interfaces,
stmmac_mac_select_pcs() starts returning the integrated PCS for that
interface instead of NULL (ethqos installs no plat->select_pcs):

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:stmmac_mac_select_pcs() {
	...
	if (priv->integrated_pcs &&
	    test_bit(interface, priv->integrated_pcs->pcs.supported_interfaces))
		return &priv->integrated_pcs->pcs;
	...
}

That newly routes ethqos through dwmac_integrated_pcs_config():

drivers/net/ethernet/stmicro/stmmac/stmmac_pcs.c:dwmac_integrated_pcs_config() {
	bool changed = false, ane = true;

	/* Only configure the advertisement and allow AN in BASE-X mode if
	 * the core supports TBI/RTBI. ...
	 */
	if (phy_interface_mode_is_8023z(interface) &&
	    spcs->support_tbi_rtbi) {
		ane = neg_mode == PHYLINK_PCS_NEG_INBAND_ENABLED;
	...
	dwmac_ctrl_ane(spcs->base, 0, ane,
		       spcs->priv->hw->reverse_sgmii_enable);
}

ethqos is the non-TBI case, per the comment in
stmmac_integrated_pcs_init():

	/* If the PCS supports extended status, then it supports BASE-X AN
	 * with a TBI interface to the SerDes. Otherwise, we can support
	 * BASE-X without AN using SGMII, which is required for qcom-ethqos.
	 */

So support_tbi_rtbi is false, the branch is skipped, ane stays true, and
dwmac_ctrl_ane() programs GMAC_AN_CTRL_ANE|GMAC_AN_CTRL_RAN even though
dwmac_integrated_pcs_inband_caps() reported only LINK_INBAND_DISABLE for
802.3z on this core and phylink therefore passed an out-of-band neg_mode.

That also leaves two layers writing GMAC_AN_CTRL in opposite directions:
pcs_config() sets ANE, while the glue clears it later at link up:

drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c:ethqos_fix_mac_speed_sgmii() {
	...
	ethqos_pcs_set_inband(ethqos, interface == PHY_INTERFACE_MODE_SGMII);
	...
}

Is correctness then dependent on a mac_link_up() always following
pcs_config()?  If the interface is configured while the PHY link is down,
or on a repeated major_config without a link-up, the PCS looks like it is
left with AN enabled and restarted on a 2500BASE-X link whose SerDes does
no AN.

Should the ane initialisation in dwmac_integrated_pcs_config() be fixed
first, and should the now-redundant ethqos_pcs_set_inband() write be
mentioned in the commit message?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/SJ2PR11MB8401F5C3A075DE2A0013E063E4872%40SJ2PR11MB8401.namprd11.prod.outlook.com
