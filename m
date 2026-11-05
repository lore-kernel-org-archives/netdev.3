Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793899006;
	b=i0aVVChW4db09VD4uLV46FEmqZddDrPsbtps9MmXqA5yJWXd6+bYHZb3vcMJXLV2WbU0
	 jhM8N9AEVxyqLXWAa7un3p8Y8Ja1Wf05DgBpv4vuagx38nrWuyoXmMlz4jDRS5FAAoEYM
	 JdDIOh10XomS83m4WiAJXJp/xvnM3eUrdF2Q3FMyIPf7KumHQ+scDdiEtkMbci2NhGdkP
	 vy3pcjulcDMEkIHoLCHS1o3Ylcvhqz5pHtqm2MSt6RYRoEV7Zu4whs+MLvpdrel/HLtYc
	 EY4x+uK0enZvUBvoBW10xWtWzt4jXgj6jY0GWa/vyvE8ubi0o8mMXZjE0BWRjR+VV8w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793899006;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=8TTgnEslfhmARTzLvGf2WXLm6wVd1Tp4w50+BJAZBOw=;
	b=vZ552r2mY5MwZg7jMXMW85OR/CBOwJRFvsZYu47AET+hClqQ0JQQjZhQjz9zSRD6bzdp
	 gsAI20DDcTB9o3V4vhyiyIIMWpnizmsfTOoOn5zVHAyBgffiuTO+JtJapfqKX1ViTrVp1
	 y3hR9MOVJFwiY0Gt3n5oYF1vgiPuFybAtfF5MkS1yGYakSHdV7rAZpthzk6nnEazjMAts
	 Z0eGJSRCguqudA55hukP0erPUpxfXoESEMmnVsob3AduVTsIycK0UNtS7TIBI61QqITTL
	 rjCSR1ZG8/+gBF0xYgwd8/gyRJxcgwgbdPQcPpYAwMTMeKdigIFuo2vpuSY5dh4golw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wgl02OB7;
	arc=none smtp.remote-ip=74.125.82.181
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com [74.125.82.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D1C606A336
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 17:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 45D1C606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Wgl02OB7
Received: by mail-dy1-f181.google.com with SMTP id 5a478bee46e88-3645f0f3fcdso3531573eec.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 09:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793899005; x=1794503805; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8TTgnEslfhmARTzLvGf2WXLm6wVd1Tp4w50+BJAZBOw=;
        b=Wgl02OB7DEB2aqh4WoP3ufq9IDXvCofH/DMsCDWp1WDM0rdOnmn3824ZqMlg/EqUQu
         yeE44JmA3wk7cCyKNW1hteK5g+IIPU4vj/+k5nCK7zySs/0T327QSf+PLhcpfZYeEX8t
         TQRwRone9aanZ333rHcWPYHvLh6Feqa/a+P/7439n7mMiAOqoT6gmSrGCcsbz5tk0r8H
         au9MlKszGg4Yr+oTK94ASBKqxphjXbWn4L1s3DPH12NXkfrOKgfMWrzuh6h/Nnbf9Ri4
         5DXkOW0jwrHSx0t94eTi236hzFRPDsJo7lCPblPjrCPe0YKDy6gcQyGkuBxYj9HWPNkS
         ihTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793899005; x=1794503805;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8TTgnEslfhmARTzLvGf2WXLm6wVd1Tp4w50+BJAZBOw=;
        b=q8MMxtnpstA5xXv9FlnoUVw8ERZ+Ny7N1/cc/fohsrKsFmFWwfG6GsUDrAsYNRw2Za
         0gwzhm9avLzIHPRGiD6t4ELnIPYwKD3oi9/nzNXmyrV6aC80sr6pA4taOfMUiF/HWxFh
         pcXmvQwLwohDrLUQScsRf5M3wvgPSOld08Qn6IzUppUPBQ2EW+uXZMsSPdwdfeNHvR82
         PGP/NnO7wk2iee7aEXi4pgscxUnxeC0/xLSaKC97sbyqNAfWONVbMNGGM1rcGTll6kfC
         BX+8HavubXGPv1qPA/GEek2VFxYAnfvmUkXCrWaohK/d2RKezx+UfNjoVhxR+yI1Co3z
         ISbw==
X-Forwarded-Encrypted: i=1; AKwUvByoaDk2ben4AqAUnRX27VnnU7ba2VgBtg0eTDa1kK+YXqCmNGDOR3SyzqxJK0LFjaIdUROrSh8=@vger.kernel.org
X-Gm-Message-State: APuU4Z87F2b07GINr0dbCDYOEABrZ7JQ3s5huTvm2AeYwCZ94rgJM8/r
	Fhe8vS6oentMWkOk9CIUftZtnpujZN8Ft7qY5yFfuH8HIjhe7dNfL1j3FHKPYb1Y
X-Gm-Gg: AYBFou2x8cGKTJPQYcZ6bcqe0tajmub933WQ+GCmFvwUS5eY/J8/X6ZLq8DhM6QR4oy
	GUn+o7hkrBYuK3VjXZx2HdHHB+4S03dD7smluoGyVSgcxf9utonb0qENz3MWUkWNDDDH5NJKU3G
	EhQHf4xpAjKhS0mlD0gi/1BMezoRFIuWJ5Dm71RbC78hdwihwJD75vQz8OVVFnHWDJUH/0qWo/O
	ofVcZmRAa8eRCkscExY4pkJMgdYs+k5FGe15DzqhalRqRIl8GQdlz/WaCNWj0lQQoJ8jMvf52m+
	qtM/I1RHu5v57JI+wEwroma9gxDuOCBuNh7SKmBhNGtXbmJKNnsTmX7KN2VkuyUlcdM869GBucm
	F7b8ZX4UNnFVgl6fMHhz2ZH4bA37eSSvGYzF0ty2XsEFEBuFV8Px4X3LAAwvhghMSMwnn1GRkau
	PYMqplYKoGPiOoWsMV+siVAjotXt7JV5oX6Ie2mSFdOIQv6dDtHsV6/kjOW0aAx3Fj3S+yd5fG/
	QQEDSNk0eZ4H1+Phgx4WWU8i28y7UfN99eM40v5uRpnW5nadMe9gQmSrL+diFS5RU+VBtxYSnkz
	xH4brQ+zPumCBEmwFJFGn4FSKodqfxo4ipQjZ8YvEQNVAdMuuhQbbWl3K3Waew4gRg==
X-Received: by 2002:a05:7300:cc96:b0:36e:b3e6:ebe7 with SMTP id 5a478bee46e88-36eb3f677e5mr2158998eec.26.1793899005312;
        Thu, 05 Nov 2026 09:16:45 -0800 (PST)
Received: from ?IPV6:2620:10d:c085:21c8::1368? ([2620:10d:c090:400::5:f848])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca39b8eb3sm24181600eec.27.2026.11.05.09.16.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Nov 2026 09:16:44 -0800 (PST)
Message-ID: <2376d06b-80b4-46d9-8540-8baf065b0326@gmail.com>
Date: Thu, 5 Nov 2026 09:16:43 -0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 1/5] net: sparx5: Drop redundant POL_ prefix
 from POL_UPD_INT_CFG
