Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5403BD22B
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 10:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783333231; cv=none; b=qCcFZDAzDtDt8FzfKB81ztKy4amImPQS28MZ44RxdEQUY25TWW1ELekTxM8M4uwW6LLwgwICUWFihCATw/XKRdqhy3fO+By0LBRN+xz20yMVwtUF5kCon8CutveByHu4I5m2iS5+V1/Oev6dsgbUD6asxAcZ0l9ZLrFLg4sF3fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783333231; c=relaxed/simple;
	bh=cOq/g4rxdhFh3c0xPJ9gwk/jxLOVthe9XluHj4I3iDc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=bYhfxtjsoicAqa0xmTYDSYQi1p50YGnLCd7HVTUg+59YROd7ONFDzA5URgwM/0S2Jhor48SlWXwmPoo3ahpvHahjkXDiPIAlSqoTJJy3mtIsvQ1XeBKLKpZtIqZ3j5eKPgaKjAO6jBT82vEnKBGzzOM4kbl8/Zqg3IGQnZ6Z1v8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i+iK02Rd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i+iK02Rd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2A11F000E9;
	Mon,  6 Jul 2026 10:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783333230;
	bh=W5GqfmmJtLMmXXIzCMKqzn/P91aHErAAwUnp5sezLro=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=i+iK02RdATzhDskPojBdJcFLqQrgB++tR/KnpKKF5SybjQJ9HpGNPj92XNvRmJDQW
	 5ZDsLxjQpXfDFfPh903z7YLW/iWbYSIeho4z1W8k363eQJKBqmw7P1AAYe5pzrHBxz
	 AUBdsAeQQh2ZtNvm2E9THwOD1KCv4XBp4XHkXSviVvTgwtJZ9pU3oNvqktG/hk5n8T
	 kRWao1ab9AjL9VD28KgpsWyCzuFZl5k+Zxww9HIzMg1OFs1eKW2Ea4ksprzYaKmP3f
	 BsEkHfBOWZvQqhuxhTYr5woM44uP4I4/ojbWyvJAnJQ6HQVlEf/MumJ4XAy67S/hBG
	 4qHrgZcE+Z26Q==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0BC63AB1394;
	Mon,  6 Jul 2026 10:20:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] selftests/tc-testing: Add tests that force multiq and
 taprio to enqueue to child's gso_skb
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178333321038.484760.9697781506643276164.git-patchwork-notify@kernel.org>
Date: Mon, 06 Jul 2026 10:20:10 +0000
References: <20260630153651.249752-1-victor@mojatatu.com>
In-Reply-To: <20260630153651.249752-1-victor@mojatatu.com>
To: Victor Nogueira <victor@mojatatu.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jhs@mojatatu.com, jiri@resnulli.us,
 netdev@vger.kernel.org, hexlabsecurity@proton.me, pctammela@mojatatu.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Tue, 30 Jun 2026 12:36:51 -0300 you wrote:
> Add test cases to reproduce scenarios fixed recently [1] where
> multiqueue and taprio forced their children into enqueueing an skb to
> gso_skb (during peek), but failed to dequeue from gso_skb because they
> called the child's dequeue callback directly. This causes a desync in the
> child's qlen/backlog and results in an eventual null-ptr-deref (with a
> qfq or dualpi2 child).
> 
> [...]

Here is the summary with links:
  - [net] selftests/tc-testing: Add tests that force multiq and taprio to enqueue to child's gso_skb
    https://git.kernel.org/netdev/net-next/c/1704cc864070

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


