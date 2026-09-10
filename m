Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70CC437A4AB
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 01:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789005075; cv=none; b=jIwr5HKLzKsvj6ok8vPIworVclsCgEXyb7PpRqoUfSMjsocGJZeBRxcoBjbhZpFeV+0ZymMSvN2dNoPcnnv+YjKEKvjqLT8LxpOuYCbGRElu6x4WY3z/5BDDUNYUs6piA54ZxwHI6P28BG13WvFoQnVX0yqbbeuK4mubDh2WCrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789005075; c=relaxed/simple;
	bh=Hi7Pz3IpCJQeAXjp3lQqmSJGG/g5sAVgp/lRZToK4L4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BkOk3prtrSTQcPUbocevZ8BjN/e+4/CEkrvXDIvFkjwBrvUbztPNYAJsqYYCkBVnpMy9I2nRRTdxQIyjrER9juJLyn+3XvKd8w5OoyZ3vEy3a/zi2UCUjVrUY3bAdMr9spapoFoxiPoSsHIkv/LRw8KAcFvorIJVcoxJVuL/204=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ku+ALqkm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ku+ALqkm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCCF1F00893;
	Thu, 10 Sep 2026 01:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789005072;
	bh=j9zQSjuMGwJX1HqcxorH10dcbjwFTg4rVV1+RXlxvrE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=ku+ALqkmX7pujcG3TNgCDTWtcUwCQz3vpcABaMWtIvRgGY3F1nG0HNR7qJQo2pQMo
	 UuM0k9eZredhKP7BTwQNyDNwzWULrRDwbKvbPiMOweSpRGAmw1DyJPayXjYA/+U3JH
	 Oi97WiC7C6MnHSHsSj/T+tI/6W8apSFhnUXKAafg3+xDwzTBrn3dbVavuAuXrAKF/v
	 YlB2ZFxnsfqKmMqooTCRTLGxpZKOUuAnNDmZO+nx8sXBeIJ8zlX4yBYuYZDP78dqg2
	 K/6NoAD30XzdOfLgCg8PruPKCO+7GqnTuxH8+Mtfa1L2wmRlhwg48qAYXj6D22twYn
	 QSQjtarAZeENw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09D1380CEC7;
	Thu, 10 Sep 2026 01:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net-next] selftests: icmp_redirect: remove xfail
 support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178900501038.1147948.4377743814764640012.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 01:50:10 +0000
References: <20260908091327.349091-1-edumazet@google.com>
In-Reply-To: <20260908091327.349091-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 dsahern@kernel.org, idosch@nvidia.com, horms@kernel.org,
 netdev@vger.kernel.org, eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  8 Sep 2026 09:13:27 +0000 you wrote:
> Commit 0a36a75c6818 ("selftests: icmp_redirect: support expected failures")
> added xfail support to icmp_redirect.sh because the test "IPv6: mtu
> exception plus redirect" was failing at the time due to a perceived
> kernel bug described in commit 99513cfa16c6 ("selftest: Fixes for
> icmp_redirect test").
> 
> However, commit 0e02bf5de46a ("selftests: icmp_redirect: IPv6 PMTU info
> should be cleared after redirect") subsequently fixed the test logic:
> after redirecting to a new path, the old PMTU information should indeed
> be cleared, so the test was adjusted to verify the redirect without the
> old PMTU.
> 
> [...]

Here is the summary with links:
  - [v2,net-next] selftests: icmp_redirect: remove xfail support
    https://git.kernel.org/netdev/net-next/c/b5a252adbe4a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


