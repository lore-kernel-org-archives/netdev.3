Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3512D4B8DDC;
	Fri,  5 Jun 2026 09:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780650025; cv=none; b=OYQ6NjwmW5YpV+NDcvD99Esu7ZXZLXdtdCHDKBwi767bQtyw7ZzBl2odFsYdx5k1ZTL8e4+MSUstKp8ubA25bTdED8N+Klke7MP7XFk7fjn6C3AGM0ch8YiXVLj1H6eyu1Kn1BErKQg8GXc0obBH/weGK8lxzzcwMM9eidwaaEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780650025; c=relaxed/simple;
	bh=r89H9S15LNf1u92s1hVry2+4aeX25Uc1aq13y9MAvaE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=VkNJ6wGvGsNBhgb6iQwg38Lyj1i2lXuIgEytfBAAGS9u+6p/vf3xEhhaYRdbHtUDHYH6jD1q2s8xbzXAuwt3QSZ07b5BJgiq1nmEOuiW9VolKrGBo/A4tIz+mZ50FqkqI4kEDzKwE5M2tha2CahLaoX/7Op+ubK8HcrGthv7VBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=iCfThAbE; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="iCfThAbE"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 03979A4B87;
	Fri,  5 Jun 2026 11:00:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1780650022; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=0JkL0R9l6WTXdKek/nYPLAftBEGUfmyc+5H3PiMLnVI=;
	b=iCfThAbEEiG0korY4CMJkLYYqHwCT7jjBL4Y95wl1c+IvcO/2JtU82p6r/fkYVLi4CQw6Y
	X2n8Dv/u21WLsfDwzAUkB9bDWyNe5q/aEdMWHYTDh9tZyEohXmXUe1RYWm+e60DGT3iOXC
	p3iXYd/fVnR1DpQB8twBefGaFWMD3GxMrGwY6SoeEVFlDYyIZIWmmBRcmMvr/03jCKnFy9
	ewWXULTMY43zFU6/zxgIrSIvhWQcLnD1JY8wZ9CyWR1MESfDcUDmsrZHoqXBdxAqoo39bf
	xKcSOE96rw2dC7f9EpqkvusfLgD1pGwVK9zYC0KCqWkowd4u5K0IQsKcgFaJfw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 05 Jun 2026 11:00:21 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: javen <javen_xu@realsil.com.cn>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, freddy_gu@realsil.com.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, daniel@makrotopia.org, vladimir.oltean@nxp.com
Subject: Re: [PATCH net-next v3 3/4] net: phy: realtek: add support for
 RTL8261C_CG
In-Reply-To: <20260605074328.1800-4-javen_xu@realsil.com.cn>
References: <20260605074328.1800-1-javen_xu@realsil.com.cn>
 <20260605074328.1800-4-javen_xu@realsil.com.cn>
Message-ID: <2d73152f762feddd895c1277a39dd5c6@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 5.6.2026 09:43, javen wrote:
> From: Javen Xu <javen_xu@realsil.com.cn>
> 
> This patch adds support for Realtek phy chip RTL8261C_CG. Its PHY ID is
> 0x001cc898.
> 
> Signed-off-by: Javen Xu <javen_xu@realsil.com.cn>
> ---
> Changes in v2:
>  - remove RTL8261D, only support RTL8261C_CG
>  - remove speed 500, rarely used
>  - add helper function, genphy_c45_soft_reset() and 
> genphy_c45_config_master_slave()
> 
> Changes in v3:
>  - remove macro RTL8261X_GBCR_REG
>  - remove priv struct and priv->sub_phy_id
> ---

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
