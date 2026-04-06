Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FDD3081A2;
	Mon,  6 Apr 2026 20:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775508260; cv=none; b=aF6wd3NSQv4T+MWhS6nDgJRAHNbJKLIu2TT8XQK6Ymfe7qRMEUt2cUXIfZiqqYF4OKyYNtPGUHSxxVhXwL99odb6e4CyxEviQVNnlDJ7Fmy7toCV1/j1CFAmkzTMdDX6PvKO5Pe8Ssop6JLXfOkDWq2koLU3gLMklWxLuFkt3pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775508260; c=relaxed/simple;
	bh=jxBp+7pRw0uh1SfkSMJic8U5vJTvRYE92lUFN5CgATQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=YjOGQ0lAkldFAh2s2OTVNj0/taM4N3PFqOAz2jVw0hVdGvyljmhqaa2EgzMCNXEgLJ61BAOiPwp4kGwZxNh5kyQrjSO/5GMXtt9KlN8q5qgGhCQsn5aqfG11+SqkkDQmNm/Dn/1JWKWb0DhcRW0r6xoBFwvYIYDz5kpOiXzr57c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=tMgMI5kK; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="tMgMI5kK"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9CAECA589C;
	Mon,  6 Apr 2026 22:44:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1775508253; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=pYINwFQq1Bof3Q8VWigTklDWeFFBvhA/aGERIAtLivM=;
	b=tMgMI5kK4E5fQYavrJ6NNsjjYjXg9cOmSbU2s1/zJdxaP6ZEyZ8EJOw2Rl78IupZNq9yRn
	rHH0jwC0XTHtMsvOebNqiwaCkxzwzTbjfI1lPj+MdCKH5F1bE36OCK7rAfG+NEYRLRWgP+
	H7lHWbufC5IvD+XxUUDvdzSEUOP31y+fNzdURPr9gSGcabW37rm44M26iGdz8W4ak6nAcQ
	FWvAjQv9lkb8KuSDNA3HYNjnhif6QPqs4qulSEA6KdECK9HcK1nV2venM0MXK966ofJwh8
	s9ST/uAzTTD3KiTHYMel88IPcc7EZZ+9pFBy3qj2iDs9p9iOGo5i7Pmv6CT/ZA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 06 Apr 2026 22:44:10 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Aleksander Jan Bajkowski <olek2@wp.pl>
Cc: andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, daniel@makrotopia.org, vladimir.oltean@nxp.com,
 michael@fossekall.de, markus.stockhausen@gmx.de, ih@simonwunderlich.de,
 rmk+kernel@armlinux.org.uk, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: phy: realtek: get rid of magic numbers in
 rtl8201_config_intr()
In-Reply-To: <20260406201222.1043396-1-olek2@wp.pl>
References: <20260406201222.1043396-1-olek2@wp.pl>
Message-ID: <bfd0b7c94c9bda4e8fc5789ce7b3fbee@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 6.4.2026 22:12, Aleksander Jan Bajkowski wrote:
> Replace the magic numbers with defines. Register names were obtained 
> from
> publicly available documentation[1]. This should make it clear what's 
> going
> on in the code.
> 
> 1. RTL8201F/RTL8201FL/RTL8201FN Rev. 1.4 Datasheet
> Signed-off-by: Aleksander Jan Bajkowski <olek2@wp.pl>
> ---
>  drivers/net/phy/realtek/realtek_main.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/phy/realtek/realtek_main.c 
> b/drivers/net/phy/realtek/realtek_main.c
> index 75565fbdbf6d..e78f3b9e89db 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c
> @@ -22,7 +22,14 @@
>  #include "../phylib.h"
>  #include "realtek.h"
> 
> +#define RTL8201F_IER_PAGE			0x07
>  #define RTL8201F_IER				0x13
> +#define RTL8201F_IER_LINK			BIT(13)
> +#define RTL8201F_IER_DUPLEX			BIT(12)
> +#define RTL8201F_IER_ANERR			BIT(11)
> +#define RTL8201F_IER_MASK			(RTL8201F_IER_ANERR | \
> +						 RTL8201F_IER_DUPLEX | \
> +						 RTL8201F_IER_LINK)
> 
>  #define RTL8201F_ISR				0x1e
>  #define RTL8201F_ISR_ANERR			BIT(15)
> @@ -346,11 +353,13 @@ static int rtl8201_config_intr(struct phy_device 
> *phydev)
>  		if (err)
>  			return err;
> 
> -		val = BIT(13) | BIT(12) | BIT(11);
> -		err = phy_write_paged(phydev, 0x7, RTL8201F_IER, val);
> +		val = RTL8201F_IER_MASK;
> +		err = phy_write_paged(phydev, RTL8201F_IER_PAGE,
> +				      RTL8201F_IER, val);
>  	} else {
>  		val = 0;
> -		err = phy_write_paged(phydev, 0x7, RTL8201F_IER, val);
> +		err = phy_write_paged(phydev, RTL8201F_IER_PAGE,
> +				      RTL8201F_IER, val);
>  		if (err)
>  			return err;

Matches the datasheet (RTL8201F/RTL8201FL/RTL8201FN Rev. 1.4 Datasheet)

Reviewed-by: Nicolai Buchwitz nb@tipi-net.de
