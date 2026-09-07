Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AF351C354;
	Mon,  7 Sep 2026 16:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788798652; cv=none; b=SRlnlIE8jmKRBZqJXFI8XOAriF4OqL0fi86Yum3ERGeLLjoansyZApEqROJZr0yXrzaHot+cIDv7kdf4Sh5WyuNa1VkTSxMXLy0bbhv6Lm5a213y3cnr+QXFPA5D3wlWYhfWsNOfQzZitgO+oZLUmfsCFUmeqDCyjIk0P/SjRvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788798652; c=relaxed/simple;
	bh=7pVYL68lc4I7fP9BMITH+l1WpisGCrtkpYIvesSOJeo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CnZCSSAo5l+RYEC1mfrQXoXcjp85H1lYdjCKGbBQ2F2AiS9ttVpT/Fkie9vSPfA54e57WqPssnHKFsWI7KY1dhZH5KJ/ac8VzVbu4yYDKrgEiGDx0E5PYORtOvTQzysY3Hm2700j2KHk0swkCz+u01SqHp65DXL0TCgBdVHfeQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=07E+epDk; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="07E+epDk"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8B8FA4E4156A;
	Mon,  7 Sep 2026 16:30:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 525CA60383;
	Mon,  7 Sep 2026 16:30:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id EA96111C7AF0B;
	Mon,  7 Sep 2026 18:30:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788798646; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=4QlYBD4vc3WFr9t8sgXZFmBKf/SRXsQ3kb0DuYXLsEM=;
	b=07E+epDknOTtGbbi0gcHpv/sb8Sv6hsDjjF2y9mVM8xJDvELdMt+L6SBJ4wixplQTh2zAJ
	22q2V73Lyshb+Lck61UuXjKcPgrXCe48ywTVQ/Ks5IK1K/rqLTH64ndX6c1PUE3mBinvJQ
	7faPnbp4mrCMEbwafITJ6EWUhTGJn1nPGAIkEtycCxBLmAOHz/e66Bc4R2qRGLmScSekSJ
	75hUlU6Fqv446dwczT8Epb2A0/VVLjN+LfWoSxbf/pYFIvDA5hUJdsUt/ry0KjxAWknNIW
	n31/PCEkblyGyFV7aPBYPiMOdk5DKjMmZOeFe8dARvXlMDHBR1c3Ag3LWfY+yA==
Message-ID: <114c4ac7-a709-4e25-ba1b-0f705b400eb5@bootlin.com>
Date: Mon, 7 Sep 2026 18:30:43 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 2/3] net: dsa: lantiq_gswip: handle SPEED_2500 in
 gswip_port_set_speed()
To: "Jan Havran (Advantech Czech)" <havran.jan@email.cz>,
 Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
 Vladimir Oltean <olteanv@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>,
 "David S. Miller" <davem@davemloft.net>
Cc: Daniel Golle <daniel@makrotopia.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260907134818.16670-1-havran.jan@email.cz>
 <20260907134818.16670-3-havran.jan@email.cz>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260907134818.16670-3-havran.jan@email.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/7/26 15:48, Jan Havran (Advantech Czech) wrote:
> The mxl-gsw1xx driver advertises 2500BASE-X on its SGMII port (via
> supports_2500m and gsw1xx_phylink_get_caps()), but the shared
> gswip_port_set_speed() has no SPEED_2500 case: at 2.5G every field keeps
> its initializer, so mdio_phy = 0 pins the MDIO speed override to 10 Mbps
> and no data passes.
> 
> At the MAC/MDIO level 2500BASE-X is identical to 1 Gbps (same wide GMII
> datapath, same speed override); the rate itself is set in the PCS and
> SerDes, not here. This matches the boot loader's PHY_ADDR_4 = 0x32A4 for
> the 2.5G strap ("1 Gbps or above"), whose SPEED field is
> GSWIP_MDIO_PHY_SPEED_G1 (the field has no encoding above G1). Share the
> SPEED_1000 arm via a stacked case label. Its mii_cfg value is a no-op
> for 2.5G: gswip_mii_mask_cfg() writes it only for the RGMII port
> (mii_cfg[SGMII port] == -1), which cannot reach 2.5G anyway.
> 
> Fixes: 22335939ec90 ("net: dsa: add driver for MaxLinear GSW1xx switch family")
> Signed-off-by: Jan Havran (Advantech Czech) <havran.jan@email.cz>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

> ---
>  drivers/net/dsa/lantiq/lantiq_gswip_common.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/dsa/lantiq/lantiq_gswip_common.c b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
> index 0e8eedf64d3a3..6150dc3ffb641 100644
> --- a/drivers/net/dsa/lantiq/lantiq_gswip_common.c
> +++ b/drivers/net/dsa/lantiq/lantiq_gswip_common.c
> @@ -1339,6 +1339,7 @@ static void gswip_port_set_speed(struct gswip_priv *priv, int port, int speed,
>  		break;
>  
>  	case SPEED_1000:
> +	case SPEED_2500:
>  		mdio_phy = GSWIP_MDIO_PHY_SPEED_G1;
>  
>  		mii_cfg = GSWIP_MII_CFG_RATE_M125;

