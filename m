Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7EF7550DAD
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790083876; cv=none; b=OSmJthZ/Onld84fMZTwBKiE9iJIoI+xxyGrMg4QRBxNOHiXg31CjiEwKwrP4cE6mXz5ijFIMo4wHV6t+vFPFSME6mHBQxmUR5aBDliibrtfnPTpG7DkMkcJ5uUFiN/nC5bYoL71sacZCDoZrFzXDjmh9/MMaeuLGyV8um8nSO6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790083876; c=relaxed/simple;
	bh=uKNhiTaJSgXL4GryT5WrinMnk1JB+9Y2wH/bsVVmpQU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=SBCKIPqLYY6rx5IlQi/siVarMKDJ0UkRayUkW5gQk2GQZZ/zgU8qnSt6B7liA+W7onn9jZiPkgZBnvR8WrmURhg4pvirtLEm8eKDUm3Yt87AbP1EfM6E9c3Vexw3d/Z+iR3vOghdfadzMAFM3quqxQSoAjl89lnr4dXEx9B15P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EBZXqbdZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EBZXqbdZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0CF31F000FF;
	Tue, 22 Sep 2026 13:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790083874;
	bh=6jwscvCMyiUKeZP9py1OKVzbh4GMzRrOcokUz+rX2a0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=EBZXqbdZHKMc+5CWbK5CEUSP/OecA9P1ZftDI0qCG7tyJUiGb6UnBSBMF2AQT+RQo
	 Tyl2rKCop2MK9cSZQIcuOHR4m2YYjA4ZYueFzNDYizXxMyJTzwQUvB2iXdyjnGjpTl
	 meHycxa0vTQlxGbJQH5WxUMvNWVrMijz7t9+VjZw2k/lwksrRp38gc2GrOcZ7ZLNjX
	 AIj+dK/9982QDaDb5TBS5q//nzSQ9MCApoZ5HmX3rtncOm7J2kOvgZS5jITJxPGIWv
	 rpyKfV4cNiIq1EkAK4spf8DvVXMbNKJAbj8EypsUM9pNqVn+THYD5ImkYlwmvQ7Rvb
	 s4x7DD/sxk+oQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 197B138119F6;
	Tue, 22 Sep 2026 13:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net 1/2] genetlink: report the real command id for
 dump-only
 ops in policy dumps
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179008380590.4078083.13191066424131386086.git-patchwork-notify@kernel.org>
Date: Tue, 22 Sep 2026 13:30:05 +0000
References: <20260918222949.4190284-1-kuba@kernel.org>
In-Reply-To: <20260918222949.4190284-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 18 Sep 2026 15:29:48 -0700 you wrote:
> The op-to-policy map a CTRL_CMD_GETPOLICY dump returns is the only way
> for userspace to find out which policy index belongs to which command.
> ctrl_dumppolicy_put_op() tags the nest with doit->cmd, but an op which
> only has a dumpit has no doit and every path which fills the split ops
> in zeroes it out, so those entries all claim to be command 0.  nlctrl's
> own CTRL_CMD_GETPOLICY and NETDEV_CMD_QSTATS_GET are both in that group:
> 
> [...]

Here is the summary with links:
  - [net,1/2] genetlink: report the real command id for dump-only ops in policy dumps
    https://git.kernel.org/netdev/net/c/261e8a37ecba
  - [net,2/2] selftests: net: nl_nlctrl: check the op ids in the policy map
    https://git.kernel.org/netdev/net/c/a87529034b9c

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


