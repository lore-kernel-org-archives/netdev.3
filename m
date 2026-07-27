Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35D923033D6
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 16:27:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785169642; cv=none; b=EnMdfpX6fPYKKjC0n9mIxLTBD28PIkoRoH8VZ2q19oCj27HprYLEEo6UCjiPZM/WqO3lhJQDs2VPdoPWtAsdWQLngEiCvWWMUwBqR7UBDiyGjHj3BqcPQn7F1BcdABBWt6jMVkuJzvjl6Bl8pQNmmgfJa6dCQgKs9vzEwnEO+nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785169642; c=relaxed/simple;
	bh=Bshd8Jw5qnCJ8rSiPc6SvkL1HLqmnM8x5cS+Ti0AOF8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZOItb/ABAzVjp47efhuL1Sh7EKz+gMZR4J10g7AtZAaDWwnXBUQ7ZNMBXiVnuOLCUxqF5YTs32F2+ZllczIUuYNqypIMfrwWjkDwN4+WpSarC1c4U8qWW6D6MBELZ1uMCKt2bSW5jZ0ftCA8xZcttoF0wogYwc0XtmYllpSdCcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KoOaF/b7; arc=none smtp.client-ip=209.85.215.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KoOaF/b7"
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-caf707e3a70so48425a12.1
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 09:27:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785169640; x=1785774440;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:dkim-signature:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=DKl7bUGmbjMOYlj9C6VYQ8SVJ8PjB52ZY+ZHE8EV7II=;
        b=jleWRMc70P2u/JgYgQLesJbcKQrYzJE2ha1Sadd4hX0fwZUGLij25i02slAecYmY1A
         SoxfdY2eR/288OdI9BVIQ3VyvL/o4DWb4/ktIIr1fAve8Cap5lKcXhRxom+u5HIjgQrq
         q5PgJhU6jmKhC0LnJ6ssVB4xU6+ZwDoe1PmyKzUo58Ni60xo4jh+ss+kZxFZp2ugP6sE
         z689XIBOt7hhZ/DlN6/zcEvc47gSBK+eJ9RDTRVFxyuX85i63duhtaqJjQ9WRLKx8nu9
         3uyP23SEuqNdR875GaTRUacWVe6cQb2oi6zvJOIeO+xbIRjDaemrIZD1TcgplCDyJ1QH
         5gDQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro4gfah1PQpeLS1RVAIsbGEUNUl3bOPsU9UwGosNr7qk6IvQZpSj+6MlZ1jd26SBrxDZi17o4k=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsTH9TZpkqvqM/lnVU0UlXqeXmGoJRMUQibEow20EWBliQum1P
	LkHf21/Am12biHKH9cdRfk9/I90+zFTqSJ0xiLn9PWOwiGqQ3ZvTddateaMWPfeXrhnDhSMi+FL
	d4+DPItC2sljT2WSD0uFDjJFqotmwfl8KD+teDPGilT2/xt5cc0y6/9AaB1zGK/eRMxKdI6IhN2
	Dzi/3S8WWd3ee2c+/nDiL6N9GAAEUWmb5PSGRmbqBWuYO14qK/pV3wsDqZRKsIApkX6yPmTqOTR
	SpRXDlxRJCYFzPX
X-Gm-Gg: AR+sD129AbbNRQYvo8N9z+Ek1OJ5SFiQgE+OvE/usl9yoKvuMd9plO/cz0HWYa/9wl/
	j43swLGvXhRTKfHZr7B4YQAK/o8q387EIKfGbEJ75C/26ra4m1RPgB6vw+44XOsWiy6luM90JgE
	tWnDwijSOogwGSFDbcDWQmFOzAu2o4yyFaCs37KBN9sCN8Wn8yU3GxQzixCITu6sIrgsWA1wxg/
	X8PJVqB5DgLAdjRRcHHlNrhxuU5qWHHqzFCN8i7C/ZbvfWSr6oJnrw9VQKMKznWVOmypNEuz13V
	pmEAXxsdmFr8e54JT22yqe5hyKaxiNY7Ww8RvnAVhR83rP5iV84nmfJbu9ZZx+Hg6ty77JGn8zs
	C1tc4CY5qrbtP2wR5UhZjcnNsTFPA8nFcgkqG2IsqcSFwctOgwCkksG8yb1FoxOa1ITeFHghDDv
	06US78YIGE2dZ6zj9HrduVBwPcsrHXKJPcb80thBHL
