Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6752367D1
	for <netdev@vger.kernel.org>; Sat,  7 Feb 2026 14:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770474210; cv=none; b=pC1P4XC0r6w3K/aQrgu78xyyicfBVHTW0vnhmCOYMmHMXvcWMDqYZm/nU/a7636bhfFZyEq3ROv7jtAFQABH/WxKEcI+HUekL0KeF4+FUgZHl0Vi6bl8aasH8mGAt7OKQCLg7/5RioFQLpAXs+WpZLuVJWba+3usqQ5WU2d9Lgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770474210; c=relaxed/simple;
	bh=+szgMuEpKZZ6DZbNPpPmpHshXK+9ny8f91/pkGyjsvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pwHIUi2aQhvi4mzZThHG64JnVPV/bX+TaN2b5OJDjSgw0jh+XQur8KjOT+O8A6XQYPZD2efjxjFKQBdl9Fi38F4fZT8EfPQZIP2wBlsiPLmxgdztf8owW2eEaCW/rtkQgJw6VPMWCbbbxLgbpF2yKzLQKtsWny2Al/kQ2e3l6Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tO0Piah9; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tO0Piah9"
Message-ID: <a736746b-aaa6-4b55-b360-5ad737567e63@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770474198;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w4QE+5u7IKXQ56J+UI6fOeWNJGfn+xPZSkNKWVeSjBg=;
	b=tO0Piah9mSn6pa9D79ouTMriEFSS8fJHl8ekqOTiwIbuefn1H4fy8/Fbl1yi8GeFHvm9cc
	evZgolb42sDjr2vSXhPM0NODYG0OMujbPRlOahY1dMXRWG7S129JfTWgesg/TK4EpQy0hM
	h4cDzZPplu20gcXmQUE14JAfj8B3/Uw=
Date: Sat, 7 Feb 2026 14:23:11 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next] net: stmmac: qcom-ethqos: fix
 qcom_ethqos_serdes_powerup()
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 Mohd Ayaan Anwar <mohd.anwar@oss.qualcomm.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Sneh Shah <quic_snehshah@quicinc.com>,
 Vinod Koul <vkoul@kernel.org>
References: <E1voPUH-000000083ji-25FH@rmk-PC.armlinux.org.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <E1voPUH-000000083ji-25FH@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 06/02/2026 17:19, Russell King (Oracle) wrote:
> Add cleanup for failure paths in qcom_ethqos_serdes_powerup(). This
> was missing calling phy_exit() and phy_power_off() at appropriate
> failure points.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> ---
>   .../net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c  | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> index 869f924f3cde..af8204c0e188 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> @@ -659,10 +659,18 @@ static int qcom_ethqos_serdes_powerup(struct net_device *ndev, void *priv)
>   		return ret;
>   
>   	ret = phy_power_on(ethqos->serdes_phy);
> -	if (ret)
> +	if (ret) {
> +		phy_exit(ethqos->serdes_phy);
>   		return ret;
> +	}
>   
> -	return phy_set_speed(ethqos->serdes_phy, ethqos->serdes_speed);
> +	ret = phy_set_speed(ethqos->serdes_phy, ethqos->serdes_speed);
> +	if (ret) {
> +		phy_power_off(ethqos->serdes_phy);
> +		phy_exit(ethqos->serdes_phy);
> +	}
> +
> +	return ret;
>   }
>   
>   static void qcom_ethqos_serdes_powerdown(struct net_device *ndev, void *priv)

Reviewed-by: Vadim Fedorenko <vadim.fedorenko@linux.dev>
