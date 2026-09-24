Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66C3313534;
	Thu, 24 Sep 2026 02:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790216866; cv=none; b=BvOKNz+fCPh9tK+GiK2nyOEzjdVZafoXicQ8Zy101RMOTepd1PCHoXtrbm5AaWs6glE4F10wW/YjLZ5cyMOu/odk6jl22T+CWTcIGuWU/5IS/Mi6UmLO78JC17rKcGFdogIWhAIGQ2mi1ATZjzyRmOBrUqAml9pqVmaRSi2BlEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790216866; c=relaxed/simple;
	bh=hsuXllKvImQEzRfzGy1c1wYRlNuqbsjrtmwuFSuIVWQ=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zz84FQbDI8J/wFLod5BqUT6Tgr61M98haB35Q09+K+aUpHLAu001tUrik1v/k4w6et1aihX/pIPLlZvq09ihQlVgYbLj73k9ml+uZWG64yRCgLAipATS4UHnx/ECIH166c6TxI+q4HHrd8yhZ3omTC5gXVrWxKqtnnqKdwPSQPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hqxpJsrt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hqxpJsrt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAB441F000FF;
	Thu, 24 Sep 2026 02:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790216865;
	bh=jdvXpwdRjUiK72rN48SRFhz2V6UO/PayiAohFZTENl8=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=hqxpJsrts5tIuGDScjhABTrVXhCp+Tl+7+3J4tu2vqwwtGnfu3XPekjkz8kO5f4xQ
	 HdtA13/9wYpxusy8FxgbaYfAn3w78XYIl711UteRFmysvLxe3WoT4GkLUPaOzk0VDj
	 3q19JtSVd0S/JBDanBZHodXgTJ97Jc8KggmGy+ZN6FT7JLidk/RsPbkd81vaxvZvZs
	 KJQIRqxrPZjcj9c9OmcVVfTNZl/h6lFvCqHycoggmyACVkiQoMMg+3t4ioUOaqQ5hv
	 55JmujW7wxo+EqY+8ddsuLXNJqbjYtJpDtbp0B7jbJYYaEGNaviEAsEJFCF1VG1LlX
	 gMSZZacxHowmQ==
Subject: Re: [PATCH] net: phy: mxl-gpy: add 2.5G for MXL68211C
From: netdev-bot+sashiko@kernel.org
To: rouven.czerwinski@linaro.org
Cc: lxu@maxlinear.com, andrew@lunn.ch, hkallweit1@gmail.com,
 linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, daniel@makrotopia.org,
 maxime.chevallier@bootlin.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Date: Thu, 24 Sep 2026 02:27:44 +0000
Message-ID: <179021686449.2160803.8908232708246171616@kernel.org>
In-Reply-To: <20260922-mainline-rouven-mxl2g5-v1-1-a0ed53631a5f@linaro.org>
References: <20260922-mainline-rouven-mxl2g5-v1-1-a0ed53631a5f@linaro.org>
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

Critical: 0 · High: 0 · Medium: 1 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [Medium] Missing `Fixes:` tag — a user-visible bug fix is submitted as
  a net-next feature.
- [Low] Commit message names the wrong part number: the subject ("net:
  phy: mxl-gpy: add 2.5G for MXL68211C") and the body sentence ("the…

--

net: phy: mxl-gpy: add 2.5G for MXL68211C

This switches the MxL86211C phy_driver entry from gpy_config_init() to
gpy21x_config_init(), so that PHY_INTERFACE_MODE_2500BASEX and
PHY_INTERFACE_MODE_SGMII get advertised in phydev->possible_interfaces.
The changelog reports that 2.5G then negotiates against a Mikrotik
CRS310-G+2S+IN.

> net: phy: mxl-gpy: add 2.5G for MXL68211C

[Severity: Low]
The subject says "MXL68211C", and the body repeats it in "the 2.5G speed
indication is the same between GPY211 & MXL68211C", while the first body
sentence and the code use MXL86211C.

The driver only knows the latter spelling:

drivers/net/phy/mxl-gpy.c:
	#define PHY_ID_MXL86211C	0xC1335400
	...
		.name		= "Maxlinear Ethernet MxL86211C",

Could the digits be un-transposed in the subject and in that sentence on a
resend?

> diff --git a/drivers/net/phy/mxl-gpy.c b/drivers/net/phy/mxl-gpy.c
> index 0da2d4e9d8548..089a1a9e5bc61 100644
> --- a/drivers/net/phy/mxl-gpy.c
> +++ b/drivers/net/phy/mxl-gpy.c
> @@ -1405,7 +1405,7 @@ static struct phy_driver gpy_drivers[] = {
>  		PHY_ID_MATCH_MODEL(PHY_ID_MXL86211C),
>  		.name		= "Maxlinear Ethernet MxL86211C",
>  		.get_features	= genphy_c45_pma_read_abilities,
> -		.config_init	= gpy_config_init,
> +		.config_init	= gpy21x_config_init,

[Severity: Medium]
Should this carry a Fixes: tag rather than going in as a feature?

The only functional delta is the possible_interfaces advertisement:

drivers/net/phy/mxl-gpy.c:
	static int gpy21x_config_init(struct phy_device *phydev)
	{
		__set_bit(PHY_INTERFACE_MODE_2500BASEX, phydev->possible_interfaces);
		__set_bit(PHY_INTERFACE_MODE_SGMII, phydev->possible_interfaces);

		return gpy_config_init(phydev);
	}

git blame shows the MxL86211C entry, including .config_init =
gpy_config_init, came in with:

9d844da693d6d0 ("net: phy: mxl-gpy: add support for MxL86211C")

and every other GPY21x entry (GPY211B/C, GPY212B/C, GPY215B/C) already uses
gpy21x_config_init. Together with the changelog note that 2.5G only
negotiates "with this change", that reads like the original entry was
incomplete rather than an intentional 1G restriction.

Would it make sense to add:

	Fixes: 9d844da693d6 ("net: phy: mxl-gpy: add support for MxL86211C")

so that boards with this PHY, which are limited to 1G on released kernels,
get the fix through stable?

>  		.probe		= gpy_probe,
>  		.inband_caps	= gpy_inband_caps,
>  		.config_inband	= gpy_config_inband,

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922-mainline-rouven-mxl2g5-v1-1-a0ed53631a5f%40linaro.org