To: Daniel Machon <daniel.machon@microchip.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Steen Hegelund <Steen.Hegelund@microchip.com>, UNGLinuxDriver@microchip.com
Cc: robert.marko@sartura.hr, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20261105-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v3-0-b45a3a26bed5@microchip.com>
 <20261105-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v3-1-b45a3a26bed5@microchip.com>
Content-Language: en-US
From: Mohsin Bashir <mohsin.bashr@gmail.com>
In-Reply-To: <20261105-b4-lan966x-pci-fdma-sparx5-lan969x-port-policers-v3-1-b45a3a26bed5@microchip.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 11/5/26 5:19 AM, Daniel Machon wrote:
> The macros for the ANA_AC_POL:POL_UPD_INT_CFG register are named
> ANA_AC_POL_POL_UPD_INT_CFG*, repeating the POL_ prefix that is already
> part of the target name.
> 
> Rename them to ANA_AC_POL_UPD_INT_CFG*, so that the port policer
> registers added in the next patch can use the same short form.
> 
> No functional change.
> 
> Signed-off-by: Daniel Machon <daniel.machon@microchip.com>
> ---
>   drivers/net/ethernet/microchip/sparx5/sparx5_main.c      |  6 +++---
>   drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h | 12 ++++++------
>   2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
> index e039f5369b95e..68c80c63f9087 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main.c
> @@ -616,10 +616,10 @@ static int sparx5_init_coreclock(struct sparx5 *sparx5)
>   		 sparx5,
>   		 HSCH_TAS_STATEMACHINE_CFG);
>   
> -	spx5_rmw(ANA_AC_POL_POL_UPD_INT_CFG_POL_UPD_INT_SET(pol_upd_int),
> -		 ANA_AC_POL_POL_UPD_INT_CFG_POL_UPD_INT,
> +	spx5_rmw(ANA_AC_POL_UPD_INT_CFG_POL_UPD_INT_SET(pol_upd_int),
> +		 ANA_AC_POL_UPD_INT_CFG_POL_UPD_INT,
>   		 sparx5,
> -		 ANA_AC_POL_POL_UPD_INT_CFG);
> +		 ANA_AC_POL_UPD_INT_CFG);
>   
>   	return 0;
>   }
> diff --git a/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h b/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
> index 1464fd1a1d447..219c7f0e516e9 100644
> --- a/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
> +++ b/drivers/net/ethernet/microchip/sparx5/sparx5_main_regs.h
> @@ -939,15 +939,15 @@ extern const struct sparx5_regs *regs;
>   	FIELD_GET(ANA_ACL_SEC_LOOKUP_STICKY_SEC_TYPE_MAC_ETYPE_STICKY, x)
>   
>   /* ANA_AC_POL:POL_ALL_CFG:POL_UPD_INT_CFG */
> -#define ANA_AC_POL_POL_UPD_INT_CFG                                             \
> +#define ANA_AC_POL_UPD_INT_CFG                                                 \
>   	__REG(TARGET_ANA_AC_POL, 0, 1, regs->gaddr[GA_ANA_AC_POL_POL_ALL_CFG], \
>   	      0, 1, 1160, 1148, 0, 1, 4)
>   
> -#define ANA_AC_POL_POL_UPD_INT_CFG_POL_UPD_INT   GENMASK(9, 0)
> -#define ANA_AC_POL_POL_UPD_INT_CFG_POL_UPD_INT_SET(x)\
> -	FIELD_PREP(ANA_AC_POL_POL_UPD_INT_CFG_POL_UPD_INT, x)
> -#define ANA_AC_POL_POL_UPD_INT_CFG_POL_UPD_INT_GET(x)\
> -	FIELD_GET(ANA_AC_POL_POL_UPD_INT_CFG_POL_UPD_INT, x)
> +#define ANA_AC_POL_UPD_INT_CFG_POL_UPD_INT       GENMASK(9, 0)
> +#define ANA_AC_POL_UPD_INT_CFG_POL_UPD_INT_SET(x)\
> +	FIELD_PREP(ANA_AC_POL_UPD_INT_CFG_POL_UPD_INT, x)
> +#define ANA_AC_POL_UPD_INT_CFG_POL_UPD_INT_GET(x)\
> +	FIELD_GET(ANA_AC_POL_UPD_INT_CFG_POL_UPD_INT, x)
>   
>   /* ANA_AC_POL:COMMON_BDLB:DLB_CTRL */
>   #define ANA_AC_POL_BDLB_DLB_CTRL                                               \
> 

Reviewed-by: Mohsin Bashir <hmohsin@meta.com>
