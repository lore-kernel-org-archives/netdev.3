Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A7D31E823;
	Tue, 22 Sep 2026 00:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790037086; cv=none; b=mqqN+vfcLSTl7HeGQW0yUHydkHKtaPSfsY6I2eubJN7bYRZDDO6wEHw18hfyVeqmwYHZ16TDSzETscA1jN6eES9T9rKnuCrTAvC3nlHJpekVKHjeVBYkUloaHUhVjStCNOb/vM36g8Nerv3xSCvDYZ4W0WyUmoxyd8vg2rO/6F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790037086; c=relaxed/simple;
	bh=yKBf48Vw+2xkbUXfd/pWHyinK6lukvXzQlD6MFuGUjE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RmE6P5KHztDisum1PH2WU9jRELsDbz8CUdk0V/ZgFN6QTmnlMeoJxxzRw8WbAUrEZdeeMPCXn96yDKD92nMFFHoUGshLJNpsKuxya5pC/1n8F81B3O93qUf+crJo8tLV93t9WyclGni/rw2lst0YHxaO1SQ8DyYryZV1WpmOrwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OKDferkB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OKDferkB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05BC1F00893;
	Tue, 22 Sep 2026 00:31:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790037084;
	bh=GJE7yNw7uyQ2FNzJFQxVbik/vY3x7bBR1y1y1QTWh00=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=OKDferkBPTZDApJsslZQZIsDDolCJa91fTip8bcpbLgprYT+iBpw8elWahiCIgkd8
	 6JMn5KXm0Go5EeuMD9Sp2AkKknclddKAVrfltxtHf9RkCZSUSVlhYKUxQiHdtZ7Pmo
	 Q1Y7lv5HZVshfkmkxmnygiajr4qqbmbZKekdRXqVLsbDBW6osNJpaEQBrSUXDQjy8A
	 7BMUfH+8BZihGVf3xwndUaUd2HtwfP9QQC5JaSThI/2cgly8h49JPxsuVUbclu724U
	 SPly6wTpZ+wHYQuQKn5gxqURrA2Q8nR0z+MUFrwun+agn+GUexXbaVhGQ03UKVItae
	 qAL6MICarpNHA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 939313930203;
	Tue, 22 Sep 2026 00:30:16 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] net: xscale: publish the IXP46x PTP OF module
 alias
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179003701514.3305732.11773957927637089319.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 00:30:15 +0000
References: <20260920034557.17734-1-hppiscas@163.com>
In-Reply-To: <20260920034557.17734-1-hppiscas@163.com>
To: Pengpeng Hou <hppiscas@163.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, richardcochran@gmail.com, horms@kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 20 Sep 2026 11:45:57 +0800 you wrote:
> The IXP46x PTP driver matches intel,ixp46x-ptp-timer via its OF table,
> but does not export that table. A module build therefore lacks the OF
> alias used to automatically load the timer driver.
> 
> Export the existing table without changing the matching or probe logic.
> 
> The issue was found by our static-analysis tool.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: xscale: publish the IXP46x PTP OF module alias
    https://git.kernel.org/netdev/net-next/c/51cb6a6424f3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


