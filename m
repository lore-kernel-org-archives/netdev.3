Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D4920D4FC;
	Wed,  7 Oct 2026 00:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791332409; cv=none; b=Smf/u681kIrOHssWYeoybSd5To2oZQ827YS9p3GP88PTmHmmJn5XWDmCxUFv5QivRoQN5tB3KquC5VZHOQjN9KE3zhLI48xSudTz6k5jqSana0FwebsHL5MR3FJTTBAbgDb3VazY6JWCJnqSHoyJ4rqRd19fGgnVjBm2MjkLgRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791332409; c=relaxed/simple;
	bh=gxOm/CpuqDw5re1ra2454MsOTp1Wq8z5s3OBnLaq4F4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=U1rOa4CkZiT3ozCuNfrOOdgpgdZaJw+QFg20JjOpQrw/F+2SkVmAzyRvl8F0ukpOTd8Ila6YMf7ATjRXRHzMn//Xx02iqVjwaGGHhsmMlwDolTUzs324gCsfHXj81cf3cojflspVcpy0vX6E9KE6tzd42kztoTfzo9/bcr8YAtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kJGergeG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kJGergeG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45BE31F0089B;
	Wed,  7 Oct 2026 00:20:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791332408;
	bh=hf1jtPhzVWbJKWMQVShLqCkt5PanYQPqkLMdn2L/T3A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=kJGergeGo9ydY7rY0st1bhCzfh2eQU/qXVi5XymEeN+s5QhanTJAmhM6/zQ9nehpF
	 ln5utJjoNTdd9kSiaD5d6+GqY8Nx2ZBzgIe/1DG1T2MJKMY7aW3QTjHSv10BjOD5Ww
	 M5ZAf+5FOCEIX57uSzzc4lFgKzyoB8EP7go8Ohf8LVgU9Fj1ufKKrzFLscIB1S7bR7
	 fotN1iX3gPCRAo8pHO2ZeIoJDHTT3AmpTrdq9GgBNYaQmQijZCRZn4VkQ8t4VcCiol
	 oYFFTJTNldZMvUSge+dAEYEoetAoe6266xrBmG+aYHFNBxpmkk1ZsmvLTIa07zt77u
	 4c6T6/VLhrDGQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3A2D83806541;
	Wed,  7 Oct 2026 00:20:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] devlink: fix devlink_rel reference leak when notify
 work
 is pending
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <179133240677.2839723.7890715824308505927.git-patchwork-notify@kernel.org>
Date: Wed, 07 Oct 2026 00:20:06 +0000
References: <20261001042232.222987-1-yanhaishuang@cmss.chinamobile.com>
In-Reply-To: <20261001042232.222987-1-yanhaishuang@cmss.chinamobile.com>
To: Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, davem@davemloft.net,
 edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  1 Oct 2026 12:22:32 +0800 you wrote:
> devlink_rel_nested_in_notify_work_schedule() takes a reference on the
> devlink_rel for the notify work and then queues the work, ignoring the
> return value of schedule_delayed_work(). If the work is already pending,
> nothing new is queued, the work runs only once and drops only one
> reference, so the extra one is leaked together with the devlink_rel and
> its index in devlink_rels.
> 
> [...]

Here is the summary with links:
  - [net] devlink: fix devlink_rel reference leak when notify work is pending
    https://git.kernel.org/netdev/net/c/c5381ae1cd14

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


