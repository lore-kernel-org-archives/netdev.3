Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ED030D406;
	Mon, 12 Oct 2026 13:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791811217; cv=none; b=hmV1duc4JH6OPCBeT3lTyGJMhuIpOK5zE5OS7+sbGYAWuLDOYjX5I6gP0AdZDdPYciy0jkjds8Wg18CA2lV+ANT5CgPwhX9813guhWTKcSkZAn1smUd72WqQtr8U9NcQXtOnvmaxEcKeXHSaGa9Ckx3UC6eLLSW+2RSuHorywdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791811217; c=relaxed/simple;
	bh=1ENi5J5rt7KxBWBq2bc77PZ+7B8wl+ffh4W+6JEOUbs=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=jKYyG0H8UHAHxiStqygJDWDjbiLl326tlfTeGyUmScGyqj05cionfMbWCFAC7sCa7CtmXS4SGM6YyvB8H3tOB8orvXse1oBRHs2W/thsRqE2aO+JMHYwLDx2X6aZJaeenk8sGciM1BuAypbbEgLDK8bLHGBdaKhx+tfSdQBIIwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=If3rLa11; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="If3rLa11"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 29C55A104C;
	Mon, 12 Oct 2026 15:20:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791811212; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=kL74KTELdJcvwFeoVvsKs4SgTL55cgLcLAQcQmzQeMk=;
	b=If3rLa11534LQabEQnytRmSS+bK1tlWpm6sIfxIdigedZjHJryMw911aqdm43ARJbclS5z
	9lsBd6uH3qKof5d2SlZONVKAecM6jywf4LwDLfO2HTPUHwZ0hWMbjWCZzHnAlAn9liHc1C
	EkysMBxzYL6fu4hKmJzXJdGMNLDR78SIs3HtWZu//pek/hOgHGANIO6jNMHlUtWRCtloY1
	MgneBCYDWw+476Y4iHWQ8n0ZCaOe9rjWq2LDG/nUMKOCa6WVFf5e+Hn0chiZ7Jb6zMuQqL
	ijc+rezCWpe0+xONodGQBbELHr4nZU9tJdiG/vgd+T5YH+GE6IRmgPhHqv4lyw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 12 Oct 2026 15:20:12 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Andrew Lunn <andrew@lunn.ch>
Cc: James Clark <jjc@jclark.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Heiner
 Kallweit <hkallweit1@gmail.com>, Richard Cochran <richardcochran@gmail.com>,
 Florian Fainelli <florian.fainelli@broadcom.com>, Doug Berger
 <opendmb@gmail.com>, =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Russell King <linux@armlinux.org.uk>, Conor Dooley
 <conor.dooley@microchip.com>, Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, Thomas Gleixner <tglx@kernel.org>,
 Miroslav Lichvar <mlichvar@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/5] net: mdio: add timestamped MDIO writes for
 PHY gettimex64
In-Reply-To: <23454c46-95cf-4e46-9621-149bf9350199@lunn.ch>
References: <20261009143506.2507607-1-jjc@jclark.com>
 <804e7c63-e762-4040-9d60-35d21df75531@lunn.ch>
 <db3a0f73c1883645f51294ca46cffe05@tipi-net.de>
 <23454c46-95cf-4e46-9621-149bf9350199@lunn.ch>
Message-ID: <fe327be3b259312675284fbacc323631@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 12.10.2026 15:18, Andrew Lunn wrote:

> [...]

>> Pi 4 and CM4 (the one with the PTP PHY) have no clock-frequency, so
>> the driver keeps the firmware's divider 9, and 200 MHz / 20 is the
>> 10 MHz James mentions.
> 
> For CM4, i think the PHY is on the board? Does the MDIO bus get
> exported via a connector? If it is a closed system, then running the
> bus faster by default is O.K, since it is impossible to connect a
> device which is only standards compliant. But if the bus does get
> connected to the carrier board, it would be better to stick to 2.5MHz.

Yes, everything is on the same board and (unfortunately for some of my 
use cases)
no connector / possibility to use MDIO without the default PHY.

Regards
Nicolai
