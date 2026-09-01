Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76E1E20D4F0;
	Tue,  1 Sep 2026 06:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788244658; cv=none; b=Pind8jHt8qw9H8jE70WITHglsjU/rUi+esGqrlltLxRTj2ZwpR2nlv432PIOoDNgmwBDygSd1nhRUlqpGU8TBDLUyz+xPrw9E2Od5W1y9Q+8XoN7TzfstOUafo6PFVbUEQ6vUxVlfF4WcPdEsQXH9xhrMmvo9Uw10EaaWimTA+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788244658; c=relaxed/simple;
	bh=iL5A9QQRXgUaacj2Ni94JENTk6pKl8l63Y+aZnPBc/o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m42hNTskKLRjAKnJwZR/FUCp+CmZEGM63vfBdUSGp9jIakjp4J7tVWaW3h+tSF/loXcl4GKpb+D6367YzL0vo6zY85uZ8RM5oZHXZdsOhZ4cdEnjhqCcSzCvqNs6TaowZg3hu/wxj/u2JfLm9q7Ywp3dzh6TG2qpXRqA+Nfk5qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UOuE6lU4; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UOuE6lU4"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 6CCAF4E4148D;
	Tue,  1 Sep 2026 06:37:33 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 388616053C;
	Tue,  1 Sep 2026 06:37:33 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CD25211C7923B;
	Tue,  1 Sep 2026 08:37:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788244648; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=nKEypurhbn+A/hhYrWpuIDicafbAr2+ct/5OlPU0wvc=;
	b=UOuE6lU4zg3o1KqkkQJPmyZu+5/Xwr2pHDItPy9EIt0atoE1KpyHORRD0EEMMLVO9IH44m
	EU1j9R4FamRgFSQMZCI9OruXFl1JLl8c4Jpez/PS5gBTU4XCuV0Q8VjTtmpmno0oXIEi6F
	EiiCN7UhAoJ9rG8eRp+8WGQQq1g3GITZi51AeebSo0reyrWR/wqmPcBWDGJQq8Z15/m4XS
	l+FTpbyXGOH9G0wgt1ueGeieFUKjjOR801jA4g4YEcprsEs0Ce+z7G9PaLEIT3tDRxXDYo
	sBqcjevFau9ZlcfxzD2/iecNRvmzFjTWbAPWHHAMzDLVbGQotRSGuZfKqQWqyg==
Message-ID: <493afde2-8603-41e8-b6ce-f8e399c53275@bootlin.com>
Date: Tue, 1 Sep 2026 08:37:20 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: stmmac: dwmac4: Use the full perfect
 filter ability for UC filter
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
References: <20260831070121.349778-1-maxime.chevallier@bootlin.com>
 <20260831070121.349778-3-maxime.chevallier@bootlin.com>
 <285c8969-2f0d-46de-b098-60ff10f30cf6@lunn.ch>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <285c8969-2f0d-46de-b098-60ff10f30cf6@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 9/1/26 02:12, Andrew Lunn wrote:
> On Mon, Aug 31, 2026 at 09:01:20AM +0200, Maxime Chevallier wrote:
>> Contrary to dwmac1000 that gets its number of perfect filter entries
>> through the 'snps,perfect-filter-entries' property, dwmac4 allows
>> reading the filter size from the HW features registers.
> 
> Does dwmac4 take any notice of "snps,perfect-filter-entries"? Should
> it be marked deprecated?

It's only used on :

  "st,spear600-gmac"
  "snps,dwmac-3.50a"
  "snps,dwmac-3.70a"
  "snps,dwmac-3.72a"
  "snps,dwmac"

So, dwmac1000.

I'd say, we can definitely deprecate on IPs that don't match these.

Interestingly, there are _some_ dwmac4 devicetrees out there that use
this property. It achieves nothing, and even worse, doesn't match what
the HW reports :

In arch/riscv/boot/dts/starfive/jh7110.dtsi for example :

gmac1: ethernet@16040000 {                                            
	compatible = "starfive,jh7110-dwmac", "snps,dwmac-5.20";
	[...]
	snps,perfect-filter-entries = <256>;
}

To my knowledge, 256 isn't even possible, there's only 128 MAC address
registers available :/

perfect filter size discovery on real HW says there's on 8 available,
I haven't measured the actual size of the filter though but it seems
more plausible than 256.

Maxime

