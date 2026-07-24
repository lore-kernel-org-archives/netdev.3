Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0B23386C25;
	Fri, 24 Jul 2026 22:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784933172; cv=none; b=S3I7xYQQw3oYoHDgGfsoWKnZFart3M+eXQC5We9Yb3dTypOOxqsTkps9N03P9flLgsr1C0JCp1wevXCfB6AjZ/dWVou0fk9yod3IZRztKRBcbhIx7puIupzdDUPj3uUi91WJW88+lX+ulD6FffoQmXycHqi6ej1BwmO34ColuRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784933172; c=relaxed/simple;
	bh=WjhVTXFgF5u0VjHDqknZctyWx108wRn4GObXi35dOUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XiDP8pk7g5WQe4Um0p89Btw6IEIw7PYO+m9o/mvlHM1ihEsspcKTxLd7ylHCfhglGxLR5ecZLuZAZmB54Hr/gsT7mLnsB8OiabEEV321FTuXsZpY/Ak/Ian2tecWEClLUGH1qFDayH1/+Dasrsv0pcZPnmq8QyeDIzcsZE/rGME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bX9Zr4D/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bX9Zr4D/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35881F00A3A;
	Fri, 24 Jul 2026 22:46:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784933162;
	bh=NMNOc/In+fWMgaFH9Omi735YDJBG/gXGBfILoP1ztBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bX9Zr4D/LezvZIgMRUL1/Y6JZMzid0uz4HB42PhG9lZ+PJcEN99y4/pWQYi1vYEGG
	 7m5MkBADwk+RPybApZ8J2wjXuNVd1nDRkdybcPI8tchX21wCu1VuExWAULiBRosMC7
	 1dcMWc7XyYLftbkZw/D9sTa07UbX7rQR9hD0AVOyVcB2CNbdYw4DQsFF80yeqS8ZTY
	 WhS3qzoX2on/sRmaOR/TO8jot7UJPz1fmqtxzvWbRYPcPnKCAHzFgrJ9e99DQmS7BU
	 +0HCuf4xYtLNSlfZLry2sHbBTZcWk0h64W5cOSNw4jpzRn1IUFBJO51R0wSrUGpcHs
	 bVg7A6UxVK9og==
From: Jakub Kicinski <kuba@kernel.org>
To: bartosz.golaszewski@oss.qualcomm.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	andersson@kernel.org,
	konradybcio@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	vkoul@kernel.org,
	peppe.cavallaro@st.com,
	wens@kernel.org,
	jernej.skrabec@gmail.com,
	neil.armstrong@linaro.org,
	khilman@baylibre.com,
	jbrunet@baylibre.com,
	shawnguo@kernel.org,
	festevam@gmail.com,
	jan.petrous@oss.nxp.com,
	s32@nxp.com,
	mohd.anwar@oss.qualcomm.com,
	romain.gantois@bootlin.com,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mripard@kernel.org,
	christophe.roullier@foss.st.com,
	brgl@kernel.org,
	radu@rendec.net,
	linux-arm-msm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	dfustini@tenstorrent.com,
	linux-sunxi@lists.linux.dev,
	linux-amlogic@lists.infradead.org,
	linux-mips@vger.kernel.org,
	imx@lists.linux.dev,
	linux-renesas-soc@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	sophgo@lists.linux.dev,
	linux-riscv@lists.infradead.org,
	bartosz.golaszewski@linaro.org
Subject: Re: [PATCH net-next v13 06/10] net: stmmac: qcom-ethqos: update phy_mode to the resolved interface in mac_finish()
Date: Fri, 24 Jul 2026 15:45:59 -0700
Message-ID: <20260724224559.1649383-1-kuba@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260713-qcom-sa8255p-emac-v13-6-119f8699ef8e@oss.qualcomm.com>
References: <20260713-qcom-sa8255p-emac-v13-6-119f8699ef8e@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
net: stmmac: qcom-ethqos: update phy_mode to the resolved interface in mac_finish()

