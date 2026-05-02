Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36DBB1DC9B5
	for <netdev@vger.kernel.org>; Sat,  2 May 2026 01:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777683654; cv=none; b=fLSdQ4KknSyDIY/X18icM7oTrIv/q8ALV1UIG1kagINL78sUWZ8SqAISDXNzNbWeOo8nTEFtbYCkBwmDC5M05HEa9v1U2YU+x7aWy9GdUu4gxWd80dhWgZJhqro/dLHLnbeuTtdeU8innjm/ZxkTdoN1K9LLtvZJslpHpnlfqGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777683654; c=relaxed/simple;
	bh=RkX3XdKaKAuy/RvJ0ds+Vc1EoKiB7PEpWNLRo+jFCws=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CNpZix43rfk1VOxHMlkFDGHrgSc7zQF9pfyakjkiuFwo9jv9kl+mk6er5QSKRo2Cqoi9Qlfb6UeiclP3GG5aKmxVpey9IrY/tJiMwgsRBb0OjZZ3+EU+sytjNRomDB9VsmcoR+6+d6eFFtlbGGGiuofgJ4Sf1FkSr29waN2geiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xi0yKheS; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xi0yKheS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6A26C2BCB4;
	Sat,  2 May 2026 01:00:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777683653;
	bh=RkX3XdKaKAuy/RvJ0ds+Vc1EoKiB7PEpWNLRo+jFCws=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Xi0yKheS4dxm2Wu8A/8MWpe2FZFdyanp9PTe9EufrdFmM3dd6e4higDrQY0dSIxTU
	 kbBJq3Up+M1PjjY71Xsud8dyaPSJ8LvO6lCv5sbXo+Q0jKCLt33u6nMClw56nqwgmV
	 HDY9BnuM8c1+G81GzrV3EeeRP67Cjudt4rVhbzG8FzCyOEdHtV8/7Ay8Cbi/y+Fjf1
	 UCXXv6obftcVwnTbyWIrsbTSYkqXGqP+OCODZcgqcOYKUz7gIIaSzn7BqaLIs4Rud9
	 SpFHavnxIVpJU/QztcIhxVobLLJtwXQsmOLUw1/I4iQ4UxGVBh7fAkm79cF0vWCma0
	 W3kHJVBmw4Tww==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02E1A380CEF5;
	Sat,  2 May 2026 01:00:08 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net/sched: sch_pie: annotate more data-races in
 pie_dump_stats()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177768360663.3679774.13291535870036375262.git-patchwork-notify@kernel.org>
Date: Sat, 02 May 2026 01:00:06 +0000
References: <20260430080056.35104-1-edumazet@google.com>
In-Reply-To: <20260430080056.35104-1-edumazet@google.com>
To: Eric Dumazet <edumazet@google.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 jhs@mojatatu.com, jiri@resnulli.us, netdev@vger.kernel.org,
 eric.dumazet@gmail.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Apr 2026 08:00:56 +0000 you wrote:
> My prior patch missed few READ_ONCE()/WRITE_ONCE() annotations.
> 
> Fixes: 5154561d9b11 ("net/sched: sch_pie: annotate data-races in pie_dump_stats()")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
>  net/sched/sch_pie.c | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)

Here is the summary with links:
  - [net] net/sched: sch_pie: annotate more data-races in pie_dump_stats()
    https://git.kernel.org/netdev/net/c/6d4106e8df94

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html


