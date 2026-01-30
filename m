Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D906374196
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 19:18:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769800737; cv=none; b=XTJrLVxIEd8sk3pALNLRmBEVCdWsx+I+Zf/D9qs4L+92yjJYWOsKvcIN8i+j0N8S88q0FLaXYV41JEQ+r8tQu/lh9exrOx1AZwbCfJMGwX68e1mm0dRgUbtlftyy5GZWjrs8yK1Yl2QYN3SI5s3QB6kPhRUHlV78pLtKLLQx4VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769800737; c=relaxed/simple;
	bh=2AhY+WzF0t3dfHKI/s7gCokW2fhsAvXVoNXQlUxnogg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=saydAxrCob41+NOogq3vmnq+3kE4Om5jRgUf5gkPfIQWriyHenvuIIiLizfiMsIO43mdIAMcvjJqdco2DfW9Vw5clYCiI4BCxZ5nUcI7L8dUR7Ic53lqQ+oZaARr/Nco0u2/ZfFcTWN/CGTnlqHM+T3OqAUIOv2D4mO+Y4FNA1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=NpZRguy8; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="NpZRguy8"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 49FFCC22F63;
	Fri, 30 Jan 2026 19:18:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id A3C8E6075A;
	Fri, 30 Jan 2026 19:18:52 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9CF06119A885C;
	Fri, 30 Jan 2026 20:18:45 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769800731; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Y4FPRRHG65/7gK1cs/oNVTykKIz42PNB3W+KzByRE1A=;
	b=NpZRguy8oaVdBEFrYrzUp16bYHyPP/N9L0XrejaRHGf3l3cNE/RsxCf7qX2IErg3JBOa9/
	L8OS1+gaSoEYt4BnHzcbFCSlpwnTSFZnw+2jFBiYhvTi77ZyhqRBBFTB0DGlM6+V0nDGyk
	mFF9+9DzhZCzliXBJ9GUnZIBHohfHJJ9FuukEuYqVfeurYbBteFLOHabFijM5hmD2+96jp
	OTl5YxhgJjtjJDnPXkyj/HjGopuZRXOHONy05Qc8jxEVrJiydrwUVZk8Q7laI2qY0Jz4Cz
	Z13S2xykO/dwa9BrBTHCaRmwiWiyrWMKxp3BaEAx0Ws+Hw1s6qHznp2cQN6+Bg==
Message-ID: <ee26c05c-a7dd-4334-b359-353449e50662@bootlin.com>
Date: Fri, 30 Jan 2026 20:18:44 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/3] net: stmmac: clear half-duplex caps where
 unsupported
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <aXyRlFw7ZuhRPiKo@shell.armlinux.org.uk>
 <E1vlmOQ-00000006zuz-0ffN@rmk-PC.armlinux.org.uk>
 <9dfdeee0-7758-439b-a2a5-a7f243427cf4@bootlin.com>
 <aXzzxeRsbnF8-nAq@shell.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <aXzzxeRsbnF8-nAq@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 30/01/2026 19:09, Russell King (Oracle) wrote:

> If you look at /sys/kernel/debug/stmmaceth/ethX/dma_cap, it should
> say whether half duplex is supported (I guess in your case it will
> be, it's probably very unlikely not to be.) However, would be worth
> knowing whether the if() is taken or not!
> 

Just rebuilt a kernel w/ debugfs support, and indeed I have :
[...]
	10/100 Mbps: Y
	1000 Mbps: Y
	Half duplex: Y
[...]

So looks like the if() isn't taken :)

Maxime
