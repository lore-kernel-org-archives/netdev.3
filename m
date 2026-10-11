Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59A81C5D5E;
	Sun, 11 Oct 2026 05:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791696782; cv=none; b=bfncJNmS/ddJaJpyi5zaItKz02JR7o5faAsJkXUvoeQbWMQGG4fzdDqGXq4Kva8Ua5UVpUPXLEHk69pfCls8kFUYgtAK28IiUUyJ8o3Ecadt++O8uzAvQ/cLGU0jcXCIBeCpOhtCYtD6GHNgjlVmR1yyYeqGLB6D56r8RMSdZKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791696782; c=relaxed/simple;
	bh=W9RvR/XI0sTjGWT17IQav5iU/yf/psweZkbaR2ucR2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=klRBK9FQIis8A1ZaIIumaBWM1iop1xFrJyOvmNbko4mC8UIGq6k6pYWl+iLahnFeTZ3xwzKC2wtkiObNJnddj2Cb3fU9kLhRdc0C2ColGD+3Aqo/tB5tIisf+36ffrXtrkxO4w0UEUcRK5WrS2XI5HpUY9xWZkSZKNZ7rqx1i+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=OlB2BMiD; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Ga7Qtsmd; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="OlB2BMiD";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="Ga7Qtsmd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791696773;
	bh=W9RvR/XI0sTjGWT17IQav5iU/yf/psweZkbaR2ucR2Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=OlB2BMiDCpFHfsjkWBTYCxlSmXfgKEB/QvA6ldTtloG6ITzsG4PdSYb/ntAifog41
	 iB9EtQW8ykOqjFbWlEmi8SqKuA9ZY0zlOmS3SMwq4Az+7TFQtx38ogyTjhzbwMPV2u
	 ivmqjN1s3MfcNk7tPIcv04dCRnhQEOEKWAeYk+cUxTk2x++6/XFAKaNjfLG3nnaJCn
	 xAw71VM4+7n6Qyn3WWrvyejZbx7iqs8jFiCD+v/jIrdwV98aQngmKquZaaiXH+aAa8
	 u+F6EbB6XOl9bK789kQfOd5063qvXZ8fVNU/N/a3SwcKgu/P9t7OLOn4AKNX2VN/mV
	 9nmai7Rnud+Cw==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id 957AE481C9; Sun, 11 Oct 2026 05:32:53 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791696772;
	bh=W9RvR/XI0sTjGWT17IQav5iU/yf/psweZkbaR2ucR2Q=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Ga7QtsmdWUYCDqTN6I/h3UkDL7pR6xvZGksXybZcmUehD0bZh0zc6U7t9hjVEiLTe
	 1TIJs81q8I56AusbvjsA/NKz7J5NFRpNYSY/kf59uaGw7yq0AOBlI7E3XGOK7Iz74s
	 OtsqXbrBPT7p+Oz3TWW4H7Pgm6gbpeDrzXQXS57gVFLPpxJqrHB8+qF3Vy/GbISI0A
	 KMv4zrAogGFS/nIzheBZ5lzv9w5xb3nuY/aTnHCnzrz9CSplElaH6wxiFgL0M3si0Z
	 5VXsA7egyt6IZCXwpukM0ARqWv222BWbjVQVsJSFZkP4cSVP9pE5hSOzMh1AjV8mMe
	 U7XmFvE3bQwpg==
Received: from [IPV6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb] (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 8F36B475D3;
	Sun, 11 Oct 2026 05:32:52 +0000 (UTC)
Message-ID: <acada24c-903e-49ea-be04-879fedbfa08b@birger-koblitz.de>
Date: Sun, 11 Oct 2026 07:32:52 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v19 01/13] phylink: Add phylink_mac_interrupt
To: sashiko-reviews@lists.linux.dev
Cc: linux-usb@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Andrew Lunn <andrew@lunn.ch>,
 Eric Dumazet <edumazet@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jianhui Xu <neuromoments@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>
References: <20261010-ax88179a-v19-0-7475173cfb56@birger-koblitz.de>
 <20261010-ax88179a-v19-1-7475173cfb56@birger-koblitz.de>
 <sashiko-outbox-167008@kernel.org>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <sashiko-outbox-167008@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/10/2026 6:54 am, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] phylink: UAF and TOCTOU in phylink_mac_interrupt due to lockless phydev access
> --
> 
> commit 667c3fb1a09bf0994b40559aee9027d3f9775442
> Author: Birger Koblitz <mail@birger-koblitz.de>
> 
> phylink: Add phylink_mac_interrupt
> 
> Adds the phylink_mac_interrupt() function to phylink, passing link-change
> interrupts received by the MAC to phylib.
> 
>> diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
>> index a7d086cdc9b25..a3ca7993eb7e0 100644
>> --- a/drivers/net/phy/phylink.c
>> +++ b/drivers/net/phy/phylink.c
> [ ... ]
>> @@ -1612,6 +1612,26 @@ static bool phylink_link_is_up(struct phylink *pl)
>>   	return pl->netdev ? netif_carrier_ok(pl->netdev) : pl->old_link_state;
>>   }
>>   
>> +/**
>> + * phylink_mac_interrupt() - wrapper for phy_mac_interrupt()
>> + * @pl: a pointer to a &struct phylink returned from phylink_create()
>> + *
>> + * Passes a link-change interrupt received by the MAC to phylib.
>> + * This function may be called in interrupt context, and therefore cannot take
>> + * a mutex. However, it is safe to assume that the reference to phy does not
>> + * disappear during the call, as only an SFP module may be unplugged to make a
>> + * PHY disappear. SFP modules however do not support interrupts.
>> + */
>> +void phylink_mac_interrupt(struct phylink *pl)
>> +{
>> +	struct phy_device *phy;
>> +
>> +	phy = pl->phydev;
>> +	if (phy)
>> +		phy_mac_interrupt(phy);
> 
> [Severity: High]
> The function comment notes that SFP modules do not support interrupts. However,
> when an SFP module is physically unplugged, the electrical link drops. Could
> this link drop trigger the MAC interrupt being handled here?

The way this code-review is done by whoever handles the AI is absolutely 
not OK. The same patch was considered to be free of errors in the 
previous round. Now something is brought up that has been discussed ad 
nauseam before, including an analysis by Andrew, and found correct.
The minimum I expect is that emails relating to the patches are being 
looked at and also understood!

Additionally, the AI spits out vast amounts of issues in code-paths for 
older hardware. Issues that I do not intend to fix, because I simply do 
not have that hardware to test. Still, reviewing these "issues" takes 
large amounts of time and even when I complain, the same or similar 
issues are raised again in the next round.

The "issues" raised by the AI have become more and more absurd and 
trying to fix them does not really improve code quality, because of 
possible introduction of new issues and regressions.

I am not going to look further through this AI review as the benefit to 
effort ratio seems tiny. The code has been tested in-depth. It has been 
reviewed by several humans. Unless a human steps in and tells me that 
something really needs to be fixed, at this point it is as good as it gets.

Birger