X-Received: by 2002:a05:6300:67c1:b0:3c6:3c5b:f7a7 with SMTP id adf61e73a8af0-3c6c8c21849mr115678637.38.1785169640251;
        Mon, 27 Jul 2026 09:27:20 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-73.dlp.protect.broadcom.com. [144.49.247.73])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-314bc528f23sm406534eec.16.2026.07.27.09.27.19
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 27 Jul 2026 09:27:20 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-84c4cd31b51so69259b3a.0
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 09:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1785169638; x=1785774438; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DKl7bUGmbjMOYlj9C6VYQ8SVJ8PjB52ZY+ZHE8EV7II=;
        b=KoOaF/b7mMdn8FrwAtxEDXXjXFg27Ds2KpyTAh7mqCOJ8++GYfUesdoQ5t6JU6HxNw
         BzLysYltrgSXlVGsi+lDHEbW5ybAlsoqdCeyp6nS/ZM8VYLk9FASd73au8GJhB+XJJgP
         PGz5favqWMY1u1iiQWIrUa2Y4XORtbj9zvZhg=
X-Forwarded-Encrypted: i=1; AHgh+RpISAOU1O1Dvg3n31zByCx2Hj9CLI2yVKZuva/0lClLsvRahWErGEOpf3/OnAFmAX/jdJx3nAc=@vger.kernel.org
X-Received: by 2002:a05:6a21:9cc8:b0:3bf:b7e8:68ab with SMTP id adf61e73a8af0-3c6c89d07f0mr156950637.2.1785169638091;
        Mon, 27 Jul 2026 09:27:18 -0700 (PDT)
X-Received: by 2002:a05:6a21:9cc8:b0:3bf:b7e8:68ab with SMTP id adf61e73a8af0-3c6c89d07f0mr156930637.2.1785169637623;
        Mon, 27 Jul 2026 09:27:17 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc5c53f3sm30947286eec.30.2026.07.27.09.27.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2026 09:27:16 -0700 (PDT)
Message-ID: <23278c3d-04eb-410d-8e6e-1f4ca63cdee7@broadcom.com>
Date: Mon, 27 Jul 2026 09:27:15 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: dsa: b53: srab: propagate errors from init
 helpers
