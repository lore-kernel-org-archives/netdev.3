Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633243C342F;
	Wed,  9 Sep 2026 21:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788990447; cv=none; b=mup5dUVfuRyqatX7hwk1BuK7lx6m8qkH1WZAki5Fr693q4oh3pjqZ1Re5Os7mjjFskazMRcmbzO7cDgQjl5/ILMWV8sDRyFTECwzcQVu+luVJpDS9awVVPeuSFGNMp4Fest82sORw+3vYun52rGMSKdlNc3Sra3sx+albY3f5y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788990447; c=relaxed/simple;
	bh=mjyQtZIA9XPJzKLE5FVNxgxaO/EKN/KvK9MIZ1qVMmg=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D9Qj/rt0B96sC3ZqQaY6+UG72eNIjYUXuby+72gSM+mfF7mtCWDFqxelrW25+Nc49UPsXOBeeo3cCOJCzGfM+9opzMQVunyqYsJrnQP+TiD8T9mkIfbR326XAJphTbfzoHAmP3YhVedDnaJOO2c89+wq1hPq0MD7wV1nchTY/OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAfLYe8b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAfLYe8b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87AE01F0089C;
	Wed,  9 Sep 2026 21:47:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788990434;
	bh=u51wIMseDkxpNxShtMSfkG0JWTpwrhqNHA6Dm1oZaNs=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lAfLYe8b5+GZyzAOdsogQyUui5DYNZtHMauM++5n5SYZIvnjSvFlrPgCAk8DWRAtC
	 kgmeghX6HGJXg1S6C41pAGl5nq02nykLw1QpAdh3UjcTN73X3hiSQUr57Otm/c5Yr+
	 a7Ujx/KqjQzU40XFi6d9znR7UE1/v1yCYRSXCKT/CZNYiE7Y0bG8NdaKVVPlts8L0P
	 ljtbA3hIo8lLhyHr0YIMf+5Q2wKRG13oFMzfxTuW8sz6w2r1JPfUtZQ5d8UerpI7PI
	 OTUmIe/KZXtRwMLAM/+tWbiYbPpRid7NQyZlp0LqiBq5yqB4FbYI99n/WhadzHPvyD
	 WKAkq9qJW9knA==
Subject: Re: [PATCH net-next 6/9] net: stmmac: qcom-ethqos: warn about legacy
 RGMII PHY modes
From: netdev-bot+sashiko@kernel.org
To: mohd.anwar@oss.qualcomm.com
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, afd@ti.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, richardcochran@gmail.com, andersson@kernel.org,
 konradybcio@kernel.org, alexandre.torgue@foss.st.com, peppe.cavallaro@st.com,
 joabreu@synopsys.com, maxime.chevallier@bootlin.com,
 mcoquelin.stm32@gmail.com, netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org
Date: Wed, 09 Sep 2026 21:47:12 +0000
Message-ID: <178899043209.219967.1138402258618527467@kernel.org>
In-Reply-To: <20260904-shikra_ethernet-v1-6-a50765996035@oss.qualcomm.com>
References: <20260904-shikra_ethernet-v1-6-a50765996035@oss.qualcomm.com>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 2 · Low: 0

- [Medium] Unbounded log spam: the new dev_warn("legacy RGMII phy-mode
  detected; consider upgrading to a newer DTB") is placed in the body of…
- [Medium] The warning fires for a PHY mode the commit message never
  mentions.

--

net: stmmac: qcom-ethqos: warn about legacy RGMII PHY modes

This adds a dev_warn() in ethqos_fix_mac_speed_rgmii() for the RGMII
configuration paths that are not rgmii-id, to encourage migration to
DTBs using "rgmii-id" with PHY-provided delays.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index 67738c1598c50..2ca2f03de3017 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -554,6 +554,8 @@ static void ethqos_fix_mac_speed_rgmii(void *bsp_priv,
>  		return;
>  	}
>  
> +	dev_warn(dev, "legacy RGMII phy-mode detected; consider upgrading to a newer DTB\n");

[Severity: Medium]
Can this print repeat without bound?  ethqos_fix_mac_speed_rgmii() is
installed as plat_dat->fix_mac_speed in qcom_ethqos_probe():

  ethqos->phy_mode = plat_dat->phy_interface;
  switch (ethqos->phy_mode) {
  case PHY_INTERFACE_MODE_RGMII:
  case PHY_INTERFACE_MODE_RGMII_ID:
  case PHY_INTERFACE_MODE_RGMII_RXID:
  case PHY_INTERFACE_MODE_RGMII_TXID:
          plat_dat->fix_mac_speed = ethqos_fix_mac_speed_rgmii;

and stmmac_mac_link_up() calls it on every resolved link:

  if (priv->plat->fix_mac_speed)
          priv->plat->fix_mac_speed(priv->plat->bsp_priv, interface,
                                    speed, mode);

The only early return before the new print is the
phy_mode == PHY_INTERFACE_MODE_RGMII_ID branch, so for the other RGMII
modes every link-up, cable re-plug, link flap, autoneg speed change,
ifdown/ifup and resume emits another identical warning.  The condition
being reported is the static DT phy-mode, which is already known at probe
time and does not change afterwards.

Would dev_warn_once(), or a single check in qcom_ethqos_probe() where the
phy_mode switch already exists, be preferable here?  dev_warn_ratelimited()
would at least bound the output.

[Severity: Medium]
The commit message says:

  "However, existing DTBs use "rgmii" and "rgmii-txid" and must remain
   supported for backwards compatibility."

  "Warn when either of these legacy PHY modes is used [...]"

but the code warns for anything reaching ethqos_fix_mac_speed_rgmii()
that is not PHY_INTERFACE_MODE_RGMII_ID, which also covers
PHY_INTERFACE_MODE_RGMII_RXID, dispatched to this callback by the switch
in qcom_ethqos_probe().

Documentation/devicetree/bindings/net/ethernet-controller.yaml lists
rgmii-rxid as the correct description when the TX delay is provided by the
PCB:

      # TX delay is provided by the PCB. See below
      - rgmii-rxid

So a board that legitimately describes itself as rgmii-rxid is now told to
move to "rgmii-id", which would misdescribe the hardware.

Should the condition be narrowed to the two modes named in the commit
message, or should the commit message explain why rgmii-rxid is deprecated
too?

>  	/* Initialize the DLL first */
>  
>  	/* Set DLL_RST */

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260904-shikra_ethernet-v1-0-a50765996035%40oss.qualcomm.com
