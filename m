Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCB0322B9F;
	Mon,  3 Aug 2026 08:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785747204; cv=none; b=Jz4+XKMwyIOyvYU3deBRKMB3Xc1UydwKU9xjJ8DI21K23exSHPPImge/SXZ9wW9Wu6pTRTlSh47hRdEnhPpaVES2qHsWYl61QdFM3toTsjTQL98PzWE795tjAP0td85/SnOhXJyrn1opY9ZFSbl9prAoEaJTAcZJ/sdsC67kqFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785747204; c=relaxed/simple;
	bh=saG8twsJDHHPqF3Ii1nCJfo3RXaAoYF+dJ7WMISWrIY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cuKPCms6GlwQ2e8zPm4HzHXGi6zPZ8YQNKiu28fTzUuh9nBJ7Aklt8Oa4vK4PuARah9LTos0GsCfwWvrVfsN+175/cPTGOhSnjwOQZoc4nGQdLzvQTTuZV/dfuPNOiUkV1L4xD3SQWIAPWPphMQ9ZckjGYcrXGDAnIXA0DIpJ00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=CAckRKkq; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=neez8M2V; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="CAckRKkq";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="neez8M2V"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785747200;
	bh=saG8twsJDHHPqF3Ii1nCJfo3RXaAoYF+dJ7WMISWrIY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=CAckRKkqBClidzcrw1XSPeSDkPyijkZLS8bW/MAF4ALEWWkveVFFby69YX/Aa0Qor
	 nuLmtxf3JGT+2vh0dydZSvBz8VLZTmIR2SUgA6WsWavkiog+ZJwqEvriXnjeNTjjeL
	 h+Ecz236fqOzeFofkzPaBB/IqL+omkwkWXRbqANELtLLgr/72QnkYFN3LhbdryIyLE
	 GDaidvPVTGKr+sNySXOYUYS0TjO/9OCuGrNAPlVCm/O85SpM7tOI6fJNWBEe8X9F3A
	 9l9J00UsvDW8qF0vBqE3yCqw4Pb8FGqO1dYBZxXAmbUt2KIG1GCOwjvz7xfAxVM1d4
	 tQqowAtQBDOGg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 5620949652; Mon,  3 Aug 2026 08:53:20 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1785747199;
	bh=saG8twsJDHHPqF3Ii1nCJfo3RXaAoYF+dJ7WMISWrIY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=neez8M2VbNgU5QnMKlEnOgLIwJUMRi87vo1GHOg5utli4bGqPZmqaqBu+LCMenK34
	 2e9GYUjraNsRot5DwTsayAXFodybFu1kC4GeUx0O9xo9QqFrtdHUIstB9ANoURAk2n
	 jJNsyD6xabu6YxKeWSfaUR+htpjpp4U5DXCfZ8tsuBP+ASsocBrBhfCDcvqUVH071I
	 6RbpFfdJkzs+Cw10FEjKR3Gy3rcazMcG6mzLuE/pmXvO5yGBReHirDwol8VKz3kY0t
	 KcB6YlBToDDnjq1AnorX8yfxktLmlYDO6WqxszBo/cB7jubbgwf8bHX10oSmLNRsKU
	 AwuggJM9vQ9eA==
Received: from [192.168.1.146] (90-227-251-202-no2480.tbcn.telia.com [90.227.251.202])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 0689E49645;
	Mon,  3 Aug 2026 08:53:18 +0000 (UTC)
Message-ID: <5e15ac01-18c1-4cdf-a800-62e2b1427087@birger-koblitz.de>
Date: Mon, 3 Aug 2026 10:53:18 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 09/13] ax88179_178a: Add Suspend/resume
 support for AX88179A/772D/279
To: Andrew Lunn <andrew@lunn.ch>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Russell King <linux@armlinux.org.uk>, Heiner Kallweit
 <hkallweit1@gmail.com>, linux-usb@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jianhui Xu <neuromoments@gmail.com>
References: <20260802-ax88179a-v5-0-dcb9fea4acd4@birger-koblitz.de>
 <20260802-ax88179a-v5-9-dcb9fea4acd4@birger-koblitz.de>
 <1cf1c0c8-d7a7-4ff8-9a9d-02dcc993ac14@lunn.ch>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <1cf1c0c8-d7a7-4ff8-9a9d-02dcc993ac14@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 02/08/2026 23:44, Andrew Lunn wrote:
>> +	/* Enable WoL */
>> +	if (priv->wolopts) {
>> +		ax88179_read_cmd(dev, AX_ACCESS_MAC, AX_MONITOR_MOD, 1, 1, &tmp8);
>> +		if (priv->wolopts & WAKE_PHY)
>> +			tmp8 |= AX_MONITOR_MODE_RWLC;
> 
> Have you tested WoL?
Yes, I tested WoL with the initially submitted driver, and I later checked that
the register writes around suspend/resume stayed the same. In fact, without
proper WoL settings, the AX279 will immediately wake up the host again after
suspend once USB wakeup is enabled for the respective USB device. I successfully
tested WoL for PHY changes (link state changes, any type of packet received) for
the 772D, 179A and 279. I did not manage to get WoL to work with magic packets,
but I could also not make this work with the ASIX Windows driver or ASIX's
out-of-tree Linux driver, so I assumed I was just not able to send the right type
of magic packets or my network setup was broken.

> 
> WoL is somewhat complex because it can be done in the PHY or the
> MAC. If it can be done in the PHY, you can power off the MAC. If the
> MAC needs to do it, it needs to stay awake.
> 
> But what i don't get is how the MAC is implementing WAKE_PHY?
> 
I really look at the suspend/resume functionality and WoL as a command that is
sent to the MCU, which then configures MAC/PHY and the USB interface in one
go and then puts the controller to sleep. It works by configuring a monitor mode
in the MAC (cmd AX_ACCESS_MAC, register AX_MONITOR_MODe) and then "calling"
AX88179A_WAKEUP_SETTING, register 8, with bits specifying
EPHY_LOW_POWER_EN | S5_WOL_EN | S5_WOL_LOW_POWER | 0x8000 which is a mix of USB
interface options and PHY configuration options plus a the EPHY_LOW_POWER_EN
command.

It now looks like suspend/resume is broken in v5 according to Jianhui's tests. Hhowever,
it was probably already broken in v4. Since this is intermittent, I wonder whether
the polling of the phy by phylink is to blame, which sometimes may still come after
the AX88179A_WAKEUP_SETTING sleep command. Can the polling be disabled by the driver
in the suspend() function?

Birger




