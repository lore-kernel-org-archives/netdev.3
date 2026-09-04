Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086883DB332
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 23:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788564077; cv=none; b=g00TlF+rWfMVpQZeSw527CCwR5qexzLMg19f2BjwwsrkUp8g9rlS/DOSvkl3y/GhgBZwUqfJXE5m6qn8KXIJUaeH3Na79AU5upVFHqMqncRoyCt59zauY7By27G16SauKFq8Ze6LuQcvJQe8uHCulMOEoBaqhZ+iJi03/dOeZVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788564077; c=relaxed/simple;
	bh=+h5Ot6XipqSjLIGIPy+iMHEoRrlklPtP2F9Yfah4gcM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oRda4XQ2568V+xGaHGcXfCOoWR9wwJ9+HExtAnwdJ9hKwMQcqSV+QioalTPnQxUiwCmhV3R+cDaNN+1y5S6L2PfGsmnWK+mY44a9DzJi+sO76q/J6xGsf4zHWqIru7d1AOKRQECLQpKqjnvCHG3qdPZfdx+jkoxE25H2oxUlhhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rl3rkx6d; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rl3rkx6d"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BADEB1F00A3E;
	Fri,  4 Sep 2026 23:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788564075;
	bh=bsPwDzXditYGw/xq4UCwqnTGRpftRkMknLQTkRstmQI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=Rl3rkx6dAOUMUD5tkbqTt5j6NC2v2CVe/VHmCP/bbF5Ir+cSiGFHT7gCcf/TfpC31
	 Y7p7IDU+5llxyQ5Lt33GzrvTOUsbRt/ejyPuSAMCzNmF9SSLJo3qxObonlCn3kfHeD
	 nf+9SPzBWDaq+Vj099lURScBsRuVm85Jn6wOp6kQFIYniLmPksa5XNHXDOlmlNNugW
	 2yYzWHtAu1vQKtXlinMCQNs07Yy3AjwvfJToVECRxrTiAA//mOX/oJOumOmPZoa++K
	 BhIbg/eyxmUcrhCL89QH2gARYfts7l/GZaepreZia6ewT/6e7t9SgswYuIz4HPdv9w
	 t0tKNGykOkqZw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 938AF3924A7F;
	Fri,  4 Sep 2026 23:20:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] netdev: avoid skipping objects on race with
 device disappearance
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178856401614.1013351.11404992028614421992.git-patchwork-notify@kernel.org>
Date: Fri, 04 Sep 2026 23:20:16 +0000
References: <20260903221154.3359889-1-kuba@kernel.org>
In-Reply-To: <20260903221154.3359889-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 bobbyeshleman@meta.com, daniel@iogearbox.net, razor@blackwall.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  3 Sep 2026 15:11:54 -0700 you wrote:
> If the currently dumped device disappears while we were mid-dump
> we will get the next device without resetting the sub-object ID.
> This is quite unlikely, it was reported by an AI tool not a real
> user. Let's fix it for better dump consistency.
> 
> We only intend to cover the case where device A disappears
> and we skip over sub-objects of device B which was stable (B existed
> before and after the dump). We don't intend to provide stable
> results for any device that gets created or deleted during
> the dump.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] netdev: avoid skipping objects on race with device disappearance
    https://git.kernel.org/netdev/net-next/c/761ae184f850

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


