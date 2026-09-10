Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0162D343889;
	Thu, 10 Sep 2026 01:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789002671; cv=none; b=L3cz2bVZLLGqYM96aBDJEv2RQ1XEaqGRtLsrlh+JigWqTjmyviLSNTkuRgc7b5133caoFPnuijxo1SGfHUQQrmm7CAUIXHUBLoBDkyV543zeWRUy2Pr+cuOx14sTQzkbOKJGY0h1BgaEX/OM6C+ujaQZ0tMCQJK77KLnnLuuCsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789002671; c=relaxed/simple;
	bh=Y5hYve4Y90iVWV180+aX9/oP7ri7RPj5Za31LJsKJo0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XMbgfbc3SLZz/L3Ke+RRPEs+6qRl3Au01J89qeQTw20+mYo05M+eargbsgIXfcdj2IC2Tm5WPIpq9lC5NwRjEh5UUH1SjddSyDLLFf9kb3NV2gVZT/B6nggrwuI9+YgA/eI74yFu+kGkr0D8VUr+ZiE88AuEts4KW0IihuWEZQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J9vvcM4N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J9vvcM4N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9060A1F000FF;
	Thu, 10 Sep 2026 01:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789002666;
	bh=6cMeRdwHydwlTv6nzCpcdEBzg+hSC68kSJ+6mcByn8Y=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=J9vvcM4NPRzj/SgQTgtyz8D1FJvdMraOtyzRsDK2szWUnwEte1NE3Uz1qv7DFOzJZ
	 dVZQ4DvH/qTOiPZ2lA5szIekw4+A8GKensv6NvmrZRApLsVld8rDAaTFKAgR4qwLi0
	 wXCq6DWuOCypH/KDXB2pjcbxoqOLf44/vEi65ne3I7K4WbqX1cLuvQqNWNSELa3Ya/
	 gwIKHbJmywzVuziAKV6MuhLVg4oSEGAI4dMzJdK+kVtbrBfSnRE9VmDSkrHGQFlUpt
	 48mO6f8XdFUIRe3T2Z44BA7GJCcKiKK421u4VuNHLcJvP6KjebXCWx8ZFVacr5UDqG
	 nr6o4CypTNb7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 93EE4380CEC5;
	Thu, 10 Sep 2026 01:10:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [net,PATCH v2] net: ks8851: Fix receiver error in 100BASE-TX mode
 following software power-down
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178900260440.1135028.1530130021791716498.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 01:10:04 +0000
References: <20260905130327.203851-1-marex@nabladev.com>
In-Reply-To: <20260905130327.203851-1-marex@nabladev.com>
To: Marek Vasut <marex@nabladev.com>
Cc: netdev@vger.kernel.org, bigeasy@linutronix.de, davem@davemloft.net,
 andrew+netdev@lunn.ch, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, ronald.wahl@raritan.com, yiconghui@gmail.com,
 kernel@dh-electronics.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat,  5 Sep 2026 15:02:32 +0200 you wrote:
> KSZ8851 errata sheet DS80000716D-page 4 Module 3 [1] states that,
> when issuing a software power-down (PMECR[1:0] = 10) followed by a
> power-on (PMECR[1:0] = 00), the receiver circuit can fail to start
> properly preventing communication. The Transmitter will still send
> data, but no data will be received.
> 
> The errata sheet also includes a workaround, which states that,
> it is recommended that the software power-down feature not be used.
> 
> [...]

Here is the summary with links:
  - [net,v2] net: ks8851: Fix receiver error in 100BASE-TX mode following software power-down
    https://git.kernel.org/netdev/net/c/66ef5adb7544

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


