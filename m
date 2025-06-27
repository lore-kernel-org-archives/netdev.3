Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F1F828A1F2
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 22:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751064589; cv=none; b=L8nwGTE56dC6+NHHKmnL6DdeHpXNLJs559sXyTLSiR+eX1PXbFXNnrhsRuImkbHnJJ4qqjrJ+ZT7/ORPgY+FNUXHQ4tEOUzb4f5gQXWTOD/aue6shpS+KBuiCVi9ZwXXw8ynt+JpnKdfIXKJjMnpNdi0RgHUJCiyrFTDJ4/YBs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751064589; c=relaxed/simple;
	bh=e/H6on70NeYRnPwxJgWCdoJFZHsVjB6POqJJZYfWVkg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=penk8dwF4gP7Zyuzjs17DGIstEpz0Os3tdZyo8+7JRjH7eQoOuwNd/JTNXvJFQVDWq44IexHxwQeW4/KTnPLCxfiW78nvrX1aeeYjC0fwwR1iQyw0mSs0WYwqlSALtbt9CE34R7ojmckoHd5wdZ9QS4g3wd+4Fpbxdk0cFlULxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cw/4/3/c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cw/4/3/c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86FD3C4CEE3;
	Fri, 27 Jun 2025 22:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751064588;
	bh=e/H6on70NeYRnPwxJgWCdoJFZHsVjB6POqJJZYfWVkg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Cw/4/3/cgnIAzDDfgb4622VGqHmq4JLzUMBSiYHkdVnxI71SPUKphMVhgxmEh4MTo
	 6YbXaCtzHwrDrblMszUWVfa1pJvL3fM04y5e7YhvZnHBI422BApvpXxvQNkakyb83l
	 6x87nY7N12mSb1CqgEXhm9GqNOiHNcaCuv/fH7x/bkh8h+gT+C6G9Aa8D3TRMEnI5q
	 Bv4HSWAXVfi/o4N2+Eo8LuZD6ErAVgrP20l4xfilFvImffPmSWJ+y4JIz5XlG+P7hC
	 7h41bozzhMnKqKJhHNTqpFc3RdmPv/+C/UFcIWiCylMZcwCoSvyGPjwZvv8xzVtRQD
	 t1IdSrGPmz1HA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC7938111CE;
	Fri, 27 Jun 2025 22:50:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/2] tcp: fix DSACK bug with non contiguous
 ranges
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175106461449.2081565.17099512582509919901.git-patchwork-notify@kernel.org>
Date: Fri, 27 Jun 2025 22:50:14 +0000
References: <20250626123420.1933835-1-edumazet@google.com>
In-Reply-To: <20250626123420.1933835-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 ncardwell@google.com, horms@kernel.org, kuniyu@google.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Jun 2025 12:34:18 +0000 you wrote:
> This series combines a fix from xin.guo and a new packetdrill test.
> 
> Eric Dumazet (1):
>   selftests/net: packetdrill: add tcp_dsack_mult.pkt
> 
> xin.guo (1):
>   tcp: fix tcp_ofo_queue() to avoid including too much DUP SACK range
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] tcp: fix tcp_ofo_queue() to avoid including too much DUP SACK range
    https://git.kernel.org/netdev/net-next/c/a041f70e573e
  - [net-next,2/2] selftests/net: packetdrill: add tcp_dsack_mult.pkt
    https://git.kernel.org/netdev/net-next/c/8cc8d749dc7e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


