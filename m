Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93914314A65;
	Tue, 15 Sep 2026 09:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789465644; cv=none; b=j4D+hB+0HuBD8P9zMUL1WatXKnm/T4dRpN9+l+v3kYa6w7IOPsvTUlqys/R/hXE6ycWWvKbqSjvlGLzgy7LL0wiOXTYIUWvqnOS9Is5wH6PFnh7EvBGJr0eOsZATLSTGYNPcWrgeEhhXbv7OPz7/0MyiHh/R5VCvQzOqvUtg8oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789465644; c=relaxed/simple;
	bh=/kuZIJKnsytx4FqD3eBz3HWjO93XOyJjcVq9h7/CvSE=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=uiUYIusy2z/6PdKiZo2gRlTqjD7DMbnaWquN86bd/Y9zwWhegtdVYxvs9gxgHG9AJILoaacel6HD2sEUim4XFaJx/nuAVyDTisTsVqXmObaShph64DGQmRJ8lYomQEXuzsr+0Npq1uQqWmUi4/nWv3rJdzKvUOPODNzjy1Yl21Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GMa0ym2m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GMa0ym2m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F68F1F000FF;
	Tue, 15 Sep 2026 09:47:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789465643;
	bh=yVmLO1UYGkx18xnxGFa0+LCVtikSySUatIbQx6T/PzY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=GMa0ym2mM1D+E4+ci5FioPgbcRLnrZDb2o8B4lhoi53VLJ74eLOlHuywT8ww2Lhvw
	 3dQqJid17LClhpCFyO26TQY1rNh166eQhFTSg3joPw8gcjSmEq0Wg3+WSn+5Gvh91v
	 hR51H0nJFliEkZo9BIbdj+dyDZqtus4zroITYuzUSK9ZuLdAdI1YintS7I8BYEG9oy
	 CltaEh3D0kQhBaUcjQzZBLlh4b78hC741zA/NU3r0aCvpTiEA+sHgSxinqCnnTi2SZ
	 YTh9nZFBx8GrbKQ4W8UzV6MVuEuB0zOJcZPCtrbR5ypDVyRnr7nWu2pGeUWVrKsryU
	 eBYeHZTgKboFw==
Subject:
 Re: [PATCH net-next] net: phy: broadcom: enable jumbo frames on BCM54xx
From: netdev-bot+sashiko@kernel.org
To: nb@tipi-net.de
Cc: florian.fainelli@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 justin.chen@broadcom.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Tue, 15 Sep 2026 09:47:22 +0000
Message-ID: <178946564204.22033.11365695579281446109@kernel.org>
In-Reply-To: <20260914094703.1093504-1-nb@tipi-net.de>
References: <20260914094703.1093504-1-nb@tipi-net.de>
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
issue(s) to consider:

Critical: 0 · High: 0 · Medium: 1 · Low: 0

- [Medium] The new unconditional bcm_phy_enable_jumbo() call in
  bcm54xx_config_init() (drivers/net/phy/broadcom.c:543) sets…

--

net: phy: broadcom: enable jumbo frames on BCM54xx

This adds an unconditional bcm_phy_enable_jumbo() call to
bcm54xx_config_init(), which sets the extended packet length bit in the
auxiliary control register and the PCS transmit FIFO elasticity bit in the
extended control register so that jumbo frames are not dropped at 100M.

> diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
> index d1a4edb34ad2e..b515e38755041 100644
> --- a/drivers/net/phy/broadcom.c
> +++ b/drivers/net/phy/broadcom.c
> @@ -537,6 +537,13 @@ static int bcm54xx_config_init(struct phy_device *phydev)
>  
>  	bcm54xx_ptp_config_init(phydev);
>  
> +	/* Transmit is limited to 4.5 KB without it, see the BCM54210PE
> +	 * datasheet section 5.4.12.14.
> +	 */
> +	err = bcm_phy_enable_jumbo(phydev);
> +	if (err < 0)
> +		return err;
> +

[Severity: Medium]
This lands directly after bcm54xx_ptp_config_init() has armed the
TimeSync block on PTP-capable parts such as the BCM54210E, whose driver
entry in broadcom_drivers uses this same .config_init.  How does the added
elastic FIFO delay interact with the PHY timestamping path?

bcm_phy_enable_jumbo() in drivers/net/phy/bcm-phy-lib.c ends with:

	/* Enable the elastic FIFO for raising the transmission limit from
	 * 4.5KB to 10KB, at the expense of an additional 16 ns in propagation
	 * latency.
	 */
	return phy_set_bits(phydev, MII_BCM54XX_ECR, MII_BCM54XX_ECR_FIFOE);

If that FIFO sits in the copper PCS transmit path downstream of the 1588
egress capture point, would egress timestamps then be reported
systematically early by that fixed delay?  A link where only one end has
MII_BCM54XX_ECR_FIFOE set would also become asymmetric.

Grepping drivers/net/phy/bcm-phy-ptp.c for latency or compensat returns no
matches, so there appears to be no TX/RX latency correction programmed
anywhere in the PHY PTP driver that could absorb the new delay.

There is also no gating here: no MTU or jumbo condition, no device tree
property and no ethtool knob, and the bit is re-armed on every
config_init() and via bcm54xx_resume().  tg3 sets the same hardware bit
only when tg3_flag(tp, JUMBO_CAPABLE) is set.

Would it make sense to gate the FIFO elasticity bit on an actual
jumbo/large-MTU requirement, or to account for the extra delay in the PTP
path?

>  	/* Acknowledge any left over interrupt and charge the device for
>  	 * wake-up.
>  	 */

Also, the changelog says the elasticity bit raises the transmit limit
"from 4.5 KB to 9 KB", while the in-tree comment on the same register
write in bcm_phy_enable_jumbo() says 4.5KB to 10KB.  Which figure is
intended, and could the two be reconciled?

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260914094703.1093504-1-nb%40tipi-net.de
