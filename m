Received: from shout01.mail.de (shout01.mail.de [62.201.172.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DB430B50C
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 07:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.201.172.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784273293; cv=none; b=fG6RKuYh0cIY6jIMmOLYi1ESlRHKMKTeVrS9AuXCw4cFJsWv29IUMNqYBgUtM8zQjztc6by0rX5A/aiycYBtXVMMpgMjoHKEd2TL9ZZ2TRpTUSrHq8YEOUpLh1pG1vs98kXlY8/MxuAZ5+gkX9D8Lp1nvqlY5X2o0kl/ko4Mzhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784273293; c=relaxed/simple;
	bh=mGpbOilzYpVZxeHSa2z2P8+XyjpvOwim0Tvovb3Lw0w=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G4tvAu6Up26yr7Vvb3cbA3xW5kG2DOFdbwDI85lKeGBcjXIFFggPmnVvVvYE8YWD68QQRlHOTlC41YEwxFj1PY5yNfk3IgHprUFHPLq+xK70HYLvlQqTOiItPjQAv21gQOYT3PJMsrmS/QJg1I935bnyMzghdbEO5bMKnvCzOrg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de; spf=pass smtp.mailfrom=mail.de; dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b=e+A75dzn; arc=none smtp.client-ip=62.201.172.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mail.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mail.de header.i=@mail.de header.b="e+A75dzn"
Received: from postfix02.mail.de (postfix02.bt.mail.de [10.0.121.126])
	by shout01.mail.de (Postfix) with ESMTP id 3AD4D24083C;
	Fri, 17 Jul 2026 09:18:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mail.de;
	s=mailde202009; t=1784272737;
	bh=mGpbOilzYpVZxeHSa2z2P8+XyjpvOwim0Tvovb3Lw0w=;
	h=Message-ID:Date:Subject:To:Cc:From:From:To:CC:Subject:Reply-To;
	b=e+A75dznDQXYbRPyaRDMNmZ5b19KGQ8pu2j43xTYwdnkfyN8KZ6PK9g+yG76MXG1U
	 GeDIhKjTKFfQLOss/CeFh0hJS5Xj6WWFnBDXYg3zUekhlxHsLTR+PjDvEUV00+zTBt
	 qaLZ3y32fJplkh//I7QZKbBMnTZNvJTk7N2ZMdCTX4UrPvH2eTAMFt6H/MTDfU1nIU
	 280SYXDSlhF4I9F+k21eRi1sdSx7OcaPamBqFBoFWTssQ6pKZOHX5L943tWZyd7taZ
	 SCgJ/DLhAQUeg8on4dwR1f86HwagnnXVXgrs0Zx5XiEf+/XgbJ+mNN8YEQxTIifFe/
	 T0I5Lh+k7HUMw==
Received: from smtp01.mail.de (smtp03.bt.mail.de [10.0.121.213])
	by postfix02.mail.de (Postfix) with ESMTP id 145B1240555;
	Fri, 17 Jul 2026 09:18:57 +0200 (CEST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp01.mail.de (Postfix) with ESMTPSA id 008ED240656;
	Fri, 17 Jul 2026 09:18:55 +0200 (CEST)
Message-ID: <72b91ec7-202c-4301-bcd8-b818cf8d72a0@mail.de>
Date: Fri, 17 Jul 2026 09:18:55 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [REGRESSION][BISECTED] stmmac: suspend hangs since 1b9707e6f1a9
 ("net: stmmac: enable RPS and RBU interrupts")
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, regressions@lists.linux.dev,
 rmk+kernel@armlinux.org.uk, kuba@kernel.org
References: <7941d239-e5f5-43b5-ae0f-20398221e027@mail.de>
 <17ebe5ba-16a5-4b3a-94cd-e9707c88df3e@lunn.ch>
Content-Language: en-US
From: tresonic <tresonic@mail.de>
In-Reply-To: <17ebe5ba-16a5-4b3a-94cd-e9707c88df3e@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) https://www.eleven.de
X-purgate: This mail is considered clean (visit https://www.eleven.de for further information)
X-purgate: clean
X-purgate-size: 2070
X-purgate-ID: 154282::1784272736-AD6EDC36-CB00A88E/0/0

On 7/16/26 11:47 PM, Andrew Lunn wrote:
> On Thu, Jul 16, 2026 at 10:10:25PM +0200, tresonic wrote:
>> Hello,
>> Please bear with me, this is my first time writing to a mailing list...
> 
> Thanks for the report. Nice description for a first post. Lots of
> useful details.
> 
>> Since commit 1b9707e6f1a9, suspend (systemctl suspend) causes a full system freeze on my laptop. Fans and keyboard backlight stay powered; the machine is completely unresponsive and requires a hard power-off (holding the power button) to recover. I could not get any kernel output from the hang.
> 
> 1b9707e6f1a9 makes in effect 4 changes.
> 
> Can you do some testing to see if the changes to
> DMA_CHAN_INTR_ABNORMAL or the changes to DMA_CHAN_INTR_ABNORMAL_4_10
> break it. Or both, but i think that is unlikely.
> 
> Once you know which of those is responsible, can you test to see which
> of DMA_CHAN_INTR_ENA_RPS or DMA_CHAN_INTR_ENA_RBU broke it.
> 
> It kind of sounds like an interrupt storm, but that is just a
> guess. If it is an interrupt storm, it suggests an interrupt is not
> being disabled during suspend.
> 
>    Andrew

I tested the changes as you suggested and it seems DMA_CHAN_INTR_ENA_RPS in DMA_CHAN_INTR_ABNORMAL_4_10 broke it.
With this change on master suspend is working:

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
index 43b036d4e95b..e907142c9ee2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_dma.h
@@ -121,7 +121,6 @@ static inline u32 dma_chanx_base_addr(const struct dwmac4_addrs *addrs,
                                         DMA_CHAN_INTR_ENA_TIE)
 
 #define DMA_CHAN_INTR_ABNORMAL_4_10    (DMA_CHAN_INTR_ENA_AIE_4_10 | \
-                                        DMA_CHAN_INTR_ENA_RPS | \
                                         DMA_CHAN_INTR_ENA_RBU | \
                                         DMA_CHAN_INTR_ENA_FBE)
 /* DMA default interrupt mask for 4.10a */

tresonic
