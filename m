Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6776267B89;
	Fri, 12 Jun 2026 01:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781226726; cv=none; b=bOqjA2Re/Zajyf9GR+8o2X3SvxoBiepxa0kNR9dqZA3qIdJ7PpXBtUpyUfYABtvjgYHZ4uP+2pFWgmZEeKmSusQe+/nqaxObmjy3h2eFJ7VZ2myjQobv+NYxWEzQlRjr+xREUBSAafywQQSCYqsB35amxg+gqcdxXZs+NOjq11k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781226726; c=relaxed/simple;
	bh=0s4x7I06JjDpHHL/AdHXiZ4kzNM1jephCdY2qRIIitc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Qhu6MpBRZVoiYbM0tLBiVIlK4zteT1UYFjW3Hrh6ISD36bV7CLmpAZA+yuGWkHqwOB27OEkAx5+RiDvGEzRXczHCJJl2BIfIJAX0QuZt6aRa1qOa+KyRB6IS+lPU9yLmRqFV+VZDwrMd2qhcRz1WS3KIuo+pprHi1GWi8AVsUqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=XsOzRLD1; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="XsOzRLD1"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id BCAE411722C;
	Fri, 12 Jun 2026 03:05:25 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1781226329;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=p7aILJyBYzvssioO/gJwVHbLCM0FoSbqpMKyKJJ9KK0=;
	b=XsOzRLD11Nw+clXacI4w774mqlkmkGkNXOMdT5jvC2In+rWsLUUiIsfptLbrMljM02vFbq
	GpAUsL1X0lVWcwMgTjJj3+oZm6//G6QGBnD28q+zhFvwRkQ5g2zdajuJZZ7MIhLAdKjCT2
	e1xSjXI1b/hRofsV7bLYrg38t14l03jukpQ5kzsUNekbJ9axC+BoO8dKEmL8PjtLabvSgG
	RSutQds9PzFbqF19I9XCuEbCtVGe7tKoBKbqB6Ep6ezVajwMO3Poy2ybokQCpZY54543dE
	aZzbTa9DliLlgsGDQh2yQ3NCo/vIcgU3e4zKyhMcXYB625I8h3d5mCrkbIIhvw==
Message-ID: <8d9fc953-0c59-4811-8273-016ba98089a3@nabladev.com>
Date: Fri, 12 Jun 2026 03:05:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v10 0/3] ksz87xx: add support for low-loss cable
 equalizer errata
To: Fidelio Lawson <lawson.fidelio@gmail.com>,
 Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Marek Vasut <marex@denx.de>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Simon Horman <horms@kernel.org>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Tristram Ha <Tristram.Ha@microchip.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Nicolai Buchwitz <nb@tipi-net.de>, Fidelio Lawson <fidelio.lawson@exotec.com>
References: <20260609-ksz87xx_errata_low_loss_connections-v10-0-9ba4418cf3db@exotec.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <20260609-ksz87xx_errata_low_loss_connections-v10-0-9ba4418cf3db@exotec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 6/9/26 6:19 PM, Fidelio Lawson wrote:

Hello Fidelio,

> This patch implements the KSZ87xx short cable erratum
> described in Microchip document DS80000687C for KSZ87xx switches
> and the following support article:
> 
> Link: https://support.microchip.com/s/article/Solution-for-Using-CAT-5E-or-CAT-6-Short-Cable-with-a-Link-Issue-for-the-KSZ8795-Family

Have you also submitted the ethtool integration already ?
Is there a link to a patch for ethtool to operate these PHY tunables ?

Thank you for your help !

-- 
Best regards,
Marek Vasut
