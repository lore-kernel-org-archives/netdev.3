Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=68.232.154.123
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793360073;
	b=tJ9U6nBB5zQFStC6BeZn3ChzWA2AqhwM1xMxtD71WuWX0V1rLaoJ/Y2kGcuhGCv7WIIR
	 7hK1lH4nORV8PhQIg3+ghSbXfhb4FExQ/DD0TlTKkebu+NY6aYDZeoTq1SQaijKGSEL05
	 Sn+/eKC2dfrsrixyTR22Dl/fUF1QHFfBDoDg3QVkq6nqKAiCYxt3JfIQinrWnyMcEqCSX
	 OfD3XZbFX9U9PAI0LirICaVMAgLIwI5iNnMNz7zDlMSyvzwJcsVwJCwaWgS8G0jSZZC6O
	 fW2ExMLPoBuPOaBmhXi8YuvNTVe6LjJN650KP8lidK2xIBtqGWMoxfc1O5RAQuw0R7A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793360073;
	h=DMARC-Filter:DKIM-Signature:X-CSE-ConnectionGUID:X-CSE-MsgGUID:
	 X-IronPort-AV:X-Amp-Result:Received:Received:Received:Date:From:To:CC:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=ZiiXnmfZtDT54dRj02Eho+B5zAGNGe4dn5wG11mcS0M=;
	b=IyWMdlhd0BXNhv9a8zzjhhisBIqSrZkJ3M12e/heYniRNWQUOLKzV1wqDvxgxiV2b97v
	 Mhxd8NHETyjXQUxW0XjBFFcNPkDUXFbLbZzbxM6f505/tsjDD2+v+Mu68dlo5Nn19pjn9
	 OsjQQEZYBD3jIuZan3dPOXLHOufLorZK+rt3DTxw8yGcdEfbKZNsgZAUbPkoxhcOWQhmB
	 12u5XdzyJOUwahe9JuM9bdbf6kLKBI9dWc/y7b6DzRnGQ4qOYFUurgIblNl8gajJyNRGH
	 6QyFU81kpVXdnhM4lT4e+IskI3dlpW67Yf213QDfV2cbEPvIqF6DOPNu3SE/tkcQ03w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=microchip.com;
	spf=pass smtp.mailfrom=microchip.com;
	dkim=pass header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=xtKYKTda;
	arc=none smtp.remote-ip=68.232.154.123
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7848E606A31A;
	Fri, 30 Oct 2026 11:34:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7848E606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=microchip.com header.i=@microchip.com header.a=rsa-sha256 header.s=mchp header.b=xtKYKTda
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1793360072; x=1824896072;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BdxExmf1Ia0xRpOfPjmqBxwkbQfRDGaKoikzDYM9808=;
  b=xtKYKTdavc75l4w2S2HIJiKWy3UUyrbnC/4S4fl9pwFDz1hAMZkyzjBI
   lq7aOvhLQPqcvp5XQDDHOnTdYww4mijxUTS/bWR+9OvyaLwzbrXFp1Efz
   8AxXJjhlCR9Ei1CD/SDAnmRBAqwGt553GDHW82+5VWUl8azIWQuE97Xo3
   BgzDvIqFBgkr7eQY48qOxpHxOyouTxByiXuil0p6tZx1s6Wk+Ww2Rg+8D
   Zfdyw6cNaGK5wf+fwM54+L7Fv7apU4F793sY3PQsdsnYgDOtFZMYLGHkV
   5WvSWibhH4mYYo9RBuZzR/SBvWare6xymqDNgXRbmkuw/fS6cBemiL+Br
   w==;
X-CSE-ConnectionGUID: VU0oIHh/SzaRn/5kySkI6g==
X-CSE-MsgGUID: +Yy0iLAASjiFM8OV22BoKQ==
X-IronPort-AV: E=Sophos;i="6.27,186,1787036400"; 
   d="scan'208";a="64814442"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Oct 2026 04:34:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Fri, 30 Oct 2026 04:34:25 -0700
Received: from DEN-DL-M70577 (10.10.85.11) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server id 15.1.2507.58 via Frontend
 Transport; Fri, 30 Oct 2026 04:34:23 -0700
Date: Fri, 30 Oct 2026 12:34:22 +0100
From: Daniel Machon <daniel.machon@microchip.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>
CC: <netdev@vger.kernel.org>, Jonas Gorski <jonas.gorski@gmail.com>, Andrew
 Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Russell King
	<linux@armlinux.org.uk>, "Russell King (Oracle)"
	<rmk+kernel@armlinux.org.uk>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net v2 2/5] net: dsa: b53: fix the SRAB grant timeout
 check
Message-ID: <20261030113422.xg2sinp5hdiyfh4p@DEN-DL-M70577>
References: <20261028212310.3847553-1-florian.fainelli@broadcom.com>
 <20261028212310.3847553-3-florian.fainelli@broadcom.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261028212310.3847553-3-florian.fainelli@broadcom.com>

> b53_srab_request_grant() polls for a grant up to 20 times, but checks for
> an iteration count of five to detect a timeout. This rejects a grant
> received on the sixth poll and reports success when all 20 polls finish
> without a grant. The latter allows a register access to proceed without
> ownership of the switch resources.
> 
> Check for exhaustion of all 20 iterations instead.
> 
> Fixes: 967dd82ffc52 ("net: dsa: b53: Add support for Broadcom RoboSwitch")
> Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
>  drivers/net/dsa/b53/b53_srab.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/b53/b53_srab.c b/drivers/net/dsa/b53/b53_srab.c
> index 83a03fca142a..f4689078ccd5 100644
> --- a/drivers/net/dsa/b53/b53_srab.c
> +++ b/drivers/net/dsa/b53/b53_srab.c
> @@ -105,7 +105,7 @@ static int b53_srab_request_grant(struct b53_device *dev)
>  			break;
>  		usleep_range(10, 100);
>  	}
> -	if (WARN_ON(i == 5))
> +	if (WARN_ON(i == 20))

I wondered why the initial check was i == 5. Seems like b53_srab_op(), just
below this one, has more or less the same loop, but with 5 iterations. Probably a
copy paste error.

>  		return -EIO;
>  
>  	return 0;
> -- 
> 2.53.0
> 

Reviewed-by: Daniel Machon <daniel.machon@microchip.com>
