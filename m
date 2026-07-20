Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86553D75C4
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 09:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784539998; cv=none; b=GKlM9hUoCTcGbv7Fnmha12h7hbsiXK8NQvtEGK4ye4aZgMK9FqSYBN8xud7NY853kR5p7qecfRDnNfFoaHV9+LKNK6Tz2JkgsRkRfgrP9Q80fy0E9CA0PStl2oyHqSDAa/Jq2KJb+7L1st21gnkwKEJ1zvFdhkB4/8CIyzBSh9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784539998; c=relaxed/simple;
	bh=AJsT6yt24aehDoQOd5ntSHWVvQrwTxU1fX9ksnkaKVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IX3R58W1lU9HOtexQEBgv31s13ziwGgETc5FbS5198hR6bG6JZ1JsoJmxfmQXbeQGFjPISs95kv2KVYTeMRm5dQpslQZDSU2tMcLRcHBSt8ha9TZIOyYefl2yg8Rpd3+6g7BWDqFcsl6uZyQWmIQyB6zoQlP31ktbNCp2kOlmRk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=lqgTOb7h; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="lqgTOb7h"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 00D181A110E;
	Mon, 20 Jul 2026 09:33:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id C46B060360;
	Mon, 20 Jul 2026 09:33:13 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CC54A11BD3CCE;
	Mon, 20 Jul 2026 11:33:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1784539992; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=4CQrISOl0BCVcY0P30M6vyCI4+NKDoGPEn3wN8pRNP8=;
	b=lqgTOb7hGCPz4Bhuasua5vOcMC3VV8568buK9tnmi9N04rblfX1BC83fjsC2wruPtlCOTJ
	OFsQKlwuR6/+LzFaEqf9hgGVWTJyiEVn7vcK0GNxUOb80IQvo8dlKHZlzZrZcPcWdreXoW
	ugqvko4Eq09Xwz8U5ibOUx58cE71sdrye8OFMeAZISkMb/6Kvp6WGhEh8CbaTZEGgbd5HR
	3f8W31rYeVcPvtf+ULh22yd0wS9mbiqgtKNwB8VwsXssU02wy06hBCdZOrnp0QjsoCMiek
	EcvypwsBMERZx9HNElvb1p+941OtF65re8Qcg2/xLDhzkC5IkX7XPQ33UwuUZA==
Message-ID: <5cc0d788-c78d-40f2-998f-235d40f567f2@bootlin.com>
Date: Mon, 20 Jul 2026 11:33:05 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: stmmac: dwmac4: mask interrupts before stopping DMA
 in suspend
To: Luis Lang <luis.la@mail.de>, netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Ovidiu Panait <ovidiu.panait.rb@renesas.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>,
 Rohan G Thomas <rohan.g.thomas@altera.com>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-stm32@st-md-mailman.stormreply.com>,
 "moderated list:ARM/STM32 ARCHITECTURE"
 <linux-arm-kernel@lists.infradead.org>,
 open list <linux-kernel@vger.kernel.org>
References: <7941d239-e5f5-43b5-ae0f-20398221e027@mail.de>
 <20260718152802.83553-1-luis.la@mail.de>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260718152802.83553-1-luis.la@mail.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi Luis,

On 7/18/26 17:27, Luis Lang wrote:
> Since commit 1b9707e6f1a9 ("net: stmmac: enable RPS and RBU
> interrupts"), suspending causes an interrupt storm from the RPS
> interrupt.
> Fix this by adding a deinit_chan() op to stmmac_dma_ops, which
> masks all default dma channel interrupts. This is called from
> stmmac_stop_all_dma(), so interrupts don't trigger while suspending.
> 
> Fixes: 1b9707e6f1a9 ("net: stmmac: enable RPS and RBU interrupts")
> Suggested-by: Andrew Lunn <andrew@lunn.ch>
> Suggested-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> Signed-off-by: Luis Lang <luis.la@mail.de>

This is almost perfect for a new submission, only 2 things to improve :

 - you're missing the tree name in the patch subject. As this is a fix, it should be :

   [PATCH net] net: stmmac: dwmac4: mask interrupts before stopping DMA in suspend

   you can find instructions for this in the doc Andrew linked :

   https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

 - When submitting a patch, do so in a dedicated thread, and not in reply to
   other threads.

You should send a V2 addressing the tree name in the patch subject.

Sashiko noted something on the patch :

  https://sashiko.dev/#/patchset/20260718152802.83553-1-luis.la%40mail.de

It looks to me that sashiko is just wrong there though, I can't make sense
of what it is saying.

Maxime
