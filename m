Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C9137F311
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 01:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790817008; cv=none; b=sVjo8MPVsDYC4lhn/q/8VIrDZaOHC/4/V8zOIie9J2930OvWBHl5FTM0No/MZCJzkrYyKW4j8VVXBLPqowNWi00kC/6I1nVErDIo6/dicw4FX5XpmyrQGFr0lsnclYI9yHyJ/taxkhEm5RJ9yEtr/gD3krVPnfEw6ko9VjUyBZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790817008; c=relaxed/simple;
	bh=QmuqQ73zRbllRF3Gcxwzoj4BVulFfpHnxEjaI32bjOg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=KlYIKG0++BXq1OGmKWb5bl6U16iYinc4pL/5lGXQrBxouspMv+s4tJ0s+5pYZdZDETvGsBvyIHJ7wrFHgabgMEhjKsq4CV2u3bYRn8k5cZDhVRNEi7y0jPLVGFNS2AbYKJzQIX6v5DfvCJ2txYq2e8/n5OaL7znNDHSOxbsUzNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IcSq73U/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IcSq73U/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E841F000FF;
	Thu,  1 Oct 2026 01:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790817006;
	bh=TA88LPYTabkSC9axVKbQDE+utSNSMiTpS9gFDqdqsTY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IcSq73U/KU1g0V0UEKLPF6W8zcK/SL7TXHo/YGV2oERuULLyK6LdG4MM8gmPYXBX2
	 LfkfkdG+A8PvOaTzI3dbAdE2JwuUqmAtMJJ8BGZdryp07AdpacNQPztjhHMH3nwuyV
	 cviODfTwybNOWc4HokwFSJGelhebmvh5Mazgf+Ceg642B67Ke+PlapKJMLKp6VWaev
	 C5zq5ICYkEwOVPgXmqI1CzUBg24b44uG+YBlpxhVkuJuwBkmufR96KWlsgwIPhYBw4
	 6nowt9IVH+o93KNzD1MZI6zjKydKSfNUJXhYifbYzBUWiCeaMRyND6RaFMDjFJOQt3
	 ukeReewvmRThw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A3373AA6A61;
	Thu,  1 Oct 2026 01:10:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: usb: qmi_wwan: add Rolling Wireless RN947R
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179081700503.2200095.5805234013318122554.git-patchwork-notify@kernel.org>
Date: Thu, 01 Oct 2026 01:10:05 +0000
References: <arZzuOOvLUZtdOlv@arcor.de>
In-Reply-To: <arZzuOOvLUZtdOlv@arcor.de>
To: Reinhard Speyerer <rspmn@arcor.de>
Cc: bjorn@mork.no, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Sep 2026 15:14:32 +0200 you wrote:
> Add Rolling Wireless RN947R 0x9300 composition:
> 
> DIAG + ADB + NMEA + MODEM + RMNET + QDSS + ADPL
> 
> T:  Bus=01 Lev=01 Prnt=01 Port=02 Cnt=02 Dev#=  6 Spd=480  MxCh= 0
> D:  Ver= 2.10 Cls=ef(misc ) Sub=02 Prot=01 MxPS=64 #Cfgs=  1
> P:  Vendor=33f8 ProdID=9300 Rev= 0.00
> S:  Manufacturer=Rolling Wireless
> S:  Product=RN947R
> S:  SerialNumber=xxxxxxxxxxx
> C:* #Ifs= 7 Cfg#= 1 Atr=a0 MxPwr=500mA
> I:* If#= 0 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=ff Prot=30 Driver=option
> E:  Ad=01(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=81(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 1 Alt= 0 #EPs= 2 Cls=ff(vend.) Sub=42 Prot=01 Driver=usbfs
> E:  Ad=02(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=82(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 2 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> E:  Ad=84(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=83(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=03(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 3 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=40 Driver=option
> E:  Ad=86(I) Atr=03(Int.) MxPS=  10 Ivl=32ms
> E:  Ad=85(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=04(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#= 8 Alt= 0 #EPs= 3 Cls=ff(vend.) Sub=ff Prot=50 Driver=qmi_wwan
> E:  Ad=88(I) Atr=03(Int.) MxPS=   8 Ivl=32ms
> E:  Ad=87(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> E:  Ad=05(O) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#=21 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=70 Driver=(none)
> E:  Ad=89(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> I:* If#=22 Alt= 0 #EPs= 1 Cls=ff(vend.) Sub=ff Prot=80 Driver=(none)
> E:  Ad=8a(I) Atr=02(Bulk) MxPS= 512 Ivl=0ms
> 
> [...]

Here is the summary with links:
  - [net] net: usb: qmi_wwan: add Rolling Wireless RN947R
    https://git.kernel.org/netdev/net/c/7375d38364a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


