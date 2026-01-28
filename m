Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BFD257854
	for <netdev@vger.kernel.org>; Wed, 28 Jan 2026 14:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769609666; cv=none; b=UOduWIX9A+gaTgJGZdi/XNqT+XBiGAXkqKKAZOQW0AwW88U+kXj8Xf+vnxUGElwKP3anc6rymS/VZimtKTAozBfoSjXvraifh/7tDgG3PMYv9B7EISPBSY59GamPnFpGjZWIk60ZfUzUWF3pxnE7sJYG6uwzZ+jxYNiv0UmyvUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769609666; c=relaxed/simple;
	bh=thHZoccgzo0Z8mbgoN97xh8AVgqaaA0FgTYbFMh1viw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mZQWXjjTTph5+D337cbFROF9AXhYMSCWy3Ln6iyjPbb6LTEumlzM8ninE8FYWteh460LJ+q/dlR9NnL4Ytfl6wMGAuuNAPM784k2fBmUfcXEsnrIFQPPfm14Qs8vOIQnjs8PfBf2T5lhFOZ/Wo2Q6+VxdkKOWKJDhmvY70GXoaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RSrp9fJa; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RSrp9fJa"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id E095BC211E7;
	Wed, 28 Jan 2026 14:14:25 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 5C4BE6071F;
	Wed, 28 Jan 2026 14:14:23 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 99C28119A880F;
	Wed, 28 Jan 2026 15:14:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1769609662; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Ihz3yFLvfwz7g5/dljDb7S5GJKxmDcCGi9AFt75Q+Jk=;
	b=RSrp9fJa/M8eOIGibDfwPpaadNoi16B6bkrtuqA5ZPtAE4g2e/UKzzpRzeCh963tJORuh8
	u/QxqRnXt66s4pr0swCK5TfwUxtX3f45uO+4y3XTOb23vCAKIXtNtHwd6UWI0BPq9LKvXg
	1NHsw8jm4loW9Em7L9KTZRVCo7FI1Tc93TeDB1ny9EQTlMW9U+tzNid+SfIDwtkwQ6jxOq
	vDWtD81O/76sh/ZvVe1VpG2x/dnDfN4vbck9Z+sylp2H53tsu4kTBuW0OLIRVCDG1w0MsE
	ZX3hST/ttuB9nRFIGm3kVbJA96HU/u/Khec0UciazKPeAD8CsKiZAllGu654aQ==
Message-ID: <b1971281-2df1-4f61-9a66-9caa9ee187cf@bootlin.com>
Date: Wed, 28 Jan 2026 15:14:15 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: stmmac: report active PHY interface
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Drew Fustini <fustini@kernel.org>,
 Eric Dumazet <edumazet@google.com>, Fu Wei <wefu@redhat.com>,
 Guo Ren <guoren@kernel.org>, Jakub Kicinski <kuba@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-riscv@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <aXnpTy6XckPGcmg0@shell.armlinux.org.uk>
 <E1vl36F-00000006url-1fWA@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1vl36F-00000006url-1fWA@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 28/01/2026 11:48, Russell King (Oracle) wrote:
> Report the active PHY interface from the point of view of the dwmac
> hardware to the kernel log, where the core supports reading this.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Tested with dwmac-socfpga on CycloneV :

RGMII interface : 

[    0.898925] socfpga-dwmac ff700000.ethernet: Active PHY interface: RGMII (1)

1000BaseX/SGMII interface connected to Lynx PCS :

[    1.003223] socfpga-dwmac ff702000.ethernet: Active PHY interface: GMII/MII (0)

Nice.

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Tested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Thanks,

Maxime


