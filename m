Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB3851993D;
	Mon,  7 Sep 2026 16:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788798526; cv=none; b=bZwOarPcJqRw1z78NC5C6UNUny5BVohaf+H+x6viK2ZQ0PHosvaMnkfHk0G7EVxGhH4ATTX/zecP3/C7Lpj5su4+jO/dg3aWea0X7LQrnZnYHbDBu6Mvv3oE6tymMSZ2i8KEMco0yhdoymmnY+kud63Gd5vc01DRsqF5QyXlEhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788798526; c=relaxed/simple;
	bh=DaCJBhL0Ie/9JsoTEaLKQ46zw4SlWH/BTshKSEG3Quo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bGCBXbaGQdKUsD49xFEokoObyzLwu2Wz6upH5t+Cax/ExPeyDpyqV56IgZgeHuw+2YUFIWoNav7VsFRF1JOmb1ZLKQLDibBopdfzx1MoC92br5nFBvO4QPwiCtQsOP/2cuiv35PTtns8W+NZKojYowiTkI5qtjTZkZ4W/QEIj0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=on7YMwyp; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="on7YMwyp"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6B72C4E4156A;
	Mon,  7 Sep 2026 16:28:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 2F6F360383;
	Mon,  7 Sep 2026 16:28:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D8D3211C79FF1;
	Mon,  7 Sep 2026 18:28:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788798517; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=AdTMXhy7HLguCTbbF69du9V2VLLyGLfiqtqDG4IxbQE=;
	b=on7YMwyp4JEz7fgboYhvMM746YaaFyJt8X1b5fezggtJNVGcA09k9WkK3fsielbCv9c/l0
	KH9J6Lv1LIME1zJLxEwrAWzQdE8c61gX5XytPQRFM3YiwgbwNxV2qr0v2xjVrb9LB5Mmjv
	Ld3C9jGny2UBizNaEcGq3rMh1Uh70gmU4QnPm1bzhVzT4kUGjE4/PsSJn15M7T4ly0oIk1
	OjZ+DyCARtLAN3N4uUq9322g3fMt6EHl7zOFGkvvMc9rLxdRheMZStk5YoTXrUU9uc66cY
	7Q5m9oKk8EiamKsEO+mLutRWzt89Io/BjWK2Sdy/q92tm5e3jL/e6VTYo2QCsA==
Message-ID: <b7d56704-2aed-464f-8295-2ad70e4afa2c@bootlin.com>
Date: Mon, 7 Sep 2026 18:28:32 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 3/3] net: dsa: lantiq_gswip: fix
 GSWIP_MDIO_PHY_FCONTX_EN value
To: "Jan Havran (Advantech Czech)" <havran.jan@email.cz>,
 Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260907134818.16670-1-havran.jan@email.cz>
 <20260907134818.16670-4-havran.jan@email.cz>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260907134818.16670-4-havran.jan@email.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/7/26 15:48, Jan Havran (Advantech Czech) wrote:
> Per the GSW145 data sheet, the FCONTX (bits 8:7) and FCONRX (bits 6:5)
> flow-control fields of the PHY_ADDR_n register both encode 00 = AUTO,
> 01 = EN, 10 = reserved, 11 = DIS. GSWIP_MDIO_PHY_FCONTX_EN was 0x0100,
> i.e. field value 10 (the reserved encoding), instead of 0x0080 (01 = EN);
> FCONRX_EN is already 0x0020 (01). Enabling tx flow control therefore wrote
> the reserved value.
> 
> Set FCONTX_EN to 0x0080. The register is shared by all supported parts.
> 
> Fixes: 14fceff4771e ("net: dsa: Add Lantiq / Intel DSA driver for vrx200")
> Signed-off-by: Jan Havran (Advantech Czech) <havran.jan@email.cz>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/dsa/lantiq/lantiq_gswip.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/dsa/lantiq/lantiq_gswip.h b/drivers/net/dsa/lantiq/lantiq_gswip.h
> index bc3686faad0d6..0b75be14dc109 100644
> --- a/drivers/net/dsa/lantiq/lantiq_gswip.h
> +++ b/drivers/net/dsa/lantiq/lantiq_gswip.h
> @@ -42,7 +42,7 @@
>  #define  GSWIP_MDIO_PHY_FDUP_DIS	0x0600
>  #define  GSWIP_MDIO_PHY_FCONTX_MASK	0x0180
>  #define  GSWIP_MDIO_PHY_FCONTX_AUTO	0x0000
> -#define  GSWIP_MDIO_PHY_FCONTX_EN	0x0100
> +#define  GSWIP_MDIO_PHY_FCONTX_EN	0x0080
>  #define  GSWIP_MDIO_PHY_FCONTX_DIS	0x0180
>  #define  GSWIP_MDIO_PHY_FCONRX_MASK	0x0060
>  #define  GSWIP_MDIO_PHY_FCONRX_AUTO	0x0000

