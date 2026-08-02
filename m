Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79A15330B01;
	Sun,  2 Aug 2026 20:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785702582; cv=none; b=IIGivMBii50QPV/rKGLQ6jA86jyBrF6oGcBz1nHX4607Dz8eNpH9WO7JXXX0adeGKpaHkEuNCxouQ59crrtSiXtkYRu1ppgl1uM4aUqnBsTfp3W1Q8BvItY97ceXes2w1Cs1Z5DoQ5NnH3LaCSfqlspgKNmFVcswiY1MrSWZCaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785702582; c=relaxed/simple;
	bh=j/qnisZo7vXZsAMvvAJfrAw1ufzzSgviDPikJR/yof8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZTbfNd2cVLQeBtBOspn79n8hWK0OrXU8JZS8ce66gYsoFwW9hseQns3QxqryFK4HPuvssgaOcLNEAx6QydvNd6z1eoREvqlFH0vq08RN9iMvgd6us+0GtbMxWKT8iuMcLHA9dS4nFsk6WT0KSElQf9HpNX14VMg+UBzV97GFmY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jOih4Cbk; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jOih4Cbk"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 8A6CA4E410B0;
	Sun,  2 Aug 2026 20:29:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 466906029B;
	Sun,  2 Aug 2026 20:29:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0F5CB11C1786D;
	Sun,  2 Aug 2026 22:29:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785702571; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=ese7NYKIqP4YMH14PHh8lmNgkBXMS5Kp6vJnbvuy/80=;
	b=jOih4CbkXugJF6FC6RbTX5XB3kv6TO+ZxzBEzAb+mdJ3dJvGOBsZ1AHWNSmJn/W7Qn3tRG
	eswvecQAkpQxkjgvFNRsfxWsCnKK12ohDFrsfobUp+eZeLz3ik5ymkDomBYO6aHvr3KGuS
	IM0KzU9qCYkp+MDN89+xwfKTWS44KLTdqgNHoP6uH65FDZxCdxFPxbA6t0ehr8Cz6Wp+AT
	+h3xPNyXcYmX5BTwceeLv3wOUTMA9Slr3PnGlenxfjXyTwqZ+CCyBkWF1ODqShPSD5YGEL
	8absHHEBqga42R7Jm2pDx5/4e74/2X9W4LVHhcUFzE17aYx8frrKKrD4pA+klQ==
Message-ID: <5f2f0e3c-cc4e-4110-ad4c-180abba5356d@bootlin.com>
Date: Sun, 2 Aug 2026 22:29:22 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: stmmac: ethtool: Address off-by-one
 when reading the coal rx-usecs
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Russell King <linux@armlinux.org.uk>, thomas.petazzoni@bootlin.com,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20260802114015.214212-1-maxime.chevallier@bootlin.com>
 <20260802114015.214212-3-maxime.chevallier@bootlin.com>
 <4e76d7c1-0052-4689-be7c-9c31dc24516a@lunn.ch>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <4e76d7c1-0052-4689-be7c-9c31dc24516a@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Andrew,

On 8/2/26 17:05, Andrew Lunn wrote:
>> This does change the boundaries of accepted rx-usecs parameters, as the
>> previously accepted values were in the 16-246 us range, and now fall
>> into the 15-245 range on imx8mp.
> 
> With this change in place, what happens when trying to set 246?
> EINVAL?

Yes indeed :

# ethtool -C eth1 rx-usecs 246
netlink error: Invalid argument

Maxime
