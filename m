Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BEB2046A5
	for <netdev@vger.kernel.org>; Thu,  9 Jan 2025 21:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736456420; cv=none; b=VNFKewdXBl4y7BR6n5FDxY0X6WWrWju89adSsRzvILgVfCaPGQ3gHyNn7ipKYbiJzKoZYGfOcPvRulJ07izr0Kab48pkrMNQpGrcv+GjSFguHOcwyY9nWzK+/yGjlVJvr2dOC3hcS3O8GrW8JGCBe3rt2ZR1+D/Trh+E9LKA0WE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736456420; c=relaxed/simple;
	bh=SodDQeT0XW6rGQzAuAb1e+NnN5svEGrERO2cxzDAk44=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=hiH8M+pSDgQ/HnPF83EiiqlUCJR7FWfCsC7rvhKRHhjt8xjFfVDf65wURhGd1RXipJBo4hxU4Dat/zyrYm1CVwhVYPCl0zm8+1vjiJc5nJgMKNIDUWkSvcnc79yNFhnnQPvJ7iaMiOTaZ7R3UmbWe0rcSRb7LSQM8l+woVC8csE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWHgRIBi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWHgRIBi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77878C4CED2;
	Thu,  9 Jan 2025 21:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736456419;
	bh=SodDQeT0XW6rGQzAuAb1e+NnN5svEGrERO2cxzDAk44=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LWHgRIBiNYf9ecETSQosWV+q6MSJ9pwK4QLN6rMGIuuqsJkP5mkBvuljEmwI0IWsE
	 1isgif9cm4gEVxg5GQJkGm7+8nF+XyILR+2CK1+9Lw87ZmfJ9iVFAUuGmFIAB8lB+s
	 yetk6QrnL7GDPg5sf82MEvgSrLqdxE1SyXEhyValenTAHgSWqqx1oxWoLt8uL7fRj7
	 mJnEjFnOJiX2V5d/dU0WlteFEcin3dPpfcV0TwtBte3BY5YXG3ePGC7lOPpo1P0JEV
	 GU33tM6KYf5ZQqZ+hnnDuLbHqZyZvgNBr7ln/Xw0l4StS+CjgmB5PbgkO39632as3I
	 DQVmBu7EnZtUw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7174E380A97F;
	Thu,  9 Jan 2025 21:00:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] tools: ynl-gen-c: improve support for empty nests
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173645644099.1509145.3913393807416069765.git-patchwork-notify@kernel.org>
Date: Thu, 09 Jan 2025 21:00:40 +0000
References: <20250108200758.2693155-1-kuba@kernel.org>
In-Reply-To: <20250108200758.2693155-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, dw@davidwei.uk,
 donald.hunter@gmail.com, nicolas.dichtel@6wind.com, sdf@fomichev.me

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  8 Jan 2025 12:07:58 -0800 you wrote:
> Empty nests are the same size as a flag at the netlink level
> (just a 4 byte nlattr without a payload). They are sometimes
> useful in case we want to only communicate a presence of
> something but may want to add more details later.
> This may be the case in the upcoming io_uring ZC patches,
> for example.
> 
> [...]

Here is the summary with links:
  - [net-next] tools: ynl-gen-c: improve support for empty nests
    https://git.kernel.org/netdev/net-next/c/93e505a300aa

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


