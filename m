Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 516303BF69C;
	Tue, 31 Mar 2026 11:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774957269; cv=none; b=tkOoHFg4C/aHzfAdNLcEpv2rHzz0iPpiXiU2goBZGuIy+lDfWYcFdtPeQoQ/K0x+XloM9yMgQrnn/2oRvU+GpKCt9batlacPfTz3/Iboc+CvHt7SJCOAKlyxOKgJl2ZfQBJgRcbwKl6PQrSlhfUjZQUT+fgT1ozCGfH/1i3eVAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774957269; c=relaxed/simple;
	bh=HC8/liEMF5F55EJ3tray695sFKJE0rqAnsbk+pm2Wi0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=MZ9bDMDZI/KXB4exosI9ChSVDNTqnpX+elT/qMEEg7HH4TwYGvR72nGsTM07E65oylEmwzymsSWm8T/DcUUK35zrCAf7az3z09xBLCXPSqoSo9/T8wv8bIk4SUJxo/eO2lOMw97iC5fALKOFQaLPG16N8g312o6i/9p+V34kO0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=w2pRbwxW; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="w2pRbwxW"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 54F98A5870;
	Tue, 31 Mar 2026 13:40:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1774957260; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Ptxu8P756vAqCj6Qj3gdQkHY8hSmYtFP5vFJaFlvzlc=;
	b=w2pRbwxWOgcsE3vYUeTHRIfB/M1eChwp0NGmSaT/nayDHMuwFJk8nE47PXwOdhXoqiBkvD
	3gVmUMEpYG6+lcX0Hr/EC7H6XSTeoObZsiTy4b5jqLEbzl0+hx8nLc8AlZwwmf5mrx51I5
	+b98LtDIcKPf0m3CJVrPqPWSTvanDVJOW9SiY/FyUI8FjeAHSGSUdLRPgTJUm0oVw2O0o8
	OP/IAqf0nTpJEdxuaPDrEbohMX5qqWaAviAre0PrUPHYjYIuKMA5+umelS1sBfDIUxh0hN
	N1od6ZXgaC4XG7NaT8VIY7UQ9IIhYKsCN5hCkuXYMQs07GP0kRsduSht/hKjXw==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 31 Mar 2026 13:40:57 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: netdev@vger.kernel.org, Phil Elwell <phil@raspberrypi.com>, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] net: phy: microchip: add downshift tunable support
 for LAN88xx
In-Reply-To: <acuwKGBn6UKfRCjU@shell.armlinux.org.uk>
References: <20260330224630.579937-1-nb@tipi-net.de>
 <20260330224630.579937-2-nb@tipi-net.de>
 <acuwKGBn6UKfRCjU@shell.armlinux.org.uk>
Message-ID: <f3c1a8af592115ca9a77b3249fa167bf@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 31.3.2026 13:29, Russell King (Oracle) wrote:
> On Tue, Mar 31, 2026 at 12:46:26AM +0200, Nicolai Buchwitz wrote:
>> Implement the standard ETHTOOL_PHY_DOWNSHIFT tunable for the LAN88xx
>> PHY. This allows runtime configuration of the auto-downshift feature
>> via ethtool:
>> 
>>   ethtool --set-phy-tunable eth0 downshift on count 3
>> 
>> The LAN88xx PHY supports downshifting from 1000BASE-T to 100BASE-TX
>> after 2-5 failed auto-negotiation attempts. Valid count values are
>> 2, 3, 4 and 5.
>> 
>> This is based on an earlier downstream implementation by Phil Elwell.
>> 
>> Signed-off-by: Nicolai Buchwitz <nb@tipi-net.de>
> 
> I didn't see a cover message. Please always include a cover message 
> with
> patch series.

Apparently the cover message [1] was sent with slightly different 
recipients (although it was a single git send-email with 
--cc-cmd='scripts/get_maintainer.pl --norolestats').

> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks, I will add it to the patch.

Nicolai

> Thanks!

[1] 
https://lore.kernel.org/netdev/20260330224630.579937-1-nb@tipi-net.de/
