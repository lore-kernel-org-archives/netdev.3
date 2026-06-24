Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B062F3C10
	for <netdev@vger.kernel.org>; Wed, 24 Jun 2026 02:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782267660; cv=none; b=csYMZjXEH7NnAEKyw8vRInft2RDnNDSlkE9uk0aNUEXJg472ku1JLYqSlRX3KJTz5PGmJpqfDfTaoofoMxOPmIVayjy8KG882yjZCM5Evvl/SoaaKOMbdrjd5TZh3wzRrBOVpw5/sJRh47EW9I9oJ0xs/3YiizT9zoA7um7M/IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782267660; c=relaxed/simple;
	bh=KecdoXxgkEHe/vAoToSERO/AnzuMccB1QYe3hCSd4rA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oghqV6OvsQg7jHZ+uikotcf64coN/5k2aauDur267RPokTF+cf7Ckj5ZToX9noonAvMwB5/tSnrwVe43Fry6xqC3T9jUmyTcc5p8e5KAAbwoDzA45zUAoLksDVMPVz6upZAtAInZKmXLjZ/RGRuh/ebtKVohDMwM4ajceqwRESo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S4QnyQzg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S4QnyQzg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65A7E1F000E9;
	Wed, 24 Jun 2026 02:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782267659;
	bh=ofqKdxfHUw9bPXkBRD1S6ZdNbIerNsJQeKshKvH0Ce8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=S4QnyQzgviwg/uogEJAuDnp3j/4EOjH+t41IqxDEYRcgoUqD0oyz42itCdIoOH9Mf
	 jeEly7eZZ0ouTn1k0KFh5b/UDm6iXc32gPB8NtClLZq9opv7plyJiyr2xdjGOkfb7i
	 icxMFyfwwfGGTCmYRilASwH+EvoyXu2MbEgjQwbnpMlwb9duWLvfdRb+W5KFDPubGM
	 ccwCcpZMT8B4IByn0JJP+eO40BmEi2fUUTWCpMjtWPd2xWNhO0iYyQZOSLIlGErF+P
	 aQDN0L0rzDO2ea8EH7d27f0Yi1AwuBpCY0/smvKPX7tEEVv+Aw0TapCzvuIp5s/A7t
	 E2Zb6VftUZGxg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0A79393102A;
	Wed, 24 Jun 2026 02:20:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/7] ipv6: fix sysctl error handling and missing
 notifications
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178226764846.2513445.16075321073161029521.git-patchwork-notify@kernel.org>
Date: Wed, 24 Jun 2026 02:20:48 +0000
References: <20260620161850.7114-1-fmancera@suse.de>
In-Reply-To: <20260620161850.7114-1-fmancera@suse.de>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, nicolas.dichtel@6wind.com,
 stephen@networkplumber.org, brian.haley@hp.com, horms@kernel.org,
 pabeni@redhat.com, kuba@kernel.org, edumazet@google.com, davem@davemloft.net,
 idosch@nvidia.com, dsahern@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sat, 20 Jun 2026 18:18:43 +0200 you wrote:
> While working on a different IPv6 patch series I have spotted multiple
> minor bugs around sysctl error handling and notifications. In general,
> they are not serious issues.
> 
> In addition, there is one more issue in forwarding sysctl as it does not
> check for CAP_NET_ADMIN for the namespace. I am keeping that patch out
> of this series and I am aiming it at the net-next tree once it re-opens.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/7] ipv6: fix error handling in disable_ipv6 sysctl
    https://git.kernel.org/netdev/net/c/c779441e5070
  - [net,v2,2/7] ipv6: fix error handling in ignore_routes_with_linkdown sysctl
    https://git.kernel.org/netdev/net/c/cf4f2b14401f
  - [net,v2,3/7] ipv6: fix error handling in forwarding sysctl
    https://git.kernel.org/netdev/net/c/058b9b19f963
  - [net,v2,4/7] ipv6: fix error handling in disable_policy sysctl
    https://git.kernel.org/netdev/net/c/3e0e51c0ee1d
  - [net,v2,5/7] ipv6: reset value and position for proxy_ndp sysctl restart
    https://git.kernel.org/netdev/net/c/6a1b50e585f0
  - [net,v2,6/7] ipv6: fix missing notification for ignore_routes_with_linkdown
    https://git.kernel.org/netdev/net/c/17dc3b245de4
  - [net,v2,7/7] ipv6: reset position for force_forwarding sysctl restart
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


