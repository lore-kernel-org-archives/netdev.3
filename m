Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95A9139B48A
	for <netdev@vger.kernel.org>; Tue,  5 May 2026 02:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777947679; cv=none; b=NPd/sxx86v9SDEkj6BQ+Cx/yt8ZyHtGPfsMK2sWeiALkNJmnDL5KakGDACQB/5S0mr7kuAmjo3HF9fV5p6vYe0uMZ9x9dpIzK1DpKjbj8SWb6SMqDEgDN/NYis74iVYgaxCVZL4Cu7dFZVFBnDlpDG7Wqz2rpXH12QYslQ8+3BY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777947679; c=relaxed/simple;
	bh=lG1TqnXXVZGpTnXq0OKnmLyaLOrCj5AlUinQexugCrc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pRegrnu2XDKPRKT1VUY1+HM5Lrh0Cc6b9g9QLTYN5BJwWuXvI1q47dmvyR4qzyMuHzXah1YHgaPh0f0U1BJra+soS73mKt6rd5m9ckEbEzQ5azhOMo6/o2mShaaAnz5GJVf7VfPYMG8sc/k5iHPGywjs9ibKsAIkMZogV+W4gfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xr3oL4+o; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xr3oL4+o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 394D0C2BCB8;
	Tue,  5 May 2026 02:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777947679;
	bh=lG1TqnXXVZGpTnXq0OKnmLyaLOrCj5AlUinQexugCrc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xr3oL4+obKlnJmDIEWdq3+bn/4dZUXQ60EZ+u4Z+DBFxys9hDd7QNbWafJIhDpAbP
	 KhQbIdPmrrklyKl1Q+yHXNS9aREm2LF2i5Kp+uCPQe8opJMUY+LLHxVK5o0hi8GDEW
	 AOS02EgjWh9KOMoJCrzUrGMPAxfIruVgCI+pcll81elnjD5/dFl0NlFz2I6/tYjDpX
	 9zbB0uWTKKmZhYoH8PyCjXQSeJRK2ZmgZTvh3in9o4C0lh6f5xEMIVKAhfUrEJ1fB/
	 qkbo/JSikEKNagswBsGn7pMg1WC70AuWIBhSntfr4FZnI8/kz+wtwu3tSqRPq82tGC
	 YGgeu9cNuRkiA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FC4439301A2;
	Tue,  5 May 2026 02:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net/sched: add qstats_cpu_drop_inc() helper
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177794762979.1391894.15675959486729697037.git-patchwork-notify@kernel.org>
Date: Tue, 05 May 2026 02:20:29 +0000
References: <20260501135916.2566766-1-edumazet@google.com>
In-Reply-To: <20260501135916.2566766-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  1 May 2026 13:59:16 +0000 you wrote:
> 1) Using this_cpu_inc() is better than going through this_cpu_ptr():
> 
> - Single instruction on x86.
> - Store tearing prevention.
> 
> 2) Change tcf_action_update_stats() to use this_cpu_add().
> 
> [...]

Here is the summary with links:
  - [net-next] net/sched: add qstats_cpu_drop_inc() helper
    https://git.kernel.org/netdev/net-next/c/3f3aa77ff1c8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


