Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A78F1FE471;
	Tue,  7 Apr 2026 01:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775524831; cv=none; b=AtU/3WDQJ5Lk0wKoDoGurDTBO2/3wT8JuQpP6agDuqR35KVNrXfgon61OqDfUBBfdPSAfrYgSNQNjY0Bqryvk/E8UVUfLgnfEwhsD8IN06cY/oKVPSzKMY+BIQROEcmttUhlYesp5rJvSAa/WbIqE7bY0bh/OoEZJCMZm0Y+Nfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775524831; c=relaxed/simple;
	bh=tliBJzA0Oz1ud3vn5ENeXWBS87IYNsaMC4U13WYAZR4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dRptf+dWDJwonMMOFrXo0GIkKASzh2+qySJPClTs8OLam30UYJCFbH/WeAlHUKWRtY8hsQdwtDaChQmZe0vffps/paZ/4/EAmd1fJn1SjjNYcAESJUEouRhcSV/2rJgrQQeqE1QUY9FOsef2YsKmcCRlMqJImCmoDLvEg9T7T3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ee28lNcd; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ee28lNcd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9323C4CEF7;
	Tue,  7 Apr 2026 01:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775524831;
	bh=tliBJzA0Oz1ud3vn5ENeXWBS87IYNsaMC4U13WYAZR4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ee28lNcdRgwWDm3Oup4XJv5WcNTMSNqprnq/jbzwATTEgk6yr2NgkM/kwIRTA6K/P
	 D13VWzmL6bUvfx8hepN8Y4uTzqhZI94cOFkMy4OodbKTNrqHoG1iaotHFk1UlG7lIb
	 09XbPcerKQHuf2dxPRB1lkFbC4BQdRbTst6b4pTNCk8jpkA6dYaVKlX+yZwdR6iAWZ
	 B4YVhlwf34CC81v3caRWPou67nvw3ixwA8bg9BKIa9cn0e6ucInLNQUhANO4Yo5DYp
	 GUx4LvE/0gxna2cOJhBs1Sn3OfgJYmrErMglxVqCTbhMeJIwfXAkmgFKCM9RH+JA+a
	 SJHgUZVNL8fIQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CDD53809A28;
	Tue,  7 Apr 2026 01:20:10 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] psp: add missing device stats to get-stats reply
 attributes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177552480929.3328957.15711154154667874515.git-patchwork-notify@kernel.org>
Date: Tue, 07 Apr 2026 01:20:09 +0000
References: <20260403-psp-yaml-fix-v1-1-dacee0663903@gmail.com>
In-Reply-To: <20260403-psp-yaml-fix-v1-1-dacee0663903@gmail.com>
To: Daniel Zahka <daniel.zahka@gmail.com>
Cc: kuba@kernel.org, willemdebruijn.kernel@gmail.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 donald.hunter@gmail.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 03 Apr 2026 03:26:31 -0700 you wrote:
> Commit f05d26198cf2 ("psp: add stats from psp spec to driver facing
> api") added device statistics (rx-packets, rx-bytes, rx-auth-fail,
> rx-error, rx-bad, tx-packets, tx-bytes, tx-error) to the stats
> attribute-set but did not add them to the get-stats operation reply
> attributes. The kernel reports these attributes in the reply, so
> list them in the spec to match.
> 
> [...]

Here is the summary with links:
  - [net-next] psp: add missing device stats to get-stats reply attributes
    https://git.kernel.org/netdev/net-next/c/c8eee00c0fef

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