To: Rosen Penev <rosenp@gmail.com>, netdev@vger.kernel.org
Cc: Jonas Gorski <jonas.gorski@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 open list <linux-kernel@vger.kernel.org>
References: <20260726231924.88459-1-rosenp@gmail.com>
Content-Language: en-US, fr-FR
From: Florian Fainelli <florian.fainelli@broadcom.com>
Autocrypt: addr=florian.fainelli@broadcom.com; keydata=
 xsBNBFPAG8ABCAC3EO02urEwipgbUNJ1r6oI2Vr/+uE389lSEShN2PmL3MVnzhViSAtrYxeT
 M0Txqn1tOWoIc4QUl6Ggqf5KP6FoRkCrgMMTnUAINsINYXK+3OLe7HjP10h2jDRX4Ajs4Ghs
 JrZOBru6rH0YrgAhr6O5gG7NE1jhly+EsOa2MpwOiXO4DE/YKZGuVe6Bh87WqmILs9KvnNrQ
 PcycQnYKTVpqE95d4M824M5cuRB6D1GrYovCsjA9uxo22kPdOoQRAu5gBBn3AdtALFyQj9DQ
 KQuc39/i/Kt6XLZ/RsBc6qLs+p+JnEuPJngTSfWvzGjpx0nkwCMi4yBb+xk7Hki4kEslABEB
 AAHNMEZsb3JpYW4gRmFpbmVsbGkgPGZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tPsLB
 IQQQAQgAywUCZWl41AUJI+Jo+hcKAAG/SMv+fS3xUQWa0NryPuoRGjsA3SAUAAAAAAAWAAFr
 ZXktdXNhZ2UtbWFza0BwZ3AuY29tjDAUgAAAAAAgAAdwcmVmZXJyZWQtZW1haWwtZW5jb2Rp
 bmdAcGdwLmNvbXBncG1pbWUICwkIBwMCAQoFF4AAAAAZGGxkYXA6Ly9rZXlzLmJyb2FkY29t
 Lm5ldAUbAwAAAAMWAgEFHgEAAAAEFQgJChYhBNXZKpfnkVze1+R8aIExtcQpvGagAAoJEIEx
 tcQpvGagWPEH/2l0DNr9QkTwJUxOoP9wgHfmVhqc0ZlDsBFv91I3BbhGKI5UATbipKNqG13Z
 TsBrJHcrnCqnTRS+8n9/myOF0ng2A4YT0EJnayzHugXm+hrkO5O9UEPJ8a+0553VqyoFhHqA
 zjxj8fUu1px5cbb4R9G4UAySqyeLLeqnYLCKb4+GklGSBGsLMYvLmIDNYlkhMdnnzsSUAS61
 WJYW6jjnzMwuKJ0ZHv7xZvSHyhIsFRiYiEs44kiYjbUUMcXor/uLEuTIazGrE3MahuGdjpT2
 IOjoMiTsbMc0yfhHp6G/2E769oDXMVxCCbMVpA+LUtVIQEA+8Zr6mX0Yk4nDS7OiBlvOwE0E
 U8AbwQEIAKxr71oqe+0+MYCc7WafWEcpQHFUwvYLcdBoOnmJPxDwDRpvU5LhqSPvk/yJdh9k
 4xUDQu3rm1qIW2I9Puk5n/Jz/lZsqGw8T13DKyu8eMcvaA/irm9lX9El27DPHy/0qsxmxVmU
 pu9y9S+BmaMb2CM9IuyxMWEl9ruWFS2jAWh/R8CrdnL6+zLk60R7XGzmSJqF09vYNlJ6Bdbs
 MWDXkYWWP5Ub1ZJGNJQ4qT7g8IN0qXxzLQsmz6tbgLMEHYBGx80bBF8AkdThd6SLhreCN7Uh
 IR/5NXGqotAZao2xlDpJLuOMQtoH9WVNuuxQQZHVd8if+yp6yRJ5DAmIUt5CCPcAEQEAAcLB
 gQQYAQIBKwUCU8AbwgUbDAAAAMBdIAQZAQgABgUCU8AbwQAKCRCTYAaomC8PVQ0VCACWk3n+
 obFABEp5Rg6Qvspi9kWXcwCcfZV41OIYWhXMoc57ssjCand5noZi8bKg0bxw4qsg+9cNgZ3P
 N/DFWcNKcAT3Z2/4fTnJqdJS//YcEhlr8uGs+ZWFcqAPbteFCM4dGDRruo69IrHfyyQGx16s
 CcFlrN8vD066RKevFepb/ml7eYEdN5SRALyEdQMKeCSf3mectdoECEqdF/MWpfWIYQ1hEfdm
 C2Kztm+h3Nkt9ZQLqc3wsPJZmbD9T0c9Rphfypgw/SfTf2/CHoYVkKqwUIzI59itl5Lze+R5
 wDByhWHx2Ud2R7SudmT9XK1e0x7W7a5z11Q6vrzuED5nQvkhAAoJEIExtcQpvGagugcIAJd5
 EYe6KM6Y6RvI6TvHp+QgbU5dxvjqSiSvam0Ms3QrLidCtantcGT2Wz/2PlbZqkoJxMQc40rb
 fXa4xQSvJYj0GWpadrDJUvUu3LEsunDCxdWrmbmwGRKqZraV2oG7YEddmDqOe0Xm/NxeSobc
 MIlnaE6V0U8f5zNHB7Y46yJjjYT/Ds1TJo3pvwevDWPvv6rdBeV07D9s43frUS6xYd1uFxHC
 7dZYWJjZmyUf5evr1W1gCgwLXG0PEi9n3qmz1lelQ8lSocmvxBKtMbX/OKhAfuP/iIwnTsww
 95A2SaPiQZA51NywV8OFgsN0ITl2PlZ4Tp9hHERDe6nQCsNI/Us=
In-Reply-To: <20260726231924.88459-1-rosenp@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

