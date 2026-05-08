Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF1B233721;
	Fri,  8 May 2026 23:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778281257; cv=none; b=bEecvgTN5YL54mSTkyGkARF37jj9vaIAdhtLnYlT9lMw+J5yF8bBMxq6ykb6e+bgUUDG135AE5yN7DAZUBALxjegkNalt8kRBJJwKZjeJqsq2qHXifq4xzFYVbXq+gfzRSYhMQ6eCBBXqUT0BckHl0vE+Z5thUAaynrGSi9Pjz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778281257; c=relaxed/simple;
	bh=kJMo2ETW+x+xVVES1o38BBC0AgbIcPOjAhsLm1P92AM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=heLCGslWF65UCW2Qi6+qLTOmBUSVTQhW1IRAIjhvRXx1z4U8AEsey6EeCAxxvmeKvbyVzlSoVhDpNfdN5WBbIl3EykoIvWCk/a3m5g0hkjrFS8X/4v/WBUSL6YNa5EFSnfg7fZZ8wI8zAHEhhfgvnfzflJuJHSDbbBZxjC7ge6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rOl4aPzg; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOl4aPzg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C065C2BCB0;
	Fri,  8 May 2026 23:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778281257;
	bh=kJMo2ETW+x+xVVES1o38BBC0AgbIcPOjAhsLm1P92AM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=rOl4aPzgy3vgha3CyU/7WAKopPN89FuV64C4ylF6CX5RclQLKwXdGP5WbiMgrgMvy
	 +tqo8RxVgECSDXE8axpzzdYPQwVL951ZrsewMjNQBrwfGcFJ9b1kwWpmL5sjc1xdF5
	 ELkry0fPvOv5SIi/zwAKF55xsEFF3V0lYx69wpEXMRBjnN5/aDYJZ8wmUZOfdf2Jb5
	 MnRt4+hGoCmP1IL/KE6msZusnMj0eLhC3kvu0j3mqlLwNaZMS0vepkPCdURaVj/r/t
	 qD+OoQT+fJW+DJjLsiepsScL2jDVXu18H3E/KnJH6jzqCs4Piv7k65Eeqb97v9oMH+
	 UzAWxIGO9BP9Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9F3938119DB;
	Fri,  8 May 2026 23:00:06 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net V2] net: shaper: Reject reparenting of existing nodes
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177828120555.883980.3474169363086619803.git-patchwork-notify@kernel.org>
Date: Fri, 08 May 2026 23:00:05 +0000
References: <20260506233745.111895-1-mohsin.bashr@gmail.com>
In-Reply-To: <20260506233745.111895-1-mohsin.bashr@gmail.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: netdev@vger.kernel.org, alexanderduyck@gmail.com, davem@davemloft.net,
 edumazet@google.com, horms@kernel.org, kees@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, p@1g4.org, pabeni@redhat.com, jiri@resnulli.us

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 May 2026 16:37:45 -0700 you wrote:
> From: Mohsin Bashir <hmohsin@meta.com>
> 
> When an existing node-scope shaper is moved to a different parent
> via the group operation, the framework fails to update the leaves
> count on both the old and new parent shapers. Only newly created
> nodes (handle.id == NET_SHAPER_ID_UNSPEC) trigger the parent
> leaves increment at line 1039.
> 
> [...]

Here is the summary with links:
  - [net,V2] net: shaper: Reject reparenting of existing nodes
    https://git.kernel.org/netdev/net/c/a77d5a069d95

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


