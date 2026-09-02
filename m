Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF6330C606;
	Wed,  2 Sep 2026 08:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788336624; cv=none; b=NMe3mS2ksqouo5yjBwuPa9CUt0WN5y5yOIELctksvD7KkESN1XdKG93AWabwRo/SPhyURqnjO/sbpn3HoEUMTKTBjFlv3+2/ySdQl69fThU9A0zjc5RzgGt7bYKIZtcF1OhxcCbdGOG+UlcevP3YqZ4G4FJMoc7GXHIdPI0TJbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788336624; c=relaxed/simple;
	bh=XKMcISq6WvTLICvhduajMvfPQ6PfVxV1JboFKHz2ydQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IreI6i1chwKCRmQrix1Z7XVDqWb5YbCKQt2jxpUd8oA1we/tKtctCkKgCTvDURvWhf2vCRdDyyxfYliLCWZGiPMQconVf6CYWkp9qZAw65vbjFfdX4/6IBt+EcExfYQJEPDZfq+AXVHRQHrwdFQr2k5DbfkVD1U5Wc3BHRd2SPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=rm1X7tqu; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="rm1X7tqu"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 10CE34E414D1;
	Wed,  2 Sep 2026 08:10:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id BC0F06053C;
	Wed,  2 Sep 2026 08:10:16 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 66A3511C792EE;
	Wed,  2 Sep 2026 10:10:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788336615; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=YUTgwGPsz/G8YVkdcuR946dpfwYBYz1f/gwExtavfow=;
	b=rm1X7tquNlI43uAjIBLL4+zHyeyVr0yx+4YYJ+38AcnqmmjP5pSNNtPJ9XTSn18O/NCzZL
	h1nuqH/lGibMgWA1sBbga9kDPSXqFtCOuK41zusjMUqQFZAERFrhZru51qEF8m2UEz3/JH
	UdutglbNqXVxYActnp1sI0mvTi9SIVXp/ShLYmrtoD1AB23eA/dOCuXbzIFjvTDi7mOn1P
	oQ/ss3mtRv/WryHLV1Rp/GRezb8r4VFA7EBthK/RjSCYOuyTmsNZsMOg5k2vNFoLKQY+Kf
	tQRjqhcAEWWLg6eT3DSpl+bUnn4Q8sbPYTCc4rELErFKQgMuyp83Qg0w6M/SoQ==
Message-ID: <b609cf54-2e37-4c43-80c9-ae3d013cc4a8@bootlin.com>
Date: Wed, 2 Sep 2026 10:10:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net: phy: dp83848: check phy_read() return value in
 config_init()
To: Donggeun Yoo <donggeunyoo.kernel@gmail.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Alvaro Gamez Machado <alvaro.gamez@hazent.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260902065828.1031113-1-donggeunyoo.kernel@gmail.com>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260902065828.1031113-1-donggeunyoo.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/2/26 08:58, Donggeun Yoo wrote:
> dp83848_config_init() reads BMCR to detect whether auto-negotiation is
> enabled, but does not check the phy_read() return value. On an MDIO read
> failure phy_read() returns a negative errno, which is then used directly
> in a bitwise test; the auto-negotiation state is left undefined while
> config_init() still reports success.
> 
> Check the return value and propagate the error.
> 
> Fixes: b718e8c8f4f5 ("net: phy: dp83822: use BMCR_ANENABLE instead of BMSR_ANEGCAPABLE for DP83620")
> Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
> Only compile-tested; I do not have DP83848-family hardware.
> 
>  drivers/net/phy/dp83848.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/phy/dp83848.c b/drivers/net/phy/dp83848.c
> index d88b1999d596..e65651ac567a 100644
> --- a/drivers/net/phy/dp83848.c
> +++ b/drivers/net/phy/dp83848.c
> @@ -117,6 +117,9 @@ static int dp83848_config_init(struct phy_device *phydev)
>  	 * we check initial value of BMCR Auto negotiation enable bit
>  	 */
>  	val = phy_read(phydev, MII_BMCR);
> +	if (val < 0)
> +		return val;
> +
>  	if (!(val & BMCR_ANENABLE))
>  		phydev->autoneg = AUTONEG_DISABLE;
>  
> 
> base-commit: 70f3995830d3f1e79faa14eb0605914f778feca9

