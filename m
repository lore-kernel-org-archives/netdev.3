Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8146514B950
	for <netdev@vger.kernel.org>; Thu, 19 Feb 2026 00:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771462214; cv=none; b=bxk/vBuRHwmAN1d+hSYrWXJ72J5IZ1rmwB/pvVXxYT9oov3kHlqH8vBNskwVhdBs4nhZeejVDujCTsQbPiPvNJEq5MjISed1dxx9dcQ5BJkcZ4LNvsagK+m0n4GK4GkLKsfKET4iUCoXcG49UX3JUQFNi/9W2pvwui1r9P8MJt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771462214; c=relaxed/simple;
	bh=tPc8i4DHmTtgGcoimT2DYgQ54rjfJz8241PdtTjsj+8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=s694QdA0R9xSQWeYg5HFP0i3CgOru9Jy3wKrITsBz8QXyadYFRJnlLRIC7LcrWu/Y5eCpB6bIxt3yVcKfouwIctCLOpWCG2HysLqK6yuXIsmfftKlXyxXntMp8CUo1+6LYeQ2O9sj2GIzVDm5dlDww3Sg2uEZuIBkaV8DIbFL3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A58uQCZD; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A58uQCZD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16834C116D0;
	Thu, 19 Feb 2026 00:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771462214;
	bh=tPc8i4DHmTtgGcoimT2DYgQ54rjfJz8241PdtTjsj+8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=A58uQCZDSaiZjgTH13ArMOVFWDYCJbblY8eIjZy7NiOdSBhjEdjHTgXny+eBaJFQ9
	 nn+xRHE5z9JVhwc8r7h9hjYycxc9xsg5VRQToeHc1zcONH+VDtiF7aWNzlJ52kKofa
	 E1YJOVaZwRqueYuy2IoXAxsJEY17IWqQhY8RLQtnsjUMju7uiOguTaIv0Dq2PVrISZ
	 zbiAESjUaTuHs48jbzejf64sW/8tSI+E35r7nqLicp03L7z7x+TOfplw7k1i4pXnpa
	 rt0WjEbcG6n4Luk5M8GRtJ41ATGjX1zSy6C/XZnDBv5dpZdJCEW2/1Rj7dswjsrFQH
	 UPqf5eHVbkEKA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 852F0380CEE0;
	Thu, 19 Feb 2026 00:50:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests/net: packetdrill: add ipv4-mapped-ipv6
 tests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177146220533.1618281.4180487651837873905.git-patchwork-notify@kernel.org>
Date: Thu, 19 Feb 2026 00:50:05 +0000
References: <20260217142924.1853498-1-edumazet@google.com>
In-Reply-To: <20260217142924.1853498-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 ncardwell@google.com, kuniyu@google.com, willemb@google.com,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 17 Feb 2026 14:29:24 +0000 you wrote:
> Add ipv4-mapped-ipv6 case to ksft_runner.sh before
> an upcoming TCP fix in this area.
> 
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  .../testing/selftests/net/packetdrill/ksft_runner.sh  | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Here is the summary with links:
  - [net] selftests/net: packetdrill: add ipv4-mapped-ipv6 tests
    https://git.kernel.org/netdev/net/c/570e4549f632

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


