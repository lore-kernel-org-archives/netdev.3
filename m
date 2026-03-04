Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232CC35DA50;
	Wed,  4 Mar 2026 22:30:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772663406; cv=none; b=eTXvfRgeoE5Wu9WZqcBXKU/evwbGuDSWs2ax9gWlTivx+3BVVlhmqNz2e9HhC2Ejn5EpKL6gGybW4LDiptfTss6Dvr9gbi6YAmPz3zQBHm0Ddz3oL42VLJ7Co9zuf3ps9FdV6U6UpkmqM4bWUuKOIPwP2YS6FeA92mHh56YzIio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772663406; c=relaxed/simple;
	bh=pD0kSiZySkKY37bE0Yo8qKrQT159uPb5YHFw9/k8NbU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Re+Zur6coNudi0W6eNPXbg0dBwSdWCmMcpw1CV9qrHimhva72fkWYED+Wc/KoroN+Is/2UyY0u//sfKqC9bSZHkacX00i1NXsvUkQiVdM8n6ueKY0PeNQtgzj6Nj//Gwnua6qRVNQSHomtJHmRudbLByBjdFzIacntf6Cma2nzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RwFCGa+5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RwFCGa+5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB607C19425;
	Wed,  4 Mar 2026 22:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772663406;
	bh=pD0kSiZySkKY37bE0Yo8qKrQT159uPb5YHFw9/k8NbU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=RwFCGa+5jIs6khKID/RuHxBSJr0kFGQiU8FjQF5MlQPg/Wd60VcVfhT41y5uLiJW0
	 FBJSW6ybzIm/+/55t+zmoNj1p6MxsfcOaQhuwX5kh1+3P2XJRdZ2gmisSdrwUlUw4B
	 ZO4wWTaWgSH9yy7F15ANNxf/QxsfZ9kcEgvcVOIq24p2Q7uGWQroTO4Yv6Ti53qGAa
	 YWLUL70IXJUbnxcvNjH2swPIAwMOf51fnZKluND7IPMnwFUy3sYS/8TMvB8nlhfeRY
	 m+bjbIUH80YxM+01loIh/x76b2yownAYlj+pJ06IgLJY1gBEUmcIXsl1LXRTiGryLB
	 QbJUbalpkwOSA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CECE3808200;
	Wed,  4 Mar 2026 22:30:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] mailmap: Add entry for Joe Damato
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177266340630.2419970.10346524013152706786.git-patchwork-notify@kernel.org>
Date: Wed, 04 Mar 2026 22:30:06 +0000
References: <20260303024202.2526604-1-joe@dama.to>
In-Reply-To: <20260303024202.2526604-1-joe@dama.to>
To: Joe Damato <joe@dama.to>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kuba@kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  2 Mar 2026 18:42:01 -0800 you wrote:
> My Fastly email address is no longer used. Add a mailmap entry to
> reflect that.
> 
> Signed-off-by: Joe Damato <joe@dama.to>
> ---
>  .mailmap | 1 +
>  1 file changed, 1 insertion(+)

Here is the summary with links:
  - mailmap: Add entry for Joe Damato
    https://git.kernel.org/netdev/net/c/126fe7ef12ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


