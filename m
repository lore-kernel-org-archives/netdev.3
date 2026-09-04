Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE37358378;
	Fri,  4 Sep 2026 02:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788488469; cv=none; b=fIyuMy+X6alxpasAuHD85wMWbgjkUGA5KptKc/Pq630YZe3LwOVkOpJWizW3W4ZK4F+0DF20rm4yxG8A+UVrelTqXDWPfBQ6vruEPUqimQZyEwg5rto+ULyNQWYSsdgbv8lFN5z3UOtut6enA94LipYQc4qh+/2pfDhhCrMGE7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788488469; c=relaxed/simple;
	bh=crrqbHEMoVl97pgiutq+1EbjQZQuen8uwNUaHyXa4u4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=DCQjxadSxT7aeh1adBICGbp6jv5/GCg49nUUiWXsJOvaBHCH9YaJZQT4VkdWwmlJtIuOrgIKAnspfKiuZ5Zbf3UgRS2L4Pi47VJwd75rOtOb7RcIUlDPPCkINkdUJfWs8Mr11XW/GM28VKjYX7GKn/qhu1tUc09L+FRnleGPCU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/NpPzOn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/NpPzOn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49AB91F000E9;
	Fri,  4 Sep 2026 02:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788488468;
	bh=nHDic7bDU42rN4NhN4aKcwMqXd0mbFSnIpnEO6Q9OfI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=l/NpPzOnyLmwAJtiAgxtm9R9KXe7/3yz1+buR/9gEKQod+1EKN87OJRaJPZfNcx0i
	 aUS1HFXEIp0yf7BwJnGkpQCEt+IIgqY7eTnN5Hb76NGj6aYsRr27eFD7DPaFohwouJ
	 IwKfYpgvquPi0RVJPG5aKAHj8tfD2K5arHTQgwFlVEadnXohAX3PyEiPN1ltoH0Goc
	 sFKccyOzKD3R6YPMPmWIz77j+sX+/lqg9CkMjD3ZaGlhe2GqO0w2rweE21G4zxemNO
	 HP9/yGnDlGcfeMmjFZI4SthZhbgjtsf4jQVgRo56fgJIRirZmjDz93twR5v7dqXhai
	 AYhyyJmUEwc4A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9395138119E3;
	Fri,  4 Sep 2026 02:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 0/2] enic: fix V2 VF mailbox reply matching and
 carrier
 reopen
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178848840914.4121988.4620731754860691922.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 02:20:09 +0000
References: <20260830-b4-enic-v2-mbox-fixes-net-v1-0-23adf9bfd426@cisco.com>
In-Reply-To: <20260830-b4-enic-v2-mbox-fixes-net-v1-0-23adf9bfd426@cisco.com>
To: Satish Kharat <satishkh@cisco.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 sebaddel@cisco.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 30 Aug 2026 15:22:51 -0700 you wrote:
> Preserve ENIC V2 VF carrier state across netdev reopen and match mailbox
> replies to their originating requests.
> 
> A V2 VF receives carrier state from PF MBOX notifications. enic_stop()
> forces carrier off, but enic_open() does not request another notification
> or restore the previous state. An ordinary netdev close/open can therefore
> leave the VF without carrier until the PF sends another link-state
> notification.
> 
> [...]

Here is the summary with links:
  - [net,1/2] enic: preserve V2 VF carrier across netdev reopen
    https://git.kernel.org/netdev/net/c/b752e041d584
  - [net,2/2] enic: match mailbox replies to request numbers
    https://git.kernel.org/netdev/net/c/8972d252f495

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


