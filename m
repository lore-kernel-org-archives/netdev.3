Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 711C528B4E2
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 22:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778277674; cv=none; b=CzB8+swYh+JpaWH+zlIlqdHvCFAwOwjvr/Y5m8DEUPtx94ygWlcUgmy1KxDcBMQ25qbrV4ClCMVzlntpCzyLhuasce4SVaDrEtEMK0F2sJQvzStMBy4uovJ2kS6KsAMXZQpR5l3Ks6yNjyc/Ovae+PMJ+jfn3wLIRN8f7074KnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778277674; c=relaxed/simple;
	bh=2GDXsCe/23OzYNnOG/LJMjbMrCgFrVL7YU4ucbV61+g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IWhtlJFWcuYa8WwcM8KOnqnHXuTeeGVoWvbzcLYkV2F6F+rqe1vVJJUh8mlJnFoagPPdY4EhTvoGLss0BuAbNglqVN7w/TD3uhhiyqHWsGnRN7EBJex9DqxGjnQ//QoZtQojNbj0l8rxyZvIHyfdTpk6ZF4mfRfX8e8AsjMxDQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YWZrFkHv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YWZrFkHv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FDC4C2BCB0;
	Fri,  8 May 2026 22:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778277674;
	bh=2GDXsCe/23OzYNnOG/LJMjbMrCgFrVL7YU4ucbV61+g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YWZrFkHvtRL9W69IEoof5jC6e1ijOZqqSv+M/ySSa79e4mQ5Kc8vSJYaichbV2ecA
	 j5KExJcNYsAxg/GKMDvnkXHnVhKw4ZHIKucSaOZ86zJtakV/yFtguSzvDX5u/mfTaJ
	 FC3uBVzy7+cswxC0Avk9exF7va2y384F5z8S0XjcIZu9r9YibFT8lJ6nPPpL+O7nuR
	 j7L/miSTbF+KADqUZs9kZb9LFL1EGT/Guye8lqInf1tVpV+dEKkF6wv/jOtRefipYa
	 v4uvoCHxYY1Nw7Jsktp6qLRIGPq+zHbydlcuA3twSjXxawgnQoqfn7SpgKYCrCZA98
	 DEiO+31IUcoWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9E2A38119CC;
	Fri,  8 May 2026 22:00:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3 1/2] net: page_pool: support dumping pps of a
 specific ifindex via Netlink
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177827762229.865600.2759908552685312593.git-patchwork-notify@kernel.org>
Date: Fri, 08 May 2026 22:00:22 +0000
References: <20260506034821.1710113-1-kuba@kernel.org>
In-Reply-To: <20260506034821.1710113-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
 donald.hunter@gmail.com, matttbe@kernel.org, chuck.lever@oracle.com,
 daniel@iogearbox.net, skhawaja@google.com, sdf@fomichev.me, hawk@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  5 May 2026 20:48:20 -0700 you wrote:
> NIPA tries to make sure that HW tests don't modify system state.
> It saves the state of page pools, too. Now that I write this commit
> message I realize that this is impractical since page pool IDs and
> state will get legitimately changed by the tests. But I already
> spent a couple of hours implementing the filtering, so..
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> 
> [...]

Here is the summary with links:
  - [net-next,v3,1/2] net: page_pool: support dumping pps of a specific ifindex via Netlink
    https://git.kernel.org/netdev/net-next/c/c93799de1bd2
  - [net-next,v3,2/2] selftests: net: add tests for filtered dumps of page pool
    https://git.kernel.org/netdev/net-next/c/ce3d4a67a076

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


