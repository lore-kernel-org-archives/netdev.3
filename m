Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1582494827;
	Fri,  9 Oct 2026 00:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791504008; cv=none; b=tZBTbR6zAR0kreVVyIEHF+mIUFn3AXaAqUzJJ4hqkNHTE6dnzOSVf9koA+8QkMeiMPjsVkSDZwugvqWT4pUZzYPoC0mutLArQ+NPCnQcckGf9+xj5DWaO55ohPgud8OIMilE7mtUFZgdXfRg1tlT4ltRZ3P490qsHVgVAUn1qXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791504008; c=relaxed/simple;
	bh=YvqnESQnZp0zT05Cgyaf2DA/xtvgT7CfncX0itzo4+Q=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=alJ+ExVh1C5fY6C6qfeDTxnRHr/norhjJDZgeGXMUzDy0uXL8pks3QIx7YqQR9sPT/qg9cTcOArRo/JyOlRHZ93+dX5PjL/K4SQ6q6pe4xUq4X3M2MjtxQVf9qUgqh+rOsoauIM2quc0H/9x/pn6fkRom3QTcu8wS2nzmXbfXeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RCFu78rA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RCFu78rA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 836071F000FF;
	Fri,  9 Oct 2026 00:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791504007;
	bh=+IyQ828IGEywIAqnUI//pAfQALlm2qhiGWwrh5Y9DDQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=RCFu78rA8pcx1es0cJQNQb8yLuEeG2KHRyALydceKAxDdKmN1eS2TcZMOzNnN+Yt2
	 F2Hsy7K/GB0acAVynoytVEJ7gz12exuzbwBd3dy+TKVfSkBKNf9XDNwJBdEz2ACbVu
	 wmVG+IDP8Qr2acvYxfEOZZY5mn4tDV8c90e9knBDqIb2cpknSyg0ea5sg0K/jafxhU
	 Cud8/pM1XwjQZkQmZq+bIS7TnOGSgn0LLMnh47j5bKp0ULwE1SewhXdHfcLN+JBGvI
	 7JP7Nzc+ToaF7/y9osPHjwQWk841J6+n7m/PBK1JckAFQoCdCScKEEM+DfLXvhXjkd
	 muV89TOOMXhSg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 774BE380AA60;
	Fri,  9 Oct 2026 00:00:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] rndis_host: enable RX aggregation for OnePlus Nord CE
 2
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179150400601.486235.366656655922837646.git-patchwork-notify@kernel.org>
Date: Fri, 09 Oct 2026 00:00:06 +0000
References: <20261005074852.76818-1-asrokasjuras@gmail.com>
In-Reply-To: <20261005074852.76818-1-asrokasjuras@gmail.com>
To: Rokas Juras <asrokasjuras@gmail.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
 gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  5 Oct 2026 10:48:52 +0300 you wrote:
> USB tethering on the OnePlus Nord CE 2 (IV2201, USB ID 22d9:2766)
> running Android 13 has download speeds of approximately 2mbps
> with the default 2048-byte receive limit.
> 
> The phone's published RNDIS code only enables packet batching
> when the computer reports a receive limit above 2048 bytes.
> Testing shows that increasing this limit to 2560 bytes
> restores normal speeds.
> 
> [...]

Here is the summary with links:
  - [net] rndis_host: enable RX aggregation for OnePlus Nord CE 2
    https://git.kernel.org/netdev/net-next/c/f688218baa71

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


