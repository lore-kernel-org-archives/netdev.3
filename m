Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5129E37C922;
	Thu, 12 Mar 2026 03:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773287423; cv=none; b=Ugl9cmztaTN5l/bYIU1AM9cmqOj/+JjPIi/ixblYe9dvhl2ldQzvGSdJUO05GpIdkJ13dKWR/p8J5v0m2Du3OK92cmG0KDiLpaLJxHJRhMgpOoCES+RDqw6WGbSI6OVsqO3HZd2/O72iGkFCSqnJJPGnqN0zLqtFirQ4hCv3XdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773287423; c=relaxed/simple;
	bh=mVeuWMbxckyMc3CGF5f3ACXjBKwVPSLOfHHcO/f7EVo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YBGCoCyuZIjh5PyF8V26aOxLKvCwd8HFl5VyBomgHurllAl+mKsjEvD34rgkq496EF2zhiMtV/S4T4fDOx/3uswCGx0ytJuyF/YoLj3hRi/pSllJC8zMCYDg+71OiBC5Ah4OIiuhPcWMg2D3eFVCkvcH/hutE6zb0dS8ut6BT7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvKVHaxS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvKVHaxS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E855CC4CEF7;
	Thu, 12 Mar 2026 03:50:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773287420;
	bh=mVeuWMbxckyMc3CGF5f3ACXjBKwVPSLOfHHcO/f7EVo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uvKVHaxS3VC7wYaNnoGDkBLk7LvoCxiHI5PFYBzXyLoKkYfkJEDq4OW1v6uxhdiJ7
	 /rEihjkfhuPlJzfDkYhRA9mmsa/mJq93XzodWP1MFfkczIxnn3OCPo5bHBTwdNZFby
	 eoicQDtdAdNMIwD8F4uVRax3lKdcgaGR+nw8MLc3UVVmcTCEFhLUsBhxdaMUZQ7BPP
	 /SqhjA5l/Y8xopI0G9rut08iNWq+a1rdiMge3v8uyoFxbyFqBhwPqz1xrzN7D0KWBe
	 pb7co+wJkE7LDjxwZtWZq5ws1eWwsDoxiHaYT3PVNqkAt/tQ8NtuD5nskAe8Sus1e2
	 szu9CPE4UtbMA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E243808200;
	Thu, 12 Mar 2026 03:50:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: Convert move_addr_to_user() to scoped user
 access
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177328741654.3930157.4250817401528256591.git-patchwork-notify@kernel.org>
Date: Thu, 12 Mar 2026 03:50:16 +0000
References: 
 <36d7f2e7f504d620c1b88526b25ebc89e3cb61d9.1773142315.git.chleroy@kernel.org>
In-Reply-To: 
 <36d7f2e7f504d620c1b88526b25ebc89e3cb61d9.1773142315.git.chleroy@kernel.org>
To: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Cc: edumazet@google.com, kuniyu@google.com, pabeni@redhat.com,
 willemb@google.com, davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Mar 2026 12:33:36 +0100 you wrote:
> move_addr_to_user() is a critical functions that was converted to
> masked user access by commit 1fb0e471611d ("net: remove one stac/clac
> pair from move_addr_to_user()")
> 
> Convert it to scoped user access to simplify the code.
> 
> Signed-off-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
> Cc: Eric Dumazet <edumazet@google.com>
> 
> [...]

Here is the summary with links:
  - [net-next] net: Convert move_addr_to_user() to scoped user access
    https://git.kernel.org/netdev/net-next/c/17edc4e820bf

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


