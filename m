Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1134025A2B3
	for <netdev@vger.kernel.org>; Tue, 29 Apr 2025 19:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745953793; cv=none; b=rePnZpLsYGCQuzkWk2apLwf/c9gfEB490nDEh/2VjZoiYi6gqrJgkm97ZkmPbq9r/GCe6uagVvcYPvIKvBSyPxoe7diGZREW2/ac9MVXbGhMoRg9OJW7/W7HIJ0AslCx4DJH4p8mtE92/Gw6xRA45ufEBbTr4uLtI6hDJRbpUVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745953793; c=relaxed/simple;
	bh=/GL9Ab1TW1k3dwdHDpWPyGeIcf7jJgQrEt2ODqJlZMA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fnIWAQtNad7QNstaFCI0wayB16DI4C2pS9HJqV+OLvIYdRdTPIVhXeWPW/fT7H0DHavfW0WAbyq0dASmMpI2xud6HGWAwnI78buCXRkmZozWcEJSZa1pjHDu97JX9SUEWbtokXcoDGw/ddkGTQT5MsxPmPW9LPbQdNpU+4/v51Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YY38rY7Y; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YY38rY7Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 833BDC4CEE3;
	Tue, 29 Apr 2025 19:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745953792;
	bh=/GL9Ab1TW1k3dwdHDpWPyGeIcf7jJgQrEt2ODqJlZMA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YY38rY7YIE2fRIid3S8UWvpw5J3H4mdESQ7A4NyhnL42LBJXlT3vk7m1oLwh1c5sa
	 POvTKsAMQ8AH4Ck7SEl0KyOZEvyMIVzoXnUOCbIzTgGI/vK4+aIHI4AbkEorLXOGqo
	 ovOuWwfoD2UtMTQCI7JCwYMXzTUaQkoDbHhgiMxC5UDkyJCnA4s8nfEzwEXtXwaKAR
	 DJqGQbROrm+RuPSoLZEa0aHk/9roYAvpnktIlIhXKcrA22HUq9p2DEenj5+m6w0h06
	 igGhdwlKDpP/RQ7F1GYK3sjunKOEw19kka185aMkVIPovoA70mrSnc4cE74uAUDPad
	 +KOCjaYmkbvfg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADE573822D4C;
	Tue, 29 Apr 2025 19:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: dlink: Correct endianness handling of led_mode
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174595383124.1770515.3904355087844093226.git-patchwork-notify@kernel.org>
Date: Tue, 29 Apr 2025 19:10:31 +0000
References: <20250425-dlink-led-mode-v1-1-6bae3c36e736@kernel.org>
In-Reply-To: <20250425-dlink-led-mode-v1-1-6bae3c36e736@kernel.org>
To: Simon Horman <horms@kernel.org>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux@rainbow-software.org,
 andy.shevchenko@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 25 Apr 2025 16:50:47 +0100 you wrote:
> As it's name suggests, parse_eeprom() parses EEPROM data.
> 
> This is done by reading data, 16 bits at a time as follows:
> 
> 	for (i = 0; i < 128; i++)
>                 ((__le16 *) sromdata)[i] = cpu_to_le16(read_eeprom(np, i));
> 
> [...]

Here is the summary with links:
  - [net] net: dlink: Correct endianness handling of led_mode
    https://git.kernel.org/netdev/net/c/e7e5ae71831c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


