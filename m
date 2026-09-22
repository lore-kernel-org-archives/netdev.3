Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3C4276050;
	Tue, 22 Sep 2026 05:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790053552; cv=none; b=s2cn4sydN52WNn0ZYbidmT/fPNnHbs+WrQdBFSI/RfuKG8vU83jffghemiyexXc9aG5mYFRHl/H+U+CThBVHTRGpXnm2TTcdW7wuCJgYnAVPkG+c8TKuF+QKhlxIHPahWlzA29H2DeCf0cv0eCK0z1k+7dIydfk4yl6V+3lQ/aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790053552; c=relaxed/simple;
	bh=SSugme39AaT4a7tjags5rgJx2pgXI2oH0edPTiycef4=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fi99Ax4Chnc2AAZ/Eur5oWtkrHqWMuYSiqyu0+OXuBxW0MLle8eXZHqUOjpJC9smILMJxqIdTRKik9lYAW+CAWr7mB8dV/9K5GBx7YX8L9QSpCD/2tbY3PYff7PetRMLvw9aFrLU3X++1NLUuvs12dQQoEUnAU0Ymfl3ffgswh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxzkTsg6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxzkTsg6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF2E81F000FF;
	Tue, 22 Sep 2026 05:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790053550;
	bh=GJG6I5Clw5SCk/1VpkRKC4P7mxnCryzaJv4G7QIe0/Q=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=cxzkTsg6YpwwvdbpuJvSO/ID7WPyYAPxPa9VxLV/seFyHqIQcuYktPfzIZWv3Pn/r
	 90tVtBDRiq3GJGXjb1/hB65AgHECqvX1kq0ukuddED6Rx+plCtncZ0sz7uLqvrPlXx
	 vyOjEGpXaKqPZ61meUlQ5uUydsTCKMA6Ltzr0rpDamWSsy14HARnnb1cwOQ/0QMQnL
	 zOky9+H9ruIRu0xY9YD5vkCA02BYOW63W/3qwbb02+mypTtgNB4nYjsSgKR1TPwTr1
	 Q3TVsEt28jmOfWRA5KdOa5qh3p25iXvRWMyYc5ZQiuHb5Zy0+gyQJW0FofpPoraiCa
	 +vdBYJSdico/w==
Subject:
 Re: [PATCH net v2 1/3] net: stmmac: propagate platform mac_finish errors
From: netdev-bot+sashiko@kernel.org
To: tom.karpiniec@outlook.com
Cc: netdev@vger.kernel.org, mohd.anwar@oss.qualcomm.com,
 maxime.chevallier@bootlin.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, linux@armlinux.org.uk, andrew+netdev@lunn.ch,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 yong.liang.choong@linux.intel.com, brgl@kernel.org, coiaprant@gmail.com,
 linux-arm-msm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Date: Tue, 22 Sep 2026 05:05:49 +0000
Message-ID: <179005354933.2160803.8939564905853996739@kernel.org>
In-Reply-To: =?utf-8?q?=3CSJ2PR11MB8401FFBBECB8FBBA9C002134E4872=40SJ2PR11MB?=
 =?utf-8?q?8401=2Enamprd11=2Eprod=2Eoutlook=2Ecom=3E?=
References: =?utf-8?q?=3CSJ2PR11MB8401FFBBECB8FBBA9C002134E4872=40SJ2PR11MB8?=
 =?utf-8?q?401=2Enamprd11=2Eprod=2Eoutlook=2Ecom=3E?=
X-sashiko-severity: High
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

Critical: 0 · High: 1 · Medium: 0 · Low: 1

If you believe none of the issues are legitimate, please reply to each
issue of Medium severity or higher and explain why the AI is wrong.
If any of them are legitimate and you plan to respin, please let patchwork
know by including "pw-bot: cr" as a separate line at the end of your reply
(one such reply per series is enough).

- [High] Incomplete fix: the bug class the commit message claims to close
  ('Phylink then treats the interface as successfully configured and can…
- [Low] Continuation-line misalignment introduced by the patch in
  stmmac_mac_finish(): after adding 'return ', the open parenthesis of…

--

net: stmmac: propagate platform mac_finish errors

stmmac_mac_finish() previously dropped the return value of the platform
mac_finish callback and always told phylink the configuration succeeded.
The patch returns the callback result instead, keeping the zero return for
the case where no platform callback is installed.

No Link: tags present in the commit header.

> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> index 1fb5f804ea23..1350e92943ac 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
> @@ -1048,8 +1048,8 @@ static int stmmac_mac_finish(struct phylink_config *config, unsigned int mode,
>  	struct stmmac_priv *priv = netdev_priv(ndev);
>  
>  	if (priv->plat->mac_finish)
> -		priv->plat->mac_finish(ndev, priv->plat->bsp_priv, mode,
> -				       interface);
> +		return priv->plat->mac_finish(ndev, priv->plat->bsp_priv, mode,
> +					     interface);

[Severity: High]
The commit message says that without this change "Phylink then treats the
interface as successfully configured and can report carrier even though the
SerDes is not ready".  Does that failure mode still remain reachable on the
Intel mGbE ports after this patch?

intel_mac_finish() in dwmac-intel.c is the other in-tree mac_finish
implementer (installed by ehl_sgmii_data(), ehl_pse0_sgmii1g_data(),
ehl_pse1_sgmii1g_data() and adln_sgmii_phy0_data()), and it ends with:

drivers/net/ethernet/stmicro/stmmac/dwmac-intel.c:intel_mac_finish() {
	...
	priv->plat->phy_interface = interface;

	intel_serdes_powerdown(ndev, intel_priv);
	intel_serdes_powerup(ndev, intel_priv);

	return ret;
}

ret here is the value from intel_set_reg_access(), normally zero, so the
return value of intel_serdes_powerup() is dropped.  That function has three
timeout exits fed by serdes_status_poll():

	data = serdes_status_poll(priv, serdes_phy_addr,
				  SERDES_GSR0,
				  SERDES_PLL_CLK,
				  SERDES_PLL_CLK);

	if (data) {
		dev_err(priv->device, "Serdes PLL clk request timeout\n");
		return data;
	}

with the other two covering the lane reset reflection and the
SERDES_PWR_ST_P0 transition.  serdes_status_poll() returns -ETIMEDOUT after
10 retries.

Since intel_serdes_powerdown() has already dropped the lane to P3, a timeout
in intel_serdes_powerup() leaves the lane out of P0 or held in reset, yet
intel_mac_finish() returns 0.  phylink_major_config() only records a failure
for err < 0, so phylink still sees success and can raise carrier.

Would it make sense to add a companion change so that intel_mac_finish()
returns the intel_serdes_powerup() result, so that the propagation added
here has an effect on this platform too?

[Severity: Low]
This isn't a bug, but the continuation line no longer lines up with the open
parenthesis after "return " was inserted: the argument list now starts one
column further right, so "interface);" needs one more space to satisfy
checkpatch.pl --strict ("CHECK: Alignment should match open parenthesis").

>  
>  	return 0;
>  }

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/SJ2PR11MB8401F5C3A075DE2A0013E063E4872%40SJ2PR11MB8401.namprd11.prod.outlook.com
