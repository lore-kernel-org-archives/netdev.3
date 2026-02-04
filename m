Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 857C338F225
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 09:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770197996; cv=none; b=HAnX68OJBKLfemlx3J8Xz4Kkhe3rhPOZr8JHsZznubJEvRN5xEC2gkqrzdvb71sRHy/jRdX0Dmg1w13qp3t7Qfev2lRWtFZKI0kdHmYT9lOps3Od906V9Xr/zHtNr0s2KK1nE+g7DW6anA8oWtcX8HkY6feTZV8k1rwf3eTkyNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770197996; c=relaxed/simple;
	bh=C+CMoSHbsVVkKpQx4qWlMSQu8EpXpFjp4jsH5u0O0/s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k63eqGdTZti3CaAq0ycQgiPtruG4bL4NXOvB4EWd2ULugS+bCX5KxgiY1s5NMST9CgqfEvjCePHDmiIEDWyfBIQs2cVlCPK85WaHbKos7+7rSM+aDbseH9hNu42YPXF9Qqfw7DLxHqSmGlz6BahKiu+0whCWeN71BsnL3h2PgH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=wvDQQR6D; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="wvDQQR6D"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 1849E1A2BE7;
	Wed,  4 Feb 2026 09:39:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id CAE3F60745;
	Wed,  4 Feb 2026 09:39:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 383D8119A865B;
	Wed,  4 Feb 2026 10:39:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770197992; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=AI/nHMuupilMGKzkZo1RxmEdDDqp05ziOca4mFkFe7Y=;
	b=wvDQQR6D3NBroTTsWxi26R4kPW+9aio4FhNW0rwmIim2KruxF+sPRmVT4VjQMLunA4Ibib
	ltTV/uFCBVhpL8x4kz4gfGY9u0v4AW9gpqgOrDWYYHIlnOqYqtvKuftqQUS4RbjYmT/yK0
	YjU+xglnARFA//o6JyluxbffW0afooKLZrSdVH7axblBGwwbUMOzMgg9CjdpiVdF6S7CvI
	zrFis9TzJqvk9ldNxb6CWAZ3dOGtzx2YkTil1S5YBWp65e4hwT9gARCalzPhbxqHTyeRru
	eilPDcA5AuI3ynI3GOD37z3IgND0dxrW21HaURKjOwfIbAc5H0v3nSodWyPhow==
Message-ID: <5935c13a-04cc-45a7-9b71-3ebd821f2043@bootlin.com>
Date: Wed, 4 Feb 2026 10:39:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/6] net: stmmac: rk: introduce flags indicating
 support for RGMII/RMII
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Heiko Stuebner <heiko@sntech.de>, Jakub Kicinski <kuba@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <aYMN2gZMfLPKuukG@shell.armlinux.org.uk>
 <E1vnYxl-00000007hol-3XiH@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1vnYxl-00000007hol-3XiH@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 04/02/2026 10:14, Russell King (Oracle) wrote:
> Introduce two boolean flags into struct rk_priv_data indicating
> whether RGMII and/or RMII is supported for this instance. Use these
> to configure the supported_interfaces mask for phylink, validate the
> interface mode. Initialise these from equivalent flags in the
> rk_gmac_ops or depending on the presence of the ops->set_to_rgmii and
> ops->set_to_mii methods. Finally, make ops->set_to_* optional.
> 
> This will allow us to get rid of empty set_to_rmii() methods.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

