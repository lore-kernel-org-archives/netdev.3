Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BE1E25392A;
	Tue, 21 Jul 2026 16:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784652993; cv=none; b=j3yqI9er1Z1uY9DsE41T36QnQ3P2uJ1ITc7Zo+tzYxxvgaETIjuyw3T/zKOWnuGDMlfnOXoiPBatlOfFRZsLyB1Kb9ZsKUS0GHaQel67AkqVeZ/psplU7tCcuwvXl6JS1kxGMVM55udJS62eYQxZ3oXbXameVfUnDND9QQawu+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784652993; c=relaxed/simple;
	bh=OcLEASZqzXC/ec/Vtd5ntT3hIJ6NsImbJ9818xME0TQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pzJ3hpGI/wZCBq5FiIVUJ+eW+IMfDZUCYWkJXqcEpUzSSqZq9t6AwZ9jqRJq+NZRCOSeGmaE1QDQaP1XvZzjGzbzgRyABLq/Nbiru47JhZ15iIh9FdF7dydO5AaaOVMVK6OfZRY35yCR/gw0yEid2cEq4ePaG3gvNSQ3RbP2u9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SZ6IIp9O; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SZ6IIp9O"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id ED20D1A1144;
	Tue, 21 Jul 2026 16:56:21 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B802A60368;
	Tue, 21 Jul 2026 16:56:21 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CC35411BD065D;
	Tue, 21 Jul 2026 18:56:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784652980; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=9pv9SMUYZxYtOR54qIKr4ZEfmnQ4N8zEKpjbxfSE8XM=;
	b=SZ6IIp9OeT2QQW04KZo5K/cLsCO29ps0O0TO7dJJaps4fqZ6Vz+PBPWebQJGcSeZySX4i5
	5v+pt7vNhwwnXW6zoeOFbQhzSqkcc92LHGwuHmmttAVueTHb1cuSRf0VNcIkpd5jvIv9Xl
	wz+/N6SUByqtABcYZ0JwF8UrtRODFHjEbv/wrmuEvQlwWc68hUPLwz67nCuSqm1t2aaFLN
	bAe8vGYEFpkIMANeWc3W4RZlu1VyCtkEtnJvV7rKtjJ7Wq/5oxVnNaJHbLPjxzed8RHJIq
	YQPtSdteRz/OAl67qEULSSbwM1QtmBWTEoTFQmcmucUdAsgpBYWPxlOpzY5qkA==
Message-ID: <83806c45-ebec-456d-9a48-76bed6bde8eb@bootlin.com>
Date: Tue, 21 Jul 2026 18:56:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] net: stmmac: Simplify ioctl handling
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, davem@davemloft.net,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Russell King <linux@armlinux.org.uk>,
 thomas.petazzoni@bootlin.com, =?UTF-8?Q?Alexis_Lothor=C3=A9?=
 <alexis.lothore@bootlin.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20260718143848.677531-1-maxime.chevallier@bootlin.com>
 <20260721094245.1b6aab2d@kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260721094245.1b6aab2d@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Jakub,

On 7/21/26 18:42, Jakub Kicinski wrote:
> On Sat, 18 Jul 2026 16:38:47 +0200 Maxime Chevallier wrote:
>> Now that timestamping is controlled through an NDO, we can simply
>> call phylink_mii_ioctl() to handle ioctls.
>>
>> The only functional difference is that phylink_mii_ioctl() ->
>> phy_mii_ioctl() can handle SIOCSHWTSTAMP, but this no longer happens
>> as this ioctl is not longer dispatched to the ndo_eth_ioctl().
> 
> To double check - the discussion is orthogonal and this patch can be
> applied as is?

Indeed yes, the patch itself doesn't introduce any behaviour change.

That's actually when I noticed that it doesn't introduce behaviour changes
(as the SIOCSHWTSTAMP ioctl is masked and doesn't reach the .ndo_ioctl() in
the first place) that I added the small comment that started this discussion :)

Maxime
