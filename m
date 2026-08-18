Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C42213790B;
	Tue, 18 Aug 2026 18:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787078589; cv=none; b=iA0ZH7BCgP8+Rs76JxV1af9qG4/sAUu1caG2ONLNTjtPjNyBYkPRVWaGUS8Ou5/kDA0tPfm5d0o79NNfdeoDSj2t2zKP/6BYGR/V19bBpRzQTKnjdkTr2t0Tw11dZVGVz+nVHQD1vcWJArPvXA8PMkq3860fgqN+hlRrVKigtMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787078589; c=relaxed/simple;
	bh=2oJbXCJU7xBE3cRUgmw45SWiGpKK8O3+O0mMqnrVlRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CqnbxtyzJcHinNUb84v+SvydUEgb/aoVgyN7viDnumZUfOqIOhAUdFZ51InPhvOKxJ4T1DcRKAHOfP7uizYgJtqdEw9dNED3zYeibTrkiGzNBQg+sseMfzbkXeaRDPrt8L4a84THTIJHg+sEh3RM90xUvsMZlJjEoGy2TDgdzB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.99)
	(envelope-from <daniel@makrotopia.org>)
	id 1wwOlx-00000000050-4B4P;
	Tue, 18 Aug 2026 18:42:54 +0000
Date: Tue, 18 Aug 2026 19:42:50 +0100
From: Daniel Golle <daniel@makrotopia.org>
To: Vladislav Karmanov <vladislav.karmanov.dev@gmail.com>
Cc: netdev@vger.kernel.org, chester.a.unal@arinc9.com, dqfext@gmail.com,
	sean.wang@mediatek.com, andrew@lunn.ch, olteanv@gmail.com,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, yangshiji66@outlook.com
Subject: Re: [PATCH net] net: dsa: mt7530: do not advertise EEE on MT7621
 switch
Message-ID: <aoSnqurLLgdVT_Eu@makrotopia.org>
References: <20260818182829.1580811-1-vladislav.karmanov.dev@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260818182829.1580811-1-vladislav.karmanov.dev@gmail.com>

Hi,

On Tue, Aug 18, 2026 at 09:28:29PM +0300, Vladislav Karmanov wrote:
> There are hardware defects in the MT7621 (MT7530) EEE support: with EEE
> advertised, some link partners cannot establish a stable connection.
> Notably, on a 2-pair (4-wire) cable where both ends advertise gigabit,
> 1000BASE-T training cannot succeed, and instead of falling back to
> 100 Mbps the port flaps in a loop and no link/DHCP lease is obtained.
> This is confined to the WAN / phylib bring-up path; the DSA/LAN side on
> the same device is unaffected.
> 
> The MT7530 internal GE PHY advertises EEE by hardware default. The
> eee-broken-100tx / eee-broken-1000t device-tree properties only take
> effect during the late PHY config_init path, which is too late for these
> link partners: they negotiate EEE before the OS disables it and then
> fail to fall back cleanly.
> 
> Commit af3b4b0e59de ("net: phy: mediatek-ge: do not disable EEE
> advertisement") removed the early EEE-advertisement disable from
> mtk_gephy_config_init(), on the rationale that "disabling EEE
> advertisement before the PHY driver initialises keeps it off", i.e. that
> the DSA subdriver already performs that early disable. That rationale
> holds for MT7531, whose mt7531_setup() clears MDIO_AN_EEE_ADV on each
> switch PHY -- but it does not hold for MT7621, whose mt7530_setup()
> never had such a loop. So af3b4b0e59de removed the only early EEE
> disable that covered MT7621, reintroducing the flapping on MT7621-based
> boards (regression reported on ramips/mt7621).
> 
> MediaTek's own recommendation (Landen Chao, 2021) confirms the hardware
> is the root cause: "EEE of the 10-year-old MT7530 internal gephy has many
> IOT problems, so it is recommended to disable its EEE."
> [...]
> --- a/drivers/net/dsa/mt7530.c
> +++ b/drivers/net/dsa/mt7530.c
> @@ -2518,6 +2518,15 @@
>  	if ((val & MT7530_XTAL_MASK) == MT7530_XTAL_40MHZ)
>  		mt7530_pll_setup(priv);
>  
> +	if (priv->id == ID_MT7621) {

It'd be very surprising if this limitation doesn't also apply for the
nearly identical decicated MT7530 IC (found eg. on BananaPi R2).

I'd recommend disabling EEE advertisement on MT7621 and MT7530; and I
suspect that some of the older Trendnet/Econet SoCs which share common
linage with the MediaTek's Ethernet switch and PHY designs could also
be affected.

Hence I'd suggest to extend 'struct mt753x_info' with a 'broken_eee'
bool instead of maintining an in-code list of EEE-broken silicon IDs.

> +		/* Disable EEE advertisement on the switch PHYs. */
> +		for (i = MT753X_CTRL_PHY_ADDR(priv->mdiodev->addr);
> +		     i < MT753X_CTRL_PHY_ADDR(priv->mdiodev->addr) + MT7530_NUM_PHYS;
> +		     i++) {
> +			mt7530_phy_write_c45(priv, i, MDIO_MMD_AN, MDIO_AN_EEE_ADV, 0);
> +		}
> +	}
> +

