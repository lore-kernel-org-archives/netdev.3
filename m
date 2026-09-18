Received: from smtp.inf.ufrgs.br (smtp.inf.ufrgs.br [143.54.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F69E2236FA;
	Fri, 18 Sep 2026 00:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.54.11.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789692365; cv=none; b=MNhFv7B8ggz6Fbf3Ip1u05MZnoyISc6R9t6FZJjxHHsegUixUXnRuoBYoXO38+do+d1RZlcj7J82kx9yyiXCv/MifRmDSRQPp1Q8/vzWdwvT5Op+VUIoUmmMbhDaKpA/v8sOF8cjU64RH4LA1P7LBgQK8cC7B5zml//T+R1fT8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789692365; c=relaxed/simple;
	bh=ig6QWU/1cL+w9xP/m4RIBSgEmoa5JwTRCf1IkjOGQoA=;
	h=MIME-Version:Content-Type:Date:From:To:Cc:Subject:In-Reply-To:
	 References:Message-ID; b=Fcnj2mfd83tZ33Yi8m4BG/MALFTyBQpjmzuZRxQmCLwiymcvPVE4yCiNLGu+B4V6PlbM/hzVai9WzFhra6v6DxQz5y0xfP2WQpBuNBeg4EeZIpzZj9xKweaP6c7umh9s660DyLlXjdgYlncQc5HbN6axIC4br7XtP+r0V8Zehgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br; spf=pass smtp.mailfrom=inf.ufrgs.br; dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b=TUldHRtd; arc=none smtp.client-ip=143.54.11.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inf.ufrgs.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inf.ufrgs.br header.i=@inf.ufrgs.br header.b="TUldHRtd"
Received: from webmail.inf.ufrgs.br (webmail.inf.ufrgs.br [143.54.11.45])
	by smtp.inf.ufrgs.br (Postfix) with ESMTPSA id 42C271202B5;
	Thu, 17 Sep 2026 21:45:52 -0300 (-03)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inf.ufrgs.br;
	s=dkim2026; t=1789692352;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7noIVcernOgHWLvqEDePe5AAR99G2EpRfhDvZQY2pho=;
	b=TUldHRtdRoorgkI4Uos7LUFcv+DTX4VuBJ97JO0Op+Z2u6mO4w8jmmIiXl9XPIO7tfc+1H
	zjRd9uOlbyjYkuJvUnUjohkixfo1PC/l43shvENL2wBktCw0rFBeTreQCINMBU2BMALNH3
	CgU1nxbSGs0usE80jy+aTlYc9cwQ8rOUQS0YwskhOv/Tp3SyNTFa8CCF6W+daSP1BgGw/B
	WwiaP1UbZjqiibSPI+WipxWHqeYDkZV+Qr0rHDGMCsE7RoAo9vhNZ98+jqdFeYunbyeJe+
	19NlViJzuTaI50i9wda3CZS8KfT5BER72hBjKpRKPagkQI3YRJpzJIQbzwZTGw==
Received: from 186-210-025-76.xd-dynamic.algarnetsuper.com.br
 ([186.210.25.76])
 by webmail.inf.ufrgs.br
 with HTTP (HTTP/1.1 POST); Thu, 17 Sep 2026 21:45:52 -0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 17 Sep 2026 21:45:52 -0300
From: Matheus Alves de Almeida <matheus.aalmeida@inf.ufrgs.br>
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, nic_swsd@realtek.com, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 3/3] r8169: release firmware on application
 failure
In-Reply-To: <0845552d-158b-4c46-b984-c0ea18237eed@lunn.ch>
References: <20260916152444.167196-1-matheus.aalmeida@inf.ufrgs.br>
 <20260916152444.167196-4-matheus.aalmeida@inf.ufrgs.br>
 <fe23c6bb-2cdf-4641-aae8-25b03b38be42@lunn.ch>
 <4ee3cd8a9a299d504fc95ba86a3f387a@inf.ufrgs.br>
 <fcaf8c8c-f6df-46c0-ac9d-7924c732283c@lunn.ch>
 <cc15edcbf76e8e70c89dd5ef5d838c3a@inf.ufrgs.br>
 <0845552d-158b-4c46-b984-c0ea18237eed@lunn.ch>
Message-ID: <714971be06fbb8d5c519d1d710d214fa@inf.ufrgs.br>
X-Sender: matheus.aalmeida@inf.ufrgs.br
User-Agent: Roundcube Webmail/0.9.5

>> Right now, firmware application failures are ignored, so the device
>> can keep going even if applying the firmware fails. The TODO also
>> specifically says to release the firmware on failure, which seems to
>> imply that continuing without it was the intended behavior, and that
>> releasing it was mainly meant to prevent retrying the same failed
>> firmware application later.
>> 
>> Making firmware application failures fatal also creates a state problem.
> 
> I don't know this driver in detail, but fatal errors generally don't
> cause state problem. The probe method fails, so the device is
> destroyed. Is firmware download not performed in probe?
> 
> This driver does support a number of different devices. How many do
> you have for testing? If you artificially cause firmware download to
> fail, is the device usable?
> 
> 	   Andrew

In the r8169 case, the firmware is not applied during probe, but rather
during rtl_open().

I got my hands on a machine with an RTL8105E. While it runs without
firmware, partial firmware application causes the NIC to stop working
unless the failure happens near the beginning or end of the application.

At this point I think the TODO I was trying to solve is stale. The proper
handling here would be, as you suggested, to fail rtl_open() on a firmware
application failure, which would release the firmware through the existing
rtl_open() error cleanup. That would instead turn this into broader
initialization error handling, which I am not knowledgeable enough about
the netdev and r8169 code yet to do confidently.

If desired, I could send the iopoll patch separately, but I do not think
I am going to continue with this series. Thanks for your help and patience.
I am still new to Linux kernel development and trying to get the hang of it.
