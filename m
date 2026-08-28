Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEF6C31B823;
	Fri, 28 Aug 2026 08:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787905231; cv=none; b=RMT6qBEiJTOV78tCklcovWAiAJVwv2HcnWJYu+W+2XNema5Eky0SwBc5ANGjxbDLh6Zwm1IAdNqAoz71UXy+Y42JJtpcTxV8EwnXeiIQSjN6byS5hqJbeB/oA5L6+CuewE/mBumx8H/JoIUnIx+7e1DYi8H1cfLMyuD2GSbAKxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787905231; c=relaxed/simple;
	bh=j73TnKN5nPpi1Biqrlh5q/TP4tPlT04om4vbQdH+2Ro=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=VBPuZf8u7t/M8WEOn3vuXN9m94/mbRXS36prEVLR73du+uMGjArbf0//QlMi8zhJo8MNsHEVPdpfIiX/6Emqp6OcA1YNw71RpXnyrUPjk3YLLwjfotpLVTLQjAhAYYb6udeCSxRbdyb7rKYxf2dDwsyneTaSQ7u8vl7dCmp5HT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=5gRPDWnv; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="5gRPDWnv"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B0A5DA3A03;
	Fri, 28 Aug 2026 10:20:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1787905225; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=tjXzZl6nwP50ndxWm0tX5ANNxnYFPedXQtlKP3mbka4=;
	b=5gRPDWnvG0CRX1RrLl+J1yARxyo5GUBaPcS8JVo8EWvs16M7n06dER7VROvYEJAMv99+Jg
	+F3X6k/mv+APEbXebDdVSg/hG+f70bGzKF9Z1LbdbTMUfHMPl9tW2NCcOvw8WF4bZEtsSo
	rmRKDDpvNPWGfX75/OC1/YPAAAX/5QUCg9laI4BCnxwQVpTfoWfLRDnbB97v12BfsjthRS
	x+ZUEV5GotWsPLFuRQBsBLg2d3kMw4/7b9LtiZoS6wV436N8dZc2C8VIWgiYCTeIIVQh2q
	V6W/EPOfbMlbmW9UbSNyh4wkHRTW88vLj1t3wJf9HzfPZF2bGe+aY40DMuFzKQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 28 Aug 2026 10:20:24 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, Conor Dooley
 <conor.dooley@microchip.com>, Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Jonathan Bell <jonathan@raspberrypi.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Richard
 Cochran <richardcochran@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: macb: exclude software FCS from TX byte
 statistics
In-Reply-To: <20260827115601.6bf0b18a@kernel.org>
References: <20260824134703.766708-1-nb@tipi-net.de>
 <20260824134703.766708-2-nb@tipi-net.de>
 <20260827115601.6bf0b18a@kernel.org>
Message-ID: <36165fe4a906b07dd9f92a73a72a05f1@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Jakub

On 27.8.2026 20:56, Jakub Kicinski wrote:
> On Mon, 24 Aug 2026 15:47:02 +0200 Nicolai Buchwitz wrote:
>> + * @skb_len: skb->len as handed over by the stack, before padding and
>> + *           software FCS, only set for the last buffer of the frame
> 
> counting pad bytes to ETH_ZLEN as sent is perfectly legit,
> it's a driver preference. Some don't because HW pads and
> the driver doesn't want to bother adding a conditional.
> But it's best if the driver bytes match wire bytes IMO.

Matches what I had in mind for my v2. So the driver bytes would match 
wire bytes minus FCS.

> 
> Either way, you only need u8 or even a flag for this,
> not a full u32?

Agreed. skb->len at completion should already do the trick (minus 
ETH_FCS_LEN).
So a flag would be sufficient.

Thanks,
Nicolai
