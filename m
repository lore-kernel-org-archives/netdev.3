Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8AC413C908
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 01:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786152648; cv=none; b=nBOmPcHQouv78WH1C0DHphL51QSPrc8PwyyY9GcT+KvMPhuEbU1olmBqYBsEJLwMvGU6opOX+jErejbN10w5tVS6OxczsRkbTllB74znB3v47Mk3fFhbtiaeyoOa6JNu0UOUXNbEQ4I+EPfjmkbpj/ik8fbsT1CIZAeUS8ar2/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786152648; c=relaxed/simple;
	bh=o+3AnYB/zk5vp/ROcsvIAtPedZmxKk6HVJQYhxKr4XY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Al3+bkU2XIYnNsSTGUyWfnDxggKouZ/+zLOkwLoiXqHNXXYkLieYtDMg0yv7fRhjI01Ce8JYuQZsAZhssckajpFb1ZHLONY9VI4JulGeKafNJs+rarhfC3KX0qtbRVva1meU4OxbZulPQwv2lyjgtmHoOjX726SNUMR9BIdyV4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=axur7YW7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="axur7YW7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FB081F000E9;
	Sat,  8 Aug 2026 01:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786152647;
	bh=TR8dw5HFcddmnDjr5sa185Gh9YKDaCfWnhPis1ZJd+A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=axur7YW77n7CAp2BN4pUwvxjs+yPNLADk9me/t3s6ep1cG6k/XTfeYiqrHMvTNK7c
	 cITsWZH82rKMGNq4BFJM71ETMM+jEpMXINNGhC6QCJDQhfFpmPIPu6kEIIQ7tW0h1/
	 mi4vufofu8vgJx02w6yA7J00bVS5OBwHS4cEXsnCx9cPKcLSVgUC39Rl2GzGsD+UzR
	 Oi1HnkqwaxpapcW2zRICURURcxZlmg/UuK6Jjnrkvipuvw5IDoc6UVl3fBpxDamuiQ
	 q3RV+7XNFkzhOQT+OC5fDV5mtFTT4ADL810Z/X7eoYpZU5DrddRet2Bp7e3l3kL/z7
	 ql3y/WdMR5y7A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id E6D82380CEE4;
	Sat,  8 Aug 2026 01:30:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] mailmap: add entries for Christoph Paasch
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178615260569.2491826.4883363979878452701.git-patchwork-notify@kernel.org>
Date: Sat, 08 Aug 2026 01:30:05 +0000
References: <20260806-b4-mailman-v1-1-b4d7bc0ffd1c@openai.com>
In-Reply-To: <20260806-b4-mailman-v1-1-b4d7bc0ffd1c@openai.com>
To: Christoph Paasch <cpaasch@openai.com>
Cc: netdev@vger.kernel.org, matttbe@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 06 Aug 2026 12:49:22 -0700 you wrote:
> From: Christoph Paasch <cpaasch@openai.com>
> 
> Map the email addresses used for previous kernel contributions to the
> current OpenAI address. This prevents get_maintainer.pl from listing
> historical addresses as patch recipients.
> 
> Suggested-by: Matthieu Baerts <matttbe@kernel.org>
> Assisted-by: Codex:gpt-5.6-sol
> Signed-off-by: Christoph Paasch <cpaasch@openai.com>
> 
> [...]

Here is the summary with links:
  - [net-next] mailmap: add entries for Christoph Paasch
    https://git.kernel.org/netdev/net/c/dd057113ac7b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


