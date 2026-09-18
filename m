Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B186264612
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 00:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789690279; cv=none; b=uxpfOPGSwpESt9MipUHyfc8ZTaVnvY/qy7iYVMOe9Uy4JvgQ1qoa5lUI7lzTkRpvW9TdWe/Guo74L9GorR9RTj3Q8Bx3HHzuke/BYM7Q1SbZ4dw2bSkKj9t6mT0DYXLyUcM3rhwH42iCTG40c5fakRrzGh1KvriKjv7XJrz+UPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789690279; c=relaxed/simple;
	bh=ADi0iTYkW2WC8KcIr7YyLoB0UH9umpYNdXYeshim9O8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LEKtzRE4hBaHuRvWgjzlT5++lvek7zqeAQT9XXYzL8K6jbKyhtuUuXbENFHcOrwh/oHXOg5PcaaUMCDkTx++sbhk6xE5FXPmMQkhU2ajFewxisGIphkJ+0CeVux4u08/AuUygo2LKEmj8Flrwl9s96jV4KIRbMmZFgo6GdJSU9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nOwL/q5o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nOwL/q5o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAD101F00893;
	Fri, 18 Sep 2026 00:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789690277;
	bh=NOscFciiLzF3Nwarm6ay9OZrdTu5uL0NpdwQy5L/qGA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=nOwL/q5o6IvfTCV/C+rlkqmM0w2Nueix/uBv0NeOGnE963V/zj5getPZTW6evFfmU
	 v9313YXzngHH1OH8zQcr0mHw3l3+kOo9y+NxCyID/SQ5lhwy/VbwxO13oT8x0n0xa+
	 bsJI4SK4eQq+QZznCgbT7Yju+aPet/bb2eKHcg/QTEgapZ2ZE3gQp9o+pcnUfPJuic
	 aYGm3q5ERVITvV6x5YkKvZbRZC+cjWbv0VTGhunK8KSJIHRs9Bz3+4g6jLoKp+kZ5H
	 2EBtMjz0LtbWpT7XpNO5JlPiZ+B0g3T8NSQIK6mPt3TgvLFnD3TXB3dQakIv/nF0cX
	 wCkSdXjf0b4Sg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 56896380820D;
	Fri, 18 Sep 2026 00:10:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] netlink: specs: nlctrl: fix the policy
 attribute
 numbering
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178969021087.191233.7506922934851696800.git-patchwork-notify@kernel.org>
Date: Fri, 18 Sep 2026 00:10:10 +0000
References: <20260916021516.1701760-1-kuba@kernel.org>
In-Reply-To: <20260916021516.1701760-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 15 Sep 2026 19:15:15 -0700 you wrote:
> mask and pad are declared the wrong way round, giving mask 11 and
> pad 12, while enum netlink_policy_type_attr has
> NL_POLICY_TYPE_ATTR_PAD at 11 and NL_POLICY_TYPE_ATTR_MASK at 12.
> 
> The kernel emits the mask for every NLA_POLICY_MASK() attribute, so a
> Python YNL client parsing a policy dump maps it onto pad and throws it
> away - 30 of them in ethtool's policy alone.  In the other direction the
> 64-bit alignment padding, which the kernel does emit on architectures
> without efficient unaligned access, is decoded as a u64 mask and blows
> up the whole dump. But those architectures are rare.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] netlink: specs: nlctrl: fix the policy attribute numbering
    https://git.kernel.org/netdev/net-next/c/0fa13b71c330
  - [net-next,2/2] netlink: specs: nlctrl: let getfamily take a family id
    https://git.kernel.org/netdev/net-next/c/7c6a3f0a8433

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


