Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62D43B19C2;
	Thu, 25 Jun 2026 16:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782404461; cv=none; b=GjwAmWZCurjCzLew/7dB75P1psI0rCE8Vl4LqYXEUCwZhmCPH482Hd2jF5APiYKJL9rOEgVLWgqsmCs1kOyy9w9KUHT/5DGk4xVb2mkuJVEG/y1ovc8dRuXIW/7usZU7c129KIukbmNnag57bqs0NDJgMi7+JUsVpZWKPERc2hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782404461; c=relaxed/simple;
	bh=nHDRQ8NfLAjGY+8ytGJD3vkrgjV/b9+hGxl4mCq+KJM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=URPiyByz/sVADHEI4WFHd5XPE71/XQO7GYMJf+QEqPl4hGcQN09AhRIH1KIMUhx1CBRAzGTx0vYonPQCRaZoFpPzZqBs6AChBLaqRr4cDlae71oLQ3kTW9nPFCNZfCbSheqpao+Ikq4g6RSGjzJWbf6HKsLdmaKkS+W6xs12bqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JfflXg87; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JfflXg87"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 486BD1F000E9;
	Thu, 25 Jun 2026 16:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782404460;
	bh=EhsjmlrUPOBja0chIIjPQ4DrnaLX9UMUdaULk3xY17Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=JfflXg87rd6hsRgefEaZ90f2ISxQecfq+aEfeolTVwVTpN+d+D2uFv8HzgNZ2PBpa
	 CBTFGPt3oA/Wbo8f6pm+i5BBPurFJqW2S4M1I8cBhC1k7fuUF4gj4HtaHEjfIutx2r
	 zM1ou7iJ9fG41eas93SNIJ9SnLXAuQP/kBB2Of/aIYh2XPYXP6U8BreppyiBCvcYHS
	 J3g9Zf6PI/4wxTl3WjJc0Mrsf38joYt8HPqMebq5swjcp707V2SrZIjN2Ffs068vVU
	 pvRX4VXChst8R1TDPK/8qAZwqHEcGZkSXoB366B0QDDFaPME/BoAyt7UjOz0PVBqSg
	 j4lArwSFE36rQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 19DB53AD449A;
	Thu, 25 Jun 2026 16:20:49 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] openvswitch: conntrack: annotate ct limit hlist
 traversal
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178240444754.3803792.2094048119456951265.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jun 2026 16:20:47 +0000
References: <20260624150149.3510541-1-runyu.xiao@seu.edu.cn>
In-Reply-To: <20260624150149.3510541-1-runyu.xiao@seu.edu.cn>
To: Runyu Xiao <runyu.xiao@seu.edu.cn>
Cc: aconole@redhat.com, echaudro@redhat.com, i.maximets@ovn.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, dev@openvswitch.org,
 linux-kernel@vger.kernel.org, jianhao.xu@seu.edu.cn

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 24 Jun 2026 23:01:49 +0800 you wrote:
> ct_limit_set() is documented as being called with ovs_mutex held. It
> walks the ct limit hlist with hlist_for_each_entry_rcu(), but the
> iterator does not currently pass the OVS lockdep condition used
> elsewhere for RCU-protected OVS objects.
> 
> Pass lockdep_ovsl_is_held() to the iterator. This matches the function's
> existing caller contract and lets CONFIG_PROVE_RCU_LIST distinguish the
> ovs_mutex-protected update path from the RCU read-side ct_limit_get()
> path.
> 
> [...]

Here is the summary with links:
  - [net-next] openvswitch: conntrack: annotate ct limit hlist traversal
    https://git.kernel.org/netdev/net/c/0e901ee5c6f9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


