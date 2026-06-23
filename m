Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4209637B011
	for <netdev@vger.kernel.org>; Tue, 23 Jun 2026 01:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782179422; cv=none; b=DBrX+cplB9Mh7OV99q5hOLot9qtp69ttLF6r+eHqM7FJMH3OQs/1+RUsokMiP+6hzNyZWRp7441/qQ4LhGUx1snjDTbVM07DsDK4s6frRzfyOn+m5Qn2WALwO0lMUtleDV46+dHlo2jLadfsh1H9dn4aDMtaDJNjdjxDZGxhIqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782179422; c=relaxed/simple;
	bh=kWACsxTpXNpykEBCU5q8AHx5IQArXlAu2VrsYU8D/kA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=UmqkUf6TjrOAiZ463xX6lKhV+oIThWk1hJpGXz72NI6Cs0UmiX+WxvlPLw70GZW/DRC2X6tISt85T3c92GQD3fg6kK5Q+iIoujU4BEbC/NVUfQnyo1ZrMLpODoxqfYAY+5pNSGswbfaMv+p2f0iPYTu9XZyUw/xY2XovnVLhZGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CmMGfp5M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CmMGfp5M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A081F000E9;
	Tue, 23 Jun 2026 01:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782179420;
	bh=MgV3A0z68J02yKfbcLS+1+NrNtmGJJEdD8OBYFhKreE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=CmMGfp5MqkETquWZfuifPfG3o6MDn4s1k4YE7F1mD01+4Q8TxEfmwNMUdACgtBuUj
	 xOLDMKGydMwPjP0vSJOBlbJGOpTFFosRibvuBZjtm3Hw/fyd0hqypBbrgt0x3Tr4vf
	 jjdZw2ZShaaWXMqecJSULJ1mw0OZhjpYta908pLBarn8TJz+eu/tR5On37NvYZOm3v
	 S2RoeYXT/m3498uNORNEhZQwr2MqN+W+/zGnoBefFwwExUaESERz4BN+ZjCyzZqNMX
	 vGOqnbADywjqy/pYmiQUnevBrJWSIQliKGIKx1oKoKHDLWaFCO4Brt9qYejIihfjD5
	 b8T1Wh3sSWNDA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56A993930A08;
	Tue, 23 Jun 2026 01:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net] ipv4: fib: Don't ignore error route in local/main
 tables.
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178217941104.1502813.488643379355950272.git-patchwork-notify@kernel.org>
Date: Tue, 23 Jun 2026 01:50:11 +0000
References: <20260619212753.3367244-1-kuniyu@google.com>
In-Reply-To: <20260619212753.3367244-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 kuni1840@gmail.com, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 19 Jun 2026 21:27:20 +0000 you wrote:
> When CONFIG_IP_MULTIPLE_TABLES is enabled but no rule is added,
> fib_lookup() performs route lookup directly on two tables.
> 
> Since the first lookup does not properly bail out, the result
> of an error route in the merged local/main table could be
> overwritten by another route in the default table:
> 
> [...]

Here is the summary with links:
  - [v1,net] ipv4: fib: Don't ignore error route in local/main tables.
    https://git.kernel.org/netdev/net/c/b72f0db64205

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


