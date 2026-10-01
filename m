Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5540A411693;
	Thu,  1 Oct 2026 11:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790853012; cv=none; b=R42aBT7z9/J0wc3lMn6sgnjDcI4U1wxbK1BB0b+seSdsyvwBHQ7bxt7rjLdhKlOl6zGguwwK0UEL5CSxkwcD7itkhBCxLrqtE9h/z0zc1r3Hvcdq3AhJKe6Mk4qNvx0Ac1bvYOIZc0WC0JuqOuBhLiwo+LmRdwTajDid8VOupkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790853012; c=relaxed/simple;
	bh=oP73pYnE/Ymuhv+H9GNlTZPtIusJoT+15TuzUuGVDcI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PE8/BQESxBEhqvuK8VaVXVhYmjwACYCIYYJZbk86SiFZphUuwws0Sgl2bawvAq7qFKsIcQpLipf3fFSUWoMncwoWK31/a1NIEPuABjp/LuRHU2qqQ4MuxTl12M+wRXkUS6qZpd+u1so3TuTEdlOgsphryfriVuduzH8xHUpci/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YTSBAMh3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YTSBAMh3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 071D11F000FF;
	Thu,  1 Oct 2026 11:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790853011;
	bh=sr5fdXa3blQoQQui696yWghZgpQvKfEw+QmV5N/f+L8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=YTSBAMh3kroI9188ZRyM5LDzx8Lep1oe6V6PxVOIH3NltXLLXvanbrT0NbXv1IQmY
	 J+JtGX1xkw6MEAQ+gvXR2EwAN6UWQXirTEOP53liO1pANIIrhkcFcMPQl1sX0BXkXI
	 aJAwpyCZUXNArsW/gEM2oT4rj4QRiaOdJEkmTbIm0V0ds1EC7s3n962fM2FK+C3War
	 /Lb0DhLGRW2Gip1Jm+YD4Bn1Zim7UdOhlutU91o7ysUojtKxhwB7/6EDs594qp9Gu1
	 coPuMiRGH1JTVJwSXDpg/aeixZHZ/TnT1nbaw+L6Yd3ouf6LY0CR878o2VbElXVY+t
	 9IwFf5PQu589w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F1600380DBE7;
	Thu,  1 Oct 2026 11:10:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] amt: pull the AMT header behind the transport header
 in
 amt_parse_type()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179085300952.2398446.10198636902442122300.git-patchwork-notify@kernel.org>
Date: Thu, 01 Oct 2026 11:10:09 +0000
References: <20260928181557.85796-1-omar@blockcast.net>
In-Reply-To: <20260928181557.85796-1-omar@blockcast.net>
To: Omar Ramadan <omar@blockcast.net>
Cc: ap420073@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Mon, 28 Sep 2026 21:15:57 +0300 you wrote:
> A gateway's encap socket passes ICMP errors to amt_err_lookup(), which
> calls amt_parse_type() on the quoted datagram to see which AMT message
> failed. On that path skb->data points at the quoted IP header and the
> transport header at the quoted UDP header, and icmp_socket_deliver()
> only guarantees the quoted IP header plus 8 bytes, that is, up to the
> end of the UDP header.
> 
> [...]

Here is the summary with links:
  - [net] amt: pull the AMT header behind the transport header in amt_parse_type()
    https://git.kernel.org/netdev/net-next/c/eb0c18404c89

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


