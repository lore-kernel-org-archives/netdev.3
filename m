Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26E129B8CF
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 22:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778277667; cv=none; b=mEeF4Z5sQ9Si/kOivIU0XrrRSgjlaAYxigwItp1hj8XsPggbfeJaHFtlR9TaDZseHkTmZnECXM2m9Czzxnq38U70AhfoLxaP0YIrKukyhOYAlR18ed9Tr5oTVOAF1mUvAx4Blr9r/Yu1mZYBL6Tee2WbXeZ1I3lZ/5Bc1s7BhIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778277667; c=relaxed/simple;
	bh=tq4A+KtcmkiGy3nu79OqZUF9FgzI52yQoK9ZBne2J3g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q7N9gIlX0fyOtzRytmh5K9qROzaFyC078clICtNNUhNBZklEgOPpIp96JypVFpdZzo+VGEq5rHiaS9zJyxcT3TwNNBENXfkn1swzwL9f1mW1BC1QkdL3Z/vcALkGxa1R5GVIPPwyD6GggHYB47EhtnPtNeesPMT2jTjkD8gx2rI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TKZ+SNCa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TKZ+SNCa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AC61C2BCC9;
	Fri,  8 May 2026 22:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778277667;
	bh=tq4A+KtcmkiGy3nu79OqZUF9FgzI52yQoK9ZBne2J3g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TKZ+SNCaQH1mTWh7rFZV3ZTXH2csxmJVJNinwg/C5MzponySrVjUZjdAs/ni1fI5N
	 PD1/kLaoYITZwm/vrYBXAvWjXP9mmTZoH70Mnnwv6RNkVVcnyarCCRa73lz7dAslpU
	 zLFm1Q3VBRgYmjc7pTifkH2SnIYvYZbQgTxxLleSRFRjjJMKcxBn0d2yastKhoWdFE
	 z7ATiliTH8nfvFzSrRze/LFnjTkfPOitJ7J5QbHfvxbfP0ykOGQ9hhwW/xsxutbT9x
	 rTuUG3BCxmk5idReajgyi5WQG/E5qth5CcyMeZN8Mu0bL1iU/fjnK8bu65V1ZIhLiv
	 272jJ4PMGMHUQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E8238119CC;
	Fri,  8 May 2026 22:00:17 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 net 0/2] tcp: Two fixes for socket migration in
 reqsk_timer_handler().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177827761580.865600.8944840782684836883.git-patchwork-notify@kernel.org>
Date: Fri, 08 May 2026 22:00:15 +0000
References: <20260506035954.1563147-1-kuniyu@google.com>
In-Reply-To: <20260506035954.1563147-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: edumazet@google.com, ncardwell@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, kuni1840@gmail.com,
 netdev@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 May 2026 03:59:17 +0000 you wrote:
> The series fixes two bugs in the error path of socket migration
> in reqsk_timer_handler().
> 
> Patch 1 fixes a potential UAF in reqsk_timer_handler().
> 
> Patch 2 fixes imbalanced icsk_accept_queue count.
> 
> [...]

Here is the summary with links:
  - [v1,net,1/2] tcp: Fix potential UAF in reqsk_timer_handler().
    https://git.kernel.org/netdev/net/c/97c8a3c1f73d
  - [v1,net,2/2] tcp: Fix imbalanced icsk_accept_queue count.
    https://git.kernel.org/netdev/net/c/7eca3292cac7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


