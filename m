Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0CFB81AA8
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 01:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792201811; cv=none; b=QR9LtYytCI1Zf5ZVPWCKCEM6zacGuDAxupIDW83qEPhEelfMrhWXXoRg6+A1blTJmbytRjlL6R0FhRoMYohmPACMomjFXvwr5lmKnIjUwzgO2F5NyPFNlxWTu9sYI4v70VSc6lXB2n6+9bCIvfcYg8gxPdkPZ1O4SFg/8mMFnVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792201811; c=relaxed/simple;
	bh=DmAEta7e5zRfo5sayPFskopdP9fCSgiMBZRlKBkRmJ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=G8MqwlgVfc87j7dzi13CpAV4lonDJJv4TuDMifovdInBqFUaBsJEVbhAuTjdL0NTqNtjnjGAvx2jXXmF9esBxAEN4Ipd4AIxwyxzTlJUl3Z1+OSP8geeWSHSWiAAxu2YfBn9gLftzIeXKHqVfgfdm4vXrEgXT3d9ESk4YLDpyMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gisAuiqj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gisAuiqj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF4BA1F000C4;
	Sat, 17 Oct 2026 01:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792201809;
	bh=pJUJ86Zh6NGHo6InFR8FHuJcZ9f+snsmTpR8YvNyMWQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gisAuiqj+Ol9g0W4DFLzgH+zAmNXZlKV1wZmBTsQt/eg+x1U0+HOM7Wm40drgce4b
	 yP9q6yF/M3iY+EfpK+jVZMIhpfeM1n4ekF4MYuZ/6PiMWDBF/QlGz2Ey5jM8RgFcxC
	 xAGr7v8qlej35cZ+gG3i+LuvKmpypdEFNs1/YCkYdPP0h7jalScWwd1S0HK5IUMuix
	 f3lucaPZR/0Nt5lNQuULjTcY13EVsfhG2BdmRhMw1imukopOGJeXn7hh6ayW0n4OC6
	 MKCe8eSs14d/ishL/fk1A0wTJcVUwMlF2GwkN40dYlwZRYjfZ8kWJFBI3isb2DEiUH
	 5xvpWKWoASWSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B44CC380CEDA;
	Sat, 17 Oct 2026 01:50:09 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v3 0/1] net/sched: cls_flower: avoid stale mask
 references
 after delete
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179220180826.1055958.2315473037177977150.git-patchwork-notify@kernel.org>
Date: Sat, 17 Oct 2026 01:50:08 +0000
References: <20261012010720.2248662-1-n05ec@lzu.edu.cn>
In-Reply-To: <20261012010720.2248662-1-n05ec@lzu.edu.cn>
To: Ren Wei <n05ec@lzu.edu.cn>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 jhs@mojatatu.com, jiri@resnulli.us, davem@davemloft.net, edumazet@kernel.org,
 horms@kernel.org, vladbu@mellanox.com, sbrivio@redhat.com, bird@lzu.edu.cn,
 kanolyc@gmail.com, z1652074432@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 12 Oct 2026 09:07:18 +0800 you wrote:
> From: Yuhang Zheng <z1652074432@gmail.com>
> 
> Hi Linux kernel maintainers,
> 
> We found and validated an issue in net/sched/cls_flower.c. The bug is
> reachable by an unprivileged user in a user and network namespace.
> 
> [...]

Here is the summary with links:
  - [net,v3,1/1] net/sched: cls_flower: avoid stale mask references after delete
    https://git.kernel.org/netdev/net/c/58f7989da6e7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


