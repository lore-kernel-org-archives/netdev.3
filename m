Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 412443E867F
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 23:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773789615; cv=none; b=B4jBc4T9IAljD5n9S4qbzqEgTGlZUxUjQoSXn7VWnNenh5grXkurUhLBS+3jhCEhg/wgIO0c8BUTPMcK0lkezQuZ9NKEnUKuS2UY0HnTv/zbcUGwscd5hkwSpwowuOucKVjFhUZS842p4lWdgdJUX8ZGFB2PFngPldrnydb0Apk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773789615; c=relaxed/simple;
	bh=Jy+4YGuw5NQyp7O6+udbEhEn18kCkgo2cgPUYVx6aF8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Bvgzas3lV+cp1bXvzfgxTr2TkX6xTMyeQ8fJUqM10F0icnAib7GDLjo/GUUFKPqy+leA177LVYGgXcUlSCJN4b1Llxtk2ULr7APW/po2+U9vJw0qeWd5VsQB8fYp38FD/DQsSuru4hPUSJJpDAVucjHd9RAR7kMlv1ZCzliwAnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOiSq32N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOiSq32N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21AFC2BC9E;
	Tue, 17 Mar 2026 23:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773789615;
	bh=Jy+4YGuw5NQyp7O6+udbEhEn18kCkgo2cgPUYVx6aF8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aOiSq32Nz7A7GC4pCeNhTEt+5CYstj8FcgZNp+QjUMmvi2Ekc5oprhgsz5L7AZHPB
	 l4hphS3GwJa/cR9fkkPOE4uZBPSjkIt36OuxQ6hOKRalMUSzbUYiF750gV2KEE5dkF
	 SOjZwXLVHLpyCVwWQYBNnkQjUBxjS1N3FiBoMBECj01EpOsM52L3ke5aW3Oibn7/5Z
	 FXFHv5mrjkZdeB4XEs7ytd+U9mwO7DHvwfzIHIPqnV8wIup1/rt/O4TvWYI8EmLRgM
	 8buYUws3br/rc4OeiTQW82UnGisdDn6SUah1KFuwf8P96eLXAUZLP7Q5YsmurGjiYL
	 jFwcT4l+2IFew==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FDB03808200;
	Tue, 17 Mar 2026 23:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net-next] fou: Remove IPPROTO_UDPLITE check in
 gue_err()
 and gue6_err().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177378960703.53238.10997487692364640854.git-patchwork-notify@kernel.org>
Date: Tue, 17 Mar 2026 23:20:07 +0000
References: <20260316133127.2646421-1-kuniyu@google.com>
In-Reply-To: <20260316133127.2646421-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Mar 2026 13:31:25 +0000 you wrote:
> UDP-Lite has been removed, and its error handler is no
> longer found in either inet_protos[IPPROTO_UDPLITE] or
> inet6_protos[IPPROTO_UDPLITE].
> 
> The recursion fixed by the protocol check in gue_err()
> and gue6_err() no longer occurs with UDP-Lite.
> 
> [...]

Here is the summary with links:
  - [v1,net-next] fou: Remove IPPROTO_UDPLITE check in gue_err() and gue6_err().
    https://git.kernel.org/netdev/net-next/c/e3f741f587a9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


