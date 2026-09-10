Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FE5C31F9A8;
	Thu, 10 Sep 2026 01:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789002077; cv=none; b=pgEAPGR5+Sce1uNA/MC2zYWSAlfltX56lw47buAMXpAZlZK9LVDtwr3KALFx6e0fYQYIHc4P/2zhQxgC3I2TNOhYB5jgPqP/NbUmfXYxlNiHAn+X7TqMbl/eZxGoeAoy2QRXeQTjRQVfdA3/mX3O7EffsA5KGJPI83IDrnz7e/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789002077; c=relaxed/simple;
	bh=Ptn+GgnVLbbkd/sP97R4fjfkBeuOAoYCDUjYGJK5zdk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pTnf9rE4WyQP2feMV4QZ076TKiEKKLIjc7J3ys/E0ZDhBng361OVC+2o9/Mq9h2+Ck/QLPkWrlD9v64GmnQecGS9O3rkGsZKYEgr4D+3NUX4Ze8IhPfDDg8K4rXR/ZUs/kmGR+zMnR3dPE6p+NU57H45aslT2p//zjagVNJ+OYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R9Ll7a/7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R9Ll7a/7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12F8A1F0089A;
	Thu, 10 Sep 2026 01:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789002076;
	bh=+fWzwz5fSEYA5D9sfwfL0DKKi31jx7ftgDv9A8MbtqA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=R9Ll7a/79ru1gtXD8Z452sTegu9jMDunC+rPms0IrehTisLlfvLN7Kn2ymXiXsgyp
	 CZ/tOZ4GoZy5zgb6Z6drtTS4sDJj5bTokrBw9FcaGV3PqWjk//msJBD+X60LN/6WtB
	 lfjZJCovGVTtoRgx6Eh3CCjfkOmgufIy6iaI260HtwpjRBBvzsH1JDnFTI0bgoBDXn
	 T2joMxBGCSJWOpPoyQAlpivjBS4lkFVGQTQnchnoStSE3L9joJYZy46LfA3yHnLva0
	 5mKMmjjlkp3ISbO0YRhb7lL/sr4saNqEvKco/wDtLq1Ua+gyVJzLRBPO5nhS8zxdrC
	 Nvx5DYtDSTFLg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198DE380CEC5;
	Thu, 10 Sep 2026 01:00:15 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH iwl-next v2 0/4] intel: fix typos in comments
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178900201362.1131357.10028347424643768946.git-patchwork-notify@kernel.org>
Date: Thu, 10 Sep 2026 01:00:13 +0000
References: <20260907095446.27290-1-hemanth.selam@gmail.com>
In-Reply-To: <20260907095446.27290-1-hemanth.selam@gmail.com>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, corbet@lwn.net,
 skhan@linuxfoundation.org, rdunlap@infradead.org,
 intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  7 Sep 2026 15:24:42 +0530 you wrote:
> Comment typos across the Intel ethernet drivers, split per driver.  Found with scripts/checkpatch.pl using the
> misspelling list in scripts/spelling.txt.  Comments only, no code
> changes.
> 
> v1 went out with a bare [PATCH] and a "net:" subject prefix.  As
> maintainer-netdev.rst asks, v2 designates the patches to a tree, and
> each subject now names the component it touches instead of "net:".  The
> series is rebased onto that tree; the diff is unchanged.
> 
> [...]

Here is the summary with links:
  - [iwl-next,v2,1/4] i40e: fix typos in comments
    https://git.kernel.org/netdev/net-next/c/42fe5a08078f
  - [iwl-next,v2,2/4] ice: fix typos in comments
    https://git.kernel.org/netdev/net-next/c/e2700f56c33e
  - [iwl-next,v2,3/4] ixgbevf: fix typo "enble" in comment
    https://git.kernel.org/netdev/net-next/c/47ea470150c8
  - [iwl-next,v2,4/4] Documentation/eth/intel: fix repeated words in comments
    https://git.kernel.org/netdev/net-next/c/f3056082e084

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


