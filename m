Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873853A16A8;
	Tue,  6 Oct 2026 23:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791328833; cv=none; b=GGzlOXpaExLnARtTz1u/1DUK1y8wrPv2afxlTqf7BnqfqyUSPc0iHk9ckNkWo/BNKdFoGoe8JXasjR9Xe++yGNEIpcW8eSmuzDChg90K6wUqo0H0Gbq9OfMWQbE3afjH5y2yNzWC4VP1BsrJLAKXGEj7vXGCsHeY4NEvnOx4MRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791328833; c=relaxed/simple;
	bh=T06Dcj7oa0w0pGf2pKmjjZtgbztOhzylMw895rKMkI8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=sSAM2d6bBfAPxEfVLDSW8xdkTunxzrhRSLq/IyfF18p5XIP88FVKVvbhKpMZ3TicYSyfVQYaS3XReIuAJrZzGg+aIUdsSjkhXctwWfLuHvhLeybV2mBVjmWitHr/RJkj9zv0VWavHqqVA4NAG6z86JkLLKuWDxl2BGSMz8RR98A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B4smrN/q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B4smrN/q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0492F1F0089D;
	Tue,  6 Oct 2026 23:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791328812;
	bh=8KN+wmYmiKppuGuz1UF50cYZjZBOpoy3WOZrHHA50ww=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=B4smrN/q/uzlqHCj3LzjvNox4DVnOSFDLny5KHp//ZGsIkwEF7C0Vh/8IfZkXCyjj
	 bn9OwY9yoOYfRMvmKRlOFWei2ceRxvqnVnlq0Dpd9RAXnOxH4btR4PRpUpbD15w3uc
	 HPntW2hJZZIb2lLT9OcVJEYdDa88QNZfXMKM7cXvc/DniJNV0QUQ0eb+ETZxkUUBUJ
	 iEcT+FuV3qSM96oINj7S7E1Pj9c1Yu20+L5dQtk6HjWAvXBGztjvArTyV3Y3+xydfM
	 rudfmDVdGnhSGn9s2YOhyQ/k6nWcoQqXUIJYP6wEuTQovGJVzGHCekcsj9IqnkEEeG
	 aCJXzDdOGIq+w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F133B3806541;
	Tue,  6 Oct 2026 23:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2] ip6_gre: remove obsolete ERSPAN PMTU update
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179132881061.2823248.4901834804478631312.git-patchwork-notify@kernel.org>
Date: Tue, 06 Oct 2026 23:20:10 +0000
References: <20261002033058.358137-1-4ncienth@gmail.com>
In-Reply-To: <20261002033058.358137-1-4ncienth@gmail.com>
To: Daehyeon Ko <4ncienth@gmail.com>
Cc: dsahern@kernel.org, idosch@nvidia.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 u9012063@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  2 Oct 2026 12:30:58 +0900 you wrote:
> A tc tunnel_key action can attach a METADATA_IP_TUNNEL dst to an skb,
> and mirred can redirect it to a native ip6erspan device. The legacy PMTU
> update in ip6erspan_tunnel_xmit() treats that metadata dst as a route.
> Since it has no output device, dst_dev(dst)->mtu dereferences NULL.
> 
> On v7.2 with KASAN, an initial UID/GID 65534 process with CapEff 0 used
> self-created user and network namespaces to trigger:
> 
> [...]

Here is the summary with links:
  - [net,v2] ip6_gre: remove obsolete ERSPAN PMTU update
    https://git.kernel.org/netdev/net/c/8bc60db48e8c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


