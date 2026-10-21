Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792550410;
	b=y19l3xbIaYQH0CW6denjfeKAi0os8EVgxt631C+ECtS3QOyfNyG8jMRBTUkqGpKyLqR3
	 FErRFyAlyAaGT3AJhtZ4BohhfjVyLE80tCxifPmf+aSS+kPyDllAvprduzGps9mhbk/3d
	 MuhLCZJ+srOL2Xzqbq7lSnmQFJv5OC8vNW5fYkZ9pp7qALClpmJS1PsGzBAueYsuD/b+/
	 gaUoHJQvEvl6K7xYCR+HPi1pa5AT9vTfhvMRU29Pc3gCyGkTf41F2/8EDlX1zFqtwaifz
	 a0+86IxWBa48auVhTWG5/CInpwSUQx+k/dbWhe78WB13T00xF248527JVIO5mNi4l+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792550410;
	h=Received:DKIM-Signature:Received:Content-Type:MIME-Version:
	 Content-Transfer-Encoding:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc;
	bh=kBDQ52NMVl5pJgyC6NSIMXvrvPTVtGlk+PTfnL+EBQE=;
	b=tlk7dLzmtlBH83/DUBQAazbFgmxjKr08zRaWz2Pra8gU6GaiQ6mvO7SVsWkCLfR4WXqt
	 CYW+5TZClfAuaRQynQtSHY/M8F1QPW9F5aPhImhJT6505gGdEJvc+7Cl+m4IIO1jWgVHl
	 D1nLwXkACmi8IngcUuua4GzffF/r/uzEUamgFH7DejGEJrmnfg2EqB2FcoRIkWTRqRgob
	 g4VVL2mlZUQIBpIDSauLYBW0nAGhuIcNZN5JsEsfPmQ10VHYx/fny2FyFA+79Gy6f1EXg
	 KgV5JyUO+Fyz64SReaW4OkBFQmjAitA0N8bat8ZXIPBA4GrwTn2ZuPSFtH5RO7OFsTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n11SFS1n;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 613DD606A31B
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 02:40:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n11SFS1n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C631F000C9;
	Wed, 21 Oct 2026 02:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792550410;
	bh=kBDQ52NMVl5pJgyC6NSIMXvrvPTVtGlk+PTfnL+EBQE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=n11SFS1nMbTKaHrELLVR6kAWfoLYYVXU4MZGQBlUTAXF5mvNe7CvF702Tpu+cZLqp
	 pvmjOZ5PwIs4O59SxkHsG5GHa514XHvhoDEs2duWMWgjSsjW1n7T80b9kjjMtvjROr
	 ZzAhPcoqgrHKQWXDuA19o3tdBN6aXjM1BuCQvhOZSVOKhFQAmQbJp5X+TCkueGtc4K
	 1PxmaTVos32q7fgRkU9axt+dbeICg7N1DVmwd2N6TY4pB7atmbvkGhhPpJhnM5O7Q/
	 nk9lj21YLhx8nTXhqgA2VlTO1aUDSFTTy2hECKLfQ6dmeuBNhRbTLNx+VeF4fQbkxg
	 SFDP/A6uH3YkQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F15253809A18;
	Wed, 21 Oct 2026 02:40:09 +0000 (UTC)
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
Subject: Re: [PATCH net-next] selftests: tc-testing: keep IPv6 autoconf out of
 exact-counter checks
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179255040878.341466.11667227416668197260.git-patchwork-notify@kernel.org>
Date: Wed, 21 Oct 2026 02:40:08 +0000
References: <QDISC-L9J8.v1.r0.20261014162217-1@mojatatu.com>
In-Reply-To: <QDISC-L9J8.v1.r0.20261014162217-1@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, edumazet@kernel.org, kuba@kernel.org,
 pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us, horms@kernel.org,
 netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 15 Oct 2026 16:15:24 -0300 you wrote:
> Several tc-testing cases assert an exact bytes/packets value from a single
> injected frame, but count every frame that traverses an egress qdisc (or
> match with "protocol all"). Every case creates a fresh veth pair (and, for
> the gso_skb cases, a netdevsim device) and brings it up with IPv6 enabled;
> a device whose link-local autoconfiguration runs then emits neighbour
> solicitations, MLD reports and router solicitations for a few seconds.
> Those are ordinary Ethernet frames (0x86DD) and are counted too, so the
> exact assertions race with the autoconf burst and fail intermittently. The
> $DEV0 peer of the veth pair lives in the init netns, so its frames follow
> the init-netns IPv6 sysctls.
> 
> [...]

Here is the summary with links:
  - [net-next] selftests: tc-testing: keep IPv6 autoconf out of exact-counter checks
    https://git.kernel.org/netdev/net-next/c/eeb63e1e0bfc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


