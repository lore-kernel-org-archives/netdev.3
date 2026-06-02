Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06BF286D7D
	for <netdev@vger.kernel.org>; Tue,  2 Jun 2026 19:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780426806; cv=none; b=iDQwZ0tzzJAVZ033yAwWEv/wUIaJW2ZcmXrEaYQyVFUIVis+u3CPQ1cZF+mmY+DhveGXhvhBU+po/PhuTSQhrcTmR4xZfb1zRg0zI6mY++BLbArjeBky9PQtJsPVCXMME/2PC/lQQNOckzrxYKKJwPyIXayoCUSBDtJ/yB01X40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780426806; c=relaxed/simple;
	bh=J9JY452fHoT1AdJNB4ASUj3ND+jA3CR1mEUmoJ/+WYQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=so0D4ohLh3t6NU3pdV+pofsITo0B5thl+6Y8jKRP+o80mLj7xBZ5BRBkCkpO2x8jKFLqZ4dx2LTTZYS4MZcbb21rOcveeXcn2j2DD/9uSLy/xljxyteBpigCixFhiBFNjal7qmYEmZ0AzVWZVtOZ/zVC+5Y1aeUm1wfkt63sQ3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PU4BNPQF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PU4BNPQF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6CDA1F00893;
	Tue,  2 Jun 2026 19:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780426805;
	bh=M+Nm8VEBNt2IKyMAuknLaYO7pFn128UMvoXewkzmVtQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=PU4BNPQF1qRx7E93j9NK9eMJniWw98yImkLZLYQtxTVnfFL6H/Enic6Y5m3SSizQg
	 o9BtHRF2ysNFlvSW8m0rAp5MjeilLXuvxg4uhPD/esL5BNZDGKgxB9UXgw7yOZM6/8
	 KIJ1spGGArkdJ/0XSQZGOrYiDPWvtMXExzWA9nExc8tMOrGQmnFhjh/6EWqIvk/rEy
	 6gOj7hQj/QsPBbjgIGF3d8/L4jWkycc1g72/3CGQlc6BVW4MySEJQr+k/eCA+/J9Q7
	 dGUAQ1uIRW/uKdn/XE19KF1x1fGQ/URJczgJB3mYuLWhpZL25Llt6rCW4pQ9oYPgUD
	 sGNxT2YHxnLaA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D09E43811A6C;
	Tue,  2 Jun 2026 19:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 net] tcp: Add preempt_{disable,enable}_nested() in
 reqsk_queue_hash_req().
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178042680740.1007375.14491547621037565757.git-patchwork-notify@kernel.org>
Date: Tue, 02 Jun 2026 19:00:07 +0000
References: <20260601182101.3183993-1-kuniyu@google.com>
In-Reply-To: <20260601182101.3183993-1-kuniyu@google.com>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: edumazet@google.com, ncardwell@google.com, davem@davemloft.net,
 kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, bigeasy@linutronix.de,
 clrkwllms@kernel.org, rostedt@goodmis.org, tglx@kernel.org,
 kuni1840@gmail.com, netdev@vger.kernel.org,
 syzbot+e809069bc15f26300526@syzkaller.appspotmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  1 Jun 2026 18:20:55 +0000 you wrote:
> syzbot reported a weird reqsk->rsk_refcnt underflow in
> __inet_csk_reqsk_queue_drop().
> 
> The captured reqsk_put() in __inet_csk_reqsk_queue_drop()
> is called only when it successfully removes reqsk from ehash.
> 
> Moreover, reqsk_timer_handler() calls another reqsk_put()
> after that.
> 
> [...]

Here is the summary with links:
  - [v2,net] tcp: Add preempt_{disable,enable}_nested() in reqsk_queue_hash_req().
    https://git.kernel.org/netdev/net/c/e10902df2448

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


