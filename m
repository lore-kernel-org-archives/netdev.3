Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B42F3E8C74;
	Fri, 11 Sep 2026 10:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789121142; cv=none; b=Tai2B3MoOrIwa1L2G8wfrYYf5uOWTLl/6jMnDalRX9ICW/qP/C9+nVd5uHMFHNBHEzgK4ybfBUmdXsc4wFspHyEM7qSa9e8OwrBMXAu1VrPV1VzddfUA5ZiV/3bqHq4gEvzLMctrnHT0+llaTKvClovyfGiEbR9y/EFpCGGQSto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789121142; c=relaxed/simple;
	bh=s9sEJ6VkNy4LnIwySs6hZhG87RYcsS59KQwQRuWZs4I=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=OgMOH2tTbmeofSqyRLeVSqmJv0AuNcNnausL70oxSV+8FqH5/l7DkSWCJuNYRLS1g4c/Iw3s7fQbSZ4U5NuJSzWlxDWyJ8ObLFnFWP8rFogdVuMjetsgkJD1QU33+gJadLuLH+CWxyX2W6ld8zFHlknaJ788jc/qmdCNw8nspok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=wwYzeqDe; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="wwYzeqDe"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6D2B0A0580;
	Fri, 11 Sep 2026 12:05:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1789121137; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=5iICex6txoAZiaKXW04b4lDCW3h8pJjsouZmJMQWVY4=;
	b=wwYzeqDe4/TknzC1RYnb6Fk67FzTFvZHK+NVRyz7bZCRosBC8MjrtOuj26wjlq7O27zDHd
	gyTUi9peAIxblrpNdo8RTmFCh52aDPBfEX3KeDkA5OY2/4trXokBn1J/c4w4+Qm1eG7WGG
	h6BdLxFQ7ITJQi1xHj0a3Y/uy9cMlKhqwBngTZAUwlxs0/iJcH6IY0bwdXddYR8V6e0Vc/
	GQ13B/um8QKUOVTOsredpQKg6mKSOUr5ZOc79FsBhX/2qbvuxx0L0mrKQx0OqBCSPo5Owe
	2fPeltWI9UmP/5kFAX5wzNfJ8nhnUMa4m+BT/RkJjNv8eslCQFcqIXS9s9T4ug==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 11 Sep 2026 12:05:34 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: javen <javen_xu@realsil.com.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, freddy_gu@realsil.com.cn, maxime.chevallier@bootlin.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, daniel@makrotopia.org,
 vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next v2] net: phy: realtek: improve firmware write
 speed
In-Reply-To: <20260911094527.1928-1-javen_xu@realsil.com.cn>
References: <20260911094527.1928-1-javen_xu@realsil.com.cn>
Message-ID: <9a85b0151eb87df26c69c507bdccbae7@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 11.9.2026 11:45, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> Firmware execution routine unconditionally uses phy_modify_mmd() for
> all OP_WRITE entries which introduces an unnecessary read transaction
> when updating an entire 16-bit register. So we optimize this by
> checking bitmask boundaries. Use phy_write_mmd() directly to speed up
> firmware loading process.
> 
> Benchmark number from tracing MDC/MDIO hardware transactions during
> firmware loading process:
>  - Unpatched: about 28,000 MDIO transactions
>  - Patched: about 9,600 MDIO transactions
> This results in an approx 65% reduction in MDIO traffic.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
>  drivers/net/phy/realtek/realtek_main.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/phy/realtek/realtek_main.c 
> b/drivers/net/phy/realtek/realtek_main.c
> index 27e31a799e2c..97b0b67b9900 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c
> @@ -548,8 +548,12 @@ static int rtl8261x_fw_execute_entry(struct 
> phy_device *phydev,
> 
>  	switch (entry->type) {
>  	case OP_WRITE:
> -		ret = phy_modify_mmd(phydev, dev, addr,
> -				     GENMASK(msb, lsb), (value << lsb) & GENMASK(msb, lsb));
> +		if (msb != 15 || lsb != 0)
> +			ret = phy_modify_mmd(phydev, dev, addr, GENMASK(msb, lsb),
> +					     (value << lsb) & GENMASK(msb, lsb));
> +		else
> +			ret = phy_write_mmd(phydev, dev, addr, value);
> +
>  		if (ret)
>  			return ret;
>  		break;

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
