Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE5F24468C
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 22:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775256632; cv=none; b=EzkYbfVkRB/3OAIzQYnN3s+hAiWT3qfJLUnh/HJ1iX31EzDPHZ+NleN6bwLyTJXS1TB0OuPE+8bADUd+smdj670Vu/S3nd2+zZ13CXkKUQ1tjKVfdxDNGhpvHmsiOe/W0AU9M0E/ssadna9Adb+lbXgmRtpK3M6aW3w+Vab0VI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775256632; c=relaxed/simple;
	bh=3OQ8s+7be93fFZ1UymG7xFK7jMJk0IP3P0i98gQ65RI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fXj7lQoypKDnTrQFRxtiOKyvTnXw2icUsAh+yiKtHLoUpJvc2NF2Ky5dzimKmahi++P8DiXdtUeFedXX5Xw3koiWzZWUUf1YvbIYcfp765YSWmk1rqelE4i05yS7Wu0a/zW0To1tbdYE9l8N+vl1CtDnLI7ePysbHv6hK23+3j4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7L1zjs8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7L1zjs8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21B0C4CEF7;
	Fri,  3 Apr 2026 22:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775256632;
	bh=3OQ8s+7be93fFZ1UymG7xFK7jMJk0IP3P0i98gQ65RI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u7L1zjs8CKDl0sN3InNuSsn0Ko0YOm0kBwcJxRddE9zAYC0ACw0O2meEp4RVdVM0g
	 I5Csjy82EcIbi9HfCCyK3x8QNnCEgLEf/NNUEP3Cm1ddET2BENtZr2Gl9vEaChIAkT
	 LxXvaUPTahzVVMK4c6PsaFSP55md5JhZsIpsImPBmfvO4+hiRNLfZ0uWu4sAuibCGS
	 YZN2Fxy6fVkvGK9wOB5j7k4AvielvHtC85XHezo22aYKTAL0y9Y97ho7svEou+Ar0A
	 7eDXRxGmKXvnwDUH6vbFvkUe9dajnJvYRbVT6UQLCKjqRWos3bD9D2YNzWVyhu9Ulx
	 trMLqItIY8WjA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EE93809A14;
	Fri,  3 Apr 2026 22:50:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2 net v3] ipv4: nexthop: avoid duplicate
 NHA_HW_STATS_ENABLE
 on nexthop group dump
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177525661354.1479823.509223355601192833.git-patchwork-notify@kernel.org>
Date: Fri, 03 Apr 2026 22:50:13 +0000
References: <20260402072613.25262-1-fmancera@suse.de>
In-Reply-To: <20260402072613.25262-1-fmancera@suse.de>
To: Fernando Fernandez Mancera <fmancera@suse.de>
Cc: netdev@vger.kernel.org, idosch@nvidia.com, petrm@nvidia.com,
 horms@kernel.org, pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
 davem@davemloft.net, dsahern@kernel.org, kees@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  2 Apr 2026 09:26:12 +0200 you wrote:
> Currently NHA_HW_STATS_ENABLE is included twice everytime a dump of
> nexthop group is performed with NHA_OP_FLAG_DUMP_STATS. As all the stats
> querying were moved to nla_put_nh_group_stats(), leave only that
> instance of the attribute querying.
> 
> Fixes: 5072ae00aea4 ("net: nexthop: Expose nexthop group HW stats to user space")
> Signed-off-by: Fernando Fernandez Mancera <fmancera@suse.de>
> Reviewed-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: Ido Schimmel <idosch@nvidia.com>
> 
> [...]

Here is the summary with links:
  - [1/2,net,v3] ipv4: nexthop: avoid duplicate NHA_HW_STATS_ENABLE on nexthop group dump
    https://git.kernel.org/netdev/net/c/06aaf04ca815
  - [2/2,net,v3] ipv4: nexthop: allocate skb dynamically in rtm_get_nexthop()
    https://git.kernel.org/netdev/net/c/14cf0cd35361

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


