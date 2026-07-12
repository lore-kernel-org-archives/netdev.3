Received: from freeshell.de (freeshell.de [116.202.128.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C0E25B092;
	Sun, 12 Jul 2026 14:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.202.128.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783867841; cv=none; b=LEN8RSrvY0Fg8sxPae6vKx+IJTiNktBgSr/mnuFXqAYvT3sE9MJfAp2c3yjBgVGovjo2DRbOOZCcZ9M9pPPsBEKjJvEVdvX2d22EsOkER7ZKRElkh4GMnQRXwrQXsXklMEAzDkW83DTdHRKRMIo1AU62oOkzY5U7yzTAc9Op3H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783867841; c=relaxed/simple;
	bh=RRavhV5FIeJDdP7Im3Ubg5sj2lE53nE/4lMGo3DPKUc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hXaoDsVuOT9H7h/vmit7JeaooaGTHG8md+kKORmkbSDhVVj/Bpz9bPpMXCYI+SBII5cKr5xQJie5z5+oHS29m3LvDpZ/rNEBAVgEt+yzKwavYo5ZFmyiOGmddwqEz2T62mm1ook6eQkqJjT9VLnshKJ7vp8hoPiPrbekmDP/070=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=freeshell.de; spf=pass smtp.mailfrom=freeshell.de; dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de header.b=e1f+qC+L; arc=none smtp.client-ip=116.202.128.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=freeshell.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freeshell.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freeshell.de header.i=@freeshell.de header.b="e1f+qC+L"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=freeshell.de;
	s=s2025; t=1783867767;
	bh=Rgbu6YiDUX9kznSJSlo+OHz7QKMcuRkPsGR/yA4U/Cc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=e1f+qC+L/WnrDmmFa5VDmWfCQGJJmU9bOVHt5snbPF8fi/BKsz3/qb1GkPUE0p/3+
	 M2KLArFP9AgM+wzed/pgadxFOk3u4quiCcXHV+X24rR6A9PwmtC3ieuuiW3K5gsMKj
	 14cSfFjUJ9Q+9MPOpdj9frQWqoxI7TAs/e9hKriXEqerM733L5CwqAVqwBJ0kbBVM8
	 P7/aowqXTgMMcCah3k1GJYwucCF4Ild3dlLv/bcCa24dRK9+bK4QJgmoAiKzut1sC9
	 tZhstVazyV3ZN6Rtp7UT837VBE+896rjsA33YVVLfM6o0cNetHLRZuGPa8ueBTwJXy
	 l7eKaYLWxXNkw==
Received: from [IPV6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc] (unknown [IPv6:2605:59ca:364f:d400:1b91:6b30:22c2:fffc])
	(Authenticated sender: e)
	by freeshell.de (Postfix) with ESMTPSA id 11F2EB2214E1;
	Sun, 12 Jul 2026 16:49:23 +0200 (CEST)
Message-ID: <203fffef-bef1-4d56-a6f0-a2fe482821db@freeshell.de>
Date: Sun, 12 Jul 2026 07:49:15 -0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Failed to reinit phy of spacemit-dwmac when reset-gpio is present
To: Andrew Lunn <andrew@lunn.ch>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Inochi Amaoto <inochiama@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Eric Dumazet <edumazet@google.com>, "David S. Miller" <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Yixun Lan <dlan@kernel.org>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>, netdev@vger.kernel.org,
 linux-riscv@lists.infradead.org, spacemit@lists.linux.dev,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Han Gao <gaohan@iscas.ac.cn>
References: <20260712045233.800748-1-inochiama@gmail.com>
 <bc78469c-3f45-4234-88b0-49f050d651db@bootlin.com>
 <8689bf7d-e00d-4097-bd3c-4d7d7844d1d2@lunn.ch>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <8689bf7d-e00d-4097-bd3c-4d7d7844d1d2@lunn.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit


On 7/12/26 06:49, Andrew Lunn wrote:
>>> --- a/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
>>> +++ b/arch/riscv/boot/dts/spacemit/k3-pico-itx.dts
>>> @@ -196,7 +196,8 @@ &eth0 {
>>>
>>>  	mdio {
>>>  		phy0: phy@1 {
>>> -			compatible = "ethernet-phy-ieee802.3-c22";
>>> +			compatible = "ethernet-phy-id001c.c916",
>>> +				     "ethernet-phy-ieee802.3-c22";
>>
>> Indeed that's merely a workaround :(
> 
> Despite is being a workaround, there has not been much progress on a
> generic framework for dealing with clocks, resets, regulators etc,
> before probing PHYs. So this is probably what you want to do.
> 
>        Andrew

Aside for my participation in reporting and testing here, I confirm that
the above addition to 'compatible' node does not itself resolve what I
observed to be a problem for debian-installer, however it does itself
resolve the rmmod/modprobe cycling issue of the eventual installed
Debian system as I described and what I am quoted as having reported
from dmesg output.

So the other report of increasing de-assert from 10ms to 50ms is needed
for success of the debian-installer hwprobe detection, and this here
issue of adding to the 'compatible' is needed for success of
rmmod/modprobe cycling. In concert together both fixes resolve all of
the trouble I observed and reported, tested and verified on Sipeed K3
Pico ITX.

Thanks for tracking this down it is very much appreciated :)

With that,

Tested-by: E Shattow <e@freeshell.de>