On 7/26/26 16:19, Rosen Penev wrote:
> Convert b53_srab_prepare_irq() and b53_srab_mux_init() from void to
> int-returning functions so probe failures are properly propagated.
> 
> b53_srab_prepare_irq() now returns -ENOMEM on allocation failure and
> -EPROBE_DEFER if any port IRQ is not yet available.
> 
> b53_srab_mux_init() now returns PTR_ERR on ioremap failure instead of
> silently ignoring it.
> 
> Check and propagate both return values in b53_srab_probe() so the
> driver core sees the real error instead of always reaching
> b53_switch_register().
> 
> Assisted-by: Opencode:Big-Pickle
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>   drivers/net/dsa/b53/b53_srab.c | 26 +++++++++++++++++++-------
>   1 file changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/net/dsa/b53/b53_srab.c b/drivers/net/dsa/b53/b53_srab.c
> index b9939bbd2cd5..d34e1fa10c9e 100644
> --- a/drivers/net/dsa/b53/b53_srab.c
> +++ b/drivers/net/dsa/b53/b53_srab.c
> @@ -531,7 +531,7 @@ static void b53_srab_intr_set(struct b53_srab_priv *priv, bool set)
>   	writel(reg, priv->regs + B53_SRAB_CTRLS);
>   }
>   
> -static void b53_srab_prepare_irq(struct platform_device *pdev)
> +static int b53_srab_prepare_irq(struct platform_device *pdev)
>   {
>   	struct b53_device *dev = platform_get_drvdata(pdev);
>   	struct b53_srab_priv *priv = dev->priv;
> @@ -551,18 +551,22 @@ static void b53_srab_prepare_irq(struct platform_device *pdev)
>   
>   		name = kasprintf(GFP_KERNEL, "link_state_p%d", i);
>   		if (!name)
> -			return;
> +			return -ENOMEM;
>   
>   		port->num = i;
>   		port->dev = dev;
>   		port->irq = platform_get_irq_byname_optional(pdev, name);
>   		kfree(name);
> +		if (port->irq == -EPROBE_DEFER)
> +			return port->irq;
>   	}
>   
>   	b53_srab_intr_set(priv, true);
> +
> +	return 0;
>   }
>   
> -static void b53_srab_mux_init(struct platform_device *pdev)
> +static int b53_srab_mux_init(struct platform_device *pdev)
>   {
>   	struct b53_device *dev = platform_get_drvdata(pdev);
>   	struct b53_srab_priv *priv = dev->priv;
> @@ -572,11 +576,11 @@ static void b53_srab_mux_init(struct platform_device *pdev)
>   	int ret;
>   
>   	if (dev->pdata && dev->pdata->chip_id != BCM58XX_DEVICE_ID)
> -		return;
> +		return 0;

That should be -ENODEV IMHO since we don't want the driver to be 
successfully registered and do nothing on a device it cannot support.

>   
>   	priv->mux_config = devm_platform_ioremap_resource(pdev, 1);
>   	if (IS_ERR(priv->mux_config))
> -		return;
> +		return PTR_ERR(priv->mux_config);
>   
>   	/* Obtain the port mux configuration so we know which lanes
>   	 * actually map to SerDes lanes
> @@ -613,6 +617,8 @@ static void b53_srab_mux_init(struct platform_device *pdev)
>   			dev_info(&pdev->dev, "Port %d mode: %s\n",
>   				 port, phy_modes(p->mode));
>   	}
> +
> +	return 0;
>   }
>   
>   static int b53_srab_probe(struct platform_device *pdev)
> @@ -622,6 +628,7 @@ static int b53_srab_probe(struct platform_device *pdev)
>   	const struct of_device_id *of_id = NULL;
>   	struct b53_srab_priv *priv;
>   	struct b53_device *dev;
> +	int err;
>   
>   	if (dn)
>   		of_id = of_match_node(b53_srab_of_match, dn);
> @@ -651,8 +658,13 @@ static int b53_srab_probe(struct platform_device *pdev)
>   
>   	platform_set_drvdata(pdev, dev);
>   
> -	b53_srab_prepare_irq(pdev);
> -	b53_srab_mux_init(pdev);
> +	err = b53_srab_prepare_irq(pdev);
> +	if (err)
> +		return err;
> +
> +	err = b53_srab_mux_init(pdev);
> +	if (err)
> +		return err;
>   
>   	return b53_switch_register(dev);
>   }


-- 
Florian
