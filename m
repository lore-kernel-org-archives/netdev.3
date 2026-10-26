Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793058609;
	b=jDxODGEEfrKEMS26HhOPYR/c/+pOz2JFy/0HuZwf3oHjvbkR0KpabygrPYXOT63G4Qjc
	 kcW3GoL/MBzX720YY2ncyKBIsm85IEAgaLHNfpnNl5mEDvI0OIMudJlSfnoLnP3ZE7UzE
	 3FL5QrlZFBT5b39ToU1Gcd7pvxSdXfJqzopzWgzd/h4zdgIDgIQhcfQqEsx2Fb8ZOCpBh
	 vz8xapqLgcHA73ck4zX6BE8Hu/vbvEpuRYDuu48QDUWueb/Io8yC2SwgFCJtkxhFaJT8S
	 sMGyhpR243MOMHUnME2xsQE/OK5fkMJLRwq/1hubcFJhUSm8IsxsSf/+XH9R688mXxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793058609;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=9n+hwE+SW67KsXNZw+chpPcRTBK/Kr011lVZz/QSQw0=;
	b=jkTwj0REj6pG0XScFP6WG6GSL+7FoQMElyzXxx7lbzz4FdZKSDQfDJdY+3NACcaPpjwM
	 CmbGZn6QC21KRTpz2B7XXbwZHTdo6WGsRQUM5aDqpD/MzLuB+sz4Fn3RD48OmImtZz9dR
	 b+7jEtc0/H5RFgufaVW3kxSClnlbnR6tBP/EqDo4TJpwIg957Fpyvtsf+Q0uT67SuNdRx
	 pVZF+NdPYTcSNmfUjwZwcgF2eMt6JRi1TFcoo6RlyzD+hz+c2ofTKTm6Z5YGdY0CHosol
	 uAYMHK75sw0Bpvgh5VcDnld/GBHghf2+qsmxc9OvxbO8PctEZn4YRW7TJHncjZa2huA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UlOXT4FG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02371606A322
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 23:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UlOXT4FG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6B5F1F01829;
	Mon, 26 Oct 2026 23:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793058608;
	bh=9n+hwE+SW67KsXNZw+chpPcRTBK/Kr011lVZz/QSQw0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=UlOXT4FGjeCuwLULNdizdfpdGgO94Dk4sscJWjC/T2Ob+JLrYz9kE7jM02WZecY7Z
	 tthIA/Ej0UZNo2rN+PxYjsPE2u/YhlWguhUut/7KOYxNp06zdaiktDZcF5uJCGWkRt
	 TLrqIamCAqMQTlpMV0UHxjtkA+qbjeDlVpwI+4zGBlrIAZs59GtFsW956So+Wd94QQ
	 NHXWQZ5epW4lvdl+b/9NnsaDd3M/SqYPCkJzsjn7vm2LI/ImZjTDUKcSR8pccngzye
	 LnVCZyz8FBb8adfDfTTf0fQafMQbRth8wTl5ubjbIdjaDgUpf1tJmCbv41vEDZ+27h
	 hzYD13dSfpK5w==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 9CA313AA80F1;
	Mon, 26 Oct 2026 23:50:08 +0000 (UTC)
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
Subject: Re: [PATCH net v3 0/1] ipmr: drop packets with unknown ingress VIF
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179305860731.3465814.7868971747105773883.git-patchwork-notify@kernel.org>
Date: Mon, 26 Oct 2026 23:50:07 +0000
References: <cover.1792608753.git.zhilinz@nebusec.ai>
In-Reply-To: <cover.1792608753.git.zhilinz@nebusec.ai>
To: Zhiling Zou <zhilinz@nebusec.ai>
Cc: idosch@nvidia.com, namangulati@google.com, netdev@vger.kernel.org,
 dsahern@kernel.org, davem@davemloft.net, edumazet@kernel.org,
 pabeni@redhat.com, horms@kernel.org, vega@nebusec.ai

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Oct 2026 03:01:15 +0800 you wrote:
> Hi Linux kernel maintainers,
> 
> We found and validated a race in net/ipv4/ipmr.c and net/ipv6/ip6mr.c.
> It is reachable by a root user configuring IPv4 multicast routing and
> racing VIF updates with packet forwarding.
> 
> We will provide details of the bug below, along with the PoC and crash
> log from the original report.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/1] ipmr: drop packets with unknown ingress VIF
    https://git.kernel.org/netdev/net/c/09280680f2ea

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