This patch updates ethqos->phy_mode from the interface argument in
ethqos_mac_finish_serdes() so that it always reflects the last resolved
interface, avoiding a stale value being observed by later
serdes_powerup()/serdes_powerdown() calls when the runtime interface
differs from the DT phy-mode.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index 47b70b5e706f..9d19203ae4bd 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -632,6 +632,12 @@ static int ethqos_mac_finish_serdes(struct net_device *ndev, void *priv,
>  	struct qcom_ethqos *ethqos = priv;
>  	int ret = 0;
>  
> +	/* The interface mode is only known once phylink has resolved it and
> +	 * may change at runtime, so keep it in sync for later
> +	 * serdes_powerup()/serdes_powerdown() calls.
> +	 */
> +	ethqos->phy_mode = interface;
> +
>  	qcom_ethqos_set_sgmii_loopback(ethqos, false);

[High]
Is the ordering here safe with respect to qcom_ethqos_set_sgmii_loopback()?

That helper early-returns unless ethqos->phy_mode equals
PHY_INTERFACE_MODE_2500BASEX:

    static void
    qcom_ethqos_set_sgmii_loopback(struct qcom_ethqos *ethqos, bool enable)
    {
            if (!ethqos->needs_sgmii_loopback ||
                ethqos->phy_mode != PHY_INTERFACE_MODE_2500BASEX)
                    return;
            ...
    }

Because ethqos->phy_mode is now overwritten with the freshly resolved
interface before the qcom_ethqos_set_sgmii_loopback(ethqos, false) call,
does that clear-side path still fire when the interface transitions away
from 2500BASE-X?

Consider a needs_sgmii_loopback platform (for example sa8775p) with a DT
phy-mode of 2500BASE-X. At probe time ethqos_clks_config(true) asserts
SGMII_PHY_CNTRL1_SGMII_TX_TO_RX_LOOPBACK_EN in the wrapper while
ethqos->phy_mode is still the DT value 2500BASE-X. If phylink later
resolves the interface to SGMII and calls ethqos_mac_finish_serdes():

    ethqos->phy_mode = interface;                   /* now SGMII */
    qcom_ethqos_set_sgmii_loopback(ethqos, false);  /* early-return */

Does the port then enter SGMII operation with the wrapper TX-to-RX
loopback bit still asserted, which is the exact 2500BASE-X to SGMII
runtime-transition scenario the commit message says it wants to make
work?

Would calling qcom_ethqos_set_sgmii_loopback(ethqos, false) first,
against the old phy_mode, and only then assigning
ethqos->phy_mode = interface avoid this?

The commit message describes the change only in terms of
serdes_powerup()/serdes_powerdown():

    ethqos->phy_mode is read by serdes_powerup() and
    qcom_ethqos_set_sgmii_loopback() to configure the SerDes and its
    wrapper for the correct interface.
    ...
    Update ethqos->phy_mode from the interface argument in
    ethqos_mac_finish_serdes() so that it always reflects the last
    resolved interface.

Should it also mention that the assignment changes what the immediately
following qcom_ethqos_set_sgmii_loopback(ethqos, false) observes?

For reference, this appears to be addressed later in the same series by
commit 8d1efdf990fc ("net: stmmac: qcom-ethqos: fix SGMII loopback not
set on resume after speed change"), which extends the guard in
qcom_ethqos_set_sgmii_loopback() to also match PHY_INTERFACE_MODE_SGMII.
That follow-up commit message frames the fix as a set-side DMA-reset
timeout on resume, but does the same guard change also happen to unbreak
the clear-side path introduced here? If so, would it be worth either
reordering the two statements in this patch or folding the guard update
in ahead of this one to avoid a bisect window where the SGMII wrapper
loopback stays asserted after a 2500BASE-X to SGMII transition?

>  
>  	if (interface == PHY_INTERFACE_MODE_SGMII ||

[ ... ]
