Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=156.67.10.101
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793280508;
	b=0OD2Udmia+M+MvSflCX4zT07eKe7DTFnIY4YdCpycFdBRTzH7o31XWmIGR941u0lyVV4
	 1985Oigc1WP7NQhZIJYcExOpa7zNfxt7EfglKnaYOGV98FUxIoCQLBZkQfHmaG9Ho4X2C
	 e3uzRScwkX38dZnYnNROMantvUbl/mCSl1DsqR2t3xRJe5LV3keGeQ8ZubwIZ23QhNhox
	 pfMX+4DrP61NP8ToWBNYfKZCVc7IsNSZahBne7jC+JgP4Jia0p4HoQg8yhdXaoqj+tDjv
	 Akn3JqmCbTW4lyN/d0cQnFL15OQ2z61D/hfNo8R5CnTtMRrsOqk6KgdjTArtzT25HGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793280508;
	h=DMARC-Filter:DKIM-Signature:Received:Date:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=9Jiu6IhR6LqPmpAEfjQ4ukzfBbep/xIaonqi088QRR4=;
	b=XHff05exKz54bU03uXBN/WHwsk8CYedrx3hqZ/arfJn2Gp322CLshBSp3eWnctJgTNuv
	 uF0VCMrZVNtjJ6sc51s3gagiqasKqGgSYsg8Pcehdo//UXSMY7iUcDtRpVdBBTfYh0Twz
	 jr5uBlq0DiXrYrWfv6JW05OF2hDRHxSsOPqb81FGZ0AvLJ7orbYntahWdB/pT1ekKzlNB
	 QYMolQOzyTid8yuv3Xww0WZyWl2L2B539hpCe73kb0esPaKgWGCuxLslfRASXBwe/HuKq
	 qk4hv/C8tOdwfHPOmHUqyjmnDs2p+C2hBSGGwDRzPqr2j8dRFjk0KvC/bAVR6fDIDRw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=lunn.ch;
	spf=pass smtp.mailfrom=lunn.ch;
	dkim=pass header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=nmCLT8x6;
	arc=none smtp.remote-ip=156.67.10.101
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3993606A335;
	Thu, 29 Oct 2026 13:28:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3993606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lunn.ch header.i=@lunn.ch header.a=rsa-sha256 header.s=20171124 header.b=nmCLT8x6
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=9Jiu6IhR6LqPmpAEfjQ4ukzfBbep/xIaonqi088QRR4=; b=nmCLT8x6Fr8IVYnZleY5Qt/zbZ
	YVTBS2SqerEkgiHaXrnRusIbFFV6Z4/FiHHBNufx9IlMTYV9Qz7atCY+5/zZHPn3ruVAwEF7BfuGd
	dKziBGm06rFO6iVCxR+FqI9iFZl2mw117uIFbevCQwl3Sgi+ZiaLH/YzcJZajql1SCKk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1xMQB0-00DFTq-Fy; Thu, 29 Oct 2026 14:28:18 +0100
Date: Thu, 29 Oct 2026 14:28:18 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Hongmei Xu <hongmei.xu@oss.qualcomm.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Sagar Cheluvegowda <sagar.cheluvegowda@oss.qualcomm.com>
Subject: Re: [PATCH net-next v3] net: phy: aquantia: Add support for 5GbaseR
Message-ID: <b87d66ca-dbd3-412a-9ebc-055f8e6f9a6f@lunn.ch>
References: <20261029-aquantia-support-5gbaser-v3-1-f1f9346553d0@oss.qualcomm.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029-aquantia-support-5gbaser-v3-1-f1f9346553d0@oss.qualcomm.com>

> @@ -786,7 +790,8 @@ static int aqr_gen1_config_init(struct phy_device *phydev)
>  	    phydev->interface != PHY_INTERFACE_MODE_10GKR &&
>  	    phydev->interface != PHY_INTERFACE_MODE_10GBASER &&
>  	    phydev->interface != PHY_INTERFACE_MODE_XAUI &&
> -	    phydev->interface != PHY_INTERFACE_MODE_RXAUI)
> +	    phydev->interface != PHY_INTERFACE_MODE_RXAUI &&
> +	    phydev->interface != PHY_INTERFACE_MODE_5GBASER)

This is sorted based on speed. So 5GBASER goes earlier in the list.

>  {
>  	if (iface == PHY_INTERFACE_MODE_10GBASER ||
> -	    iface == PHY_INTERFACE_MODE_2500BASEX)
> +	    iface == PHY_INTERFACE_MODE_2500BASEX ||
> +	    iface == PHY_INTERFACE_MODE_5GBASER)
>  		return RATE_MATCH_PAUSE;

Please keep this in order, 10, 5, 2.5.

    Andrew

---
pw-bot: cr
