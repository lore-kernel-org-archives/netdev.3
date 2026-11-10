Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794279285;
	b=1Bk1kD6yJlTxRkzUDPNSQCD40u59qbIvJ8X3WMgaxLVVX0AHvyartFVOsmnTmcW0knyW
	 PGVodsSWqeFOnKGHB37E66Xs3x0rBUCINYRyFVW0Bh7ADkkt2SV1QvNH/mNgLVfYHzUHp
	 J/MHZjcRkjOpfewAaM8wjfgWayqF+73R/QkO1ON3WLtXVO7yCieWcYQFF87kjIMYA0nmh
	 BG52oURK4WvSFBcBXhY9swpcybVSTvuVlpm8S2DBh/2trjoEOS412c3lnZBdc6jhI5n3u
	 tVzXuDV/QJSbx1yeZgfD5l5n83xdRza2uvY2qVZ8Fwc5MQrB0DvGq2ucZsizWdeNpHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794279285;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=+jTVWBbMV4f9doxkrkGvmb9Lf7FH01stTrDXfI7hfYA=;
	b=Lx81dGaYIkHnDBH/w84IwjDNqkhHQFl8sTr6AGwJfo8mwO2SxRhjLuNQPXYXsfa5XCpM
	 Se9kCZICMt8x2heUUla5L4GrTJMxysad9l9JQurqGt5ZxMst/ld5tNRkSfIUOKo0ywvtQ
	 AE+jEU7OHJ2DUh3vZkFSEweYEOkA0ZowLxrnok9UgYK7DREo5HKZwgxwJO9OZxvdkWTYF
	 vA/btQcqwV0ijm6J+Jy4gMLoI642be32wfkzxlVsRXGWOmyOoALYMXRTDbOy/DBA/zmf9
	 uyqA/qKth0HwhHlb/YhrgB4Nozi0Lg7i7qoUKK3zfnBs/RMEO80QooqsD3BPZ/dPavQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="bnKLpb/x";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928DF606A33C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 02:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bnKLpb/x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C1251F008A1;
	Tue, 10 Nov 2026 02:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794279285;
	bh=+jTVWBbMV4f9doxkrkGvmb9Lf7FH01stTrDXfI7hfYA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=bnKLpb/x4JaDHa/mGiJrtm+4yD8gc7AUSmcsfyn+H9sBjTNJWnWeoBo2BsNrhAYK4
	 qXM6ajLcV5VzxSESTuun3c4F8tUJgCUeHaQCtRwzvyMPP3Bnddx7TM2Skz2jQm7STd
	 6nlOtLzlgNndwOJr4YMjmVmtFVR9SCKZ1YcvEAQFxbt9CQ1oSkQnrRx+V0fEe+KbAm
	 +f1SELRthrKz92OAk9bDQBfbfKxNmWcj/CEkEPoAXh9cBfSZAnf3xQMGRghBEl5lPm
	 9/G4C3ZgBzzJYjNF4nAlqj65uFCmeOCewCJypB3Jzhho0uznycdROcSXrhnuW7gOsH
	 HDRY4EJCfVbow==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 21006391AFCB;
	Tue, 10 Nov 2026 02:54:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] MAINTAINERS: remove and replace myself as sfc
 maintainer
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179427928367.3612825.13896523701701821613.git-patchwork-notify@kernel.org>
Date: Tue, 10 Nov 2026 02:54:43 +0000
References: <20261104013138.4103896-1-edward.cree@amd.com>
In-Reply-To: <20261104013138.4103896-1-edward.cree@amd.com>
To:  <edward.cree@amd.com>
Cc: linux-net-drivers@amd.com, davem@davemloft.net, kuba@kernel.org,
 pabeni@redhat.com, edumazet@google.com, andrew+netdev@lunn.ch,
 ecree.xilinx@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 4 Nov 2026 01:31:38 +0000 you wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> I will be retiring this month, so it is time to hand over the baton
>  after a decade maintaining the Solarflare drivers.
> Remove my M: line, and add Alex and Andy as the new maintainers.
> 
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
> 
> [...]

Here is the summary with links:
  - [net] MAINTAINERS: remove and replace myself as sfc maintainer
    https://git.kernel.org/netdev/net/c/343886276800

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


