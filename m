Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A483A3826;
	Mon, 31 Aug 2026 09:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788167464; cv=none; b=OIgfEHdc2rp2XAsXbnuum8J8bhSUVQDD5afXQYCnBob1aTgR6b4cByzRASKH9Vt6DcwB02HvsMbty8qP9rXp4YHHEtRGG9vFq1vk80sdmp0X6GZfaKd1dPXWTioE4NfUTgyZ0tQn692fPs3HwdzWZjwwZ0BhCXaToMT9gGhP4TE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788167464; c=relaxed/simple;
	bh=SY4YikWVvQ6SCXsDVFu7kxZPLs48OZPoQ/Mjs9I0oIE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WKvrgllfg8dOFIM5Duyuhvp+6FYrnhAGaIElQ5Fw8UApJyKLwZTwMEHlr4zPKvSu/c2bvY5F7uFNbuQ+0LVv5sFrOtXOESLOxH0vFA2aDk1byQaG5sLiQW/S3vMWk6E+cfksqjNngyEljFOj9P1e2wMFiDdYIu7CDXYxAEGtER0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VHIE2X3/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VHIE2X3/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93BD11F000E9;
	Mon, 31 Aug 2026 09:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788167462;
	bh=C9+3ntl6gDf30XDx2u7J2NbyAz1jSEmLDZfvwZVBLwU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=VHIE2X3/y5s+RNmglpJcHTiFSgs9HwBOir2rTiNVIV21HX5ZWsn2yeqE/LRn8TVPw
	 L2vCgnq0g9lGB4gsuHtQmBwzrBh0DQeRLl3p4iPvSBdT3jsoQJ8TLjXiZcSmOobxOU
	 3+ylcLxemDJek8TTiur+D9QoV1zw8nfElSg9v9zK01OcFuEDM4jHaZB2LRXeDtS9HQ
	 Q29p+8I0AaJvAxzXYBXs0peKENd63nYdAhGe1AOLIciFannbUDUQO80DaiUAGG+cfG
	 DzCNSYvf5SZ4CymZe8PMoKhIEncYVfcK+E2TavawQ1E5vFLiXEjMcNNlyAGYtY05ck
	 Dbq/QZpiMG8wA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19A69380DBE7;
	Mon, 31 Aug 2026 09:10:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] octeontx2-af: fix CN20K default MCAM rule removal on
 port
 cleanup
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178816740590.4159632.8782205699345652438.git-patchwork-notify@kernel.org>
Date: Mon, 31 Aug 2026 09:10:05 +0000
References: <20260825051725.3732440-1-rkannoth@marvell.com>
In-Reply-To: <20260825051725.3732440-1-rkannoth@marvell.com>
To: Ratheesh Kannoth <rkannoth@marvell.com>
Cc: kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, sgoutham@marvell.com, kirankumark@marvell.com

Hello:

This patch was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 25 Aug 2026 10:47:25 +0530 you wrote:
> From: Kiran Kumar K <kirankumark@marvell.com>
> 
> npc_mcam_free_all_entries() disables every MCAM entry mapped to a
> port before freeing it.  On CN20K, that also disables the default
> broadcast, multicast, promiscuous, and unicast rules, which causes
> packet drops when all rules are removed per port.
> 
> [...]

Here is the summary with links:
  - [net] octeontx2-af: fix CN20K default MCAM rule removal on port cleanup
    https://git.kernel.org/netdev/net/c/1376afc7660b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


